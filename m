Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D37B8E31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjJDUjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJDUjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:39:52 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DEEAD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:39:47 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231004203943euoutp02823d29479a5c25c6459c74aaa8a19b04~LAhdVD9JA2370523705euoutp02i
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 20:39:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231004203943euoutp02823d29479a5c25c6459c74aaa8a19b04~LAhdVD9JA2370523705euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696451983;
        bh=MnqIjZyECIksFDvy7lSFMyxKTSSdk4y3paA1+9xTP3A=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=os4VFBQusJr7bhzBNDkJxv1dHpfaL8uoTaThn+6wt79I9KJhUTTmyCAC0K+mDqm02
         AMa25HFq+2sPlg1urWoNlA4aJTik9oldizhFKyTUBssoaxret9t9XxDNWu8scisbTt
         hloJvUmiVFLbOWau0gkNhjfsd+CWD2tFqjYMGi/I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231004203942eucas1p1b524dd06b9ff71c01574881c5d47ff41~LAhb5X7FO1051010510eucas1p1n;
        Wed,  4 Oct 2023 20:39:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7A.67.42423.E8DCD156; Wed,  4
        Oct 2023 21:39:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231004203940eucas1p2f73b017497d1f4239a6e236fdb6019e2~LAhapkkOC2221222212eucas1p2Z;
        Wed,  4 Oct 2023 20:39:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231004203940eusmtrp1f3adbf9e57a5d47c495f257219781bd2~LAhaneyqz2916129161eusmtrp1U;
        Wed,  4 Oct 2023 20:39:40 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-b8-651dcd8ef698
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 30.B6.10549.C8DCD156; Wed,  4
        Oct 2023 21:39:40 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231004203939eusmtip23428b65bde6661176144a416debbcd47~LAhZDqQN82278422784eusmtip2p;
        Wed,  4 Oct 2023 20:39:39 +0000 (GMT)
