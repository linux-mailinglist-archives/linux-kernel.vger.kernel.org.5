Return-Path: <linux-kernel+bounces-92228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E426871D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF151C211B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50F5A4CC;
	Tue,  5 Mar 2024 11:10:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4A59B54
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637030; cv=none; b=Vp79XUf02W6r6FUk9WOOVX48I7Yq7rVUN+dDgq/O0N+jOGdleU1dS4i15T0tsWIyWAYZoP/TrUasBj+ePdtkK6WQ/lTSZ9lkzv8TfPkRxMS4n1yumlkj8PUABuBSicSXilA2txaEc8Djlq/NRi0wmmqLJGbtc30+GOvnrq5AGKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637030; c=relaxed/simple;
	bh=QdedY/MUtdPYew2UtoXQQZq7W8eZj45MkqVOtzMgcak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kwLM9XKjmw3ffFlmykia8CxAtYVivk1QK0e4jXeEuBDa3+mAwBG8zrgBqpr7ppGDILcxnz8uIQhuS0l7h1UPb+SAA1Q4BOuxMKp/lYn2c2+LTbXmVD/aupKTVQqu8mOCPgO9xs4+ykEw+uytIAftuyrN5XUOW5w200LZAVMji+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c495649efdso716512439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637028; x=1710241828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2R1WIqVBRG6442yw7vjn9+5OhQFpW9A/GTiTm4WvqB8=;
        b=tWfJPUyfvlu+IgcgtFvw7WoGTDnEcIoZem6o2WPbtFXm36BEk1RKMZZWLLUqw2Spr3
         R0mslAvNG9UjNQUsAhNJTrhCTbszxCJVi18VQeV6ljuO2bfB/07djnUwoEEudYbIfqJ/
         a+tZbAv8m9ooIF89AzMOg91HxIZ+0ocgZpK9r7FY7/vVerf2tvzrn+ftSuOu1d+fe/+n
         EVB0y87ajrs+ehQG330OuNxpQDcVAZfKOst/fvekdksvcAyC3udT1wQC3orMEmWSJK48
         RWBjY8vSURQGRtivSkWIGVAcLRoRCJ/nH46mcBKINp4c0BlVPZdh8YR61XJmHxfBYMfC
         jAqg==
X-Forwarded-Encrypted: i=1; AJvYcCWlBtyovf9gsbAB56Dml9vq9fLyfdxWH9wsOAjgo2AYP2AtqIE7UaD+qnAzIga6Dr0AOm4wWobW8C8bytckXUoaZOplaoKsOjOvBpsh
X-Gm-Message-State: AOJu0YxNnfYX/yk84wTxUttIr8q330qPO+TL02w/16KTU+pqSt2tNZre
	6d8dyT9iLRtXEE5KaCu6ROFU9IX1YT6VoMj91Z97192185PUocLLk68LjCDpQcNArdx3TJjE5TG
	+LAvRvjqrdTr+/11WanuhxAcGWD45KO7oG17XdPj6q4hjYGSlnp/L+wM=
X-Google-Smtp-Source: AGHT+IFQZMZXuQZFDtC6pA8mQYOrH6pqBHZlIrJ1O9F2wg091ORDRY0Z9DKNqYmj6uOx75rlKIj1eAl8GnhuS46j4nmp+6Gexxzu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c9:b0:474:f25a:6fb with SMTP id
 l9-20020a05663814c900b00474f25a06fbmr317105jak.3.1709637028211; Tue, 05 Mar
 2024 03:10:28 -0800 (PST)
Date: Tue, 05 Mar 2024 03:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2fbf10612e7e3ae@google.com>
Subject: [syzbot] Monthly serial report (Mar 2024)
From: syzbot <syzbot+list97f3ea5e2a4b53b98e7c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 15 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 51700   Yes   possible deadlock in console_flush_all (2)
                  https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2> 4959    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<3> 156     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<4> 41      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<5> 16      Yes   BUG: sleeping function called from invalid context in gsm_send
                  https://syzkaller.appspot.com/bug?extid=b687fe9bf10db0839715
<6> 5       No    KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

