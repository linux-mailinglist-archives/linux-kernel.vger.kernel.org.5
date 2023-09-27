Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012A07AF8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjI0D1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjI0DZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:25:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A5493C4;
        Tue, 26 Sep 2023 19:52:24 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RwLgg75kmz15NV9;
        Wed, 27 Sep 2023 10:50:07 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 10:52:22 +0800
Message-ID: <1c645b06-4d46-8991-889e-5a63801a974a@huawei.com>
Date:   Wed, 27 Sep 2023 10:52:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] fpga: add a platform driver to the FPGA Bridge test
 suite
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230926163911.66114-1-marpagan@redhat.com>
 <20230926163911.66114-4-marpagan@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230926163911.66114-4-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/27 0:39, Marco Pagani wrote:
> Register a minimal platform driver associated with the parent platform
> device used for testing to prevent a null-ptr-deref when try_module_get()
> is called by __fpga_bridge_get().
> 
> Fixes: 9e6823481e5f ("fpga: add an initial KUnit suite for the FPGA Bridge")
> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-bridge-test.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
> index 1d258002cdd7..4bd4ecaa7e90 100644
> --- a/drivers/fpga/tests/fpga-bridge-test.c
> +++ b/drivers/fpga/tests/fpga-bridge-test.c
> @@ -13,6 +13,8 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  
> +#include "fpga-test-helpers.h"
> +
>  struct bridge_stats {
>  	bool enable;
>  };
> @@ -53,7 +55,7 @@ static struct bridge_ctx *register_test_bridge(struct kunit *test)
>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>  
> -	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	ctx->pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
>  
>  	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
> @@ -144,6 +146,18 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
>  	unregister_test_bridge(ctx_1);
>  }
>  
> +TEST_PLATFORM_DRIVER(test_platform_driver);
> +
> +static int fpga_bridge_test_suite_init(struct kunit_suite *suite)
> +{
> +	return platform_driver_register(&test_platform_driver);

modprobe fpga-bridge-test and there is still a null-ptr-deref.

root@syzkaller:~# modprobe fpga-bridge-test
[   33.870688] KTAP version 1
[   33.870897] 1..1
[   33.871947] ------------[ cut here ]------------
[   33.872287] kobject: '(null)' (ffffffffa0241990): is not initialized,
yet kobject_get() is being called.
[   33.873267] WARNING: CPU: 6 PID: 1860 at lib/kobject.c:637
kobject_get+0x98/0xe0
[   33.873884] Modules linked in: fpga_bridge_test(+) fpga_bridge
[   33.874368] CPU: 6 PID: 1860 Comm: modprobe Tainted: G
 N 6.6.0-rc3+ #54
[   33.875023] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   33.875700] RIP: 0010:kobject_get+0x98/0xe0
[   33.876044] Code: 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03
80 3c 02 00 75 44 49 8b 34 24 4c 89 e2 48 c7 c7 20 63 ac 84 e8 38 fe 24
fd <0f> 0b eb a2 48 89 ef be 01 00 00 00 e8 d7 de a4 fe 4c 89 e0 5d 41
[   33.877527] RSP: 0018:ffff88810df6f298 EFLAGS: 00010286
[   33.877951] RAX: 0000000000000000 RBX: ffffffff848a3660 RCX:
0000000000000000
[   33.878538] RDX: 0000000000000002 RSI: ffffffff847b4d40 RDI:
0000000000000001
[   33.879100] RBP: ffff88810c83cd40 R08: 0000000000000001 R09:
ffffed1021bede12
[   33.879687] R10: ffff88810df6f097 R11: 3a7463656a626f6b R12:
ffffffffa0241990
[   33.880235] R13: ffff88810c83cd58 R14: ffffffffa0241990 R15:
ffff888106502dd8
[   33.880790] FS:  00007f27dd761540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[   33.881437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.881886] CR2: 00007ffc270848b8 CR3: 0000000106d73006 CR4:
0000000000770ee0
[   33.882452] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   33.883001] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   33.883557] PKRU: 55555554
[   33.883777] Call Trace:
[   33.883975]  <TASK>
[   33.884151]  ? __warn+0xc9/0x260
[   33.884424]  ? irq_work_queue+0x35/0x50
[   33.884728]  ? kobject_get+0x98/0xe0
[   33.885010]  ? report_bug+0x345/0x400
[   33.885304]  ? handle_bug+0x3c/0x70
[   33.885602]  ? exc_invalid_op+0x14/0x40
[   33.885900]  ? asm_exc_invalid_op+0x16/0x20
[   33.886224]  ? kobject_get+0x98/0xe0
[   33.886518]  ? kobject_get+0x98/0xe0
[   33.886813]  kobject_add_internal+0x9e/0x870
[   33.887148]  kobject_add+0x120/0x1f0
[   33.887444]  ? kset_create_and_add+0x160/0x160
[   33.887796]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   33.888171]  ? _raw_spin_lock+0x87/0xe0
[   33.888480]  ? kobject_create_and_add+0x3c/0xb0
[   33.888836]  kobject_create_and_add+0x68/0xb0
[   33.889183]  module_add_driver+0x260/0x350
[   33.889515]  bus_add_driver+0x2c9/0x580
[   33.889818]  driver_register+0x133/0x460
[   33.890128]  kunit_run_tests+0xdb/0xef0
[   33.890440]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.890802]  ? __sched_text_end+0xa/0xa
[   33.891108]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   33.891508]  ? __kunit_test_suites_exit+0x80/0x80
[   33.891875]  ? set_track_prepare+0x8a/0xd0
[   33.892192]  ? get_object+0x70/0x70
[   33.892479]  ? alloc_inode+0x12a/0x1e0
[   33.892780]  ? new_inode+0x14/0x230
[   33.893056]  ? __debugfs_create_file+0xc8/0x5d0
[   33.893424]  ? __kunit_test_suites_init+0x73/0x140
[   33.893804]  ? kunit_module_notify+0x3ab/0x440
[   33.894157]  ? notifier_call_chain+0xbf/0x280
[   33.894512]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.894873]  ? __sched_text_end+0xa/0xa
[   33.895178]  ? projid_m_show+0x200/0x200
[   33.895496]  ? kasan_set_track+0x21/0x30
[   33.895803]  ? _raw_spin_lock+0x87/0xe0
[   33.896101]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.896434]  ? _raw_spin_lock+0x87/0xe0
[   33.896733]  ? __d_instantiate+0x1d5/0x3b0
[   33.897055]  ? alloc_inode+0x72/0x1e0
[   33.897356]  ? up_write+0x6d/0xa0
[   33.897623]  ? __debugfs_create_file+0x3b5/0x5d0
[   33.897988]  __kunit_test_suites_init+0xde/0x140
[   33.898357]  kunit_module_notify+0x3ab/0x440
[   33.898701]  ? __kunit_test_suites_init+0x140/0x140
[   33.899084]  ? preempt_count_add+0x79/0x150
[   33.899428]  notifier_call_chain+0xbf/0x280
[   33.899757]  ? kasan_quarantine_put+0x21/0x1a0
[   33.900107]  blocking_notifier_call_chain_robust+0xbb/0x140
[   33.900549]  ? notifier_call_chain+0x280/0x280
[   33.900895]  ? 0xffffffffa0238000
[   33.901158]  load_module+0x4af0/0x67d0
[   33.901471]  ? module_frob_arch_sections+0x20/0x20
[   33.901842]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   33.902244]  ? kernel_read_file+0x3ca/0x510
[   33.902591]  ? __x64_sys_fspick+0x2a0/0x2a0
[   33.902921]  ? init_module_from_file+0xd2/0x130
[   33.903271]  init_module_from_file+0xd2/0x130
[   33.903621]  ? __ia32_sys_init_module+0xa0/0xa0
[   33.903977]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   33.904352]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.904674]  idempotent_init_module+0x339/0x610
[   33.905028]  ? init_module_from_file+0x130/0x130
[   33.905405]  ? __fget_light+0x57/0x500
[   33.905700]  __x64_sys_finit_module+0xba/0x130
[   33.906046]  do_syscall_64+0x35/0x80
[   33.906342]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   33.906743] RIP: 0033:0x7f27dd11b839
[   33.907026] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   33.908447] RSP: 002b:00007ffc27087998 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   33.909022] RAX: ffffffffffffffda RBX: 00005645642bed20 RCX:
00007f27dd11b839
[   33.909578] RDX: 0000000000000000 RSI: 000056456321bc2e RDI:
0000000000000004
[   33.910114] RBP: 000056456321bc2e R08: 0000000000000000 R09:
00005645642bed20
[   33.910670] R10: 0000000000000004 R11: 0000000000000246 R12:
0000000000000000
[   33.911219] R13: 00005645642bee90 R14: 0000000000040000 R15:
00005645642bed20
[   33.911770]  </TASK>
[   33.911947] ---[ end trace 0000000000000000 ]---
[   33.912307] ------------[ cut here ]------------
[   33.912679] refcount_t: addition on 0; use-after-free.
[   33.913097] WARNING: CPU: 6 PID: 1860 at lib/refcount.c:25
refcount_warn_saturate+0x120/0x190
[   33.913757] Modules linked in: fpga_bridge_test(+) fpga_bridge
[   33.914207] CPU: 6 PID: 1860 Comm: modprobe Tainted: G        W
 N 6.6.0-rc3+ #54
