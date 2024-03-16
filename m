Return-Path: <linux-kernel+bounces-105176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F17B87DA15
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A544CB21079
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C618036;
	Sat, 16 Mar 2024 12:09:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328517722
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590968; cv=none; b=n4rZxm02/HWRXfCV0fUqSFD3INkkFmVPTlIxsXonvoyMu25fwhsLckn4WAKR+CgSdlVd5sG3LF7gyQs9K4JfoDz92i28Ivpjd5Ed/d/uCdHfOWDShAO3ynK9I33/IM+yGlW5GI2FIAv9GOOru9+hk74mR/NyCcGTEDNZsL+WCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590968; c=relaxed/simple;
	bh=OFqpG2u95CTHKj3kiWG8U0Pt/ngyH6TQPFJ5yqRP+yg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fbzK4QzLlPnxH9ciwPzKVKjgXCpNwLFAaDaigd+HUioJFnjdcp8go3tms44q+pVlBBGs9oaf5Apax6ill/XO2EL9n6Pd0C6YkyqaWs6M3zEBI9W0AYu8kUiRPMTtojGpX4pOrcY9N9Myi/0DsinUgMbE044Uh+PS55onghBQ4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36660582003so42153625ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 05:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710590965; x=1711195765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBkvNjKAtbHEtQdfCVzshZvUM62vA91GLq3QAxf7k2g=;
        b=gxoUMwdOsIVqkTWZKwZS6PHhchV2qZXlcYOWAYGjIIR5trdv3jYm5l79No2nVOkdSs
         yNgkJHvSuRANZvuY2c51buOyEy0m/O2HVy5r2gaTpI8HoXK9FnJFC5cu6TqPpTBt1oI9
         mEPBCQY99Zh3HVzOZA7MDHfIgR/9OI7vpwew0q3R8EvOmfCBX+YhzpRs0EjmcWzsil/2
         CEMzCZ8aAVtWhI1CuU4dXmGEeK0wCwvxvdYPr40waxXgXBV1JPy7SCP4pIU9ewRIyn/8
         VPHS6+8t6qEstO5V2GXoOYJjLif+WL98x+pTB3YUUSHepC46z7SdFg6wflvwmRzj94eJ
         TcVA==
X-Forwarded-Encrypted: i=1; AJvYcCW7a42B3X8JxsjfeiG2RLUd9WRTrcFo/AnVUekOGGk3e+FZj8Lh/Lc/fbJsPWBu1/3l0QZPmYPifGeZi9mGhDUYWYVO16OH0jVkDiOH
X-Gm-Message-State: AOJu0Yynqnw8gyfD3+1/GQVLZffOqJ9NmlLZ9tptepDgS4J435KXypOO
	ioPi03VOa6upA1naDmD8kYLdB6yaoNoSKfNZJOOhd4VjIqB9n2DaMxgrBdIBZ8+T34Lx/WI04Ea
	6lf8zGnddX+SPFdDVBEbaB7cGhb+kV3evHAYxUMP1v2xHLH6hapIGEwI=
X-Google-Smtp-Source: AGHT+IHBDSGm6qgrdNZtdCvk0lrhV5I+K23cilpOGSz1XR/vrUcw1YAMgWunfM+R4KQ0ES6QNjpdZngAyZtFZY3Eu9/0VvsVvmiu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:365:5dbd:b956 with SMTP id
 h9-20020a056e021d8900b003655dbdb956mr476433ila.3.1710590965746; Sat, 16 Mar
 2024 05:09:25 -0700 (PDT)
Date: Sat, 16 Mar 2024 05:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de9d170613c5fe46@google.com>
Subject: [syzbot] Monthly fs report (Mar 2024)
From: syzbot <syzbot+listc1ea4dfa31fea8381e9d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 1 new issues were detected and 1 were fixed.
In total, 40 issues are still open and 341 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  233     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<2>  210     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<3>  73      Yes   INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<4>  62      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<5>  45      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<6>  36      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<7>  35      Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<8>  21      Yes   BUG: unable to handle kernel NULL pointer dereference in do_pagemap_scan
                   https://syzkaller.appspot.com/bug?extid=f9238a0a31f9b5603fef
<9>  13      Yes   KASAN: use-after-free Read in sysv_new_block
                   https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
<10> 3       Yes   WARNING in pagemap_scan_pmd_entry (2)
                   https://syzkaller.appspot.com/bug?extid=0748a3a1931714d970d0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

