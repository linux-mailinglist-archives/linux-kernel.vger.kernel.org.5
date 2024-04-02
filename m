Return-Path: <linux-kernel+bounces-128419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A5895A91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84E028741E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B5515A49D;
	Tue,  2 Apr 2024 17:22:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1C15A480
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078545; cv=none; b=WlNJBgmXWGiFmMHxTAHubee5WU/0KD2LBm1+65YMPJIDFlR8SW0YlpTHU64gS4YwxtZzVbQyYzNnMN0kZcvY71PunzTp5578SQQ9qtLSkFcPacECuuZB4hM9eChcFizeEQb247AknDcAXjsM3zD03eLHwKbh03biffeVQpl9v2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078545; c=relaxed/simple;
	bh=LBktxRSJW6FqJOM/haOQ9aZlZaZ+M2+WyyYEVud4ees=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WqOwGW+kLIsmqeLwqci8YDe/8wpNuZ21PbRmDpSosqSiW6rjuJBZRVm+wjJAYy6IJVGDhVK3H0NfB9cr4IMU+13q5GZRlhzwfTlfA7zZDEifMVYGJvfrVSS+MhpDo9B+TR443qwCRKWGvH7PqRQPqAdUwvd6K+5HrNPPMm5amdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so7538239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712078543; x=1712683343;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyZ4y+RtmwUpbBCKI17zVFEJ/EY3alOUhTWMMfA+maA=;
        b=FYY5cMByfqhRjZQB1PNjtPFsURMrrNB6jMN0QFeq3nQlk3AaRccTOuOlCV+4r81f0C
         COvZ8enNSHfKnGwxJn44Y7Ku6UUigedgYVNRLbU80kkLw5Q46ZtQOzlOE/A7OwFRQT89
         +4yNVX3N+u5KnJpo88V2/3y5WIDjegRgcZ2mC9Ib8n6EYzQVtglPntPW3JCXbb33okjB
         DWXnHXvk06QoGkIpJDk/Oht+zhIEc0UFgyFoPl+a5zqaY0788IjTbnWTlCSsUTwWwT5/
         F0leQbjOoe+EfHIchkrrOAAX9vcCdnc7u8IEnUv8Uow9FRMGdqxAejaqnD54hcBErXvk
         PafQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfJTuhVRv09ENz0PYBqQWh4yewiNKFzvoGF6RUf2Egd5NwnpgB6qvIYhZXJHP1XhWZ5iuGBlwfoavRnNmNj2tx6TLg3w6rrsM8P/rX
X-Gm-Message-State: AOJu0YwnkSTrYvHE5OVkILJZbFMFNZ/TJd0X2rK65sRaAWzTR1FfzV+q
	D4y0tmgG1FQgcJPTrlAQp/x6qr/kKokyjaRNieE9l3KD2lKItAeClCYHMO6r61qYbSoT6o4yJ5E
	BK6HoVRXBFwgZ8dGq2tGrNHzNaOrCkkL58fyJQ1Sus2AHg46y6+xolww=
X-Google-Smtp-Source: AGHT+IE5sYOEGeW0Dq9TUU6KKmEsVku0KXM5A4AszSQ+g1aN9s9OafJG5FdmlE5Z9+ghoNOKg8Q5AHV20WrkTDprfIre4KzwBvME
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c84:b0:7d0:690c:6a01 with SMTP id
 i4-20020a0566022c8400b007d0690c6a01mr5504iow.1.1712078543509; Tue, 02 Apr
 2024 10:22:23 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:22:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069edc606152059d4@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in percpu_array_map_lookup_percpu_elem
From: syzbot <syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13891cc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=aca389a8a7da35c070ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11629a19180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169e86e5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dba7eac545d2/disk-39cd87c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ddf1c8e07b17/vmlinux-39cd87c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/808527761eab/bzImage-39cd87c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aca389a8a7da35c070ce@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
 percpu_array_map_lookup_percpu_elem+0x1cb/0x200 kernel/bpf/arraymap.c:257
 ____bpf_map_lookup_percpu_elem kernel/bpf/helpers.c:133 [inline]
 bpf_map_lookup_percpu_elem+0x67/0x90 kernel/bpf/helpers.c:130
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426
 __bpf_trace_jbd2_handle_stats+0x51/0x70 include/trace/events/jbd2.h:210
 trace_jbd2_handle_stats include/trace/events/jbd2.h:210 [inline]
 jbd2_journal_stop+0x1157/0x12c0 fs/jbd2/transaction.c:1869
 __ext4_journal_stop+0x115/0x310 fs/ext4/ext4_jbd2.c:134
 ext4_do_writepages+0x1c3c/0x62e0 fs/ext4/inode.c:2692
 ext4_writepages+0x312/0x830 fs/ext4/inode.c:2768
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 __writeback_single_inode+0x10d/0x12c0 fs/fs-writeback.c:1650
 writeback_sb_inodes+0xb48/0x1be0 fs/fs-writeback.c:1941
 __writeback_inodes_wb+0x14c/0x440 fs/fs-writeback.c:2012
 wb_writeback+0x4da/0xdf0 fs/fs-writeback.c:2119
 wb_check_old_data_flush fs/fs-writeback.c:2223 [inline]
 wb_do_writeback fs/fs-writeback.c:2276 [inline]
 wb_workfn+0x110c/0x1940 fs/fs-writeback.c:2304
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa81/0x1bd0 kernel/workqueue.c:3335
 worker_thread+0xea5/0x1560 kernel/workqueue.c:3416
 kthread+0x3e2/0x540 kernel/kthread.c:388
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2237
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run8+0x1bd/0x3a0 kernel/trace/bpf_trace.c:2426

CPU: 1 PID: 1070 Comm: kworker/u8:7 Not tainted 6.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-8:0)
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

