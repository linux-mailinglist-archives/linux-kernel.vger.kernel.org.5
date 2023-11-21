Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D17F3740
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKUU1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKUU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:27:11 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166F319E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:27:07 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf6e930886so15311665ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:27:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598426; x=1701203226;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8Df5cuqMqSyizP/11eYl6v0tulaOCao3UPcZKj9MfQ=;
        b=EdeHeXB1IR+uAwlM2gFOv3FJ4IhlAzfeOVGOQZtsRKKpH22eSrlKrPEJ2RgDQzK7Sx
         IJwywj30QVxOMYZTpD7zgzGm6+SdsFYQ06l4S/zCvOpB5tjEeyzb7SoEYoctcXs2nCzx
         cy+3LF4x6f/yqOgERF5QxoZTsp8edHbgo5Dt81JB+cVXliNN27jjcD4PKaH6cLSdHM8T
         CpFVmlh8km7gzx3irIxiMYkgjhuIF18F27Xl3pkZw5z0wShnWhFvyEiZimk5bA+sILyI
         yp9JUMOB9YF2WklNrVJblGhtnLpLUvnL8qh8t9o8JK/6s7eNjUZ4mcj6v0rAcMS72H99
         qi/A==
X-Gm-Message-State: AOJu0YyDATVOtqNhCFOctcx1dSm7nf0odlxMzmHWeA9yp/25Ictl/Ylc
        rrlLGbFSPnkkWfsbwA+KltN5pf4LHbsd60/MezUlKr3aocSP9NU=
X-Google-Smtp-Source: AGHT+IGroASKvRv275OYnuW1udLy3196WexKVfY4CJiC1VkyF1Za3uN6dslnnwU2rHfcZ6dsegf6Oi/dlgmT62TPVp3rcqhsod37
MIME-Version: 1.0
X-Received: by 2002:a17:902:eccf:b0:1cc:f064:8d6f with SMTP id
 a15-20020a170902eccf00b001ccf0648d6fmr50470plh.4.1700598426385; Tue, 21 Nov
 2023 12:27:06 -0800 (PST)
Date:   Tue, 21 Nov 2023 12:27:06 -0800
In-Reply-To: <20231121191815.201459-1-tintinm2017@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c44c9060aaf6de3@google.com>
Subject: Re: [syzbot] [usb?] UBSAN: array-index-out-of-bounds in usbhid_parse
From:   syzbot <syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
UBSAN: array-index-out-of-bounds in drivers/hid/usbhid/hid-core.c:1026:18
index 1 is out of range for type 'hid_class_descriptor [1]'
CPU: 1 PID: 23 Comm: kworker/1:0 Not tainted 6.7.0-rc2-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x125/0x1b0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x111/0x150 lib/ubsan.c:348
 usbhid_parse+0x99d/0xa10 drivers/hid/usbhid/hid-core.c:1026
 hid_add_device+0x189/0xa60 drivers/hid/hid-core.c:2783
 usbhid_probe+0xd0a/0x1360 drivers/hid/usbhid/hid-core.c:1431
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

commit:         98b1cc82 Linux 6.7-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17127f58e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7445bf05fbfd240c
dashboard link: https://syzkaller.appspot.com/bug?extid=c52569baf0c843f35495
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112520af680000

