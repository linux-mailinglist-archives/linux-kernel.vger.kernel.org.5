Return-Path: <linux-kernel+bounces-61303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FA8510BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB33B23E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8D31B274;
	Mon, 12 Feb 2024 10:25:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049918059
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733526; cv=none; b=dF1GQpmTcMI/OIltQUgoGoqhYBoxSLX9H4/SIO5O2gSrine0m1FMYWSoMMZnTxBu4FBjfxI+kJ/S9e6VrUqyMxF4q5050tBU+z+AhisoHbk87dCx67RSYIYJRLo1G5a8AotzppD1DOWmEeWhQUyPXNw1rbwvKh8JJsmRJgDUbWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733526; c=relaxed/simple;
	bh=Vmw7e+ikPueKBaDfuv+MIArZmdJU/DDtIWJtNorjxXM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eHAiJkf7MeWouREBUHRC7LO8BzgxYXjsn+UX6J4HHM0nmYAdG+kUv06vjFO2FhXUxYcyxFdUH0NPjKa8UYnNwbpNtnABX91fxJ9UL58j6tAbobz5vH9EAPBvGIsY5BhHgDQSZFkxixtn490zDA66mTzDJB0x4T5GhYzB1eXFO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363abe44869so29122385ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:25:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733524; x=1708338324;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzKjOzRjJUG3ahnARCa3HwD7nlfVuV2trdR+qXnTPfw=;
        b=nNqy0x+bnEBGVPztnjw9X8PHlPFcwuHjt57sDo/yjTN0ABkU7ib9v/eKS53jtI1t52
         TPQ/EIstn5Qv7/NQWrgTcSqV6awgl8voZstfGnaU5D3hdgHcMOU3YRJJwbBLeQ9ow3mX
         2+YRVhN9gm5DnVL+Y61LXc0JKFk9ruyleE4emsIZ7/ZUDO3iHvM0w7cY6Xus/u9Egemz
         2OFNN+nBLCNq57MOH7M/bgnqiynTcF3xUFeYayjH9lJ6nlElzhXRtKOVU85cwJyl+wxw
         I4Ys1a6TMG4KcH10XXSgqBMjIS2/JJG43YY0jLeGT2Ue/79lFOVuB/pWEZyragkE8BtG
         nJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgV4rDEFilLtGJT4YGS5uVzK3ttyORLcSlDmMa7afhibM+kr6vRsFHtmBPKw++UEIOIOuz1Cld5T7ZFOvk2Ja+Zq/ibojj5PnRAhUi
X-Gm-Message-State: AOJu0YxqNkONCs0x3LvY8j7IiWfppWfEcw9g36fyw8RRuL0WzBMni6LU
	wFF2BXdiG+q4ODDe9OYrjslShPhraCeUjGIoLuctuYX+akfsfokECkEmjTiv7rAn0IlU/4dP224
	Vpj88f205MjBiW34SwFO6ZyB7i9OLog6oNxKitZp1DWbpPaK/y6t3kI4=
X-Google-Smtp-Source: AGHT+IFiTle8Gbcz3iNrAkr2fd/Q6GA5XfsTDKt+6lm3VilkGuMQnYKloeg/jE75OwHDwwWOtikvHHqaW1QKdw+oNcBirA7C/J6I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:363:819c:926d with SMTP id
 h13-20020a056e021d8d00b00363819c926dmr566793ila.1.1707733524623; Mon, 12 Feb
 2024 02:25:24 -0800 (PST)
Date: Mon, 12 Feb 2024 02:25:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b399c06112cb236@google.com>
Subject: [syzbot] Monthly udf report (Feb 2024)
From: syzbot <syzbot+listd2c42195477ba0041ed0@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 22 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2077    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 375     Yes   KMSAN: uninit-value in udf_update_tag
                  https://syzkaller.appspot.com/bug?extid=d31185aa54170f7fc1f5
<3> 22      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

