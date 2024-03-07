Return-Path: <linux-kernel+bounces-95136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0478749A4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271851F2417C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9733F64AB3;
	Thu,  7 Mar 2024 08:30:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAB5B03B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800220; cv=none; b=Kr8EFHFj4WyjVOrHGVbT/219qbo0xuamL79Jd+7EOUIqgRFWdqlbbiAhw/dq8UN5ZYHIcrMYI8uDFJpt8wHk+I+euAt7bsonpAH55EyB4qPfjINAzhFOpl0YeVkBo6aCVLqsWgn8d8n/ttvLDd3t5Dl3cg/UrMw3cu+lW2t7xUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800220; c=relaxed/simple;
	bh=0fAYZVzkNANajbEox82PcleCjcFCVD2kAiceHZsNeew=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LWkIf4yYWq7TdCCAynu1U8foP0MIG9a7r0I6ebRs8LFh8keLJk+OdBGfZDcy/Ai57f2YUslnVBiCeoQIi//9hfcwrRVEK6C91fy8A1BVpU8Es1SKRQzddZ0OdrGO07L0LKk/tFosEsdPrJCJqD/xt+6cLuIC3b/2x5HHAHP+gfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c83e0f8c51so62751339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709800218; x=1710405018;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kOU1DI7iQ5eXeV3YAuu9M3eSVDmwHwlQYz6+06CcSoM=;
        b=JH+9Wry8WmBxpro/7+tTc/QsX6XnZuI5+r8M1vjExb2QQqX580DKZNmtfs5LyXxTiN
         5yhDJonYiazxFmBdMtet/N5K9vyXqUfiSvYMbosmjD14nen0tOui6H9dbs3658a2384Z
         fmqX1vWqKdxsTr4B5Ig6lZ2zTq1tk8olT4QIxeRZEs4Jh8i14urvWbGbsJh5IUS1lHBB
         tfLvQcDwbPJa5IBjC+mTVvcuYGiao1YwMfaINljMNSHHPRJT0dMB4mqssfZElTMly7pG
         zQGMwUiGiNF9FZhK8eW/Qk/MEPfbM3XdWFbDz8bdDCrnqoWQm5l5aN3sHYu2PA+uHrEi
         OhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh4RDRny5kE6zP+5bx2whA5SxvoCPVzaMmP9EFO7FFsr3XvANIX8QDTtiN3hiwz/OMdtvJ1dWKQIhrapehkNkq0n0OauysNTS3ls/l
X-Gm-Message-State: AOJu0YzqX7KW/o0tkN6Z/evXGkVODfATPkFDPYXpAN68pPNAA7jZdO7p
	U8xaeTq7ad2WwHKr8m94qrpkee0SSTx+OZtiNubQQyuRdZX1z9XevQIWUSAGs8trTkT/ROXl0zf
	UZToi9+pf424e87KckdF5yoKUg+L0Ezc6+1gJGh+rFuwTDYgJ/GUYanM=
X-Google-Smtp-Source: AGHT+IGxje5CvjesTv569fcM4amnpaVbp5+6kcuhA3pdKJql1WDwPUd6qNa+669L7vRC8jMZ+dgpqeDH3mIt0EXsiXok97fTAryj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16ca:b0:474:c490:d051 with SMTP id
 g10-20020a05663816ca00b00474c490d051mr368161jat.3.1709800217762; Thu, 07 Mar
 2024 00:30:17 -0800 (PST)
Date: Thu, 07 Mar 2024 00:30:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e2ff406130de279@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
From: syzbot <syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    04b8076df253 Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10bb9306180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11093316180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a53082180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a4610b1ff2a7/disk-04b8076d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/991e9d902d39/vmlinux-04b8076d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5b8e8e98121/bzImage-04b8076d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in strnchr+0x90/0xd0 lib/string.c:388
 strnchr+0x90/0xd0 lib/string.c:388
 bpf_bprintf_prepare+0x1c2/0x23b0 kernel/bpf/helpers.c:829
 ____bpf_trace_printk kernel/trace/bpf_trace.c:385 [inline]
 bpf_trace_printk+0xec/0x3e0 kernel/trace/bpf_trace.c:375
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2225
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xaf0 net/bpf/test_run.c:423
 bpf_prog_test_run_skb+0x14e5/0x1f20 net/bpf/test_run.c:1056
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2225
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_test_run+0x482/0xaf0 net/bpf/test_run.c:423

CPU: 0 PID: 5019 Comm: syz-executor938 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

