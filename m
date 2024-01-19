Return-Path: <linux-kernel+bounces-31233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F4832AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9661F23A22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA0537F0;
	Fri, 19 Jan 2024 14:04:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C951C4A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673047; cv=none; b=F1V0J7FXJxOVPSiRBkBJDIrvLZL1BgUiWsYgTsuHg1i+VCsAgR9yTkB8sSW6i3AuXnxX1Y/XyuwfpUgeaTixMxYPc+6iKXV/7IcUuuFpayeFnKA13L3FBBvPjxAsbW+nk7gU2mTirvgAo0GhWEkps5GfIPJWXPPB+Oe6xDGd7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673047; c=relaxed/simple;
	bh=G0UMP9/RdniRLz2gJ2RxTiChVaG0soseS21lHcPQp3s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jvh+DkAhTl2QzZaOrFUeMyLp2ypVVPGDIgE/6vfKSePKZiipZT0Ad4dhWgHlTTJfFwOcQpPKNdO0umFb5R4cHhKKkTQVlwi2dILCfpLGI2viALaPC/sbyTKqckyzdTADA90x6jeyO4RrT2ntPzLmQxMqu/Bdc0PJDd3G7/XExRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b7f98e777cso79433939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705673045; x=1706277845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TW0BQflZb9OrkxepL06+BYefBoiex7o4KUY8X0N476s=;
        b=v75ECgqauH4B6bxAAT8As6GcW1QCACp8PSyuHg/V+zwBgoEb6Pxb/6Zj+PbP/sEMNS
         SV5FnZ5gNiEYXVkOdq/lxANVUei7T/mrIF5Kv3ncHu1074aA7H8iyebetGdov/aTAqwm
         wRWTF8pRYRDcSnQBp4+r5fcCv5p/BB8pqpOCeoZ3eEG3sjnRv2TTT0PmX2MBkrj7odRX
         Ffo/UP/Ul/gHKrY+ymdymtOrXKdO3va2f9h6earaMKCZvy6lfE2zWnzpNKT+3Fq3m6oZ
         IL32JYJ8EOg6E7XK/ocB+URoGc6tc02D1Hq93vSYuVehgsjMBRrMb9hGei1GqTcAo4s2
         gupA==
X-Gm-Message-State: AOJu0YxYsTObOY/Xf+rhoHz4RD7r/WspnS3QntanfyJWVtF0hhDkXSk8
	T6GrnYhM7X2ITDwt14T9EWuyxafql5TX3yOtAyKVtklxT5GxHd1FQD2uSyfURgLt9Lo9IM7HKcL
	BiifhfWx/lRbG81PY19jcyT7l0SWrxdC1qM9lGwwqEjw+gd20Q3PBTXvX9Q==
X-Google-Smtp-Source: AGHT+IH88s80aoc9SP9ONj51o6uxojWP52OGTh27VRy4jQ/6VMJU+JYw5mzM+AfJfpXE8dEdfBU6IO63pir8w2jdigdQJwTSh1p9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2108:b0:46e:6732:763f with SMTP id
 n8-20020a056638210800b0046e6732763fmr110104jaj.0.1705673044337; Fri, 19 Jan
 2024 06:04:04 -0800 (PST)
Date: Fri, 19 Jan 2024 06:04:04 -0800
In-Reply-To: <20240119132214.3095-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e92c8f060f4cf392@google.com>
Subject: Re: [syzbot] [staging?] [usb?] memory leak in _r8712_init_xmit_priv (2)
From: syzbot <syzbot+83763e624cfec6b462cb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in corrupted

BUG: memory leak
unreferenced object 0xffff888109b12000 (size 4096):
  comm "kworker/1:1", pid 28, jiffies 4294944675
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff815fa6f3>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa6f3>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa6f3>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa6f3>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff83d23552>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff83d23552>] _r8712_init_xmit_priv+0x2b2/0x6e0 drivers/staging/rtl8712/rtl871x_xmit.c:130
    [<ffffffff83d1e143>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:310
    [<ffffffff83d1ce06>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff8330155b>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:399
    [<ffffffff82c6ef96>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c6ef96>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c6f373>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c6f46a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c6f664>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c6c3bd>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c6fb8a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c6db2a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c69fde>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832fe627>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff833110bf>] usb_generic_driver_probe+0x7f/0xd0 drivers/usb/core/generic.c:254
    [<ffffffff83300c49>] usb_probe_device+0x79/0x180 drivers/usb/core/driver.c:294

BUG: memory leak
unreferenced object 0xffff888109b17000 (size 4096):
  comm "kworker/1:1", pid 28, jiffies 4294944675
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff815fa6f3>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa6f3>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa6f3>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa6f3>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff83d23552>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff83d23552>] _r8712_init_xmit_priv+0x2b2/0x6e0 drivers/staging/rtl8712/rtl871x_xmit.c:130
    [<ffffffff83d1e143>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:310
    [<ffffffff83d1ce06>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff8330155b>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:399
    [<ffffffff82c6ef96>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c6ef96>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c6f373>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c6f46a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c6f664>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c6c3bd>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c6fb8a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c6db2a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c69fde>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832fe627>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff833110bf>] usb_generic_driver_probe+0x7f/0xd0 drivers/usb/core/generic.c:254
    [<ffffffff83300c49>] usb_probe_device+0x79/0x180 drivers/usb/core/driver.c:294

BUG: memory leak
unreferenced object 0xffff888109b15000 (size 4096):
  comm "kworker/1:1", pid 28, jiffies 4294944675
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff815fa6f3>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa6f3>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa6f3>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa6f3>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff83d23552>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff83d23552>] _r8712_init_xmit_priv+0x2b2/0x6e0 drivers/staging/rtl8712/rtl871x_xmit.c:130
    [<ffffffff83d1e143>] r8712_init_drv_sw+0xc3/0x290 drivers/staging/rtl8712/os_intfs.c:310
    [<ffffffff83d1ce06>] r871xu_drv_init+0x1c6/0x920 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff8330155b>] usb_probe_interface+0x16b/0x3a0 drivers/usb/core/driver.c:399
    [<ffffffff82c6ef96>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82c6ef96>] really_probe+0x126/0x440 drivers/base/dd.c:658
    [<ffffffff82c6f373>] __driver_probe_device+0xc3/0x190 drivers/base/dd.c:800
    [<ffffffff82c6f46a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82c6f664>] __device_attach_driver+0x104/0x160 drivers/base/dd.c:958
    [<ffffffff82c6c3bd>] bus_for_each_drv+0xcd/0x120 drivers/base/bus.c:457
    [<ffffffff82c6fb8a>] __device_attach+0xfa/0x290 drivers/base/dd.c:1030
    [<ffffffff82c6db2a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82c69fde>] device_add+0x9be/0xc90 drivers/base/core.c:3625
    [<ffffffff832fe627>] usb_set_configuration+0x967/0xc70 drivers/usb/core/message.c:2207
    [<ffffffff833110bf>] usb_generic_driver_probe+0x7f/0xd0 drivers/usb/core/generic.c:254
    [<ffffffff83300c49>] usb_probe_device+0x79/0x180 drivers/usb/core/driver.c:294



Tested on:

commit:         9d1694dc Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b61b63e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=447c03a4f5a8d571
dashboard link: https://syzkaller.appspot.com/bug?extid=83763e624cfec6b462cb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

