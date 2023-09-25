Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA8F7ADBFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjIYPpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:45:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5442695;
        Mon, 25 Sep 2023 08:45:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA7DC433C7;
        Mon, 25 Sep 2023 15:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695656732;
        bh=r6d3UHi9iuC8eAYcrKfRH5vLUedaTi4dpeCISda4o+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bQXPnN7Yc84gJkjqfDddCaCFWI+5zyyQxNOlKwWyWuZ4H+dOVOqFGRQT3nKr0iawi
         V/SProg1aBVcrUHvzSAPkVsXF2WusfLFLiQpCkuSqhNF2kpJridxr0sS3GGuaO/wN+
         +RpMaomMXIT5qHPv98cMgAmH2rqGoBpnoFiXd47T8fEnrrSB/CHMed966AHt0iqB5d
         PBuJujVH2LDlO/T7agMScKI37GwVmn/cXsKHi80eOj04DoMuWBGpEe6CXLDFyFA/at
         QgLqHmfrqeRew6fjvfK6WI9cjE0hsp+D2Khl3tBbD2rQqNvm5GphYKBHeBTZrcpbmi
         o8tvDWBiYg0+w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-503397ee920so10685889e87.1;
        Mon, 25 Sep 2023 08:45:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxfpncvx28bLlLW9sEqhz0u67kg+WyesZR7oDpQroPU1yx0nz5l
        vFosCSx5ult0KONKio2QmJRuoSVVh+90XN736pY=
X-Google-Smtp-Source: AGHT+IEBcw3CI/DrGTni5kgkAHyjMaXoj0faNMKf1I9S6+/LZbNZJkKBwcP3/wXFs06JAYZvOpIK0LVgRa2rwyhLxqU=
X-Received: by 2002:ac2:5b4c:0:b0:503:364e:96ce with SMTP id
 i12-20020ac25b4c000000b00503364e96cemr5825695lfp.29.1695656730091; Mon, 25
 Sep 2023 08:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 25 Sep 2023 08:45:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4-L+u6--do0W8shPF63kcw28N6-k5iPcuQwUJtiCbWRw@mail.gmail.com>
Message-ID: <CAPhsuW4-L+u6--do0W8shPF63kcw28N6-k5iPcuQwUJtiCbWRw@mail.gmail.com>
Subject: Re: [PATCH -next v2 00/28] md: synchronize io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai,

Thanks for the patchset!

I have got the following panic with mdadm test 23rdev-lifetime.
Could you please look into it?

I pushed the test code to this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tes=
t-28

Thanks,
Song


