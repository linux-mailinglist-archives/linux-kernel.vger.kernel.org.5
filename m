Return-Path: <linux-kernel+bounces-39986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB883D823
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEED329745C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25CC1BF55;
	Fri, 26 Jan 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8fsvsP+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7F1BF4C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264042; cv=none; b=bIK0gnLfNw7/KFIx0jJXO6+RYIWdT4DvkObA/v1EdPS3PRvWAU5tktPB5vHgbB7RD1sv4yopAxjxCfzlMYBpGt3gnCArB/gF1thMKJJ3IG47VNN+bLxac18C0+SzSdsu1PbbvhYf8cvUXbPxL1qiL4Z1E/YljlnOTU7MrJSqGdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264042; c=relaxed/simple;
	bh=7+8Qzhe6mHmLH6kd72kk3HmiTh9u8aRtYsmoWmyDwg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1rjaj8ue7AsH6JG0gR6XNEO3m7lgG4Y2YIN7SogxmzGN5A+fJMQ8grH+Mz0W7A1jTB6VfvYGEAA0s6XMKyejN3hluNweYPndIxklPmPDyx2pX+R+L+c8esVKS1XRrvbTVVefcURTsUUNv+LXC0hQdrFz2I3KbJ4gR2pkW+gbmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8fsvsP+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55c89dbef80so1763a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706264038; x=1706868838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvqEquYt/bZVYH7bHyLPXtUBeFueS0MJ3q9sGV+6qNk=;
        b=h8fsvsP+DNZEQhBjjiK5YyLSJtW36Vk1mKjSpPhsEzPAGhrlM84PhrMJge7fgKcwQf
         XSNewCaIP6+EZ8LeZ76TI4dGPWdodqk9ez/6uNJyEO44+O758JASKHG3rHMTFrVWqanc
         nz+knJr9MxOkUFxcdKC3InK3mFGGNR1B6g9Unstkn1B/WVR9yY7tkv+6rle9SMo+y67Z
         HEqcDp3LwnPeuE3sDD+3CDe7bEpgEPTMTtKskupw4YTF4qBjviBjO+9LNNXz6QZhv/ij
         fMkIznQPaPEa5eOwGMfW7cZHfxX7sRmSI1y+A+uR2LXRCJtm+il+NsOIcUiurZxFuvi+
         +ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706264039; x=1706868839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BvqEquYt/bZVYH7bHyLPXtUBeFueS0MJ3q9sGV+6qNk=;
        b=v+b/iAnitQMzwZyjjoiaNwSidVEu4mFAiicCMR/wWwZ6+gfFrzLrKHl3uyAy//FV8D
         MqVjPR2cKlum1zrZPQFClNCt3w17GJT72Y/RcwJ19vr5XOnjzbY+1fCtsdH+9TFulTqu
         jT5XZjwvTX9DVW54cLDZDpMIYb67OhvZ5ItyEAbdLFSuEWHAs8GUpGUxp22wMefaqxO+
         nEuOyiGrFAtGJG7er7/AK2f6kEY8lqEoTl3Vt5yUn0BvM1KJYtJEko/yEbyBMr5FfOGT
         vaLPx1uCFwyLtZ9BDjBHWTSy6J6JEihAVTM0I/1Tm3GOMiRi3YNEkbS/OlMgw27qHi9r
         aWrQ==
X-Gm-Message-State: AOJu0YyHNiPuDL/VtGR1sfiqavQn6BA6CY7A0o2T+aY7e6sRb6dF7ap3
	CbIONx+dRVavouMFQhXUwH0L0KocIrelzdvWPY2o3uV+PuYCnyfxyr/4WJ8fqgNT3nAa6UvOBBE
	1TkiEBzMSPkw7iNsuIlEiGVLH5L1bHdHbtjk7
X-Google-Smtp-Source: AGHT+IEMEhpxf4J9tTeaGOXnw61oDRUQSFt9uZf+HhtkSJBGuheZqdh/y4uxkchX1z1aJT3Ly1bE9HhF0DZixf8sltw=
X-Received: by 2002:a05:6402:3092:b0:55c:2493:2b31 with SMTP id
 de18-20020a056402309200b0055c24932b31mr86268edb.3.1706264038379; Fri, 26 Jan
 2024 02:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126075127.2825068-1-alexious@zju.edu.cn>
In-Reply-To: <20240126075127.2825068-1-alexious@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Jan 2024 11:13:44 +0100
Message-ID: <CANn89iKvoZLHGbptM-9Q_m826Ae4PF9UTjuj6UMFsthZmEUjiw@mail.gmail.com>
Subject: Re: [PATCH] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:51=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> wr=
ote:
>
> When inetdev_valid_mtu fails, cork->opt should be freed if it is
> allocated in ip_setup_cork. Otherwise there could be a memleak.
>
> Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  net/ipv4/ip_output.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index b06f678b03a1..3215ea07d398 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1282,6 +1282,7 @@ static int ip_setup_cork(struct sock *sk, struct in=
et_cork *cork,
>  {
>         struct ip_options_rcu *opt;
>         struct rtable *rt;
> +       int free_opt =3D 0;
>
>         rt =3D *rtp;
>         if (unlikely(!rt))
> @@ -1297,6 +1298,7 @@ static int ip_setup_cork(struct sock *sk, struct in=
et_cork *cork,
>                                             sk->sk_allocation);
>                         if (unlikely(!cork->opt))
>                                 return -ENOBUFS;
> +                       free_opt =3D 1;
>                 }
>                 memcpy(cork->opt, &opt->opt, sizeof(struct ip_options) + =
opt->opt.optlen);
>                 cork->flags |=3D IPCORK_OPT;
> @@ -1306,8 +1308,13 @@ static int ip_setup_cork(struct sock *sk, struct i=
net_cork *cork,
>         cork->fragsize =3D ip_sk_use_pmtu(sk) ?
>                          dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
>
> -       if (!inetdev_valid_mtu(cork->fragsize))
> +       if (!inetdev_valid_mtu(cork->fragsize)) {
> +               if (opt && free_opt) {
> +                       kfree(cork->opt);
> +                       cork->opt =3D NULL;
> +               }
>                 return -ENETUNREACH;
> +       }
>
>         cork->gso_size =3D ipc->gso_size;
>
> --
> 2.34.1
>

What about something simpler like :

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b06f678b03a19b806fd14764a4caad60caf02919..41537d18eecfd6e1163aacc35e0=
47c22468e04e6
100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1287,6 +1287,12 @@ static int ip_setup_cork(struct sock *sk,
struct inet_cork *cork,
        if (unlikely(!rt))
                return -EFAULT;

+       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
+                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
+
+       if (!inetdev_valid_mtu(cork->fragsize))
+               return -ENETUNREACH;
+
        /*
         * setup for corking.
         */
@@ -1303,12 +1309,6 @@ static int ip_setup_cork(struct sock *sk,
struct inet_cork *cork,
                cork->addr =3D ipc->addr;
        }

-       cork->fragsize =3D ip_sk_use_pmtu(sk) ?
-                        dst_mtu(&rt->dst) : READ_ONCE(rt->dst.dev->mtu);
-
-       if (!inetdev_valid_mtu(cork->fragsize))
-               return -ENETUNREACH;
-
        cork->gso_size =3D ipc->gso_size;

        cork->dst =3D &rt->dst;

