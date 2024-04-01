Return-Path: <linux-kernel+bounces-126622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF019893A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD8C1C20DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC8E210F8;
	Mon,  1 Apr 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC0rG/Qp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC57200AE;
	Mon,  1 Apr 2024 11:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711969218; cv=none; b=t0+F+VuCARAlCf94LponACUZVvBfWl/DJm0SCbzBIbmnEfUNsBJWFHaJSQBh96E+Dt30xqLQrKPe3Iqw16PNEZGHP7kHsiC68DtxP9ZaNfZkSx6mQ0wncMzZD47IONCgozxs9FYQJP6I/R1VO9YdscBgEZlSL1UQGJTM6bRhuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711969218; c=relaxed/simple;
	bh=w5luFLfUfnHBVCxJtXFMS1UvIwxlGGuv7RTuG/oMpkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IExIYJijtgsRPMtTiO4gNMRE6yviMMsOh7fSUDJuCztrDSz4LTu1JTNH47InlC+iAQcihT/8SzUECE0K31TVa08/IiUwz1nhhkhP4THUSGkhw/IhjYxrEXo54EsFwRfM1Zxn/0lL6FIfNS0lyHa9DpvYkd3lyCwaqsAPd5Am8ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC0rG/Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B140C433F1;
	Mon,  1 Apr 2024 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711969217;
	bh=w5luFLfUfnHBVCxJtXFMS1UvIwxlGGuv7RTuG/oMpkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kC0rG/QpgKYIets+b8eOPVKqwKUJQKQyRK66SQxjqRYhrKj5WK0mrYPb9QZnx+t7n
	 iRFuIYVmKlg+Q4sGGhfJcQ91Cvj4k0P/m1QrVVB7TQRgQPe5fYvSPYWBb5jasIDlG1
	 Wphin9/HwqAXIuWj7PMd33YQ++xBE3rqrtVcyxkytyCdq1EqZEG7TeThTMOQu8e+cl
	 2moq4gdJeigRj1zY1fB3vfnhc5SUCVZvydby/2S1j5DWe6W5ID2vdADcVdnDwrzJ1O
	 hHL9I9elYKWO3xo+vzyLBwgPDMKaOt+hD0Z5qkWYR4NEnzDzI1a3ip3HCRlNxkEa79
	 I4HGqXW/dfdow==
Message-ID: <f45ad3e1-4433-422e-be28-17deaba4ade1@kernel.org>
Date: Mon, 1 Apr 2024 13:00:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: fix null ptr deref in dev_map_enqueue
To: Edward Adam Davis <eadavis@qq.com>,
 syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
References: <00000000000069ee1a06149ff00c@google.com>
 <tencent_EF4FAF8DF125F00D8D9237DDCC5DE9990307@qq.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <tencent_EF4FAF8DF125F00D8D9237DDCC5DE9990307@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/03/2024 11.08, Edward Adam Davis wrote:
> [Syzbot reported]
> general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 PID: 5179 Comm: syz-executor120 Not tainted 6.8.0-syzkaller-05271-gf99c5f563c17 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
> Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 00 00 00 00 00 fc ff df e8 e6 45 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 d0 8b 3b 00 4c 8b 7d 00 48 83 c5
> RSP: 0018:ffffc90003b0f688 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888025258000
> RDX: 0000000000000000 RSI: ffff888024035070 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff55e
> R10: 0000000000000004 R11: ffff888025258000 R12: ffff8880157d8000
> R13: ffff888024035070 R14: dffffc0000000000 R15: ffff8880b943c088
> FS:  00007fd0098e46c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200009c0 CR3: 0000000025314000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
>   xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
>   xdp_test_run_batch net/bpf/test_run.c:336 [inline]
>   bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
>   bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
>   bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
>   __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fd00992a0d9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd0098e4238 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fd0099b43e8 RCX: 00007fd00992a0d9
> RDX: 0000000000000050 RSI: 0000000020000240 RDI: 000000000000000a
> RBP: 00007fd0099b43e0 R08: 00007fd0098e46c0 R09: 00007fd0098e46c0
> R10: 00007fd0098e46c0 R11: 0000000000000246 R12: 00007fd009981060
> R13: 0000000000000016 R14: 00007fffcb70c160 R15: 00007fffcb70c248
>   </TASK>
> [Fix]
> On the execution path of bpf_prog_test_run(), due to ri->map being NULL,
> ri->tgtvalue was not set correctly.
> 
> Reported-and-tested-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   kernel/bpf/devmap.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 4e2cdbb5629f..ef20de14154a 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -86,6 +86,7 @@ struct bpf_dtab {
>   static DEFINE_PER_CPU(struct list_head, dev_flush_list);
>   static DEFINE_SPINLOCK(dev_map_lock);
>   static LIST_HEAD(dev_map_list);
> +static bool is_valid_dst(struct bpf_dtab_netdev *obj, struct xdp_frame *xdpf);
>   
>   static struct hlist_head *dev_map_create_hash(unsigned int entries,
>   					      int numa_node)
> @@ -536,7 +537,10 @@ int dev_xdp_enqueue(struct net_device *dev, struct xdp_frame *xdpf,
>   int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
>   		    struct net_device *dev_rx)
>   {
> -	struct net_device *dev = dst->dev;
> +	struct net_device *dev;
> +	if (!is_valid_dst(dst, xdpf))

This is overkill, because __xdp_enqueue() already contains most of the
checks in is_valid_dst().

Why not:

  if (!dst)
	return -EINVAL;


> +		return -EINVAL;
> +	dev = dst->dev;
>   
>   	return __xdp_enqueue(dev, xdpf, dev_rx, dst->xdp_prog);
>   }


Is this fix pampering over another issue?

To repeat myself:
I think something is wrong in xdp_test_run_batch().
The `ri->tgt_value` is being set in __bpf_xdp_redirect_map(), but I
cannot see __bpf_xdp_redirect_map() being used in xdp_test_run_batch().

Is this a case of XDP program returning XDP_REDIRECT without having
called the BPF helper for redirect?

--Jesper

