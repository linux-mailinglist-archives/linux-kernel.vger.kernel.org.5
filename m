Return-Path: <linux-kernel+bounces-144059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7878A415C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C1F1C20D27
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77A22612;
	Sun, 14 Apr 2024 08:58:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C023225AE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085085; cv=none; b=mR6RwNjA4sytuwEM0XYkNJCFff2YDd47nBzfxSW//WqQE0PBvzzoFXYlN8L7belpKCovUMsPwb2m/dDDNbCNTvuGOzxpE0v77zl4xWgfU2udJdSADV2btHm0gmK0UKoO2MXHlbfjJIOZcIt8wt6qam1ODU3U4ktgA8G45qVTzec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085085; c=relaxed/simple;
	bh=FveVRdzqBtkxT6lWcSOibRZMu/hirfuVrLILWSGrIqg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kOdNB8qINhJHnvvZ+iu9Ldv2usZ2OCbrQgv97hKCJ5XA2wVZQb/xzSNAgOLxF9F00bfKAK4T4WOpfgdn1GHEXOjChTnUuxbA77KhsmexFc1i9y1XRiWyQHA+/KnJfo6ds0ODZmP/vuMXkqOSJoBw57+gjnpZ3PE5cuffJyGk9SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36a0d85da1cso26429875ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713085083; x=1713689883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elGJ3DFJEYnJWxrnnDKy2utWRA0XXejEtYJ3AcLN9NA=;
        b=fttZMSxhuUZPJzBlop8udCO1sj2SgjAOtbYOaXQXTAufB1RXDBh7As68dW7OOG8h6g
         3ia2eDKlKdZazGug2yO2NXyhV0kmoYoiTbF1D2/xsh/2nLZXkOTRTD3Nj0Pku0nUu5SY
         F+T+ScimevKKiARKAUbW0GtW75GnyLybkUMcskqQXkLCSP/DucKu8CqDucBHHYJLnVAs
         /Hd9aSK7c1/UTGs0HGatsajUykvk4Yfk0WQJCMHSbBBVlqlPXWPosv9CV/gOCgs3+zIi
         tNHhywtKSeaDHD2MIKUq/q0ng5ZthMYYEVAQHW+myP+ki6kxDsGOxY9wT7raDn0tbosK
         MAXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhgfqDz2Yqbu2L9nGw9ptNKacdUu8KVATVl+LYSGerHq668rHGeupGTEiKliAxOrYgaU+jh2K2bDjHFUy6fodjBh1c2+MzEjdmjTYq
X-Gm-Message-State: AOJu0YzjFU5E3MhNdyhXLQ9sXnYleWpPRgKms6xf0LaWaCjuHxxj7KUv
	mbO6TxTIpL5WNakgYc+b5qO/GrvnaFdxx97chSNRN1cJxU5iZdT6fL2ag+WMOIy9k7gTK8xZUTU
	Yk/WsHttlFISOMxLQbTSKWV+YF+hRwheQ8nB1aC604F/Qf+D7cIlZoQ8=
X-Google-Smtp-Source: AGHT+IH4pUZy/yusqM8GtHczZl+lmXDcNTBFRCGHrHwBbi03NuvVZ6XYlXN6EZLc5QUNGZSpgVLs4JY3o9v1uqnDy7mSQMgr+Fn9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0d:0:b0:36a:3615:33e4 with SMTP id
 j13-20020a92ca0d000000b0036a361533e4mr481682ils.4.1713085083321; Sun, 14 Apr
 2024 01:58:03 -0700 (PDT)
Date: Sun, 14 Apr 2024 01:58:03 -0700
In-Reply-To: <20240414083044.2191-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc9a2706160ab3b2@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_set_handle
From: syzbot <syzbot+d6282a21a27259b5f7e7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in hci_conn_set_handle

------------[ cut here ]------------
ida_free called for id=8192 which is not allocated.
WARNING: CPU: 1 PID: 4466 at lib/idr.c:525 ida_free+0x370/0x420 lib/idr.c:525
Modules linked in:
CPU: 1 PID: 4466 Comm: kworker/u9:1 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
RIP: 0010:ida_free+0x370/0x420 lib/idr.c:525
Code: 10 42 80 3c 28 00 74 05 e8 8d de 90 f6 48 8b 7c 24 40 4c 89 fe e8 c0 93 17 00 90 48 c7 c7 c0 e6 c6 8c 89 de e8 81 63 f0 f5 90 <0f> 0b 90 90 eb 3d e8 45 8f 2d f6 49 bd 00 00 00 00 00 fc ff df 4d
RSP: 0018:ffffc9000e87f780 EFLAGS: 00010246
RAX: 477b027121803500 RBX: 0000000000002000 RCX: ffff88802dd2da00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000e87f880 R08: ffffffff8157cc12 R09: fffffbfff1bf9650
R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: ffffc9000e87f7c0
R13: dffffc0000000000 R14: ffff88807bfc80a0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005575b0dd0131 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_conn_set_handle+0x193/0x270 net/bluetooth/hci_conn.c:1257
 hci_le_create_big_complete_evt+0x277/0x750 net/bluetooth/hci_event.c:6922
 hci_event_func net/bluetooth/hci_event.c:7504 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7559
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14492add180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=d6282a21a27259b5f7e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1476882b180000


