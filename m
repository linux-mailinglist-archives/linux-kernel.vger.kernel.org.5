Return-Path: <linux-kernel+bounces-63717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF418853392
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F627B27E74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDDB58AC5;
	Tue, 13 Feb 2024 14:51:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9277D22066
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835866; cv=none; b=iGUFNkqPdS1nY6xiJEULCwLQTvy0DND+eaU6W/9N3OkNuE9rSh2XMJ6Ujv2bZJXhaJMcbFITYldZfL5RzmXbIoregBci70jgTHRis9BCVGXJDLYqtiVDKdnfqnsdLkoW9Y8amjPjL65EjRBWYDe8h+zoiqwNkQo62F4PIxrTQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835866; c=relaxed/simple;
	bh=Uck0XutKhGVw27em880EaR5i30Ve1Tad9T6qzaKbHpU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jo0gGo5uG05km698PU1StGNFI9cR1TMRXDrsluDHkAZclkUkbs0pkIDEIre2XdbF7KEck1NDuV9rYCAUSAqNxTW3RpUf9Nj2xWWYqXu4bhMsyEMs2RGo/nAjJA5v89JcuVa4TfDC4OrDHwlfh4rjDxysoEIL8aJYi7RXAZreOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b6ee24d3so34256165ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835863; x=1708440663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYlnebGOtSb69zKalPEo1O2aZMfj/sfohaXKKNt7vKY=;
        b=mVDU+A9mBI819xTdVo/l3VfLmpNkqX64Xl1qmbcWvA0v/JoXo5i4mdeAWCAHN9ZIPO
         cPJ54H1Zd2AUuy0prz1Gry9/KR3bx6jDZFP3PVaFehlK3UgSvRPEK/xHkcSDsKWj8iNn
         Y45MVIPKaeVYu64WcwAW6W0ry/aaElkYcmUPDpfrlqAJ8LtlXz/Fe61yJQfOzS6CE+K+
         RfSfT4KAJlLdye0wzSOaM/lp05d+zSvlCVqERiSdjJLkjS4HcVecyOh79NiZPdbaIYza
         Gj1rv+QaKnp25O/Vs21nD+GGkY5RKlHBT0wjmf/brxESU1u4U/C7PazsVuwk5c6yb9mt
         JFLA==
X-Gm-Message-State: AOJu0Yx3WPFZrCyLRm+X9B11dfyXZ8L4KRrkawSSm7GtWOje1KY/rly8
	C60az4WFZWwqDPEPGBP4tcvzyUAniKG8JlepJrQ6joeJAEMgsj2OgxzUU5czOHDupEWRbXR+DkM
	tdZtFNg71YVBUoxP104jw4zfBsssFIU/+bnzIGbnbLY9gXmpXvMwsKVumYA==
X-Google-Smtp-Source: AGHT+IHiNTJ3hOU9Wr2fGxFbspU42u8/CqTxIfi4t0iIXwAgAYa3G0SJJ0y+HCZEeBbLeyAmOzONWnhCznplGZiKDb7NbeEXbTTe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:363:c002:719f with SMTP id
 g6-20020a92cda6000000b00363c002719fmr743040ild.6.1707835863778; Tue, 13 Feb
 2024 06:51:03 -0800 (PST)
Date: Tue, 13 Feb 2024 06:51:03 -0800
In-Reply-To: <20240213141308.3138-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fed2a7061144854c@google.com>
Subject: Re: [syzbot] [wpan?] KMSAN: uninit-value in ieee802154_hdr_push (2)
From: syzbot <syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in ieee802154_hdr_push

=====================================================
BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inline]
 ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
 ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
 wpan_dev_hard_header include/net/cfg802154.h:524 [inline]
 dgram_sendmsg+0xd1e/0x1500 net/ieee802154/socket.c:677
 ieee802154_sock_sendmsg+0x96/0xd0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x30e/0x380 net/socket.c:745
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x4a0 net/socket.c:2674
 do_syscall_64+0x76/0x150
 entry_SYSCALL_64_after_hwframe+0x6c/0x74

Local variable hdr created at:
 ieee802154_header_create+0x4e/0xc00 net/mac802154/iface.c:360
 wpan_dev_hard_header include/net/cfg802154.h:524 [inline]
 dgram_sendmsg+0xd1e/0x1500 net/ieee802154/socket.c:677

CPU: 0 PID: 5449 Comm: syz-executor.0 Not tainted 6.8.0-rc4-next-20240213-syzkaller-g46d4e2eb58e1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


Tested on:

commit:         46d4e2eb Add linux-next specific files for 20240213
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1553bdec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e558550134480d4a
dashboard link: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

