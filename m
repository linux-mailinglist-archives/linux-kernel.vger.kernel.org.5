Return-Path: <linux-kernel+bounces-96706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6087604C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE3A1F27842
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F6252F8F;
	Fri,  8 Mar 2024 08:53:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E105150A70
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888005; cv=none; b=eAXlncsqIm8CBuo63zvmASmPjNmfRlMQT1gdfSM8YYWFRI2Gn37ee+VoaoKHNoUuKCP56bqB66Bxa8NJLeonPChfQ4tKYQ1IhPtypWZuCE0AdcppLxnXcCDrS79cJhlUW4YZWcpaQjTT0ZD8syufEFvE5/3vLPRNetZ2qBUvobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888005; c=relaxed/simple;
	bh=WuLlOiYmj9s7y86RnjWbEhbOMJs/ikccw8x07WP3uvc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k2rhnSWD3jPyHbEKhKA7nI14fcgANvyodqIP5mzTbx5K4AwnXUqgFCcN8OBixwrQ5kFUwC4FW/jxK6yb+6EHmEB3U/nf+M+0sz478KXWwV2Zh1kv4TRGsmEO/jrW1Rbcdhl5Ji+W1lGQSNtn4eTugQiqiEhbzizM9kAMy/HX708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c882931b36so60645839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:53:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888003; x=1710492803;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8LJaZFzEhjA6xI4uEzq7WXkdneFEvV9I2SWWd9J1OrE=;
        b=YgWWNH8I3j3R84b4w1wCikUnLnVRVl2GmgUaOPOmLrup92q2TmCwmxw+LmRegrM1vQ
         efgU6tY91bPf8bW/cGyhsJy9knSWFLpCURWVmsJ6vd0v9Y+XsaRnePf3V4tKCSIACnO2
         fmnxkKKt8umny7AjD2/k4tmsmjP8/8/HfcXZsx7wf7VOhxRtendULHtp6WdrifakVcYs
         RKRS1YLsVmY0I6MRzABTPMqaIlRNeHOskrIHEMueLVvydWB45kQ4l4QrS/iF9beo1d2j
         EsBbuuOqKz6L8mLqjhPWTc3LM4h3q22STrvHDGMX6CAnYPYyOw8YPZu1CzudIpLptvLJ
         VZGw==
X-Gm-Message-State: AOJu0YwS27j3jJxZsyj86ZOkfLvy+PDjLteHCcIestJAUb6NSG/fg134
	HG7lh3CZyhD+L67fvtOQSw9Bd/T1jQvTc+vMASugJAzclciY/bnzChKqKyb6vOKhAP5zqYRjKQX
	PfRCVNALayhfLwMfd005T4amJ1RSn0sEt3v+jkiDutA1CG5/prob93C4kmQ==
X-Google-Smtp-Source: AGHT+IFXSPDo4pOdBkNk+ykdLG0YZU8ZetNXvBtqXuL4pUBvKUzKjt9eJRUK87IBMKhNvQIvTbBLutL0YHwwJPyOOa2I/dYIQksZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8b:b0:7c8:421f:bfa8 with SMTP id
 i11-20020a0566022c8b00b007c8421fbfa8mr250384iow.4.1709888003129; Fri, 08 Mar
 2024 00:53:23 -0800 (PST)
Date: Fri, 08 Mar 2024 00:53:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000851660613225344@google.com>
Subject: [syzbot] Monthly usb report (Mar 2024)
From: syzbot <syzbot+list2ae0342013f79ec1e51e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 7 new issues were detected and 0 were fixed.
In total, 66 issues are still open and 332 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3225    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<2>  949     Yes   WARNING in implement
                   https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
<3>  864     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<4>  634     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<5>  509     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<6>  390     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<7>  268     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<8>  257     Yes   INFO: task hung in get_bMaxPacketSize0
                   https://syzkaller.appspot.com/bug?extid=f7ac46d91cf13b4591a4
<9>  222     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<10> 172     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

