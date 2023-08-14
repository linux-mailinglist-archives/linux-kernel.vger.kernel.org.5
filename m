Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015C77C06D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjHNTLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjHNTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002839C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9058961B30
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 19:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72ECC433C8;
        Mon, 14 Aug 2023 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692040260;
        bh=Bd69ANmRs4znb021NkyY0AZ00SvBVE8CnOWDRJnJKn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnDOfCYLRtbpBChvhQ5Wm2YU9ckuGsIzchFY0PFyLQ/uvqtwCeSUziSLwz3ioHAZH
         b/KKP34HeT1eS09cURAW5pEszHVA1IbMW8JycQlK5DYiV46lEicGRMXctUKUaJflY6
         aFfAjFp9xDQAS5S4iSKwAjgJDipgSd6mDOWC7jGo=
Date:   Mon, 14 Aug 2023 12:10:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in
 do_vmi_align_munmap()
Message-Id: <20230814121059.8b6046595d69284a62b876e9@linux-foundation.org>
In-Reply-To: <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
        <20230724183157.3939892-16-Liam.Howlett@oracle.com>
        <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 17:43:39 +0200 Jann Horn <jannh@google.com> wrote:

> @akpm
> 
> On Mon, Jul 24, 2023 at 8:31 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> > Since prev will be set later in the function, it is better to reverse
> > the splitting direction of the start VMA (modify the new_below argument
> > to __split_vma).
> 
> It might be a good idea to reorder "mm: always lock new vma before
> inserting into vma tree" before this patch.
> 
> If you apply this patch without "mm: always lock new vma before
> inserting into vma tree", I think move_vma(), when called with a start
> address in the middle of a VMA, will behave like this:
> 
>  - vma_start_write() [lock the VMA to be moved]
>  - move_page_tables() [moves page table entries]
>  - do_vmi_munmap()
>    - do_vmi_align_munmap()
>      - __split_vma()
>        - creates a new VMA **covering the moved range** that is **not locked**
>        - stores the new VMA in the VMA tree **without locking it** [1]
>      - new VMA is locked and removed again [2]
> [...]
> 
> So after the page tables in the region have already been moved, I
> believe there will be a brief window (between [1] and [2]) where page
> faults in the region can happen again, which could probably cause new
> page tables and PTEs to be created in the region again in that window.
> (This can't happen in Linus' current tree because the new VMA created
> by __split_vma() only covers the range that is not being moved.)
> 
> Though I guess that's not going to lead to anything bad, since
> do_vmi_munmap() anyway cleans up PTEs and page tables in the region?
> So maybe it's not that important.

Thanks.  I'd of course prefer not to rebuild mm-stable.  If this ends
up being a hard-to-hit issue during git-bisect searches, I think we can
live with that.

