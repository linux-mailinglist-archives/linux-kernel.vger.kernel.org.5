Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290176E8C8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjHCMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjHCMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:50:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417343586
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VNHUTpeBs5mRpl5sVmA/ZVFzvyQPjDFvS1GmgYeLZd4=; b=OerHrGfxBQtMVz35e1/Cs1aPyu
        lQKQ740ezPvbQpX22/OdolClvRhyx9rBkGf8OoRogTYYoDsk8PBmgdQbRU+r3lSj46KDTo2ohPKjI
        RVk/8ZJOZ2GVkpolO2o/WvmBIseFotcB0xDyxOBNzPTrXlrOsWpIGytfRC7JpRj6J/MaejIzd9+yM
        YxEEbgpMSg4oruQXCKbuKx7oflQjqYwmMXF6idWvKFnAVnjHw6fpcL1o0FTGFFDNxv34k5HxnsuaW
        w2CVsfaTHcC68qFtApk6jruP4fUdRgkCEK+TPZBRplraX4I9NrxHCg9xJ3mM8oJ1TSMMQIZRZ9hI1
        v5M5B5Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRXmX-003iwb-Hw; Thu, 03 Aug 2023 12:50:21 +0000
Date:   Thu, 3 Aug 2023 13:50:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yikebaer Aizezi <yikebaer61@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: WARNING in try_grab_page
Message-ID: <ZMuijbZCgTSyGUC7@casper.infradead.org>
References: <CALcu4rbFsnB5hsiv310tRNNBioLve0n553O1cX1mS9+HdA8r+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALcu4rbFsnB5hsiv310tRNNBioLve0n553O1cX1mS9+HdA8r+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 04:56:03PM +0800, Yikebaer Aizezi wrote:
> console output:
> https://drive.google.com/file/d/1Lq71bFwtEDix82PEf_193CLG6uh1Pjj9/view?usp=drive_link
> kernel config: https://drive.google.com/file/d/1dApy7OR4KDYdhF96ZUowZQ1r-uLYTd-0/view?usp=drive_link
> C reproducer: https://drive.google.com/file/d/1Dkj31wwYP7p-AEJeemD3yrIUr7-VdBqF/view?usp=drive_link

Are you sure this is right?  The below stack trace shows something
coming in through the ioctl() path, but nothing in this reproducer
calls ioctl().  It's just socket(), bind(), accept4() and sendmsg().
I don't see a way to come up with this stack backtrace from that
program.

> Call Trace:
>  <TASK>
>  follow_page_pte+0x18c/0x1610 mm/gup.c:651
>  follow_pmd_mask mm/gup.c:727 [inline]
>  follow_pud_mask mm/gup.c:765 [inline]
>  follow_p4d_mask mm/gup.c:782 [inline]
>  follow_page_mask+0x2e4/0xbd0 mm/gup.c:839
>  __get_user_pages+0x3fa/0xcf0 mm/gup.c:1256
>  __get_user_pages_locked mm/gup.c:1487 [inline]
>  get_user_pages_unlocked+0x183/0x580 mm/gup.c:2387
>  hva_to_pfn_slow arch/x86/kvm/../../../virt/kvm/kvm_main.c:2536 [inline]
>  hva_to_pfn+0x198/0xbc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2674
>  __gfn_to_pfn_memslot+0x202/0x3e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2736
>  __kvm_faultin_pfn arch/x86/kvm/mmu/mmu.c:4329 [inline]
>  kvm_faultin_pfn+0x21b/0x12d0 arch/x86/kvm/mmu/mmu.c:4365
>  kvm_tdp_mmu_page_fault arch/x86/kvm/mmu/mmu.c:4503 [inline]
>  kvm_tdp_page_fault+0x167/0x4d0 arch/x86/kvm/mmu/mmu.c:4549
>  kvm_mmu_do_page_fault arch/x86/kvm/mmu/mmu_internal.h:320 [inline]
>  kvm_mmu_page_fault+0x2f4/0x1a40 arch/x86/kvm/mmu/mmu.c:5756
>  handle_ept_violation+0x20a/0x620 arch/x86/kvm/vmx/vmx.c:5760
>  __vmx_handle_exit arch/x86/kvm/vmx/vmx.c:6539 [inline]
>  vmx_handle_exit+0x4a1/0x18d0 arch/x86/kvm/vmx/vmx.c:6556
>  vcpu_enter_guest arch/x86/kvm/x86.c:10848 [inline]
>  vcpu_run+0x24b6/0x44b0 arch/x86/kvm/x86.c:10951
>  kvm_arch_vcpu_ioctl_run+0x416/0x1830 arch/x86/kvm/x86.c:11172
>  kvm_vcpu_ioctl+0x4de/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4112
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x173/0x1e0 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x47959d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc6339a4068 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
> RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000006
> RBP: 000000000059c0a0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0ac
> R13: 000000000000000b R14: 0000000000437250 R15: 00007fc633984000
>  </TASK>
