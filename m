Return-Path: <linux-kernel+bounces-124070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB258911CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECE01F22A50
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764D381BB;
	Fri, 29 Mar 2024 02:59:24 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289137160
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681163; cv=none; b=VAc7v9dW9K4wjB3PubNhavQr3id1q5VohW1NmKpKramttMiFkdNIp62RGMMxpu9hx+iodPuNWTjbYlqRHBWzv+qK06ATmqs5TLKSX/ed3LZysfo95LF3tdosfvgUJS5iy5oPpSbuhPcgL4nJdPHYHMAmMGjIXs7L9CfZcPWrd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681163; c=relaxed/simple;
	bh=dGtETsdt0QT/4xvEP76pejvB7FB1g2easUs9qA8vpVk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SW1KedaWfki4KavNoaAfmnVikO04cev/DhyoanX0eWK6uqMM0HQgkWGlBfYwlp/bKvArHtXNC5XcARKA0IYc9jqTA7BUd8oKAeifWgFteYi3GvUxCj7PzBHthHJU8yJc9J1Bqb+WsXwBQZa5v2rxO6T01Nuvx8yH5ERKkunooo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so151058539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681161; x=1712285961;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6n7QmXOvYboAd7Cq7lfplGqLO69ROJHflHj1c62Ec4U=;
        b=eN7frTpLirswBYCji7jq/U8WtWmHvUd2btjFo5GjKr9vsgFxz7J1apsBCILKK43neR
         KA4K6jTwilJPrS57j0P8Sj7KLyduZfIaqhlR8ZwP54ENnKJLN/HQwGvYPONxaBbwbqaz
         ghbLkDh4iurp/Kvcc/yZoaqVWYhZUfbu/OFr8/4LKdc0uzUmvmS5ocIksjr9XkYehI8s
         nu2kW6XBXfsUv//B3X+JQ+QAYZ2g9eq9BqL76sCiRwCLKzRAcS/Gx1CepUOkoDlHkwLw
         pm75th9K7LjrcHQqxfzY17UCk7MkQBwCxwUoLwDdMDzL52DwLEDt2pBtsN/tz2wDW3Og
         g+AA==
X-Forwarded-Encrypted: i=1; AJvYcCWX9yiKK3c6zz+QjY5EpSWQW2VukpHJu0R7BuHLUM6V7PPZt4WAjne2nbFoyVTKJPoa7nXrMjYbJDcxOIrz5zMqbGxJxQDQr9Gueplo
X-Gm-Message-State: AOJu0YxJ93Cpn6wHz2VT+zLo/uqEbltAW+sNZUXqJkQd42gwZqLzQbqC
	gtx0PTnPzJ2uhZw8MCZXVO3w8lECA6YrNlieqyJYnhwrTNU6lZCofirGdxCf69/Yp2FhYAJvtxI
	rSb1GYR+RsuuC4RTCGykREz1/7AXW4lZdQVVtJ5ee77x1zqBDjl4YjXg=
X-Google-Smtp-Source: AGHT+IGolnO7oOOyMon/XNOqd2HDi6/YkPAAhYiO/AndRNtsW+20fOtvMU0XJp762Ja0wcdLnnnlR/MH80jR7+0s7mokZjDFOJb1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378d:b0:47e:d028:3eff with SMTP id
 w13-20020a056638378d00b0047ed0283effmr21880jal.2.1711681161467; Thu, 28 Mar
 2024 19:59:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 19:59:21 -0700
In-Reply-To: <00000000000011b2f00614076749@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009925b60614c3d39d@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in __bpf_strtoull
From: syzbot <syzbot+8ac8b7b2292ea867a162@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	samsun1006219@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d025e2092e2 Merge tag 'erofs-for-6.9-rc2-fixes' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f2ffe6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=8ac8b7b2292ea867a162
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b3ac29180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160153c9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ccde1a19e22/disk-8d025e20.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45420817e7d9/vmlinux-8d025e20.xz
kernel image: https://storage.googleapis.com/syzbot-assets/354bdafd8c8f/bzImage-8d025e20.xz

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
 __x64_sys_bpf+0xa0/0xe0 kernel/bpf/syscall.c:5736
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Local variable stack created at:
 __bpf_prog_run96+0x45/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run_xdp include/net/xdp.h:514 [inline]
 bpf_test_run+0x43e/0xc30 net/bpf/test_run.c:423

CPU: 1 PID: 5019 Comm: syz-executor335 Not tainted 6.9.0-rc1-syzkaller-00061-g8d025e2092e2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

