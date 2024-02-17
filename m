Return-Path: <linux-kernel+bounces-70065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59585929C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445011C21B62
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F117E76B;
	Sat, 17 Feb 2024 20:23:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93DD7D413
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201413; cv=none; b=pffEVBdeUyR/D12DoiT0ha0+YHvprncWeGg+DnyZtUOMsXRA527Zk05M/686MLhg7TMcG5nO+z6JvP3K9NTaAL36v9aZoov2P+aTGYZ12OsniKdYRSiENEkaw2bF4QgaeWCNu5Cyr4X/+3wnA0m4PBF886wRGPjxGf4I8rV1u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201413; c=relaxed/simple;
	bh=81u/T7Hkylpl+cYgKVCaUPgCL3ty6xDKnxMpidqLznE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kV4DkkmzSSGjOYmDjHSOOwN0mv2VlXzFcWUM38cpXNmOrDx75m7iQrJijR05+AXKQVA9dJlH0p7SwbfeZ+bfP0VJMQnsOWPi0SP48IIBdKfjeo/HGpVV9VUMmH7uzi1RnJ0dDbVz/GJsV9zRc+DJR9Nc3bmUFxkeFvR63MEhvyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365032b8456so17004015ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:23:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708201411; x=1708806211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vn33Bn8dNbpZtYkfmwI07g8AXjsR+zmg6L34qqGxuDk=;
        b=aS7D/4gTXvKE1apr/mc1irNm6Nsa6oHUiWQbbqq6tOVBTpWeRip4J0DIVrbAsdV9Ud
         sWJWQ+3Sg//3Wpv6dGWnCt/qNkwP+0iBQ1f+do1Aa8CNyARBiNgmdv+Lek4zo7qkKu8M
         YWmrXLz3bwju9R8EPUKlqfm0nzTPHOvLM2GHn5fdp2uE749crrTnA6zk4+hGp+vwj/UU
         Z1zDMMVynWUQgujjfMg20dTfCb8CnvsCaaniSot6pgXpkr75zM4iuFb3oMZxZlWjUgrz
         BQUBI+S+xzlGvQmCGkH46D6+XezZz4rnmm3WrW7rZE0U47rolRQM3P4VvtR/sY/mGzrE
         /4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoUf+ISzOwq8wy4j+yTpSWKRRzkzgSylcTy5l2UNKs9OJL4+MMLZY4Twz3k6FfBTT3u8LLRW6nHDvR/JgogoZXXEkyVbLegZjouFJk
X-Gm-Message-State: AOJu0YyKsW8524keRmlyKNRoWDWwXheAKL7YRT+W/oj7rspDOinRrIXa
	eyrRjH75Zt5uKuXfhjFJODEPOuwV8xdiiVJc7Kae531OKQ1X/PjH61cjkwWEq7ErLQbyqcul1Wz
	8EVIFMTwJFBA8SD39BsIy56i4fW4Q3gNJy9ns7GUKIqXu3Tq+zxsIXnc=
X-Google-Smtp-Source: AGHT+IHJpern2tQOKp6wqFHVEU184C2cGx4e6nZR0wEd1rZi7tziGb8oZhYguRDwBEGagl4eORZL8DvtZcNURaXMAIAGYVYSaisX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2143:b0:365:1780:2ca9 with SMTP id
 d3-20020a056e02214300b0036517802ca9mr226831ilv.5.1708201411192; Sat, 17 Feb
 2024 12:23:31 -0800 (PST)
Date: Sat, 17 Feb 2024 12:23:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000051b17c061199a29e@google.com>
Subject: [syzbot] Monthly input report (Feb 2024)
From: syzbot <syzbot+list163cb1c4023af331df63@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 1 new issues were detected and 0 were fixed.
In total, 13 issues are still open and 52 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4346    Yes   WARNING in input_mt_init_slots
                  https://syzkaller.appspot.com/bug?extid=0122fa359a69694395d5
<2> 394     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<3> 175     Yes   INFO: task hung in uhid_char_release
                  https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<4> 154     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<5> 2       Yes   WARNING in input_unregister_device (2)
                  https://syzkaller.appspot.com/bug?extid=617f4ccb03b9869f6494

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

