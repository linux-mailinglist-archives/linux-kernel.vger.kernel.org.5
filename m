Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023DD7867E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjHXGyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjHXGxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2805410FD;
        Wed, 23 Aug 2023 23:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B959A64F10;
        Thu, 24 Aug 2023 06:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B34C433C7;
        Thu, 24 Aug 2023 06:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692860023;
        bh=oe4g+ZM7mSjfay+6G9vESARCsbmWufAd4nTqJCySwpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fclIG5U0yO/AmakgZZKzCJggJk18rRX3+RDdtGnWTGCvl7EYl2xxDNoGNOQOEK3uk
         2FFQulbZAnJqVMvky9MvnJ+TC7L2iTLAzbQ1BJ7jfFgmBr9Oyerhqz2oI5Ro9rHf/E
         U8/BHmIvtd4Fu2vgGfrvlMcGgM7EHAMhPInTch+g=
Date:   Thu, 24 Aug 2023 08:53:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1] KVM: x86/mmu: Fix an sign-extension bug with mmu_seq
 that hangs vCPUs
Message-ID: <2023082423-ninetieth-hamlet-54dc@gregkh>
References: <20230824010104.2714198-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824010104.2714198-1-seanjc@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 06:01:04PM -0700, Sean Christopherson wrote:
> Take the vCPU's mmu_seq snapshot as an "unsigned long" instead of an "int"
> when checking to see if a page fault is stale, as the sequence count is
> stored as an "unsigned long" everywhere else in KVM.  This fixes a bug
> where KVM will effectively hang vCPUs due to always thinking page faults
> are stale, which results in KVM refusing to "fix" faults.
> 
> mmu_invalidate_seq (née mmu_notifier_seq) is a sequence counter used when
> KVM is handling page faults to detect if userspace mappings relevant to
> the guest were invalidated between snapshotting the counter and acquiring
> mmu_lock, i.e. to ensure that the userspace mapping KVM is using to
> resolve the page fault is fresh.  If KVM sees that the counter has
> changed, KVM simply resumes the guest without fixing the fault.
> 
> What _should_ happen is that the source of the mmu_notifier invalidations
> eventually goes away, mmu_invalidate_seq becomes stable, and KVM can once
> again fix guest page fault(s).
> 
> But for a long-lived VM and/or a VM that the host just doesn't particularly
> like, it's possible for a VM to be on the receiving end of 2 billion (with
> a B) mmu_notifier invalidations.  When that happens, bit 31 will be set in
> mmu_invalidate_seq.  This causes the value to be turned into a 32-bit
> negative value when implicitly cast to an "int" by is_page_fault_stale(),
> and then sign-extended into a 64-bit unsigned when the signed "int" is
> implicitly cast back to an "unsigned long" on the call to
> mmu_invalidate_retry_hva().
> 
> As a result of the casting and sign-extension, given a sequence counter of
> e.g. 0x8002dc25, mmu_invalidate_retry_hva() ends up doing
> 
> 	if (0x8002dc25 != 0xffffffff8002dc25)
> 
> and signals that the page fault is stale and needs to be retried even
> though the sequence counter is stable, and KVM effectively hangs any vCPU
> that takes a page fault (EPT violation or #NPF when TDP is enabled).
> 
> Note, upstream commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq
> in kvm_faultin_pfn()") unknowingly fixed the bug in v6.3 when refactoring
> how KVM tracks the sequence counter snapshot.
> 
> Reported-by: Brian Rak <brak@vultr.com>
> Reported-by: Amaan Cheval <amaan.cheval@gmail.com>
> Reported-by: Eric Wheeler <kvm@lists.ewheeler.net>
> Closes: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@gameservers.com
> Fixes: a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update")
> Signed-off-by: Sean Christopherson <seanjc@google.com>

What is the git commit id of this change in Linus's tree?

thanks,

greg k-h
