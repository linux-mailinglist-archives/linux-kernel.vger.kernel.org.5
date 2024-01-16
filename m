Return-Path: <linux-kernel+bounces-28288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8DE82FC94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B474229101E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0972DF92;
	Tue, 16 Jan 2024 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COjwSVVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6F1BDFF;
	Tue, 16 Jan 2024 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439745; cv=none; b=ABH9VFCDoBF9gX6+WqCCxCmP6MZnoj9q1luG0AdemyRVdJkHNmRwTOlfvTlGwwvFxBnvY7LV8AkVh75VIZnVaZSdR043wxOFny2qy+7mkqnpnFL4mAW1dAqRMjU2ySfF7F2JLk8GHO6+AZmQu8AybXVOX8FFV9nA2Tu5Xd+ud2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439745; c=relaxed/simple;
	bh=EBJw08qmV6yOH2K/wrXLMcSmDhOhzzw8QxkVEW2bFNQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Message-ID:In-Reply-To:
	 References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Correlation-ID; b=aoXP75GnbXZnevVsIZj48wXcgjY9il4FkEf4Z1DOho6B3zeYDTJvnUh7L1GCe2diM7Lm71h2ZrsfnMLQvNz7DwPhqMzERQ67ZbZZgv3el7Vk47TokpLbE1q8YrtcC/lNPbW1fch8vy2fHZG/fH/po0Ei9QMswugGJBwheQCOWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COjwSVVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EDBC433C7;
	Tue, 16 Jan 2024 21:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705439745;
	bh=EBJw08qmV6yOH2K/wrXLMcSmDhOhzzw8QxkVEW2bFNQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=COjwSVViGpkvm6N6oYf2mjNVLX662lpKYtx1xK+Y0RGs2BQOWkDJCztb/tXujNuFI
	 8SuAarI4T1+kltR/s78rDXcDDyJ4JVlMJVQgfRIS0keMqevrFAAaONtF+FkODv8sBq
	 Jm1Nis93gV8+USysnRhMcc2mNdcBfptqgz3t+kerPCQPkDu2matPxtklLxHyPyCEXt
	 jAV3yJVmWROOwRwfrtjaOXNdR7eHqAsfGaU+y0w4/KoQiysoD0kcfzkclN5b6wHGU6
	 crIYo8UAdK1gsi8KHVIhRCmT+Wd7nzBuDPqX5RtX6hgsE6TElJp4w8uhCnTaw6LFRX
	 08PEwvT8ekAMA==