[   33.914834] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   33.915487] RIP: 0010:refcount_warn_saturate+0x120/0x190
[   33.915891] Code: 1d bc 3f 40 0a 80 fb 01 0f 87 5a f8 67 01 83 e3 01
0f 85 5d ff ff ff 48 c7 c7 e0 99 7a 84 c6 05 9c 3f 40 0a 01 e8 30 1e 80
fe <0f> 0b e9 43 ff ff ff 0f b6 1d 86 3f 40 0a 80 fb 01 0f 87 4f f8 67
[   33.917299] RSP: 0018:ffff88810df6f280 EFLAGS: 00010286
[   33.917717] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   33.918265] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
0000000000000001
[   33.918816] RBP: 0000000000000002 R08: 0000000000000001 R09:
ffffed10233e4ef1
[   33.919372] R10: ffff888119f2778b R11: 746e756f63666572 R12:
ffffffffa0241990
[   33.919913] R13: ffff88810c83cd58 R14: ffffffffa0241990 R15:
ffff888106502dd8
[   33.920462] FS:  00007f27dd761540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[   33.921066] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.921513] CR2: 00007ffc270848b8 CR3: 0000000106d73006 CR4:
0000000000770ee0
[   33.922059] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   33.922621] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   33.923163] PKRU: 55555554
[   33.923386] Call Trace:
[   33.923581]  <TASK>
[   33.923753]  ? __warn+0xc9/0x260
[   33.924008]  ? refcount_warn_saturate+0x120/0x190
[   33.924381]  ? report_bug+0x345/0x400
[   33.924668]  ? handle_bug+0x3c/0x70
[   33.924942]  ? exc_invalid_op+0x14/0x40
[   33.925241]  ? asm_exc_invalid_op+0x16/0x20
[   33.925576]  ? refcount_warn_saturate+0x120/0x190
[   33.925942]  kobject_get+0xbd/0xe0
[   33.926208]  kobject_add_internal+0x9e/0x870
[   33.926552]  kobject_add+0x120/0x1f0
[   33.926841]  ? kset_create_and_add+0x160/0x160
[   33.927186]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   33.927568]  ? _raw_spin_lock+0x87/0xe0
[   33.927871]  ? kobject_create_and_add+0x3c/0xb0
[   33.928226]  kobject_create_and_add+0x68/0xb0
[   33.928581]  module_add_driver+0x260/0x350
[   33.928905]  bus_add_driver+0x2c9/0x580
[   33.929204]  driver_register+0x133/0x460
[   33.929521]  kunit_run_tests+0xdb/0xef0
[   33.929821]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.930177]  ? __sched_text_end+0xa/0xa
[   33.930491]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   33.930888]  ? __kunit_test_suites_exit+0x80/0x80
[   33.931253]  ? set_track_prepare+0x8a/0xd0
[   33.931582]  ? get_object+0x70/0x70
[   33.931853]  ? alloc_inode+0x12a/0x1e0
[   33.932149]  ? new_inode+0x14/0x230
[   33.932433]  ? __debugfs_create_file+0xc8/0x5d0
[   33.932785]  ? __kunit_test_suites_init+0x73/0x140
[   33.933149]  ? kunit_module_notify+0x3ab/0x440
[   33.933511]  ? notifier_call_chain+0xbf/0x280
[   33.933856]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.934209]  ? __sched_text_end+0xa/0xa
[   33.934519]  ? projid_m_show+0x200/0x200
[   33.934831]  ? kasan_set_track+0x21/0x30
[   33.935135]  ? _raw_spin_lock+0x87/0xe0
[   33.935447]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.935768]  ? _raw_spin_lock+0x87/0xe0
[   33.936068]  ? __d_instantiate+0x1d5/0x3b0
[   33.936398]  ? alloc_inode+0x72/0x1e0
[   33.936691]  ? up_write+0x6d/0xa0
[   33.936953]  ? __debugfs_create_file+0x3b5/0x5d0
[   33.937325]  __kunit_test_suites_init+0xde/0x140
[   33.937689]  kunit_module_notify+0x3ab/0x440
[   33.938027]  ? __kunit_test_suites_init+0x140/0x140
[   33.938417]  ? preempt_count_add+0x79/0x150
[   33.938751]  notifier_call_chain+0xbf/0x280
[   33.939071]  ? kasan_quarantine_put+0x21/0x1a0
[   33.939428]  blocking_notifier_call_chain_robust+0xbb/0x140
[   33.939860]  ? notifier_call_chain+0x280/0x280
[   33.940207]  ? 0xffffffffa0238000
[   33.940483]  load_module+0x4af0/0x67d0
[   33.940783]  ? module_frob_arch_sections+0x20/0x20
[   33.941153]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   33.941562]  ? kernel_read_file+0x3ca/0x510
[   33.941889]  ? __x64_sys_fspick+0x2a0/0x2a0
[   33.942213]  ? init_module_from_file+0xd2/0x130
[   33.942584]  init_module_from_file+0xd2/0x130
[   33.942928]  ? __ia32_sys_init_module+0xa0/0xa0
[   33.943276]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   33.943653]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.943971]  idempotent_init_module+0x339/0x610
[   33.944331]  ? init_module_from_file+0x130/0x130
[   33.944691]  ? __fget_light+0x57/0x500
[   33.944987]  __x64_sys_finit_module+0xba/0x130
[   33.945343]  do_syscall_64+0x35/0x80
[   33.945624]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   33.946011] RIP: 0033:0x7f27dd11b839
[   33.946292] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   33.947694] RSP: 002b:00007ffc27087998 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   33.948267] RAX: ffffffffffffffda RBX: 00005645642bed20 RCX:
00007f27dd11b839
[   33.948815] RDX: 0000000000000000 RSI: 000056456321bc2e RDI:
0000000000000004
[   33.949366] RBP: 000056456321bc2e R08: 0000000000000000 R09:
00005645642bed20
[   33.949905] R10: 0000000000000004 R11: 0000000000000246 R12:
0000000000000000
[   33.950463] R13: 00005645642bee90 R14: 0000000000040000 R15:
00005645642bed20
[   33.951014]  </TASK>
[   33.951188] ---[ end trace 0000000000000000 ]---
[   33.951561] general protection fault, probably for non-canonical
address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
[   33.952381] KASAN: null-ptr-deref in range
[0x0000000000000018-0x000000000000001f]
[   33.952952] CPU: 6 PID: 1860 Comm: modprobe Tainted: G        W
 N 6.6.0-rc3+ #54
