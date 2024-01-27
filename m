Return-Path: <linux-kernel+bounces-41115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61883EC0E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F45B22B67
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43AE1E888;
	Sat, 27 Jan 2024 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l33AMTZv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D74B66C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706344497; cv=none; b=HiYjE38Sa6vpzQWwucV7RzN2J18bVZuljywRVMoWWBt0h+US99W82Eno6a7dRUIZMqyUZfLyu1E19E8X8dKVWS+2h9L2zxme96aVlgd+Y+F/w3xeCRB5JlJueNadrhbU5wxbXgh8HslmZsx7sAWkbYFafBHQ7kbUEvpqUe3M2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706344497; c=relaxed/simple;
	bh=YhYYFMhnowTbbuX5rz69qv/M8AQK9VQhBzVq0JwlygA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPEMzHmIe38tcoHQyXxiobPPvWpRERSBSi+IywarNspYhNutSgaLZOk9oSRpC91Y+GITx3SQ7pKg38PkHmt13Dq2IAXqt1nphGV/w+5DkGjj/wGKbRY/TKlLcn0bU0IsgV0OfkEN20hIhxVl/nf+fHHE9HHTWeKq0yS6afAsqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l33AMTZv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so23545e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706344494; x=1706949294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ax1AbFa1G9ibq+UxnRv4ud0AHrSaEuEaK3VswH1DhqM=;
        b=l33AMTZv2N37ygBQXSZ0qJdKqsLZxu/YsggFiLlNByvBRHCJEcSjT4wnfwY1RW/KZr
         NsNYOCViPQdXGLnbuxRt3V/oOLhYZwv6J5CISy25XEhSawkRs1cqraOQnQM2KOQPsASq
         7re9dCeSa8ynnYIoL1d3wQiSwTr+VJzmbyNG2FGJjVbh8/KqNIJvbPQ1SeZikc16DDLg
         N33kfG4loFDmRuZIGiVj8MmBmPpviZBl1xal8nP1tokZRnnTXhjPc8oJGECZGZSkz1/L
         2Cv2Veo86tix41kCALRRKPKJ9xSqS0Dvyq5yALDuRF7OH3R1u56oDe/9ITT6d47QlJWl
         dd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706344494; x=1706949294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ax1AbFa1G9ibq+UxnRv4ud0AHrSaEuEaK3VswH1DhqM=;
        b=c3SQUm0dq7Uv5Qj8cQKj1zKTIAGfiP3ExMQ4CXLsgdzPiJSWUgO9BkfgEnwMfrqAuQ
         ZJEbwBj+o/SWlrk4s6/ESZN77o/DZt3/n0TVnTl/Zyj5J8xmJ3yfdWhSYZIR0Vt3rMOe
         R1wy2oDiHsMDQ7gRZkCpckRS3W2AYvXTiucJfijO5Ot9P+H8MOe840Fz0pchTywa7Ivr
         6PteLO3b7DnTGGB0RVIAOsXiD+iPf0hZtYXs9zi+giMYbJ+rCqwjfBqxxLlhAx8fFGS+
         IFSjOsFf3q5038ycXBEJzsMajDjZiWIBY/aw+DfPCvIn+xThb4agSe9jiu1i4zd747nm
         l/aA==
X-Gm-Message-State: AOJu0YxRtNllAbfE1UJy/+xfYnmEB+o4j1sjzocYo6bCo4r4EQLWC1XS
	Y+Rm1yMn1m/APF2/M2RRX33ueIepX9FmiiUZm9+9/owJkvcw75Hp1DeFYSLhMcYXz/uA9se1DjF
	e87GxtFFtecFS2on8E3B7BndYa3jBlhNrMzkV
X-Google-Smtp-Source: AGHT+IE75zSW/Rhs1QgAL7VROnqq4Lv+uAOUij8+AACC5vqdr+QQg/pDOeSbn28a5PQjrCE6O05IB0aWWvEn/ZkIdGs=
X-Received: by 2002:a05:600c:510f:b0:40d:87df:92ca with SMTP id
 o15-20020a05600c510f00b0040d87df92camr275914wms.3.1706344493527; Sat, 27 Jan
 2024 00:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126075127.2825068-1-alexious@zju.edu.cn> <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
In-Reply-To: <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 27 Jan 2024 09:34:42 +0100
Message-ID: <CANn89i+3Maf90HUzaGzFQgw9UQDoZLP-Ob+KrE9Ns6jND=6D9w@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Jan 26, 2024 at 8:51=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> =
wrote:
> >
> > When inetdev_valid_mtu fails, cork->opt should be freed if it is
> > allocated in ip_setup_cork. Otherwise there could be a memleak.
> >
> > Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> > Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> > ---
> >  net/ipv4/ip_output.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > index b06f678b03a1..3215ea07d398 100644
> > --- a/net/ipv4/ip_output.c
> > +++ b/net/ipv4/ip_output.c
> > @@ -1282,6 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct =
inet_cork *cork,
> >  {
> >         struct ip_options_rcu *opt;
> >         struct rtable *rt;
> > +       int free_opt =3D 0;
> >
> >         rt =3D *rtp;
> >         if (unlikely(!rt))
> > @@ -1297,6 +1298,7 @@ static int ip_setup_cork(struct sock *sk, struct =
inet_cork *cork,
> >                                             sk->sk_allocation);
> >                         if (unlikely(!cork->opt))
> >                                 return -ENOBUFS;
> > +                       free_opt =3D 1;
> >                 }
> >                 memcpy(cork->opt, &opt->opt, sizeof(struct ip_options) =
+ opt->opt.optlen);
> >                 cork->flags |=3D IPCORK_OPT;
> > @@ -1306,8 +1308,13 @@ static int ip_setup_cork(struct sock *sk, struct=
 inet_cork *cork,
> >         cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> >                          dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu=
);
> >
> > -       if (!inetdev_valid_mtu(cork->fragsize))
> > +       if (!inetdev_valid_mtu(cork->fragsize)) {
> > +               if (opt && free_opt) {
> > +                       kfree(cork->opt);
> > +                       cork->opt =3D NULL;
> > +               }
> >                 return -ENETUNREACH;
> > +       }
> >
> >         cork->gso_size =3D ipc->gso_size;
> >
> > --
> > 2.34.1
> >
>
> What about something simpler like :
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b06f678b03a19b806fd14764a4caad60caf02919..41537d18eecfd6e1163aacc35=
e047c22468e04e6
> 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1287,6 +1287,12 @@ static int ip_setup_cork(struct sock *sk,
> struct inet_cork *cork,
>         if (unlikely(!rt))
>                 return -EFAULT;
>
> +       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> +                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
> +
> +       if (!inetdev_valid_mtu(cork->fragsize))
> +               return -ENETUNREACH;
> +
>         /*
>          * setup for corking.
>          */
> @@ -1303,12 +1309,6 @@ static int ip_setup_cork(struct sock *sk,
> struct inet_cork *cork,
>                 cork->addr =3D ipc->addr;
>         }
>
> -       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
> -                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
> -
> -       if (!inetdev_valid_mtu(cork->fragsize))
> -               return -ENETUNREACH;
> -
>         cork->gso_size =3D ipc->gso_size;
>
>         cork->dst =3D &rt->dst;

Hi Zhipeng Lu

Could you send a V2 off your patch ? I will then add a Reviewed-by:
tag, thanks !

