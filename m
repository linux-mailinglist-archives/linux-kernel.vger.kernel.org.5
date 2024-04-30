Return-Path: <linux-kernel+bounces-163922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD898B75DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F5D2828EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3768517108E;
	Tue, 30 Apr 2024 12:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REcLOlO2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD29D17592
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480733; cv=none; b=A8Ox9GlTlOVofgjLrBH48GK625zgwrdpx6mIYJSKlLXPXouKNRlUIfHSGzl+YwqcNGh/sdyxixC1iLA6rfPxdRF2SFTs3fRyZstjEn/vyoAdUt7+es4TT6L43Pz5lSM51q1CkRFNQ7DavJY4x0VncDNJgcfhHA3NimRZwp8TPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480733; c=relaxed/simple;
	bh=J69lym4Y1ijVS2l3VccQr4VnjGIc/ffT+ZVFdcU/Cg8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WJTzpV2FdUJi9FVlKuUM9xSTTZHNC4ZHWRGBv/ZaOHNlkEQRKt9byZN0nbE24ZPxvY93xK0Op7QTCvkKlLRst/EG4Fmtg3WD4il0ugBUOYrG0X6WMVaKqfAa8qtABf6qExI6M+ppPt06yzDMPkIGpM1LPQOkFryUetT6rI8qK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REcLOlO2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714480730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTsVsZGEpgTzoqVRCmrDFKCPKwoBHLuOSJ7Pzk7+PZg=;
	b=REcLOlO2nOvvtBjCGpH6HlnKnRWX3ZTNnxSZYiZnSTB64FJDnMhMsx/WcRQAhZmpXu1Qpq
	b/B+Ur8ntjXBvkRKH7FCgtwV5e02mAnqCSdVoV5YKvtM2OqO6C0CtCoFcFR3HD0nIaZvay
	mEYC6zS0i5I+3/DvMCV7T8eckU/1dx0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-7tvXSP2kNGOwMbu2sm-rSg-1; Tue, 30 Apr 2024 08:38:49 -0400
X-MC-Unique: 7tvXSP2kNGOwMbu2sm-rSg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ecec819962so6188711b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714480728; x=1715085528;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTsVsZGEpgTzoqVRCmrDFKCPKwoBHLuOSJ7Pzk7+PZg=;
        b=ELHVy3x5qDs1ZPJZctnn63QVsjOI3DYixVcybLkX8NPhX8S2h8Pb6pj9311j11+qPG
         3M4wOLYMC0iHhmNcQMLrr4NepDuCrnn1QIZbR+fIvhZTLlN9BWKFGTfIUumjVIfI68Te
         X2rKiMTP95wFMnR4Frf3hOki4lWVeJYGHXK7LfMqRgzHunmFNbSjrzyVosUYKGRKpRJU
         Yo3v7Ey5AHvHeemMpbMHd0xc/GJUR8zOIzw+/hDOz3qGdHAzyl6yY22G5c3HnTuyICcK
         T4wcTLMY3JgGGydSwzCxOfxCxgDdktH69shzj9AuccdKMabm0C8gDwzwZiexQTennjXm
         3lGw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0bIpOcXh8vQ7FLrKImrWAEcEY27Uw3akMjkbhKMd0OUm9xYNIZLBFV+b9O5LHTjyR5WNx5jZ89er9k/4xAv6Fv2d7Wrq49VMoR75
X-Gm-Message-State: AOJu0YxkUfyWrOqocz4jhp67pMrCDcAI7Zb+BzCDFheZR8oF+lMEwpNw
	ywHGvG2s0Ka5kLSaPxx6DnbOzQe9HhJtnn+GE2MoY24uHI+V3IKWIReykmXHYHyhfBfwZJ4MXbX
	lQjipuM3ot7ueDM+XqTuIxNwQGPxTPHcuAi5j4Nx7VODXg3T9LuRx5aIPhyOP+Q==
X-Received: by 2002:a05:6a00:2352:b0:6ed:1c7:8c5d with SMTP id j18-20020a056a00235200b006ed01c78c5dmr2762955pfj.12.1714480728002;
        Tue, 30 Apr 2024 05:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFztMv0UxyXJZbWLLW1L8xXAYOsfxU9m0GCXL6tXtHNGq5aaCWWYqCJstyFzENtRXtCfOyBPA==
X-Received: by 2002:a05:6a00:2352:b0:6ed:1c7:8c5d with SMTP id j18-20020a056a00235200b006ed01c78c5dmr2762929pfj.12.1714480727495;
        Tue, 30 Apr 2024 05:38:47 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id km3-20020a056a003c4300b006eaa21301a7sm21009112pfb.162.2024.04.30.05.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:38:47 -0700 (PDT)
