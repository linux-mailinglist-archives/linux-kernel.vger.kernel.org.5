Return-Path: <linux-kernel+bounces-50590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F9847B54
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3EC51F2A3AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD585934;
	Fri,  2 Feb 2024 21:05:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EA81758
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=SSbBvUycotQ2OZUw3/KyQSyfWfOe63Z3jjrllnjsckObRYC9HdphsCbgA+BLkVrYX8GlFdfgMJ9mlBPxi+FlOdiphRlC3pEphzG0SIHIptashyruhJaHcGBto4Ce4FkN/co7+EIz/gs41XUco8XN5y/FFqsWZqJ37L/Ohfb3D5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=OEvr5+/yj2ihjujNxK4XVMyOABYMSi6tbqhkyqIcGII=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ks39YEhYzB1ELB5s8gcvXZeg6sCRzIWWEJKagFOVsmtJSeW8U+72VkzG0Qqp+NM1U0/7ObFgeLuLwkNuWDXPvMd01IsGT/2hcuj3OeC30wONDa8wjc5CuiJiK0AqjMDgE7WU6pILIpDq6NR+2NtlpeX0x5T4e2KL1PkPOjVo328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363abe44869so16169565ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tN2jUIgOwKh+WxF6WnNkQPAYfTv3IkyDk5IO5TckmRo=;
        b=kxRcSnDS49yCnWjxGZHjbj4Fr/Z/m+UZy9P6yIGl7IYx/bY0tRuLhmF+0thvoyHScj
         FVawyyc09m0rpQXeY3sBWQLYUUEVl1jh/6J5LyOWGvzRR2Isa50VUR34vN6tfmDE8JXH
         wtYtfyUlYJbqxmBhC1bBchEBeFkl9tpj43H3z6HI5LRFlhnQXsAi7NSBC5+IChlKqOdn
         GDdm0EfjmGnBP1ZO4cbKwm5hOQr726FsYLoYVmKAQwa+aG1m4V9U2yGzl1kgKs8oJ2pd
         14u9zBY1zTr3CONPV0JU+Ph6IZZgej3s34RPGujF4yMawcowniiqRVNteFFsPkWeFB5k
         zpuw==
X-Gm-Message-State: AOJu0YyxwTyFBi7AOP8b05CnAybsf0Ily+22ZFNK29KMmaHjvJPS2exG
	ZYEQ13LAkUSRKbiK+buvjsn/0/meFmEkX8gYpCORCqMpWChuPkFoSLQJfbMxzDlUchtPETPwAXL
	gFNRhYI7LDPHmmnIUK4GrsZCGdqP748kb25GvYOmvY0XZ7Hgtj0NBqS0=
X-Google-Smtp-Source: AGHT+IFqGl04LsBhODxZQWt/9Z5loRCI9Hxb5onmXoKXECF1BuW6tfK/uoGsAEoRuMJbCXHJwMHofLY+efqmGCSL2YQh3mPm9utS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc2:b0:363:8336:b21d with SMTP id
 x2-20020a056e021bc200b003638336b21dmr194522ilv.4.1706907923174; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ce0ca06106c7894@google.com>
Subject: [syzbot] Monthly kernfs report (Feb 2024)
From: syzbot <syzbot+lista950330f639d85c965e2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello kernfs maintainers/developers,

This is a 31-day syzbot report for the kernfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kernfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1714    Yes   possible deadlock in input_event (2)
                  https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<2> 227     Yes   WARNING in kernfs_remove_by_name_ns (3)
                  https://syzkaller.appspot.com/bug?extid=93cbdd0ab421adc5275d
<3> 30      Yes   INFO: rcu detected stall in sys_openat (3)
                  https://syzkaller.appspot.com/bug?extid=23d96fb466ad56cbb5e5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

