Return-Path: <linux-kernel+bounces-133590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFD289A607
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401FA1F21241
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AB175549;
	Fri,  5 Apr 2024 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxtPJ3qT"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E017334F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712352174; cv=none; b=UwkO9HFt1D7nVG9/5vevQOGlSUoCOkbbm1AT2IIgPgM2IEvujf4a5ot6jeSMtBZ973UUzPJVBKgS+P+pYD6I+YrsVdPEz0keZeiCrPlg8Oq1Y5slK3NjY+2rMTyPmqy4iR+Uj37hC08QQUFWGDvQXSfKp2moso8YnnpmILpN2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712352174; c=relaxed/simple;
	bh=+XGvr/9UwiEYoJxySupRBV0fX9P8bN9Wu4aGZNBWzG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKvW5uAwhBCpXZv8Ni47BbGsyHubq/QlRSYNuOWa6Yg61wOEtFlohIXzPjTCkc+8kEuPHtfHN7cN7wHw/537lrsxN7arcKAXR3CejobIr0r4OK49zcFhFC2t7OLNIPUpdBLOA6bKf/Ykuw79gyqzUWFviOZscqbyJi5aYZSbaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxtPJ3qT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so4220a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 14:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712352171; x=1712956971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bOittMnFEaGoOVCuwnFtfdUUNfSo5v/D1jXHfwcvf4=;
        b=pxtPJ3qT4wTIVSuqwhApOuUxV+A8e4pJWttpwvpjSUMq8u8Rm54z96eT6oJwxrKOOL
         XeXmeVPHBFbBFSdkkKcizZUmtu6GL8GS/rh5SGcnU7VdLvrLEiNeYJTSO0Zu3lKa8CSe
         +XB+tkJHk3XTzKxSvsllpUlv6O5j8zOHcHBdHrIMMfQm7ZAAKYITSAjhzIjuIONI6Fqu
         wfQDBy4uIJjmu5P3HAqKBTRmKuWwohVVoaoE43XmL/cqCGV2kjW2mGfOUDTx6D2pZMcP
         N1S4TZaHIL1bD8nyI3KgyXQf7UpvzptFwuvRRuG8CbjloXzgnvvsfYKlrme1TMTzM9tw
         v2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712352171; x=1712956971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bOittMnFEaGoOVCuwnFtfdUUNfSo5v/D1jXHfwcvf4=;
        b=SucnTRNDDVA3iVPXiLUQ+HxczIZ6jZci8DUEM6iLhUFOlobScvcI/J1Z4Eq8EQnwJY
         Ce7xJr6jOErYMVMhEP4O+jqL0dAs3oHAeycyo4RiPX+5U8AVnejEVGNCMfYmV8ehu6bl
         AiQa4LkCMY2pWTGtGUlXC0ESMee0l8k3Ywr5svUoghEr0oKucdopXUYOtDw+zPUfAxxx
         tFchZUqbl9dw59TlSg26KOVTYM0lhzqQbg7QgTNqduxna1VtRpfTxLzoyWhoFfYs3Hze
         y6Lb1bgRXJqOXy4PYMBhOaSgqtd7ToYhoKqnUT6tgfV5YHbU9PtSDwmi5OnV4DGRbfNj
         KLIg==
X-Forwarded-Encrypted: i=1; AJvYcCUiU1SfgeiUBZ5iQe9l9fKx30wphEl11bajEQaJInPVJP/3u2UP/e9820zpwQOW7e7qOIMOv/vHtfCTqxBvCYbtOgsWH2TSwdSA7y29
X-Gm-Message-State: AOJu0YysECvKEX941iwIBErHam3BsyMM2IRrBCDkfwc5+v5Uj4wtOk65
	GC+9hJDwQqTH8lkaiZJS21mkGWJNEAWp5gXRY48qewZwDaAtTzDBo+1QkbZ3NvtZGYgRoY+B2xm
	W6Rl/3ULEvxhqUAoPRQBAFwNxlxVjyTLZwNp7Dkg+33tGaiVBc172
X-Google-Smtp-Source: AGHT+IHW+7mf82GixhuIT44gfxUqRfQhYZqSPvI+8Wc67f6b41aoVw8JPchWHJiiUx52XXEGD+SfiIIS/CP4s+sHzXI=
X-Received: by 2002:a05:6402:c9b:b0:56e:3486:25a3 with SMTP id
 cm27-20020a0564020c9b00b0056e348625a3mr6488edb.1.1712352170998; Fri, 05 Apr
 2024 14:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000002ca935060b5a7682@google.com> <0000000000009c0f98061550a827@google.com>
In-Reply-To: <0000000000009c0f98061550a827@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Apr 2024 23:22:40 +0200
Message-ID: <CANn89iLxVgrd2QoFkv0xS6ppyZTyO5Hnv5+M5gGg99BQ09n5Ng@mail.gmail.com>
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (3)
To: syzbot <syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, hdanton@sina.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 5:00=E2=80=AFAM syzbot
<syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11fdccc518000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfe78468a74fdc=
3b7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D9ada62e1dc03fdc=
41982
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16696223180=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/dis=
k-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinu=
x-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/b=
zImage-fe46a7dd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+9ada62e1dc03fdc41982@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5236 at lib/ref_tracker.c:179 ref_tracker_dir_exit+0=
x411/0x550 lib/ref_tracker.c:179
> Modules linked in:
> CPU: 1 PID: 5236 Comm: kworker/u8:6 Not tainted 6.8.0-syzkaller-08951-gfe=
46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: netns cleanup_net
> RIP: 0010:ref_tracker_dir_exit+0x411/0x550 lib/ref_tracker.c:179
> Code: 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 88 e7 9f 06 eb 1a e8 71 d2 b=
5 fc 48 8b 1c 24 48 89 df 48 8b 74 24 20 e8 70 e7 9f 06 90 <0f> 0b 90 48 83=
 c3 44 48 89 df be 04 00 00 00 e8 db 23 19 fd 48 89
> RSP: 0018:ffffc9000905f9e0 EFLAGS: 00010246
> RAX: 717a74f119e84f00 RBX: ffff888021ec9e98 RCX: 0000000000000001
> RDX: dffffc0000000000 RSI: ffffffff8baac1e0 RDI: 0000000000000001
> RBP: ffffc9000905fab0 R08: ffffffff92ce55ff R09: 1ffffffff259cabf
> R10: dffffc0000000000 R11: fffffbfff259cac0 R12: 1ffff1100df19ef8
> R13: dead000000000100 R14: ffff888021ec9ee8 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f5c604d35c0 CR3: 0000000029078000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  net_free net/core/net_namespace.c:462 [inline]
>  cleanup_net+0xbf3/0xcc0 net/core/net_namespace.c:658
>  process_one_work kernel/workqueue.c:3254 [inline]
>  process_scheduled_works+0xa02/0x1770 kernel/workqueue.c:3335
>  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>  kthread+0x2f2/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz fix: rds: tcp: Fix use-after-free of net in reqsk_timer_handler().