Date: Tue, 30 Apr 2024 21:38:40 +0900 (JST)
Message-Id: <20240430.213840.1150978152260555051.syoshida@redhat.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syoshida@redhat.com, syzkaller@googlegroups.com
Subject: Re: [PATCH net] ipv4: Fix uninit-value access in __ip_make_skb()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <20240429151605.2055465-1-syoshida@redhat.com>
References: <20240429151605.2055465-1-syoshida@redhat.com>
X-Mailer: Mew version 6.9 on Emacs 29.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Sorry, I forgot to add "v2" to the prefix. I will repost this.

On Tue, 30 Apr 2024 00:16:05 +0900, Shigeru Yoshida wrote:
> KMSAN reported uninit-value access in __ip_make_skb() [1].  __ip_make_skb()
> tests HDRINCL to know if the skb has icmphdr. However, HDRINCL can cause a
> race condition. If calling setsockopt(2) with IP_HDRINCL changes HDRINCL
> while __ip_make_skb() is running, the function will access icmphdr in the
> skb even if it is not included. This causes the issue reported by KMSAN.
> 
> Check FLOWI_FLAG_KNOWN_NH on fl4->flowi4_flags instead of testing HDRINCL
> on the socket.
> 
> Also, fl4->fl4_icmp_type and fl4->fl4_icmp_code are not initialized. These
> are union in struct flowi4 and are implicitly initialized by
> flowi4_init_output(), but we should not rely on specific union layout.
> 
> Initialize these explicitly in raw_sendmsg().
> 
> [1]
> BUG: KMSAN: uninit-value in __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
>  __ip_make_skb+0x2b74/0x2d20 net/ipv4/ip_output.c:1481
>  ip_finish_skb include/net/ip.h:243 [inline]
>  ip_push_pending_frames+0x4c/0x5c0 net/ipv4/ip_output.c:1508
>  raw_sendmsg+0x2381/0x2690 net/ipv4/raw.c:654
>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3804 [inline]
>  slab_alloc_node mm/slub.c:3845 [inline]
>  kmem_cache_alloc_node+0x5f6/0xc50 mm/slub.c:3888
>  kmalloc_reserve+0x13c/0x4a0 net/core/skbuff.c:577
>  __alloc_skb+0x35a/0x7c0 net/core/skbuff.c:668
>  alloc_skb include/linux/skbuff.h:1318 [inline]
>  __ip_append_data+0x49ab/0x68c0 net/ipv4/ip_output.c:1128
>  ip_append_data+0x1e7/0x260 net/ipv4/ip_output.c:1365
>  raw_sendmsg+0x22b1/0x2690 net/ipv4/raw.c:648
>  inet_sendmsg+0x27b/0x2a0 net/ipv4/af_inet.c:851
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x274/0x3c0 net/socket.c:745
>  __sys_sendto+0x62c/0x7b0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x130/0x200 net/socket.c:2199
>  do_syscall_64+0xd8/0x1f0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> CPU: 1 PID: 15709 Comm: syz-executor.7 Not tainted 6.8.0-11567-gb3603fcb79b1 #25
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-1.fc39 04/01/2014
> 
> Fixes: 99e5acae193e ("ipv4: Fix potential uninit variable access bug in __ip_make_skb()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
> v1->v2: https://lore.kernel.org/all/20240324050554.1609460-1-syoshida@redhat.com/
> - Explicitly initialize fl4->fl4_icmp_type and fl4->fl4_icmp_code because
>   we should not rely on a specific union layout.
> ---
>  net/ipv4/ip_output.c | 2 +-
>  net/ipv4/raw.c       | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 1fe794967211..39229fd0601a 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1473,7 +1473,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
>  		 * by icmp_hdr(skb)->type.
>  		 */
>  		if (sk->sk_type == SOCK_RAW &&
> -		    !inet_test_bit(HDRINCL, sk))
> +		    !(fl4->flowi4_flags & FLOWI_FLAG_KNOWN_NH))
>  			icmp_type = fl4->fl4_icmp_type;
>  		else
>  			icmp_type = icmp_hdr(skb)->type;
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index dcb11f22cbf2..4cb43401e0e0 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -612,6 +612,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
>  			   daddr, saddr, 0, 0, sk->sk_uid);
>  
> +	fl4.fl4_icmp_type = 0;
> +	fl4.fl4_icmp_code = 0;
> +
>  	if (!hdrincl) {
>  		rfv.msg = msg;
>  		rfv.hlen = 0;
> -- 
> 2.44.0
> 


