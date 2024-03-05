Return-Path: <linux-kernel+bounces-92224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A36871D11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E651C233C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318D56B7C;
	Tue,  5 Mar 2024 11:09:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52364548EE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636966; cv=none; b=peAj7gvvSJbWxMyXR0j0SAzjzNeLWVzSyFNf2oTDNc38TOEZO6zOWzqo4ea9wqnx4ax+vrOw1z9CqQSk3QrCRqkOkEkFq/suEhO7roWS3L0jOrI4hnCLK2JuVPb5B27qp36Ho6Y78D71pBb3J3upnol4Nb3I90PG9acV92G6pmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636966; c=relaxed/simple;
	bh=YGFkNFR6BVT4HzZEwFfHVNLmz3rtTFWjnXbYP88kSxk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qgODXqfy8J+suO2oWbmrxnYG/C+4Hta+bFAOZGZE62KXzSYW/JsImTcpAc4byaEyrMDYLzv/XAzEvC6Rlh4E9GUIPXl/llG8eUbYdRhpDKUqcYVrtvG+Vj37W5J8xGL4A6boq7vQIcvLhlYdwnUoA+pV4DUkF9PRbETEMPu40bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c49d118546so438761839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636964; x=1710241764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NINenztmi1JIDOL7+T+uX7S56DXuTaxMwu0U9sYeZh8=;
        b=hruYg1RJPpM2a7bWaU6CHr0AEupHTFZKVlM6mt6xwFxR+afXSTIeC7Op/ZuDh8un+O
         T538V0jbi1NpO459+9n7F8ey2d3SRTZBw4TM7O0AlMgNnYOwvThvX1I/YMgLZ7RZrLR/
         0vXT8QB18mSb31RdbAZidym2QzLbynpPCnU4HfLL6/BomIqhBHH8r731fVnTdVSLl0Pz
         Swpe4PvFerIMEPUsYqfz8+k9C6vXy+V8GbcHKwSHZVICJtmwL/3/1pnN/wmLIJs17TYR
         20U9RqzR3OuHT9GkYdp09pkITjHPYlLTZng91NLgHZK6AAq7EwmJKB7kVQYzbo16zwrj
         P5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVoErv6TN6R5l9FI6IX+8iY4T4QJM84Y5Faz1o7GaCKOzt8BTMKc3SzgsFOp8FxiRWToN/Ojz/MaTI4kd8Pp7kijQjZFwxEgQu2yENl
X-Gm-Message-State: AOJu0Yzpl5EyxB/ouqySDw3ALM5oZvSsLSi3Pjd5dtJ8wFIhEXOxJQaz
	9h683MPep82brcEh3IhOGvQIrcvh3J44L2uVY9KnXSeYjBIUGCypkEf8TsG75iiXehPMjWJQ6Jw
	LrjiiH/qq3dzpJMUBWJY6/AFECkUfT4jQstoLkgJc6EbG4Vu8pJYtlPs=
X-Google-Smtp-Source: AGHT+IE8tLV4V8t6SSMxemP9bmpaV+de9LW7kK6fYoUBrxgLrKYcz39WotJL8USLPdsfzWA0LRuRhuqaoYh+S/SiAs0RcNxheZBZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:474:d2f6:f0d1 with SMTP id
 v39-20020a05663835a700b00474d2f6f0d1mr71197jal.1.1709636964623; Tue, 05 Mar
 2024 03:09:24 -0800 (PST)
Date: Tue, 05 Mar 2024 03:09:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8b0ab0612e7dffa@google.com>
Subject: [syzbot] Monthly ntfs3 report (Mar 2024)
From: syzbot <syzbot+list6abea8b8591745b4404a@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 1 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 41 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11885   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3848    Yes   kernel BUG at fs/ntfs/aops.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
<3>  2589    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  2164    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  2136    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<6>  1940    Yes   kernel BUG in __ntfs_grab_cache_pages
                   https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
<7>  1785    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<8>  1003    Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  672     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<10> 645     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

