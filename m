Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF597AF8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjI0Dgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjI0D2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 23:28:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6051BCF;
        Tue, 26 Sep 2023 19:58:22 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwLpX5h9KzrSDS;
        Wed, 27 Sep 2023 10:56:04 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 27 Sep 2023 10:58:19 +0800
Message-ID: <512f2079-6fcb-f2c5-d64d-d0e124cd2853@huawei.com>
Date:   Wed, 27 Sep 2023 10:58:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] fpga: add a platform driver to the FPGA Region test
 suite
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230926163911.66114-1-marpagan@redhat.com>
 <20230926163911.66114-5-marpagan@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230926163911.66114-5-marpagan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/27 0:39, Marco Pagani wrote:
> Register a minimal platform driver associated with the parent platform
> device used for testing to prevent a null-ptr-deref when try_module_get()
> is called by fpga_region_get(). Also, fix a typo in the suite's name.
> 
> Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-region-test.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> index 9f9d50ee7871..5ff688b394f9 100644
> --- a/drivers/fpga/tests/fpga-region-test.c
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -15,6 +15,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
>  
> +#include "fpga-test-helpers.h"
> +
>  struct mgr_stats {
>  	u32 write_count;
>  };
> @@ -132,6 +134,18 @@ static void fpga_region_test_program_fpga(struct kunit *test)
>  	fpga_image_info_free(img_info);
>  }
>  
> +TEST_PLATFORM_DRIVER(test_platform_driver);
> +
> +static int fpga_region_test_suite_init(struct kunit_suite *suite)
> +{
> +	return platform_driver_register(&test_platform_driver);

modprobe fpga-region-test and then there is still a null-ptr-deref.

root@syzkaller:~# modprobe fpga-region-test
[   39.603646] KTAP version 1
[   39.603866] 1..1
[   39.604574] ------------[ cut here ]------------
[   39.604921] kobject: '(null)' (ffffffffa0271490): is not initialized,
yet kobject_get() is being called.
[   39.605842] WARNING: CPU: 3 PID: 1862 at lib/kobject.c:637
kobject_get+0x98/0xe0
[   39.606445] Modules linked in: fpga_region_test(+) fpga_region
fpga_bridge
[   39.607000] CPU: 3 PID: 1862 Comm: modprobe Tainted: G
 N 6.6.0-rc3+ #54
[   39.607640] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   39.608304] RIP: 0010:kobject_get+0x98/0xe0
[   39.608651] Code: 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03
80 3c 02 00 75 44 49 8b 34 24 4c 89 e2 48 c7 c7 20 63 ac 84 e8 38 fe 24
fd <0f> 0b eb a2 48 89 ef be 01 00 00 00 e8 d7 de a4 fe 4c 89 e0 5d 41
[   39.610140] RSP: 0018:ffff888106f87298 EFLAGS: 00010286
[   39.610583] RAX: 0000000000000000 RBX: ffffffff848a3660 RCX:
0000000000000000
[   39.611153] RDX: 0000000000000002 RSI: ffffffff847b4d40 RDI:
0000000000000001
[   39.611736] RBP: ffff888106002740 R08: 0000000000000001 R09:
ffffed1020df0e12
[   39.612298] R10: ffff888106f87097 R11: 3a7463656a626f6b R12:
ffffffffa0271490
[   39.612882] R13: ffff888106002758 R14: ffffffffa0271490 R15:
ffff88810b6a9798
[   39.613458] FS:  00007fecca45a540(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
[   39.614079] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.614542] CR2: 00007ffe202a0f58 CR3: 000000010ba75004 CR4:
0000000000770ee0
[   39.615110] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.615680] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.616227] PKRU: 55555554
[   39.616456] Call Trace:
[   39.616652]  <TASK>
[   39.616825]  ? __warn+0xc9/0x260
[   39.617085]  ? irq_work_queue+0x35/0x50
[   39.617410]  ? kobject_get+0x98/0xe0
[   39.617711]  ? report_bug+0x345/0x400
[   39.618002]  ? handle_bug+0x3c/0x70
[   39.618278]  ? exc_invalid_op+0x14/0x40
[   39.618596]  ? asm_exc_invalid_op+0x16/0x20
[   39.618926]  ? kobject_get+0x98/0xe0
[   39.619208]  ? kobject_get+0x98/0xe0
[   39.619510]  kobject_add_internal+0x9e/0x870
[   39.619850]  kobject_add+0x120/0x1f0
[   39.620138]  ? kset_create_and_add+0x160/0x160
[   39.620500]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   39.620881]  ? _raw_spin_lock+0x87/0xe0
[   39.621185]  ? kobject_create_and_add+0x3c/0xb0
[   39.621566]  kobject_create_and_add+0x68/0xb0
[   39.621913]  module_add_driver+0x260/0x350
[   39.622237]  bus_add_driver+0x2c9/0x580
[   39.622556]  driver_register+0x133/0x460
[   39.622867]  kunit_run_tests+0xdb/0xef0
[   39.623169]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.623540]  ? __sched_text_end+0xa/0xa
[   39.623845]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   39.624230]  ? __kunit_test_suites_exit+0x80/0x80
[   39.624615]  ? set_track_prepare+0x8a/0xd0
[   39.624935]  ? get_object+0x70/0x70
[   39.625212]  ? alloc_inode+0x12a/0x1e0
[   39.625541]  ? new_inode+0x14/0x230
[   39.625818]  ? __debugfs_create_file+0xc8/0x5d0
[   39.626178]  ? __kunit_test_suites_init+0x73/0x140
[   39.626577]  ? kunit_module_notify+0x3ab/0x440
[   39.626925]  ? notifier_call_chain+0xbf/0x280
[   39.627274]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.627647]  ? __sched_text_end+0xa/0xa
[   39.627958]  ? projid_m_show+0x200/0x200
[   39.628279]  ? kasan_set_track+0x21/0x30
[   39.628607]  ? _raw_spin_lock+0x87/0xe0
[   39.628911]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.629238]  ? _raw_spin_lock+0x87/0xe0
[   39.629566]  ? __d_instantiate+0x1d5/0x3b0
[   39.629894]  ? alloc_inode+0x72/0x1e0
[   39.630197]  ? up_write+0x6d/0xa0
[   39.630506]  ? __debugfs_create_file+0x3b5/0x5d0
[   39.630881]  __kunit_test_suites_init+0xde/0x140
[   39.631248]  kunit_module_notify+0x3ab/0x440
[   39.631602]  ? __kunit_test_suites_init+0x140/0x140
[   39.631985]  ? preempt_count_add+0x79/0x150
[   39.632319]  notifier_call_chain+0xbf/0x280
[   39.632665]  ? kasan_quarantine_put+0x21/0x1a0
[   39.633020]  blocking_notifier_call_chain_robust+0xbb/0x140
[   39.633470]  ? notifier_call_chain+0x280/0x280
[   39.633828]  ? 0xffffffffa0268000
[   39.634099]  load_module+0x4af0/0x67d0
[   39.634402]  ? module_frob_arch_sections+0x20/0x20
[   39.634795]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   39.635200]  ? kernel_read_file+0x3ca/0x510
[   39.635549]  ? __x64_sys_fspick+0x2a0/0x2a0
[   39.635884]  ? init_module_from_file+0xd2/0x130
[   39.636237]  init_module_from_file+0xd2/0x130
[   39.636591]  ? __ia32_sys_init_module+0xa0/0xa0
[   39.636948]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   39.637318]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.637663]  idempotent_init_module+0x339/0x610
[   39.638022]  ? init_module_from_file+0x130/0x130
[   39.638390]  ? __fget_light+0x57/0x500
[   39.638711]  __x64_sys_finit_module+0xba/0x130
[   39.639066]  do_syscall_64+0x35/0x80
[   39.639355]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   39.639771] RIP: 0033:0x7fecc9f1b839
[   39.640065] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   39.641519] RSP: 002b:00007ffe202a4038 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   39.642105] RAX: ffffffffffffffda RBX: 000055fe429e7d20 RCX:
00007fecc9f1b839
[   39.642679] RDX: 0000000000000000 RSI: 000055fe4081bc2e RDI:
0000000000000005
[   39.643236] RBP: 000055fe4081bc2e R08: 0000000000000000 R09:
000055fe429e7d20
[   39.643807] R10: 0000000000000005 R11: 0000000000000246 R12:
0000000000000000
[   39.644370] R13: 000055fe429e7e90 R14: 0000000000040000 R15:
000055fe429e7d20
[   39.644943]  </TASK>
[   39.645122] ---[ end trace 0000000000000000 ]---
[   39.645513] ------------[ cut here ]------------
[   39.645876] refcount_t: addition on 0; use-after-free.
[   39.646301] WARNING: CPU: 3 PID: 1862 at lib/refcount.c:25
refcount_warn_saturate+0x120/0x190
[   39.646992] Modules linked in: fpga_region_test(+) fpga_region
fpga_bridge
[   39.647551] CPU: 3 PID: 1862 Comm: modprobe Tainted: G        W
 N 6.6.0-rc3+ #54
