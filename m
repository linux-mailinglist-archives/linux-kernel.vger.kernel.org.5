Return-Path: <linux-kernel+bounces-27745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03582F52F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE12285DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C71D52A;
	Tue, 16 Jan 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQdlRg9T"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240891CF9A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432661; cv=none; b=gzaTxvWXFX1QEjSmhHqQJVuBmCxhOE+dbrkiyea5vECBCz6uaGeFDzpl6U0J80tY3+15tyPDfeemRxgpjxP2LGteG+oVbE/jdlM5RgrQX/13uuy8P/UmdlKOJSlNXyR8Jh7nl6cBIeqk1by+7FZgaPia6sIG+BOs+n+bCntiKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432661; c=relaxed/simple;
	bh=GMxODEs3EzrTfDuvVmFvI8K654S1g7xNRS+tyHPjiB0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=t+IFFhp7K+ApkHnTitxeMNoq2SrKITWkliZQHHBhjLn652xjhB/IJugXN/lb3ErE5tT61anyNQ/+fBrDHt6dxj/oVg/Lv+dXOaeFv5lb4Pyy39uzcqSbbbJ8dkFKEC8YCteYK2maqGMHu2C18PPF23zTyGJM3HkRIpzuvO8A/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQdlRg9T; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso1821a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705432656; x=1706037456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL70gyyqnUHhpKRmmA7eUyp7dZ8Kkyy5Et01qDOjmAU=;
        b=mQdlRg9TYeczPHqo9B5uhe2ZpmMZUDLvK3ilJptXKqF02j73oPkDJBooF2F0ErwsL3
         3Gv7/v1PdUYEvVwXZu3Nd5CxMbAXCAQpgoAnizVT1GidsaQiTgH8lYcUucBmhOh6pcHZ
         jHy8+Q/Mc8Bmn+tW4SCZYg6khJpgL9TMQu9DirJxhTgw/eqJ8/7UGWBK2InFjEffFobi
         9c/BmxStKQ2FhwR21riIxImZKpiVIIAA97KvwtrdzZSenKFAahC0CPQSvbq1vysFrod7
         lQniCcS1aaQDNe0iL6AefcdSVWdUhknIQLTiE0SI0xuDorVEQIySvftJmOcV9IUTRYyH
         JHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705432656; x=1706037456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL70gyyqnUHhpKRmmA7eUyp7dZ8Kkyy5Et01qDOjmAU=;
        b=vwQAGTRycicem/rteD1SO9gPRhuJz1vTrlc074SdSGuaKJY7vxsBlnxlBn0v1Ggi/M
         9Tnt1hnE5Qixs4ZW04vuPR5LBOcma5B1NzXgaHwF/rVdyCDlOOnZs9ZqgHC+Q9w1e/tm
         LKZHQVdMEWz0B/y4jTnpzmk7CqxZmyHjXFmFksERglmtj6t8CHDAPjNQm7Jo9Iy6KpH3
         UM2yhNnsB5z/44YpjC+oOFFDuc9QYs76AFDypUVB0+0bq6A2tYD2JZnOwd/dm4Je1RLQ
         qfAVwjp81OYVZ+pjAY3R74CGRA0MDXLovLt38++3vSX8iqtmd7HXm/mB3jvhDSH+lyu0
         +ong==
X-Gm-Message-State: AOJu0YxjbD5X2D0tjRm2/WnsBs0p1RFdJj5kEWmwFdx0sr8anlpLPN6j
	tYLmBzMOhFjxcJn4kSWeQpEOWWbq56i7IjELRKGSEUtOa/TtG9rDlJQ5Tyt/VA==
X-Google-Smtp-Source: AGHT+IEFnFiOHKIzGviU7y2wUwscolt/j7AsnPEFNKyfsLcUmbB4oRZ0J8WILMZy2uqDvXkcoAWbLZMUwvINEgtWgzU=
X-Received: by 2002:aa7:d647:0:b0:559:a5c5:1e93 with SMTP id
 v7-20020aa7d647000000b00559a5c51e93mr57450edr.0.1705432656037; Tue, 16 Jan
 2024 11:17:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
