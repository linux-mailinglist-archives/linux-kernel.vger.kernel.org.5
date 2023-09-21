Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEB37AA16B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjIUVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjIUVBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:01:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E65B84601;
        Thu, 21 Sep 2023 10:37:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37EBC3277B;
        Thu, 21 Sep 2023 09:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287916;
        bh=ZjnW8OcBulkPB1i8nYOF+IEEcndwEahWTB8+exB9Czw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DJ51SKJ0l8JsvL8ZQVpgB5iMfqpilNiXkWC2Kk0NUC5Wj1WVacW4Ivk0IZXJBUGPP
         XSZg5DF+wsn9CnwjfznYU51u5/FmLGftCEzZaCq7ahjN4h3c/fCok8wB5r2VOfXjTk
         Pq9cSqkw7sHacySu3kmzDCh4/SUW46lfaJE5RcxZjtTpMYBwc4XOGC7MKg1rBwWpkD
         Po1SeAjcVSx8qhp2YOAuXMamcTSAgl0XH0nrHOp7dPUvUaEzjTUMrCeawa5KkupLBJ
         rMRioG0Vwkb3Nc7KFBYwK62FBM8/J6NOK7lnJL9xOtLkwrKrHzK/IiWKlaNqOJqMF7
         2xigUgxuhuQAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A3B17CE18F5; Thu, 21 Sep 2023 02:18:33 -0700 (PDT)
Date:   Thu, 21 Sep 2023 02:18:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Ard Biesheuvel <ardb@kernel.org>,
        rcu <rcu@vger.kernel.org>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] arm64: Unable to handle kernel execute from non-executable
 memory at virtual address ffff8000834c13a0
Message-ID: <6e2ee0ca-cf37-42ec-8dc6-593d831eb262@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYtqLarsezP_-6iQqonh8M4Q6McUCEBM9gFv+GU-zZRHAQ@mail.gmail.com>
 <ZQsCj997AW8Tz27W@FVFF77S0Q05N.cambridge.arm.com>
 <7c85cbf5-efb2-9cc6-4a5c-9854f7db1b0e@arm.com>
 <8474df43-0718-4ae5-b36e-2c3c1f19d5e9@paulmck-laptop>
 <CAASaF6yjDFEOjhvum3fy1AfDnDsFAAq3R6PvinOQigdQ=yn+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6yjDFEOjhvum3fy1AfDnDsFAAq3R6PvinOQigdQ=yn+7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 11:01:06AM +0200, Jan Stancek wrote:
