Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C310475FCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGXRLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGXRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850551B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22C0C612D1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A78C433C7;
        Mon, 24 Jul 2023 17:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690218697;
        bh=/iEHzZZI/uM1YwURbFTNXhK6+11qyGduzfaCBn2j9xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1IWTAX7YAuRQKQpYUUvovEu6BdmlHkXDehUYuxFG7eK5ZU4w13BfmUlcM5iJV+/0q
         6lnQ6u3+QeDdEQh2IOsUDDUl0hd4Zrmo1F595c19pK+ooVkhNJWOQwybSewEOPYf1s
         v7/SLJ35QcU2hKDUUGgyxeA08yV1YO/Qzu6M4vgk=
Date:   Mon, 24 Jul 2023 10:11:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm: Fix memory ordering for mm_lock_seq and
 vm_lock_seq
Message-Id: <20230724101136.4c58e8291961e87f6c5c1c79@linux-foundation.org>
In-Reply-To: <20230721225107.942336-1-jannh@google.com>
References: <20230721225107.942336-1-jannh@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2023 00:51:07 +0200 Jann Horn <jannh@google.com> wrote:

> mm->mm_lock_seq effectively functions as a read/write lock; therefore it
> must be used with acquire/release semantics.
> 
> A specific example is the interaction between userfaultfd_register() and
> lock_vma_under_rcu().
> userfaultfd_register() does the following from the point where it changes
> a VMA's flags to the point where concurrent readers are permitted again
> (in a simple scenario where only a single private VMA is accessed and no
> merging/splitting is involved):
> 
> userfaultfd_register
>   userfaultfd_set_vm_flags
>     vm_flags_reset
>       vma_start_write
>         down_write(&vma->vm_lock->lock)
>         vma->vm_lock_seq = mm_lock_seq [marks VMA as busy]
>         up_write(&vma->vm_lock->lock)
>       vm_flags_init
>         [sets VM_UFFD_* in __vm_flags]
>   vma->vm_userfaultfd_ctx.ctx = ctx
>   mmap_write_unlock
>     vma_end_write_all
>       WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1) [unlocks VMA]
> 
> There are no memory barriers in between the __vm_flags update and the
> mm->mm_lock_seq update that unlocks the VMA, so the unlock can be reordered
> to above the `vm_flags_init()` call, which means from the perspective of a
> concurrent reader, a VMA can be marked as a userfaultfd VMA while it is not
> VMA-locked. That's bad, we definitely need a store-release for the unlock
> operation.
> 
> The non-atomic write to vma->vm_lock_seq in vma_start_write() is mostly
> fine because all accesses to vma->vm_lock_seq that matter are always
> protected by the VMA lock. There is a racy read in vma_start_read() though
> that can tolerate false-positives, so we should be using WRITE_ONCE() to
> keep things tidy and data-race-free (including for KCSAN).
> 
> On the other side, lock_vma_under_rcu() works as follows in the relevant
> region for locking and userfaultfd check:
> 
> lock_vma_under_rcu
>   vma_start_read
>     vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [early bailout]
>     down_read_trylock(&vma->vm_lock->lock)
>     vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [main check]
>   userfaultfd_armed
>     checks vma->vm_flags & __VM_UFFD_FLAGS
> 
> Here, the interesting aspect is how far down the mm->mm_lock_seq read
> can be reordered - if this read is reordered down below the vma->vm_flags
> access, this could cause lock_vma_under_rcu() to partly operate on
> information that was read while the VMA was supposed to be locked.
> To prevent this kind of downwards bleeding of the mm->mm_lock_seq read, we
> need to read it with a load-acquire.
> 
> Some of the comment wording is based on suggestions by Suren.
> 
> BACKPORT WARNING: One of the functions changed by this patch (which I've
> written against Linus' tree) is vma_try_start_write(), but this function
> no longer exists in mm/mm-everything. I don't know whether the merged
> version of this patch will be ordered before or after the patch that
> removes vma_try_start_write(). If you're backporting this patch to a
> tree with vma_try_start_write(), make sure this patch changes that
> function.

I staged this patch as a hotfix, ahead of mm-unstable material.

The conflict is with Hugh's "mm: delete mmap_write_trylock() and
vma_try_start_write()"
(https://lkml.kernel.org/r/4e6db3d-e8e-73fb-1f2a-8de2dab2a87c@google.com)

I fixed the reject in the obvious way (deleted the function anyway),
but there's a possibility that the ordering issue you have addressed
will now be reintroduced by Hugh's series, so please let's review that.

