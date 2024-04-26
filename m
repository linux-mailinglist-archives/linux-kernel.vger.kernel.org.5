Return-Path: <linux-kernel+bounces-159657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522F38B31A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FC6283CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3115C13C8F1;
	Fri, 26 Apr 2024 07:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4WXJPV8s"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D798913C3E1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117664; cv=none; b=bh5rrYiLPskm5vcjwI6kw8THJE4BANT4fXpXUMAQuz5jIUqNUN4MT3M57ach00E76UP+U0Si/m//BAXmIMl2jwjsTF0b9EQfCpdCS2jxUKst6WslFEDhrgcajVetRHuXS9a1B+xeWIMuSxXYKsO0jd6UMvKdQAdcVubYMJHd9VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117664; c=relaxed/simple;
	bh=8mSG1fMDjDDohnUwndjQ8rYQ+klC8a+dxukU+MstjXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0jrNiI16nUYJEjjikABEXQHkxWMwphS3P1nNE8XRkths73XC/xGa6s3nTcEofXjHmI5Kx8KvFPHJ+McQeAFbAniFTOFXEZoZZMV9xOH/KNQAuuRwPZG+RlMSEzS+vxbAE0U2cqvRIB7mS680ae5T+YWgTQUvnzLalOBNxChkJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4WXJPV8s; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so9336a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714117661; x=1714722461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIAWLJTmoesX+sQpDbnk16DWBHfM7w6XqP7pg4sMby0=;
        b=4WXJPV8sWXMKohoA1wfiejyL3+/UMfZu9mfnjUhDbeb5VQHC9AAtUHb+aPVswJwNPO
         4azTi7OljRQM40vIO/AwaEnekTFnJAFVgcaKHLe2YH+LUa7TNintT+Zvk7seZ7bf12ao
         iLrhWNBrNw11JV2E2xXgeWaNwKhlAn/w3WjXBI8F2qiyNMLQ0iC3xloozwnEQgGiwkf5
         7CRiNlHMi7mF9REpOhgvy0jHJ/RoqoZm69Xooht0LMkENWLM+VzjeQarS/OB5n8h17XJ
         XWeECDkaqPZj6vFsaET4P3+s5/Ndoc1J7zsx9K2gZtfPTQZk1ZkJLztTa5Ns2HNJeM5P
         IRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117661; x=1714722461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIAWLJTmoesX+sQpDbnk16DWBHfM7w6XqP7pg4sMby0=;
        b=IAVl/93IepC/+3gFnHI3SE0bCIeiUIBEEYW0jdM6UoeF8iH0Lvi8Yzzrt1XhzxbvzV
         Uh89aIfApw4hRAtLWefhiLHG8d/BIDWJtFx84r0XIfcLapCyjS+n9tdnDr3goeiGiSWJ
         rr2cId/4YwR6HNacxisJD3Yd6x7PyyLmMOSNlIk9rzqHiF4ABlQpmMMEM24p3XpCXCAI
         NIFZWUZwd1HOUwWAv06fVtJGZbwvcGsyuDAPkgF5WnQuMbrgf2+Bb/Ai3sHWUq7lQHJh
         lm0U3MonfY5PsF5TM01p2j3Dsx/LrQYC26uEb/JIhxNYEYGQNd+OD0CWGhTC8RzSnX78
         V31Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZNsaD5jqTA1kZDgmJHe7jGJEmN47G6z0TS07qvoGaKIJQ1+BbFOntsG8Ed/CCVVszou2QBvgrAR84zajGzszA31zXRIaONuujsMVD
X-Gm-Message-State: AOJu0YzRzTRp6nG0ZAq+8dJTgAUcfYRcEn7YAhPr6K1dirGMsrGEGXht
	pVK2GRitt5NNcHdJ+gHoK9+jwAkspi8IR8ngp3AbiErZq7+ZTGSTEqbr1FIFNOY8foz4CNJCelv
	QJDmSkvx6E/2z5Qy42996zRf3V/0jEhx1jhxz
X-Google-Smtp-Source: AGHT+IFLQr0sMyzpOSJIY4p9nJ8GQ5UqSgfsVWNy79rCWkQWJ+N3qUGVbAAzCKpzk3SQnvP5E/G4ifq2QAYKBlWFbus=
X-Received: by 2002:a05:6402:309a:b0:572:554b:ec4f with SMTP id
 de26-20020a056402309a00b00572554bec4fmr54744edb.3.1714117660971; Fri, 26 Apr
 2024 00:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-4-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-4-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:47:30 +0200
Message-ID: <CANn89iL-4CB3-+mMtBQapXV7EaCzOWOU1MRp4X1tUtjaXfbk=Q@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 3/6] net: add code for TCP fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index c493e95e09a5..ffd6b7a4163a 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -332,6 +332,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>         flush |=3D (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>         flush |=3D skb_cmp_decrypted(p, skb);
>
> +       if (NAPI_GRO_CB(p)->is_flist) {


Please add unlikely() for all NAPI_GRO_CB(p)->is_flist checks added in
this patch.

> +               flush |=3D (__force int)(flags ^ tcp_flag_word(th2));
> +               flush |=3D skb->ip_summed !=3D p->ip_summed;
> +               flush |=3D skb->csum_level !=3D p->csum_level;
> +               flush |=3D !pskb_may_pull(skb, skb_gro_offset(skb));
> +               flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
> +
> +               if (flush || skb_gro_receive_list(p, skb))
> +                       mss =3D 1;
> +
> +               goto out_check_final;
> +       }
> +
>         if (flush || skb_gro_receive(p, skb)) {
>                 mss =3D 1;
>                 goto out_check_final;
> @@ -398,6 +411,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct=
 sk_buff *skb, int thoff)
>         const struct iphdr *iph =3D ip_hdr(skb);
>         struct tcphdr *th =3D tcp_hdr(skb);
>
> +       if (NAPI_GRO_CB(skb)->is_flist) {
> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_FRAGLIST | SKB_GSO=
_TCPV4;
> +               skb_shinfo(skb)->gso_segs =3D NAPI_GRO_CB(skb)->count;
> +
> +               __skb_incr_checksum_unnecessary(skb);
> +
> +               return 0;
> +       }
> +
>         th->check =3D ~tcp_v4_check(skb->len - thoff, iph->saddr,
>                                   iph->daddr, 0);
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index b3b8e1f6b92a..c97d55cf036f 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -32,6 +32,15 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct s=
k_buff *skb, int thoff)
>         const struct ipv6hdr *iph =3D ipv6_hdr(skb);
>         struct tcphdr *th =3D tcp_hdr(skb);
>
> +       if (NAPI_GRO_CB(skb)->is_flist) {
> +               skb_shinfo(skb)->gso_type |=3D SKB_GSO_FRAGLIST | SKB_GSO=
_TCPV6;
> +               skb_shinfo(skb)->gso_segs =3D NAPI_GRO_CB(skb)->count;
> +
> +               __skb_incr_checksum_unnecessary(skb);
> +
> +               return 0;
> +       }
> +
>         th->check =3D ~tcp_v6_check(skb->len - thoff, &iph->saddr,
>                                   &iph->daddr, 0);
>         skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCPV6;
> --
> 2.44.0
>