[  173.143010] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  173.144256] BUG: KASAN: null-ptr-deref in __mutex_lock+0xc0/0x920
[  173.145232] Read of size 8 at addr 00000000000000a8 by task test/1215
[  173.146138]
[  173.146375] CPU: 26 PID: 1215 Comm: test Not tainted 6.6.0-rc2+ #8
[  173.147254] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[  173.148840] Call Trace:
[  173.149202]  <TASK>
[  173.149531]  dump_stack_lvl+0xb5/0x100
[  173.150093]  ? __pfx_dump_stack_lvl+0x10/0x10
[  173.150724]  ? _printk+0xac/0xf0
[  173.151251]  ? lock_acquired+0xff/0x680
[  173.151852]  print_report+0xe6/0x510
[  173.152372]  ? __might_resched+0x1a1/0x3d0
[  173.152997]  ? __mutex_lock+0xc0/0x920
[  173.153566]  kasan_report+0x119/0x150
[  173.154114]  ? lock_acquire+0x18a/0x390
[  173.154667]  ? __mutex_lock+0xc0/0x920
[  173.155225]  ? mddev_suspend+0xbc/0x260
[  173.155799]  __mutex_lock+0xc0/0x920
[  173.156332]  ? lock_acquire+0x18a/0x390
[  173.156928]  ? kernfs_find_and_get_ns+0x4c/0xb0
[  173.157578]  ? __pfx___mutex_lock+0x10/0x10
[  173.158177]  ? down_read+0x6b2/0x800
[  173.158696]  ? lock_is_held_type+0xdb/0x150
[  173.159300]  mddev_suspend+0xbc/0x260
[  173.159832]  ? __pfx_lock_release+0x10/0x10
[  173.160427]  ? lock_is_held_type+0xdb/0x150
[  173.161074]  ? __pfx_mddev_suspend+0x10/0x10
[  173.161698]  rdev_attr_store+0x5ba/0x600
[  173.162282]  ? __pfx_sysfs_kf_write+0x10/0x10
[  173.162915]  kernfs_fop_write_iter+0x1d1/0x280
[  173.163595]  vfs_write+0x45d/0x5d0
[  173.164113]  ? __pfx_vfs_write+0x10/0x10
[  173.164709]  ? __pfx_lock_release+0x10/0x10
[  173.165352]  ksys_write+0xed/0x1a0
[  173.165912]  ? __pfx_ksys_write+0x10/0x10
[  173.166501]  ? __audit_syscall_entry+0x1cf/0x200
[  173.167191]  ? syscall_enter_from_user_mode+0x181/0x220
[  173.168034]  do_syscall_64+0x43/0x90
[  173.168588]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  173.169355] RIP: 0033:0x7f4e65ced648
[  173.169830] md: could not open device unknown-block(7,0).
[  173.169914] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
d4 55
[  173.173324] RSP: 002b:00007ffe9a2ac128 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  173.174398] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f4e65c=
ed648
[  173.175405] RDX: 0000000000000007 RSI: 0000561ae26e29d0 RDI: 00000000000=
00001
[  173.176416] RBP: 0000561ae26e29d0 R08: 000000000000000a R09: 00007f4e65d=
80620
[  173.177417] R10: 000000000000000a R11: 0000000000000246 R12: 00007f4e65f=
c06e0
[  173.178418] R13: 0000000000000007 R14: 00007f4e65fbb880 R15: 00000000000=
00007
[  173.179441]  </TASK>
[  173.179775] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  173.180838] Disabling lock debugging due to kernel taint
[  173.181662] BUG: kernel NULL pointer dereference, address: 0000000000000=
0a8
[  173.182654] #PF: supervisor read access in kernel mode
[  173.183408] #PF: error_code(0x0000) - not-present page
[  173.184152] PGD 0 P4D 0
[  173.184531] Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[  173.185224] CPU: 26 PID: 1215 Comm: test Tainted: G    B
  6.6.0-rc2+ #8
