Return-Path: <linux-kernel+bounces-163821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5650E8B7265
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09861F21009
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B819912D77C;
	Tue, 30 Apr 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLIiCAwa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73A1E50A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475248; cv=none; b=M10QUPCMOB5ERsm2PvTF4lmi35/EkvGgD8udkW+bPMHthmZkSPBHZOFqOLBaYpwwEb5NltM5trJ3+/QUAWkvDZ6rrqLblX5x+2DfzV9DJoELPPUmkSHagKS96QaKSTcgmgjnZyXgh7ZJ+z1klWJK2PftWSQwmVMgAowBeoFJ9Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475248; c=relaxed/simple;
	bh=2RAQXx9Hs2V88qI0iAiCTAiB8WYUsdO56+IVGIPnsSE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=svjVqGrPbxigwlBUfYzBvF+/2ajtdxfhJWwLkeKtF5BxGg698zjapE7/T1iUCHm7tFXjUD7UKx7J54KP0svIZfp8ICnEHQBwRXW64mQHJ+JqyBvPkZUOb/kKJMkcYd9lBtrgPf6dqPrqpL2b3UJ7QRS+nNDkOyaY19ZkRiHUukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLIiCAwa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714475246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=479+9n3x4cuBmKHOomGQFmMun7aOPyQx0HKnJJwE/uc=;
	b=VLIiCAwaTQemw/dB7IQi/lQ6oCx5c7Hg73O0kLBZtdipOtt9qb1uxubGB51+2KlD71YbPn
	2fLO5jjcjBEfLYAlzNnzbQi09gNc0a7CqyikEmqUoHrDTkKs8XrsB+29hmi8KCYUc1RNjQ
	4y5GdWEgLP03mbPiM58K7J2tLZ9/50o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-7pmW1EF_NOmuhxSyOmw4Xg-1; Tue, 30 Apr 2024 07:07:24 -0400
X-MC-Unique: 7pmW1EF_NOmuhxSyOmw4Xg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-416640b7139so6678015e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475243; x=1715080043;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=479+9n3x4cuBmKHOomGQFmMun7aOPyQx0HKnJJwE/uc=;
        b=KNGYOGcpz6PhgiYF9w3nyhQFKkJRJ26jrQD3tqg31ayw9cwNMd3lc1sPrDZmTGkH+B
         VgIFD/ocf3eQeASWtLCTBh02nj7rD16RkdQZb5eeONzTJgpJwGPhNWiDQuVJz8hqD7I8
         KSIrDDgzUOyuVEGxsfyl65J8xcDglBCgb6BacDim5C6qpXhB0qx4Y04WKhOmpEgzmKm3
         uuKwqDIntUxOOj+BHSE+aOWgNDyUmPKH9HgwLssiVZ5ibTG/9gh3tVPXTSlkd4HyxatU
         pj4CEkUCFxT+SMevrHhEBilKUcdedzaX+kFQrcuudw8yeuq3VWr/u08TQlO5GYEVnqLT
         M8KA==
X-Forwarded-Encrypted: i=1; AJvYcCUxGTykfzI4smfRjqdaTByYJEiUCT0+kZuo1R/wFiy/fnWA+UHaQGDZ59vxtVsFBiqSjDkm3QvoMfnQqtZvD7mhKdb71kJ/uzE1N0wH
X-Gm-Message-State: AOJu0Yz4WSIP/MtfXwRgYeuFFEk2hhr7QZUCtel+/R75eHFObe4VlKoU
	h0mtVfBKLsLTCBFqMZbEuxHNHRm5X8idsqJ9jIJd8kzVG8s7bhP/1HQoVOFxNI7bQJ3VZdOyS96
	wBuLR+tz8jQY4ZKNZyHfSfIlvvu4wJfP31i0nka2oO3nLSh4SzBBsWdtegKmiyg==
X-Received: by 2002:a5d:5692:0:b0:34d:7d77:36fa with SMTP id f18-20020a5d5692000000b0034d7d7736famr1006353wrv.5.1714475243644;
        Tue, 30 Apr 2024 04:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcLNke56JnTbPaAydHL1JwA1e2Rs1ezSc6zl5FkWobFVmpOsDpeZkzrMYwNPY8bl/KnnrD2g==
X-Received: by 2002:a5d:5692:0:b0:34d:7d77:36fa with SMTP id f18-20020a5d5692000000b0034d7d7736famr1006332wrv.5.1714475243219;
        Tue, 30 Apr 2024 04:07:23 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b0034c8b0354a6sm9179999wru.106.2024.04.30.04.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 04:07:22 -0700 (PDT)
Message-ID: <b763c28aa7cb3276136eac39a9144a4242587438.camel@redhat.com>
Subject: Re: [PATCH net 1/2] net: bridge: fix multicast-to-unicast with
 fraglist GSO
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Linus =?ISO-8859-1?Q?L=FCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 13:07:21 +0200
In-Reply-To: <20240427182420.24673-1-nbd@nbd.name>
References: <20240427182420.24673-1-nbd@nbd.name>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-27 at 20:24 +0200, Felix Fietkau wrote:
> Calling skb_copy on a SKB_GSO_FRAGLIST skb is not valid, since it returns
> an invalid linearized skb. This code only needs to change the ethernet
> header, so pskb_copy is the right function to call here.
>=20
> Fixes: 6db6f0eae605 ("bridge: multicast to unicast")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
> index 7431f89e897b..d7c35f55bd69 100644
> --- a/net/bridge/br_forward.c
> +++ b/net/bridge/br_forward.c
> @@ -266,7 +266,7 @@ static void maybe_deliver_addr(struct net_bridge_port=
 *p, struct sk_buff *skb,
>  	if (skb->dev =3D=3D p->dev && ether_addr_equal(src, addr))
>  		return;
> =20
> -	skb =3D skb_copy(skb, GFP_ATOMIC);
> +	skb =3D pskb_copy(skb, GFP_ATOMIC);
>  	if (!skb) {
>  		DEV_STATS_INC(dev, tx_dropped);
>  		return;

LGTM, but let's wait a little more time for Nikolay

Acked-by: Paolo Abeni <pabeni@redhat.com>


