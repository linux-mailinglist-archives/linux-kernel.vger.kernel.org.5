Return-Path: <linux-kernel+bounces-163838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDF8B7309
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F481C20B26
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C412DD84;
	Tue, 30 Apr 2024 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwRzUtj6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED28211C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475665; cv=none; b=nDD8baknKwTXwvqPehRXU4VbHYxgLEMPxbJEyl/HuccxgaiiIQsW4eQBh8S28UtKpnrPUXF7lnLr5f05DPBLIkeujQ/g3F36a77MlRLR0Rr9rO6wSnTXgVQLyDx8vecXaoa04dHO1PSc8XkTjROonVNkJttY+rinN8zM+Kw5de0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475665; c=relaxed/simple;
	bh=1v3iKbYRwkoqF4GswqbZSAc/O4twc8pg1X2WdcHj6nc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ochi7l9nWRGZXSKFRcPKc4u9j8OK8VSSX8j8MluG9uDW7wmMErO0UO7JCLaRGPlbnu2lgPcctIchS4iPOvBT2xmlEXawjf8y+VtSIX4zojXhQB+Gzj4xBQxsUA2nQ6LHtWATuLVUwHR3IsJua+sy0x5x6rWuoRQjwt8P6mwcO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwRzUtj6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714475662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZKlqsYerCfpJBU242kuBh82/O/c7RiKM2R2B8jV0WP8=;
	b=XwRzUtj63ckv1z3IsMaAJK8uuDiv9Tk298IvytjS/f3cF2aOEHjEMGv5CjFgGd6gDes2Ms
	sqXpPpnJfFylehyuNaXUCDj8GBI8LT+N07MKlcPhTTqtk329Gl9rtDuTxFTvhQ9xvLxiCN
	ojU81zFqUCXnyoFYBr+/yas/ig/dIcA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-9V-8a6TuN--pj2crQtJMXg-1; Tue, 30 Apr 2024 07:14:21 -0400
X-MC-Unique: 9V-8a6TuN--pj2crQtJMXg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d9627ffd0so66831f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475660; x=1715080460;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKlqsYerCfpJBU242kuBh82/O/c7RiKM2R2B8jV0WP8=;
        b=DKcVM5kDBSh6FoHaM2IpnBV6uyBPtddfLbwIozt4AbZ/qB7M9aF1turOpNy1tjxhx0
         hD+Zp5XCGWNNUueox9Y592KL4o6DJbsXPwV3XYu2FklSzdk+PWv9iT81yWCGPCXd1g1K
         EJirvD75pb9lZ2pqwU9mOF3tH9BfxTOoOAzjq3AUcU3yqDYZuNE/YN6yD63C60wuXRzI
         I77U8kCoWLor9jRdNXqWhfvCcpUbG3eBkk9HkPr0zgpfRf2jhbnegQfBL9n8q69pdqVw
         +G1fgqA6KsJuXbCiuHbPse3mxy/QFc2hfRHZIpmJEQScDqGvbgqCQHAAaWSHZMifIjdx
         bzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFZDiOmUfRswUTc35k3AAGPHb1QxNlXE6xogL/sAijY7Zlf4LVzLMG/MR7xd/n+bvKMZU/S6ouXiJkS9TofvkUUFsq4LTUrdT63GfA
X-Gm-Message-State: AOJu0Yz1xHT7UwQtnAcZtq5THVxR7H4ogSuYrNDrLutJtQQfQ+e4yIIo
	cKNcLBuFoWoXkAZpwZXsnyWLnNOrFO6InkmRphjtpJrG7N9v6xGMnPS+HmeBwcV2FSPbwY9zjAp
	xQ4l7hU4IF5ZGL2+X3HpF4cRqYgtIXstaI40Y2tj5HDeGAAsC+M247DX0Fv5iFQ==
X-Received: by 2002:a5d:42cb:0:b0:34d:8ccf:c9ce with SMTP id t11-20020a5d42cb000000b0034d8ccfc9cemr1046326wrr.5.1714475659999;
        Tue, 30 Apr 2024 04:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFGw/FQ4V7WgwOjQMrGJp7DK9lZTOj0lhUWJqhOwmJTT8pE4hscFbpaG6PtCgjwPrMgGRMyQ==
X-Received: by 2002:a5d:42cb:0:b0:34d:8ccf:c9ce with SMTP id t11-20020a5d42cb000000b0034d8ccfc9cemr1046311wrr.5.1714475659527;
        Tue, 30 Apr 2024 04:14:19 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0ae:6a10::f71])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4489000000b0034d9605eb70sm965095wrq.49.2024.04.30.04.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 04:14:19 -0700 (PDT)
