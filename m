Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95F17F67A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 20:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKWTiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 14:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjKWThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 14:37:50 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2B30DD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:36:35 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc41aed6a5so12918685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 11:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700768166; x=1701372966;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+A9PJEIs87A1VlXJIAa7rv7twfRr8/F4BoeMDNQkMM=;
        b=K24Zd4dUwb5F6JW6XXGwKPmF0gLt2AE8DZcKda/3MY8lr13plRuMvHY9kt56jIyO2F
         kTy61KCb+e/zY1KqurLyK32SCzkAJWmSmyE+7Y1Ql+z8Cb69leizq5lx3h+gt3IvERqm
         dI6aQt6ZK/oIRjRULk7zaZPaQ+8+UY8ZrYy7w2kLk698eE0Upjtb7AGv+gMFbeB0mEQ8
         FazQVQtnnoH6p7hwWkatFD8Q4iYg94RgILlbwosTTRiDup5sYNAYUIHN4EMxE1u8QLmE
         90Mt4kuL2SYiDv6aPyRTi+CT4d4/Izl5jNZdkAAUMIbJ9s76aMP/4QMY9c5u8Pv3u9pM
         ++5Q==
X-Gm-Message-State: AOJu0Yx4bssZvVb4v0aMe8na+D+HmcX5AsdpKMDeSABMcX5CnL8u2MVF
        g1t2TROgAUBLcnusjY0VuBbDhnnRtMkB61Q6Rn9S6hpOrNjTMKs=
X-Google-Smtp-Source: AGHT+IHn3I7TMnTLmLm66gozmb6up19NaUXz3ud/upi4g0HVhe7yF6rzzKcqWPv6UA58CoJAsJPvIe56RzN53ltsdnnnSXJ1V9J8
MIME-Version: 1.0
X-Received: by 2002:a17:902:be12:b0:1cc:4327:8bbc with SMTP id
 r18-20020a170902be1200b001cc43278bbcmr99528pls.10.1700768165929; Thu, 23 Nov
 2023 11:36:05 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:36:05 -0800
In-Reply-To: <GV1PR10MB65630A7C27259A0F96F488B5E8B9A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006029f4060ad6f227@google.com>
Subject: Re: [syzbot] [usb?] [staging?] memory leak in _r8712_init_xmit_priv (2)
From:   syzbot <syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in _r8712_init_xmit_priv

BUG: memory leak
unreferenced object 0xffff8881085a3000 (size 4096):
  comm "kworker/0:5", pid 5051, jiffies 4294944413 (age 8.790s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81633f0d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81633f0d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81633f0d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81633f0d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157ed95>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff83cef2a1>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff83cef2a1>] _r8712_init_xmit_priv+0x2c1/0x6f0 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83ce9e83>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83ce8b36>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff832d15eb>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:396
    [<ffffffff82c3c336>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c3c336>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c3c713>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c3c80a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c3ca04>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c3978d>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c3cf2a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c3aefa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c373ae>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832ce6b7>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff832e138c>] usb_generic_driver_probe+0x9c/0xf0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff8881085a5000 (size 4096):
  comm "kworker/0:5", pid 5051, jiffies 4294944413 (age 8.790s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81633f0d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81633f0d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81633f0d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81633f0d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157ed95>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff83cef2a1>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff83cef2a1>] _r8712_init_xmit_priv+0x2c1/0x6f0 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83ce9e83>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83ce8b36>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff832d15eb>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:396
    [<ffffffff82c3c336>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c3c336>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c3c713>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c3c80a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c3ca04>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c3978d>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c3cf2a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c3aefa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c373ae>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832ce6b7>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff832e138c>] usb_generic_driver_probe+0x9c/0xf0 drivers/usb/core/generic.c:238

BUG: memory leak
unreferenced object 0xffff8881085a7000 (size 4096):
  comm "kworker/0:5", pid 5051, jiffies 4294944414 (age 8.780s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81633f0d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81633f0d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81633f0d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81633f0d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157ed95>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff83cef2a1>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff83cef2a1>] _r8712_init_xmit_priv+0x2c1/0x6f0 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83ce9e83>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83ce8b36>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff832d15eb>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:396
    [<ffffffff82c3c336>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c3c336>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c3c713>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c3c80a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c3ca04>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c3978d>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c3cf2a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c3aefa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c373ae>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832ce6b7>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff832e138c>] usb_generic_driver_probe+0x9c/0xf0 drivers/usb/core/generic.c:238



Tested on:

commit:         d3fa86b1 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=142ccff0e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1b9d95ada516af
dashboard link: https://syzkaller.appspot.com/bug?extid=83763e624cfec6b462cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f560a4e80000

