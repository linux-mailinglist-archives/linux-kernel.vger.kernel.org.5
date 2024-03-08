Return-Path: <linux-kernel+bounces-96486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E5875CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF198282680
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352312C692;
	Fri,  8 Mar 2024 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivXA3Gky"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86422B9CD;
	Fri,  8 Mar 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869475; cv=none; b=Ih5Kp3FrIdDwRxPfZnUj+oKDQqad17x7Wk+rbo+cJBWqyTiLMP9x0jUeOegbEvQ4SJVddCW4DVPMPDOKHx6k8fag+wynJ60Cd+QwqLeGfr3y8zJ7scMBB9L1rHWW0iwpUMJ2Lkzkb7XW8bn3HBucD2ApxWOaPFwgvxMWQiPDDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869475; c=relaxed/simple;
	bh=uEVg+4YZG4VxUZEymDtNlS89+tL+uuSkO21k6vxYSFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LifySytjjkGnLT8lA0X6/7ihUxKJh+EyohgMJBchtDalBKdOS90XjwKwXsGNL7w9XghqAH70H3I2aQE9wzru1TYYLke33Bf5qulCQSqVyfNPzag98YqCrIfaUm/VgewbSlZ5Aadc81M8mQUoXPp/Lb8jdB4FZRdeuR/RtLRUSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivXA3Gky; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44665605f3so234300966b.2;
        Thu, 07 Mar 2024 19:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709869472; x=1710474272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGnHCoLaz/ffyd8p+UJOwvgRfMr4bDhvjC0IW5sSUmM=;
        b=ivXA3GkyH2i+iJ5zqsbX+6jlhLePSuBZT2OxiSMvuOEFHBC0DA3Dmx/tcFPNdI3uE5
         18uTQXqVyq8YeusFbnNBrMdaU7aveF2ZIG/vSqLIDSarNFc+VZ8ynI4LBRuTRaROCfxi
         /0hTn12z0dqQwOthyVLxZO9L8Q/h1UtD/WfoTJRb9wN6AXRq1ISSOh68xePlFc2g4/6+
         0WRKffOLy+/V4XxpeWm9oCRjNjFEsFjlaDApHyjFZdiAesyxdhJ7CkWB/FLG09b4eOaK
         h1Hj6Rr7WCWbO+xm/Owj5e046wU3jhmI7lMA1Jsm+F2/5518+d5T+1s/8hvVtT87Qp2p
         2ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869472; x=1710474272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGnHCoLaz/ffyd8p+UJOwvgRfMr4bDhvjC0IW5sSUmM=;
        b=L9vsqTYDs5lFsQUhYwy9aBvOUkSHLo8CpP2CmWF4qWtA3ebK2ly13aUnnQXTTRa832
         57wE5gW7ZUgN9UU6sZpmYAxlsXaPBR3l17ij/EwOUIFn8CPhvBHAq2rZzzJbcrCe9O1Z
         l3BO4qEPqDfwIgpzd5SicWJNdj7sWRqvWb7denohqH7MhrvMYpZis3C+VXRavrckiDHJ
         HfuPBpTar+rVsTpmYffL4T/8F8EUfzPRTrOyBSfVDmYKPGSBzJvZSOGb8BSyHpUA0Ptl
         cp18K2/3QZ6au/KedTmyA8WJgOf2cyBTb8ZIETqtnJzt+WCcBwnD10Ra7mG20UHj+Laf
         07Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV6s7egCOwrNZCeoyXlqiP+cKtViFzt1NifCU/5CRK1WrNd3A0IYJdk8L9e4U7r8bX7ORg0DtLFrLKV1PMLyYgFbmGDKBIgbrQFJLtckS8vjfgsBlpVBs3eCnbR1rQXO1QYKwoJ
X-Gm-Message-State: AOJu0Yz+b6UhirHGS1oxZ2IKJt7Mfdjk5lFbilidEAiEcmnjWlqVfhDZ
	dBnSbZUuvlLcWQF+GwG1Wl7kUsVV0uMsD6u+JrK5wzVTda6fqaBH2U2EakfykQeBvZ+sXwhRlCI
	VeWRn5LlmDis/IIbBxMPGgL+1k+c=
X-Google-Smtp-Source: AGHT+IGs4S6wwKbMWKdIpz+c1GGDOqI49NUGplbX7bK57SKGLHJagITjG8I7HR458HKMMjGUu1yCZ3WdTF+B8SVA9nQ=
X-Received: by 2002:a17:906:27d9:b0:a45:c8cb:b8b6 with SMTP id
 k25-20020a17090627d900b00a45c8cbb8b6mr3210989ejc.17.1709869471823; Thu, 07
 Mar 2024 19:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru> <20240307142030.2708698-2-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240307142030.2708698-2-Ilia.Gavrilov@infotecs.ru>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 8 Mar 2024 11:43:54 +0800
Message-ID: <CAL+tcoC+ysfwDSJfuavL_8-3+nUbEAkruy3iuiHU7LizesicRw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] tcp: fix incorrect parameter validation
 in the do_tcp_getsockopt() function
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 10:44=E2=80=AFPM Gavrilov Ilia <Ilia.Gavrilov@infote=
cs.ru> wrote:
>
> The 'len' variable can't be negative when assigned the result of
> 'min_t' because all 'min_t' parameters are cast to unsigned int,
> and then the minimum one is chosen.
>
> To fix the logic, check 'len' as read from 'optlen',
> where the types of relevant variables are (signed) int.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

For the patch itself, please feel free to add:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

I notice that you use Fixes meanwhile you target net-next. I'm not
sure if it's proper.

> ---
> V2:
>  - reword the patch description
>
>  net/ipv4/tcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c82dc42f57c6..a4f418592314 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4010,11 +4010,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>         if (copy_from_sockptr(&len, optlen, sizeof(int)))
>                 return -EFAULT;
>
> -       len =3D min_t(unsigned int, len, sizeof(int));
> -
>         if (len < 0)
>                 return -EINVAL;
>
> +       len =3D min_t(unsigned int, len, sizeof(int));
> +
>         switch (optname) {
>         case TCP_MAXSEG:
>                 val =3D tp->mss_cache;
> --
> 2.39.2
>

