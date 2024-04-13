Return-Path: <linux-kernel+bounces-143842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3388A3E1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64541F21677
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B353803;
	Sat, 13 Apr 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyB7EQpO"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0AEC7;
	Sat, 13 Apr 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713033494; cv=none; b=hWumNVnYZMdxSEN3Z3fP2x4Jc16mFMExYOjHMxrmbT3dXP1JOuwkkQ3FcW1mers9ZcQyndwn1TAWNI8E1kiuM8U+iOjjeZr2EAY5SqZrQhoYUAsSvTeCiIDBMsLKMclGAWauQy3zFK0xTWFRGy0zVr1Sw2+3ADsXM0RIoxjZxdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713033494; c=relaxed/simple;
	bh=n+n610De9TEoupfYqoMSJOg05kKiAQ2DdDTcw4BNXYc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=f4FK4ZQc/6lUFY3y1sdWygpLgnMGyq4GqpJPJSIillfmJ2IHlBxtHppRp/7jxUlQytp7ikc7krZCfnXes3nUP7jzh8DrdUu1u/Sb7bt6APQ/UaSjVZkixkvoi0crVG2AN7c6f1mtslIcegRzwMowaIyeawshXAGJ4cEwWwcffPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyB7EQpO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb50c13f44so1290144a34.2;
        Sat, 13 Apr 2024 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713033492; x=1713638292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/nJU/VEfuhMETnVDjiW+UnOL47XPkcKd7GNS5voFxk=;
        b=TyB7EQpOwWKapOfwh8dJTf2rgUBAU3tfvYtnCrU9lHnkJb5+8sshg963+b9vjdLTqM
         64G0BYbUnEgfZYWlwWTlkHbrd9WpclIlsExAciILKWfbIbDWoFM1n987r2gN4RyZlM1e
         EDGJr0OQNdAXoR8KKuPgwebci7xV3mnSW9PGC5pd9TrxGi7cbio8DnuN+HJjgua9bbZm
         nHuUBV/tb+7TX9RLoU/3t7ctpHhU7kuoHMxRNESb3O1qsZXOjPu4KBwVNtiKNRYNRGuU
         PerMRw3AGhqxmrB7gpploDOnytYvM+O/k4levtWPVt+3+BhYSpmCpLdO0mH71CESs7hO
         5wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713033492; x=1713638292;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/nJU/VEfuhMETnVDjiW+UnOL47XPkcKd7GNS5voFxk=;
        b=DtoGfq0UwRqZY1/J4ZxNoxHKUdNGDrtWSJ9Ur1kSmACp/J8QLp1IrlUTKRCqKZDFNp
         UfFnInAtgnXyQZZMyqpdodk+w8mOMHdF9v29cqlDvNTu3ury56YSK4BddsWs+sK3K3VB
         wsfzb8WrhueJlusITCAoFJrGzCPUaJWBg8rhOxnFk0GnGqtmZmIR6I8eUwc58YUH3cxs
         Xjo0KSNnfYbWxW9bfYYeV0jQ9uN47+I+4GYzQ7cOy0kYKooBDzdP5BZBS0ep3TAk0zuZ
         6vWX+IUUjO1TDCEWUVL8oynYjtd3UpKCRKHPFsmrqWIst2smN2cAlPXHclRFBtC1xOgO
         8BGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs56UyVlOyQcblrXQEP3wG5lcm3IT/8ByuWa3vTqeYnzNmLMp64Ut/fB3oYqyPYrsunBB1naMIXQPi4ZJn1EzmtZEtt27tXuNTkBUG/TqhQMvdK2ubvVTCPXR0htdEHBJGpUwo
X-Gm-Message-State: AOJu0YzCppAZHdJd84QWP/hEcJAZ8qEsWwgvgcWDfDJEvg2MZoZL9mIk
	8gk8TfoUN5cdFQvWJtZj/0OUGc1Ma8VK1yMftYnqivM/gleUY6qY
X-Google-Smtp-Source: AGHT+IH3bmOWil9Aw4QY2OFb50LQEQ56jX6vaDi6dheFJgxgqPDZFxuEnNfhzIxhoCVjlnxSPF1aqA==
X-Received: by 2002:a05:6830:39da:b0:6ea:1702:b018 with SMTP id bt26-20020a05683039da00b006ea1702b018mr6651716otb.34.1713033492126;
        Sat, 13 Apr 2024 11:38:12 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id c5-20020a056214070500b0069b4f48003bsm3500926qvz.100.2024.04.13.11.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 11:38:11 -0700 (PDT)
Date: Sat, 13 Apr 2024 14:38:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 alexander.duyck@gmail.com
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <661ad1136bc10_3be9a7294c2@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412152120.115067-2-richardbgobert@gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net v1 1/2] net: gro: add flush check in
 udp_gro_receive_segment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> GRO-GSO path is supposed to be transparent and as such L3 flush checks are
> relevant to all flows which call skb_gro_receive. This patch uses the same
> logic and code from tcp_gro_receive but in the relevant flow path in
> udp_gro_receive_segment.
> 
> Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/ipv4/udp_offload.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 3498dd1d0694..1f4e08f43c4b 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  	struct sk_buff *p;
>  	unsigned int ulen;
>  	int ret = 0;
> +	int flush;
>  
>  	/* requires non zero csum, for symmetry with GSO */
>  	if (!uh->check) {
> @@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  				skb_gro_postpull_rcsum(skb, uh,
>  						       sizeof(struct udphdr));
>  
> -				ret = skb_gro_receive(p, skb);
> +				flush = NAPI_GRO_CB(p)->flush;
> +
> +				if (NAPI_GRO_CB(p)->flush_id != 1 ||
> +				    NAPI_GRO_CB(p)->count != 1 ||
> +				    !NAPI_GRO_CB(p)->is_atomic)
> +					flush |= NAPI_GRO_CB(p)->flush_id;
> +				else
> +					NAPI_GRO_CB(p)->is_atomic = false;
> +
> +				if (flush || skb_gro_receive(p, skb))
> +					ret = 1;

UDP_L4 does not have the SKB_GSO_TCP_FIXEDID that uses is_atomic as
input.

And I still don't fully internalize the flush_id logic after staring
at it for more than one coffee.

But even ignoring those, the flush signal of NAPI_GRO_CB(p)->flush
set the network layer must be followed, so ACK. Thanks for the fix.