In-Reply-To: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jan 2024 20:17:22 +0100
Message-ID: <CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
Subject: Re: Kernel panic in netif_rx_internal after v6 pings between netns
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:36=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hello,
>
> Our MPTCP CIs recently hit some kernel panics when validating the -net
> tree + 2 pending MPTCP patches. This is on top of e327b2372bc0 ("net:
> ravb: Fix dma_addr_t truncation in error case").
>
> It looks like these panics are not related to MPTCP. That's why I'm
> sharing that here:

Indeed, this seems an x86 issue to me (jump labels ?), are all stack
traces pointing to the same issue ?

Let's cc lkml just in case this rings a bell

>
> > # INFO: validating network environment with pings
> > [   45.505495] int3: 0000 [#1] PREEMPT SMP NOPTI
> > [   45.505547] CPU: 1 PID: 1070 Comm: ping Tainted: G                 N=
 6.7.0-g244ee3389ffe #1
> > [   45.505547] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.15.0-1 04/01/2014
> > [   45.505547] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_l=
abel.h:27)
> > [ 45.505547] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 5=
5 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <=
c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 17 9d 11
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
> >    7: 00
> >    8: 0f 1f 40 00             nopl   0x0(%rax)
> >    c: 0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >   11: 55                      push   %rbp
> >   12: 48 89 fd                mov    %rdi,%rbp
> >   15: 48 83 ec 20             sub    $0x20,%rsp
> >   19: 65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
> >   20: 00 00
> >   22: 48 89 44 24 18          mov    %rax,0x18(%rsp)
> >   27: 31 c0                   xor    %eax,%eax
> >   29:*        e9 c9 00 00 00          jmp    0xf7             <-- trapp=
ing instruction
> >   2e: 66 90                   xchg   %ax,%ax
> >   30: 66 90                   xchg   %ax,%ax
> >   32: 48 8d 54 24 10          lea    0x10(%rsp),%rdx
> >   37: 48 89 ef                mov    %rbp,%rdi
> >   3a: 65                      gs
> >   3b: 8b                      .byte 0x8b
> >   3c: 35                      .byte 0x35
> >   3d: 17                      (bad)
> >   3e: 9d                      popf
> >   3f: 11                      .byte 0x11
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: c9                      leave
> >    1: 00 00                   add    %al,(%rax)
> >    3: 00 66 90                add    %ah,-0x70(%rsi)
> >    6: 66 90                   xchg   %ax,%ax
> >    8: 48 8d 54 24 10          lea    0x10(%rsp),%rdx
> >    d: 48 89 ef                mov    %rbp,%rdi
> >   10: 65                      gs
> >   11: 8b                      .byte 0x8b
> >   12: 35                      .byte 0x35
> >   13: 17                      (bad)
> >   14: 9d                      popf
> >   15: 11                      .byte 0x11
> > [   45.505547] RSP: 0018:ffffb106c00f0af8 EFLAGS: 00000246
> > [   45.505547] RAX: 0000000000000000 RBX: ffff99918827b000 RCX: 0000000=
000000000
> > [   45.505547] RDX: 000000000000000a RSI: ffff99918827d000 RDI: ffff999=
1819e6400
> > [   45.505547] RBP: ffff9991819e6400 R08: 0000000000000000 R09: 0000000=
000000068
> > [   45.505547] R10: ffff999181c104c0 R11: 736f6d6570736575 R12: ffff999=
1819e6400
> > [   45.505547] R13: 0000000000000076 R14: 0000000000000000 R15: ffff999=
18827c000
> > [   45.505547] FS:  00007fa1d06ca1c0(0000) GS:ffff9991fdc80000(0000) kn=
lGS:0000000000000000
> > [   45.505547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   45.505547] CR2: 0000559b91aac240 CR3: 0000000004986000 CR4: 0000000=
0000006f0
> > [   45.505547] Call Trace:
> > [   45.505547]  <IRQ>
> > [   45.505547] ? die (arch/x86/kernel/dumpstack.c:421)
> > [   45.505547] ? exc_int3 (arch/x86/kernel/traps.c:762)
> > [   45.505547] ? asm_exc_int3 (arch/x86/include/asm/idtentry.h:569)
> > [   45.505547] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:2=
7)
> > [   45.505547] ? netif_rx_internal (arch/x86/include/asm/jump_label.h:2=
7)
> > [   45.505547] __netif_rx (net/core/dev.c:5084)
> > [   45.505547] veth_xmit (drivers/net/veth.c:321)
> > [   45.505547] dev_hard_start_xmit (include/linux/netdevice.h:4989)
> > [   45.505547] __dev_queue_xmit (include/linux/netdevice.h:3367)
> > [   45.505547] ? selinux_ip_postroute_compat (security/selinux/hooks.c:=
5783)
> > [   45.505547] ? eth_header (net/ethernet/eth.c:85)
> > [   45.505547] ip6_finish_output2 (include/net/neighbour.h:542)
> > [   45.505547] ? ip6_output (include/linux/netfilter.h:301)
> > [   45.505547] ? ip6_mtu (net/ipv6/route.c:3208)
> > [   45.505547] ip6_send_skb (net/ipv6/ip6_output.c:1953)
> > [   45.505547] icmpv6_echo_reply (net/ipv6/icmp.c:812)
> > [   45.505547] ? icmpv6_rcv (net/ipv6/icmp.c:939)
> > [   45.505547] icmpv6_rcv (net/ipv6/icmp.c:939)
> > [   45.505547] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:440)
> > [   45.505547] ip6_input_finish (include/linux/rcupdate.h:779)
> > [   45.505547] __netif_receive_skb_one_core (net/core/dev.c:5537)
> > [   45.505547] process_backlog (include/linux/rcupdate.h:779)
> > [   45.505547] __napi_poll (net/core/dev.c:6576)
> > [   45.505547] net_rx_action (net/core/dev.c:6647)
> > [   45.505547] __do_softirq (arch/x86/include/asm/jump_label.h:27)
> > [   45.505547] do_softirq (kernel/softirq.c:454)
> > [   45.505547]  </IRQ>
> > [   45.505547]  <TASK>
> > [   45.505547] __local_bh_enable_ip (kernel/softirq.c:381)
> > [   45.505547] __dev_queue_xmit (net/core/dev.c:4379)
> > [   45.505547] ip6_finish_output2 (include/linux/netdevice.h:3171)
> > [   45.505547] ? ip6_output (include/linux/netfilter.h:301)
> > [   45.505547] ? ip6_mtu (net/ipv6/route.c:3208)
> > [   45.505547] ip6_send_skb (net/ipv6/ip6_output.c:1953)
> > [   45.505547] rawv6_sendmsg (net/ipv6/raw.c:584)
> > [   45.505547] ? netfs_clear_subrequests (include/linux/list.h:373)
> > [   45.505547] ? netfs_alloc_request (fs/netfs/objects.c:42)
> > [   45.505547] ? folio_add_file_rmap_ptes (arch/x86/include/asm/bitops.=
h:206)
> > [   45.505547] ? set_pte_range (mm/memory.c:4529)
> > [   45.505547] ? next_uptodate_folio (include/linux/xarray.h:1699)
> > [   45.505547] ? __sock_sendmsg (net/socket.c:733)
> > [   45.505547] __sock_sendmsg (net/socket.c:733)
> > [   45.505547] ? move_addr_to_kernel.part.0 (net/socket.c:253)
> > [   45.505547] __sys_sendto (net/socket.c:2191)
> > [   45.505547] ? __hrtimer_run_queues (include/linux/seqlock.h:566)
> > [   45.505547] ? __do_softirq (arch/x86/include/asm/jump_label.h:27)
> > [   45.505547] __x64_sys_sendto (net/socket.c:2203)
> > [   45.505547] do_syscall_64 (arch/x86/entry/common.c:52)
> > [   45.505547] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.=
S:129)
> > [   45.505547] RIP: 0033:0x7fa1d099ca0a
> > [ 45.505547] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0=
f 1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: d8 64 89 02             fsubs  0x2(%rcx,%rcx,4)
> >    4: 48 c7 c0 ff ff ff ff    mov    $0xffffffffffffffff,%rax
> >    b: eb b8                   jmp    0xffffffffffffffc5
> >    d: 0f 1f 00                nopl   (%rax)
> >   10: f3 0f 1e fa             endbr64
> >   14: 41 89 ca                mov    %ecx,%r10d
> >   17: 64 8b 04 25 18 00 00    mov    %fs:0x18,%eax
> >   1e: 00
> >   1f: 85 c0                   test   %eax,%eax
> >   21: 75 15                   jne    0x38
> >   23: b8 2c 00 00 00          mov    $0x2c,%eax
> >   28: 0f 05                   syscall
> >   2a:*        48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax  =
       <-- trapping instruction
