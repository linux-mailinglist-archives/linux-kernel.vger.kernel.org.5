Return-Path: <linux-kernel+bounces-28712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8E830229
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3E81F24DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E091426D;
	Wed, 17 Jan 2024 09:21:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3F13AED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483282; cv=none; b=PWRrp4A0uVQaB6UnpqP4VDpi88d4B/Og5kz84bY4pObFTg+lhlBgTuxJOUVFt+KejeP/eqS7kNi2NEt1+8h0L9330qnkStZTqilT5+IDUANtELKOiYMMdw1MWVFy2LC4ajdoIGNNlbUNO62WyxuhTgKHmOohwF8RWWOR7BU3seE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483282; c=relaxed/simple;
	bh=s5vuN6JWkgaXfmqPxiqAmbI3bXzyrZtw626VB7EuW+c=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=NiHxnFQY/cqUvKIgom71I2+VcAkHfkPQY6QDYNRpzIvLEV3sSNZh4wFrGG9hOtQ4nCIiNQ3z2orM9VGG36WNrYB6N7KO+8npcqYzTZJygUz91Go4F4doBRDcX4QYFFCEZlSdZN7trW1KcMuo90E7y1LWbjG3TI+47Iq9XLE1DQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36037f2de0aso93201285ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705483280; x=1706088080;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Up+jt1bihbVkBuUSBW+4TnpBfqZB9U3eKOg/evtGkN8=;
        b=xT6HMXxlCjsHnpfHG67abPmYE67LTaF7FGzexSMunfASHKnWC/pzF0pbvG9bP3Vrxg
         iGT0TGTMz4v74H1jrBOiqsOOJN44AsqLBHYFxgjPjuuWJXvn6ffFC8nD59KlJgcMfqE5
         y8qd1ZqvNsjwkqRr6V9t/ibWTofy2KVQmFFXL9lGU7BAnKAQ+m2ggT/kVmoEnYyJb9Uh
         F4x7tZDXxBkwUo6ZDLfH6oh4m9Pq0s1Qn5cu466UPQXwBYcX2J6P/epSkNMDVpLxhJIr
         8SQR4XTJvln//VuoxjGOxYLkdYd43l9xS0DsNg08icwDMfDeBofOyWTUggo7PYzTMOgK
         W2cA==
X-Gm-Message-State: AOJu0YyYBQmefQpS9PKTdbUvQ/XmomCVSQqpn2LKprYVaZWaN9cTlgt2
	VU9tuG2/QB75HtjSvYvHaHHQbmkQ22+ZmoDAppWgovNv7M/k
X-Google-Smtp-Source: AGHT+IGj5Jz/cVztIRPm1xyeRL71jW9Gjid3kd57muWdi+IvewSnwCcswtoo81J75UUWRsb9pLwrUMeVpn/k2lEgyCspNgrP0743
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca5:b0:361:8d02:f37d with SMTP id
 x5-20020a056e021ca500b003618d02f37dmr266518ill.4.1705483280708; Wed, 17 Jan
 2024 01:21:20 -0800 (PST)
Date: Wed, 17 Jan 2024 01:21:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001df937060f20c585@google.com>
Subject: [syzbot] Monthly input report (Jan 2024)
From: syzbot <syzbot+listb3639229afd4dbbee8c1@syzkaller.appspotmail.com>
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello input maintainers/developers,

This is a 31-day syzbot report for the input subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/input

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 51 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 4133    Yes   WARNING in input_mt_init_slots
                  https://syzkaller.appspot.com/bug?extid=0122fa359a69694395d5
<2> 947     Yes   WARNING in implement
                  https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
<3> 353     No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<4> 149     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<5> 90      Yes   INFO: task hung in uhid_char_release
                  https://syzkaller.appspot.com/bug?extid=8fe2d362af0e1cba8735
<6> 39      Yes   WARNING in bcm5974_start_traffic/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

