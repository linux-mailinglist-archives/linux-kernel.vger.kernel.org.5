Return-Path: <linux-kernel+bounces-53933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31984A832
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25261C27504
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208013AA39;
	Mon,  5 Feb 2024 20:59:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD82C877
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166772; cv=none; b=QBHg5YuKiWacojjBYMhktE3JEvkVHc7SRrzH9uu+ZN5rR3ffhPPKEaiYdnU5/Dfw78L+K9CZDmn82CqgOLeu6zpeVhQ/vAS8w1Wak+Rb7p/Csj5vaK0G2i7SfORGbeUI5TKKq4pWmVL7KzLReI7GKtW1cWZDBzDhjkVAH0cCe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166772; c=relaxed/simple;
	bh=LV+vgzqgX4bSPC3ZSNZIykuj2CrnyVWEDZdsPOar0AI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tFZUe4VuTQ6r5o3eBaKBs7hFbic8mBCF5WCgNWqi+aN2AzM02j/1iKQ4wHDLShtRt871Q6ORJI6O68914Yw/QZ0TdyU0OMM8A/VeZaARLvx/6EJKyDiW9V7OTJU42FqczbZBuxSv8F2UGMccu1CuL5P7Fym2NJnef0Kp/LrvEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bad62322f0so522674139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166770; x=1707771570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qdk2OXx+00WvakL8qEtDlM2Y2YDJtRedEifNmm7F+7E=;
        b=mdqGJ1Z5gxyshIZ7BRbcxX9KAgztJUAaOYDZP1Aj4+wHkwdN05cQmfaFXIpBqQe5t3
         RZj7rybvR7iiUpQemSLtEmeaTHIuH/21Ye72s/6B09iUD6vD24TjIBJH50vQYU/IOxgS
         9NI7SRR+c/3qnouxwkbXHQx/Jn2K6wwHvgDSQIRcSeOrbKczMvLQTmhNsLPxtyQ/tRci
         ZJKZUtWi39EdVK+V9HF7DfimRpJJvmXMIdfnqss2cnevg+Q4g9ZgUL6jBf+guq9D67VA
         9BrWeoqw24jnAOYHL5/KsGgdo1hWCRvs2geXUIUdWCCyVDpqzzWsiKxRboQqVFk8EXFF
         BuEQ==
X-Gm-Message-State: AOJu0Yy+JRgKVQsC1QBv59Q6rkVKXvGE0yfWgDW4n6a9155yTI8fTv8e
	+/46Gx8rorFJTZ+u3sgKtCC8IfrJLeptgTdRPEFNUslRYRFMEgHs8kp2gd9UfgJGUyWEAGWdwt8
	eh2JO5wvPyxNFAUfhkQwaYh7h5tdEVjRRbFUeRNiG5cD2OuOXN/AY2kv7FA==
X-Google-Smtp-Source: AGHT+IG2IptJzG8ztHzoyy897n1MsxT4UD0l7OufVE/rw2jySvLNL11tCmS+/8HJRlk1QKAdb/DQzcPA1JPVULpfadUXfeksLjnl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1c95:b0:471:2afc:63f2 with SMTP id
 dp21-20020a0566381c9500b004712afc63f2mr7766jab.5.1707166769761; Mon, 05 Feb
 2024 12:59:29 -0800 (PST)
Date: Mon, 05 Feb 2024 12:59:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e257bc0610a8bcb3@google.com>
Subject: [syzbot] Monthly usb report (Feb 2024)
From: syzbot <syzbot+lista48d6b8e8e1b33217dd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 0 new issues were detected and 0 were fixed.
In total, 59 issues are still open and 332 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3116    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<2>  949     Yes   WARNING in implement
                   https://syzkaller.appspot.com/bug?extid=38e7237add3712479d65
<3>  864     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<4>  862     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<5>  567     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<6>  460     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<7>  387     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<8>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<9>  253     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<10> 247     Yes   INFO: task hung in get_bMaxPacketSize0
                   https://syzkaller.appspot.com/bug?extid=f7ac46d91cf13b4591a4

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