> >   30: 77 7e                   ja     0xb0
> >   32: c3                      ret
> >   33: 0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >   38: 41 54                   push   %r12
> >   3a: 48 83 ec 30             sub    $0x30,%rsp
> >   3e: 44                      rex.R
> >   3f: 89                      .byte 0x89
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
> >    6: 77 7e                   ja     0x86
> >    8: c3                      ret
> >    9: 0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >    e: 41 54                   push   %r12
> >   10: 48 83 ec 30             sub    $0x30,%rsp
> >   14: 44                      rex.R
> >   15: 89                      .byte 0x89
> > [   45.505547] RSP: 002b:00007ffe47710958 EFLAGS: 00000246 ORIG_RAX: 00=
0000000000002c
> > [   45.505547] RAX: ffffffffffffffda RBX: 00007ffe47712090 RCX: 00007fa=
1d099ca0a
> > [   45.505547] RDX: 0000000000000040 RSI: 0000559b91bbd300 RDI: 0000000=
000000003
> > [   45.505547] RBP: 0000559b91bbd300 R08: 00007ffe477142a4 R09: 0000000=
00000001c
> > [   45.505547] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff=
e47711c20
> > [   45.505547] R13: 0000000000000040 R14: 0000559b91bbf4f4 R15: 00007ff=
e47712090
> > [   45.505547]  </TASK>
> > [   45.505547] Modules linked in: mptcp_diag inet_diag mptcp_token_test=
 mptcp_crypto_test kunit
