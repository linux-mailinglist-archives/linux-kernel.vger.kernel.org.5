Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722EE7AE325
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjIZA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjIZA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:56:12 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0643B3;
        Mon, 25 Sep 2023 17:56:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RvhBL6tmYz4f3jsm;
        Tue, 26 Sep 2023 08:55:54 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgDnfd0aLBJlpZ2bBQ--.24070S3;
        Tue, 26 Sep 2023 08:55:55 +0800 (CST)
Subject: Re: [PATCH -next v2 00/28] md: synchronize io with array
 reconfiguration
To:     Song Liu <song@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
 <CAPhsuW4-L+u6--do0W8shPF63kcw28N6-k5iPcuQwUJtiCbWRw@mail.gmail.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <89fffc6b-f156-bcda-0a82-f1a73d885b01@huaweicloud.com>
Date:   Tue, 26 Sep 2023 08:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW4-L+u6--do0W8shPF63kcw28N6-k5iPcuQwUJtiCbWRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDnfd0aLBJlpZ2bBQ--.24070S3
X-Coremail-Antispam: 1UD129KBjvAXoW3Zr45tw43KFyxJFy5Zw1kXwb_yoW8Jw4Uuo
        WUJw1fCr4rGrn8JF1fJr4DJryUWr1DJFZ7tr12kr4DCFs7GrWUtFyUGr18Jr4jqF45CF9I
        yr13Kr95G348GFs7n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYg7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
        0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
        sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/09/25 23:45, Song Liu 写道:
> Hi Kuai,
> 
> Thanks for the patchset!
> 
> I have got the following panic with mdadm test 23rdev-lifetime.
> Could you please look into it?
> 
> I pushed the test code to this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=md-test-28

Thanks for the test, I know where the problem is now, mddev is
dereferenced before the null checking.

I'll fix this in the next version.

Thanks,
Kuai

