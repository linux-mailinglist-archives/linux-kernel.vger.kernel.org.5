Return-Path: <linux-kernel+bounces-151754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353718AB36F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A021C21BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431BC131BB8;
	Fri, 19 Apr 2024 16:36:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691B6130A5B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544590; cv=none; b=ru9b0epSLcgQjRoYaIYV66bNlfonIRrd6pNF6C+4Tn/YLZC+sD+q0DfY75bPhsrQV4bGUzsVL8Dyu2K2tm4yqv/Z7a4hfOix4UcmSpbyYoaG69msGE2sjfyXGrzjMRMdsOdHY/gL130W+KLLHYKSDw5I+1mYuPCGVQ+diXCf8D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544590; c=relaxed/simple;
	bh=+C4DMii5zcb/bP9gJ9Q8qwtxYZLGxz+666DdY3d/UwY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YwpGhuISyrtMbXxfn9jkvzZDysd4WhVWw5X5koGcCvsGhM/SRy0CHS1Rc/M6OcM8HEHAocYpUAxeOfL5bjBe/EmL471uJjidEa3DIg1byBFg6sIMyHEXzye304MAZFd0Ld9KOGTANGJIvVAOgMhaJatTKYDF6qwielwYnVuxweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b36e64789so29606185ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713544588; x=1714149388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJTgtM8/phEDPy29/U+rRcWoZ2PCF3g9CcR2GjEyFog=;
        b=jTMh2RKZzCLp2zzgfUc3LdOQQxCmR3V9/TVhtDXWf3iUnKCNNNU44XD/P//AzXLaB5
         PJeK/pmSKEmN0lCsyITeH/wmXfth9KQ4OecLpNqE4CR7SDz3vwAZwiUDL48T2RibDCPW
         +2lNP5J3SL9C7QOoLy+ek+zyHeRtYOgHLJva588h++FyovwpH1kbvgF3y3PAEIQ7hlpl
         Vas44/FMSn0m1ZuIyuWILH5nj9gBXfWEKEQQ32tBUoF4WOJXNvd3j1XMjFnc5FF0mcNu
         u3MXamUfivqPRAbV9v+5Vc97s40nqAOTdM3F/bKop4/4PruyAGtnarYgCdiFaWWRX/+w
         fDYg==
X-Forwarded-Encrypted: i=1; AJvYcCWH7sz4eyl8Jigm7q1cuhvE2kN/RuTSoC8Flw1AF5uy4yVatpONLzCUv5Px+qSXQMuh2RmRdmoRByY9kLRhP+8HPnTDk0aiLVNSXbFI
X-Gm-Message-State: AOJu0Yw62CEzCX/4dsnSqldoZMWDkgm2ZSOGxsBkbN0EHAdVaOKX7vr1
	nKq2MUwPti4ayapMA5QocnglosavxrRbrpTGL31R370SDR4LHrfZluxuNAMGIh/46ZZslIU6lAN
	g4uc/fGwSK19oVOCx3jy/8kl/liEZFfDNDTzvKAG0nxltf897tVnZeiY=
X-Google-Smtp-Source: AGHT+IEcfUp0pVkcrvPKsDpRGGwGB97E/TmioptRlF21U/7NduERDQoFqDWTBQ9vkis37DE1AoYMsQmDlY8lMNNEgJF7hejmof9u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:36a:3c40:3e29 with SMTP id
 i18-20020a056e021d1200b0036a3c403e29mr113388ila.3.1713544588580; Fri, 19 Apr
 2024 09:36:28 -0700 (PDT)
Date: Fri, 19 Apr 2024 09:36:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000826ac1061675b0e3@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in unwind_dump
From: syzbot <syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bbac3facb5d Linux 6.9-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13403bcb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=355c5bb8c1445c871ee8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93eb2bab28b5/disk-0bbac3fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47a883d2dfaa/vmlinux-0bbac3fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6bc56900ec1d/bzImage-0bbac3fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com

WARNING: kernel stack frame pointer at ffff88813fd05fe8 in kworker/1:1:42 has bad value ffff888103513fe8
unwind stack type:0 next_sp:ffff888103513fd8 mask:0x4 graph_idx:0
=====================================================
BUG: KMSAN: uninit-value in unwind_dump+0x5a0/0x730 arch/x86/kernel/unwind_frame.c:60
 unwind_dump+0x5a0/0x730 arch/x86/kernel/unwind_frame.c:60
 unwind_next_frame+0x2d6/0x470
 arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
 ref_tracker_free+0x103/0xec0 lib/ref_tracker.c:239
 __netns_tracker_free include/net/net_namespace.h:348 [inline]
 put_net_track include/net/net_namespace.h:363 [inline]
 __sk_destruct+0x5aa/0xb70 net/core/sock.c:2204
 sk_destruct net/core/sock.c:2223 [inline]
 __sk_free+0x6de/0x760 net/core/sock.c:2234
 sk_free+0x70/0xc0 net/core/sock.c:2245
 deferred_put_nlk_sk+0x243/0x270 net/netlink/af_netlink.c:744
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
 __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043

Local variable tx created at:
 ieee80211_get_buffered_bc+0x44/0x970 net/mac80211/tx.c:5886
 mac80211_hwsim_beacon_tx+0x63b/0xb40 drivers/net/wireless/virtual/mac80211_hwsim.c:2303

CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted 6.9.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: usb_hub_wq hub_event
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

