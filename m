Return-Path: <linux-kernel+bounces-94634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35320874271
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91091F256CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B991BDE2;
	Wed,  6 Mar 2024 22:08:31 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31F1B946
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 22:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762911; cv=none; b=KNBXQweXLwIuWLurXC+A9pA6Fk7IdUsKTF7/MkTAmXYLDoA9AJpEDs9fCcTOxXhCpT33HZEP4Mt3x3kfo41oH6RN6gF9w9yZHeuIwSK2feAOBINhfTcLLRczOIs7W7Iz0FGf8pX6k1eu5bu5oBa7qolsPUPUOHRp4r3tf/2/8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762911; c=relaxed/simple;
	bh=aLqD1qqrg4H5cW6Sta4E4emtGDDwylkjtBqP6jN8U8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cTU48EK7VZuwIrS8fDQROp3utCLZAv8pf6nlDBMzV2oeIotkDJZvo+Cw7AvKN/8nN0/8vFLX+7TJ6b9N3kcyi8QtTNmPPR+nkfcAR1Ip4xiToXsy4vl5N63X59SMYr7B2K97HIUxC63bfxlHoPNnLvNYRpOz2c9XAYlL6vWBjw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so32077239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 14:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709762908; x=1710367708;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ydl/05qviZ59DUb0+tYjcpB6jNkUerBbrbnghjwTq8=;
        b=reveCmW64LTu7XXbm2t2KqoIg4PzrF7Yhhdx8N8QArlwraY5ZXosg6uMMzN4adg5NU
         PVcdOvwTLes/oSFUxivSIKVfwYsgvKLH+JkQc8EbH2a4B5CgDUiDXDhKPzgjixiV9SYn
         us4/f4gVDLfOdXOrJW0/IMaTHjPyqUhkd5bGdxAUr8g3HnfgrUQwKJYLKfdSn0aX1X7r
         diEOCx0PYhetejBcQHS/7Enm3zoPH3Db2T+L3kjT5mKFFpFn2CDHwn26CLDDYH2S1uMr
         SRkbZZ5sIvyF16v+j3Q30xbrFspvqCP2bW8uzFuaaZZML9wecPi6HFvqSI3+UKewNPRG
         a1Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWtGmKaeohhXKoPNGrnT4YZyWcEekowoEKderKrI4CWCoBPEUMqBBL09mOZe5jmB7tfeQ11hxsJZvpQ5p156QSLqLfJLJcmMP3GQrjH
X-Gm-Message-State: AOJu0Yydl0NtmO2ldUemO3bpc8tihBy7NkCV6L+j6qsHb6XCQheax/4c
	BGq/Oude9IzWr5KYFnyHwIqsEKU8vsJ+nneoKq10P+2Kxwv7XiT1zFnhMGpjzXsq334SBbgnEqE
	2REVWAlMehsX+SweVGg2yyRRm5pluAr1ok1yCyZX+pJ9WTxKvbMmFjAk=
X-Google-Smtp-Source: AGHT+IHR5Fsp+gGDp4OcyRnoO0IK33EA0UpUzzcluBuUVwW4wDXOTe81M5JhSUqqlYaFC9Jb17KkZBZ1+SYYbowiauDgOoKSai0W
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4818:b0:474:dc73:2aa4 with SMTP id
 cp24-20020a056638481800b00474dc732aa4mr576597jab.3.1709762908799; Wed, 06 Mar
 2024 14:08:28 -0800 (PST)
Date: Wed, 06 Mar 2024 14:08:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4506f06130532c6@google.com>
Subject: [syzbot] Monthly exfat report (Mar 2024)
From: syzbot <syzbot+listfd275f6d56fcfac99f4b@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello exfat maintainers/developers,

This is a 31-day syzbot report for the exfat subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/exfat

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 14 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 362     No    INFO: task hung in exfat_sync_fs
                  https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
<2> 59      Yes   INFO: task hung in exfat_write_inode
                  https://syzkaller.appspot.com/bug?extid=2f73ed585f115e98aee8
<3> 43      Yes   INFO: task hung in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

