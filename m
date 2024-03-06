Return-Path: <linux-kernel+bounces-94633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41D187426E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BF12826B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301B31BC53;
	Wed,  6 Mar 2024 22:08:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84714276
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762910; cv=none; b=Wyvr1tyygBoR0L76P3ocXilmhyIUIb9z+ZKweERQJd35C7ArdJ9/21A6qZR87vIfaQtDAARBOuVciacpvtSl6In02FZdq21ekwox02EVnL3SJ2szeaAn8aiB7K2u+wCjzbD04yZmD4uNmj7ZFEwxvG6c3ouUYeCcMSz6n3DcReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762910; c=relaxed/simple;
	bh=dNOqznjn5ybCeBNvEHvHzB1UiUrXUN/Sx+WiTzgXgAQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f5LovwXB/5ks/3rBHQzET5bHCMxHvX9zBUbj2NrOd6LiA7eRqtRg9lF0vSfzpWFNl8SHdYguK9BKx4XjsYEAK6MQ56FSSubXBl9WsZs+a1TdqXSwkrjGQI226JXpD6BnAN1eavPgcoTM/eIDjtdwSD7Wi6eDMs7O1oHWUWUreMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8772ee3d4so33398439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762908; x=1710367708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPu8pxVqA/GG5U4nME77kZYjgEqZsNQoKccg4F1Fbto=;
        b=eRIMjqn9UDS9C0LZY0nPlW5Hv9vGGN1nVTiB5mL3atJFO038CLYCaQMqH72jrbKeR2
         hE6zLe3V0TzSOq8yibLGu9ecZ/9preLd5ufTrEoKKLJBJoTTf4XhssxxgfXhnpv50mvO
         N8XF2400LIltKEjvBmu5K+R4MToCgVL9KyPt6TJuVeZtnh8I64b+IAiXwCglAPAHK9tU
         GbpJn/ONNApYySrvyYzrD0dOCqGpViRNQkhyJXHkdEbBlkewQyI0XYpoaE1apm/Ch8Gy
         YrwrLcqnSE+J6KNxAqe/BVSVOpkWr9q9WfY6gVlzgRzgu5h+Fy3gfikDxW7Rih72vqr6
         T1jg==
X-Forwarded-Encrypted: i=1; AJvYcCXHW7kF2+WP2l153cZ7UnfynUMU1hg8njJFPO3JjqP9j0RzGU5KOnWrxqCHpwjPEcSzKHVwoINz3X1tLYRGrNJqcFFRhxJ6c0HphhOn
X-Gm-Message-State: AOJu0YwHDHjUASY7NKKBsYBQLudwOdELbZvI5LVJKw2x9pOwS4abAyRL
	TZUO1dRDuqG15arBd5v9+IDTp9DD1HvnUbJCWDnl6vj99FkVlVH5oS1JhehfJ/9LMb6zufJe4Ce
	Z6aiTtq21kMPXZl8l7UIoG93pik34qvutR4iNsugvRtHPFOEQLN8HLGg=
X-Google-Smtp-Source: AGHT+IFT54PwmYZVmKNdY/zZEIrOxYEj2j4cSTHIIWkUIsJC2vOOFniTTNhegl5L9CWatQyJEHqxOxVG3obWaC8kT3t3xHzCuCiF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b0d:b0:474:eb37:1f51 with SMTP id
 fm13-20020a0566382b0d00b00474eb371f51mr415581jab.2.1709762908565; Wed, 06 Mar
 2024 14:08:28 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0c5a306130532ba@google.com>
Subject: [syzbot] Monthly bluetooth report (Mar 2024)
From: syzbot <syzbot+list13832dc108d3458e33cf@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 5 new issues were detected and 0 were fixed.
In total, 29 issues are still open and 60 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  17714   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  9531    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4920    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  3400    Yes   BUG: sleeping function called from invalid context in hci_cmd_sync_submit
                   https://syzkaller.appspot.com/bug?extid=e7be5be00de0c3c2d782
<5>  1369    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  189     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  45      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<8>  22      Yes   KMSAN: uninit-value in eir_get_service_data
                   https://syzkaller.appspot.com/bug?extid=5e132fbe94a9ede456ad
<9>  3       No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
<10> 2       No    KASAN: slab-use-after-free Read in l2cap_send_cmd
                   https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

