Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0307B114B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjI1DmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjI1DmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:42:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786FACE7;
        Wed, 27 Sep 2023 20:42:01 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwzkQ3sTHzrT5J;
        Thu, 28 Sep 2023 11:39:42 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 28 Sep 2023 11:41:58 +0800
Message-ID: <e426bab8-66cb-636d-1ad1-4b9537bc2bae@huawei.com>
Date:   Thu, 28 Sep 2023 11:41:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/4] fpga: add a platform driver to the FPGA Manager test
 suite
Content-Language: en-US
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
References: <20230926163911.66114-1-marpagan@redhat.com>
 <20230926163911.66114-3-marpagan@redhat.com>
 <6535a42b-d3e7-12d4-e986-7e1aa472d321@huawei.com>
 <b359905a-0684-359d-62b6-d3707696c6bf@redhat.com>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <b359905a-0684-359d-62b6-d3707696c6bf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/9/28 0:56, Marco Pagani wrote:
> 
> 
> On 2023-09-27 04:55, Ruan Jinjie wrote:
>>
>>
>> On 2023/9/27 0:39, Marco Pagani wrote:
>>> Register a minimal platform driver associated with the parent platform
>>> device used for testing to prevent a null-ptr-deref when try_module_get()
>>> is called by fpga_mgr_get().
>>>
>>> Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
>>> Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>> ---
>>>  drivers/fpga/tests/fpga-mgr-test.c | 18 +++++++++++++++++-
>>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
>>> index 6acec55b60ce..30de474d7def 100644
>>> --- a/drivers/fpga/tests/fpga-mgr-test.c
>>> +++ b/drivers/fpga/tests/fpga-mgr-test.c
>>> @@ -14,6 +14,8 @@
>>>  #include <linux/scatterlist.h>
>>>  #include <linux/types.h>
>>>  
>>> +#include "fpga-test-helpers.h"
>>> +
>>>  #define HEADER_FILL		'H'
>>>  #define IMAGE_FILL		'P'
>>>  #define IMAGE_BLOCK		1024
>>> @@ -277,6 +279,18 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
>>>  	sg_free_table(ctx->img_info->sgt);
>>>  }
>>>  
>>> +TEST_PLATFORM_DRIVER(test_platform_driver);
>>> +
>>> +static int fpga_mgr_test_suite_init(struct kunit_suite *suite)
>>> +{
>>> +	return platform_driver_register(&test_platform_driver);
>>
>> modprobe fpga-mgr-test and there is still a null-ptr-deref.
> 
> 
> These issues appear to be caused by your commit 2810c1e99867 ("kunit: Fix
> wild-memory-access bug in kunit_free_suite_set()") that causes all test
> suites to run while modules are still in MODULE_STATE_COMING. In that
> state, modules are not yet fully initialized lacking sysfs' kobjects
> and hence causing module_add_driver() to fail.

Right! it is the commit's issue.

> 
> You can test it by running the FPGA suites on a kernel before commit
> 2810c1e99867. I sent an RFC patch to restore the normal execution
> flow and use the refcount to avoid calling kunit_free_suite_set() if
> load_module() fails.

I have a more elegant way to fix it, which split the init func into 2
parts and use the return error code to avoid check whether free is
empty. I'll send it sooner.

> 
> Thanks,
> Marco
> 
> 
>>
>> root@syzkaller:~# modprobe fpga-mgr-test
>> [   45.088127] KTAP version 1
>> [   45.088354] 1..1
>> [   45.089520] ------------[ cut here ]------------
>> [   45.089861] kobject: '(null)' (ffffffffa02121d0): is not initialized,
>> yet kobject_get() is being called.
>> [   45.090608] WARNING: CPU: 1 PID: 1862 at lib/kobject.c:637
>> kobject_get+0x98/0xe0
>> [   45.091209] Modules linked in: fpga_mgr_test(+)
>> [   45.091581] CPU: 1 PID: 1862 Comm: modprobe Tainted: G
>>  N 6.6.0-rc3+ #54
>> [   45.092201] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.15.0-1 04/01/2014
>> [   45.092870] RIP: 0010:kobject_get+0x98/0xe0
>> [   45.093200] Code: 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03
>> 80 3c 02 00 75 44 49 8b 34 24 4c 89 e2 48 c7 c7 20 63 ac 84 e8 38 fe 24
>> fd <0f> 0b eb a2 48 89 ef be 01 00 00 00 e8 d7 de a4 fe 4c 89 e0 5d 41
>> [   45.094653] RSP: 0018:ffff8881062f7298 EFLAGS: 00010286
>> [   45.095086] RAX: 0000000000000000 RBX: ffffffff848a3660 RCX:
>> 0000000000000000
>> [   45.095649] RDX: 0000000000000002 RSI: ffffffff847b4d40 RDI:
>> 0000000000000001
>> [   45.096205] RBP: ffff888101b6d840 R08: 0000000000000001 R09:
>> ffffed1020c5ee12
>> [   45.096761] R10: ffff8881062f7097 R11: 3a7463656a626f6b R12:
>> ffffffffa02121d0
>> [   45.097315] R13: ffff888101b6d858 R14: ffffffffa02121d0 R15:
>> ffff88810661aca0
>> [   45.097863] FS:  00007fabf4c34540(0000) GS:ffff888119c80000(0000)
>> knlGS:0000000000000000
>> [   45.098485] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   45.098933] CR2: 000055578ca04e20 CR3: 000000010ac0e006 CR4:
>> 0000000000770ee0
>> [   45.099497] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   45.100054] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   45.100615] PKRU: 55555554
>> [   45.100833] Call Trace:
>> [   45.101034]  <TASK>
>> [   45.101206]  ? __warn+0xc9/0x260
>> [   45.101480]  ? irq_work_queue+0x35/0x50
>> [   45.101786]  ? kobject_get+0x98/0xe0
>> [   45.102073]  ? report_bug+0x345/0x400
>> [   45.102377]  ? handle_bug+0x3c/0x70
>> [   45.102661]  ? exc_invalid_op+0x14/0x40
>> [   45.102968]  ? asm_exc_invalid_op+0x16/0x20
>> [   45.103317]  ? kobject_get+0x98/0xe0
>> [   45.103604]  ? kobject_get+0x98/0xe0
>> [   45.103892]  kobject_add_internal+0x9e/0x870
>> [   45.104235]  kobject_add+0x120/0x1f0
>> [   45.104535]  ? kset_create_and_add+0x160/0x160
>> [   45.104892]  ? __kmem_cache_alloc_node+0x1d2/0x350
>> [   45.105269]  ? _raw_spin_lock+0x87/0xe0
>> [   45.105586]  ? kobject_create_and_add+0x3c/0xb0
>> [   45.105948]  kobject_create_and_add+0x68/0xb0
>> [   45.106303]  module_add_driver+0x260/0x350
>> [   45.106635]  bus_add_driver+0x2c9/0x580
>> [   45.106941]  driver_register+0x133/0x460
>> [   45.107284]  kunit_run_tests+0xdb/0xef0
>> [   45.107599]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.107962]  ? __sched_text_end+0xa/0xa
>> [   45.108284]  ? _raw_spin_unlock_irqrestore+0x42/0x80
>> [   45.108675]  ? __kunit_test_suites_exit+0x80/0x80
>> [   45.109045]  ? set_track_prepare+0x8a/0xd0
>> [   45.109380]  ? get_object+0x70/0x70
>> [   45.109658]  ? alloc_inode+0x12a/0x1e0
>> [   45.109960]  ? new_inode+0x14/0x230
>> [   45.110238]  ? __debugfs_create_file+0xc8/0x5d0
>> [   45.110607]  ? __kunit_test_suites_init+0x73/0x140
>> [   45.110982]  ? kunit_module_notify+0x3ab/0x440
>> [   45.111341]  ? notifier_call_chain+0xbf/0x280
>> [   45.111688]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.112045]  ? __sched_text_end+0xa/0xa
>> [   45.112362]  ? projid_m_show+0x200/0x200
>> [   45.112671]  ? kasan_set_track+0x21/0x30
>> [   45.112974]  ? _raw_spin_lock+0x87/0xe0
>> [   45.113290]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.113615]  ? _raw_spin_lock+0x87/0xe0
>> [   45.113914]  ? __d_instantiate+0x1d5/0x3b0
>> [   45.114232]  ? alloc_inode+0x72/0x1e0
>> [   45.114535]  ? up_write+0x6d/0xa0
>> [   45.114803]  ? __debugfs_create_file+0x3b5/0x5d0
>> [   45.115180]  __kunit_test_suites_init+0xde/0x140
>> [   45.115557]  kunit_module_notify+0x3ab/0x440
>> [   45.115895]  ? __kunit_test_suites_init+0x140/0x140
>> [   45.116287]  ? preempt_count_add+0x79/0x150
>> [   45.116623]  notifier_call_chain+0xbf/0x280
>> [   45.116953]  ? kasan_quarantine_put+0x21/0x1a0
>> [   45.117311]  blocking_notifier_call_chain_robust+0xbb/0x140
>> [   45.117747]  ? notifier_call_chain+0x280/0x280
>> [   45.118097]  ? 0xffffffffa0208000
>> [   45.118372]  load_module+0x4af0/0x67d0
>> [   45.118671]  ? module_frob_arch_sections+0x20/0x20
>> [   45.119057]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
>> [   45.119476]  ? kernel_read_file+0x3ca/0x510
>> [   45.119807]  ? __x64_sys_fspick+0x2a0/0x2a0
>> [   45.120134]  ? init_module_from_file+0xd2/0x130
>> [   45.120499]  init_module_from_file+0xd2/0x130
>> [   45.120843]  ? __ia32_sys_init_module+0xa0/0xa0
>> [   45.121203]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
>> [   45.121589]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.121916]  idempotent_init_module+0x339/0x610
>> [   45.122286]  ? init_module_from_file+0x130/0x130
>> [   45.122648]  ? __fget_light+0x57/0x500
>> [   45.122950]  __x64_sys_finit_module+0xba/0x130
>> [   45.123323]  do_syscall_64+0x35/0x80
>> [   45.123607]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [   45.124001] RIP: 0033:0x7fabf471b839
>> [   45.124303] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
>> [   45.125754] RSP: 002b:00007ffd1f377128 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000139
>> [   45.126359] RAX: ffffffffffffffda RBX: 000055578e370e10 RCX:
>> 00007fabf471b839
>> [   45.126921] RDX: 0000000000000000 RSI: 000055578ca1bc2e RDI:
>> 0000000000000003
>> [   45.127505] RBP: 000055578ca1bc2e R08: 0000000000000000 R09:
>> 000055578e373210
>> [   45.128057] R10: 0000000000000003 R11: 0000000000000246 R12:
>> 0000000000000000
>> [   45.128621] R13: 000055578e370f30 R14: 0000000000040000 R15:
>> 000055578e370e10
>> [   45.129183]  </TASK>
>> [   45.129376] ---[ end trace 0000000000000000 ]---
>> [   45.129744] ------------[ cut here ]------------
>> [   45.130109] refcount_t: addition on 0; use-after-free.
>> [   45.130555] WARNING: CPU: 1 PID: 1862 at lib/refcount.c:25
>> refcount_warn_saturate+0x120/0x190
>> [   45.131214] Modules linked in: fpga_mgr_test(+)
>> [   45.131588] CPU: 1 PID: 1862 Comm: modprobe Tainted: G        W
>>  N 6.6.0-rc3+ #54
>> [   45.132205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.15.0-1 04/01/2014
>> [   45.132854] RIP: 0010:refcount_warn_saturate+0x120/0x190
>> [   45.133262] Code: 1d bc 3f 40 0a 80 fb 01 0f 87 5a f8 67 01 83 e3 01
>> 0f 85 5d ff ff ff 48 c7 c7 e0 99 7a 84 c6 05 9c 3f 40 0a 01 e8 30 1e 80
>> fe <0f> 0b e9 43 ff ff ff 0f b6 1d 86 3f 40 0a 80 fb 01 0f 87 4f f8 67
>> [   45.134712] RSP: 0018:ffff8881062f7280 EFLAGS: 00010286
>> [   45.135138] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [   45.135698] RDX: 0000000000000002 RSI: ffffffff847b4d40 RDI:
>> 0000000000000001
>> [   45.136244] RBP: 0000000000000002 R08: 0000000000000001 R09:
>> ffffed1020c5ee0f
>> [   45.136804] R10: ffff8881062f707f R11: 746e756f63666572 R12:
>> ffffffffa02121d0
>> [   45.137367] R13: ffff888101b6d858 R14: ffffffffa02121d0 R15:
>> ffff88810661aca0
>> [   45.137919] FS:  00007fabf4c34540(0000) GS:ffff888119c80000(0000)
>> knlGS:0000000000000000
>> [   45.138551] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   45.139007] CR2: 000055578ca04e20 CR3: 000000010ac0e006 CR4:
>> 0000000000770ee0
>> [   45.139566] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   45.140116] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   45.140669] PKRU: 55555554
>> [   45.140882] Call Trace:
>> [   45.141084]  <TASK>
>> [   45.141254]  ? __warn+0xc9/0x260
>> [   45.141520]  ? refcount_warn_saturate+0x120/0x190
>> [   45.141889]  ? report_bug+0x345/0x400
>> [   45.142176]  ? handle_bug+0x3c/0x70
>> [   45.142461]  ? exc_invalid_op+0x14/0x40
>> [   45.142767]  ? asm_exc_invalid_op+0x16/0x20
>> [   45.143101]  ? refcount_warn_saturate+0x120/0x190
>> [   45.143474]  kobject_get+0xbd/0xe0
>> [   45.143745]  kobject_add_internal+0x9e/0x870
>> [   45.144084]  kobject_add+0x120/0x1f0
>> [   45.144378]  ? kset_create_and_add+0x160/0x160
>> [   45.144732]  ? __kmem_cache_alloc_node+0x1d2/0x350
>> [   45.145109]  ? _raw_spin_lock+0x87/0xe0
>> [   45.145426]  ? kobject_create_and_add+0x3c/0xb0
>> [   45.145787]  kobject_create_and_add+0x68/0xb0
>> [   45.146130]  module_add_driver+0x260/0x350
>> [   45.146465]  bus_add_driver+0x2c9/0x580
>> [   45.146762]  driver_register+0x133/0x460
>> [   45.147084]  kunit_run_tests+0xdb/0xef0
>> [   45.147404]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.147754]  ? __sched_text_end+0xa/0xa
>> [   45.148056]  ? _raw_spin_unlock_irqrestore+0x42/0x80
>> [   45.148456]  ? __kunit_test_suites_exit+0x80/0x80
>> [   45.148817]  ? set_track_prepare+0x8a/0xd0
>> [   45.149145]  ? get_object+0x70/0x70
>> [   45.149425]  ? alloc_inode+0x12a/0x1e0
>> [   45.149716]  ? new_inode+0x14/0x230
>> [   45.149989]  ? __debugfs_create_file+0xc8/0x5d0
>> [   45.150347]  ? __kunit_test_suites_init+0x73/0x140
>> [   45.150724]  ? kunit_module_notify+0x3ab/0x440
>> [   45.151074]  ? notifier_call_chain+0xbf/0x280
>> [   45.151420]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.151772]  ? __sched_text_end+0xa/0xa
>> [   45.152079]  ? projid_m_show+0x200/0x200
>> [   45.152403]  ? kasan_set_track+0x21/0x30
>> [   45.152712]  ? _raw_spin_lock+0x87/0xe0
>> [   45.153010]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.153333]  ? _raw_spin_lock+0x87/0xe0
>> [   45.153635]  ? __d_instantiate+0x1d5/0x3b0
>> [   45.153953]  ? alloc_inode+0x72/0x1e0
>> [   45.154235]  ? up_write+0x6d/0xa0
>> [   45.154509]  ? __debugfs_create_file+0x3b5/0x5d0
>> [   45.154869]  __kunit_test_suites_init+0xde/0x140
>> [   45.155222]  kunit_module_notify+0x3ab/0x440
>> [   45.155560]  ? __kunit_test_suites_init+0x140/0x140
>> [   45.155938]  ? preempt_count_add+0x79/0x150
>> [   45.156259]  notifier_call_chain+0xbf/0x280
>> [   45.156591]  ? kasan_quarantine_put+0x21/0x1a0
>> [   45.156937]  blocking_notifier_call_chain_robust+0xbb/0x140
>> [   45.157371]  ? notifier_call_chain+0x280/0x280
>> [   45.157713]  ? 0xffffffffa0208000
>> [   45.157967]  load_module+0x4af0/0x67d0
>> [   45.158255]  ? module_frob_arch_sections+0x20/0x20
>> [   45.158630]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
>> [   45.159025]  ? kernel_read_file+0x3ca/0x510
>> [   45.159353]  ? __x64_sys_fspick+0x2a0/0x2a0
>> [   45.159673]  ? init_module_from_file+0xd2/0x130
>> [   45.160014]  init_module_from_file+0xd2/0x130
>> [   45.160356]  ? __ia32_sys_init_module+0xa0/0xa0
>> [   45.160702]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
>> [   45.161058]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.161386]  idempotent_init_module+0x339/0x610
>> [   45.161727]  ? init_module_from_file+0x130/0x130
>> [   45.162081]  ? __fget_light+0x57/0x500
>> [   45.162378]  __x64_sys_finit_module+0xba/0x130
>> [   45.162720]  do_syscall_64+0x35/0x80
>> [   45.162989]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [   45.163380] RIP: 0033:0x7fabf471b839
>> [   45.163655] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
>> [   45.165049] RSP: 002b:00007ffd1f377128 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000139
>> [   45.165627] RAX: ffffffffffffffda RBX: 000055578e370e10 RCX:
>> 00007fabf471b839
>> [   45.166168] RDX: 0000000000000000 RSI: 000055578ca1bc2e RDI:
>> 0000000000000003
>> [   45.166733] RBP: 000055578ca1bc2e R08: 0000000000000000 R09:
>> 000055578e373210
>> [   45.167297] R10: 0000000000000003 R11: 0000000000000246 R12:
>> 0000000000000000
>> [   45.167847] R13: 000055578e370f30 R14: 0000000000040000 R15:
>> 000055578e370e10
>> [   45.168404]  </TASK>
>> [   45.168579] ---[ end trace 0000000000000000 ]---
>> [   45.168952] general protection fault, probably for non-canonical
>> address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
>> [   45.169771] KASAN: null-ptr-deref in range
>> [0x0000000000000018-0x000000000000001f]
>> [   45.170336] CPU: 1 PID: 1862 Comm: modprobe Tainted: G        W
>>  N 6.6.0-rc3+ #54
>> [   45.170935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.15.0-1 04/01/2014
>> [   45.171562] RIP: 0010:kobject_namespace+0x71/0x150
>> [   45.171933] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
>> b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
>> 03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
>> [   45.173324] RSP: 0018:ffff8881062f7288 EFLAGS: 00010206
>> [   45.173716] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [   45.174245] RDX: 0000000000000003 RSI: ffffffff847b4d40 RDI:
>> 0000000000000018
>> [   45.174777] RBP: ffff888101b6d840 R08: 0000000000000001 R09:
>> ffffed1020c5ee0f
>> [   45.175317] R10: ffff8881062f707f R11: 746e756f63666572 R12:
>> ffffffffa02121d0
>> [   45.175847] R13: ffff888101b6d858 R14: ffff888101b6d868 R15:
>> ffffffff84ac7020
>> [   45.176377] FS:  00007fabf4c34540(0000) GS:ffff888119c80000(0000)
>> knlGS:0000000000000000
>> [   45.176977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   45.177413] CR2: 000055578ca04e20 CR3: 000000010ac0e006 CR4:
>> 0000000000770ee0
>> [   45.177946] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   45.178479] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   45.179016] PKRU: 55555554
>> [   45.179227] Call Trace:
>> [   45.179418]  <TASK>
>> [   45.179584]  ? die_addr+0x3d/0xa0
>> [   45.179843]  ? exc_general_protection+0x144/0x220
>> [   45.180202]  ? asm_exc_general_protection+0x22/0x30
>> [   45.180570]  ? kobject_namespace+0x71/0x150
>> [   45.180886]  kobject_add_internal+0x267/0x870
>> [   45.181221]  kobject_add+0x120/0x1f0
>> [   45.181497]  ? kset_create_and_add+0x160/0x160
>> [   45.181828]  ? __kmem_cache_alloc_node+0x1d2/0x350
>> [   45.182188]  ? _raw_spin_lock+0x87/0xe0
>> [   45.182480]  ? kobject_create_and_add+0x3c/0xb0
>> [   45.182822]  kobject_create_and_add+0x68/0xb0
>> [   45.183159]  module_add_driver+0x260/0x350
>> [   45.183472]  bus_add_driver+0x2c9/0x580
>> [   45.183764]  driver_register+0x133/0x460
>> [   45.184061]  kunit_run_tests+0xdb/0xef0
>> [   45.184354]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.184700]  ? __sched_text_end+0xa/0xa
>> [   45.184993]  ? _raw_spin_unlock_irqrestore+0x42/0x80
>> [   45.185365]  ? __kunit_test_suites_exit+0x80/0x80
>> [   45.185718]  ? set_track_prepare+0x8a/0xd0
>> [   45.186027]  ? get_object+0x70/0x70
>> [   45.186296]  ? alloc_inode+0x12a/0x1e0
>> [   45.186578]  ? new_inode+0x14/0x230
>> [   45.186848]  ? __debugfs_create_file+0xc8/0x5d0
>> [   45.187199]  ? __kunit_test_suites_init+0x73/0x140
>> [   45.187563]  ? kunit_module_notify+0x3ab/0x440
>> [   45.187905]  ? notifier_call_chain+0xbf/0x280
>> [   45.188232]  ? _raw_spin_lock_irqsave+0x8d/0xe0
>> [   45.188574]  ? __sched_text_end+0xa/0xa
>> [   45.188862]  ? projid_m_show+0x200/0x200
>> [   45.189158]  ? kasan_set_track+0x21/0x30
>> [   45.189457]  ? _raw_spin_lock+0x87/0xe0
>> [   45.189747]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.190054]  ? _raw_spin_lock+0x87/0xe0
>> [   45.190345]  ? __d_instantiate+0x1d5/0x3b0
>> [   45.190657]  ? alloc_inode+0x72/0x1e0
>> [   45.190935]  ? up_write+0x6d/0xa0
>> [   45.191191]  ? __debugfs_create_file+0x3b5/0x5d0
>> [   45.191545]  __kunit_test_suites_init+0xde/0x140
>> [   45.191904]  kunit_module_notify+0x3ab/0x440
>> [   45.192226]  ? __kunit_test_suites_init+0x140/0x140
>> [   45.192601]  ? preempt_count_add+0x79/0x150
>> [   45.192927]  notifier_call_chain+0xbf/0x280
>> [   45.193244]  ? kasan_quarantine_put+0x21/0x1a0
>> [   45.193586]  blocking_notifier_call_chain_robust+0xbb/0x140
>> [   45.194015]  ? notifier_call_chain+0x280/0x280
>> [   45.194360]  ? 0xffffffffa0208000
>> [   45.194614]  load_module+0x4af0/0x67d0
>> [   45.194909]  ? module_frob_arch_sections+0x20/0x20
>> [   45.195274]  ? rwsem_down_write_slowpath+0x11a0/0x11a0
>> [   45.195672]  ? kernel_read_file+0x3ca/0x510
>> [   45.195997]  ? __x64_sys_fspick+0x2a0/0x2a0
>> [   45.196319]  ? init_module_from_file+0xd2/0x130
>> [   45.196675]  init_module_from_file+0xd2/0x130
>> [   45.197006]  ? __ia32_sys_init_module+0xa0/0xa0
>> [   45.197352]  ? userfaultfd_unmap_prep+0x3d0/0x3d0
>> [   45.197724]  ? _raw_spin_lock_bh+0xe0/0xe0
>> [   45.198044]  idempotent_init_module+0x339/0x610
>> [   45.198392]  ? init_module_from_file+0x130/0x130
>> [   45.198748]  ? __fget_light+0x57/0x500
>> [   45.199043]  __x64_sys_finit_module+0xba/0x130
>> [   45.199389]  do_syscall_64+0x35/0x80
>> [   45.199664]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>> [   45.200050] RIP: 0033:0x7fabf471b839
>> [   45.200325] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
>> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 89 01 48
>> [   45.201713] RSP: 002b:00007ffd1f377128 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000139
>> [   45.202278] RAX: ffffffffffffffda RBX: 000055578e370e10 RCX:
>> 00007fabf471b839
>> [   45.202816] RDX: 0000000000000000 RSI: 000055578ca1bc2e RDI:
>> 0000000000000003
>> [   45.203348] RBP: 000055578ca1bc2e R08: 0000000000000000 R09:
>> 000055578e373210
>> [   45.203886] R10: 0000000000000003 R11: 0000000000000246 R12:
>> 0000000000000000
>> [   45.204426] R13: 000055578e370f30 R14: 0000000000040000 R15:
>> 000055578e370e10
>> [   45.204962]  </TASK>
>> [   45.205140] Modules linked in: fpga_mgr_test(+)
>> [   45.205500] Dumping ftrace buffer:
>> [   45.205768]    (ftrace buffer empty)
>> [   45.206066] ---[ end trace 0000000000000000 ]---
>> [   45.206477] RIP: 0010:kobject_namespace+0x71/0x150
>> [   45.206850] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 cd 00 00 00 48
>> b8 00 00 00 00 00 fc ff df 49 8b 5c 24 28 48 8d 7b 18 48 89 fa 48 c1 ea
>> 03 <80> 3c 02 00 0f 85 c1 00 00 00 48 8b 43 18 48 85 c0 74 79 4c 89 e7
>> [   45.208501] RSP: 0018:ffff8881062f7288 EFLAGS: 00010206
>> [   45.209015] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> [   45.209708] RDX: 0000000000000003 RSI: ffffffff847b4d40 RDI:
>> 0000000000000018
>> [   45.210473] RBP: ffff888101b6d840 R08: 0000000000000001 R09:
>> ffffed1020c5ee0f
>> [   45.211142] R10: ffff8881062f707f R11: 746e756f63666572 R12:
>> ffffffffa02121d0
>> [   45.211898] R13: ffff888101b6d858 R14: ffff888101b6d868 R15:
>> ffffffff84ac7020
>> [   45.212653] FS:  00007fabf4c34540(0000) GS:ffff888119c80000(0000)
>> knlGS:0000000000000000
>> [   45.213441] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   45.213970] CR2: 000055578ca04e20 CR3: 000000010ac0e006 CR4:
>> 0000000000770ee0
>> [   45.214716] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [   45.215424] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [   45.216089] PKRU: 55555554
>> [   45.216440] Kernel panic - not syncing: Fatal exception
>> [   45.217935] Dumping ftrace buffer:
>> [   45.218195]    (ftrace buffer empty)
>> [   45.218473] Kernel Offset: disabled
>> [   45.218740] Rebooting in 1 seconds..
>>
>>> +}
>>> +
>>> +static void fpga_mgr_test_suite_exit(struct kunit_suite *suite)
>>> +{
>>> +	platform_driver_unregister(&test_platform_driver);
>>> +}
>>> +
>>>  static int fpga_mgr_test_init(struct kunit *test)
>>>  {
>>>  	struct mgr_ctx *ctx;
>>> @@ -284,7 +298,7 @@ static int fpga_mgr_test_init(struct kunit *test)
>>>  	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>>>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>>>  
>>> -	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
>>> +	ctx->pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
>>>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
>>>  
>>>  	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
>>> @@ -317,6 +331,8 @@ static struct kunit_case fpga_mgr_test_cases[] = {
>>>  
>>>  static struct kunit_suite fpga_mgr_suite = {
>>>  	.name = "fpga_mgr",
>>> +	.suite_init = fpga_mgr_test_suite_init,
>>> +	.suite_exit = fpga_mgr_test_suite_exit,
>>>  	.init = fpga_mgr_test_init,
>>>  	.exit = fpga_mgr_test_exit,
>>>  	.test_cases = fpga_mgr_test_cases,
>>
> 
