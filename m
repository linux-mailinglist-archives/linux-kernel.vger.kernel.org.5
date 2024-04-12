Return-Path: <linux-kernel+bounces-142705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E58A2F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCD9282B85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438828248A;
	Fri, 12 Apr 2024 13:18:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE381AAA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927902; cv=none; b=pQy/C4cWxpj8w7bp7JBtK9Xpv/Lc9GUPOfus5jpzIYDBVxj3yxuCPFvLGsFj7SJqK/7+G5i9zeHPfZeAyT8na4B51fCH+D6Iya5GSr3ZfpqsqqxL4swvTNMkc+jfJzqIClIYSJaDuHqQkrypQT3dhquhsO5p0ADTRNthMjsoTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927902; c=relaxed/simple;
	bh=10LLZDrGOU9wrEZQUx7zq0sXQtH4PdfTYhAVtwrWfek=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sj75DcSRkQT2+6kh1dsSDMoAK4/n9KMje0bEdJUftNIbVLYh4drd158obcz2OkT6bqqeuboVTELXFcckm6jBuyU3RuBUjaBCiO6Av7JZoKoM2YwGWnXfy5Q72UKeZBDRAokIiv6lMZidmy6dv1TPTppyn7UR18+obXAWArtojts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a38d56655so10063585ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712927901; x=1713532701;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Mqv+/ZO+3xx7M9EDTPVKDbLutpy3xdH8I/GFId62E=;
        b=Msb/PynPdT86hWe0cEJQ+Z83AnmCfSkTNpz8IU0xn7jZ9GdOUcooTKYyN6lPTImkBl
         0iybHPfYD6hJO5xbvUsSLQKEIYjC9oDM+PDRlViSm7nOqk5HQie1wIcaPMsum+mQJP8/
         NzGj3g4aMvJqDT8uvZ9NZnZ/z5PgkyHrmtuk7ZXdrba06qVCF/TZVzfZY/hJVZGFMXTC
         NjCB/zhe2xk++KtJQYbfwc7150EgUxhHF/VcmAzjf8Egsb7lO0XEI4uEwChlNWQrBROV
         xjDlZHoBsJlUkyLyueOegafHF8LRlEuv31T3XlL2kTypNQR9CriWcBHoU7rp+YwNT1hO
         WGJg==
X-Forwarded-Encrypted: i=1; AJvYcCWjT97/SRx31dUcWJvJavooilDWTb9rzuO4HxXddJ6Q1PYNNGQoYbJdLeDJYdzaC20A7t+JKCND4W2BxO7sqBf0H6JuiLOODZ/Y0a0Q
X-Gm-Message-State: AOJu0YyW/cZkONihP02DdnqX3hqAd5+m1RvcNuS46Tjb0rCk5iQ7TMZk
	oqu4uhF9DYECx1HJqvNhX6yhKIR92vaA8EsmWjZXaMD/oygKNWxqNiKgbouWEXXmPp0Z3yO/J1Q
	19c3xR9Ebl/K6tx0zwV3/wthBFyAzrMhXCwwlxtPFaT1G2U4DDRuq7T8=
X-Google-Smtp-Source: AGHT+IE8vttjY9NAE6uAnOWzX9Vm1MdDFAe8ZTTMKL/qQ8uy81c+9dwqlhcgD7YXNi0KHYUX52veWeJRJ7fmrUkWYJDoN7o3L58W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:36a:a6c4:2 with SMTP id q7-20020a92ca47000000b0036aa6c40002mr222389ilo.5.1712927900815;
 Fri, 12 Apr 2024 06:18:20 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:18:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de9270615e61b58@google.com>
Subject: [syzbot] Monthly block report (Apr 2024)
From: syzbot <syzbot+list813439a47d944440e6fb@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 92 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1571    Yes   KMSAN: kernel-infoleak in filemap_read
                  https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2> 220     Yes   INFO: task hung in blkdev_fallocate
                  https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<3> 198     Yes   INFO: task hung in bdev_release
                  https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<4> 25      Yes   INFO: task hung in blk_trace_ioctl (4)
                  https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
<5> 8       Yes   INFO: task hung in blkdev_flush_mapping
                  https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
<6> 7       Yes   WARNING in validate_chain
                  https://syzkaller.appspot.com/bug?extid=6647fcd6542faf3abd06

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

