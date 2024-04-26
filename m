Return-Path: <linux-kernel+bounces-159681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050158B321A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B137D281D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C19E13C9AC;
	Fri, 26 Apr 2024 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMfa19Vb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28313C915
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119254; cv=none; b=mhl6jd4EgLxQQE/hccv3zikIm+54SyPPrQG/gHma5hSebYPz3m5WUf4Iu+PqgF6kmRgsYq5QibuEwZYfg9r8KJTi7EnI1GGjqN6Wn7Mgz6O4JgHaGFDaMk+C/xJsm/1c7xrdF106b+dzZCEFg3o/tQf2g4OJ9tg8FUclPcE9Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119254; c=relaxed/simple;
	bh=xnukKj82afXd616up3SVX4P1lCt0MFKwpZCZY6Zyco8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIgQjj/qsKxqzMXUTx8VK8A8ELz2IZ18VQpigEQKru23uR98GZChvwpBYiN2EKbhdlGoOXDpoGYCOedfahfm02SHklKiyppAtXArP2ur8T86e7iYeTNLIBm7x59ezU+D8/l9U2YjT6dh/YUhQ1OV4chv+grvHpOELtOICPnnJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMfa19Vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714119252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BDqpBO7omNT7QL5cCt7YADimwVUvaeaLukFM/JMfaDQ=;
	b=bMfa19Vbk+Sz0pw3kmGAwXJjMzIpjJYq4gcTV0FPabfFINcQh6vRYiohNOUeYUVUHqv0cE
	IjX2U7qCHLAy1itPRdO1yG/YnXuWrYX8YIpa2gJs8u4Ls+mlKDWGJ2wN7uUvUHRNr3TJ14
	Tiq6QmS40oadNRbU1zrxFgc33+5+QXU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-J4rtdXY7OdWpk8OoaWm_2A-1; Fri, 26 Apr 2024 04:14:10 -0400
X-MC-Unique: J4rtdXY7OdWpk8OoaWm_2A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-519669141f7so252971e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119249; x=1714724049;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDqpBO7omNT7QL5cCt7YADimwVUvaeaLukFM/JMfaDQ=;
        b=HkpuxfJbjuC5vEzs124ymy0gB0MdzNjIiJyTXT0fmkQqSra7wdiMk0KC7Myp6Wee5U
         5yUbNQ4N/FoqJu9QW9Vp2VUz6rjT+raWeWH2YI1r+IDqy4tPWRHvem1gzO2EPJAeJCtV
         Won4HoyW8QUvugFDfQ2R9lkmRtTFe9c6gp04g3YLQxkbBiDX2hNfjgPVi2sfiIOfjKG1
         eDfdydLPHNbZ54k7vL1vuWqNOGtPnYkW1/py6anWlpB6QnlorY4wwzcRda4e2Sv4jIRy
         XnEmvd21FJhougrJ88hJtX58uM566YVFm0UUInmwzLGu6b2XZVzWGQTxTTe/GqJyI6RA
         su4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXQZe5QfDxHtzklbiwhxz4DAAz6eWTLxIA5HlVW8J5Zs77MWF54ADhIxgZ+u0d9twcuNp9ApdiUMnHj8lvEkJG0Pb5h1BVTGXSGOod
X-Gm-Message-State: AOJu0YyEXOsm2DlN8h7oUBoMLw/d7ueLl6gI+xAgTpc8MSPyxLNtULdx
	E+dPMoiGlfBDjN8NL159dpcE2qZG824bbZxP577pWR6iRkyt1A7BhQ014ODJBe0HgpKzsZY7xdB
	hOnAWK3FFbbjPvDv62+wHgoP+Iio51W/Hoo/VVIXKJKmfG9mfo9+ZCyazh9rSVA==
X-Received: by 2002:a2e:8194:0:b0:2de:6d53:fcd8 with SMTP id e20-20020a2e8194000000b002de6d53fcd8mr978654ljg.5.1714119249114;
        Fri, 26 Apr 2024 01:14:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ9ofEkQeveoLtOGpbOvjocWfrh6SiycrseBVJIV7jmOr/hVHBQnJv2z07Kqdv5851n/hFAA==
X-Received: by 2002:a2e:8194:0:b0:2de:6d53:fcd8 with SMTP id e20-20020a2e8194000000b002de6d53fcd8mr978635ljg.5.1714119248626;
        Fri, 26 Apr 2024 01:14:08 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000050c00b00349ac818326sm21795221wrf.43.2024.04.26.01.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 01:14:08 -0700 (PDT)
Message-ID: <ce46af97c03471c64f1fcff27c41e65ca82dd151.camel@redhat.com>
Subject: Re: [PATCH net-next 3/4] net: add code for TCP fraglist GRO
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 10:14:06 +0200
In-Reply-To: <20240424180458.56211-4-nbd@nbd.name>
References: <20240424180458.56211-1-nbd@nbd.name>
	 <20240424180458.56211-4-nbd@nbd.name>
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

On Wed, 2024-04-24 at 20:04 +0200, Felix Fietkau wrote:
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  include/net/tcp.h        |  3 ++-
>  net/ipv4/tcp_offload.c   | 29 +++++++++++++++++++++++++++--
>  net/ipv6/tcpv6_offload.c | 11 ++++++++++-
>  3 files changed, 39 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index b935e1ae4caf..875cda53a7c9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2194,7 +2194,8 @@ void tcp_v4_destroy_sock(struct sock *sk);
> =20
>  struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>  				netdev_features_t features);
> -struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *=
skb);
> +struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *=
skb,
> +				bool fraglist);
>  INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int=
 thoff));
>  INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_h=
ead *head, struct sk_buff *skb));
>  INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int=
 thoff));
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 06dbb2e2b2f3..6294e7a5c099 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -252,7 +252,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
>  	return segs;
>  }
> =20
> -struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *=
skb)
> +struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *=
skb,
> +				bool fraglist)
>  {
>  	struct sk_buff *pp =3D NULL;
>  	struct sk_buff *p;
> @@ -289,6 +290,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb)
>  	len =3D skb_gro_len(skb);
>  	flags =3D tcp_flag_word(th);
> =20
> +	NAPI_GRO_CB(skb)->is_flist =3D fraglist;
>  	list_for_each_entry(p, head, list) {
>  		if (!NAPI_GRO_CB(p)->same_flow)
>  			continue;
> @@ -308,6 +310,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb)
>  found:
>  	/* Include the IP ID check below from the inner most IP hdr */
>  	flush =3D NAPI_GRO_CB(p)->flush;
> +	flush |=3D fraglist !=3D NAPI_GRO_CB(p)->is_flist;
>  	flush |=3D (__force int)(flags & TCP_FLAG_CWR);
>  	flush |=3D (__force int)((flags ^ tcp_flag_word(th2)) &
>  		  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
> @@ -341,6 +344,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>  	flush |=3D (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>  	flush |=3D skb_cmp_decrypted(p, skb);
> =20
> +	if (fraglist) {
> +		flush |=3D (__force int)(flags ^ tcp_flag_word(th2));

Don't we have this check already a few lines above?


> +		flush |=3D skb->ip_summed !=3D p->ip_summed;
> +		flush |=3D skb->csum_level !=3D p->csum_level;
> +		flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));

Why we need this check? The earlier skb_gro_may_pull() should ensure
that, right?

> +		flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
> +
> +		if (flush || skb_gro_receive_list(p, skb))
> +			mss =3D 1;
> +
> +		goto out_check_final;

TCP flags processing needs some care. You need to propagate the current
packets flag to the old one, and update the older packet csum
accordingly.

Cheers,

Paolo


