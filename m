Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690F7C6153
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJLADd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjJLADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:03:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC88390
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:03:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91027C433C7;
        Thu, 12 Oct 2023 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697069010;
        bh=NT3MPmQP3Ft6GdyMVBxqACxP/O1fU4jdsdkufjHBiEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqYqYBkFhsX6TUC0NEdxv5i1JF06rhgBuWKrC3ryn6AUmvQS0enolBalfzAw9pyTo
         zb7MVxHQXznqKOntvAN/HhCuibAuCb734kG3xgvPZrF904nc8HqkD3EkfRpE+Nqxel
         scpGE/oJOZaeF+3lrGyH7dNws4rLYi2Det6YGH4lFv6BBVq0hQ/fVCgxhoE1nxyI1o
         dJnM0xH6yok5mP8hopqdLFyZvCoWocJ4Yz1P3nEAAZ2TSH0Xi19LsLJCdoq9TXkTML
         wNCthCivvtAl1dMPykEtbGibUd0X9T8Ci5qKHZrTKSokLWevQ1MEAynYs6FU/uwhbQ
         flkMomB+XOJmA==
Date:   Wed, 11 Oct 2023 17:03:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Usama Arif <usama.arif@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231012000327.GA1855399@dev-arch.thelio-3990X>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
 <20231010012345.GA108129@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010012345.GA108129@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Mon, Oct 09, 2023 at 06:23:45PM -0700, Mike Kravetz wrote:
