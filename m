Return-Path: <linux-kernel+bounces-101549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF687A896
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504861C22143
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDDB45010;
	Wed, 13 Mar 2024 13:39:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B2B45BF9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337168; cv=none; b=M+9p4uZ/xY3F97eFtQ0BV49a+PRzwn2fw1XfC/xuErp+l3fSDhsBuNcHPVGohA6vRABStJwlh8UT/+gmcUDhjUxdkamjGdwVHQXksP36gOJ4OoVDDAjnN02Ojves168dwO4UVt+mZQm4vzXVUH31kbmPZp2ixBfz1yEk9+vvbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337168; c=relaxed/simple;
	bh=a3ZPpK/m61lmncjSx+iVNUY3ldiF9WNBx6q/qUG2r+c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ViL3nPzo22SE9g8CbUGtqlKS7dSP9cprLqsax0GobkLB6JuSgpRwa8ZyWfqlTWIAZTr2/3QrGMpMeN5r9V9QMy5/TTMKoP9NXv6CWtMQ8kuARQSc3sN4HuP9ElAxk0AvI/IcZGDF9ywuGjwi9WZWPT/ROzlVT1tU/rxBC3jtqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-366715a1eaaso18276785ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710337166; x=1710941966;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YimAWqpG5NnLwSN89T43J3b3s94fZqAt7khnYV4AVSs=;
        b=ws53vfjq/TaCCb5lkUXeUTHwkNOmQBN4857w22cd4elBV4HU0d5RNPGhk+xdnCix7s
         6o09agylNJQBfFzq8beAD5/mkJR5mbxBSkgmAZcC50LOcKEEIi0UsYbTzyUNNe8fdHcy
         Cq9ymyCAHgKKWLvWwzrLEoG4T0eKLZOTq+soQAfXbjOmeyKefZ/GqopQT20jQN4YtbvN
         h2awREFY1ckE5uB43sL0laxsrTOaxnlFZLpGwyJV2O82MWbLc3gDQgy5eASHG5q5uz+1
         YzZ4kocvcNDQo96DBRo6ktOrBLplGSW3KOcTXbtA5NkcPV3NCh1AX9refzIQBPUjYoVE
         RoHw==
X-Gm-Message-State: AOJu0YwQ93v9FnI1808CG1xQmkqh+3L2h5hjeTeahP5y83o7YsLDJdLy
	UPHwKYamWA+UZ2Be1Ylw3R3oGWm29VglHehG9TPi5kA4v4Ep23jlxmzlzfbFzQoXbvpOg+ZQ4jY
	pMYfEHa387YmwDFaaXUaGQSKzGzlKN/yBao7l9jIxfcjSLya1f3FfImWUJw==
X-Google-Smtp-Source: AGHT+IHzSJodTkAyNgs4WzD8bi/5MkDLk/MI58MMkAU8qjn9Z6yDWQrlRixUEif3uKzyIUJ4Gy6QfilqiVps1ybkE2NR+xPU9ygn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d88:b0:366:2f1c:2b98 with SMTP id
 h8-20020a056e021d8800b003662f1c2b98mr244129ila.5.1710337166606; Wed, 13 Mar
 2024 06:39:26 -0700 (PDT)
Date: Wed, 13 Mar 2024 06:39:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004316e406138ae7c4@google.com>
Subject: [syzbot] Monthly media report (Mar 2024)
From: syzbot <syzbot+list1be0a511b81c99ed573e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello media maintainers/developers,

This is a 31-day syzbot report for the media subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/media

During the period, 3 new issues were detected and 0 were fixed.
In total, 19 issues are still open and 85 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2813    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                  https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2> 864     Yes   general protection fault in ir_raw_event_store_with_filter
                  https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<3> 134     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<4> 119     Yes   inconsistent lock state in valid_state (2)
                  https://syzkaller.appspot.com/bug?extid=a225ee3df7e7f9372dbe
<5> 100     Yes   WARNING in media_create_pad_link
                  https://syzkaller.appspot.com/bug?extid=dd320d114deb3f5bb79b
<6> 88      Yes   WARNING in smsusb_start_streaming/usb_submit_urb
                  https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
<7> 5       Yes   INFO: task hung in cec_claim_log_addrs
                  https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
<8> 3       Yes   possible deadlock in vb2_video_unregister_device
                  https://syzkaller.appspot.com/bug?extid=3b1d4b3d5f7a358bf9a9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

