Return-Path: <linux-kernel+bounces-159881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0418B356D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4207F1C2165B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49001139D10;
	Fri, 26 Apr 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp8pt4uI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C52AF11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128048; cv=none; b=SUEF8MFfAtmeI07RyqaN6m1our/Q0DizU9kpFSZGBZYBLdhTA5d+v36Vyw29jHX0OfKBsGZT6MU1WT/iACRsCu3xvsNh3lSPx1wldPuA6RBFUyjDEpdggE5zs9Cdu7sXFCuOfcbMnicWX3ePU+eT3TITREKexm25MbW9WQgEvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128048; c=relaxed/simple;
	bh=gpo9fmAotkN0bV2ezUnKswQkQ7spknPD8yt1uTT9AiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SLbm+q7c6d7BVTDyMlrlqkFYhjRqO6lSDJP4HggKsmVEFZ8TAbqGxclg8+Yp2t6bkqCmIxUDhrfjsQpVMnoGaXmNqF1Tvmxgvp/mzwvUzCN4PH48E9io9HdDCBZQSPdsdQf7bcioifnwI2ofOGyndn6Hpk17Mtipnm5xG5VBNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cp8pt4uI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aWdJarjvevrp+sqkeLHrEJaw2ugclz8D4c3/BHgjuSM=;
	b=cp8pt4uIOG8nBBfsOjVaEnTXJahbEcqQ7Iu4HO9sNGoBGJXaTWDBlkHgXW+ocObe6+3uXB
	QVLtPWp2Xqtxw02sH4I8mdNPg5EgggFqRVG4XEneXCqNsBGjnkOKwn75uI8fp2IVXdJEYZ
	wq19ZVggEPtjK4HRFiQ+avrRTa/VTM8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-yKVsdJ_QPHmb6t3DkuugKA-1; Fri, 26 Apr 2024 06:40:43 -0400
X-MC-Unique: yKVsdJ_QPHmb6t3DkuugKA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-516ce9afcabso253469e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128042; x=1714732842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWdJarjvevrp+sqkeLHrEJaw2ugclz8D4c3/BHgjuSM=;
        b=sfwipojtdt/FQpPGYcR5WlWN9uJKc92wMUawqLGJsc7rLzFqFfsTGamSXV09Xp60H7
         jQZG8aOKNPucpJp0ND+hZG2kpGhUWCSVHXhxfpuU0j48/i/Fm6YkjJDTeNhzJnp5Sb5n
         MIDQjkoSysnun7OMHFev/ZkVRoCEDRIaGLMY3RR0WzPZqbjCOlG2mpcgNiwdqcD/HWNu
         9zVFSpgxbaxuv39Wjf2GoJOgeVDbtv2U5CvrxVJDjfnzJPNqoTFK0KMGb3YUxiB0bnkQ
         T+shMqwyehuXUbWLpooCDk8QUgMVWhoYyAaITvD4NIPDPen7SF/cVI6DCySBo7hnkQUQ
         +CCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Pb75XumvY/vUuq0F2oUcktYMPOY3pfM/hoOXxVYCOmJWL2LZsGh1MDxbAZa5aTVSy8ESk8lxr54i7pVI+X5JFie63NHLN3VhUci6
X-Gm-Message-State: AOJu0YwNZ9HIEi66M2zbiZQPvGW8Y5SweI0WnMOSp3KBxEyXp3MiddG9
	LRZdYFieBVIH/0ioSW0wGNFPFIQkBBwIKSXpoiU8XgcqzL1W0+GzMMviK6nAJ/Nvbnw3vPJqpJ6
	LkBju+jBbERG5Vlg372OcRe959nqga0twbcbWgei/gmJopEtKwdCyiBhpef8+7g==
X-Received: by 2002:a19:381a:0:b0:513:9d6b:6d6d with SMTP id f26-20020a19381a000000b005139d6b6d6dmr1254309lfa.5.1714128042263;
        Fri, 26 Apr 2024 03:40:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuMVPvU3AKlyxbmtdx61atPVTT03VJVj3i1e6gYHBAAAg6x/5RnpVB8vzz4nCZ1LgHEthkpg==
