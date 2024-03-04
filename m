Return-Path: <linux-kernel+bounces-90123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A692F86FAA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D831B1C20D44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E713FFD;
	Mon,  4 Mar 2024 07:23:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CD9134B7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537006; cv=none; b=Rpcv10LX2fiwstZ0XPk5+ELqYdv9tH5B28RY8AXGzsG18cxE4aVp4zhaZotehcTHPhnAzAOfH2ElCxXF0bGVXJKYdmg4+9gwgi9QtNKJbEQU5QaEPv1T5k30U3DTGd3TikYD1DNOrSD0NzLFjGGYqfX4eh6ff7S0cS2YkwsaWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537006; c=relaxed/simple;
	bh=uZVPkag5AAXBeA+sFAklmErR3BGsvvJg/HeilNA4UWc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e+er5/of1qoYHrVNQXvqEl0bO/20KAs8s/AFWBiAEjXnUrgAiLp+rVJslWNTdIUAcH60/ew6ONQhe9/etzX1mIKrKLqdAz0TNb1b4BE4Qp+5nnnVPuP7a8NZ0VXpvlsDSUYpVixPmeeJ8Nt3LE1Wg5/dB61P+xdCOK+xNnu09lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c846da7ad2so98441839f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 23:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709537004; x=1710141804;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tpG0eDwWW5kcoi19UELPjP4fL+iOhGGTyJmkrVdifU=;
        b=UG23jPSqrk2+wyVBsq3RBCOKvf2pZAK1x9FvidTCqxPZmMaZUTUbQKNUiHpnQVXOPP
         x6m5sVbw3QMyOqY3PfutVhT/v8PBMyT/6nn9AmZTZ1q/SYHNWa4KBJ//k306a8SWXMp6
         /aXxqr/hOWkBeXwc77ijxsxa1f26JovMTMjJzGPLv2SxId7BW1m55/WcgLb3hphafh7Y
         4gD8aLDVKeIk4MPPD8CPCzPc7yZxI0W3Ti9mFENTk+Rqy96wato7RYkNjmdugzOJ79i8
         EHzxQdTb+UGDMH8ZEr+B0Jkx/h8EeWlR/EbdITmUdjO2lkgvQ6Xr0IfBqzKEnq62rD4t
         u+OA==
X-Forwarded-Encrypted: i=1; AJvYcCVxTJIKDkYb4QlJDwGgcm2hN46GhMvlVBItLOp5QWkpN7/VAfF3jkMtx3CACjqzXlMr6tBLgFjY6G+but3GqpRDjIEGRKFnHS59KfmB
X-Gm-Message-State: AOJu0Yyk2XcCvYm9f/Dm+ykdy5F1WdJdg1F4sPDc2poAZu7IGHHG1uk7
	GCJOfgkbnd1q2EcKp2GmrSJoIj+0xm2Y6dFUyeit/RwDMiufCj22YbRD3C5DDEWQ/V7D9vYliF8
	kz7LEybeCHhCBr+QLGhiCXtE1S6DLQqu1vNsQDwzxB5LtHd9Fxon2Hqc=
X-Google-Smtp-Source: AGHT+IFjA7/eq7vxEVBVY5D06vCo1DteiS6LkpGXtmk3Tly1vrk328qEQjpu/DZfM2joVCaFNCyjlUKyQSgAds0XeYOjkSA+zkN1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:365:26e3:6e48 with SMTP id
 j29-20020a056e02219d00b0036526e36e48mr664367ila.0.1709537004058; Sun, 03 Mar
 2024 23:23:24 -0800 (PST)
Date: Sun, 03 Mar 2024 23:23:24 -0800
In-Reply-To: <000000000000b18c2406124b652e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000db848a0612d09997@google.com>
Subject: Re: [syzbot] [wireless?] KMSAN: uninit-value in ieee80211_amsdu_to_8023s
From: syzbot <syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes.berg@intel.com, 
	johannes@sipsolutions.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58c806d867bf Merge tag 'phy-fixes2-6.8' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12374c96180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d050d437fe47d479d210
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14227612180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134411a2180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2b0ed9886ae/disk-58c806d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/372dff1b6033/vmlinux-58c806d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2b87ebe3e7b/bzImage-58c806d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d050d437fe47d479d210@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 ieee80211_amsdu_to_8023s+0x8c1/0x2d40 net/wireless/util.c:856
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047
 ieee80211_rx_h_amsdu net/mac80211/rx.c:3133 [inline]
 ieee80211_rx_handlers+0x571a/0x10c40 net/mac80211/rx.c:4141
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4185 [inline]
 ieee80211_prepare_and_rx_handle+0x5640/0x9690 net/mac80211/rx.c:5033
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5239 [inline]
 ieee80211_rx_list+0x642c/0x65d0 net/mac80211/rx.c:5410
 ieee80211_rx_napi+0x84/0x3e0 net/mac80211/rx.c:5433
 ieee80211_rx include/net/mac80211.h:4983 [inline]
 ieee80211_tasklet_handler+0x19f/0x330 net/mac80211/main.c:318
 tasklet_action_common+0x391/0xd30 kernel/softirq.c:780
 tasklet_action+0x26/0x30 kernel/softirq.c:805
 __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
 run_ksoftirqd+0x24/0x40 kernel/softirq.c:921
 smpboot_thread_fn+0x558/0xa60 kernel/smpboot.c:164
 kthread+0x3ed/0x550 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

Local variable hdr created at:
 ieee80211_amsdu_to_8023s+0x5b/0x2d40 net/wireless/util.c:832
 __ieee80211_rx_h_amsdu+0x91a/0x13b0 net/mac80211/rx.c:3047

CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.8.0-rc6-syzkaller-00278-g58c806d867bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

