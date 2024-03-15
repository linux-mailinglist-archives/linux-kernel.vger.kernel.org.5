Return-Path: <linux-kernel+bounces-104983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED787D73F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159D1284D92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884D5A4D5;
	Fri, 15 Mar 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CYIBjIMZ"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429FB5A0E7;
	Fri, 15 Mar 2024 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710544323; cv=none; b=i4XKdpyqSI4wXG+dc+ir4Jl4/f/la5ieFVeo92sLJYQnAnJ1vDg7Oy15IKy2kQcDpve3tdoH51jSvaUagc/mUoM+X/+fjMtA0Ljr2wrWiwRi6tOqumQ5fiWjjQNxYCav4sVfRJ1CBVNvC5SKfyFU9RshUMEeYz0793Xb6YK1RjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710544323; c=relaxed/simple;
	bh=VQpxIo0PRL4MlhjDwV9PLwADMylqIo1qt3PRoZ+zYW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmWC0T5h2wLYiN3Ot/Y6B69YooO0zaxDrTj75oDwcI5lDFItqqO1cvY2tfwvCQDWUSwMxXsSoqy1HLXa3Wiwu0+PrvzOgiutdZ+76Jhb6N85cPWEzVsHAYl2r8mhAjlYdex+cvJgWHVO4cxUvavaK97Vv4EUoM88G9+kon86mBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CYIBjIMZ; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710544321; x=1742080321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4dnSYlWi+5f7Z1pVNEI53jPibTTZHENrkrv7AgPCIg=;
  b=CYIBjIMZedxnpTM42iSQy1wPnrbdvQURaToagXnoucn4gxMaHkAOkH2P
   FTxFYWzfP/OAfLKvzXHrOwmytlsrmgQSefqr8Q/C2uq3/ySkN+a6HvKPG
   2vgAUznirbZYmuXbGVzjg8+J9N0e55atpFV4hUYPr5qhweTvKApJTCqyn
   0=;
X-IronPort-AV: E=Sophos;i="6.07,129,1708387200"; 
   d="scan'208";a="620033953"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 23:11:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:50026]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.84:2525] with esmtp (Farcaster)
 id c630005c-4ede-431c-93cb-c18bfbd6267b; Fri, 15 Mar 2024 23:11:56 +0000 (UTC)
X-Farcaster-Flow-ID: c630005c-4ede-431c-93cb-c18bfbd6267b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 23:11:56 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 15 Mar 2024 23:11:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <cgzones@googlemail.com>
CC: <alex.aring@gmail.com>, <alexander@mihalicyn.com>, <bpf@vger.kernel.org>,
	<daan.j.demeyer@gmail.com>, <davem@davemloft.net>, <dhowells@redhat.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <john.fastabend@gmail.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <leitao@debian.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<mkl@pengutronix.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<stefan@datenfreihafen.org>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH 08/10] net: use new capable_any functionality
