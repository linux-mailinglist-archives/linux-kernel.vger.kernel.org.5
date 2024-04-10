Return-Path: <linux-kernel+bounces-137755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8749889E6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF571F22AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86E338F;
	Wed, 10 Apr 2024 00:22:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1FE7F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708524; cv=none; b=dOFRfzVoM6xh/Z9JS8RgqyCUU9Tj/BUYo5EK1mmNaaFwEg7amJKI6NKqgJKLR1zPJfg0n29ftMiqolKYSIRm7vEb23d0tcjSVWMICxJH7Q5BgtYnAiyJQ+LFCnLTxbW5+1yurPJXYdF9eFyLiSGLrciRABGXz53RdiwIQC6h/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708524; c=relaxed/simple;
	bh=wUtpIL2ILOC8FA4U/sXwjnh/Fx6raImDqd7/l64IJko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IztuXo40pIx2nc56OSPukXAH9AKn1YEENC9CKZOiIU5s6JGheTNRtzcxXlIMsXNTaPrvYHMrMOIvov8RccTPoCQFixy9+yNgeHC902inU5/aXP794w9g7U7bJx9raFX10K6wXbkesVHGBud7TmSkseVWqJNt2oVkNQWhV3tgHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so655055039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708522; x=1713313322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNJGh+sEpeFJq+m+uYFXwLpIvO8auMGS2CbLoDFIxTo=;
        b=smKQBLHaLSdzJF4TNGAYxu3ZNT/N6SorrRomhG9oyVFN0i7hnDee8yMeMfvpwbGBGT
         xvIYR9W2RJYMjYPbA0jFl9wXa9iwMzIWAB7Mn0qTxktlq/+AGp0Dw7l9ocdIxfezcD/C
         djyex+Yo8hwsqMwkgKaRM8na6iSmi9YNduxM9bCAOLE+RMTtxhrX6KJs1wQMfNYvGsK8
         1qJe0o7GnQ+8I/tC621xwXOGPzgGGQcnSC0JiUdMvq7GL/pimw7NFryw1hfoUI9YeYji
         j2n+Q+V3aigZkBGK9yEOJqo5ro8OWFy/iAE2bWuqIVLRDvfx+YKvZ03KHnctPRtzXZoU
         KGBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIPAabPV2m/xh+BAZvWcmLaBtaKDNScN4oSMdi1JWRiMWBTMYcDq6OJp2qdU+WBRJgjWtuQC61HCy/+rgo/IozlX480QAx4A8CFJow
X-Gm-Message-State: AOJu0YwFErxA8ox4g4zsP8c7y2mq+rQXKvOUsM9hs78+TWHti2wD2W4O
	Thrx78sCKX3bIV9d5zRb5T4AiPW5dy0fQvvUUcrU3G4UGiUZSPadO0nuhm4vStorKGepAoWNTDc
	52yKrZBFdKv6uhjpcN+3kgi0AGcU8wTKUP0FVIk+VPU8pwfG4a1tAbkA=
X-Google-Smtp-Source: AGHT+IG1H7CTc/dXQKUFy9+KgHHqfW+wHwgjNkOSOU/ZrwyrvqMcv/OZEZgPmpX0x5MYzxbHmojf566tEmfKkkdQrTpGzS8s+U3e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4412:b0:480:6aa1:1d03 with SMTP id
 bp18-20020a056638441200b004806aa11d03mr38956jab.3.1712708522102; Tue, 09 Apr
 2024 17:22:02 -0700 (PDT)
Date: Tue, 09 Apr 2024 17:22:02 -0700
In-Reply-To: <tencent_4DCD347A366F802CB96D5095B8EAA6ED7E0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000105b7f0615b307c0@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in strnchr
From: syzbot <syzbot+9b8be5e35747291236c8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in strnchrnul

=====================================================
BUG: KMSAN: uninit-value in strnchrnul+0xb5/0xf0 lib/string.c:352
 strnchrnul+0xb5/0xf0 lib/string.c:352
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

CPU: 0 PID: 5507 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-00250-g04b8076df253-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1470b105180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=9b8be5e35747291236c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112caf9d180000