[   33.953554] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   33.954178] RIP: 0010:kobject_namespace+0x71/0x150
[   33.954546] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
[   33.955934] RSP: 0018:ffff88810df6f288 EFLAGS: 00010206
[   33.956330] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   33.956869] RDX: 0000000000000003 RSI: 0000000000000004 RDI:
0000000000000018
[   33.957411] RBP: ffff88810c83cd40 R08: 0000000000000001 R09:
ffffed10233e4ef1
[   33.957949] R10: ffff888119f2778b R11: 746e756f63666572 R12:
ffffffffa0241990
[   33.958486] R13: ffff88810c83cd58 R14: ffff88810c83cd68 R15:
ffffffff84ac7020
[   33.959030] FS:  00007f27dd761540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[   33.959642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.960079] CR2: 00007ffc270848b8 CR3: 0000000106d73006 CR4:
0000000000770ee0
[   33.960616] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   33.961145] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   33.961682] PKRU: 55555554
[   33.961890] Call Trace:
[   33.962081]  <TASK>
[   33.962247]  ? die_addr+0x3d/0xa0
[   33.962511]  ? exc_general_protection+0x144/0x220
[   33.962876]  ? asm_exc_general_protection+0x22/0x30
[   33.963244]  ? kobject_namespace+0x71/0x150
[   33.963570]  kobject_add_internal+0x267/0x870
[   33.963908]  kobject_add+0x120/0x1f0
[   33.964185]  ? kset_create_and_add+0x160/0x160
[   33.964528]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   33.964896]  ? _raw_spin_lock+0x87/0xe0
[   33.965192]  ? kobject_create_and_add+0x3c/0xb0
[   33.965544]  kobject_create_and_add+0x68/0xb0
[   33.965877]  module_add_driver+0x260/0x350
[   33.966197]  bus_add_driver+0x2c9/0x580
[   33.966502]  driver_register+0x133/0x460
[   33.966812]  kunit_run_tests+0xdb/0xef0
[   33.967106]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.967457]  ? __sched_text_end+0xa/0xa
[   33.967756]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   33.968127]  ? __kunit_test_suites_exit+0x80/0x80
[   33.968489]  ? set_track_prepare+0x8a/0xd0
[   33.968810]  ? get_object+0x70/0x70
[   33.969078]  ? alloc_inode+0x12a/0x1e0
[   33.969371]  ? new_inode+0x14/0x230
[   33.969644]  ? __debugfs_create_file+0xc8/0x5d0
[   33.969992]  ? __kunit_test_suites_init+0x73/0x140
[   33.970365]  ? kunit_module_notify+0x3ab/0x440
[   33.970711]  ? notifier_call_chain+0xbf/0x280
[   33.971044]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   33.971399]  ? __sched_text_end+0xa/0xa
[   33.971701]  ? projid_m_show+0x200/0x200
[   33.972009]  ? kasan_set_track+0x21/0x30
[   33.972313]  ? _raw_spin_lock+0x87/0xe0
[   33.972614]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.972931]  ? _raw_spin_lock+0x87/0xe0
[   33.973221]  ? __d_instantiate+0x1d5/0x3b0
[   33.973537]  ? alloc_inode+0x72/0x1e0
[   33.973819]  ? up_write+0x6d/0xa0
[   33.974075]  ? __debugfs_create_file+0x3b5/0x5d0
[   33.974431]  __kunit_test_suites_init+0xde/0x140
[   33.974794]  kunit_module_notify+0x3ab/0x440
[   33.975123]  ? __kunit_test_suites_init+0x140/0x140
[   33.975499]  ? preempt_count_add+0x79/0x150
[   33.975825]  notifier_call_chain+0xbf/0x280
[   33.976146]  ? kasan_quarantine_put+0x21/0x1a0
[   33.976498]  blocking_notifier_call_chain_robust+0xbb/0x140
[   33.976919]  ? notifier_call_chain+0x280/0x280
[   33.977262]  ? 0xffffffffa0238000
[   33.977527]  load_module+0x4af0/0x67d0
[   33.977822]  ? module_frob_arch_sections+0x20/0x20
[   33.978190]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   33.978592]  ? kernel_read_file+0x3ca/0x510
[   33.978920]  ? __x64_sys_fspick+0x2a0/0x2a0
[   33.979244]  ? init_module_from_file+0xd2/0x130
[   33.979595]  init_module_from_file+0xd2/0x130
[   33.979932]  ? __ia32_sys_init_module+0xa0/0xa0
[   33.980278]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   33.980642]  ? _raw_spin_lock_bh+0xe0/0xe0
[   33.980958]  idempotent_init_module+0x339/0x610
[   33.981311]  ? init_module_from_file+0x130/0x130
[   33.981671]  ? __fget_light+0x57/0x500
[   33.981965]  __x64_sys_finit_module+0xba/0x130
[   33.982307]  do_syscall_64+0x35/0x80
[   33.982596]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   33.982977] RIP: 0033:0x7f27dd11b839
[   33.983250] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   33.984642] RSP: 002b:00007ffc27087998 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   33.985206] RAX: ffffffffffffffda RBX: 00005645642bed20 RCX:
00007f27dd11b839
[   33.985738] RDX: 0000000000000000 RSI: 000056456321bc2e RDI:
0000000000000004
[   33.986272] RBP: 000056456321bc2e R08: 0000000000000000 R09:
00005645642bed20
[   33.986830] R10: 0000000000000004 R11: 0000000000000246 R12:
0000000000000000
[   33.987381] R13: 00005645642bee90 R14: 0000000000040000 R15:
00005645642bed20
[   33.987926]  </TASK>
[   33.988098] Modules linked in: fpga_bridge_test(+) fpga_bridge
[   33.988551] Dumping ftrace buffer:
[   33.988814]    (ftrace buffer empty)
[   33.989107] ---[ end trace 0000000000000000 ]---
[   33.989516] RIP: 0010:kobject_namespace+0x71/0x150
[   33.989886] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
[   33.991715] RSP: 0018:ffff88810df6f288 EFLAGS: 00010206
[   33.992201] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   33.992989] RDX: 0000000000000003 RSI: 0000000000000004 RDI:
0000000000000018
[   33.993614] RBP: ffff88810c83cd40 R08: 0000000000000001 R09:
ffffed10233e4ef1
[   33.994373] R10: ffff888119f2778b R11: 746e756f63666572 R12:
ffffffffa0241990
[   33.995091] R13: ffff88810c83cd58 R14: ffff88810c83cd68 R15:
ffffffff84ac7020
[   33.995829] FS:  00007f27dd761540(0000) GS:ffff888119f00000(0000)
knlGS:0000000000000000
[   33.996640] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.997246] CR2: 00007ffc270848b8 CR3: 0000000106d73006 CR4:
0000000000770ee0
[   33.997971] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   33.998673] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   33.999414] PKRU: 55555554
[   33.999678] Kernel panic - not syncing: Fatal exception
[   34.001019] Dumping ftrace buffer:
[   34.001286]    (ftrace buffer empty)
[   34.001561] Kernel Offset: disabled
[   34.001829] Rebooting in 1 seconds..


> +}
> +
> +static void fpga_bridge_test_suite_exit(struct kunit_suite *suite)
> +{
> +	platform_driver_unregister(&test_platform_driver);
> +}
> +
>  static int fpga_bridge_test_init(struct kunit *test)
>  {
>  	test->priv = register_test_bridge(test);
> @@ -165,6 +179,8 @@ static struct kunit_case fpga_bridge_test_cases[] = {
>  
>  static struct kunit_suite fpga_bridge_suite = {
>  	.name = "fpga_bridge",
> +	.suite_init = fpga_bridge_test_suite_init,
> +	.suite_exit = fpga_bridge_test_suite_exit,
>  	.init = fpga_bridge_test_init,
>  	.exit = fpga_bridge_test_exit,
>  	.test_cases = fpga_bridge_test_cases,