Date: Fri, 15 Mar 2024 16:11:42 -0700
Message-ID: <20240315231142.56998-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240315113828.258005-8-cgzones@googlemail.com>
References: <20240315113828.258005-8-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Christian Göttsche <cgzones@googlemail.com>
Date: Fri, 15 Mar 2024 12:37:29 +0100
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Add sock_ns_capable_any() wrapper similar to existing sock_ns_capable()
> one.
> 
> Reorder CAP_SYS_ADMIN last.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> (ieee802154 portion)
> ---
> v4:
>   - introduce sockopt_ns_capable_any()
> v3:
>   - rename to capable_any()
>   - make use of ns_capable_any
> ---
>  include/net/sock.h       |  1 +
>  net/caif/caif_socket.c   |  2 +-
>  net/core/sock.c          | 15 +++++++++------
>  net/ieee802154/socket.c  |  6 ++----
>  net/ipv4/ip_sockglue.c   |  5 +++--
>  net/ipv6/ipv6_sockglue.c |  3 +--
>  net/unix/af_unix.c       |  2 +-
>  7 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index b5e00702acc1..2e64a80c8fca 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1736,6 +1736,7 @@ static inline void unlock_sock_fast(struct sock *sk, bool slow)
>  void sockopt_lock_sock(struct sock *sk);
>  void sockopt_release_sock(struct sock *sk);
>  bool sockopt_ns_capable(struct user_namespace *ns, int cap);
> +bool sockopt_ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
>  bool sockopt_capable(int cap);
>  
>  /* Used by processes to "lock" a socket state, so that
> diff --git a/net/caif/caif_socket.c b/net/caif/caif_socket.c
> index 039dfbd367c9..2d811037e378 100644
> --- a/net/caif/caif_socket.c
> +++ b/net/caif/caif_socket.c
> @@ -1026,7 +1026,7 @@ static int caif_create(struct net *net, struct socket *sock, int protocol,
>  		.usersize = sizeof_field(struct caifsock, conn_req.param)
>  	};
>  
> -	if (!capable(CAP_SYS_ADMIN) && !capable(CAP_NET_ADMIN))
> +	if (!capable_any(CAP_NET_ADMIN, CAP_SYS_ADMIN))
>  		return -EPERM;
>  	/*
>  	 * The sock->type specifies the socket type to use.
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 43bf3818c19e..fa9edcc3e23d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1077,6 +1077,12 @@ bool sockopt_ns_capable(struct user_namespace *ns, int cap)
>  }
>  EXPORT_SYMBOL(sockopt_ns_capable);
>  
> +bool sockopt_ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> +{
> +	return has_current_bpf_ctx() || ns_capable_any(ns, cap1, cap2);
> +}
> +EXPORT_SYMBOL(sockopt_ns_capable_any);
> +
>  bool sockopt_capable(int cap)
>  {
>  	return has_current_bpf_ctx() || capable(cap);
> @@ -1118,8 +1124,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  	switch (optname) {
>  	case SO_PRIORITY:
>  		if ((val >= 0 && val <= 6) ||
> -		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
> -		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
> +		    sockopt_ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
>  			sock_set_priority(sk, val);
>  			return 0;
>  		}
> @@ -1422,8 +1427,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		break;
>  
>  	case SO_MARK:
> -		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
> -		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
> +		if (!sockopt_ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
>  			ret = -EPERM;
>  			break;
>  		}
> @@ -2813,8 +2817,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  
>  	switch (cmsg->cmsg_type) {
>  	case SO_MARK:
> -		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
> -		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
> +		if (!ns_capable_any(sock_net(sk)->user_ns, CAP_NET_RAW, CAP_NET_ADMIN))
>  			return -EPERM;
>  		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
>  			return -EINVAL;
> diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
> index 990a83455dcf..42b3b12eb493 100644
> --- a/net/ieee802154/socket.c
> +++ b/net/ieee802154/socket.c
> @@ -902,8 +902,7 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
>  		ro->want_lqi = !!val;
>  		break;
>  	case WPAN_SECURITY:
> -		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
> -		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
> +		if (!ns_capable_any(net->user_ns, CAP_NET_ADMIN, CAP_NET_RAW)) {

IIUC, should CAP_NET_RAW be tested first ?

Then, perhaps you should remove the Reviewed-by tag.


>  			err = -EPERM;
>  			break;
>  		}
> @@ -926,8 +925,7 @@ static int dgram_setsockopt(struct sock *sk, int level, int optname,
>  		}
>  		break;
>  	case WPAN_SECURITY_LEVEL:
> -		if (!ns_capable(net->user_ns, CAP_NET_ADMIN) &&
> -		    !ns_capable(net->user_ns, CAP_NET_RAW)) {
> +		if (!ns_capable_any(net->user_ns, CAP_NET_ADMIN, CAP_NET_RAW)) {

Same here.

Thanks!


>  			err = -EPERM;
>  			break;
>  		}
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..5a1e5ee20ddd 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -1008,8 +1008,9 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
>  		inet_assign_bit(MC_ALL, sk, val);
>  		return 0;
>  	case IP_TRANSPARENT:
> -		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
> -		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
> +		if (!!val &&
> +		    !sockopt_ns_capable_any(sock_net(sk)->user_ns,
> +					    CAP_NET_RAW, CAP_NET_ADMIN))
>  			return -EPERM;
>  		if (optlen < 1)
>  			return -EINVAL;
> diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> index d4c28ec1bc51..e46b11b5d3dd 100644
> --- a/net/ipv6/ipv6_sockglue.c
> +++ b/net/ipv6/ipv6_sockglue.c
> @@ -773,8 +773,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
>  		break;
>  
>  	case IPV6_TRANSPARENT:
> -		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
> -		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN)) {
> +		if (valbool && !sockopt_ns_capable_any(net->user_ns, CAP_NET_RAW, CAP_NET_ADMIN)) {
>  			retv = -EPERM;
>  			break;
>  		}
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 5b41e2321209..acc36b2d25d7 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1783,7 +1783,7 @@ static inline bool too_many_unix_fds(struct task_struct *p)
>  	struct user_struct *user = current_user();
>  
>  	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
> -		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
> +		return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
>  	return false;
>  }
>  
> -- 
> 2.43.0