[   39.648193] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   39.648868] RIP: 0010:refcount_warn_saturate+0x120/0x190
[   39.649287] Code: 1d bc 3f 40 0a 80 fb 01 0f 87 5a f8 67 01 83 e3 01
0f 85 5d ff ff ff 48 c7 c7 e0 99 7a 84 c6 05 9c 3f 40 0a 01 e8 30 1e 80
fe <0f> 0b e9 43 ff ff ff 0f b6 1d 86 3f 40 0a 80 fb 01 0f 87 4f f8 67
[   39.650771] RSP: 0018:ffff888106f87280 EFLAGS: 00010286
[   39.651185] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   39.651766] RDX: 0000000000000002 RSI: 0000000000000004 RDI:
0000000000000001
[   39.652328] RBP: 0000000000000002 R08: 0000000000000001 R09:
ffffed10233b4ef1
[   39.652902] R10: ffff888119da778b R11: 746e756f63666572 R12:
ffffffffa0271490
[   39.653483] R13: ffff888106002758 R14: ffffffffa0271490 R15:
ffff88810b6a9798
[   39.654041] FS:  00007fecca45a540(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
[   39.654697] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.655155] CR2: 00007ffe202a0f58 CR3: 000000010ba75004 CR4:
0000000000770ee0
[   39.655746] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.656312] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.656894] PKRU: 55555554
[   39.657116] Call Trace:
[   39.657319]  <TASK>
[   39.657516]  ? __warn+0xc9/0x260
[   39.657782]  ? refcount_warn_saturate+0x120/0x190
[   39.658158]  ? report_bug+0x345/0x400
[   39.658467]  ? handle_bug+0x3c/0x70
[   39.658760]  ? exc_invalid_op+0x14/0x40
[   39.659069]  ? asm_exc_invalid_op+0x16/0x20
[   39.659405]  ? refcount_warn_saturate+0x120/0x190
[   39.659806]  kobject_get+0xbd/0xe0
[   39.660088]  kobject_add_internal+0x9e/0x870
[   39.660441]  kobject_add+0x120/0x1f0
[   39.660747]  ? kset_create_and_add+0x160/0x160
[   39.661108]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   39.661512]  ? _raw_spin_lock+0x87/0xe0
[   39.661820]  ? kobject_create_and_add+0x3c/0xb0
[   39.662184]  kobject_create_and_add+0x68/0xb0
[   39.662554]  module_add_driver+0x260/0x350
[   39.662890]  bus_add_driver+0x2c9/0x580
[   39.663207]  driver_register+0x133/0x460
[   39.663547]  kunit_run_tests+0xdb/0xef0
[   39.663866]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.664232]  ? __sched_text_end+0xa/0xa
[   39.664560]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   39.664960]  ? __kunit_test_suites_exit+0x80/0x80
[   39.665343]  ? set_track_prepare+0x8a/0xd0
[   39.665702]  ? get_object+0x70/0x70
[   39.665985]  ? alloc_inode+0x12a/0x1e0
[   39.666294]  ? new_inode+0x14/0x230
[   39.666600]  ? __debugfs_create_file+0xc8/0x5d0
[   39.666970]  ? __kunit_test_suites_init+0x73/0x140
[   39.667359]  ? kunit_module_notify+0x3ab/0x440
[   39.667742]  ? notifier_call_chain+0xbf/0x280
[   39.668093]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.668478]  ? __sched_text_end+0xa/0xa
[   39.668796]  ? projid_m_show+0x200/0x200
[   39.669115]  ? kasan_set_track+0x21/0x30
[   39.669459]  ? _raw_spin_lock+0x87/0xe0
[   39.669773]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.670106]  ? _raw_spin_lock+0x87/0xe0
[   39.670419]  ? __d_instantiate+0x1d5/0x3b0
[   39.670766]  ? alloc_inode+0x72/0x1e0
[   39.671070]  ? up_write+0x6d/0xa0
[   39.671344]  ? __debugfs_create_file+0x3b5/0x5d0
[   39.671738]  __kunit_test_suites_init+0xde/0x140
[   39.672122]  kunit_module_notify+0x3ab/0x440
[   39.672487]  ? __kunit_test_suites_init+0x140/0x140
[   39.672890]  ? preempt_count_add+0x79/0x150
[   39.673232]  notifier_call_chain+0xbf/0x280
[   39.673588]  ? kasan_quarantine_put+0x21/0x1a0
[   39.673953]  blocking_notifier_call_chain_robust+0xbb/0x140
[   39.674395]  ? notifier_call_chain+0x280/0x280
[   39.674785]  ? 0xffffffffa0268000
[   39.675061]  load_module+0x4af0/0x67d0
[   39.675377]  ? module_frob_arch_sections+0x20/0x20
[   39.675786]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   39.676209]  ? kernel_read_file+0x3ca/0x510
[   39.676565]  ? __x64_sys_fspick+0x2a0/0x2a0
[   39.676908]  ? init_module_from_file+0xd2/0x130
[   39.677277]  init_module_from_file+0xd2/0x130
[   39.677668]  ? __ia32_sys_init_module+0xa0/0xa0
[   39.678041]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   39.678437]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.678784]  idempotent_init_module+0x339/0x610
[   39.679156]  ? init_module_from_file+0x130/0x130
[   39.679556]  ? __fget_light+0x57/0x500
[   39.679870]  __x64_sys_finit_module+0xba/0x130
[   39.680237]  do_syscall_64+0x35/0x80
[   39.680553]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   39.680973] RIP: 0033:0x7fecc9f1b839
[   39.681271] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   39.682793] RSP: 002b:00007ffe202a4038 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   39.683399] RAX: ffffffffffffffda RBX: 000055fe429e7d20 RCX:
00007fecc9f1b839
[   39.683993] RDX: 0000000000000000 RSI: 000055fe4081bc2e RDI:
0000000000000005
[   39.684584] RBP: 000055fe4081bc2e R08: 0000000000000000 R09:
000055fe429e7d20
[   39.685160] R10: 0000000000000005 R11: 0000000000000246 R12:
0000000000000000
[   39.685760] R13: 000055fe429e7e90 R14: 0000000000040000 R15:
000055fe429e7d20
[   39.686337]  </TASK>
[   39.686537] ---[ end trace 0000000000000000 ]---
[   39.686924] general protection fault, probably for non-canonical
address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
[   39.687789] KASAN: null-ptr-deref in range
[0x0000000000000018-0x000000000000001f]
[   39.688397] CPU: 3 PID: 1862 Comm: modprobe Tainted: G        W
 N 6.6.0-rc3+ #54
