Return-Path: <linux-kernel+bounces-133015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37AA899D76
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B421F240AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA716D313;
	Fri,  5 Apr 2024 12:46:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296316ABFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321182; cv=none; b=SvUHFoJT429Cw3VHA/kH+6WqFeWM4CxrtGh1LJjwxbbKsHBn7oOcYS2Fo+Y9wGWRTxh6g0hTkt3ETKFlVtkg/3ExtFqtyNWO2kYjGeN9Xj319w2R4V5Hl+PaIZ2u03A6PdeTyK1WWjcUpj1e2mhPa0ajwZ7pSsKblHGLK7HvMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321182; c=relaxed/simple;
	bh=TzuAvaDxx2jfqrDe2Jq2/7JXP4PxC8E2It4y4YV7UG0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pV5T9OqVET4EzoosY7HgVEqLH772loQ4wShhtYmVxXXFY+5UmjH0XQ86zLoZPVZdrQeECj6oDKOHhYOGEGw0moxJxfyT1MDtF+qulflVMocwPgdZ7FhZkzXHpDpJjMG56hcfpW+V6BhMxK6tCHlplHh9l2vt2/BZvQviIHo0CII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d022d0c76aso205882139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321180; x=1712925980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZFJE9UvxeAoobKH7stsE4IX2cg9gqXNdpmLrHc9THA=;
        b=ZLMuzWKX+LsahxfabVVigZUlE6QMLOFpXcw58OQ0fAHnboQXj2BWGBFIoiKG6v3Qvf
         eZeYy54F+MMyyJvVwSIf/abG57J+nnyq1r56LkBiYanVck3iv410lv7Z1KbmQ/HMCEtx
         U5rmIVSG8C3EB9L9+ZVpVlF3yHfZVT6FMTWPxRf72vevvfbPuvptHZjHqbzcxnrYJ7NZ
         1rP1Xy/7D/pBCKy2DuaP53X/wrwak02BxqPO2gg8Ii11u03nffhM+cjaqmW9RPUaHqrA
         Ciw8jOQTo/Md56JHghr1PH0fippAX3oGXuQ0svmRh9hpIaYva1qakLLv8NgvateJeg1y
         8mUw==
X-Forwarded-Encrypted: i=1; AJvYcCU9dr6vCjRVBpQ44r2ptmmoX91kkC9TYJGW14lZVFq8wFHsM9WHwMHXi/a/vf5fvF+rC7sjIVePFnULEKBzaKT3QNhdENmaU6daWG0Z
X-Gm-Message-State: AOJu0Ywi4CqgF7D6WVcWJeKL5uy5bc+0t8L3tEnwRJjlp7dA2Yb1oLrr
	zLIIltHNdo84z6zRow42r70MYmhmEDU6Sd90ohnK/9B351FxPFpeltroHu1X/TNsGq+m4XlmU1C
	TYVJs68lbtf910fpCoQGS+BbzSkIWan4+mpjDEK8wW/HvU+7+j7tSOrU=
X-Google-Smtp-Source: AGHT+IFnd1Xo+MV8KNzliwJSjIfYT+jDuA0ciAoNioe4t085EcYpfvppOT6g+WweSE7Ch0inROf04OHDyIG/oLOlECttwafu7ufC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdae:0:b0:369:fba0:e97d with SMTP id
 g14-20020a92cdae000000b00369fba0e97dmr90725ild.3.1712321180244; Fri, 05 Apr
 2024 05:46:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ab81061558d779@google.com>
Subject: [syzbot] Monthly serial report (Apr 2024)
From: syzbot <syzbot+list047751094a40ab426596@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 5923    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<2> 146     Yes   general protection fault in serial8250_tx_chars
                  https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
<3> 62      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<4> 55      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

