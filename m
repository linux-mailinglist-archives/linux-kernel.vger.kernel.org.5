Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85A772947
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjHGPc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHGPcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:32:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F06399
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:32:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EF61FB;
        Mon,  7 Aug 2023 08:33:29 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2533F59C;
        Mon,  7 Aug 2023 08:32:44 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:32:41 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     John Hsu =?utf-8?B?KOioseawuOe/sCk=?= <John.Hsu@mediatek.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Xiaobing Shi =?utf-8?B?KOWPsuWwj+WFtSk=?= 
        <Xiaobing.Shi@mediatek.com>,
        Chunhui Li =?utf-8?B?KOadjuaYpei+iSk=?= 
        <chunhui.li@mediatek.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [BUG kernel-5.15] aarch64: __pi_strncmp() out-of-bound error
Message-ID: <ZNEOmRb2sYQlVYwj@FVFF77S0Q05N.cambridge.arm.com>
References: <e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f30f7d5b7d72a3521da31ab2002b49a26f542e.camel@mediatek.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 12:31:45PM +0000, John Hsu (許永翰) wrote:
> Hi ARM maintainers,
>  
> We met this issue under our internal test.
> It seems that __pi_strncmp() reads out-of-bound.
>  
> [ 7445.268043][  T382] ueventd: [name:fault&]Unable to handle kernel
> paging request at virtual address ffffff803fd3f000
> [ 7445.268078][  T382] ueventd: [name:fault&]Mem abort info:
> [ 7445.268084][  T382] ueventd: [name:fault&]  ESR = 0x96000007
> [ 7445.268089][  T382] ueventd: [name:fault&]  EC = 0x25: DABT (current
> EL), IL = 32 bits
> [ 7445.268095][  T382] ueventd: [name:fault&]  SET = 0, FnV = 0
> [ 7445.268100][  T382] ueventd: [name:fault&]  EA = 0, S1PTW = 0
> [ 7445.268105][  T382] ueventd: [name:fault&]  FSC = 0x07: level 3
> translation fault
> [ 7445.268110][  T382] ueventd: [name:fault&]Data abort info:
> [ 7445.268115][  T382] ueventd: [name:fault&]  ISV = 0, ISS =
> 0x00000007
> [ 7445.268120][  T382] ueventd: [name:fault&]  CM = 0, WnR = 0
> [ 7445.268126][  T382] ueventd: [name:fault&]swapper pgtable: 4k pages,
> 39-bit VAs, pgdp=00000000426c6000
> [ 7445.268133][  T382] ueventd: [name:fault&][ffffff803fd3f000]
> pgd=1800000327ff5003, p4d=1800000327ff5003, pud=1800000327ff5003,
> pmd=1800000327fef003, pte=0000000000000000
> [ 7445.268154][  T382] ueventd: [name:traps&]Internal error: Oops:
> 96000007 [#1] PREEMPT SMP
> [ 7445.268278][  T382] ueventd: [name:mrdump&]Kernel Offset:
> 0x2825400000 from 0xffffffc008000000
> [ 7445.268286][  T382] ueventd: [name:mrdump&]PHYS_OFFSET: 0x40000000
> [ 7445.268294][  T382] ueventd: [name:mrdump&]pstate: 82400005 (Nzcv
> daif +PAN -UAO)
> [ 7445.268301][  T382] ueventd: [name:mrdump&]pc : [0xffffffe82d420210]
> __pi_strncmp+0x1a0/0x1c4
> [ 7445.268310][  T382] ueventd: [name:mrdump&]lr : [0xffffffe82dbe12c0]
> __security_genfs_sid+0x100/0x168
> [ 7445.268319][  T382] ueventd: [name:mrdump&]sp : ffffffc0097cb8b0
> …
> [ 7445.269337][  T382] ueventd: CPU: 0 PID: 382 Comm: ueventd Tainted:
> G S      W  OE     5.15.41-android13-8-gb1f1ad628628 #1
> [ 7445.269347][  T382] ueventd: Hardware name: MT6886(ENG) (DT)
> [ 7445.269354][  T382] ueventd: Call trace:
> [ 7445.269359][  T382] ueventd:  dump_backtrace+0x0/0x2a8
> [ 7445.269374][  T382] ueventd:  dump_stack_lvl+0x74/0xa4
> [ 7445.269384][  T382] ueventd:  dump_stack+0x14/0x1c
> [ 7445.269391][  T382] ueventd:  mrdump_common_die+0x32c/0x5ac [mrdump]
> [ 7445.269470][  T382] ueventd:  ipanic_die+0x1c/0x28 [mrdump]
> [ 7445.269539][  T382] ueventd:  __die+0xbc/0x308
> [ 7445.269548][  T382] ueventd:  die+0xd8/0x500
> [ 7445.269556][  T382] ueventd:  die_kernel_fault+0x94/0xa8
> [ 7445.269565][  T382] ueventd:  __do_kernel_fault+0x1d8/0x214
> [ 7445.269571][  T382] ueventd:  do_bad_area+0x40/0x174
> [ 7445.269579][  T382] ueventd:  do_translation_fault+0x48/0x54
> [ 7445.269585][  T382] ueventd:  do_mem_abort+0x3c/0x100
> [ 7445.269592][  T382] ueventd:  el1_abort+0x38/0x54
> [ 7445.269602][  T382] ueventd:  el1h_64_sync_handler+0x54/0x88
> [ 7445.269610][  T382] ueventd:  el1h_64_sync+0x78/0x7c
> [ 7445.269618][  T382] ueventd:  __pi_strncmp+0x1a0/0x1c4
> [ 7445.269626][  T382] ueventd:  selinux_genfs_get_sid+0x114/0x220
> [ 7445.269636][  T382] ueventd:  inode_doinit_with_dentry+0x3d0/0x598
> [ 7445.269644][  T382] ueventd:  selinux_d_instantiate+0x1c/0x24
> [ 7445.269652][  T382] ueventd:  d_splice_alias+0x5c/0x280
> [ 7445.269662][  T382] ueventd:  kernfs_iop_lookup+0xec/0x21c
> [ 7445.269674][  T382] ueventd:  __lookup_slow+0xc4/0x150
> [ 7445.269684][  T382] ueventd:  lookup_slow+0x40/0xf0
> [ 7445.269690][  T382] ueventd:  walk_component+0x144/0x160
> [ 7445.269696][  T382] ueventd:  link_path_walk+0x25c/0x344
> [ 7445.269703][  T382] ueventd:  path_lookupat+0x64/0x120
> [ 7445.269710][  T382] ueventd:  filename_lookup+0xc4/0x1b0
> [ 7445.269718][  T382] ueventd:  user_path_at_empty+0x48/0xb4
> [ 7445.269725][  T382] ueventd:  do_faccessat+0xa8/0x1f0
> [ 7445.269732][  T382] ueventd:  __arm64_sys_faccessat+0x20/0x28
> [ 7445.269738][  T382] ueventd:  invoke_syscall+0x3c/0xf0
> [ 7445.269746][  T382] ueventd:  el0_svc_common+0x84/0xe8
> [ 7445.269753][  T382] ueventd:  do_el0_svc+0x20/0x84
> [ 7445.269759][  T382] ueventd:  el0_svc+0x1c/0x48
> [ 7445.269766][  T382] ueventd:  el0t_64_sync_handler+0x7c/0xd8
> [ 7445.269773][  T382] ueventd:  el0t_64_sync+0x15c/0x160
>  
> We found that we hit this issue when we compare these two strings.
>  
> ________________address|_0__1__2__3__4__5__6__7__8__9__A__B__C__D__E__F
> __   0123456789ABCDEF
>    NSD:FFFFFF80089EDA00|>2F 64 65 76 69 63 65 73 2F 76 69 72 74 75 61
> 6C  /devices/virtual
>    NSD:FFFFFF80089EDA10| 2F 62 6C 6F 63 6B 2F 00 E0 03 01 AA E1 03 02
> AA  /block/.........
>  
> ________________address|_0__1__2__3__4__5__6__7__8__9__A__B__C__D__E__F
> __    0123456789ABCDEF
>    NSD:FFFFFF803FD3EFE0| 00 00 00 00 00 00 00 00 00 00 2F 64 65 76 69
> 63    ........../devic
>    NSD:FFFFFF803FD3EFF0| 65 73>2F 76 69 72 74 75 61 6C 2F 6D 69 73 63
> 00  es/virtual/misc.
>    NSD:FFFFFF803FD3F000| ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
> ??
>    NSD:FFFFFF803FD3F0E0| ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
> ??
> 
> We observe the second string is put at the tail of the first page and
> the next page is unreadable.
> Thus, we made a simple test as below and it can reproduce this issue.
> 
> static noinline void strncmp_ut(void)
> {
>     int ret = 0;
>     int size = 4096;
>     char *src1 = vmalloc(size);
>     char *src2 = vmalloc(size);
>     char *str1 = "/devices/virtual/block/";
>     char *str2 = "/devices/virtual/misc";
>     int len1 = strlen(str1);
>     int len2 = strlen(str2);
>     char *str1_start, *str2_start;
> 
>     pr_info("src1: %px\n", src1);
>     pr_info("src2: %px\n", src2);
>     pr_info("len1 :%d, len2: %d\n", len1, len2);
> 
>     memset(src1, 0, size);
>     strncpy(&src1[size-len1-1], str1, len1);
>     memset(src2, 0, size);
>     strncpy(&src2[size-len2-1], str2, len2);
> 
>     str1_start = src1 + size - len1 - 1;
>     pr_info("str1_start: %px", str1_start);
>     str2_start = src2 + size - len2 - 1;
>     pr_info("str2_start: %px", str2_start);
>     ret = strncmp(str1_start, str2_start, len1);
>     pr_info("ret: %d\n", ret);
> }
> 
> 
> Does any issue exist in __pi_strncmp in kernel-5.15?

There's no known issue, but the implementation change substantially in commit:

  387d828adffcf1eb ("arm64: lib: Import latest version of Arm Optimized Routines' strncmp")

... which added additional alignment restrictions to accesses to avoid crossing
an MTE tag granule.

Using your test on v6.5-rc3 I could not trigger the issue, but I could trigger
the issue atop v5.15:

[    1.639268] src1: ffff800010005000
[    1.639982] src2: ffff80001000d000
[    1.640758] len1 :23, len2: 21
[    1.641098] str1_start: ffff800010005fe8
[    1.641202] str2_start: ffff80001000dfea
[    1.642312] Unable to handle kernel paging request at virtual address ffff80001000e000
[    1.643237] Mem abort info:
[    1.643858]   ESR = 0x96000007
[    1.644201]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.644453]   SET = 0, FnV = 0
[    1.644979]   EA = 0, S1PTW = 0
[    1.645212]   FSC = 0x07: level 3 translation fault
[    1.645492] Data abort info:
[    1.645638]   ISV = 0, ISS = 0x00000007
[    1.645818]   CM = 0, WnR = 0
[    1.646075] swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000007a611000
[    1.646417] [ffff80001000e000] pgd=100000004001d003, p4d=100000004001d003, pud=100000004001e003, pmd=100000004001f003, pte=0000000000000000
[    1.648699] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[    1.649681] Modules linked in:
[    1.650322] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.0-dirty #1
[    1.650994] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.651475] pc : __pi_strncmp+0x1a0/0x1c4
[    1.652860] lr : strncmp_ut+0xf4/0x118
[    1.653133] sp : ffff80001009bdd0
[    1.653680] x29: ffff80001009bdd0 x28: 0000000000000000 x27: 0000000000000000
[    1.654134] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    1.654453] x23: ffffa050aff25000 x22: 0000000000001000 x21: ffff800010005fe8
[    1.654774] x20: ffff80001000dfea x19: ffff80001000dff7 x18: 0000000000000006
[    1.655138] x17: 687469726f676c61 x16: 2046454420504d49 x15: ffff80001009b950
[    1.655462] x14: 0000000000000008 x13: ffffffffffffffff x12: 00000000000002dc
[    1.656107] x11: 0101010101010101 x10: ffffa050afc9c540 x9 : 7f7f7f7f7f7f7f7f
[    1.656467] x8 : 6b6074737168752e x7 : ffffa050afc9ae60 x6 : 0000000000000000
[    1.656769] x5 : 0000000000000000 x4 : 6c6175747269762f x3 : 2f6b636f6c622f6c
[    1.657083] x2 : 0000000000000007 x1 : ffff80001000dff2 x0 : ffff800010005ff0
[    1.657576] Call trace:
[    1.657920]  __pi_strncmp+0x1a0/0x1c4
[    1.658179]  smp_cpus_done+0xb4/0xc0
[    1.658363]  smp_init+0x80/0x90
[    1.658516]  kernel_init_freeable+0x12c/0x290
[    1.658792]  kernel_init+0x28/0x130
[    1.658966]  ret_from_fork+0x10/0x20
[    1.659564] Code: b4fff762 d1002000 d1002021 f8626803 (f8626824) 
[    1.661848] ---[ end trace 5ce515dccfbd3da3 ]---
[    1.663291] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.663861] SMP: stopping secondary CPUs
[    1.667296] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

That __pi_strncmp+0x1a0/0x1c4 is right at the end of __pi_strcmp():

| L(done_loop):
|         /* We found a difference or a NULL before the limit was reached.  */
|         and     limit, limit, #7
|         cbz     limit, L(not_limit)
|         /* Read the last word.  */
|         sub     src1, src1, 8
|         sub     src2, src2, 8
|         ldr     data1, [src1, limit]
|         ldr     data2, [src2, limit]	// <----------- Faulting LDR here
|         sub     tmp1, data1, zeroones
|         orr     tmp2, data1, #REP8_7f
|         eor     diff, data1, data2      /* Non-zero if differences found.  */
|         bics    has_nul, tmp1, tmp2     /* Non-zero if NUL terminator.  */
|         ccmp    diff, #0, #0, eq
|         b.ne    L(not_limit)
| 
| L(ret0):
|         mov     result, #0
|         ret 

Thanks,
Mark.
