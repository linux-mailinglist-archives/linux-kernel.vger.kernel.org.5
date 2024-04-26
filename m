Return-Path: <linux-kernel+bounces-159635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1442B8B3160
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9A8284FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493513C3D9;
	Fri, 26 Apr 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HJSTZU7j"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA413BC2B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116745; cv=none; b=TD6Dh9h9Gl/YTujHq9mjC2TeMhXSlOarQv3gs0gQ21LwhpVfMRDfDCTO4j/rxqIBKlavhJlDU8qftzPc4EYZCGY3ZxGAiKZeQf930NFiqurA0NVcQvMl/RAVSNnRDTYhIuAwJL1pdyfSUYJr02AZgg71WWOo4BkjOknU1l4Hi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116745; c=relaxed/simple;
	bh=huZdh8GW0EXWSaQhXBQtDCOGAUHcTkfS3ydWBvzJTfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvJJBJPez4I0UTFtFnILukevHnLpNYsDpVA9hDYF/K45+r6f9+ZlnNd24Nlws15dzy7uvdZJTuximD1PrwjBddkKBcp5SyE4jNRkRAygI7K7x8Vzl7dPKOFEeDbBS5ck21b2L7cV0EsZ4rJyWXob2V6YmxcCOGEVowLU7AuAwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HJSTZU7j; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5110a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116742; x=1714721542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55aGktq7fs+SXar6JRKvBBqXiEBqzDHYlydi7Q0XdwU=;
        b=HJSTZU7j+4tZ/XgJccHtoLutXeJL0szwCVMk0kOv5/nyKUPJzzW0dw+V1WX0hVng9h
         FM5aX2LcP5SbLPpS1oeH+KtpuYNgIPi1CZkCIsZoeeLqZTkjKh159YqmOl2G4C87WU2a
         qqukPDrzrTkgD8UDpBtFqi1CE6y3SmE05k/rdbH3R+sjGKSwdwh88i9q8rhFDdw9+ymB
         KIJFtVY85ECnRtQ+0L3xK8KzcezYiJZbBGFE9xJWmpPJA+GCXkmpi0A+5LQP3uLMl92y
         G1UjxgaWTqTuzjgX6vOnKFshhqdYASpNPvjeHpEj/SIyrbhs2OO7unZqX/KouOkJRU8N
         ZedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116742; x=1714721542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55aGktq7fs+SXar6JRKvBBqXiEBqzDHYlydi7Q0XdwU=;
        b=HLoRJ5XsAYLDoySAmRqwcjKcb+3UwqciyoRFRf2PZZeFhqG7BjuA8nU8WgTErvJN6/
         bvn5fimnjZBJheYFwaI/F0StYp99H1y3PiParZ7NUU+wA40HPNm0z4iBcQFCsk+4fszA
         uLz7uC7QZaWUR6pvU+sjZzc84lUZJCmTKiqhBY+ufUoZys5Ounlx9KQezjKpM0YxN7ze
         tl6Wmz9VIj6wyuHVz5zuWDIayXvhC7yoaUoF1IGiM4Pfit1yaHLWte1Y4dZsuD5BrzDs
         ERr2Nce1tBKk56iSgxjyDZvJvvowXhNOu6Hkzi0T0QGueK+U3cpd9r6cju84VHeUePAK
         3aZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKyY/LcV6CdNkVd+VsvnoymZLuHKAxjxDfv1v1+1/2otlyYJE9ZFKNHPs98XbdmzNZoLo5xlN+esr0MOCpuVH30gYTnzuQrxtYTKOI
X-Gm-Message-State: AOJu0YyF/BOKqy99UgOErHazMCjJ7YowpKV+lvBMMASaNjlG3UPKW9o3
	sb9coLXb2dGrBbFfKrJJyxMW6BV/I7v72LhU3HZg+naPemFs37rq1G+araMnf0dx3e5QSILjsjD
	cbIBGE2ARb8dREcUAAaJQdsSPZfFxhM7DQCHO
X-Google-Smtp-Source: AGHT+IEmW9ouiJCqwPAVRnOSQEoBVj2s2LXB1190cNP9r+cvXOG1N7u66gEYNrtBxCX5nVZ0R/5anNWPcQRBeuT7d1k=
X-Received: by 2002:a05:6402:2285:b0:570:49e3:60a8 with SMTP id
 cw5-20020a056402228500b0057049e360a8mr70016edb.7.1714116742251; Fri, 26 Apr
 2024 00:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-7-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-7-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:32:11 +0200
Message-ID: <CANn89i+n76MEoQPbj8oxMMEw5N6T8KAP4Xp2YsUYb32fUzAJNg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 6/6] net: add heuristic for enabling TCP
 fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
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
>  net/ipv4/tcp_offload.c   | 30 ++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index ee5403760775..2ae83f4394dc 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -406,6 +406,34 @@ void tcp_gro_complete(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(tcp_gro_complete);
>
> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb,
> +                                   struct tcphdr *th)
> +{
> +       const struct iphdr *iph =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);

Could you defer the initializations of iph and net after the
NETIF_F_GRO_FRAGLIST check ?

dev_net() has an implicit READ_ONCE() ...

> +       struct sk_buff *p;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet_lookup_established(net, net->ipv4.tcp_death_row.has=
hinfo,
> +                                      iph->saddr, th->source,
> +                                      iph->daddr, ntohs(th->dest),
> +                                      iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -421,6 +449,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>         if (!th)
>                 goto flush;
>
> +       tcp4_check_fraglist_gro(head, skb, th);
> +
>         return tcp_gro_receive(head, skb, th);
>
>  flush:
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index c01ace2e9ff0..1ab45cca3936 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -7,12 +7,43 @@
>   */
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/skbuff.h>
> +#include <net/inet6_hashtables.h>
>  #include <net/gro.h>
>  #include <net/protocol.h>
>  #include <net/tcp.h>
>  #include <net/ip6_checksum.h>
>  #include "ip6_offload.h"
>
> +static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb,
> +                                   struct tcphdr *th)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +       const struct ipv6hdr *hdr =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);

Same remark here.

> +       struct sk_buff *p;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet6_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet6_lookup_established(net, net->ipv4.tcp_death_row.ha=
shinfo,
> +                                       &hdr->saddr, th->source,
> +                                       &hdr->daddr, ntohs(th->dest),
> +                                       iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -28,6 +59,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head=
, struct sk_buff *skb)
>         if (!th)
>                 goto flush;
>
> +       tcp6_check_fraglist_gro(head, skb, th);
> +
>         return tcp_gro_receive(head, skb, th);
>
>  flush:
> --
> 2.44.0
>

