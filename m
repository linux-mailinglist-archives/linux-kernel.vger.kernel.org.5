Return-Path: <linux-kernel+bounces-69618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD14858C75
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02011C20B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372311B811;
	Sat, 17 Feb 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RkBi+WEp"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D861CA8A;
	Sat, 17 Feb 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131634; cv=none; b=q46BX4U3z0pK/3+nXw/miGSAswrccrn4YIYk+TVmk+j+DbtDEtRXSEu0OsQ8SrpsdYwR9YgqNBcPSpa1MKCGRTGJwQVYP5NifagtBiB7JqnuaC5JSaggShl5dDq8rMtkXXnujCnwSZpTcs2jlXPX10LxGNiznBgkVocqYz5+6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131634; c=relaxed/simple;
	bh=1zfNqioyniR4xnLdtvSzh0f8uun5eZtSu1xERp95dN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNCPa+F3C5JjCWvN4xGOK9lac9/gfklJFMYybKpMCDb2Tkhof1deKJLOZOIhyQ4QPdooJ4dFmC8EsdDMeeFRhCyIIve7V4EAt9rE7D2iIWBfVPUGLlRvEI2c5g9P/bnl2pxdUshDwbpwxHXSj9mqHAY3wFxREuwo693B96hUGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RkBi+WEp; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708131633; x=1739667633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RquXHbfufZByeP1vhcrpgfQqW1al7eeTE6lYVW9xOH8=;
  b=RkBi+WEpSR0fekqhEaeNsYpGeOhVdyHybeZdyw04XfpDuo7VO5rNaaST
   XrcY1HlgdzQZjC94JlZJIeR2eC44W30Ng8mEgTec4Q8yeN9HmqckOV9hg
   B6Vbu5YZYr5cr6s4oCFQy7Rde7M5MuO1i3SeTnPM3gGUmRvjae4+CRX/Q
   Q=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="273878251"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 01:00:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:61573]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id 15ba2131-9529-4178-82bc-c81ecd60df33; Sat, 17 Feb 2024 01:00:30 +0000 (UTC)
X-Farcaster-Flow-ID: 15ba2131-9529-4178-82bc-c81ecd60df33
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 17 Feb 2024 01:00:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 17 Feb 2024 01:00:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <keescook@chromium.org>
CC: <alexander@mihalicyn.com>, <davem@davemloft.net>, <dhowells@redhat.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <leitao@debian.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v2] sock: Use unsafe_memcpy() for sock_copy()
Date: Fri, 16 Feb 2024 17:00:17 -0800
Message-ID: <20240217010017.88921-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216232220.it.450-kees@kernel.org>
References: <20240216232220.it.450-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <keescook@chromium.org>
Date: Fri, 16 Feb 2024 15:22:23 -0800
> While testing for places where zero-sized destinations were still showing
> up in the kernel, sock_copy() and inet_reqsk_clone() were found, which
> are using very specific memcpy() offsets for both avoiding a portion of
> struct sock, and copying beyond the end of it (since struct sock is really
> just a common header before the protocol-specific allocation). Instead
> of trying to unravel this historical lack of container_of(), just switch
> to unsafe_memcpy(), since that's effectively what was happening already
> (memcpy() wasn't checking 0-sized destinations while the code base was
> being converted away from fake flexible arrays).
> 
> Avoid the following false positive warning with future changes to
> CONFIG_FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 3068) of destination "&nsk->__sk_common.skc_dontcopy_end" at net/core/sock.c:2057 (size 0)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> 
> v2- add inet_reqsk_clone() instance too
> v1- https://lore.kernel.org/lkml/20240216204423.work.066-kees@kernel.org/
> ---
>  net/core/sock.c                 | 5 +++--
>  net/ipv4/inet_connection_sock.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 0a7f46c37f0c..b7ea358eb18f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2053,8 +2053,9 @@ static void sock_copy(struct sock *nsk, const struct sock *osk)
>  
>  	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));
>  
> -	memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
> -	       prot->obj_size - offsetof(struct sock, sk_dontcopy_end));
> +	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
> +		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
> +		      /* alloc is larger than struct, see sk_prot_alloc() */);
>  
>  #ifdef CONFIG_SECURITY_NETWORK
>  	nsk->sk_security = sptr;
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index 459af1f89739..4a1d96ba3ad1 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -906,8 +906,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>  
>  	memcpy(nreq_sk, req_sk,
>  	       offsetof(struct sock, sk_dontcopy_begin));
> -	memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
> -	       req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end));
> +	unsafe_memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
> +		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
> +		      /* alloc is larger than struct, see sk_prot_alloc() */);

nit: reqsk is allocated in inet_reqsk_clone().


>  
>  	sk_node_init(&nreq_sk->sk_node);
>  	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
> -- 
> 2.34.1
> 

