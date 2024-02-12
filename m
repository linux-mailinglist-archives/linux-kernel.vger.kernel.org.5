Return-Path: <linux-kernel+bounces-61298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D138510AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3111C1F224C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D48C1804A;
	Mon, 12 Feb 2024 10:24:22 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4D818624
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733461; cv=none; b=hQua/rWToy7XLjwEdi0BlePXwlNlAxzRV62nZu99lBbrtsRd93XqXoeLMCpGxOWnCYHehCj3CRBc3OErn7M0j+bxkwgf0U9jnc04jUzvdZW1WQ9ekuKlygAKmTTHFKd9yM36Oye5dA6NwiHI5QPnLsHUoFqlXmg6qvj7u/nm4aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733461; c=relaxed/simple;
	bh=BXo6EaA/HxDCl11YRQdW0f2qZos9jkOR0O7aqPAqQak=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J1YA0SE1yEipPgY8tOftAFcgmmpkPwyPA1lifm4WE1ug6TFCY6kipvN1rUbUSwU8AaxB/04ZMZsg26Gos4JVOxxXWyh0DafyLE7sYpAWpCNFeSgJtZJcCmUJlMrXQYVk8kNjvCqa4Xa8UpV0HlJfb70DQ3cxxAinjAPtD2GOgwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363c3eb46e3so28835975ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733459; x=1708338259;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qmU/SGWkogq9oK1nP7heae05OFn/vB1cTpUNhNmJ5Ck=;
        b=PT5sPu41W0Uhubuqcfl8A1nOE3uziGzgHl6jmpYPh9wDQIBLQ8bL06Bbo1mRY7pgcA
         uk0LGHO3Mm33Vjn9pOCQo2/iPKEnPiPyUng1tgRljXb22PZfsBVIkWcHiNqM6R+O/1PI
         xFJaabngddaxhCPxq38sh1Emv7h6w+0GMJZKnQG38qGKy9VqShIWZP3F1RrmkhdaAJNM
         cXzO5pvflzZvx7lD8XGoKBrarP1NjlbDdEBy68u97zXTF2vdv6I157IaiqkAl1I+1Boz
         GIDIf8CtG3749lb/+3UAuhxmMDcr7lbNhXKcOkcR+9r7FpLRHO55ZikLg1wUxB4pYFke
         obgQ==
X-Gm-Message-State: AOJu0Yw+eEemnvCsx7KY6kj6EknYkgsSj3K7cdatjq0/ddJ4W6wiNq80
	Z4oMbNhWlh79uU53bNb/tA/jGLH2FBZoczuuDX7zumlAjBXkcj8jmj7pdAIO+JwidYKGZrKYz66
	syfwhOxLpglfZoqV/LYMf/PfVKrvA+NlVuREEjP884JFUcXOSsdPmBf8rZg==
X-Google-Smtp-Source: AGHT+IGGNVeNpkQF2hAM4NlGHWWGNCkJjSw3YI4prsACWuGliVzlwLYQLCe7eqv9nPZruDQqjKJIWTPdnG/vV1GCm62zPm+naUCp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:363:c25b:75e7 with SMTP id
 k10-20020a92c24a000000b00363c25b75e7mr478883ilo.3.1707733459680; Mon, 12 Feb
 2024 02:24:19 -0800 (PST)
Date: Mon, 12 Feb 2024 02:24:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c49c206112cae25@google.com>
Subject: [syzbot] Monthly media report (Feb 2024)
From: syzbot <syzbot+list4854992ca3cdf939a1f3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 3 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 864     Yes   general protection fault in ir_raw_event_store_with_filter
                  https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<2> 132     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<3> 100     Yes   WARNING in media_create_pad_link
                  https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
<4> 87      Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<5> 24      No    inconsistent lock state in valid_state (2)
                  https://syzkaller.appspot.com/bug?extid=a225ee3df7e7f9372dbe
<6> 3       Yes   KASAN: use-after-free Read in em28xx_init_extension (2)
                  https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

