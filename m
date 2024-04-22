Return-Path: <linux-kernel+bounces-153537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591F8ACF54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493991C2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC901514C5;
	Mon, 22 Apr 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrfzRs6e"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48881514D0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795974; cv=none; b=shduq7xosF+wTgBpc5VJ02Usd/rZus0n5PPNzTC/oWgRjYLJy2Gx437bHSZh1iPY2k7GaBO1qeIOv4PocWBATbxPs5eqA8+aPxt4a8q8REx4H+NUM0AfyHYTHdQEewN8WzRrHXQ7eZCJOQnvUHv+eQsfr+HgVvEJyToI1EIEGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795974; c=relaxed/simple;
	bh=/yWZ8xMYVRAL9qVEu9co7JGNHY4mKt21cBuo+1aE3y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+7q5uUe1+I4waQEkimHOs6lEQfo+g1ZpvlfnholLsnGKxQ7PdKmHXWHTiwWb9NByAa1BU6yI86bOh6EXdM9LeQ2io0UjzlbdefFdlGD/j9iCvJ7LlGHb/wG2I9eGeLPh9eBqg0l9J4Ocg0czFeiWtqEEG0nR+DwIjFg4RHEIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrfzRs6e; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so12370a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713795970; x=1714400770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/daevu4P3VIlTkEgUGpd0CJgDiQmVPdHNlXHA6B3X8=;
        b=ZrfzRs6e0jQxfowqgY5DwmOBz0d5F4mBU6DCTEMUGhEMmSCJClaCfIL8cIk3HwDTdP
         tCahbLjlk2eXvcWbzBtGuL9NG0nHSDUWN78ZyrsQyx3V5OMRra2FqQ/NkNldYZKWvopB
         /G4jHDpFDHFMXPr9RhgEBnGCOYENnCHOP/+5affwZDdFz9p+G8VI6Yzc2ZaUpQUVdtRp
         XaD0nxkvw9JEUAxD3KHJHa9IA8zveUdLtEgdpM9uJD5OxSZHrOLdfyb9XJOUs5d8KAqS
         QzhMIfvANdOfCBi9hKeSUb81p0HMlKzm8PF5WRIR9nPvpZUW9kqlPaz1QCEsc5NpqWt4
         wbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713795970; x=1714400770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/daevu4P3VIlTkEgUGpd0CJgDiQmVPdHNlXHA6B3X8=;
        b=rVZR/KUwFxhXmTRrPWNv1Um4z4npG+k8Tcl7KSOYEXq+f5phnEFEeOpJgPeojHxgrp
         G3aiBb61kKQk8SgTJlt5rBWAZ/pky0tulP19sfjJBUWSVNZVthYYq/HMGS+df5l4zIsw
         m5S+dQwVr1F5XyAfQIuXau8Ya8EmTBsEGaHCMB9rWX5HkA4fDRtFSUVEKQPPFXn861v/
         9DeRgOHiQ7EEPSexV2aTopucKIon9zbSjRgPuLYVw6WUaUoU8cb7pXLDMD2gu3M+d2rX
         daSXgKF917odO9UKC97zHajfN77Fbv8C6jv0mjoZPjMW7WZ7ajM7VHqntroPp7QyzfoE
         BeRA==
X-Forwarded-Encrypted: i=1; AJvYcCV4WA1xSn34iz9V7piEO+bV92fnDUugjzPK+PyC98uSKPqKxEnFbUHK4bMYChObDZF3fDb29hvATAyGQHWRvuaHTUhIAxXIuXhFVxgo
X-Gm-Message-State: AOJu0YzRSfP2OvcZ40urfINHo0RbrfKACx6K6xSEIKIvYUr7g6LDoMZP
	3IFwotZD9eO0r9n40KJIpxDphzPpNbkVYsnHygjzwSdG/y0ulm3kYkkIuJKDuoDQ6vgwT2zsNNQ
	o2c4r4xFUSm4fNDhX1ehcWupZQUYUctexIY3j
X-Google-Smtp-Source: AGHT+IHWFSmfhvprZgn+nCdRa04clSFSSc40I/vhqKF2TQTEN+Vj6Dka/3FYf3k8+tC16MNhxFjYBjqGWHBtVZ+dHX4=
X-Received: by 2002:a50:cbc8:0:b0:571:b9c7:2804 with SMTP id
 l8-20020a50cbc8000000b00571b9c72804mr217637edi.5.1713795969736; Mon, 22 Apr
 2024 07:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000eac28e0616b026d1@google.com>
In-Reply-To: <000000000000eac28e0616b026d1@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Apr 2024 16:25:55 +0200
Message-ID: <CANn89iKr4pY3wcMb=ONr8f5DU1X300XG8RoX7HU4_FEWSAJ9_w@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in skb_ensure_writable
To: syzbot <syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, fw@strlen.de, 
	haoluo@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:21=E2=80=AFPM syzbot
<syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4ac828960a60 Merge branch 'eee-linkmode-bitmaps'
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14710a5418000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D57c41f64f37f5=
1c5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D0c4150bff9fff3b=
f023c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D17cc49d8180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12c8861618000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f1bd74942969/dis=
k-4ac82896.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c99cbac61b8b/vmlinu=
x-4ac82896.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fa3d589c2a1c/b=
zImage-4ac82896.xz
>
> The issue was bisected to:
>
> commit 219eee9c0d16f1b754a8b85275854ab17df0850a
> Author: Florian Westphal <fw@strlen.de>
> Date:   Fri Feb 16 11:36:57 2024 +0000
>
>     net: skbuff: add overflow debug check to pull/push helpers
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D166b3a4c18=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D156b3a4c18=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D116b3a4c18000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+0c4150bff9fff3bf023c@syzkaller.appspotmail.com
> Fixes: 219eee9c0d16 ("net: skbuff: add overflow debug check to pull/push =
helpers")
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 pskb_may_pull_re=
ason include/linux/skbuff.h:2723 [inline]
> WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 pskb_may_pull in=
clude/linux/skbuff.h:2739 [inline]
> WARNING: CPU: 1 PID: 5074 at include/linux/skbuff.h:2723 skb_ensure_writa=
ble+0x2ef/0x440 net/core/skbuff.c:6103
> Modules linked in:
> CPU: 1 PID: 5074 Comm: syz-executor365 Not tainted 6.8.0-rc5-syzkaller-01=
654-g4ac828960a60 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> RIP: 0010:pskb_may_pull_reason include/linux/skbuff.h:2723 [inline]
> RIP: 0010:pskb_may_pull include/linux/skbuff.h:2739 [inline]
> RIP: 0010:skb_ensure_writable+0x2ef/0x440 net/core/skbuff.c:6103
> Code: e8 b6 f7 57 f8 4c 89 ef 31 f6 31 d2 b9 20 08 00 00 48 83 c4 28 5b 4=
1 5c 41 5d 41 5e 41 5f 5d e9 17 04 fe ff e8 92 f7 57 f8 90 <0f> 0b 90 e9 3e=
 fd ff ff 44 89 f7 44 89 e6 e8 3e f9 57 f8 45 39 e6
> RSP: 0018:ffffc900039ef8f8 EFLAGS: 00010293
> RAX: ffffffff893b75de RBX: ffff88802c8a1000 RCX: ffff88802a155940
> RDX: 0000000000000000 RSI: 00000000fb6014e4 RDI: 0000000000000000
> RBP: 00000000fb6014e4 R08: ffffffff893b7317 R09: 1ffffffff1f0bcb5
> R10: dffffc0000000000 R11: ffffffffa0000954 R12: 00000000fb6014e4
> R13: ffff88802c8a1000 R14: ffffc90000b06030 R15: dffffc0000000000
> FS:  0000555556fa9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001b7b398 CR3: 00000000241e8000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __bpf_try_make_writable net/core/filter.c:1665 [inline]
>  bpf_try_make_writable net/core/filter.c:1671 [inline]
>  ____bpf_skb_pull_data net/core/filter.c:1862 [inline]
>  bpf_skb_pull_data+0x7c/0x230 net/core/filter.c:1851
>  bpf_prog_ca74b6b79e086095+0x1d/0x1f
>  bpf_dispatcher_nop_func include/linux/bpf.h:1235 [inline]
>  __bpf_prog_run include/linux/filter.h:651 [inline]
>  bpf_prog_run include/linux/filter.h:658 [inline]
>  bpf_test_run+0x408/0x900 net/bpf/test_run.c:423
>  bpf_prog_test_run_skb+0xaf9/0x13a0 net/bpf/test_run.c:1056
>  bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4188
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5591
>  __do_sys_bpf kernel/bpf/syscall.c:5680 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5678 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5678
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f6a0471c4a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcdcead7e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffcdcead9b8 RCX: 00007f6a0471c4a9
> RDX: 0000000000000050 RSI: 0000000020000080 RDI: 000000000000000a
> RBP: 00007f6a0478f610 R08: 0000000000000000 R09: 00007ffcdcead9b8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffcdcead9a8 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

Hmm... Not sure how to deal with this one... this is a 'false positive'

diff --git a/net/core/filter.c b/net/core/filter.c
index 58e8e1a70aa752a2c045117e00d8797478da4738..a7cea6d717ef321215bc4cf9ab3=
b83535c4eec98
100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1662,6 +1662,11 @@ static DEFINE_PER_CPU(struct bpf_scratchpad, bpf_sp)=
;
 static inline int __bpf_try_make_writable(struct sk_buff *skb,
                                          unsigned int write_len)
 {
+#if defined(CONFIG_DEBUG_NET)
+       /* Avoid a splat in pskb_may_pull_reason() */
+       if (write_len > INT_MAX)
+               return -EINVAL;
+#endif
        return skb_ensure_writable(skb, write_len);
 }