[  173.186320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[  173.187912] RIP: 0010:__mutex_lock+0xc0/0x920
[  173.188557] Code: 00 e8 24 f3 77 fe 2e 2e 2e 31 c0 48 c7 c7 80 c7
c5 89 e8 03 01 bf fe 83 3d ec e0 27 07 00 75 15 49 8d 7c 24 68 e8 30
02 bf fe <4d> 39 64 24 68 0f 85 00 08 00 00 bf 01 00 00 00 e8 5b e7 76
fe 4d
[  173.191203] RSP: 0018:ffff8881b18c7a20 EFLAGS: 00010286
[  173.191958] RAX: ffff8881b0ae4001 RBX: 0000000000000000 RCX: ffffffff810=
e0df1
[  173.192968] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff890=
0ea40
[  173.193976] RBP: ffff8881b18c7b50 R08: ffffffff8900ea47 R09: 1ffffffff12=
01d48
[  173.194986] R10: dffffc0000000000 R11: fffffbfff1201d49 R12: 00000000000=
00040
[  173.196263] R13: ffffffff823e61cc R14: 0000000000000000 R15: 00000000000=
00000
[  173.197274] FS:  00007f4e66b6e740(0000) GS:ffff888dfd200000(0000)
knlGS:0000000000000000
[  173.198466] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  173.199316] CR2: 00000000000000a8 CR3: 00000001b191e005 CR4: 00000000003=
70ee0
[  173.200327] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  173.201382] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  173.202430] Call Trace:
[  173.202810]  <TASK>
[  173.203173]  ? __die_body+0x63/0xb0
[  173.203678]  ? page_fault_oops+0x2f3/0x440
[  173.204338]  ? __pfx_page_fault_oops+0x10/0x10
[  173.204981]  ? vprintk_emit+0x455/0x520
[  173.205593]  ? __pfx_vprintk_emit+0x10/0x10
[  173.206276]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  173.207068]  ? do_user_addr_fault+0x796/0x840
[  173.207694]  ? _printk+0xac/0xf0
[  173.208188]  ? __pfx_do_user_addr_fault+0x10/0x10
[  173.208879]  ? rcu_is_watching+0x30/0x60
[  173.209475]  ? exc_page_fault+0x7d/0x290
[  173.210043]  ? asm_exc_page_fault+0x22/0x30
[  173.210639]  ? mddev_suspend+0xbc/0x260
[  173.211294]  ? add_taint+0x41/0x90
[  173.211798]  ? __mutex_lock+0xc0/0x920
[  173.212352]  ? lock_acquire+0x18a/0x390
[  173.212914]  ? kernfs_find_and_get_ns+0x4c/0xb0
[  173.213623]  ? __pfx___mutex_lock+0x10/0x10
[  173.214243]  ? down_read+0x6b2/0x800
[  173.214773]  ? lock_is_held_type+0xdb/0x150
[  173.215374]  mddev_suspend+0xbc/0x260
[  173.215941]  ? __pfx_lock_release+0x10/0x10
[  173.216541]  ? lock_is_held_type+0xdb/0x150
[  173.217148]  ? __pfx_mddev_suspend+0x10/0x10
[  173.217776]  rdev_attr_store+0x5ba/0x600
[  173.218343]  ? __pfx_sysfs_kf_write+0x10/0x10
[  173.218977]  kernfs_fop_write_iter+0x1d1/0x280
[  173.219618]  vfs_write+0x45d/0x5d0
[  173.220126]  ? __pfx_vfs_write+0x10/0x10
[  173.220689]  ? __pfx_lock_release+0x10/0x10
[  173.221342]  ksys_write+0xed/0x1a0
[  173.221850]  ? __pfx_ksys_write+0x10/0x10
[  173.222421]  ? __audit_syscall_entry+0x1cf/0x200
[  173.223090]  ? syscall_enter_from_user_mode+0x181/0x220
[  173.223845]  do_syscall_64+0x43/0x90
[  173.224362]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  173.225083] RIP: 0033:0x7f4e65ced648
[  173.225599] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00
00 00 f3 0f 1e fa 48 8d 05 55 6f 2d 00 8b 00 85 c0 75 17 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89
d4 55
[  173.228199] RSP: 002b:00007ffe9a2ac128 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  173.229267] RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f4e65c=
ed648
[  173.230273] RDX: 0000000000000007 RSI: 0000561ae26e29d0 RDI: 00000000000=
00001
[  173.231274] RBP: 0000561ae26e29d0 R08: 000000000000000a R09: 00007f4e65d=
80620
[  173.232323] R10: 000000000000000a R11: 0000000000000246 R12: 00007f4e65f=
c06e0
[  173.233323] R13: 0000000000000007 R14: 00007f4e65fbb880 R15: 00000000000=
00007
[  173.234333]  </TASK>
[  173.234657] Modules linked in:
[  173.235118] CR2: 00000000000000a8
[  173.235601] ---[ end trace 0000000000000000 ]---
[  173.236270] RIP: 0010:__mutex_lock+0xc0/0x920
[  173.236906] Code: 00 e8 24 f3 77 fe 2e 2e 2e 31 c0 48 c7 c7 80 c7
c5 89 e8 03 01 bf fe 83 3d ec e0 27 07 00 75 15 49 8d 7c 24 68 e8 30
02 bf fe <4d> 39 64 24 68 0f 85 00 08 00 00 bf 01 00 00 00 e8 5b e7 76
fe 4d
[  173.239538] RSP: 0018:ffff8881b18c7a20 EFLAGS: 00010286
[  173.240286] RAX: ffff8881b0ae4001 RBX: 0000000000000000 RCX: ffffffff810=
e0df1
[  173.241293] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffffff890=
0ea40
[  173.242342] RBP: ffff8881b18c7b50 R08: ffffffff8900ea47 R09: 1ffffffff12=
01d48
[  173.243343] R10: dffffc0000000000 R11: fffffbfff1201d49 R12: 00000000000=
00040
[  173.244346] R13: ffffffff823e61cc R14: 0000000000000000 R15: 00000000000=
00000
[  173.245384] FS:  00007f4e66b6e740(0000) GS:ffff888dfd200000(0000)
knlGS:0000000000000000
[  173.246548] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  173.247362] CR2: 00000000000000a8 CR3: 00000001b191e005 CR4: 00000000003=
70ee0
[  173.248371] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  173.249390] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  173.250395] Kernel panic - not syncing: Fatal exception
[  173.251612] Kernel Offset: disabled
[  173.252133] ---[ end Kernel panic - not syncing: Fatal exception ]---


