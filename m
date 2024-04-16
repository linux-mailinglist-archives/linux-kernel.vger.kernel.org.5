Return-Path: <linux-kernel+bounces-146048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72F78A5F76
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059FD1F21B73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41A53D6A;
	Tue, 16 Apr 2024 00:52:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CEF1849
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228724; cv=none; b=mtAHOXDBVsh/OPTCom5Gh9UxjpqTDcg5pbZrVhCQEkMsP4p3xs4x9I7KvTnr9SANeBWP9fafYyKH6Vmbw27lTAdqHLz7eo1/x5NbHUUYL46aNk74SeIG72qYlTN+3jum6xzhvbsnH1kw4hJLx/zCxy7/2YEDxAM7JX02gtd48y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228724; c=relaxed/simple;
	bh=zjG7+OaQnziYHRTWl7xNsjflohLBW1+2vxCilr15SIY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=brUzHxd1kNuoUeqwbbH/f2Cj5HnJq6NdhWLfCKor+ohiC6zjeE0ONXtgQlDiOHMZaX8IcibFyP7NfR8XC+IQlq7zSawwp0inSJ9Pr7W/OKVzkZP69g1K8JHb7c5Ympa5exjZZFBURQl+hYKmKNd4Ba97eFV5LmUucShh0PVMUiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so449642539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713228722; x=1713833522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmvDrKU/n7BIoU5MJ4UwfD/U+LFPgx0YQmMjKUEpAog=;
        b=nux4xyXPtUx17toqy5T8/YS06zwKcboAchW4nngylakD9nHNK8y57sztVdoL4Zwi7J
         fi6IBFqUu7gv3JysOpsYaRH9IV/YnRgwSw1Lcy1TQda49H6Dby/Rma5v7DZPxzSGJ7px
         2++afOpzLwivCd1K6W8FDb1eShJzHdDaJ61M95kt5hkC3o57oqZ0B2iMIyAKJNPo9uxs
         QjY2Bgi8qlaKEZ2VEsSCofUE2IbgQB6byjdsvOJRGVOK/bx5RVvkp0pHZaLRgdsWfBPH
         5vD+u/s4wbzdwbn1m/f2OGPwCsO8bupYPSbU5KxgQt6G0k9G4/seNzUkZXBNdU1gFlQZ
         mrfg==
X-Forwarded-Encrypted: i=1; AJvYcCVHeKnRlFVGAwsv8j+k25lXyT58F4ODiVkzrBrm9MrgZJffBOFu3RLLGoyJQTqfptAqWrc7y34IvVygey+L83e+XBixaH0s1jdOo9qZ
X-Gm-Message-State: AOJu0YzxPBgfIpGNGfE9IAx1Q4U76ed0Ex4Qx2IukdZ8Q2u+jNeuGRxO
	AFZvQDk9gZZ5ExXlcOTv7gtGCxk3ouwTAJM6Mj859kLoSjOnbMWOiB0NuIGITkZktfvNlfcDEtU
	Zq0X6sBe9DVewX7ewwdplEYHkIt75vMtFt7Jo2fUxOCxoXcOk+MR4MPM=
X-Google-Smtp-Source: AGHT+IFo+a9aOKmVUIwfIgGAF4Uwhc+vC5qgBFqFKsXTsqFQtmevQ32MLjoLsdIUy0ExrAq9dpzZCkhto3YZ+lYZ6zyqpzQHbEq8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:860f:b0:482:e69d:b0c6 with SMTP id
 iu15-20020a056638860f00b00482e69db0c6mr910332jab.6.1713228722081; Mon, 15 Apr
 2024 17:52:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 17:52:02 -0700
In-Reply-To: <661dc844.2e0a0220.ae23e.1016@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066253406162c2536@google.com>
Subject: Re: [syzbot] [bpf?] [net?] BUG: unable to handle kernel NULL pointer
 dereference in sk_msg_recvmsg
From: syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel NULL pointer dereference in sk_msg_recvmsg

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000043940000
[0000000000000000] pgd=08000000468bd003, p4d=08000000468bd003, pud=0800000046ab8003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3479 Comm: syz-executor.0 Not tainted 6.9.0-rc4-syzkaller-g96fca68c4fbf #0
Hardware name: linux,dummy-virt (DT)
pstate: 61401009 (nZCv daif +PAN -UAO -TCO +DIT +SSBS BTYPE=--)
pc : page_kasan_tag include/linux/mm.h:1834 [inline]
pc : lowmem_page_address include/linux/mm.h:2234 [inline]
pc : kmap_local_page include/linux/highmem-internal.h:185 [inline]
pc : copy_page_to_iter+0xb4/0x154 lib/iov_iter.c:360
lr : sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
sp : ffff80008964b940
x29: ffff80008964b940 x28: 0000000000000000 x27: f1ff000005cd9800
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: 0000020040000000 x21: ffff000000000000
x20: 0000000000001000 x19: ffff80008964bd50 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000382 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000001 x10: 382d7d5bed6f0326 x9 : a9c46d8380c16462
x8 : fdff0000056d6bc8 x7 : 0000000000000000 x6 : fdff000005cd6d40
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff80008964bd50
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff801000000000
Call trace:
 arch_static_branch_jump arch/arm64/include/asm/jump_label.h:38 [inline]
 kasan_enabled include/linux/kasan-enabled.h:13 [inline]
 page_kasan_tag include/linux/mm.h:1833 [inline]
 lowmem_page_address include/linux/mm.h:2234 [inline]
 kmap_local_page include/linux/highmem-internal.h:185 [inline]
 copy_page_to_iter+0xb4/0x154 lib/iov_iter.c:360
 sk_msg_recvmsg+0xf8/0x37c net/core/skmsg.c:437
 unix_bpf_recvmsg net/unix/unix_bpf.c:73 [inline]
 unix_bpf_recvmsg+0x13c/0x4f0 net/unix/unix_bpf.c:50
 unix_dgram_recvmsg+0x30/0x4c net/unix/af_unix.c:2529
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 sock_recvmsg net/socket.c:1064 [inline]
 ____sys_recvmsg+0x1d0/0x268 net/socket.c:2803
 ___sys_recvmsg+0x90/0xe8 net/socket.c:2845
 do_recvmmsg+0xc8/0x2f8 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __arm64_sys_recvmmsg+0xd0/0xec net/socket.c:3034
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x48/0x118 arch/arm64/kernel/syscall.c:48
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:152
 el0_svc+0x34/0xf8 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
Code: 8b160320 d346fc00 8b0032a0 d503201f (f9400323) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b160320 	add	x0, x25, x22
   4:	d346fc00 	lsr	x0, x0, #6
   8:	8b0032a0 	add	x0, x21, x0, lsl #12
   c:	d503201f 	nop
* 10:	f9400323 	ldr	x3, [x25] <-- trapping instruction


Tested on:

commit:         96fca68c Merge tag 'nfsd-6.9-3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16572cc3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ba795506e24be71
dashboard link: https://syzkaller.appspot.com/bug?extid=84f695756ed0c4bb3aba
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.

