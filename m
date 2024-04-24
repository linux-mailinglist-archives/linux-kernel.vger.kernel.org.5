Return-Path: <linux-kernel+bounces-157526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D420E8B125D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FED41F245C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A317279E;
	Wed, 24 Apr 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qa/fXVu5"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE616EBFF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983012; cv=none; b=QY9z7E1IP4EF77U9/GSr0meCNyKMwh14RsmrsUMclpHuWHt5w9/tWQsnZ5yLFPCJc8TUKPd7m44xA2NVSVmlOd/7eAOQKrH8IUHeCWIMF9uHmhNLIc2t9aC8wx0YHEe2CcARb8IdVorwRsR0ugUndd9FuhaweCVb9sbKIEh155o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983012; c=relaxed/simple;
	bh=OW6K79LTwyn9Oh4Z2zu66keXdk6bie9FWxJ2hFH7idk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMjCrwCC8YP178nUy1ZfgFSC6F7p6x3GbzIFeH7GPc7pJMcOSoPVHByJS6ITa0gJlHB00cLjzCaY6Ul4XLDQi56z/C3C6O2ijwO6Bbfa5Z48amBGQndKAYEFRG48yCVb/BPyVHw6Z+mGyOkck3xckCBtFyiKzuQuQKXk8WBVK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qa/fXVu5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so2422a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713983009; x=1714587809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUR7q0/1SIHPCudA3r8n/GS4qjmEqShPz422ck3ZFsQ=;
        b=qa/fXVu5gXt4wNkFPfl2QZ5QBmlQkuTB/+wpraskj1QZ9Yj5yTt2oz3nxbvMPiknJa
         ttoOZmWF7y32hJAt0K9ul7WC9cwwnZxL0zXiqz9S7+G1jzMqXad8J2vZeufMcOEEhA0S
         s2v6MPsY/fnVZL7dQimbLD+lCRhSY6g106v8ZYu6CMeIxi/9V37dG9IDrUoIYS2IoO14
         UXLH8iHO1gtDmLmAm+ETBVnhwzbAVJmVf09I1WtP/YE9YZLDxOo4OCb1MeSyM1kPd9bF
         WwEA9Wl4+RuFMQ9d8LLfwPKxaTh+ACMRptQ2UapiPnvmbfTXeeWCGBVowrV0qRNGqHRy
         0Xkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983009; x=1714587809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUR7q0/1SIHPCudA3r8n/GS4qjmEqShPz422ck3ZFsQ=;
        b=E9u4ldOK5fOobp4vEIdEW8J3o7rjhkCkU76PYMGDbuZl+RmGJjT6BXdpQEPfQB8sg9
         INzwK4sIA4Q6yi9ZfFy9MHxly9Dh/7g/O4ph/ijvIx/yNkWfrw9bHAFtTCUVnaavTY6U
         hmColyjjwbYnlSSwWufIUiIAcxKftufUSCADqKFQyh5823uZoYKq6ceAfDhSump6lhSg
         zMdsdSiAlyTo1O8VN5cef03+/Qp83pxWSv0o23MhG/mnNYFnbQ0seCpBLDk+O7mH6MuT
         Lm5uxCRK1ayW7Xw1ko3SvRSsF7Crw92D61ayhUCryAqiouxCzhgNkp9CyIN8JLuqo4AG
         kOMw==
X-Forwarded-Encrypted: i=1; AJvYcCVgQrBiCQpLzqyOltxLErW2sNMvFWNVaSmI2UyUl/579We9xeOvJSqri1JeXRX3zipHPYdiRxvvfA1fLejX7ngepJH/O49TNoOx7mzK
X-Gm-Message-State: AOJu0YwAsRj+tU4S2Vtv9Gs5urOI4D1TS/UtK2wyPPkZJs2s9ndFaS+7
	Iw2mYanubsTpMExPpb55bt0coPvelZ+SuB73BSisb5nMeHrzIngGu4LlVUsrydPENCnjqud4ziC
	BTdZN8IVaPaw0u5MU4SnT5p4PHZcJjgcOQqkN
X-Google-Smtp-Source: AGHT+IEjqJGW4k3GY74vFUxHtSdyRkdPWxbHnE82tGNfR/UBj+oUw2la1kTSF97etRl9JLWRdY4muBrMIspw9d3xkbc=
X-Received: by 2002:a50:ff07:0:b0:571:b2c2:5c3e with SMTP id
 a7-20020a50ff07000000b00571b2c25c3emr12634edu.1.1713983008810; Wed, 24 Apr
 2024 11:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424180458.56211-1-nbd@nbd.name> <20240424180458.56211-5-nbd@nbd.name>
In-Reply-To: <20240424180458.56211-5-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Apr 2024 20:23:17 +0200
Message-ID: <CANn89iL39fo99P-mfiwR6jnMdw4do-tkyb=qxOQJLPtnB8cZvA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: add heuristic for enabling TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:05=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>
> Signe-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 45 ++++++++++++++++++++++++++++++++++++++-
>  net/ipv6/tcpv6_offload.c | 46 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 89 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 6294e7a5c099..f987e2d8423a 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -404,6 +404,49 @@ void tcp_gro_complete(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(tcp_gro_complete);
>
> +static bool tcp4_check_fraglist_gro(struct sk_buff *skb)
> +{
> +       const struct iphdr *iph =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);
> +       unsigned int off, hlen, thlen;
> +       struct tcphdr *th;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return false;
> +
> +       inet_get_iif_sdif(skb, &iif, &sdif);
> +
> +       off =3D skb_gro_offset(skb);
> +       hlen =3D off + sizeof(*th);
> +       th =3D skb_gro_header(skb, hlen, off);
> +       if (unlikely(!th))
> +               return false;
> +
> +       thlen =3D th->doff * 4;
> +       if (thlen < sizeof(*th))
> +               return false;
> +
> +       hlen =3D off + thlen;
> +       if (!skb_gro_may_pull(skb, hlen)) {
> +               th =3D skb_gro_header_slow(skb, hlen, off);
> +               if (unlikely(!th))
> +                       return false;
> +       }
> +
> +       sk =3D __inet_lookup_established(net, net->ipv4.tcp_death_row.has=
hinfo,
> +                                      iph->saddr, th->source,
> +                                      iph->daddr, ntohs(th->dest),
> +                                      iif, sdif);

Presumably all this could be done only for the first skb/segment of a GRO t=
rain.

We could store the fraglist in a single bit in NAPI_GRO_CB(skb) ?

GRO does a full tuple evaluation, we can trust it.

