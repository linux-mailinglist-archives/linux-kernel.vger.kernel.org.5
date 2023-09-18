Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06B7A4093
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjIRFs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 01:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjIRFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 01:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF8100
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695016040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rIwfLa6JYSQEWjwhyT0Y1FXeYym2WgQoBbWawv2aRw=;
        b=REpZN0LwlzwjvJnh7ad5HR6ay/CKsXsCIYVXqvyLjSyoFYJXUMspjlcY+WhfI8OsuVYsQf
        izt0T0yQcuVREEW1l9rERCHO46q9luTEwA8Gx4KqMkUm2cUmUSl7kQnaw6uiZiAF46Ud2o
        AJvsyWhI3E8C8E2tN06/CuYFx9BqfwM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-UewbgYNIPNSpYHMjpLV5Lg-1; Mon, 18 Sep 2023 01:47:16 -0400
X-MC-Unique: UewbgYNIPNSpYHMjpLV5Lg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a348facbbso317446766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 22:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016035; x=1695620835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rIwfLa6JYSQEWjwhyT0Y1FXeYym2WgQoBbWawv2aRw=;
        b=YYo295iX/85wOpFgWZup8KBQ/xNdVMTjKYoPqojMYx9YdqkiaK7eQQfd9nqcPcK7G5
         Q1QJlMoGSybVZJPuMREj290wdBtJjRdMlB+82t95ISJeZFZFao2ieP/8UPhOvq+0PapW
         NdbqkC73oXEkJE/L1GFpFZ61kdMlHqP3NtDEtrTJ4tXo6zXkxA9zyFSnch7afmXcaMZi
         5RJHdGkHobwGWtKx+WR23N+1B3tD5Ql/UYmT1PXK2KQL/juWSTVoKiUP9vrwIzGSzNtL
         VwSJW5BvI5hDL6Yc9yHm0PvjpdGDYJG7LwrDInhLD+/Y9XBBP4WrSRJthXJSM267auKA
         vVIA==
X-Gm-Message-State: AOJu0YxqIUtgcDOVAV5FwZqjsjXykcwja0KUHUNZ+6kaa0VdSTP0vBFe
        FGmvDJY4pt+Pp8B8vS5Stfbdkl7C/8/MiN5cW7L/i7TXeK0pj9/9dF2sL6XoULOeV0ed4xqEHRO
        5E284TyvcCfWIv20JCqMHV4U9CSxADEuZWZ89wnu9
X-Received: by 2002:a17:906:197:b0:9a1:c357:c743 with SMTP id 23-20020a170906019700b009a1c357c743mr7968582ejb.52.1695016035532;
        Sun, 17 Sep 2023 22:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENE13sgYCD85zSxjyJrYNOvrX2ckA90aO972XLRn7cyU3UWkAlkxrPLMnWlW93MaXka5CO1mJFchpv/DnksGA=
X-Received: by 2002:a17:906:197:b0:9a1:c357:c743 with SMTP id
 23-20020a170906019700b009a1c357c743mr7968570ejb.52.1695016035256; Sun, 17 Sep
 2023 22:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230912082440.325189-1-tglozar@gmail.com> <65036a57ea900_35db10294ec@iweiny-mobl.notmuch>
In-Reply-To: <65036a57ea900_35db10294ec@iweiny-mobl.notmuch>
From:   Tomas Glozar <tglozar@redhat.com>
Date:   Mon, 18 Sep 2023 07:47:04 +0200
Message-ID: <CAP4=nvTKFWHZgrMmfWtRmsjBZ8gijktyJ3rpsNyspqZhL8+Fzg@mail.gmail.com>
Subject: Re: [PATCH] nd_btt: Make BTT lanes preemptible
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 14. 9. 2023 v 22:18 odes=C3=ADlatel Ira Weiny <ira.weiny@intel.com>=
 napsal:
> Is the bug in 1 of 2 places?
>
> 1) When btt_write_pg()->lock_map() (when the number of lanes is < number
>    of cpus) and the lane is acquired is called?
>
> *or*
>
> 2) When nd_region_acquire_lane() internally trys to take it's lock?
>
> A copy/paste of the BUG observed would have been more clear I think.
>

The BUG was observed on btt_write_pg()->lock_map(), but I assume the
BUG will also happen on the lock in nd_region_acquire_lane, since that
is also a spin lock, i.e. a sleeping lock on RT.

BUG observed in dmesg when running ndctl tests on RT kernel without the pat=
ch:

[  123.262740] nfit_test_iomap: loading out-of-tree module taints kernel.
[  123.262744] nfit_test_iomap: loading test module taints kernel.
[  123.408628] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0x0000000100000000-0x0000000101ffffff]
[  123.408633] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0x0000000100000000-0x0000000101ffffff]
[  123.408852] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0x0000000108000000-0x000000010bffffff]
[  123.408855] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0x0000000108000000-0x000000010bffffff]
[  123.408933] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0xffffb900c2cbd000-0xffffb900c2cbd00b]
[  123.408935] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0xffffb900c2cbd000-0xffffb900c2cbd00b]
[  123.408961] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0xffffb900c2cde000-0xffffb900c2cde00b]
[  123.408963] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0xffffb900c2cde000-0xffffb900c2cde00b]
[  123.408988] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0xffffb900c2cff000-0xffffb900c2cff00b]
[  123.408990] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0xffffb900c2cff000-0xffffb900c2cff00b]
[  123.409015] nfit_test nfit_test.0: changing numa node from -1 to 0
for nfit region [0xffffb900c2d45000-0xffffb900c2d4500b]
[  123.409018] nfit_test nfit_test.0: changing target node from -1 to
0 for nfit region [0xffffb900c2d45000-0xffffb900c2d4500b]
[  123.409586] nfit_test nfit_test.0: failed to evaluate _FIT
[  123.441834] nfit_test nfit_test.1: Error found in NVDIMM nmem4
flags: save_fail restore_fail flush_fail not_armed
[  123.441857] nfit_test nfit_test.1: Error found in NVDIMM nmem5
flags: map_fail
[  123.457346] nfit_test nfit_test.1: changing numa node from -1 to 0
for nfit region [0x0000000140000000-0x0000000141ffffff]
[  123.457351] nfit_test nfit_test.1: changing target node from -1 to
0 for nfit region [0x0000000140000000-0x0000000141ffffff]
[  123.457427] nfit_test nfit_test.1: changing numa node from -1 to 0
for nfit region [0xffffb900c361d000-0xffffb900c3a1cfff]
[  123.457429] nfit_test nfit_test.1: changing target node from -1 to
0 for nfit region [0xffffb900c361d000-0xffffb900c3a1cfff]
[  123.475513] nd_pmem namespace3.0: unable to guarantee persistence of wri=
tes
[  123.484778] nd_pmem namespace2.0: region2 read-only, marking pmem2 read-=
only
[  126.349866] nd_pmem btt0.0: No existing arenas
[  126.407070] BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
[  126.407073] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
4903, name: libndctl
[  126.407074] preempt_count: 1, expected: 0
[  126.407075] RCU nest depth: 0, expected: 0
[  126.407075] 1 lock held by libndctl/4903:
[  126.407076]  #0: ffff8c184a270060
(&arena->map_locks[i].lock){+.+.}-{2:2}, at: btt_write_pg+0x2d7/0x500
[nd_btt]
[  126.407085] Preemption disabled at:
[  126.407085] [<ffffffffc1313db5>] nd_region_acquire_lane+0x15/0x90 [libnv=
dimm]
[  126.407099] CPU: 1 PID: 4903 Comm: libndctl Kdump: loaded Tainted:
G        W  O     N-------  ---
6.5.0-ark.ndctl-tests.el9+rt-debug-rt6+ #6
[  126.407101] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS 1.16.2-1.fc38 04/01/2014
[  126.407102] Call Trace:
[  126.407103]  <TASK>
[  126.407104]  dump_stack_lvl+0x8e/0xb0
[  126.407109]  __might_resched+0x19b/0x250
[  126.407113]  rt_spin_lock+0x4c/0x100
[  126.407116]  ? btt_write_pg+0x2d7/0x500 [nd_btt]
[  126.407120]  btt_write_pg+0x2d7/0x500 [nd_btt]
[  126.407127]  ? local_clock_noinstr+0x9/0xc0
[  126.407131]  btt_submit_bio+0x16d/0x270 [nd_btt]
[  126.407138]  __submit_bio+0x48/0x80
[  126.407141]  __submit_bio_noacct+0x7e/0x1e0
[  126.407146]  submit_bio_wait+0x58/0xb0
[  126.407153]  __blkdev_direct_IO_simple+0x107/0x240
[  126.407156]  ? inode_set_ctime_current+0x51/0x110
[  126.407164]  ? __pfx_submit_bio_wait_endio+0x10/0x10
[  126.407171]  blkdev_write_iter+0x1d8/0x290
[  126.407174]  vfs_write+0x237/0x330
[  126.407183]  ksys_write+0x68/0xf0
[  126.407187]  do_syscall_64+0x59/0x90
[  126.407192]  ? do_syscall_64+0x69/0x90
[  126.407193]  ? lockdep_hardirqs_on+0x79/0x100
[  126.407195]  ? do_syscall_64+0x69/0x90
[  126.407196]  ? lockdep_hardirqs_on+0x79/0x100
[  126.407198]  ? do_syscall_64+0x69/0x90
[  126.407199]  ? do_syscall_64+0x69/0x90
[  126.407200]  ? lockdep_hardirqs_on+0x79/0x100
[  126.407202]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  126.407205] RIP: 0033:0x7f95f2f3eba7
[  126.407218] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7
0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
7
4 24
[  126.407219] RSP: 002b:00007ffe7a298678 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  126.407221] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f95f2f=
3eba7
[  126.407222] RDX: 0000000000001000 RSI: 0000000001ea9000 RDI: 00000000000=
0000a
[  126.407223] RBP: 00007ffe7a298740 R08: 0000000000000000 R09: 00007f95f2f=
b14e0
[  126.407223] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe7a2=
98be8
[  126.407224] R13: 000000000040e3a2 R14: 0000000000412db8 R15: 00007f95f31=
ff000
[  126.407233]  </TASK>