X-Received: by 2002:a19:381a:0:b0:513:9d6b:6d6d with SMTP id f26-20020a19381a000000b005139d6b6d6dmr1254291lfa.5.1714128041789;
        Fri, 26 Apr 2024 03:40:41 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id l25-20020adfa399000000b0034c59263c80sm1148469wrb.89.2024.04.26.03.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:40:41 -0700 (PDT)
Message-ID: <869b3dbb8f5c80ead202c6db3ebc61c0007ee5e1.camel@redhat.com>
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 26 Apr 2024 12:40:39 +0200
In-Reply-To: <9350b6f7-abd8-45c5-931a-62f48a50bee4@nbd.name>
References: <20240426065143.4667-1-nbd@nbd.name>
	 <20240426065143.4667-3-nbd@nbd.name>
	 <5a95fea4156b492eb19124bb33b21be81766c617.camel@redhat.com>
	 <9350b6f7-abd8-45c5-931a-62f48a50bee4@nbd.name>
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

On Fri, 2024-04-26 at 11:39 +0200, Felix Fietkau wrote:
> On 26.04.24 10:28, Paolo Abeni wrote:
> > On Fri, 2024-04-26 at 08:51 +0200, Felix Fietkau wrote:
> > > Preparation for adding TCP fraglist GRO support. It expects packets t=
o be
> > > combined in a similar way as UDP fraglist GSO packets.
> > > For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
> > >=20
> > > Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > > ---
> > >  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++=
++
> > >  net/ipv6/tcpv6_offload.c |  3 ++
> > >  2 files changed, 68 insertions(+)
> > >=20
> > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > index fab0973f995b..c493e95e09a5 100644
> > > --- a/net/ipv4/tcp_offload.c
> > > +++ b/net/ipv4/tcp_offload.c
> > > @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, un=
signed int ts_seq,
> > >  	}
> > >  }
> > > =20
> > > +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> > > +				     __be32 *oldip, __be32 *newip,
> > > +				     __be16 *oldport, __be16 *newport)
> > > +{
> > > +	struct tcphdr *th;
> > > +	struct iphdr *iph;
> > > +
> > > +	if (*oldip =3D=3D *newip && *oldport =3D=3D *newport)
> > > +		return;
> > > +
> > > +	th =3D tcp_hdr(seg);
> > > +	iph =3D ip_hdr(seg);
> > > +
> > > +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> > > +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false=
);
> > > +	*oldport =3D *newport;
> > > +
> > > +	csum_replace4(&iph->check, *oldip, *newip);
> > > +	*oldip =3D *newip;
> > > +}
> > > +
> > > +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff =
*segs)
> > > +{
> > > +	struct sk_buff *seg;
> > > +	struct tcphdr *th, *th2;
> > > +	struct iphdr *iph, *iph2;
> > > +
> > > +	seg =3D segs;
> > > +	th =3D tcp_hdr(seg);
> > > +	iph =3D ip_hdr(seg);
> > > +	th2 =3D tcp_hdr(seg->next);
> > > +	iph2 =3D ip_hdr(seg->next);
> > > +
> > > +	if (!(*(u32 *)&th->source ^ *(u32 *)&th2->source) &&
> > > +	    iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->saddr)
> > > +		return segs;
> >=20
> > As mentioned in previous revisions, I think a problem with this
> > approach is that the stack could make other changes to the TCP header
> > after the GRO stage, that are unnoticed here and could cause csum
> > corruption, if the egress device does not recompute the packet csum.
>=20
> On segmentation, each packet keeps its original TCP header and csum. If=
=20
> the stack makes changes, they apply to the first packet only. I don't=20
> see how we could get csum corruption.

You are right. I did not take in account that such changes (to the
first skb) are not reflected to the frag_list at segmentation time. The
end result could be different from what the user/admin is expecting,
but at least should not impact drops.

Side note: alike UDP, this is not supporting IPv6 NAT...

Thanks,

Paolo


