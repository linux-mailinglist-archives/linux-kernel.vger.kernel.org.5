Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0827EF4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjKQOjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjKQOjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:39:09 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D651AD4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:39:04 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc502d401eso26408055ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:39:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700231944; x=1700836744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3ZuRSFmHNLDdVBZSB9HQX0NianTuUsPJjWoXTZRBaY=;
        b=sfD1cdnFuGKs4N5N/nzbVpDWQwlHBJVbn2mvGJqV+cHF755S7Qz6ZlO+eyvu/7T+Ey
         oCJSlVfB7A94C0w7a9qRZBneb03+ysb7SKyOUZnJfpPSiHTtppijX1l8PCK8ppMYbxBi
         IGl6o8N/HJUnN5Pc2gY8zy9/XuCogEx+nNudMg/2KmFKJoj+JJVIReUYGn6V0NqW5cdM
         BZCNg1hAgKJzoYrcZOufrNyxSmrF3Z46GUboCa5bf3fY9XFa6p85Uu+fEBhehzg9UjA1
         z9JzZhct6l6lV4EkHU32wlWU9XfQ0elNI0J9+kP2Fl1xvA+6AOqLy0cUBJvkqnCVI3WF
         Z8gw==
X-Gm-Message-State: AOJu0YzhaOK2l0YoDmtokvmpCty4cnTzX17r58gA5E4BJlXkh3Xj2dcu
        gc0t6qt8kbAeRyLm3NuJ8UCQem+Omttc9JNeruc6dewsQjj6Ik4=
X-Google-Smtp-Source: AGHT+IEfLxsQwWbx6QpprS8l0R+4EpAnBwHSuaGACqJ/4FOS+nBQkadi2QMPMDkQ5FRz0wTxuGEb4U8BnM8xRoR5w0prh3XyBe/I
MIME-Version: 1.0
X-Received: by 2002:a17:903:31c2:b0:1cc:37d1:905d with SMTP id
 v2-20020a17090331c200b001cc37d1905dmr2991562ple.11.1700231944461; Fri, 17 Nov
 2023 06:39:04 -0800 (PST)
Date:   Fri, 17 Nov 2023 06:39:04 -0800
In-Reply-To: <CAJjsb4qSx1FGaj6N0HXJp7cJEo1BQWyYgxTcXVcFNbc5bRZKxA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015e53d060a5a1904@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From:   syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
UBSAN: array-index-out-of-bounds in usbhid_parse

usb 1-1: string descriptor 0 read error: -22
usb 1-1: New USB device found, idVendor=080e, idProduct=4eb9, bcdDevice=d7.f6
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
================================================================================
UBSAN: array-index-out-of-bounds in drivers/hid/usbhid/hid-core.c:1024:18
index 1 is out of range for type 'hid_class_descriptor [1]'
CPU: 0 PID: 778 Comm: kworker/0:2 Not tainted 6.7.0-rc1-syzkaller-00125-g7475e51b8796 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 usbhid_parse+0x94a/0xa20 drivers/hid/usbhid/hid-core.c:1024
 hid_add_device+0x189/0xa60 drivers/hid/hid-core.c:2783
 usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1429
 usb_probe_interface+0x307/0x930 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_set_configuration+0x10cb/0x1c40 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0xca/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xda/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x234/0xc90 drivers/base/dd.c:658
 __driver_probe_device+0x1de/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x300 drivers/base/dd.c:958
 bus_for_each_drv+0x157/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e8/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x117e/0x1aa0 drivers/base/core.c:3625
 usb_new_device+0xd80/0x19f0 drivers/usb/core/hub.c:2599
 hub_port_connect drivers/usb/core/hub.c:5463 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5603 [inline]
 port_event drivers/usb/core/hub.c:5763 [inline]
 hub_event+0x2dac/0x4e10 drivers/usb/core/hub.c:5845
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
================================================================================


Tested on:

commit:         7475e51b Merge tag 'net-6.7-rc2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=158e7800e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54e2bd738b08eef2
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
