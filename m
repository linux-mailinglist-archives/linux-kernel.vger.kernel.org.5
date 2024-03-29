Return-Path: <linux-kernel+bounces-125284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AF89236E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02841F2407F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83E3B781;
	Fri, 29 Mar 2024 18:37:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AA22075
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737452; cv=none; b=BpSsxApzFcdERSNO8MkfM+TpB2TjHKaxJ5x38+0mE+221HuPMF+kOY5YtsLrnAAEGMji3Owq7q4z5POXHZz9JILHSyx/cOOaUuJUi53T+tL6uZPF7v2+CSoVLIDM+G+dZyH/eJ8yFzpLQ+ZHoIUjXkIaWJBCAeLVBGbz4jMmC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737452; c=relaxed/simple;
	bh=F2gfhsww7XTA3P50A1RX32InMlF8Q/9z+ZW7DdeTxgM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qmGl26BHCWX8kZUgRqnlvOJQogEHx79OC/kor4CDeymctE5U58mFvQfX5rB1JS94z0Ti25efL6iISUpBU47HfdT8FbN84vofg7i3DS9PBfJn5vv6LWhyio4X2d33LOPvQF2FHFnbSM0mbTLV3AZnyt7/U3IsFtaLN5dGbYsLl8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc764c885bso239412639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737450; x=1712342250;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLH3G/wi97DU/DtrnW/ODIbuNOVKTyxl862AdQPOt0k=;
        b=XRt8ku/MJXlhJLEGCue999n0oaJKVZIrAIuelQRDuCpbTZCez2IaQeVxwVxnYAV3Y/
         s5WM22HmYIBpY+2gjSG+77MGheSpACFF8QQkn8sTJvwMFOZaVT0H37B53456E3KhUCQP
         1k7/lMhKWUXa7DlCQJATNpl53Xec1ffawwjXcD3eBBJ5l+p8i34CUtwUFZBAc4BiSBOu
         HPUzt6WsZsJmFlmDXReVbnU2NMXM10WnBpqTYfmo9ewRgF/LuUVResqaHVKwEDG7jIk7
         sbhmpzWyDQL84yefDU9vzTw8NoNLOkoneqRqYlp8E32YnbmLTlLYdFdgbrwFfZmzSR39
         In4A==
X-Gm-Message-State: AOJu0YzsA+XtERetQEHZBnrgzS9KufTogrgBevd9RilguiuficPce5+S
	p2dZrgCegPKdHSWaniTbXBp+rdBEcOKuQyL9EXNSAnLmC+prFSXnEwxm7ayNWjSCSH3yYeaK3Db
	mzGuYhc20LOuglWw+RgknaZ/HzIhrEDFXUDTHhZZeRuTX2N9bvjPh0ZZzEQ==
X-Google-Smtp-Source: AGHT+IFRfpXx1VnfI0V7Zv8tfOUmGGmfvDvfktxzjg0GMDbH6xeORJdCTMoNoHwSU1EO7q6fta4nRuojWuGCc7GjOPpRVjDT3z+b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:368:9839:d232 with SMTP id
 h7-20020a92c267000000b003689839d232mr182469ild.4.1711737449863; Fri, 29 Mar
 2024 11:37:29 -0700 (PDT)
Date: Fri, 29 Mar 2024 11:37:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5ee120614d0eef8@google.com>
Subject: [syzbot] Monthly net report (Mar 2024)
From: syzbot <syzbot+liste7bfc894f5476da05e96@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 25 new issues were detected and 14 were fixed.
In total, 83 issues are still open and 1401 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5716    Yes   WARNING in rxrpc_alloc_data_txbuf
                   https://syzkaller.appspot.com/bug?extid=150fa730f40bce72aa05
<2>  4782    Yes   WARNING in sock_map_delete_elem
                   https://syzkaller.appspot.com/bug?extid=2f4f478b78801c186d39
<3>  4300    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  3586    Yes   WARNING in sock_hash_delete_elem
                   https://syzkaller.appspot.com/bug?extid=1c04a1e4ae355870dc7a
<5>  981     Yes   possible deadlock in __dev_queue_xmit (3)
                   https://syzkaller.appspot.com/bug?extid=3b165dac15094065651e
<6>  896     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<7>  684     Yes   unregister_netdevice: waiting for DEV to become free (8)
                   https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
<8>  509     No    possible deadlock in __lock_task_sighand (2)
                   https://syzkaller.appspot.com/bug?extid=34267210261c2cbba2da
<9>  378     Yes   KMSAN: uninit-value in nci_rx_work
                   https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
<10> 323     Yes   INFO: rcu detected stall in tc_modify_qdisc
                   https://syzkaller.appspot.com/bug?extid=9f78d5c664a8c33f4cce

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

