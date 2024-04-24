Return-Path: <linux-kernel+bounces-156272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BE8B0096
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257A9B23DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C668F15380D;
	Wed, 24 Apr 2024 04:32:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D4152DE1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933147; cv=none; b=kUd3KuZKeiOszaU324KWajLyqgNEqHvOiwgvteRAYynLPtQHBvp3kqwbuc9kohBLic8C3tw9JXTgdsnaUWTeCQP1+qwoSKUhNWYzs7L+CQbNF9BmbWQ5/x16rW0W42GyDY3923Y41UF7Zvj/Ww+tr0gJ11J5EP/8pBzZSoBzM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933147; c=relaxed/simple;
	bh=/LCrrqzmvWiGPIZB22bQ5ZYR27Ggafk91ccmd/t9HzA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MNQECuhFqvG23Ayu9SeQbPZ6Hxfp4fELjKKvSN+X9SHf/h8OG4/6sAg53t3FOIqwCxqYZiENdygbrvJaw/60DwuWHXV9E73GCh2UNoWJPtPullM0dU+6Xbm0KPkI0AcbgiL1Wm7ryo6wawpzi/2mwgc4VjEb4S4cBCeJyRXfSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da41da873bso786419239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933145; x=1714537945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7F9q8LKnGslbaDCEPZim7I8bSQ7WXorVsXiaYhSXFk=;
        b=dNinaimaGo3CSqktcfIvwuiJgJ2fnEcd0zbinYe+DLn2axfANDss7pT0ijGichl2uN
         Jd3BHQIAvzrV1IYhwiPpTs+1wxXUQ+cQ2IHXqzWS3HKiDfm1XNwKvGtYpQrN6U9FTKBC
         eF9214S0QJLydkkvxrjV7yhdPKaQhnsTEOgwJyUc2AdryBf4SSjhqnKX+pRyYyR2Zm5y
         c9qOeuB7kFECPXf4GPf4+JP4i731FB27zM+xZvilYw9BlFNCvRtx3j5yJR9032VrMW54
         J3FOPbtU1LbUzMrt0QQw5Vxzbb6mw1i6PVFFziS3IfaaKSJtarPftY63lyYOW26NkAR/
         Xn6g==
X-Forwarded-Encrypted: i=1; AJvYcCXYjffqF8dpD6cEO9N+WKvlcCQN/TH7V/5UR56HL9/9LaBMim0WT6OFs5cvJuKbsoxHz+bCTiBDL6NnNLl2Pd1Wpu3pyRV+nMa3mPvz
X-Gm-Message-State: AOJu0YxvEeDhFhbvM2bX7kL+3bbdv2t2hI56ik7dgsmWqH/Ql5ydtc6D
	VkKDvQ1ytgmkhHOwoCTZPfLV+srDuO+ygsrADr/Gz/rG+NQqdfJUpYN1oz1Om9wNUb2ZEqBqZTa
	94rzWRiUWBzLLUUMOK8x3QTnrjwNHMDQFbtf42dCQL3UVlARcLotrjhc=
X-Google-Smtp-Source: AGHT+IGll4l2W8rp8JECph6mthKpERioCEdWuyBfxXzO5GWc08oqoE0bx7wc2f5zOmRcOwtx9ZvbtgC/6Bzcpbbq7glgNbUu3dhO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:830b:b0:485:7a8:4294 with SMTP id
 io11-20020a056638830b00b0048507a84294mr179480jab.1.1713933145214; Tue, 23 Apr
 2024 21:32:25 -0700 (PDT)
Date: Tue, 23 Apr 2024 21:32:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a20330616d0280b@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in reg_check_chans_work (6)
From: syzbot <syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12383e07180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11449c27180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749866f180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04e2e4bee9fb/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65456769dc43/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09504bbdec9e/bzImage-3cdb4559.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com

INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
      Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:23744 pid:5088  tgid:5088  ppid:2      flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6746
 __schedule_loop kernel/sched/core.c:6823 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6838
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 wiphy_lock include/net/cfg80211.h:5953 [inline]
 reg_leave_invalid_chans net/wireless/reg.c:2466 [inline]
 reg_check_chans_work+0x10a/0x10e0 net/wireless/reg.c:2481


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

