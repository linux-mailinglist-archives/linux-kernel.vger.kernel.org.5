Return-Path: <linux-kernel+bounces-32885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C358361BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE79B23794
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD4E3FB28;
	Mon, 22 Jan 2024 11:12:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E343FB1E;
	Mon, 22 Jan 2024 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921971; cv=none; b=I7ywl4t8xATgSaEEGKu09f/+EWrsFv7SDAqvf/GZzm3mYoevzcVij+cx3M37WQlGUwx0ORmdFOFW5E0NTvB8L8QQf0oiD51+PA2fJ8lOz7gpIYDaE6snjKfLQtuJHtqUMw/176bQ2iSBRY0DE+rX6zvhFuUdN1EbZS45sMh1ilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921971; c=relaxed/simple;
	bh=rOtL9M7EFa+Ovl0KWx795b/5zMGGND+rDCTV90EM8Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qpmNT123Ck3EsqmhHbWAcJ40njyl+omtuvsYsz6x2x+JNE4sPILrI2pHPJU5RXvWSOyMWShAvi4qqvgDZeu6fOcswQ0SKXWgWDy/zlo+Qvp51/fu4HQY7gNiqX9RhUa5po8qMs3czsM6Se9RuvQQH2h8o3zRysaAb6Nj5zFWxwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TJSGS3H4zzsWKc;
	Mon, 22 Jan 2024 19:11:44 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id B65991400E5;
	Mon, 22 Jan 2024 19:12:44 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 19:12:44 +0800
Message-ID: <7f963ac6-28ef-376c-e20d-bdfaedefba36@huawei.com>
Date: Mon, 22 Jan 2024 19:12:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH netdev] ipv6: Make sure tcp accept_queue's spinlocks are
 initialized
To: Chen-Yu Tsai <wenst@chromium.org>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240122102322.1131826-1-wenst@chromium.org>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240122102322.1131826-1-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Hi Chen-Yu Tsai:
	I have send the fixed patch.
https://lore.kernel.org/all/20240122102001.2851701-1-shaozhengchao@huawei.com/
Thank you

Zhengchao Shao

On 2024/1/22 18:23, Chen-Yu Tsai wrote:
> Commit 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks
> once") moved the TCP accept_queue spinlock initialization from a common
> core function to two places for two cases: the common accept callback,
> and the socket create callback.
> 
> For the second case, only AF_INET (IPv4) was considered. This results
> in a lockdep error when accepting an incoming IPv6 TCP connection.
> 
>      INFO: trying to register non-static key.
>      The code is fine but needs lockdep annotation, or maybe
>      you didn't initialize this object before use?
>      turning off the locking correctness validator.
>      Call trace:
>      ... <stack dump> ...
>      register_lock_class (kernel/locking/lockdep.c:977 kernel/locking/lockdep.c:1289)
>      __lock_acquire (kernel/locking/lockdep.c:5014)
>      lock_acquire (./arch/arm64/include/asm/percpu.h:40 kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5756 kernel/locking/lockdep.c:5719)
>      _raw_spin_lock (./include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
>      inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1303 net/ipv4/inet_connection_sock.c:1355)
>      tcp_check_req (net/ipv4/tcp_minisocks.c:653)
>      tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1837)
>      ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:438)
>      ip6_input_finish (./include/linux/rcupdate.h:779 net/ipv6/ip6_input.c:484)
>      ip6_input (./include/linux/netfilter.h:314 ./include/linux/netfilter.h:308 net/ipv6/ip6_input.c:492)
>      ip6_sublist_rcv_finish (net/ipv6/ip6_input.c:86 (discriminator 3))
>      ip6_sublist_rcv (net/ipv6/ip6_input.c:317)
>      ipv6_list_rcv (net/ipv6/ip6_input.c:326)
>      __netif_receive_skb_list_core (net/core/dev.c:5577 net/core/dev.c:5625)
>      netif_receive_skb_list_internal (net/core/dev.c:5679 net/core/dev.c:5768)
>      napi_complete_done (./include/linux/list.h:37 (discriminator 2) ./include/net/gro.h:440 (discriminator 2) ./include/net/gro.h:435 (discriminator 2) net/core/dev.c:6108 (discriminator 2))
>      ... <device callback> ...
> 
> Fix this by adding the appropriate code to AF_INET6 (IPv6) socket create
> callback, mirroring what was added for AF_INET.
> 
> Fixes: 198bc90e0e73 ("tcp: make sure init the accept_queue's spinlocks once")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   net/ipv6/af_inet6.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 13a1833a4df5..959bfd9f6344 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -199,6 +199,9 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
>   	if (INET_PROTOSW_REUSE & answer_flags)
>   		sk->sk_reuse = SK_CAN_REUSE;
>   
> +	if (INET_PROTOSW_ICSK & answer_flags)
> +		inet_init_csk_locks(sk);
> +
>   	inet = inet_sk(sk);
>   	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
>   