> 
> Thanks,
> Song
> 
> 
> [  173.143010] ==================================================================
> [  173.144256] BUG: KASAN: null-ptr-deref in __mutex_lock+0xc0/0x920
> [  173.145232] Read of size 8 at addr 00000000000000a8 by task test/1215
> [  173.146138]
> [  173.146375] CPU: 26 PID: 1215 Comm: test Not tainted 6.6.0-rc2+ #8
> [  173.147254] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [  173.148840] Call Trace:
> [  173.149202]  <TASK>
> [  173.149531]  dump_stack_lvl+0xb5/0x100
> [  173.150093]  ? __pfx_dump_stack_lvl+0x10/0x10
> [  173.150724]  ? _printk+0xac/0xf0
> [  173.151251]  ? lock_acquired+0xff/0x680
> [  173.151852]  print_report+0xe6/0x510
> [  173.152372]  ? __might_resched+0x1a1/0x3d0
> [  173.152997]  ? __mutex_lock+0xc0/0x920
> [  173.153566]  kasan_report+0x119/0x150
> [  173.154114]  ? lock_acquire+0x18a/0x390
> [  173.154667]  ? __mutex_lock+0xc0/0x920
> [  173.155225]  ? mddev_suspend+0xbc/0x260
> [  173.155799]  __mutex_lock+0xc0/0x920
> [  173.156332]  ? lock_acquire+0x18a/0x390
> [  173.156928]  ? kernfs_find_and_get_ns+0x4c/0xb0
> [  173.157578]  ? __pfx___mutex_lock+0x10/0x10
> [  173.158177]  ? down_read+0x6b2/0x800
> [  173.158696]  ? lock_is_held_type+0xdb/0x150
> [  173.159300]  mddev_suspend+0xbc/0x260
> [  173.159832]  ? __pfx_lock_release+0x10/0x10
> [  173.160427]  ? lock_is_held_type+0xdb/0x150
> [  173.161074]  ? __pfx_mddev_suspend+0x10/0x10
> [  173.161698]  rdev_attr_store+0x5ba/0x600
> [  173.162282]  ? __pfx_sysfs_kf_write+0x10/0x10
> [  173.162915]  kernfs_fop_write_iter+0x1d1/0x280
> [  173.163595]  vfs_write+0x45d/0x5d0
> [  173.164113]  ? __pfx_vfs_write+0x10/0x10
> [  173.164709]  ? __pfx_lock_release+0x10/0x10
> [  173.165352]  ksys_write+0xed/0x1a0
> [  173.165912]  ? __pfx_ksys_write+0x10/0x10
> [  173.166501]  ? __audit_syscall_entry+0x1cf/0x200
> [  173.167191]  ? syscall_enter_from_user_mode+0x181/0x220
> [  173.168034]  do_syscall_64+0x43/0x90
> [  173.168588]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  173.169355] RIP: 0033:0x7f4e65ced648
> [  173.169830] md: could not open device unknown-block(7,0).
> [  173.169914] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> d4 55
> [  173.173324] RSP: 002b:00007ffe9a2ac128 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [  173.174398] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f4e65ced648
> [  173.175405] RDX: 0000000000000007 RSI: 0000561ae26e29d0 RDI: 0000000000000001
> [  173.176416] RBP: 0000561ae26e29d0 R08: 000000000000000a R09: 00007f4e65d80620
> [  173.177417] R10: 000000000000000a R11: 0000000000000246 R12: 00007f4e65fc06e0
> [  173.178418] R13: 0000000000000007 R14: 00007f4e65fbb880 R15: 0000000000000007
> [  173.179441]  </TASK>
> [  173.179775] ==================================================================
> [  173.180838] Disabling lock debugging due to kernel taint
> [  173.181662] BUG: kernel NULL pointer dereference, address: 00000000000000a8
> [  173.182654] #PF: supervisor read access in kernel mode
> [  173.183408] #PF: error_code(0x0000) - not-present page
> [  173.184152] PGD 0 P4D 0
> [  173.184531] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
> [  173.185224] CPU: 26 PID: 1215 Comm: test Tainted: G    B
>    6.6.0-rc2+ #8
> [  173.186320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> [  173.187912] RIP: 0010:__mutex_lock+0xc0/0x920
> [  173.188557] Code: 00 e8 24 f3 77 fe 2e 2e 2e 31 c0 48 c7 c7 80 c7
> c5 89 e8 03 01 bf fe 83 3d ec e0 27 07 00 75 15 49 8d 7c 24 68 e8 30
> 02 bf fe <4d> 39 64 24 68 0f 85 00 08 00 00 bf 01 00 00 00 e8 5b e7 76
> fe 4d
> [  173.191203] RSP: 0018:ffff8881b18c7a20 EFLAGS: 00010286
> [  173.191958] RAX: ffff8881b0ae4001 RBX: 0000000000000000 RCX: ffffffff810e0df1
> [  173.192968] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8900ea40
> [  173.193976] RBP: ffff8881b18c7b50 R08: ffffffff8900ea47 R09: 1ffffffff1201d48
> [  173.194986] R10: dffffc0000000000 R11: fffffbfff1201d49 R12: 0000000000000040
> [  173.196263] R13: ffffffff823e61cc R14: 0000000000000000 R15: 0000000000000000
> [  173.197274] FS:  00007f4e66b6e740(0000) GS:ffff888dfd200000(0000)
> knlGS:0000000000000000
> [  173.198466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  173.199316] CR2: 00000000000000a8 CR3: 00000001b191e005 CR4: 0000000000370ee0
> [  173.200327] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  173.201382] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  173.202430] Call Trace:
> [  173.202810]  <TASK>
> [  173.203173]  ? __die_body+0x63/0xb0
> [  173.203678]  ? page_fault_oops+0x2f3/0x440
> [  173.204338]  ? __pfx_page_fault_oops+0x10/0x10
> [  173.204981]  ? vprintk_emit+0x455/0x520
> [  173.205593]  ? __pfx_vprintk_emit+0x10/0x10
> [  173.206276]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
> [  173.207068]  ? do_user_addr_fault+0x796/0x840
> [  173.207694]  ? _printk+0xac/0xf0
> [  173.208188]  ? __pfx_do_user_addr_fault+0x10/0x10
> [  173.208879]  ? rcu_is_watching+0x30/0x60
> [  173.209475]  ? exc_page_fault+0x7d/0x290
> [  173.210043]  ? asm_exc_page_fault+0x22/0x30
> [  173.210639]  ? mddev_suspend+0xbc/0x260
> [  173.211294]  ? add_taint+0x41/0x90
> [  173.211798]  ? __mutex_lock+0xc0/0x920
> [  173.212352]  ? lock_acquire+0x18a/0x390
> [  173.212914]  ? kernfs_find_and_get_ns+0x4c/0xb0
> [  173.213623]  ? __pfx___mutex_lock+0x10/0x10
> [  173.214243]  ? down_read+0x6b2/0x800
> [  173.214773]  ? lock_is_held_type+0xdb/0x150
> [  173.215374]  mddev_suspend+0xbc/0x260
> [  173.215941]  ? __pfx_lock_release+0x10/0x10
> [  173.216541]  ? lock_is_held_type+0xdb/0x150
> [  173.217148]  ? __pfx_mddev_suspend+0x10/0x10
> [  173.217776]  rdev_attr_store+0x5ba/0x600
> [  173.218343]  ? __pfx_sysfs_kf_write+0x10/0x10
> [  173.218977]  kernfs_fop_write_iter+0x1d1/0x280
> [  173.219618]  vfs_write+0x45d/0x5d0
> [  173.220126]  ? __pfx_vfs_write+0x10/0x10
> [  173.220689]  ? __pfx_lock_release+0x10/0x10
> [  173.221342]  ksys_write+0xed/0x1a0
> [  173.221850]  ? __pfx_ksys_write+0x10/0x10
> [  173.222421]  ? __audit_syscall_entry+0x1cf/0x200
> [  173.223090]  ? syscall_enter_from_user_mode+0x181/0x220
> [  173.223845]  do_syscall_64+0x43/0x90
> [  173.224362]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  173.225083] RIP: 0033:0x7f4e65ced648
> [  173.225599] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
> 00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
> d4 55
> [  173.228199] RSP: 002b:00007ffe9a2ac128 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [  173.229267] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f4e65ced648
> [  173.230273] RDX: 0000000000000007 RSI: 0000561ae26e29d0 RDI: 0000000000000001
> [  173.231274] RBP: 0000561ae26e29d0 R08: 000000000000000a R09: 00007f4e65d80620
> [  173.232323] R10: 000000000000000a R11: 0000000000000246 R12: 00007f4e65fc06e0
> [  173.233323] R13: 0000000000000007 R14: 00007f4e65fbb880 R15: 0000000000000007
> [  173.234333]  </TASK>
> [  173.234657] Modules linked in:
> [  173.235118] CR2: 00000000000000a8
> [  173.235601] ---[ end trace 0000000000000000 ]---
> [  173.236270] RIP: 0010:__mutex_lock+0xc0/0x920
> [  173.236906] Code: 00 e8 24 f3 77 fe 2e 2e 2e 31 c0 48 c7 c7 80 c7
> c5 89 e8 03 01 bf fe 83 3d ec e0 27 07 00 75 15 49 8d 7c 24 68 e8 30
> 02 bf fe <4d> 39 64 24 68 0f 85 00 08 00 00 bf 01 00 00 00 e8 5b e7 76
> fe 4d
> [  173.239538] RSP: 0018:ffff8881b18c7a20 EFLAGS: 00010286
> [  173.240286] RAX: ffff8881b0ae4001 RBX: 0000000000000000 RCX: ffffffff810e0df1
> [  173.241293] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff8900ea40
> [  173.242342] RBP: ffff8881b18c7b50 R08: ffffffff8900ea47 R09: 1ffffffff1201d48
> [  173.243343] R10: dffffc0000000000 R11: fffffbfff1201d49 R12: 0000000000000040
> [  173.244346] R13: ffffffff823e61cc R14: 0000000000000000 R15: 0000000000000000
> [  173.245384] FS:  00007f4e66b6e740(0000) GS:ffff888dfd200000(0000)
> knlGS:0000000000000000
> [  173.246548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  173.247362] CR2: 00000000000000a8 CR3: 00000001b191e005 CR4: 0000000000370ee0
> [  173.248371] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  173.249390] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  173.250395] Kernel panic - not syncing: Fatal exception
> [  173.251612] Kernel Offset: disabled
> [  173.252133] ---[ end Kernel panic - not syncing: Fatal exception ]---
> 
> 
> On Sun, Aug 27, 2023 at 7:04 PM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>>
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Changes in v2:
>>   - rebase with latest md-next
>>   - remove some follow up cleanup patches, these patches will be sent
>>   later after this patchset.
>>
>> After previous four patchset of preparatory work, this patchset impelement
>> a new version of mddev_suspend(), the new apis:
>>   - reconfig_mutex is not required;
>>   - the weird logical that suspend array hold 'reconfig_mutex' for
>>     mddev_check_recovery() to update superblock is not needed;
>>   - the special handling, 'pers->prepare_suspend', for raid456 is not
>>     needed;
>>   - It's safe to be called at any time once mddev is allocated, and it's
>>     designed to be used from slow path where array configuration is changed;
>>
>> And use the new api to replace:
>>
>> mddev_lock
>> mddev_suspend or not
>> // array reconfiguration
>> mddev_resume or not
>> mddev_unlock
>>
>> With:
>>
>> mddev_suspend
>> mddev_lock
>> // array reconfiguration
>> mddev_unlock
>> mddev_resume
>>
>> However, the above change is not possible for raid5 and raid-cluster in
>> some corner cases, and mddev_suspend/resume() is replaced with quiesce()
>> callback, which will suspend the array as well.
>>
>> This patchset is tested in my VM with mdadm testsuite with loop device
>> except for 10ddf tests(they always fail before this patchset).
>>
>> A lot of cleanups will be started after this patchset.
>>
>> Yu Kuai (28):
>>    md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
>>    md: use 'mddev->suspended' for is_md_suspended()
>>    md: add new helpers to suspend/resume array
>>    md: add new helpers to suspend/resume and lock/unlock array
>>    md: use new apis to suspend array for suspend_lo/hi_store()
>>    md: use new apis to suspend array for level_store()
>>    md: use new apis to suspend array for serialize_policy_store()
>>    md/dm-raid: use new apis to suspend array
>>    md/md-bitmap: use new apis to suspend array for location_store()
>>    md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
>>    md/raid5-cache: use new apis to suspend array for
>>      r5c_disable_writeback_async()
>>    md/raid5-cache: use new apis to suspend array for
>>      r5c_journal_mode_store()
>>    md/raid5: use new apis to suspend array for raid5_store_stripe_size()
>>    md/raid5: use new apis to suspend array for raid5_store_skip_copy()
>>    md/raid5: use new apis to suspend array for
>>      raid5_store_group_thread_cnt()
>>    md/raid5: use new apis to suspend array for
>>      raid5_change_consistency_policy()
>>    md/raid5: replace suspend with quiesce() callback
>>    md: quiesce before md_kick_rdev_from_array() for md-cluster
>>    md: use new apis to suspend array for ioctls involed array
>>      reconfiguration
>>    md: use new apis to suspend array for adding/removing rdev from
>>      state_store()
>>    md: use new apis to suspend array for bind_rdev_to_array()
>>    md: use new apis to suspend array related to serial pool in
>>      state_store()
>>    md: use new apis to suspend array in backlog_store()
>>    md: suspend array in md_start_sync() if array need reconfiguration
>>    md: cleanup mddev_create/destroy_serial_pool()
>>    md/md-linear: cleanup linear_add()
>>    md: remove old apis to suspend the array
>>    md: rename __mddev_suspend/resume() back to mddev_suspend/resume()
>>
>>   drivers/md/dm-raid.c       |   8 +-
>>   drivers/md/md-autodetect.c |   4 +-
>>   drivers/md/md-bitmap.c     |  18 ++-
>>   drivers/md/md-linear.c     |   2 -
>>   drivers/md/md.c            | 250 ++++++++++++++++++++++---------------
>>   drivers/md/md.h            |  52 ++++++--
>>   drivers/md/raid5-cache.c   |  61 +++++----
>>   drivers/md/raid5.c         |  56 ++++-----
>>   8 files changed, 253 insertions(+), 198 deletions(-)
>>
>> --
>> 2.39.2
>>
> .
> 

