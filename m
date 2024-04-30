Return-Path: <linux-kernel+bounces-163759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF11D8B6F80
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E19C1C2207E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A9129E9C;
	Tue, 30 Apr 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0Axocf7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D61272AB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472390; cv=none; b=CwTbRllrhZgTlpp2CPaRjFdBjfqz60JHP2s1h6B4GFVrcC8qUq2YBKRpaohsHEYuvoPEEopRn5l9ZQ8hW7T5gBX1zhf4LdJAY0aWIHQprP4Je0PwB8jAAC1U1qNXUT0Zvey/fAmBbwhl6gBO+Qq3FyfmmOwX3QOLJaS6eotlLD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472390; c=relaxed/simple;
	bh=RBvwsFiMJYsTuSDgHfJczO2jCg4XQ1haWtK29o2NpoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dz9e4M2S1Bz7PPq2xAwZwQU/mZKAISgoAV1pzSu5cPU615k6shCO/oUPGVEgvBbGBHOherP6AbCtVBf2YioPM/vlMvsBTygFSC3vrFHEtHNvprLBhwjbo05+NDV3uWjxRaJXagdQhMpsviSljTerUcaNvp/3DfNuvZdphi4F1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0Axocf7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714472387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bMaZOXmwfkvy1y0270V5YasUqwBAP06Q+stByWGvEA8=;
	b=L0Axocf78uRjxwKfuY+5Pz8O/x7zvu3p3oFvUcqLR2sT1EJ/KZPLcQgY7QHa1QVynuhsYR
	2nM4I9DRrWzvN+e5uzi7KbGsf7e43uh4GnKq7lDbMOvbuv9F+TwwIHtvn5M+28Ax14Fs3u
	3UIY1T4hLKhfsC1XCBLMNBj403K7oyQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-IpPgtiXbOjyIA47weskFvA-1; Tue, 30 Apr 2024 06:19:45 -0400
X-MC-Unique: IpPgtiXbOjyIA47weskFvA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5727e9f92c3so243967a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472384; x=1715077184;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bMaZOXmwfkvy1y0270V5YasUqwBAP06Q+stByWGvEA8=;
        b=pGv2EBbuqOloyZ3HR3bpSJ2d8212NfqZcO/IIkHjuiz3Mb6pD5q60rkoqkNs4URrwI
         MurwVpAzmpv0lZr7JZ2Q4OxQfYWrWYvhu3xi3jcQCOdytRyhCTjccqE1BvT2mGb0XnDH
         1KWQPkSYdiY8vA/3zEhtBTNXdeg4eZcRCRxZgigH/AJV88ebb4pItS31qgBq83xZUrKF
         3I4j519jF3vZqdn7tyBVdkYox2Lbd7B0JuUQx9p8HlvjdBuet8MRtAEDNlkGaFAe8jGs
         ytB1ILwg1VjONxCMHffkAamKxpy6GM+FaKy9agnEI1XHkUCeJYJLJMaJVkGpDnOGUXPE
         Jd6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVccoHXObVpdfQxTvfUHSqCx98BshdJmua5TwcDfgcqAqPJ4bwOSW+ITIqAGPjlxTdAR6oTE6jKAOcht4HHdfh0MmS4G15CatEXEbBx
X-Gm-Message-State: AOJu0Yy5m42j3D4tJXPNUETUjuZKB3Fo1WDqjzM4DoBqkL8IZvoYtU1K
	JnasE72EvDWaXtw+48YbDBIpKtVqWqnq4SsSgIiuWVAn3qpgLKYh3NTtaUC28VMFVkQFxmT4vE4
	9h+Ftc9kuSOxqqKBb+aoSU21Czx8UPozDgkFWCZ7SD5bvILnI0U9evn3FboAjFg==
X-Received: by 2002:a05:6402:e8d:b0:572:58d3:a6bf with SMTP id h13-20020a0564020e8d00b0057258d3a6bfmr8032151eda.2.1714472384606;
        Tue, 30 Apr 2024 03:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfMsFBtyM3OlfXV3ingrrFUG8cA3jAtkmrlX9UvF6ywbd5RXuVKGhUk82uYA+uE/B3kxctHA==
X-Received: by 2002:a05:6402:e8d:b0:572:58d3:a6bf with SMTP id h13-20020a0564020e8d00b0057258d3a6bfmr8032128eda.2.1714472384232;
        Tue, 30 Apr 2024 03:19:44 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id y9-20020a50eb09000000b005727bdb1eafsm2770452edp.40.2024.04.30.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:19:43 -0700 (PDT)
Message-ID: <a20a0f0479cedc7f2f6abaf26e46ca7642e70958.camel@redhat.com>
Subject: Re: [PATCH v4 net-next v4 2/6] net: add support for segmenting TCP
 fraglist GSO packets
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 12:19:42 +0200
In-Reply-To: <20240427182305.24461-3-nbd@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
	 <20240427182305.24461-3-nbd@nbd.name>
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

On Sat, 2024-04-27 at 20:22 +0200, Felix Fietkau wrote:
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 67 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 58 ++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+)
>=20
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..affd4ed28cfe 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,70 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsign=
ed int ts_seq,
>  	}
>  }
> =20
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +				     __be32 *oldip, __be32 newip,
> +				     __be16 *oldport, __be16 newport)
> +{
> +	struct tcphdr *th;
> +	struct iphdr *iph;
> +
> +	if (*oldip =3D=3D newip && *oldport =3D=3D newport)
> +		return;
> +
> +	th =3D tcp_hdr(seg);
> +	iph =3D ip_hdr(seg);
> +
> +	inet_proto_csum_replace4(&th->check, seg, *oldip, newip, true);
> +	inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false);
> +	*oldport =3D newport;
> +
> +	csum_replace4(&iph->check, *oldip, newip);
> +	*oldip =3D newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *seg=
s)
> +{
> +	const struct tcphdr *th;
> +	const struct iphdr *iph;
> +	struct sk_buff *seg;
> +	struct tcphdr *th2;
> +	struct iphdr *iph2;
> +
> +	seg =3D segs;
> +	th =3D tcp_hdr(seg);
> +	iph =3D ip_hdr(seg);
> +	th2 =3D tcp_hdr(seg->next);
> +	iph2 =3D ip_hdr(seg->next);
> +
> +	if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
> +	    iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->saddr)
> +		return segs;
> +
> +	while ((seg =3D seg->next)) {
> +		th2 =3D tcp_hdr(seg);
> +		iph2 =3D ip_hdr(seg);
> +
> +		__tcpv4_gso_segment_csum(seg,
> +					 &iph2->saddr, iph->saddr,
> +					 &th2->source, th->source);
> +		__tcpv4_gso_segment_csum(seg,
> +					 &iph2->daddr, iph->daddr,
> +					 &th2->dest, th->dest);
> +	}
> +
> +	return segs;
> +}

AFAICS, all the above is really alike the UDP side, except for the
transport header zero csum.

What about renaming the udp version of this helpers as 'tcpudpv4_...',
move them in common code, add an explicit argument for
'zerocsum_allowed' and reuse such helper for both tcp and udp?

The same for the ipv6 variant.=C2=A0

Cheers,

Paolo