> On 10/09/23 15:56, Usama Arif wrote:
> > Calling prep_and_add_allocated_folios when allocating gigantic pages
> > at boot time causes the kernel to crash as folio_list is empty
> > and iterating it causes a NULL pointer dereference. Call this only
> > for non-gigantic pages when folio_list has entires.
> 
> Thanks!
> 
> However, are you sure the issue is the result of iterating through a
> NULL list?  For reference, the routine prep_and_add_allocated_folios is:
> 
> static void prep_and_add_allocated_folios(struct hstate *h,
> 					struct list_head *folio_list)
> {
> 	struct folio *folio, *tmp_f;
> 
> 	/* Add all new pool pages to free lists in one lock cycle */
> 	spin_lock_irq(&hugetlb_lock);
> 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
> 		__prep_account_new_huge_page(h, folio_nid(folio));
> 		enqueue_hugetlb_folio(h, folio);
> 	}
> 	spin_unlock_irq(&hugetlb_lock);
> }
> 
> If folio_list is empty, then the only code that should be executed is
> acquiring the lock, notice the list is empty, release the lock.
> 
> In the case of gigantic pages addressed below, I do see the warning:
> 
> [    0.055140] DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled)
> [    0.055149] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4345 lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055153] Modules linked in:
> [    0.055155] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc4+ #40
> [    0.055157] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> [    0.055158] RIP: 0010:lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055160] Code: 00 85 c0 0f 84 5e ff ff ff 8b 0d a7 20 74 01 85 c9 0f 85 50 ff ff ff 48 c7 c6 48 25 42 82 48 c7 c7 70 7f 40 82 e8 18 10 f7 ff <0f> 0b 5b e9 e0 d8 af 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> [    0.055162] RSP: 0000:ffffffff82603d40 EFLAGS: 00010086 ORIG_RAX: 0000000000000000
> [    0.055164] RAX: 0000000000000000 RBX: ffffffff827911e0 RCX: 0000000000000000
> [    0.055165] RDX: 0000000000000004 RSI: ffffffff8246b3e1 RDI: 00000000ffffffff
> [    0.055166] RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
> [    0.055166] R10: ffffffffffffffff R11: 284e4f5f4e524157 R12: 0000000000000001
> [    0.055167] R13: ffffffff82eb6316 R14: ffffffff82603d70 R15: ffffffff82ee5f70
> [    0.055169] FS:  0000000000000000(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [    0.055170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.055171] CR2: ffff88847ffff000 CR3: 000000000263a000 CR4: 00000000000200b0
> [    0.055174] Call Trace:
> [    0.055174]  <TASK>
> [    0.055175]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055177]  ? __warn+0x81/0x170
> [    0.055181]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055182]  ? report_bug+0x18d/0x1c0
> [    0.055186]  ? early_fixup_exception+0x92/0xb0
> [    0.055189]  ? early_idt_handler_common+0x2f/0x40
> [    0.055194]  ? lockdep_hardirqs_on_prepare+0x1a8/0x1b0
> [    0.055196]  trace_hardirqs_on+0x10/0xa0
> [    0.055198]  _raw_spin_unlock_irq+0x24/0x50
> [    0.055201]  hugetlb_hstate_alloc_pages+0x311/0x3e0
> [    0.055206]  hugepages_setup+0x220/0x2c0
> [    0.055210]  unknown_bootoption+0x98/0x1d0
> [    0.055213]  parse_args+0x152/0x440
> [    0.055216]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.055220]  start_kernel+0x1af/0x6c0
> [    0.055222]  ? __pfx_unknown_bootoption+0x10/0x10
> [    0.055225]  x86_64_start_reservations+0x14/0x30
> [    0.055227]  x86_64_start_kernel+0x74/0x80
> [    0.055229]  secondary_startup_64_no_verify+0x166/0x16b
> [    0.055234]  </TASK>
> [    0.055235] irq event stamp: 0
> [    0.055236] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.055238] hardirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.055239] softirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.055240] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.055240] ---[ end trace 0000000000000000 ]---
> 
> This is because interrupts are not enabled this early in boot, and the
> spin_unlock_irq() would incorrectly enable interrupts too early.  I wonder
> if this 'warning' could translate to a panic or NULL deref under certain
> configurations?
> 
> Konrad, I am interested to see if this addresses your booting problem.  But,
> your stack trace is a bit different.  My 'guess' is that this will not address
> your issue.  If it does not, can you try the following patch?  This
> applies to next-20231009.
> -- 
> Mike Kravetz
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f3749fc125d4..8346c98e5616 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2178,18 +2178,19 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
>  static void prep_and_add_allocated_folios(struct hstate *h,
>  					struct list_head *folio_list)
>  {
> +	unsigned long flags;
>  	struct folio *folio, *tmp_f;
>  
>  	/* Send list for bulk vmemmap optimization processing */
>  	hugetlb_vmemmap_optimize_folios(h, folio_list);
>  
>  	/* Add all new pool pages to free lists in one lock cycle */
> -	spin_lock_irq(&hugetlb_lock);
> +	spin_lock_irqsave(&hugetlb_lock, flags);
>  	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>  		__prep_account_new_huge_page(h, folio_nid(folio));
>  		enqueue_hugetlb_folio(h, folio);
>  	}
> -	spin_unlock_irq(&hugetlb_lock);
> +	spin_unlock_irqrestore(&hugetlb_lock, flags);
>  }
>  
>  /*
> @@ -3224,13 +3225,14 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
>  static void __init prep_and_add_bootmem_folios(struct hstate *h,
>  					struct list_head *folio_list)
>  {
> +	unsigned long flags;
>  	struct folio *folio, *tmp_f;
>  
>  	/* Send list for bulk vmemmap optimization processing */
>  	hugetlb_vmemmap_optimize_folios(h, folio_list);
>  
>  	/* Add all new pool pages to free lists in one lock cycle */
> -	spin_lock_irq(&hugetlb_lock);
> +	spin_lock_irqsave(&hugetlb_lock, flags);
>  	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
>  		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
>  			/*
> @@ -3246,7 +3248,7 @@ static void __init prep_and_add_bootmem_folios(struct hstate *h,
>  		__prep_account_new_huge_page(h, folio_nid(folio));
>  		enqueue_hugetlb_folio(h, folio);
>  	}
> -	spin_unlock_irq(&hugetlb_lock);
> +	spin_unlock_irqrestore(&hugetlb_lock, flags);
>  }
>  
>  /*

I suspect the crash that our continuous integration spotted [1] is the
same issue that Konrad is seeing, as I have bisected that failure to
bfb41d6b2fe1 in next-20231009. However, neither the first half of your
diff (since the second half does not apply at bfb41d6b2fe1) nor the
original patch in this thread resolves the issue though, so maybe it is
entirely different from Konrad's?

For what it's worth, this issue is only visible for me when building for
arm64 using LLVM with CONFIG_INIT_STACK_NONE=y, instead of the default
CONFIG_INIT_STACK_ALL_ZERO=y (which appears to hide the problem?),
making it seem like it could be something with uninitialized memory... I
have not been able to reproduce it with GCC, which could also mean
something.

Using LLVM 17.0.2 from kernel.org [2]:

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 mrproper defconfig

$ scripts/config -d INIT_STACK_ALL_ZERO -e INIT_STACK_NONE

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 Image.gz

$ qemu-system-aarch64 \
    -display none \
    -nodefaults \
    -cpu max,pauth-impdef=true \
    -machine virt,gic-version=max,virtualization=true \
    -append 'console=ttyAMA0 earlycon' \
    -kernel arch/arm64/boot/Image.gz \
    -initrd arm64-rootfs.cpio \
    -m 512m \
    -serial mon:stdio
...
[    0.000000] Linux version 6.6.0-rc4-00317-gbfb41d6b2fe1 (nathan@dev-arch.thelio-3990X) (ClangBuiltLinux clang version 17.0.2 (https://github.com/llvm/llvm-project b2417f51dbbd7435eb3aaf203de24de6754da50e), ClangBuiltLinux LLD 17.0.2) #1 SMP PREEMPT Wed Oct 11 16:44:41 MST 2023
...
[    0.304543] Unable to handle kernel paging request at virtual address ffffff602827f9f4
[    0.304899] Mem abort info:
[    0.305022]   ESR = 0x0000000096000004
[    0.305438]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.305668]   SET = 0, FnV = 0
[    0.305804]   EA = 0, S1PTW = 0
[    0.305949]   FSC = 0x04: level 0 translation fault
[    0.306156] Data abort info:
[    0.306287]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    0.306500]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.306711]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.306976] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000041cc3000
[    0.307251] [ffffff602827f9f4] pgd=0000000000000000, p4d=0000000000000000
[    0.308086] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    0.308428] Modules linked in:
[    0.308722] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4-00317-gbfb41d6b2fe1 #1
[    0.309159] Hardware name: linux,dummy-virt (DT)
[    0.309496] pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    0.309987] pc : gather_bootmem_prealloc+0x80/0x1a8
[    0.310673] lr : hugetlb_init+0x1c8/0x2ec
[    0.310871] sp : ffff80008000ba10
[    0.311038] x29: ffff80008000ba30 x28: 0000000000000000 x27: ffffd80a09fe7db8
[    0.311417] x26: 0000000000000001 x25: ffffd80a09fe7db8 x24: 0000000000000100
[    0.311702] x23: fffffc0000000000 x22: 0001000000000000 x21: ffff80008000ba18
[    0.311987] x20: ffffff602827f9c0 x19: ffffd80a0a555b60 x18: 00000000fbf7386f
[    0.312272] x17: 00000000bee83943 x16: 000000002ae32058 x15: 0000000000000000
[    0.312557] x14: 0000000000000009 x13: ffffd80a0a556d28 x12: ffffffffffffee38
[    0.312831] x11: ffffd80a0a556d28 x10: 0000000000000004 x9 : ffffd80a09fe7000
[    0.313141] x8 : 0000000d80a09fe7 x7 : 0000000001e1f7fb x6 : 0000000000000008
[    0.313425] x5 : ffffd80a09ef1454 x4 : ffff00001fed5630 x3 : 0000000000019e00
[    0.313703] x2 : ffff000002407b80 x1 : 0000000000019d00 x0 : 0000000000000000
[    0.314054] Call trace:
[    0.314259]  gather_bootmem_prealloc+0x80/0x1a8
[    0.314536]  hugetlb_init+0x1c8/0x2ec
[    0.314743]  do_one_initcall+0xac/0x220
[    0.314928]  do_initcall_level+0x8c/0xac
[    0.315114]  do_initcalls+0x54/0x94
[    0.315276]  do_basic_setup+0x1c/0x28
[    0.315450]  kernel_init_freeable+0x104/0x170
[    0.315648]  kernel_init+0x20/0x1a0
[    0.315822]  ret_from_fork+0x10/0x20
[    0.316235] Code: 979e8c0d 8b160328 d34cfd08 8b081af4 (b9403688)
[    0.316745] ---[ end trace 0000000000000000 ]---
[    0.317463] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.318093] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

The rootfs is available at [3] in case it is relevant. I am more than
happy to provide any additional information or test any patches as
necessary.

[1]: https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/6469151768/job/17570882198
[2]: https://mirrors.edge.kernel.org/pub/tools/llvm/
[3]: https://github.com/ClangBuiltLinux/boot-utils/releases

Cheers,
Nathan