Message-ID: <c92bc8a6-225d-4fd2-88b5-8994090fb2de@samsung.com>
Date:   Wed, 4 Oct 2023 22:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <xm261qego72d.fsf_-_@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUxbVRz19r2+PirFtzLDDbAQq0PBrIgfy1W3OZIpz8REFjK/Fp0NfQGk
        QNfCnGYxZUBp6z4KjA3ajTEqW8HyYfkIqw0CbkBhAyxhYgPCbB0WKVoQNt2gUl6m/HfO757z
        O/fcXBITthCRZGZOHqPIkchEBB/v6Pt7ZMepm9uY587bQpHTPU6gc94CHK00lhHI010C0K/6
        dgxZ5l04KjQ1E+iyajvyzwvQ1OkKHK1qk9CY7TyByhfuAPT12iBAVwZbCDQ1eJ1A/Se7Oehq
        vZmLblg7cOTTPuCiLs0MB7VaKzB0q+wigUbXvsGR5toKhsaKSjHkPR6/N4oudq4StKXaAmij
        6gec/tP/Ea0+u5Mu6nLx6BprPt1qjqdNdi+HvrS4zKWtDVqC9hgucejJW3aCXhge5tHVjv30
        dxcsvJSID/i7pIws8wijSNjzMT/DtHZEPpt0dNF/n6sCvpd1IISE1Iuw80ERpgN8UkiZAXSv
        jhMs+QvARb2ZG1QJqSUA693JDx3e6lrAiq4AWHKiFmeJH8ACUx0eVAmoPfDnvh833Dj1FFxq
        nQXsfAt0VHk2NI9TMXDaVckL4nDqbWhXD2BBjFER0OW5yAnirdR+WPe9iRsMwKgBHPrL/RtL
        CSoR6nw6IohDqB3QfaOOYM0xsLDduFEIUu18aLzduZ5MrpN9sHEljq0QDuf623gsjoZD5Sdw
        Vl8CYM39aQ5L9ACqZl2AVb0KJ4f/IYKLMCoONtsS2HES/GruDI/dHwYnfFvYO4TBso5zGDsW
        QI1ayKpjoaG/6b/YnlEnpgciw6ZnMWyqb9jUxvB/bg3AG0AEk6/MTmeUiTnMp2KlJFuZn5Mu
        TsvNtoL1Tz201r/YCS7M+cW9gEOCXgBJTLRVkK6KZoQCqeSzzxlF7iFFvoxR9oIoEhdFCJ7d
        7UgTUumSPCaLYeSM4uEphwyJVHEYayD06TdOLZOhvvK+PFfI69q989KZu0vZM1nTTxxQNtaX
        Thx6RzNxW7xz5I8SvuiYgV88mSt5pqsnWf6YtiDhPX3xtZ4BokqW0R0u7ZKR3Uppk9qdEYiO
        q3Lr+FUO4+6XFlJ5v5TGj/a23muTl9I3vW96ZQf9bRGmL7Jnfl89hsKeL3xr6fqXPdTJSo8t
        6pN5T/NyX31LJDNmoe2PzMqPGgbFlzuMsZ7l7YG0pBdSk6EyNW3quOn0o1I+3lDT8mHiwW/d
        KQGbIIDOTGle26W2j40PNd2pFJlXRq4e+KliW+zdJycUnHczDzsdo/sqY2LczsO1obVhgVfe
        /y0rBdwT4coMSWI8plBK/gVVkL8CQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsVy+t/xe7o9Z2VTDVbsMbG49Pgqm8X0l40s
        Ft/WTmKzeHKgndHi6YStzBZr3txisWhevJ7NYlmDqsXHN7wWd/unslj87XS0uLxrDpvF5HfP
        GC1W/zvFaLH81AY2i7unjrJZHO89wGSxc+UKVoszm7axWLzt/MNqsa/jAZPF5k1TmS2uTZrP
        ZnHh30YWi44j35gtLrdMZLZ42aTlIO3Reukvm8eaeWsYPWY3XGTx+PAxzqNtmplHy75b7B4L
        NpV6bF6h5bF4z0smj4WfvrJ6bFrVyebxZNZCJo871/awebw7d47dY97JQI/9c9ewB4hH6dkU
        5ZeWpCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GUs/ldW8Nyx
        4tPH36wNjG8tuxg5OSQETCRezlvE2MXIxSEksJRRouvvJlaIhIzEyWkNULawxJ9rXWwQRe8Z
        JS5s3MwMkuAVsJO4d+w6WBGLgIrE583PGSHighInZz5hAbFFBeQl7t+awQ5iCwv4SqxvnQLW
        yywgLnHryXwmEFtEIFDi6edXYFcwC5xgkTg/Zyk7xLYGRome+Q1gHWwChhJdb0HO4OTgFNCV
        eHxmKRvEJDOJrq1djBC2vETz1tnMExiFZiE5ZBaShbOQtMxC0rKAkWUVo0hqaXFuem6xoV5x
        Ym5xaV66XnJ+7iZGYHLaduzn5h2M81591DvEyMTBeIhRgoNZSYQ3vUEmVYg3JbGyKrUoP76o
        NCe1+BCjKTA0JjJLiSbnA9NjXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFM
        HxMHp1QDk9jP3SzVKp1GoUk/JyrPdWIxYG0Un7Mus3Ile8quZs31BYl+/lt9WIM9F13sPRzI
        86x+6bWZMvbGtUu+Ni5LzmRbcPRFw2KdqKdtFvtSmb+6P4he7ROm6aHvxfx54v9LVf5REpqX
        jqq3vbljaiC1aMbiqzn3Drgop3/IVH+lLGPUZxR67eH3ubcu1yT8mGDgeaXNodRVYnMyQx7j
        jii5JxkSrxcwxblvf+H88VOFjseZjqYpq8zNlrEuONh0+4Luv7sdydf6Vk/WEWqtWJakc4zt
        Z554XFLNO46SGSVca2yOC/Xf6nkVk2Ud0mCvu7PqkVHMk54pZotmBTzZxcpzf03I+ekKMrIZ
        pQKrlLcosRRnJBpqMRcVJwIANwJnsdcDAAA=
X-CMS-MailID: 20231004203940eucas1p2f73b017497d1f4239a6e236fdb6019e2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231004203940eucas1p2f73b017497d1f4239a6e236fdb6019e2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231004203940eucas1p2f73b017497d1f4239a6e236fdb6019e2
References: <20230531115839.089944915@infradead.org>
        <20230531124603.931005524@infradead.org> <xm261qego72d.fsf_-_@google.com>
        <CGME20231004203940eucas1p2f73b017497d1f4239a6e236fdb6019e2@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30.09.2023 02:09, Benjamin Segall wrote:
> The old pick_eevdf could fail to find the actual earliest eligible
> deadline when it descended to the right looking for min_deadline, but it
> turned out that that min_deadline wasn't actually eligible. In that case
> we need to go back and search through any left branches we skipped
> looking for the actual best _eligible_ min_deadline.
>
> This is more expensive, but still O(log n), and at worst should only
> involve descending two branches of the rbtree.
>
> I've run this through a userspace stress test (thank you
> tools/lib/rbtree.c), so hopefully this implementation doesn't miss any
> corner cases.
>
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Ben Segall <bsegall@google.com>

This patch landed in today's linux-next as commit 561c58efd239 
("sched/fair: Fix pick_eevdf()"). Surprisingly it introduced a warning 
about circular locking dependency. It can be easily observed during boot 
from time to time on on qemu/arm64 'virt' machine:

======================================================
WARNING: possible circular locking dependency detected
6.6.0-rc4+ #7222 Not tainted
------------------------------------------------------
systemd-udevd/1187 is trying to acquire lock:
ffffbcc2be0c4de0 (console_owner){..-.}-{0:0}, at: 
console_flush_all+0x1b0/0x500

but task is already holding lock:
ffff5535ffdd2b18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0xe0/0xc40

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&rq->__lock){-.-.}-{2:2}:
        _raw_spin_lock_nested+0x44/0x5c
        raw_spin_rq_lock_nested+0x24/0x40
        task_fork_fair+0x3c/0xac
        sched_cgroup_fork+0xe8/0x14c
        copy_process+0x11c4/0x1a14
        kernel_clone+0x8c/0x400
        user_mode_thread+0x70/0x98
        rest_init+0x28/0x190
        arch_post_acpi_subsys_init+0x0/0x8
        start_kernel+0x594/0x684
        __primary_switched+0xbc/0xc4

-> #3 (&p->pi_lock){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x88
        try_to_wake_up+0x58/0x468
        default_wake_function+0x14/0x20
        woken_wake_function+0x20/0x2c
        __wake_up_common+0x94/0x170
        __wake_up_common_lock+0x7c/0xcc
        __wake_up+0x18/0x24
        tty_wakeup+0x34/0x70
        tty_port_default_wakeup+0x20/0x38
        tty_port_tty_wakeup+0x18/0x24
        uart_write_wakeup+0x18/0x28
        pl011_tx_chars+0x140/0x2b4
        pl011_start_tx+0xe8/0x190
        serial_port_runtime_resume+0x90/0xc0
        __rpm_callback+0x48/0x1a8
        rpm_callback+0x6c/0x78
        rpm_resume+0x438/0x6d8
        pm_runtime_work+0x84/0xc8
        process_one_work+0x1ec/0x53c
        worker_thread+0x298/0x408
        kthread+0x124/0x128
        ret_from_fork+0x10/0x20

-> #2 (&tty->write_wait){....}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x88
        __wake_up_common_lock+0x5c/0xcc
        __wake_up+0x18/0x24
        tty_wakeup+0x34/0x70
        tty_port_default_wakeup+0x20/0x38
        tty_port_tty_wakeup+0x18/0x24
        uart_write_wakeup+0x18/0x28
        pl011_tx_chars+0x140/0x2b4
        pl011_start_tx+0xe8/0x190
        serial_port_runtime_resume+0x90/0xc0
        __rpm_callback+0x48/0x1a8
        rpm_callback+0x6c/0x78
        rpm_resume+0x438/0x6d8
        pm_runtime_work+0x84/0xc8
        process_one_work+0x1ec/0x53c
        worker_thread+0x298/0x408
        kthread+0x124/0x128
        ret_from_fork+0x10/0x20

