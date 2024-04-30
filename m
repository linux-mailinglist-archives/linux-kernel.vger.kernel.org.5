Return-Path: <linux-kernel+bounces-163794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2C8B70C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B1F1F2232E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703012B176;
	Tue, 30 Apr 2024 10:49:34 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512812C47A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474174; cv=none; b=aY4fhEd/byn1FgBl4w15oW2ZiwKwFRRLCbQ90iXhV7PGz5Uu21Nc9kf3Ze0URhi5kFCtgLE+kl+MxXyI0oYjxmFvELNjuHhih3v5+HSdyV1k5Ms2YKOWk6L2+1sSU6fe90yXjk+R96uewH9k0d5/6RiUW9DBsgUfovZA5iU8s5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474174; c=relaxed/simple;
	bh=rg7Ir/JwmVTjrliKbX84vWYg+XqEFJCSeIOZ8yghe/0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UEmV0X2tlxFET1K456ZFWXe46/pbMrAoN8ZOAEMey5dvK14/g1B2TwBrRfcjPjnmrAwFFjdNxVEYTpOnEkzFhkWtlnBVIlzbfIYhPqF6NH7lCPSG1v/+k+SZjcXfdM6Z4WaCvrsudyKenprIO0kmT76WjTqaJPI/Iib6/PHmcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so453236539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714474172; x=1715078972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5kpd8aa6Rw6Tv6ELMLEFAJfgughcDa8xDxAee/jbg0=;
        b=IGvTt/azujNGZTSzBB/GsySbttf+khCq9GVRVyrhwp9wBiouEcjguGuak2eV5zEJrH
         uJcxP8FTVfUVd9E1vqnFcWquxtAJUFNpBMyqVtNg6rugAm5fQ8SuoyEKXnXyFELa9Nft
         TkTqlf9diB7GLDFyRCZiesj8wp0WyRdCEt0VFjK0hR6SJ1BFETWtLpUigEkpZqgjmeuj
         K5sFepbVciQd68CsWUttLpD3xv5zKZcKdLXF2s8aUk3IqtlfiNgKRebf0SAQ/3U3ePGE
         QHwDnujCVfeDrNGdnhJuOIVvfcvI1PGVpmeIokMikfe1xomb/QYyxMZyizHKj40pdXoV
         C7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVplOuCHsBpT6CSPTwI93wh9R8+rilbWwazdViLhb1aHUeiRhTepI1Mg436eQ6FTJvjIZxcMSGhNhWRfbmLA+J0vjZq90M8DCep1+Uo
X-Gm-Message-State: AOJu0YzcYfEuq1UdpLOnJmDrLvVrInGqekn98u3OAo1v0qA6BBWsdXlZ
	lw0Oba6bz1iPVqtU1/ftcfSou8uZc/Wu09W0xuRh/fg/ccmcH1PKDcvj1ShBP4E4jIEiqRK6rP0
	HkEErtGaF+QviVfOuXGCusuvDYgFj2+Uar2FvHh/42rCCM1/isOnK7YQ=
X-Google-Smtp-Source: AGHT+IEanKNOfl9IZZvqvNS0s274g8HAyqp36SXPNlICm0pE2TEOTyW9lHiolcRIMxHXUHPsL3VEVXY7N89APsr7tbNvJZhGu56D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6422:b0:7d9:b860:3e54 with SMTP id
 gn34-20020a056602642200b007d9b8603e54mr55948iob.2.1714474171892; Tue, 30 Apr
 2024 03:49:31 -0700 (PDT)
Date: Tue, 30 Apr 2024 03:49:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe324606174e1f9e@google.com>
Subject: [syzbot] [perf?] WARNING: suspicious RCU usage in get_callchain_entry
From: syzbot <syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c942a0cd3603 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef0aef180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=72a43cdb78469f7fbad1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4d490980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138bf96b180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c942a0cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02773b27b0d3/vmlinux-c942a0cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/669bed7ebf5d/bzImage-c942a0cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72a43cdb78469f7fbad1@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.9.0-rc5-syzkaller-00159-gc942a0cd3603 #0 Not tainted
-----------------------------
kernel/events/callchain.c:161 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor305/5180:
 #0: ffffffff8d7b04c0 (rcu_read_lock_trace){....}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8d7b04c0 (rcu_read_lock_trace){....}-{0:0}, at: rcu_read_lock_trace include/linux/rcupdate_trace.h:57 [inline]
 #0: ffffffff8d7b04c0 (rcu_read_lock_trace){....}-{0:0}, at: bpf_prog_test_run_syscall+0x345/0x770 net/bpf/test_run.c:1508

stack backtrace:
CPU: 3 PID: 5180 Comm: syz-executor305 Not tainted 6.9.0-rc5-syzkaller-00159-gc942a0cd3603 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x20b/0x3b0 kernel/locking/lockdep.c:6712
 get_callchain_entry+0x274/0x3f0 kernel/events/callchain.c:161
 get_perf_callchain+0xdc/0x5a0 kernel/events/callchain.c:187
 __bpf_get_stack+0x4d9/0x700 kernel/bpf/stackmap.c:435
 ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1985 [inline]
 bpf_get_stack_raw_tp+0x124/0x160 kernel/trace/bpf_trace.c:1975
 ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:681 [inline]
 bpf_prog_test_run_syscall+0x3ae/0x770 net/bpf/test_run.c:1509
 bpf_prog_test_run kernel/bpf/syscall.c:4269 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5678
 __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54610dc669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff4b9fae08 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007fff4b9fafd8 RCX: 00007f54610dc669
RDX: 000000000000000c RSI: 00000000200004c0 RDI: 000000000000000a
RBP: 00007f546114f610 R08: 00007fff4b9fafd8 R09: 00007fff4b9fafd8
R10: 00007fff4b9fafd8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff4b9fafc8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>


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

