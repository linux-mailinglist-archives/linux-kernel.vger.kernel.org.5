Return-Path: <linux-kernel+bounces-144829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635CD8A4B60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D22C1C21DE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22333FB1D;
	Mon, 15 Apr 2024 09:23:19 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E283C463
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172999; cv=none; b=t1RJ7VhCJU+TEvx/jQp1xMIZC3W2sczFuSO2PETUQ5x2iI01m4KimLCfXI5NiXF6ZO5LGXii5wV9Mq+G9xw3SkXfG57AsLzVQyVxax/oJ7LDNkpXOew5zIS2Ecjvy+dmR+odQzYGCVM/0xFKgTHZm5coK3KEzjBnxBsv0myDauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172999; c=relaxed/simple;
	bh=Dtu2WwxG/82/wQT7AK8oq6ICr8XKHDmANozQb8jsroo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Rd2VoFDSSinCzWoM5cj1P3s7R15vAldRdGmNDFbstj1M+KynE/clhIMuK1MWiF+ZLUn1hmvW4j0a6hBYfcLi//Kp8ukSHz0MGP1BC/z6pyyl5npUSL+Zp/XqwpNiGgR3CCZKykrAGPRSqo7o5H7OMn0GzQQU5HS6mIcAuINl9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36b1c0cc29cso10067895ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172997; x=1713777797;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUJMCxqfhE36FvyCjh56U6tHOcz17K7U0ebNl+J8Q7A=;
        b=gnAkIeTI6Lec9HtvLrHJy9P/BsvUlI8Zd4fjks0J5YxslAHDuCFjiGi0fkLXnPKwfI
         o5jPuf1i5bqo6m0aGeg5pqYlUet2ml5VRlhaMejs91Wxr+gjZK214X8WCbbUj9P5AngV
         Vvnfschp1JluyPV37gJXGbf6RVpw++o9VV9EQ5OzVxb42PP/DYLr32QxbwbZ4dOBr+hW
         8ldLJyNSi+Cv7+yyGX49+ek/HBAPhF/v8JBTEW7m1TB8436GcdaE/KD52CJeVf0U9RKO
         XUlrb6zVxOOJ7R3feSxPamopKnqCYtKRjspjdw0bxCFmVr9Ae7aUCxpdJucEl+6+JiWA
         MsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqShZhieAcWxrf1FawB2EeUHP9ANaAyKCCGkqwjTQeZVmr/cPb4uzMy6pskvBt+R4cuQVfDTIZ7zbJ8u1K+lto9EWfEixaDMNy6JX4
X-Gm-Message-State: AOJu0Yx4saKPPXozH8mAsBbfAlHWKKOGXd5nrxuPN0Q6ppYHWkJgDrp/
	fmIXh5NorUCl18Yl1mWYylAJw+szP0CjhvmAbarGeMCCzPpRiJxH+c6hb00ABYYwjkl29/ROFFN
	nKdevVyr6zX8S/4Ly/iQ+Z/xKSg6lSqIEHql41MqIy8mI0KK6yveWQuw=
X-Google-Smtp-Source: AGHT+IFi4hD53iFoBFrBLy8U0xxpWWqjcClXfDsSB5XiPFaWFrDCq8Ebp2J2aKYfmncJOA6xLQuF0aQCj5/6c+i5NBdpEN28Sebq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c567:0:b0:36a:686:bbb5 with SMTP id
 b7-20020a92c567000000b0036a0686bbb5mr755410ilj.3.1713172997501; Mon, 15 Apr
 2024 02:23:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 02:23:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4875e06161f2b0c@google.com>
Subject: [syzbot] Monthly io-uring report (Apr 2024)
From: syzbot <syzbot+listd5c9c3b310f9577a0430@syzkaller.appspotmail.com>
To: axboe@kernel.dk, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello io-uring maintainers/developers,

This is a 31-day syzbot report for the io-uring subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/io-uring

During the period, 3 new issues were detected and 1 were fixed.
In total, 5 issues are still open and 93 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3525    Yes   general protection fault in try_to_wake_up (2)
                  https://syzkaller.appspot.com/bug?extid=b4a81dc8727e513f364d
<2> 2       No    WARNING in io_ring_exit_work (2)
                  https://syzkaller.appspot.com/bug?extid=557a278955ff3a4d3938
<3> 1       Yes   general protection fault in __ep_remove
                  https://syzkaller.appspot.com/bug?extid=045b454ab35fd82a35fb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

