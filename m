Return-Path: <linux-kernel+bounces-163452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0B8B6B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E188EB21ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBDB37719;
	Tue, 30 Apr 2024 07:12:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAF20DC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461149; cv=none; b=WikEA8prcz59DnwgQ9UVj9W9LXyRsXCbYO4UB7uP9UcQwgSdfvFjIEZkJYA3BhG5xd6lfek3OK/hwXAbjWUXA5plNau5OkKphaLYiXcQsm0MDfo30xN9XGSxitmmzGPIMwl8dLAXmtM9P4cS66Gc1L/lZTGYKm6qNnwts8uZxVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461149; c=relaxed/simple;
	bh=YKbHQ7+DrpuKs/BKqxo5iJkOTSM9So8QbVCvBQj2fEQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HqSenCQGSnosuBSzgEkIzVYKdyAF/X00EJEnvsJ1WTGKZp6EqPpFx+uQSf/xRIdj8eiDRrop7YaUN5dTVaM16rpGy3MYYsM6mx49hA7u6iqGSM7VIAEWOCNGMGC57KBe0+Sit1ltUmodk3ALgFvpKwMvzafrFA1l7spAyqsFRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso611882139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714461147; x=1715065947;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4r/M9mVoHzgKMM4Alitf2mS+gYX2JYeQm5phPBvoZ5E=;
        b=xConavxsNMed++p2AU8CN30c33OPp6R9INyItrPML1A+5PJNBZ/vG+PpKh33BUHtby
         SGOX4yUd+paNzykJirwgCw0N8ZTNiSkq+99Fj3+DXiSUTT32GC+U9rqBlbZkLEW1B/Ml
         2Fg7KWUW7hY+SS7mwvoPbr1Qtt8igDBvge5AjZgL3uK3T1lj6feRkXdDYAZNBbaNhkTA
         tEyN7deY41QPRe7zwpl1pZ2dOQCSnpfXD5oFhuGximX4Dfwy7o+7Nwrz4J/Kgjo1o9l2
         SaFT9aI6WJWpMRY6O8bTWrKeiW3KZWCY2++M0OHEGJzVfuSg23muaV6VqlQRgAUVbItO
         aq1g==
X-Forwarded-Encrypted: i=1; AJvYcCWap5RzRwJwwWvvsN6cRIx7/IsiuU/lUCefGfscjOQecuN6o0Sf0mm/rus9OoWNtYMWnLp4eauD+o8UYgfCpIY5hpHi40g42uotCtcb
X-Gm-Message-State: AOJu0Ywkxv7eAtHsle2WqeeYCyzPYa39m5xRdhbssFUDhdOJnR5vKWs7
	dNfJ0kehvwoxntT+ezi0GByfzex5eM8MdndUhDGSFpRVLR+NfOK/XdNKeHwt/Qfv83vgP20iopl
	MJdbWxoEiSpB2H89p/1MkxSbkqsT/aTwVIoYEUd2UsnP7SpuofJl+ZHU=
X-Google-Smtp-Source: AGHT+IFj9e8GCmj+12GcGndXBWrtWWwI61rth8HpP5Zyg7gSTF+bE1SVfqk714WViOFbyNrWPHiOHIi+Aaz4Ustz5xBH7NsNzZES
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8d:b0:7de:e182:ddf1 with SMTP id
 i13-20020a0566022c8d00b007dee182ddf1mr30462iow.0.1714461147810; Tue, 30 Apr
 2024 00:12:27 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:12:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b25bef06174b1755@google.com>
Subject: [syzbot] Monthly arm report (Apr 2024)
From: syzbot <syzbot+listc3adb3676e5a9d135247@syzkaller.appspotmail.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello arm maintainers/developers,

This is a 31-day syzbot report for the arm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/arm

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 4 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1634    Yes   BUG: bad usercopy in fpa_set
                  https://syzkaller.appspot.com/bug?extid=cb76c2983557a07cdb14
<2> 350     Yes   INFO: task hung in lookup_slow (3)
                  https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
<3> 37      No    WARNING in delayed_work_timer_fn
                  https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
<4> 18      Yes   BUG: unable to handle kernel paging request in trans_pgd_create_copy
                  https://syzkaller.appspot.com/bug?extid=2d1f5a94167d430a3bd7
<5> 9       No    WARNING in do_sve_acc
                  https://syzkaller.appspot.com/bug?extid=95ffb6a83b20ea7f4f55

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

