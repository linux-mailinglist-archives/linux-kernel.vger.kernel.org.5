Return-Path: <linux-kernel+bounces-163779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15238B6FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1A8285130
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0536812D743;
	Tue, 30 Apr 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT3SDQf3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9312D1E0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473642; cv=none; b=Vzfv7TcQX4aueyWs7fJzaM9ba0YEcYdiuUMwrK2YSNwwHg8U3D7h06TH+FfOsH3FNVdv6crB52BUFXnZXLpIo8eMWcMNKneq+lIKON0cHGiXmQtQRDf/oCoecbAW3ApWDyhi+gv0EQVB3/vdVbOt/dD+4t2Cuw2nW6F6u9AQuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473642; c=relaxed/simple;
	bh=MZrViSg8jsZ0VHahAlyxw7aZOP9IOSCCin+ffecckc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZa50sMclQ/9KYUUGYRTJlh+N97xdIluP3KHt23oo/sTgIfbdTxojo7w9vPfS+MxnW6yfD3WXlD7fh9cmIzEtbxglj9eyhIM6dSk9OJnw2eLv1Z/BNw4fY8zahoMxu+bsIWvSHfSM4Zr0pD0pc7e5k1sgXq2K0z3QlPGJHU3AUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT3SDQf3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714473639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z+3pI/52NLYbeniFa7s38Cg51LKELjtpe+t6gtnHwiY=;
	b=bT3SDQf38H7XGTw45Wbtav77sceP/tNqc+eQr8uBbxlj7+0OFRu78xTskaj2y3gEPI4bp7
	7LZ/aapXi83YaXfpHp91MB0qpVu51k3hMHNr4FIqBEbLdfe845fB7dEb4VEO0DU0W8uY28
	ICbAPcZfepsuB9kAnWzk9+TiXbs8ZiE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-tveKE1jONu-6mPA4faaPow-1; Tue, 30 Apr 2024 06:40:37 -0400
X-MC-Unique: tveKE1jONu-6mPA4faaPow-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-416640b7139so6647875e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714473636; x=1715078436;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+3pI/52NLYbeniFa7s38Cg51LKELjtpe+t6gtnHwiY=;
        b=SvKSX8RRxw2fXTVqMS6uqFdHY3QeF4gcuJB7EwDfQx1rq++n31bpa9BGlGyYtP1r+v
         lrzB0Vs2qULiKLn72OgcqvNvRCQKqsyzxkf7nlGaMnFkljf6uTZ86imYbv+jhCD/I92Z
         7rnYQwmrP8fS8WjS2vO9rI0X/BRJfQZNNxRTDr8fy0d1rkb0M8lr1Br6n9HqPzEyOtZF
         n8NUHNqTWSVvnho1XujhwArIiPaR7mkgRiQHR5EoXpyZtMZveFgHkDgbsEP9NfhRHJhD
         XbV3XlvjQPEduubI7euFJJcZc9jkC1TFr4X8skxoX6mEaN/JhJDeA8fW7cQaSL+D77Wq
         D+1g==
X-Forwarded-Encrypted: i=1; AJvYcCUcLvJzcXkKQYhDS6luBfeZxd3k1LLlNavLB0k6HShFWdLQOtEAGI2Lf5HSrklXW4b+x8WBkcMUTYgsLzlJ8BvYQHvdsu6CqIM7b1Vf
X-Gm-Message-State: AOJu0YxvMR5w+utKJJjOkbpQCio75iqfFpHkc4zmNrG7UuBRM6lYY3G0
	ozFzkShVQOeIUo1/wOYgLg+furv6M7LBhOW4EFsGRi1RxMT+2ngB0SS5hmOK+TS0+tbYZVnUUgO
	gaVNEFlxQgboXqw6zR/2/4snSzB1ZThVaSCsIOx0z2n/i8LOCQuZ56IN9DnIIwA==
X-Received: by 2002:a05:600c:1d26:b0:41a:c04a:8021 with SMTP id l38-20020a05600c1d2600b0041ac04a8021mr9320323wms.0.1714473636178;
        Tue, 30 Apr 2024 03:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGIDRHUgcbr1K8Ie6wDrg7kUpsxvavfyrGxgyBY4SxyKPvAYu/OM+f0v5zhtSL3UFz3WEIwQ==
X-Received: by 2002:a05:600c:1d26:b0:41a:c04a:8021 with SMTP id l38-20020a05600c1d2600b0041ac04a8021mr9320304wms.0.1714473635738;
        Tue, 30 Apr 2024 03:40:35 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id b2-20020a05600010c200b0034c9f060a14sm8445728wrx.11.2024.04.30.03.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:40:35 -0700 (PDT)