Message-ID: <e598e9eee3827fd173e3cd6f525df133eb3b54ec.camel@redhat.com>
Subject: Re: [PATCH v4 net-next v4 6/6] net: add heuristic for enabling TCP
 fraglist GRO
From: Paolo Abeni <pabeni@redhat.com>
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Date: Tue, 30 Apr 2024 13:14:17 +0200
In-Reply-To: <63c1cb0e-bd63-43da-b451-5383bb4a0f5f@nbd.name>
References: <20240427182305.24461-1-nbd@nbd.name>
	 <20240427182305.24461-7-nbd@nbd.name>
	 <e590ba4608c9810d3d75fefdcbba9f2a02c23a0f.camel@redhat.com>
	 <e3a3a499-11b3-4906-b0f1-b94e70825ca9@nbd.name>
	 <18dee53b6ae7cd75196141e4c5d8984bc0f3296f.camel@redhat.com>
	 <63c1cb0e-bd63-43da-b451-5383bb4a0f5f@nbd.name>
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

On Tue, 2024-04-30 at 12:55 +0200, Felix Fietkau wrote:
> On 30.04.24 12:31, Paolo Abeni wrote:
> > On Tue, 2024-04-30 at 12:23 +0200, Felix Fietkau wrote:
> > > On 30.04.24 12:12, Paolo Abeni wrote:
> > > > On Sat, 2024-04-27 at 20:23 +0200, Felix Fietkau wrote:
> > > > > When forwarding TCP after GRO, software segmentation is very expe=
nsive,
> > > > > especially when the checksum needs to be recalculated.
> > > > > One case where that's currently unavoidable is when routing packe=
ts over
> > > > > PPPoE. Performance improves significantly when using fraglist GRO
> > > > > implemented in the same way as for UDP.
> > > > >=20
> > > > > When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an est=
ablished
> > > > > socket in the same netns as the receiving device. While this may =
not
> > > > > cover all relevant use cases in multi-netns configurations, it sh=
ould be
> > > > > good enough for most configurations that need this.
> > > > >=20
> > > > > Here's a measurement of running 2 TCP streams through a MediaTek =
MT7622
> > > > > device (2-core Cortex-A53), which runs NAT with flow offload enab=
led from
> > > > > one ethernet port to PPPoE on another ethernet port + cake qdisc =
set to
> > > > > 1Gbps.
> > > > >=20
> > > > > rx-gro-list off: 630 Mbit/s, CPU 35% idle
> > > > > rx-gro-list on:  770 Mbit/s, CPU 40% idle
> > > > >=20
> > > > > Signe-off-by: Felix Fietkau <nbd@nbd.name>
> > > > > ---
> > > > >  net/ipv4/tcp_offload.c   | 32 ++++++++++++++++++++++++++++++++
> > > > >  net/ipv6/tcpv6_offload.c | 35 ++++++++++++++++++++++++++++++++++=
+
> > > > >  2 files changed, 67 insertions(+)
> > > > >=20
> > > > > diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> > > > > index 87ae9808e260..3e9b8c6f9c8c 100644
> > > > > --- a/net/ipv4/tcp_offload.c
> > > > > +++ b/net/ipv4/tcp_offload.c
> > > > > @@ -407,6 +407,36 @@ void tcp_gro_complete(struct sk_buff *skb)
> > > > >  }
> > > > >  EXPORT_SYMBOL(tcp_gro_complete);
> > > > > =20
> > > > > +static void tcp4_check_fraglist_gro(struct list_head *head, stru=
ct sk_buff *skb,
> > > > > +				    struct tcphdr *th)
> > > > > +{
> > > > > +	const struct iphdr *iph;
> > > > > +	struct sk_buff *p;
> > > > > +	struct sock *sk;
> > > > > +	struct net *net;
> > > > > +	int iif, sdif;
> > > > > +
> > > > > +	if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> > > >=20
> > > > Should we add an 'unlikely()' here to pair with unlikely(is_flist) =
in
> > > > *gro_receive / *gro_complete?
> > > Not sure if unlikely() will make any difference here. I think it make=
s=20
> > > more sense in the other places than here.
> >=20
> > Why? AFAICS this will be called for every packet on the wire, exactly
> > as the code getting this annotation in patch 3/6.
>=20
> I had compared assembly after adding an annotation and didn't see a=20
> difference. However, my annotation was wrong.
> When I add: if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
> the generated code is different, and I probably should use that.

I read the above as you intend to send a new revision. If so, feel free
to add=20

Acked-by: Paolo Abeni <pabeni@redhat.com>

to the whole series.

Otherwise, please LMK, I think we can merge it as-is and ev. follow-up.

Thanks,

Paolo


