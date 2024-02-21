Return-Path: <linux-kernel+bounces-75480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2732F85E947
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9F62841BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF786AE2;
	Wed, 21 Feb 2024 20:55:25 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9901F3A1AF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548925; cv=none; b=PIWRb388ro+rDSKBGrLFoas30zvkbqDey53Lh953LXyNukHLeDJYPtJcpd6xbXXhNs/1FN0iIeJvv7weO4Hyt2yk5iUdu1L/kfapMN7NyLjKBjUuPmaoCVz89vsiBagENe9Tm4qguXJDQ+usxuzj0ZT08wZTVK4BPfZGKhWdxg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548925; c=relaxed/simple;
	bh=caKc/CPpM4x3ScSRVkyxc33LEvt4ZNW7IkX4c5n4n9Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mXxdb7lyD697seCIztTf/ykoVZUYfX6UpK3IjUH6Nd8FQRo+tCKRAI55YOyekL2IwRetVX1gQhxHQi9m/nw0eoZ1Cay88Tz1RMpbvo8z/N40HT9LGFwiGoqQaP8LTKVfCfb2+XUSpvocy80y4EvIJkFUVRvewZ+VqCaD7I22kvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7490332deso394216539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708548923; x=1709153723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtt7yIyV6XwD7hBaKZDpwR3hipJAtiE0FYIHBc4h1jM=;
        b=dU2L33BhTE/Hgam1rvwYJKkcjUHq45GDkQbKVp/xqPHjpABSwOFB6D9gjAg/gtdgm4
         9qIC+qW7uf9/1clyQCyyEOKwzzVyhjEHBG01AZRjQmO4XveUMsFjHhFBrY0ukzvgaqus
         bJ7QcvVqFL1vmMTQn4/G5N1cKeZs3MLIy1U++T9DboM+V4A9QNkPUDDTp+2cF5rrChAF
         FDxyWPFWiB50p3HNepL7a19W1tah3k0lDhvuKIoetmPK/bFdoiBWjJGdImvIsxPB+/JO
         W1meGDYfcVQvEmazMz+kOnXyC45a+Mug3FoVsS8sC8fS+U07JRfhaq5xjuzdR+HjfRxD
         gZNg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0lJNeuBZ64SlFKC81KDoc3B1boSDYEIExz8HIFu7KfWZA7JzMFbk1wttHflxbw4fyk+xsOc8glPeRnCGYCKsykMBsf1o4HKX4n12
X-Gm-Message-State: AOJu0Yw/MS32hHVWayacSDnXXIVo72VlbUCxCqx0ozzuoWPO65yRoqL2
	NdmV8hg3J7W5dULP10HZqphx2p/RnDemUxV4dONseSdIT7CzmeelV2uEKhgIOdRiZRVZDsLeyAU
	9Dth/DIcAPBomkGKJdYBfocuemOTeJUJEsLTY58B/+nbo3ESCa34aMYA=
X-Google-Smtp-Source: AGHT+IFjfWHHZS+CgUYJNUaiQuXIriqXVLJFN+VJLxesSIvlRJ1EDKEoQIr4araHddqeZbQgAx1C7OUvBcpBz0UgEp7qjreX/92G
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4905:b0:473:edc2:9589 with SMTP id
 cx5-20020a056638490500b00473edc29589mr459889jab.3.1708548922907; Wed, 21 Feb
 2024 12:55:22 -0800 (PST)
Date: Wed, 21 Feb 2024 12:55:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1a6990611ea8b4d@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in bpf_bprintf_prepare
From: syzbot <syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ca10ceffbb Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1364db0c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
dashboard link: https://syzkaller.appspot.com/bug?extid=c2dc95f7d0825a145992
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83d019f0ac47/disk-c1ca10ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49e05dd7a23d/vmlinux-c1ca10ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68ec9fa2d33d/bzImage-c1ca10ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2dc95f7d0825a145992@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in bpf_bprintf_prepare+0x20d7/0x23b0 kernel/bpf/helpers.c:904
 bpf_bprintf_prepare+0x20d7/0x23b0 kernel/bpf/helpers.c:904
 ____bpf_snprintf kernel/bpf/helpers.c:1060 [inline]
 bpf_snprintf+0x141/0x360 kernel/bpf/helpers.c:1044
 ___bpf_prog_run+0x2180/0xdb80 kernel/bpf/core.c:1986
 __bpf_prog_run288+0xb5/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991
 bpf_prog_test_run_flow_dissector+0x6f4/0xa20 net/bpf/test_run.c:1359
 bpf_prog_test_run+0x6af/0xac0 kernel/bpf/syscall.c:4107
 __sys_bpf+0x649/0xd60 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable stack created at:
 __bpf_prog_run288+0x45/0xe0 kernel/bpf/core.c:2226
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x127/0x470 net/core/flow_dissector.c:991

CPU: 0 PID: 6318 Comm: syz-executor.2 Not tainted 6.8.0-rc4-syzkaller-00331-gc1ca10ceffbb #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