Message-ID: <bef0c2839b05d4f2692fa3cde82258e6af87e645.camel@redhat.com>
Subject: Re: [PATCH v4 net-next v4 2/6] net: add support for segmenting TCP
 fraglist GSO packets
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 12:40:33 +0200
In-Reply-To: <9e686cb4-ed1f-4886-a0b7-328367e62757@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
	 <20240427182305.24461-3-nbd@nbd.name>
	 <a20a0f0479cedc7f2f6abaf26e46ca7642e70958.camel@redhat.com>
	 <9e686cb4-ed1f-4886-a0b7-328367e62757@nbd.name>
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

On Tue, 2024-04-30 at 12:27 +0200, Felix Fietkau wrote:
> On 30.04.24 12:19, Paolo Abeni wrote:
> > On Sat, 2024-04-27 at 20:22 +0200, Felix Fietkau wrote:
> > > Preparation for adding TCP fraglist GRO support. It expects packets t=
o be
> > > combined in a similar way as UDP fraglist GSO packets.
> > > For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
> > >=20
> > > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > > ---
> > >  net/ipv4/tcp_offload.c   | 67 ++++++++++++++++++++++++++++++++++++++=
++
> > >  net/ipv6/tcpv6_offload.c | 58 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 125 insertions(+)
> > >=20
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index fab0973f995b..affd4ed28cfe 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -28,6 +28,70 @@ static void tcp_gso_tstamp(struct sk_buff *skb, un=
signed int ts_seq,
> > >  	}
> > >  }
> > > =20
> > > +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> > > +				     __be32 *oldip, __be32 newip,
> > > +				     __be16 *oldport, __be16 newport)
> > > +{
> > > +	struct tcphdr *th;
> > > +	struct iphdr *iph;
> > > +
> > > +	if (*oldip =3D=3D newip && *oldport =3D=3D newport)
> > > +		return;
> > > +
> > > +	th =3D tcp_hdr(seg);
> > > +	iph =3D ip_hdr(seg);
> > > +
> > > +	inet_proto_csum_replace4(&th->check, seg, *oldip, newip, true);
> > > +	inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false)=
;
> > > +	*oldport =3D newport;
> > > +
> > > +	csum_replace4(&iph->check, *oldip, newip);
> > > +	*oldip =3D newip;
> > > +}
> > > +
> > > +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff =
*segs)
> > > +{
> > > +	const struct tcphdr *th;
> > > +	const struct iphdr *iph;
> > > +	struct sk_buff *seg;
> > > +	struct tcphdr *th2;
> > > +	struct iphdr *iph2;
> > > +
> > > +	seg =3D segs;
> > > +	th =3D tcp_hdr(seg);
> > > +	iph =3D ip_hdr(seg);
> > > +	th2 =3D tcp_hdr(seg->next);
> > > +	iph2 =3D ip_hdr(seg->next);
> > > +
> > > +	if (!(*(const u32 *)&th->source ^ *(const u32 *)&th2->source) &&
> > > +	    iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->saddr)
> > > +		return segs;
> > > +
> > > +	while ((seg =3D seg->next)) {
> > > +		th2 =3D tcp_hdr(seg);
> > > +		iph2 =3D ip_hdr(seg);
> > > +
> > > +		__tcpv4_gso_segment_csum(seg,
> > > +					 &iph2->saddr, iph->saddr,
> > > +					 &th2->source, th->source);
> > > +		__tcpv4_gso_segment_csum(seg,
> > > +					 &iph2->daddr, iph->daddr,
> > > +					 &th2->dest, th->dest);
> > > +	}
> > > +
> > > +	return segs;
> > > +}
> >=20
> > AFAICS, all the above is really alike the UDP side, except for the
> > transport header zero csum.
> >=20
> > What about renaming the udp version of this helpers as 'tcpudpv4_...',
> > move them in common code, add an explicit argument for
> > 'zerocsum_allowed' and reuse such helper for both tcp and udp?
> >=20
> > The same for the ipv6 variant.
>=20
> Wouldn't that make it more convoluted when taking into account that the=
=20
> checksum field offset is different for tcp vs udp?
> How would you handle that?

Probably making a common helper just for
__tcpudpv{4,6}_gso_segment_csum and pass it the target l4 csum pointer
as an additional argument. It would not be spectacularly nice, so no
strong opinion either way.

Cheers,

Paolo