> > [   45.505547] ---[ end trace 0000000000000000 ]---
> > [   45.505547] RIP: 0010:netif_rx_internal (arch/x86/include/asm/jump_l=
abel.h:27)
> > [ 45.505547] Code: 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 5=
5 48 89 fd 48 83 ec 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 e9 <=
c9> 00 00 00 66 90 66 90 48 8d 54 24 10 48 89 ef 65 8b 35 17 9d 11
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0f 1f 84 00 00 00 00    nopl   0x0(%rax,%rax,1)
> >    7: 00
> >    8: 0f 1f 40 00             nopl   0x0(%rax)
> >    c: 0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> >   11: 55                      push   %rbp
> >   12: 48 89 fd                mov    %rdi,%rbp
> >   15: 48 83 ec 20             sub    $0x20,%rsp
> >   19: 65 48 8b 04 25 28 00    mov    %gs:0x28,%rax
> >   20: 00 00
> >   22: 48 89 44 24 18          mov    %rax,0x18(%rsp)
> >   27: 31 c0                   xor    %eax,%eax
> >   29:*        e9 c9 00 00 00          jmp    0xf7             <-- trapp=
ing instruction
> >   2e: 66 90                   xchg   %ax,%ax
> >   30: 66 90                   xchg   %ax,%ax
> >   32: 48 8d 54 24 10          lea    0x10(%rsp),%rdx
> >   37: 48 89 ef                mov    %rbp,%rdi
> >   3a: 65                      gs
> >   3b: 8b                      .byte 0x8b
> >   3c: 35                      .byte 0x35
> >   3d: 17                      (bad)
> >   3e: 9d                      popf
> >   3f: 11                      .byte 0x11
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: c9                      leave
> >    1: 00 00                   add    %al,(%rax)
> >    3: 00 66 90                add    %ah,-0x70(%rsi)
> >    6: 66 90                   xchg   %ax,%ax
> >    8: 48 8d 54 24 10          lea    0x10(%rsp),%rdx
> >    d: 48 89 ef                mov    %rbp,%rdi
> >   10: 65                      gs
> >   11: 8b                      .byte 0x8b
> >   12: 35                      .byte 0x35
> >   13: 17                      (bad)
> >   14: 9d                      popf
> >   15: 11                      .byte 0x11
> > [   45.505547] RSP: 0018:ffffb106c00f0af8 EFLAGS: 00000246
> > [   45.505547] RAX: 0000000000000000 RBX: ffff99918827b000 RCX: 0000000=
000000000
> > [   45.505547] RDX: 000000000000000a RSI: ffff99918827d000 RDI: ffff999=
1819e6400
> > [   45.505547] RBP: ffff9991819e6400 R08: 0000000000000000 R09: 0000000=
000000068
> > [   45.505547] R10: ffff999181c104c0 R11: 736f6d6570736575 R12: ffff999=
1819e6400
> > [   45.505547] R13: 0000000000000076 R14: 0000000000000000 R15: ffff999=
18827c000
> > [   45.505547] FS:  00007fa1d06ca1c0(0000) GS:ffff9991fdc80000(0000) kn=
lGS:0000000000000000
> > [   45.505547] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   45.505547] CR2: 0000559b91aac240 CR3: 0000000004986000 CR4: 0000000=
0000006f0
> > [   45.505547] Kernel panic - not syncing: Fatal exception in interrupt
> > [   45.505547] Kernel Offset: 0x37600000 from 0xffffffff81000000 (reloc=
ation range: 0xffffffff80000000-0xffffffffbfffffff)
>
>
> When hitting the panic, the MPTCP selftest was doing some pings -- v6
> according to the call trace -- between different netns: client, server,
> 2 routers in between with some TC config. See [1] for more details. In
> other words, that's before creating MPTCP connections.
>
> These panics are not easy to reproduce. In fact, we only saw the issue 2
> (maybe 3) times, only when running on Github Actions (without KVM). I
> didn't manage to reproduce it locally.
>
> It is only recently that we have started to use Github Actions to do
> some validations, so I cannot confirm that it is a very recent issue. I
> think the CI hit the same issue a few days ago, on top of bec161add35b
> ("amt: do not use overwrapped cb area"), but there was another issue and
> the debug info have not been stored.
>
> For reference, I originally added info in a Github issue [2]. If the CI
> hits the same bug again, I will add stacktrace there. Please tell me if
> I should cc someone.
>
> If you have any idea what is causing such panic, please tell me. I can
> also add test patches in the MPTCP tree if needed.
>
>
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/tools=
/testing/selftests/net/mptcp/mptcp_connect.sh?id=3De327b2372bc0#n171
>
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/issues/471#issuecomment-1=
894061756
>
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.

