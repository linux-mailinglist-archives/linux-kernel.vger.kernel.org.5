Return-Path: <linux-kernel+bounces-107983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57388880470
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E1DB23E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E22D638;
	Tue, 19 Mar 2024 18:11:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E62BAE9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871889; cv=none; b=Y6WKtYEEnFfq99JMk1H/V+koi0KGJRjtGLXnk+x/tTcTiWrw3oX5l2l+T3zeXimoGUEF25u109YtfeuqmWen3fAyKQu7M6mTWnUO062QVnG9u1rIPCav2ag9xDH2EWA+Lw1HQdC/WHIV5ZA0GUHdKort7/FoECAxTavlcunP8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871889; c=relaxed/simple;
	bh=tiGL1NHxk39qgpzX58WM7MKSdnmnH6vTVN+JwmMZD6g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GbM07rAY4SBjs2//8xjvLVo5zUwZ0ywgkM0D6E7XtsS2F6F+h51CwtYtv0WugPGEXEL8MjjkeKrlehnb+kPEuwlmOYvwicJq6FiCEXHQQfqt8hses1XcrTXdafstEWxQTHZDyk4ty4hBbX3FGBprUMY96uv7DoUY2Hsk5cZu3Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3657cf730a0so65040805ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871887; x=1711476687;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4FGA3Q/Jsb5iylMpt4gm0U57kMlr8EgSfuZyJGPJfJk=;
        b=CuLFRausT+JEgXKVWehNNx+0WQn+Xtaxg41Sp8b47Pv66tQabQbY3bn9C9ZwCKvnXb
         k0yjF4B9tUH3/u/dMPl23cqyCDj+dG9TJsE2K26sr4JL0pIKTeYIAneblwJ1KFVzyXpc
         BUmiZonkHL83gnIG0CM8e1N4rkHg6/aNzP9YihnhUYly4REVeKeohbH87vbOajgK6VHo
         JrC1v+gXxnJ8lwLxX+Y+cRBWL4t5WtFHtBnKPzYO2DPjKCa62GaXLgBg9Rk5T+6rZ7uJ
         ohaTrHHgTJJHYm9ZgE5d1EZeXEW5y7EEgWwcMezVNVJFZLXWfWRSRkyv3/zm6Vw9ydNm
         fcqA==
X-Forwarded-Encrypted: i=1; AJvYcCVNlfNETQR4rPQHPe9HYnW4n1MD881PGarlB/V3A/YgBc3QJaJ+dvXxW9dMJcaB01VnUA4hXVcBH1JepQOUbKy6YJdEPjLlOLOEQdlP
X-Gm-Message-State: AOJu0YwMEf43FZp3E3T6R5u6utnowTJZCp2CRRMEl3m6l2pyWQ7zYQhM
	t8KpBhyeosS1q8h8lyQA7M3SKf16ciRjajV4nQNb8HgeOeHubCezB00L4sgTUpuh7YGSNRIN7bo
	G8qnVXQnyHWVgINEk5EmEt0wI9X+NM6SmXpKTTwQvBu6s5VP1bFAEaF8=
X-Google-Smtp-Source: AGHT+IFmFGl290mOUiju8BeiMLuWxemiwm3OHI1KQCej6a3+CV9O/BljYHG38jI0cLAM186qzncQTYeAY5huH5cRFpHkhyemTZ+b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:360a:0:b0:366:9ead:645b with SMTP id
 d10-20020a92360a000000b003669ead645bmr343659ila.1.1710871886800; Tue, 19 Mar
 2024 11:11:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:11:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b2f00614076749@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
From: syzbot <syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    741e9d668aa5 Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=113721f1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac8b7b2292ea867a162
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7e1776e6e382/disk-741e9d66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69580881d554/vmlinux-741e9d66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65e4047a1117/bzImage-741e9d66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoull+0x245/0x5b0 kernel/bpf/helpers.c:465
 __bpf_strtoll kernel/bpf/helpers.c:504 [inline]
 ____bpf_strtol kernel/bpf/helpers.c:525 [inline]
 bpf_strtol+0x7c/0x270 kernel/bpf/helpers.c:519
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run96+0xb5/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423
 bpf_prog_test_run_xdp+0xeaa/0x1a40 net/bpf/test_run.c:1269
 bpf_prog_test_run+0x6b7/0xad0 kernel/bpf/syscall.c:4240
 __sys_bpf+0x6aa/0xd90 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __ia32_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xba/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x7a/0x84

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423

CPU: 0 PID: 11097 Comm: syz-executor.0 Not tainted 6.8.0-syzkaller-11339-g741e9d668aa5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
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