Date: Tue, 16 Jan 2024 22:15:40 +0100 (GMT+01:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <65c4f6a2-207f-45e0-9ec3-bad81a05b196@kernel.org>
In-Reply-To: <CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
References: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org> <CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
Subject: Re: Kernel panic in netif_rx_internal after v6 pings between netns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <65c4f6a2-207f-45e0-9ec3-bad81a05b196@kernel.org>

Hi Eric,

Thank you for your quick reply!

16 Jan 2024 20:17:40 Eric Dumazet <edumazet@google.com>:
> On Tue, Jan 16, 2024 at 7:36=E2=80=AFPM Matthieu Baerts <matttbe@kernel.o=
rg> wrote:
>> Our MPTCP CIs recently hit some kernel panics when validating the -net
>> tree + 2 pending MPTCP patches. This is on top of e327b2372bc0 ("net:
>> ravb: Fix dma_addr_t truncation in error case").
>>
>> It looks like these panics are not related to MPTCP. That's why I'm
>> sharing that here:
>
> Indeed, this seems an x86 issue to me (jump labels ?)

Thank you, good point!

(I don't know why I always think there is no x86 issue :) )

> are all stack
> traces pointing to the same issue ?

I think so.

We had twice the same stack trace, and another one, sadly not
decoded. But both when doing the same thing (ping6):


# INFO: validating network environment with pings
[ 2211.138427] int3: 0000 [#1] PREEMPT SMP NOPTI
[ 2211.138427] CPU: 0 PID: 21830 Comm: ping Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 N 6.7.0-gc6465fa4649b #1
[ 2211.138427] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.15.0-1 04/01/2014
[ 2211.138427] RIP: 0010:__netif_receive_skb_core.constprop.0+0x39/0x10b0
[ 2211.138427] Code: 54 55 53 48 83 ec 78 48 8b 2f 48 89 7c 24 10 48 89 54 =
24 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 70 31 c0 48 89 6c 24 30 e9 <13=
> 08 00 00 0f 1f 44 00 00 48 8b 85 c8 00 00 00 48 2b 85 c0 00 00
[ 2211.138427] RSP: 0018:ffffb09700003e00 EFLAGS: 00000246
[ 2211.138427] RAX: 0000000000000000 RBX: ffff9eec3dc2ef10 RCX: ffff9eebc62=
05700
[ 2211.138427] RDX: ffffb09700003eb8 RSI: 0000000000000000 RDI: ffffb097000=
03eb0
[ 2211.138427] RBP: ffff9eebc6205700 R08: 0000000000000000 R09: 00000000000=
00048
[ 2211.138427] R10: 00000000000002ff R11: 020000ff01000000 R12: ffff9eebc82=
b5000
[ 2211.138427] R13: ffff9eec3dc2ee10 R14: 0000000000000000 R15: 00000000000=
00002
[ 2211.138427] FS:=C2=A0 00007fa1f295b1c0(0000) GS:ffff9eec3dc00000(0000) k=
nlGS:0000000000000000
[ 2211.138427] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2211.138427] CR2: 00005595dc9df240 CR3: 0000000004758000 CR4: 00000000000=
006f0
[ 2211.138427] Call Trace:
[ 2211.138427]=C2=A0 <IRQ>
[ 2211.138427]=C2=A0 ? die+0x37/0x90
[ 2211.138427]=C2=A0 ? exc_int3+0x10b/0x110
[ 2211.138427]=C2=A0 ? asm_exc_int3+0x39/0x40
[ 2211.138427]=C2=A0 ? __netif_receive_skb_core.constprop.0+0x39/0x10b0
[ 2211.138427]=C2=A0 ? __netif_receive_skb_core.constprop.0+0x39/0x10b0
[ 2211.138427]=C2=A0 ? ip6_finish_output2+0x209/0x670
[ 2211.138427]=C2=A0 ? ip6_output+0x12d/0x150
[ 2211.138427]=C2=A0 ? unix_stream_read_generic+0x7c4/0xb70
[ 2211.138427]=C2=A0 ? ip6_mtu+0x46/0x50
[ 2211.138427]=C2=A0 __netif_receive_skb_one_core+0x3d/0x80
[ 2211.138427]=C2=A0 process_backlog+0x9d/0x140
[ 2211.138427]=C2=A0 __napi_poll+0x26/0x1b0
[ 2211.138427]=C2=A0 net_rx_action+0x28f/0x300
[ 2211.138427]=C2=A0 __do_softirq+0xc0/0x28b
[ 2211.138427]=C2=A0 do_softirq+0x43/0x60
[ 2211.138427]=C2=A0 </IRQ>
[ 2211.138427]=C2=A0 <TASK>
[ 2211.138427]=C2=A0 __local_bh_enable_ip+0x5c/0x70
[ 2211.138427]=C2=A0 __dev_queue_xmit+0x28e/0xd70
[ 2211.138427]=C2=A0 ip6_finish_output2+0x2d8/0x670
[ 2211.138427]=C2=A0 ? ip6_output+0x12d/0x150
[ 2211.138427]=C2=A0 ? ip6_mtu+0x46/0x50
[ 2211.138427]=C2=A0 ip6_send_skb+0x22/0x70
[ 2211.138427]=C2=A0 rawv6_sendmsg+0xda5/0x10c0
[ 2211.138427]=C2=A0 ? netfs_clear_subrequests+0x63/0x80
[ 2211.138427]=C2=A0 ? netfs_alloc_request+0xec/0x130
[ 2211.138427]=C2=A0 ? folio_add_file_rmap_ptes+0x88/0xb0
[ 2211.138427]=C2=A0 ? set_pte_range+0xe8/0x310
[ 2211.138427]=C2=A0 ? next_uptodate_folio+0x85/0x260
[ 2211.138427]=C2=A0 ? __sock_sendmsg+0x38/0x70
[ 2211.138427]=C2=A0 __sock_sendmsg+0x38/0x70
[ 2211.138427]=C2=A0 ? move_addr_to_kernel.part.0+0x1b/0x60
[ 2211.138427]=C2=A0 __sys_sendto+0xfc/0x160
[ 2211.138427]=C2=A0 ? ktime_get_real_ts64+0x4d/0xf0
[ 2211.138427]=C2=A0 __x64_sys_sendto+0x24/0x30
[ 2211.138427]=C2=A0 do_syscall_64+0xad/0x1a0
[ 2211.138427]=C2=A0 entry_SYSCALL_64_after_hwframe+0x63/0x6b
[ 2211.138427] RIP: 0033:0x7fa1f2c2da0a
[ 2211.138427] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f =
1e fa 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 7e c3 0f 1f 44 00 00 41 54 48 83 ec 30 44 89
[ 2211.138427] RSP: 002b:00007fff0d984668 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[ 2211.138427] RAX: ffffffffffffffda RBX: 00007fff0d985da0 RCX: 00007fa1f2c=
2da0a
[ 2211.138427] RDX: 0000000000000040 RSI: 00005595dcf1d300 RDI: 00000000000=
00003
[ 2211.138427] RBP: 00005595dcf1d300 R08: 00007fff0d987fb4 R09: 00000000000=
0001c
[ 2211.138427] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff0d9=
85930
[ 2211.138427] R13: 0000000000000040 R14: 00005595dcf1f4f4 R15: 00007fff0d9=
85da0
[ 2211.138427]=C2=A0 </TASK>
[ 2211.138427] Modules linked in: tcp_diag act_csum act_pedit cls_fw sch_in=
gress xt_mark xt_statistic xt_length xt_bpf ipt_REJECT nft_tproxy nf_tproxy=
_ipv6 nf_tproxy_ipv4 nft_socket nf_socket_ipv4 nf_socket_ipv6 nf_tables sch=
_netem mptcp_diag inet_diag mptcp_token_test mptcp_crypto_test kunit
[ 2211.138427] ---[ end trace 0000000000000000 ]---
[ 2211.138427] RIP: 0010:__netif_receive_skb_core.constprop.0+0x39/0x10b0
[ 2211.138427] Code: 54 55 53 48 83 ec 78 48 8b 2f 48 89 7c 24 10 48 89 54 =
24 20 65 48 8b 04 25 28 00 00 00 48 89 44 24 70 31 c0 48 89 6c 24 30 e9 <13=
> 08 00 00 0f 1f 44 00 00 48 8b 85 c8 00 00 00 48 2b 85 c0 00 00
[ 2211.138427] RSP: 0018:ffffb09700003e00 EFLAGS: 00000246
[ 2211.138427] RAX: 0000000000000000 RBX: ffff9eec3dc2ef10 RCX: ffff9eebc62=
05700
[ 2211.138427] RDX: ffffb09700003eb8 RSI: 0000000000000000 RDI: ffffb097000=
03eb0
[ 2211.138427] RBP: ffff9eebc6205700 R08: 0000000000000000 R09: 00000000000=
00048
[ 2211.138427] R10: 00000000000002ff R11: 020000ff01000000 R12: ffff9eebc82=
b5000
[ 2211.138427] R13: ffff9eec3dc2ee10 R14: 0000000000000000 R15: 00000000000=
00002
[ 2211.138427] FS:=C2=A0 00007fa1f295b1c0(0000) GS:ffff9eec3dc00000(0000) k=
nlGS:0000000000000000
[ 2211.138427] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2211.138427] CR2: 00005595dc9df240 CR3: 0000000004758000 CR4: 00000000000=
006f0
[ 2211.138427] Kernel panic - not syncing: Fatal exception in interrupt
[ 2211.138427] Kernel Offset: 0x1c400000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)


> Let's cc lkml just in case this rings a bell

Thank you! Hopefully there are still people reading lkml :)

Cheers,
Matt
--
Sponsored by the NGI0 Core fund.