[   39.689054] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.15.0-1 04/01/2014
[   39.689741] RIP: 0010:kobject_namespace+0x71/0x150
[   39.690141] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
[   39.691661] RSP: 0018:ffff888106f87288 EFLAGS: 00010206
[   39.692087] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   39.692683] RDX: 0000000000000003 RSI: 0000000000000004 RDI:
0000000000000018
[   39.693275] RBP: ffff888106002740 R08: 0000000000000001 R09:
ffffed10233b4ef1
[   39.693882] R10: ffff888119da778b R11: 746e756f63666572 R12:
ffffffffa0271490
[   39.694465] R13: ffff888106002758 R14: ffff888106002768 R15:
ffffffff84ac7020
[   39.695044] FS:  00007fecca45a540(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
[   39.695703] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.696180] CR2: 00007ffe202a0f58 CR3: 000000010ba75004 CR4:
0000000000770ee0
[   39.696770] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.697346] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.697955] PKRU: 55555554
[   39.698180] Call Trace:
[   39.698386]  <TASK>
[   39.698577]  ? die_addr+0x3d/0xa0
[   39.698861]  ? exc_general_protection+0x144/0x220
[   39.699253]  ? asm_exc_general_protection+0x22/0x30
[   39.699667]  ? kobject_namespace+0x71/0x150
[   39.700016]  kobject_add_internal+0x267/0x870
[   39.700396]  kobject_add+0x120/0x1f0
[   39.700708]  ? kset_create_and_add+0x160/0x160
[   39.701087]  ? __kmem_cache_alloc_node+0x1d2/0x350
[   39.701506]  ? _raw_spin_lock+0x87/0xe0
[   39.701839]  ? kobject_create_and_add+0x3c/0xb0
[   39.702223]  kobject_create_and_add+0x68/0xb0
[   39.702604]  module_add_driver+0x260/0x350
[   39.702954]  bus_add_driver+0x2c9/0x580
[   39.703284]  driver_register+0x133/0x460
[   39.703627]  kunit_run_tests+0xdb/0xef0
[   39.703955]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.704342]  ? __sched_text_end+0xa/0xa
[   39.704693]  ? _raw_spin_unlock_irqrestore+0x42/0x80
[   39.705108]  ? __kunit_test_suites_exit+0x80/0x80
[   39.705533]  ? set_track_prepare+0x8a/0xd0
[   39.705880]  ? get_object+0x70/0x70
[   39.706181]  ? alloc_inode+0x12a/0x1e0
[   39.706505]  ? new_inode+0x14/0x230
[   39.706809]  ? __debugfs_create_file+0xc8/0x5d0
[   39.707188]  ? __kunit_test_suites_init+0x73/0x140
[   39.707597]  ? kunit_module_notify+0x3ab/0x440
[   39.707980]  ? notifier_call_chain+0xbf/0x280
[   39.708354]  ? _raw_spin_lock_irqsave+0x8d/0xe0
[   39.708750]  ? __sched_text_end+0xa/0xa
[   39.709085]  ? projid_m_show+0x200/0x200
[   39.709423]  ? kasan_set_track+0x21/0x30
[   39.709761]  ? _raw_spin_lock+0x87/0xe0
[   39.710094]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.710443]  ? _raw_spin_lock+0x87/0xe0
[   39.710773]  ? __d_instantiate+0x1d5/0x3b0
[   39.711131]  ? alloc_inode+0x72/0x1e0
[   39.711458]  ? up_write+0x6d/0xa0
[   39.711753]  ? __debugfs_create_file+0x3b5/0x5d0
[   39.712150]  __kunit_test_suites_init+0xde/0x140
[   39.712557]  kunit_module_notify+0x3ab/0x440
[   39.712943]  ? __kunit_test_suites_init+0x140/0x140
[   39.713385]  ? preempt_count_add+0x79/0x150
[   39.713761]  notifier_call_chain+0xbf/0x280
[   39.714118]  ? kasan_quarantine_put+0x21/0x1a0
[   39.714511]  blocking_notifier_call_chain_robust+0xbb/0x140
[   39.714994]  ? notifier_call_chain+0x280/0x280
[   39.715374]  ? 0xffffffffa0268000
[   39.715688]  load_module+0x4af0/0x67d0
[   39.716021]  ? module_frob_arch_sections+0x20/0x20
[   39.716435]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
[   39.716893]  ? kernel_read_file+0x3ca/0x510
[   39.717267]  ? __x64_sys_fspick+0x2a0/0x2a0
[   39.717648]  ? init_module_from_file+0xd2/0x130
[   39.718042]  init_module_from_file+0xd2/0x130
[   39.718418]  ? __ia32_sys_init_module+0xa0/0xa0
[   39.718832]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
[   39.719237]  ? _raw_spin_lock_bh+0xe0/0xe0
[   39.719608]  idempotent_init_module+0x339/0x610
[   39.720006]  ? init_module_from_file+0x130/0x130
[   39.720418]  ? __fget_light+0x57/0x500
[   39.720760]  __x64_sys_finit_module+0xba/0x130
[   39.721160]  do_syscall_64+0x35/0x80
[   39.721488]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[   39.721931] RIP: 0033:0x7fecc9f1b839
[   39.722236] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
[   39.723816] RSP: 002b:00007ffe202a4038 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   39.724470] RAX: ffffffffffffffda RBX: 000055fe429e7d20 RCX:
00007fecc9f1b839
[   39.725091] RDX: 0000000000000000 RSI: 000055fe4081bc2e RDI:
0000000000000005
[   39.725719] RBP: 000055fe4081bc2e R08: 0000000000000000 R09:
000055fe429e7d20
[   39.726337] R10: 0000000000000005 R11: 0000000000000246 R12:
0000000000000000
[   39.726966] R13: 000055fe429e7e90 R14: 0000000000040000 R15:
000055fe429e7d20
[   39.727604]  </TASK>
[   39.727804] Modules linked in: fpga_region_test(+) fpga_region
fpga_bridge
[   39.728401] Dumping ftrace buffer:
[   39.728719]    (ftrace buffer empty)
[   39.729058] ---[ end trace 0000000000000000 ]---
[   39.729539] RIP: 0010:kobject_namespace+0x71/0x150
[   39.729967] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
[   39.731622] RSP: 0018:ffff888106f87288 EFLAGS: 00010206
[   39.732076] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
0000000000000000
[   39.732745] RDX: 0000000000000003 RSI: 0000000000000004 RDI:
0000000000000018
[   39.733381] RBP: ffff888106002740 R08: 0000000000000001 R09:
ffffed10233b4ef1
[   39.734054] R10: ffff888119da778b R11: 746e756f63666572 R12:
ffffffffa0271490
[   39.734696] R13: ffff888106002758 R14: ffff888106002768 R15:
ffffffff84ac7020
[   39.735318] FS:  00007fecca45a540(0000) GS:ffff888119d80000(0000)
knlGS:0000000000000000
[   39.736022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   39.736542] CR2: 00007ffe202a0f58 CR3: 000000010ba75004 CR4:
0000000000770ee0
[   39.737170] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   39.737818] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   39.738446] PKRU: 55555554
[   39.738695] Kernel panic - not syncing: Fatal exception
[   39.739930] Dumping ftrace buffer:
[   39.740176]    (ftrace buffer empty)
[   39.740485] Kernel Offset: disabled
[   39.740794] Rebooting in 1 seconds..