-> #1 (&port_lock_key){..-.}-{2:2}:
        _raw_spin_lock+0x48/0x60
        pl011_console_write+0x13c/0x1b0
        console_flush_all+0x20c/0x500
        console_unlock+0x6c/0x130
        vprintk_emit+0x228/0x3a0
        vprintk_default+0x38/0x44
        vprintk+0xa4/0xc0
        _printk+0x5c/0x84
        register_console+0x1f4/0x420
        serial_core_register_port+0x5a4/0x5d8
        serial_ctrl_register_port+0x10/0x1c
        uart_add_one_port+0x10/0x1c
        pl011_register_port+0x70/0x12c
        pl011_probe+0x1bc/0x1fc
        amba_probe+0x110/0x1c8
        really_probe+0x148/0x2b4
        __driver_probe_device+0x78/0x12c
        driver_probe_device+0xd8/0x160
        __device_attach_driver+0xb8/0x138
        bus_for_each_drv+0x84/0xe0
        __device_attach+0xa8/0x1b0
        device_initial_probe+0x14/0x20
        bus_probe_device+0xb0/0xb4
        device_add+0x574/0x738
        amba_device_add+0x40/0xac
        of_platform_bus_create+0x2b4/0x378
        of_platform_populate+0x50/0xfc
        of_platform_default_populate_init+0xd0/0xf0
        do_one_initcall+0x74/0x2f0
        kernel_init_freeable+0x28c/0x4dc
        kernel_init+0x24/0x1dc
        ret_from_fork+0x10/0x20

-> #0 (console_owner){..-.}-{0:0}:
        __lock_acquire+0x1318/0x20c4
        lock_acquire+0x1e8/0x318
        console_flush_all+0x1f8/0x500
        console_unlock+0x6c/0x130
        vprintk_emit+0x228/0x3a0
        vprintk_default+0x38/0x44
        vprintk+0xa4/0xc0
        _printk+0x5c/0x84
        pick_next_task_fair+0x28c/0x498
        __schedule+0x164/0xc40
        do_task_dead+0x54/0x58
        do_exit+0x61c/0x9e8
        do_group_exit+0x34/0x90
        __wake_up_parent+0x0/0x30
        invoke_syscall+0x48/0x114
        el0_svc_common.constprop.0+0x40/0xe0
        do_el0_svc_compat+0x1c/0x38
        el0_svc_compat+0x48/0xb4
        el0t_32_sync_handler+0x90/0x140
        el0t_32_sync+0x194/0x198

other info that might help us debug this:

Chain exists of:
   console_owner --> &p->pi_lock --> &rq->__lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->__lock);
                                lock(&p->pi_lock);
                                lock(&rq->__lock);
   lock(console_owner);

  *** DEADLOCK ***

3 locks held by systemd-udevd/1187:
  #0: ffff5535ffdd2b18 (&rq->__lock){-.-.}-{2:2}, at: __schedule+0xe0/0xc40
  #1: ffffbcc2be0c4c30 (console_lock){+.+.}-{0:0}, at: 
vprintk_emit+0x11c/0x3a0
  #2: ffffbcc2be0c4c88 (console_srcu){....}-{0:0}, at: 
console_flush_all+0x7c/0x500

stack backtrace:
CPU: 1 PID: 1187 Comm: systemd-udevd Not tainted 6.6.0-rc4+ #7222
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x98/0xf0
  show_stack+0x18/0x24
  dump_stack_lvl+0x60/0xac
  dump_stack+0x18/0x24
  print_circular_bug+0x290/0x370
  check_noncircular+0x15c/0x170
  __lock_acquire+0x1318/0x20c4
  lock_acquire+0x1e8/0x318
  console_flush_all+0x1f8/0x500
  console_unlock+0x6c/0x130
  vprintk_emit+0x228/0x3a0
  vprintk_default+0x38/0x44
  vprintk+0xa4/0xc0
  _printk+0x5c/0x84
  pick_next_task_fair+0x28c/0x498
  __schedule+0x164/0xc40
  do_task_dead+0x54/0x58
  do_exit+0x61c/0x9e8
  do_group_exit+0x34/0x90
  __wake_up_parent+0x0/0x30
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0x40/0xe0
  do_el0_svc_compat+0x1c/0x38
  el0_svc_compat+0x48/0xb4
  el0t_32_sync_handler+0x90/0x140
  el0t_32_sync+0x194/0x198

The problem is probably elsewhere, but this scheduler change only 
revealed it in a fully reproducible way. Reverting $subject on top of 
linux-next hides the problem deep enough that I was not able to 
reproduce it. Let me know if there is anything I can do to help fixing 
this issue.

> ---
>   kernel/sched/fair.c | 72 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 14 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

