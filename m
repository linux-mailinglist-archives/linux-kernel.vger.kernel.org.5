Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE7D7E2B66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjKFRnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:43:08 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A816B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 09:43:06 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1ef4782ef93so5825411fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 09:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292585; x=1699897385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1chGtzP+NJIdFgX6mTGFRL3WZtTM13gNkwuROiGukFw=;
        b=N3WMd3OyYgSWxqgHepUfo5sQYl3q4zeSrAo5+0X0TmEgCXCgrojmcVJUZlEcCaPd3E
         juJTu3odBJICM4OtZ+0+iH/waeRZs9EVD+dw7R83WF2LqA04cEIkSVxJilwC4X6EHAhf
         Gea0ykEu5tKYH64Zau0Q0m43nDLOd3onB96Pn/8AmMT9o7M/qQ8enyH+XNCtmrYkillJ
         QNNbbY6ATJ2VKenFQTegwRDJk5pWP84rJ0O/Tm12+3xSXgtzH+WEzr3I8HfVIoqi+vhg
         o2w2GwGvQTdHx9nQSc9X5g/Q4AdH30moYhzKuS0iiZDDfCE3BAxgUQyaUjOWqmV4N6uA
         l1oQ==
X-Gm-Message-State: AOJu0Yyu1YkDaL1JX5ALUUTm6btoy4QNtUAYYClUy0v24AoGzpHYRGom
        PUoKDO2W9lQU3p17bNX3PCMzxSEQvZrGNBlZF+kySc7fS6dB
X-Google-Smtp-Source: AGHT+IHkcjVEdRjcu5eL6m0XBcE9ytXj7mJ7sE/Zg/gdx6mMFpuV6p9YbNToaeuWqcnMqNEySMfeMI95rgF/vWVMTNDX5mM93yBM
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d394:b0:1dd:ac4:bc14 with SMTP id
 k20-20020a056870d39400b001dd0ac4bc14mr70837oag.1.1699292585409; Mon, 06 Nov
 2023 09:43:05 -0800 (PST)
Date:   Mon, 06 Nov 2023 09:43:05 -0800
In-Reply-To: <6791f9a2ed4021b183ebf536f340994b@foxhound.fi>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec450406097f6236@google.com>
Subject: Re: [syzbot] [usb?] [fs?] WARNING in firmware_fallback_sysfs
From:   syzbot <syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com>
To:     jose.pekkarinen@foxhound.fi, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in firmware_fallback_sysfs

WARNING: CPU: 0 PID: 5070 at fs/sysfs/group.c:282 sysfs_remove_group+0x12a/0x170 fs/sysfs/group.c:282
Modules linked in:
CPU: 0 PID: 5070 Comm: kworker/0:5 Not tainted 6.6.0-syzkaller-03860-g5a6a09e97199-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events request_firmware_work_func
RIP: 0010:sysfs_remove_group+0x12a/0x170 fs/sysfs/group.c:282
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c 01 00 75 37 48 8b 33 48 c7 c7 40 3f c0 8a e8 d6 84 37 ff <0f> 0b eb 98 e8 3d e7 c6 ff e9 01 ff ff ff 48 89 df e8 30 e7 c6 ff
RSP: 0018:ffffc9000377f9a8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8b377da0 RCX: ffffffff814d2eb9
RDX: ffff88802b036180 RSI: ffffffff814d2ec6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801c3d5008
R13: ffffffff8b378340 R14: 0000000000001770 R15: ffff88801c3d5008
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe076d98000 CR3: 000000002906b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dpm_sysfs_remove+0x9d/0xb0 drivers/base/power/sysfs.c:837
 device_del+0x1a8/0xa50 drivers/base/core.c:3788
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:120 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0xa73/0xb90 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xe5b/0x12a0 drivers/base/firmware_loader/main.c:909
 request_firmware_work_func+0xeb/0x240 drivers/base/firmware_loader/main.c:1160
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         5a6a09e9 Merge tag 'cgroup-for-6.7' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1198425b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c450de9124fc495d
dashboard link: https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1114ab60e80000