> +}
> +
> +static void fpga_region_test_suite_exit(struct kunit_suite *suite)
> +{
> +	platform_driver_unregister(&test_platform_driver);
> +}
> +
>  /*
>   * The configuration used in this test suite uses a single bridge to
>   * limit the code under test to a single unit. The functions used by the
> @@ -146,14 +160,15 @@ static int fpga_region_test_init(struct kunit *test)
>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>  
> -	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	ctx->mgr_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
> +							NULL, 0);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
>  
>  	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
>  					  &ctx->mgr_stats);
>  	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
>  
> -	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
> +	ctx->bridge_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
>  							   NULL, 0);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
>  
> @@ -163,7 +178,7 @@ static int fpga_region_test_init(struct kunit *test)
>  
>  	ctx->bridge_stats.enable = true;
>  
> -	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
> +	ctx->region_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
>  							   NULL, 0);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
>  
> @@ -195,12 +210,13 @@ static void fpga_region_test_exit(struct kunit *test)
>  static struct kunit_case fpga_region_test_cases[] = {
>  	KUNIT_CASE(fpga_region_test_class_find),
>  	KUNIT_CASE(fpga_region_test_program_fpga),
> -
>  	{}
>  };
>  
>  static struct kunit_suite fpga_region_suite = {
> -	.name = "fpga_mgr",
> +	.name = "fpga_region",
> +	.suite_init = fpga_region_test_suite_init,
> +	.suite_exit = fpga_region_test_suite_exit,
>  	.init = fpga_region_test_init,
>  	.exit = fpga_region_test_exit,
>  	.test_cases = fpga_region_test_cases,
