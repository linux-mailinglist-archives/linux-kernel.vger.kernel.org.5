Return-Path: <linux-kernel+bounces-152997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676E8AC742
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880E81C203A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC04502A6;
	Mon, 22 Apr 2024 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4kVrvdjr"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A67502A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775214; cv=none; b=YVWONrB7ZWMlj2CF8vJ0MInILOeTgZymFoNtWuXSAayR3thtBRgrzGSsMav3iWL+HJBC8xmRnjPSt2Ex+E9JmGiSaiQ83PBjHXtHG45vXTo1oJGZzs40Zur/qqXhIbK8a5YxJAs1qBiejx9BGLARrOQEnVGGKKf21dXWghp+Te8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775214; c=relaxed/simple;
	bh=gBjd+Vu8U7gmMK1cuacoUqWYu4Mm34R+F75jPHl6MLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9aate0jJ6ilHDFksqkpTWgt7bxehTTvdvAtg95W2xuIblIzy40Qw+/Brk7PiJ5hH4z4d0Lxz9Ep7RbbxREybjydW6WGdTwV9RLDv9TMkxvr+P9ROZld+YhtE3Tpwi0PD5vJDy/5ynzWEr0qBkxxnrIdMvN8YEpQUQ6z+VbpZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4kVrvdjr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78f05341128so291927485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713775211; x=1714380011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyV/lN5dlUHG9Gy3r8/spvLCW++B9nPT5UV3g/jx5Xs=;
        b=4kVrvdjr2p9mjVLIDGrZWj387KqxTGUQaknDPGFWnpWaDNFJ3jOfDIohD1ym1dOGfl
         bG7Lw9t5kpHqeu60Fw6sL66PNSNOwoZzNm1r97z1GdMD3GG+VcQQWgkUvudk/VIC8DIx
         kmIFipbu4UwgjDT024Nm2/0r0FZpiKwCVXsVpunkPRTt2E0DsvQ0Ht08EGQF2riJKYAh
         4eBNxt2Q/pjDi+9SKOQg7EOaaLYiAeRC/5eUOHQswjkx2jxJARuJ9jc93PbH4vbjLqqw
         e9F13nl352QwbNi+80aZ19D5bZmjMbwSH7EcRBhI69Y6zLWqNl2VrtlqtUYEe4gZsGD+
         ocuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775211; x=1714380011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyV/lN5dlUHG9Gy3r8/spvLCW++B9nPT5UV3g/jx5Xs=;
        b=WDpFa+c0e3wEz0AoUkJ3DIzTXdsJk0GkfZGi/ZAptGY/b3cv/W9wl6S7ji6bEX2/Sl
         T7GphwKwkt1sAcyFNUjDXNSbkNiTJKmssjZmxFIdGAJzs0etBbDw2Vi2L+oO5UZjr6K3
         P/d0/uHFapbrKCFPCinFkwR3yzzYo+/uDDrZb+li+Kn1yXy4TjoM2ZweJoW/lNeAUHok
         +NJtcywh0diapgUck5QxrgGf/B7pSSUD/6HI3x104RooZWyfejWREl8M4qZzmZ9+9taJ
         FeddL9sb8JCphpWIXarys4PeX/BzBUG8f4xzN+karEXDhk3SRgtvt13U5jLdbh+MXOGz
         r+FA==
X-Forwarded-Encrypted: i=1; AJvYcCV9IGRks5ZEEnurGzq153aJezjvC99DOiqZW0QXoHTEtImbjVF+/Q+t/gGq0Flnn5QZfh44Zj7MWKDdRHd14eHwioUih9afeMKC6q48
X-Gm-Message-State: AOJu0Yx7tBz3tTkK1q627M0VqCuzgfx9bzQ19AWCMaKIGlwIidjcz0b+
	2bEdKY8Fz8l3SRFCK4LePGPGpT7daO8eB0EEKoejVgskM/zwPcGSU0CUGHE1YweyMSSOEDLZsS4
	Z36NCW+V9EsP9x7FF/ePelp0y72PCdBJNxpge
X-Google-Smtp-Source: AGHT+IENPCbRIQ0LUueLwxddxA/XFr+u6ftoONVq0st9eSr/uSCaEUXWKVFNQ/qNjCmILccHeR7B/y8ZUUcVGBHPLk0=
X-Received: by 2002:a05:6214:1772:b0:6a0:75fb:4587 with SMTP id
 et18-20020a056214177200b006a075fb4587mr5828957qvb.41.1713775211256; Mon, 22
 Apr 2024 01:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000826ac1061675b0e3@google.com>
In-Reply-To: <000000000000826ac1061675b0e3@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 22 Apr 2024 10:39:31 +0200
Message-ID: <CAG_fn=Xt=i_EqRbbceS-GSo5voAF-9GO0ZBMykX3LwyffaU9NA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in unwind_dump
To: syzbot <syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 6:36=E2=80=AFPM syzbot
<syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    0bbac3facb5d Linux 6.9-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13403bcb18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D87a805e655619=
c64
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D355c5bb8c1445c8=
71ee8
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/93eb2bab28b5/dis=
k-0bbac3fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/47a883d2dfaa/vmlinu=
x-0bbac3fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6bc56900ec1d/b=
zImage-0bbac3fa.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
>
> WARNING: kernel stack frame pointer at ffff88813fd05fe8 in kworker/1:1:42=
 has bad value ffff888103513fe8
> unwind stack type:0 next_sp:ffff888103513fd8 mask:0x4 graph_idx:0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in unwind_dump+0x5a0/0x730 arch/x86/kernel/unwin=
d_frame.c:60
>  unwind_dump+0x5a0/0x730 arch/x86/kernel/unwind_frame.c:60
>  unwind_next_frame+0x2d6/0x470
>  arch_stack_walk+0x1ec/0x2d0 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0xaa/0xe0 kernel/stacktrace.c:122
>  ref_tracker_free+0x103/0xec0 lib/ref_tracker.c:239
>  __netns_tracker_free include/net/net_namespace.h:348 [inline]
>  put_net_track include/net/net_namespace.h:363 [inline]
>  __sk_destruct+0x5aa/0xb70 net/core/sock.c:2204
>  sk_destruct net/core/sock.c:2223 [inline]
>  __sk_free+0x6de/0x760 net/core/sock.c:2234
>  sk_free+0x70/0xc0 net/core/sock.c:2245
>  deferred_put_nlk_sk+0x243/0x270 net/netlink/af_netlink.c:744
>  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
>  rcu_core+0xa59/0x1e70 kernel/rcu/tree.c:2471
>  rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2488
>  __do_softirq+0x1c0/0x7d7 kernel/softirq.c:554
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu kernel/softirq.c:633 [inline]
>  irq_exit_rcu+0x6a/0x130 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x83/0x90 arch/x86/kernel/apic/apic.c:1043
>
> Local variable tx created at:
>  ieee80211_get_buffered_bc+0x44/0x970 net/mac80211/tx.c:5886
>  mac80211_hwsim_beacon_tx+0x63b/0xb40 drivers/net/wireless/virtual/mac802=
11_hwsim.c:2303
>
> CPU: 1 PID: 42 Comm: kworker/1:1 Not tainted 6.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: usb_hub_wq hub_event
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

This seems to be a false positive caused by KMSAN instrumenting
READ_ONCE_NOCHECK(), although it is not supposed to.
I was going to define it as follows under __SANITIZE_MEMORY__:

  #define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused

, but I find the name __no_sanitize_or_inline a bit unfortunate
because it doesn't distinguish between "do not instrument this code"
and "do not report bugs in this code", which have different meanings
from KMSAN perspective.

