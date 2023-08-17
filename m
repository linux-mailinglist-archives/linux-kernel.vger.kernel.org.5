Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516AB77FC6A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353783AbjHQQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353772AbjHQQ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:57:57 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0542D72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:57:54 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-563ab574cb5so73798a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291474; x=1692896274;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kg0QE7WFC8jIy1ZqIe4bmipuDdvn/U9mghxu2TvRjdY=;
        b=hSj7IpB+PahhY/Fx2ot+jnDGDfyjHp0homie/bgHSsdRy7zHtr8CqhDZkoEEwc07LR
         KLtD3d4VJ7RAEatiNybDiBWG6UXBS71Zexuj1BqiFXOaLT4RFU7Q5go19uNHCEmZ983f
         BTcmHgRoMm06hTPE21WtxGeXA662u6OVvvyk5W0SBOK3O/ZQofI4pPsevwN5h4zVdwkd
         CYEnYamcMT5qF9LKXMsUE9PwkOxAq1nsKBVo6Be1qXFzYjIy2yWUoXAJN81DaGLo4WCL
         VKkFpuQs1BTpFRwgaP2fZ/0m25SYe/DNjUeM7OAPr4SaHOQS9ozRLm6zomCGiBXYYlWC
         Lizg==
X-Gm-Message-State: AOJu0YwGyRBbKRShm90gxFDndLyPgMbh/dP+SWGiQ+Qn1JVYMvTLHEMb
        qgfUR3Du4JRtrbCdlGT9oWJHiSdzTSQaYv+r8AVu3xt8sHkk
X-Google-Smtp-Source: AGHT+IHwt0gjkRKpc97W+cfpcU7E3G/whLAz1Nq6YNHExHH4HSBlb2RVSmxU1pev+NrhTqcYtuniymiIAXbyb1Q2yGQcFbNObXPb
MIME-Version: 1.0
X-Received: by 2002:a17:902:ec92:b0:1b9:e8e5:b0a4 with SMTP id
 x18-20020a170902ec9200b001b9e8e5b0a4mr2156836plg.8.1692291473831; Thu, 17 Aug
 2023 09:57:53 -0700 (PDT)
Date:   Thu, 17 Aug 2023 09:57:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027870106032150f5@google.com>
Subject: [syzbot] [media?] [usb?] UBSAN: shift-out-of-bounds in set_flicker
From:   syzbot <syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com>
To:     hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    55c3e571d2a0 USB: gadget: f_mass_storage: Fix unused varia..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13eead53a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7789f2bd4d1e7af
dashboard link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dfaeada80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ac7d16ee63e/disk-55c3e571.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea99a7a9832f/vmlinux-55c3e571.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6848258d554d/bzImage-55c3e571.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com

gspca_cpia1: usb_control_msg 03, error -32
gspca_cpia1: usb_control_msg a1, error -32
gspca_cpia1: usb_control_msg a1, error -32
gspca_cpia1: usb_control_msg a1, error -32
gspca_cpia1: usb_control_msg 05, error -71
gspca_cpia1: usb_control_msg 03, error -71
================================================================================
UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'
CPU: 1 PID: 25 Comm: kworker/1:1 Not tainted 6.5.0-rc4-syzkaller-00118-g55c3e571d2a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_shift_out_of_bounds+0x27a/0x600 lib/ubsan.c:387
 set_flicker.cold+0x1b/0x20 drivers/media/usb/gspca/cpia1.c:1031
 sd_s_ctrl+0x2c6/0xbf0 drivers/media/usb/gspca/cpia1.c:1782
 __v4l2_ctrl_handler_setup+0x511/0x710 drivers/media/v4l2-core/v4l2-ctrls-core.c:2481
 v4l2_ctrl_handler_setup drivers/media/v4l2-core/v4l2-ctrls-core.c:2498 [inline]
 v4l2_ctrl_handler_setup+0x50/0xa0 drivers/media/v4l2-core/v4l2-ctrls-core.c:2490
 gspca_set_default_mode drivers/media/usb/gspca/gspca.c:908 [inline]
 gspca_dev_probe2+0xdd6/0x1b20 drivers/media/usb/gspca/gspca.c:1541
 gspca_dev_probe+0x18b/0x270 drivers/media/usb/gspca/gspca.c:1610
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:956
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11f1/0x1b40 drivers/base/core.c:3625
 usb_new_device+0xd80/0x1960 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x2e62/0x4f30 drivers/usb/core/hub.c:5822
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2597
 process_scheduled_works kernel/workqueue.c:2664 [inline]
 worker_thread+0x896/0x1110 kernel/workqueue.c:2750
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