> On Wed, Sep 20, 2023 at 7:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Wed, Sep 20, 2023 at 05:26:33PM +0100, Robin Murphy wrote:
> > > On 20/09/2023 3:32 pm, Mark Rutland wrote:
> > > > Hi Naresh,
> > > >
> > > > On Wed, Sep 20, 2023 at 11:29:12AM +0200, Naresh Kamboju wrote:
> > > > > [ my two cents ]
> > > > > While running LTP pty07 test cases on arm64 juno-r2 with Linux next-20230919
> > > > > the following kernel crash was noticed.
> > > > >
> > > > > I have been noticing this issue intermittently on Juno-r2 for more than a month.
> > > > > Anyone have noticed this crash ?
> > > >
> > > > How intermittent is this? 1/2, 1/10, 1/100, rarer still?
> > > >
> > > > Are you running *just* the pty07 test, or are you running a whole LTP suite and
> > > > the issue first occurs around pty07?
> > > >
> > > > Given you've been hitting this for a month, have you tried testing mainline? Do
> > > > you have a known-good kernel that we can start a bisect from?
> > > >
> > > > Do you *only* see this on Juno-r2 and are you testing on other hardware?
> > > >
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > >
> > > > > [    0.000000] Linux version 6.6.0-rc2-next-20230919 (tuxmake@tuxmake)
> > > > > (aarch64-linux-gnu-gcc (Debian 13.2.0-2) 13.2.0, GNU ld (GNU Binutils
> > > > > for Debian) 2.41) #1 SMP PREEMPT @1695107157
> > > > > [    0.000000] KASLR disabled due to lack of seed
> > > > > [    0.000000] Machine model: ARM Juno development board (r2)
> > > > > ...
> > > > > LTP running pty
> > > > > ...
> > > > >
> > > > > pty07.c:92: TINFO: Saving active console 1
> > > > > ../../../include/tst_fuzzy_sync.h:640: TINFO: Stopped sampling at 552
> > > > > (out of 1024) samples, sampling time reached 50% of the total time
> > > > > limit
> > > > > ../../../include/tst_fuzzy_sync.h:307: TINFO: loop = 552, delay_bias = 0
> > > > > ../../../include/tst_fuzzy_sync.h:295: TINFO: start_a - start_b: { avg
> > > > > =   127ns, avg_dev =    84ns, dev_ratio = 0.66 }
> > > > > ../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - start_a  : { avg
> > > > > = 17296156ns, avg_dev = 5155058ns, dev_ratio = 0.30 }
> > > > > ../../../include/tst_fuzzy_sync.h:295: TINFO: end_b - start_b  : { avg
> > > > > = 101202336ns, avg_dev = 6689286ns, dev_ratio = 0.07 }
> > > > > ../../../include/tst_fuzzy_sync.h:295: TINFO: end_a - end_b    : { avg
> > > > > = -83906064ns, avg_dev = 10230694ns, dev_ratio = 0.12 }
> > > > > ../../../include/tst_fuzzy_sync.h:295: TINFO: spins            : { avg
> > > > > = 2765565  , avg_dev = 339285  , dev_ratio = 0.12 }
> > > > > [  384.133538] Unable to handle kernel execute from non-executable
> > > > > memory at virtual address ffff8000834c13a0
> > > > > [  384.133559] Mem abort info:
> > > > > [  384.133568]   ESR = 0x000000008600000f
> > > > > [  384.133578]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > > > [  384.133590]   SET = 0, FnV = 0
> > > > > [  384.133600]   EA = 0, S1PTW = 0
> > > > > [  384.133610]   FSC = 0x0f: level 3 permission fault
> > > > > [  384.133621] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000082375000
> > > > > [  384.133634] [ffff8000834c13a0] pgd=10000009fffff003,
> > > > > p4d=10000009fffff003, pud=10000009ffffe003, pmd=10000009ffff8003,
> > > > > pte=00780000836c1703
> > > > > [  384.133697] Internal error: Oops: 000000008600000f [#1] PREEMPT SMP
> > > > > [  384.133707] Modules linked in: tda998x onboard_usb_hub cec hdlcd
> > > > > crct10dif_ce drm_dma_helper drm_kms_helper fuse drm backlight dm_mod
> > > > > ip_tables x_tables
> > > > > [  384.133767] CPU: 3 PID: 589 Comm: (udev-worker) Not tainted
> > > > > 6.6.0-rc2-next-20230919 #1
> > > > > [  384.133779] Hardware name: ARM Juno development board (r2) (DT)
> > > > > [  384.133784] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > > > [  384.133796] pc : in_lookup_hashtable+0x178/0x2000
> > > >
> > > > This indicates that the faulting address ffff8000834c13a0 is
> > > > in_lookup_hashtable+0x178/0x2000, which would been we've somehow marked the
> > > > kernel text as non-executable, which we never do intentionally.
> > > >
> > > > I suspect that implies memory corruption. Have you tried running this with
> > > > KASAN enabled?
> > > >
> > > > > [  384.133818] lr : rcu_core (arch/arm64/include/asm/preempt.h:13
> > > > > (discriminator 1) kernel/rcu/tree.c:2146 (discriminator 1)
> > > > > kernel/rcu/tree.c:2403 (discriminator 1))
> > >
> > > For the record, this LR appears to be the expected return address of the
> > > "f(rhp);" call within rcu_do_batch() (if CONFIG_DEBUG_LOCK_ALLOC=n), so it
> > > looks like a case of a bogus or corrupted RCU callback. The PC is in the
> > > middle of a data symbol (in_lookup_hashtable is an array), so NX is expected
> > > and I wouldn't imagine the pagetables have gone wrong, just regular data
> > > corruption or use-after-free somewhere.
> >
> > Is it possible to use either KASAN or CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> > here?
> 
> CKI has been also running into issues during pty07 runs lately. This
> is from aarch64 debug kernel:

These might well be related, so perhaps fixing one will fix the other.

							Thanx, Paul

> [ 5537.660548] LTP: starting pty07
> [-- MARK -- Mon Sep 18 14:30:00 2023]
> [ 5807.450507] ==================================================================
> [ 5807.450515] BUG: KASAN: slab-use-after-free in d_alloc_parallel+0xbfc/0xdf8
> [ 5807.450524] Read of size 4 at addr ffff000169d87630 by task
> (udev-worker)/280492
> [ 5807.450527]
> [ 5807.450530] CPU: 4 PID: 280492 Comm: (udev-worker) Not tainted
> 6.6.0-0.rc2.20.test.eln.aarch64+debug #1
> [ 5807.450534] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [ 5807.450536] Call trace:
> [ 5807.450537]  dump_backtrace+0xa0/0x128
> [ 5807.450542]  show_stack+0x20/0x38
> [ 5807.450544]  dump_stack_lvl+0xe8/0x178
> [ 5807.450550]  print_address_description.constprop.0+0x84/0x3a0
> [ 5807.450555]  print_report+0xb0/0x278
> [ 5807.450557]  kasan_report+0x90/0xd0
> [ 5807.450559]  __asan_report_load4_noabort+0x20/0x30
> [ 5807.450562]  d_alloc_parallel+0xbfc/0xdf8
> [ 5807.450564]  lookup_open.isra.0+0x6e0/0xe88
> [ 5807.450567]  open_last_lookups+0x740/0xe88
> [ 5807.450571]  path_openat+0x16c/0x538
> [ 5807.450573]  do_filp_open+0x174/0x340
> [ 5807.450576]  do_sys_openat2+0x134/0x180
> [ 5807.450579]  __arm64_sys_openat+0x138/0x1d0
> [ 5807.450581]  invoke_syscall.constprop.0+0xdc/0x1e0
> [ 5807.450584]  do_el0_svc+0x154/0x1d0
> [ 5807.450586]  el0_svc+0x58/0x118
> [ 5807.450590]  el0t_64_sync_handler+0x120/0x130
> [ 5807.450593]  el0t_64_sync+0x1a4/0x1a8
> [ 5807.450595]
> [ 5807.450596] Allocated by task 280071:
> [ 5807.450598]  kasan_save_stack+0x3c/0x68
> [ 5807.450604]  kasan_set_track+0x2c/0x40
> [ 5807.450607]  kasan_save_alloc_info+0x24/0x38
> [ 5807.450609]  __kasan_slab_alloc+0x8c/0x90
> [ 5807.450613]  kmem_cache_alloc+0x144/0x300
> [ 5807.450618]  alloc_empty_file+0x6c/0x180
> [ 5807.450621]  path_openat+0xd0/0x538
> [ 5807.450623]  do_filp_open+0x174/0x340
> [ 5807.450626]  do_sys_openat2+0x134/0x180
> [ 5807.450628]  __arm64_sys_openat+0x138/0x1d0
> [ 5807.450630]  invoke_syscall.constprop.0+0xdc/0x1e0
> [ 5807.450632]  do_el0_svc+0x154/0x1d0
> [ 5807.450634]  el0_svc+0x58/0x118
> [ 5807.450637]  el0t_64_sync_handler+0x120/0x130
> [ 5807.450639]  el0t_64_sync+0x1a4/0x1a8
> [ 5807.450642]
> [ 5807.450643] Freed by task 79:
> [ 5807.450645]  kasan_save_stack+0x3c/0x68
> [ 5807.450649]  kasan_set_track+0x2c/0x40
> [ 5807.450652]  kasan_save_free_info+0x38/0x60
> [ 5807.450654]  __kasan_slab_free+0xe4/0x150
> [ 5807.450658]  slab_free_freelist_hook+0xf4/0x1d0
> [ 5807.450662]  kmem_cache_free+0x1d0/0x3e8
> [ 5807.450665]  file_free_rcu+0xa4/0x120
> [ 5807.450668]  rcu_do_batch+0x4e0/0x1860
> [ 5807.450671]  rcu_core+0x408/0x5b0
> [ 5807.450673]  rcu_core_si+0x18/0x30
> [ 5807.450676]  __do_softirq+0x2e0/0xed0
> [ 5807.450678]
> [ 5807.450678] Last potentially related work creation:
> [ 5807.450680]  kasan_save_stack+0x3c/0x68
> [ 5807.450683]  __kasan_record_aux_stack+0x9c/0xc8
> [ 5807.450686]  kasan_record_aux_stack_noalloc+0x14/0x20
> [ 5807.450689]  __call_rcu_common.constprop.0+0x100/0x940
> [ 5807.450691]  call_rcu+0x18/0x30
> [ 5807.450693]  __fput+0x404/0x848
> [ 5807.450696]  __fput_sync+0x7c/0x98
> [ 5807.450698]  __arm64_sys_close+0x74/0xd0
> [ 5807.450700]  invoke_syscall.constprop.0+0xdc/0x1e0
> [ 5807.450702]  do_el0_svc+0x154/0x1d0
> [ 5807.450704]  el0_svc+0x58/0x118
> [ 5807.450707]  el0t_64_sync_handler+0x120/0x130
> [ 5807.450710]  el0t_64_sync+0x1a4/0x1a8
> [ 5807.450712]
> [ 5807.450712] Second to last potentially related work creation:
> [ 5807.450714]  kasan_save_stack+0x3c/0x68
> [ 5807.450717]  __kasan_record_aux_stack+0x9c/0xc8
> [ 5807.450719]  kasan_record_aux_stack_noalloc+0x14/0x20
> [ 5807.450722]  __call_rcu_common.constprop.0+0x100/0x940
> [ 5807.450724]  call_rcu+0x18/0x30
> [ 5807.450726]  __fput+0x404/0x848
> [ 5807.450728]  __fput_sync+0x7c/0x98
> [ 5807.450731]  __arm64_sys_close+0x74/0xd0
> [ 5807.450733]  invoke_syscall.constprop.0+0xdc/0x1e0
> [ 5807.450735]  do_el0_svc+0x154/0x1d0
> [ 5807.450737]  el0_svc+0x58/0x118
> [ 5807.450740]  el0t_64_sync_handler+0x120/0x130
> [ 5807.450742]  el0t_64_sync+0x1a4/0x1a8
> [ 5807.450744]
> [ 5807.450745] The buggy address belongs to the object at ffff000169d87480
> [ 5807.450745]  which belongs to the cache filp of size 464
> [ 5807.450748] The buggy address is located 432 bytes inside of
> [ 5807.450748]  freed 464-byte region [ffff000169d87480, ffff000169d87650)
> [ 5807.450751]
> [ 5807.450752] The buggy address belongs to the physical page:
> [ 5807.450754] page:00000000310d19d2 refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x1a9d84
> [ 5807.450758] head:00000000310d19d2 order:2 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [ 5807.450760] memcg:ffff0001350cb601
> [ 5807.450762] flags:
> 0x2fffff00000840(slab|head|node=0|zone=2|lastcpupid=0xfffff)
> [ 5807.450766] page_type: 0xffffffff()
> [ 5807.450770] raw: 002fffff00000840 ffff0000d225eb40 fffffc0004b0cc00
> dead000000000002
> [ 5807.450772] raw: 0000000000000000 0000000000190019 00000001ffffffff
> ffff0001350cb601
> [ 5807.450774] page dumped because: kasan: bad access detected
> [ 5807.450775]
> [ 5807.450776] Memory state around the buggy address:
> [ 5807.450778]  ffff000169d87500: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 5807.450779]  ffff000169d87580: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [ 5807.450781] >ffff000169d87600: fb fb fb fb fb fb fb fb fb fb fc fc
> fc fc fc fc
> [ 5807.450783]                                      ^
> [ 5807.450784]  ffff000169d87680: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [ 5807.450786]  ffff000169d87700: 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [ 5807.450787] ==================================================================
> [ 5807.450790] Disabling lock debugging due to kernel taint
> [ 5807.458789] Unable to handle kernel execute from non-executable
> memory at virtual address ffffb66294dcf728
> [ 5807.486215] KASAN: maybe wild-memory-access in range
> [0x0001b314a6e7b940-0x0001b314a6e7b947]
> [ 5807.486221] Mem abort info:
> [ 5807.486223]   ESR = 0x000000008600000e
> [ 5807.486226]   EC = 0x21: IABT (current EL), IL = 32 bits
> [ 5807.486228]   SET = 0, FnV = 0
> [ 5807.486230]   EA = 0, S1PTW = 0
> [ 5807.486232]   FSC = 0x0e: level 2 permission fault
> [ 5807.486235] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000012b3603000
> [ 5807.486238] [ffffb66294dcf728] pgd=100000233ffff003,
> p4d=100000233ffff003, pud=100000233fffe003, pmd=00680012b7600f01
> [ 5807.486250] Internal error: Oops: 000000008600000e [#1] SMP
> [ 5807.486254] Modules linked in: n_hdlc slcan can_dev slip slhc nfsv3
> nfs_acl nfs lockd grace fscache netfs tun brd overlay exfat ext4
> mbcache jbd2 rfkill sunrpc vfat fat loop fuse dm_mod xfs crct10dif_ce
> ghash_ce sha2_ce sha256_arm64 sha1_ce virtio_blk virtio_console
> virtio_net net_failover failover virtio_mmio [last unloaded:
> hwpoison_inject]
> [ 5807.486304] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G    B
>   -------  ---  6.6.0-0.rc2.20.test.eln.aarch64+debug #1
> [ 5807.486308] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
> [ 5807.486310] pstate: 10400005 (nzcV daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 5807.486313] pc : in_lookup_hashtable+0x13c8/0x2020
> [ 5807.486320] lr : rcu_do_batch+0x4e0/0x1860
> [ 5807.486324] sp : ffff800080097cb0
> [ 5807.486325] x29: ffff800080097cb0 x28: 0000000000000009 x27: ffff0000d293c008
> [ 5807.486330] x26: ffffb6628fb04ca0 x25: ffffb66292266000 x24: ffffb66291de8fc8
> [ 5807.486334] x23: ffffb66291de9a20 x22: 0000000000000066 x21: dfff800000000000
> [ 5807.486338] x20: ffffb66290e73008 x19: ffff0002f4ba4418 x18: 0000000000000000
> [ 5807.486342] x17: ffff49bb6df11000 x16: ffff800080090000 x15: ffff001dfed8b168
> [ 5807.486345] x14: ffff001dfed8b0e8 x13: ffff001dfed8b068 x12: ffff76cc529d0793
> [ 5807.486349] x11: 1ffff6cc529d0792 x10: ffff76cc529d0792 x9 : ffffb66291de9000
> [ 5807.486353] x8 : 0000000000000007 x7 : 0000000000000000 x6 : ffffb6628d8d0488
> [ 5807.486357] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 1fffe003bfdb2e10
> [ 5807.486360] x2 : 1fffe0001a527801 x1 : ffffb66294dcf728 x0 : ffff0002f4ba4418
> [ 5807.486364] Call trace:
> [ 5807.486365]  in_lookup_hashtable+0x13c8/0x2020
> [ 5807.486368]  rcu_core+0x408/0x5b0
> [ 5807.486371]  rcu_core_si+0x18/0x30
> [ 5807.486373]  __do_softirq+0x2e0/0xed0
> [ 5807.486376]  ____do_softirq+0x18/0x30
> [ 5807.486379]  call_on_irq_stack+0x24/0x30
> [ 5807.486384]  do_softirq_own_stack+0x24/0x38
> [ 5807.486386]  __irq_exit_rcu+0x1f8/0x580
> [ 5807.486391]  irq_exit_rcu+0x1c/0x90
> [ 5807.486393]  el1_interrupt+0x4c/0xb0
> [ 5807.486398]  el1h_64_irq_handler+0x18/0x28
> [ 5807.486400]  el1h_64_irq+0x78/0x80
> [ 5807.486402]  arch_local_irq_enable+0x8/0x20
> [ 5807.486406]  cpuidle_idle_call+0x26c/0x370
> [ 5807.486409]  do_idle+0x1ac/0x208
> [ 5807.486411]  cpu_startup_entry+0x2c/0x40
> [ 5807.486413]  secondary_start_kernel+0x240/0x360
> [ 5807.486417]  __secondary_switched+0xb8/0xc0
> [ 5807.486423] Code: 00000000 00000000 00000000 00000000 (f4ba4418)
> [ 5807.486426] ---[ end trace 0000000000000000 ]---
> [ 5807.486428] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> [ 5807.486430] SMP: stopping secondary CPUs
> [ 5807.486467] Kernel Offset: 0x36620d560000 from 0xffff800080000000
> [ 5807.486469] PHYS_OFFSET: 0x40000000
> [ 5807.486470] CPU features: 0x00000001,70020143,1001720b
> [ 5807.486472] Memory Limit: none
> 