On Sun, Aug 27, 2023 at 7:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - rebase with latest md-next
>  - remove some follow up cleanup patches, these patches will be sent
>  later after this patchset.
>
> After previous four patchset of preparatory work, this patchset impelemen=
t
> a new version of mddev_suspend(), the new apis:
>  - reconfig_mutex is not required;
>  - the weird logical that suspend array hold 'reconfig_mutex' for
>    mddev_check_recovery() to update superblock is not needed;
>  - the special handling, 'pers->prepare_suspend', for raid456 is not
>    needed;
>  - It's safe to be called at any time once mddev is allocated, and it's
>    designed to be used from slow path where array configuration is change=
d;
>
> And use the new api to replace:
>
> mddev_lock
> mddev_suspend or not
> // array reconfiguration
> mddev_resume or not
> mddev_unlock
>
> With:
>
> mddev_suspend
> mddev_lock
> // array reconfiguration
> mddev_unlock
> mddev_resume
>
> However, the above change is not possible for raid5 and raid-cluster in
> some corner cases, and mddev_suspend/resume() is replaced with quiesce()
> callback, which will suspend the array as well.
>
> This patchset is tested in my VM with mdadm testsuite with loop device
> except for 10ddf tests(they always fail before this patchset).
>
> A lot of cleanups will be started after this patchset.
>
> Yu Kuai (28):
>   md: use READ_ONCE/WRITE_ONCE for 'suspend_lo' and 'suspend_hi'
>   md: use 'mddev->suspended' for is_md_suspended()
>   md: add new helpers to suspend/resume array
>   md: add new helpers to suspend/resume and lock/unlock array
>   md: use new apis to suspend array for suspend_lo/hi_store()
>   md: use new apis to suspend array for level_store()
>   md: use new apis to suspend array for serialize_policy_store()
>   md/dm-raid: use new apis to suspend array
>   md/md-bitmap: use new apis to suspend array for location_store()
>   md/raid5-cache: use READ_ONCE/WRITE_ONCE for 'conf->log'
>   md/raid5-cache: use new apis to suspend array for
>     r5c_disable_writeback_async()
>   md/raid5-cache: use new apis to suspend array for
>     r5c_journal_mode_store()
>   md/raid5: use new apis to suspend array for raid5_store_stripe_size()
>   md/raid5: use new apis to suspend array for raid5_store_skip_copy()
>   md/raid5: use new apis to suspend array for
>     raid5_store_group_thread_cnt()
>   md/raid5: use new apis to suspend array for
>     raid5_change_consistency_policy()
>   md/raid5: replace suspend with quiesce() callback
>   md: quiesce before md_kick_rdev_from_array() for md-cluster
>   md: use new apis to suspend array for ioctls involed array
>     reconfiguration
>   md: use new apis to suspend array for adding/removing rdev from
>     state_store()
>   md: use new apis to suspend array for bind_rdev_to_array()
>   md: use new apis to suspend array related to serial pool in
>     state_store()
>   md: use new apis to suspend array in backlog_store()
>   md: suspend array in md_start_sync() if array need reconfiguration
>   md: cleanup mddev_create/destroy_serial_pool()
>   md/md-linear: cleanup linear_add()
>   md: remove old apis to suspend the array
>   md: rename __mddev_suspend/resume() back to mddev_suspend/resume()
>
>  drivers/md/dm-raid.c       |   8 +-
>  drivers/md/md-autodetect.c |   4 +-
>  drivers/md/md-bitmap.c     |  18 ++-
>  drivers/md/md-linear.c     |   2 -
>  drivers/md/md.c            | 250 ++++++++++++++++++++++---------------
>  drivers/md/md.h            |  52 ++++++--
>  drivers/md/raid5-cache.c   |  61 +++++----
>  drivers/md/raid5.c         |  56 ++++-----
>  8 files changed, 253 insertions(+), 198 deletions(-)
>
> --
> 2.39.2
>
