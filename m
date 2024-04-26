Return-Path: <linux-kernel+bounces-159655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEC8B31A2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B4228A72C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F513C8FB;
	Fri, 26 Apr 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oawk07lh"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F513C3EC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714117497; cv=none; b=hh+x3pkuc3bcJxYbn+hnpzNc7R2v8De6+Q9kHDubvDUVZgaq9avxH7EB/KXJ4hA1XEIW0fXU9GqLg3FBWPASer2lCmXSnvHTxxE7tZAGM9nqC1q6r8DbWFb4Ztu7+WpW4hL8i0g0FmRcPNmtwqXIgd9E6AVtqRZBAUeuY9JblwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714117497; c=relaxed/simple;
	bh=IAy3KSdWgKQ5Dy6jkMVe3ewR5lCzfv6BECAXxzU/b10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbP+ZyShh1bmXbO59/3ApYx1RIUgTPJ42LjXTbmuOgRKv0XMv7iLcW0uy4nhbdIolkmLkzAPZ0h/6roFXMIrSX2zB35WMMvsqey4NXAOQIg5eP61O/vjpKdu/KfY2VwtrJhIUhOkhW4OqllhlulxtlUFzzIfp7vEVu1bLMHwjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oawk07lh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5191a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714117493; x=1714722293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A33BurzJz4OQByTITh6Ot1PgPb3FP3Ow3zWOTt8U/FQ=;
        b=oawk07lhJBcKEp94xHEuT4kwtNRyk0fJ6jXQFmX8JTGtEEyc7zahwKQtM/GDNtSbIG
         20DdU4UHCMpnTh1Vo4rSdKKs/2tg/iy0bjN1sfn7gkM+BHPJ0sX8XRdDIR/Q9I36g/R4
         ryJVNu3Sk7JS4fB+FTlwJDi9VmTQ643IAMft3uJHrr9CFZFj1xFb9bxR2Bj1PfuMjyO9
         o5DF/Le5mOmd4PImviZJzV6cTQCMPILS+DHAeRMSR5Yg0kET7UboBOHkkLJVnBaPEK42
         4+mElj8jGyEZ42+pvJf5pQ892CRFDX7mOOX6Ss+B0sA7TPQNs4yLijQde8x/wevZfzqS
         GnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714117493; x=1714722293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A33BurzJz4OQByTITh6Ot1PgPb3FP3Ow3zWOTt8U/FQ=;
        b=TIC6T0uRpB12Xvq4iosc2QBG11JKNLIG6a2aViVNzaNSau7nPVkDng05I7+4hQn9pW
         mrSgz143+Wg5sBULLMhAtSgW/t29HBGh51xIar6w0l39TjVeCNOQUbrpMxTJOUCAbTG7
         7FD4UUJE8lafbstZl9Tx4EVudyXjMI3i7eNdDUsxOH/jCCE/TENFUEH49kdTyg1RJSVy
         WPhJeDNyzQYuV2va/d5ZbIMl5I3XWed9HTJTD8YiNumC8F0WEJH0Ta9j20qvjNOMaJiy
         uF3lGoYUnUvflZsQlfOeXHv3HBoF2RgpH7Db+3gmaph12FZaeHcUvujFkUQBlTKif4lT
         UDSA==
X-Forwarded-Encrypted: i=1; AJvYcCVwOsdywhjRSbmRlvyhu4uuYJ3ttvZNGdsvG3OSBZR+CyJu80d4Z0j/uqn/ew2dhkXXMqdxzZcDa9LxNpa8noo8Zpa35TdjPljI7zsQ
X-Gm-Message-State: AOJu0YylBVKEc5rdUXmPtXRcSdraeMWOeciIRlJPv6uo3QvBipWTyBDe
	rZMdmqINduiN3qRiZYZOdkz3Pzi6KSXZUNs9ASq3/vk+QQX2o0Fij+vbGecczITuTOeKglFx+sw
	B8I7bcbYOXkROpeYna3XZov9AV47AFApVcM6O
X-Google-Smtp-Source: AGHT+IEk1uXUIDXCS1Qd6f2BzElPYf3TlvuOyrYn14Ix9f6DOldn8oT6ET0aMSrOaQ5UNNf8yUYn6CTwM5ZjbPhg3Ow=
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4516 with SMTP id
 x12-20020a05640226cc00b0057257d84516mr47477edd.2.1714117492798; Fri, 26 Apr
 2024 00:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-3-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-3-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:44:40 +0200
Message-ID: <CANn89iJKfgQNNXUL10-7aVZTn+ttqvVNZbnKi6jCdQGwzbFFYQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 2/6] net: add support for segmenting TCP
 fraglist GSO packets
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> For IPv4 packets, NAT is handled in the same way as UDP fraglist GSO.
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 65 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  3 ++
>  2 files changed, 68 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..c493e95e09a5 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,68 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsign=
ed int ts_seq,
>         }
>  }
>
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +                                    __be32 *oldip, __be32 *newip,
> +                                    __be16 *oldport, __be16 *newport)


Do we really need pointers for newip and newport ?

> +{
> +       struct tcphdr *th;
> +       struct iphdr *iph;
> +
> +       if (*oldip =3D=3D *newip && *oldport =3D=3D *newport)
> +               return;
> +
> +       th =3D tcp_hdr(seg);
> +       iph =3D ip_hdr(seg);
> +
> +       inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> +       inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, fal=
se);
> +       *oldport =3D *newport;
> +
> +       csum_replace4(&iph->check, *oldip, *newip);
> +       *oldip =3D *newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *seg=
s)
> +{
> +       struct sk_buff *seg;
> +       struct tcphdr *th, *th2;
> +       struct iphdr *iph, *iph2;

I would probably add a const qualifier to th and iph

> +
> +       seg =3D segs;
> +       th =3D tcp_hdr(seg);
> +       iph =3D ip_hdr(seg);
> +       th2 =3D tcp_hdr(seg->next);
> +       iph2 =3D ip_hdr(seg->next);
> +
> +       if (!(*(u32 *)&th->source ^ *(u32 *)&th2->source) &&


> +           iph->daddr =3D=3D iph2->daddr && iph->saddr =3D=3D iph2->sadd=
r)
> +               return segs;
> +
> +       while ((seg =3D seg->next)) {
> +               th2 =3D tcp_hdr(seg);
> +               iph2 =3D ip_hdr(seg);
> +
> +               __tcpv4_gso_segment_csum(seg,
> +                                        &iph2->saddr, &iph->saddr,
> +                                        &th2->source, &th->source);
> +               __tcpv4_gso_segment_csum(seg,
> +                                        &iph2->daddr, &iph->daddr,
> +                                        &th2->dest, &th->dest);
> +       }
> +
> +       return segs;
> +}
>

