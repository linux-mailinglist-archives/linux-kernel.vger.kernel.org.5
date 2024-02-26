Return-Path: <linux-kernel+bounces-81050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF0866F7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9D288326
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C375576D;
	Mon, 26 Feb 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pm4F8Qtn"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437954BFE;
	Mon, 26 Feb 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939687; cv=none; b=F4NP0ByFihjW5HaLo0yq1T8qa2KOoCl3oj1J1HESkzBgwOT+HkfMQe4WwX20n1Z0jHnEAjK8ujg7h7KsRBcrKXmqpAQsQd1g2sWF6t9UOtROVn7MV9SLqA65ZCk9M2IgWFb+lt+8fNDRqw37/GvpCIfUvRjLadPmyEXKIwW7Y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939687; c=relaxed/simple;
	bh=lpT4EEEFtGcKtomDFu0DuY1Ilyst3kgzdjJTTE066wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EK3rTlNEaZ6lp1b662Ww1FE9LamHKlpCTwxo3lW1a2o2B8OC/00+/CeYRzbrmwt3/YX45ivgu5A+Nbu8+8t48Rf50hH41Lj54MS381lgo6eLK7rYu0m4+BBA7KZD8CEayHvTZ8mV5RuuxzZBgNeldqjm+i90k9AW2ma9oQQkIrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pm4F8Qtn; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-564fc495d83so3161104a12.0;
        Mon, 26 Feb 2024 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708939684; x=1709544484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zezp1plCc6cYEOmZOZvdSFi9iYdG1RWykK9uDZ/Mnao=;
        b=Pm4F8QtnPZwSrIMol8Llm+ovWwY93+b0PKQ9/YWRHkoR/dJk2GvMuLZdigDjMyE8Kt
         aEt8BAdgyVMqyOoxj3LLSwnbyIlNlxE6cEFb+nVwOOp515MjqrIukytmQO0umTOytyxv
         Tm0b+L5fLtOkN8wReplJWcB042OWIcohgkrO8gFOSA3t7cpOraWA2ydA9GmjGRSWEUFC
         vE7WMmK5Req3xH5L69vFx3bDp+TktNcdplmQ3SOxPPVrpsquGKFHJH5TKypOu1+j76Az
         Wvkfp7nj7LIxquWbcYEze7i/RWmKGqLU1icAyWMH4N6vt1tyOrALyxp0qH0uK6UxuqL5
         TK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939684; x=1709544484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zezp1plCc6cYEOmZOZvdSFi9iYdG1RWykK9uDZ/Mnao=;
        b=rRSIrCl2f5LMBiHVS5i3vYg9GQEj/QEjnBuQfSHUm2TjkFgUjzwwXw89mTjWxTUBC0
         2LKFVxTBpp1OFLsd79iBIXbSQ5VPBkBkDdwA4zfn3dyjVaqdzc3tyoO7EKtHrmtD1QOo
         FRPIFY1iqWp3A9k4x3GueMK38v7PgSExfs/8OTV+1YI6kjEh8ttH4eqZ5+Y0I8IusG/j
         Am4mLN9ySoZAY5Jz5jZvMx4M37Sa1sJZ7dkcYpObTTXxuOseLC+i7kF/yX9qO3tXxiZG
         kXhcGMKbrE6e2FksVRX0TyUlQ76uYhqZA6Qu7RC7cRwdELll3nBN3FIi88HOkSygdlir
         wkIw==
X-Forwarded-Encrypted: i=1; AJvYcCWRpHk4yTEg0AU20mY6VPsE4R4PZ0/IQk7Rxt63IrvzFYCAUeLp3q6qqcbTVNYU544rNl566orbl1SxAemi52gk9GBRyAtc6Ds7iSAPn/Qx8LxDmC6WwEc5MG2mQ4jiiRmoksaf
X-Gm-Message-State: AOJu0Yz320quea1j30KMkkHlUz0qFAMpFPNJJkYKRUj7beb46CsLb9ja
	/MHKCD9+d+dSc8RgAfGSRoGrMhFY88J7TUPEL3tejzbnikXFt7mFvN+1GoTI21CTgRpf4YADnRt
	2LBF3TsU3VObHRhJgpX3zglpyBeU=
X-Google-Smtp-Source: AGHT+IHSYUBtbIIKd5SFQ0SrthFoCS/puFEZ/tiizES94XySMAwveW9qDVNNtbHeTogNFlQ80ybtAHjRWTsBT85jaCc=
X-Received: by 2002:a17:906:8802:b0:a3f:40ac:1e0e with SMTP id
 zh2-20020a170906880200b00a3f40ac1e0emr4166524ejb.67.1708939684159; Mon, 26
 Feb 2024 01:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org> <20240223115839.3572852-2-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 26 Feb 2024 17:27:27 +0800
Message-ID: <CAL+tcoA=FVBJi2eJgAELhWG_f+N-kwmrHc+XRfKXhYk2RJcPKg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:59=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Another similar codes that also can be changed later go like this:

diff --git a/drivers/net/nlmon.c b/drivers/net/nlmon.c
index 5e19a6839dea..9b205b152734 100644
--- a/drivers/net/nlmon.c
+++ b/drivers/net/nlmon.c
@@ -56,10 +56,8 @@ nlmon_get_stats64(struct net_device *dev, struct
rtnl_link_stats64 *stats)
        dev_lstats_read(dev, &packets, &bytes);

        stats->rx_packets =3D packets;
-       stats->tx_packets =3D 0;

        stats->rx_bytes =3D bytes;
-       stats->tx_bytes =3D 0;
 }

 static u32 always_on(struct net_device *dev)

> ---
>  drivers/net/vsockmon.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
> index a0b4dca36baf..a1ba5169ed5d 100644
> --- a/drivers/net/vsockmon.c
> +++ b/drivers/net/vsockmon.c
> @@ -46,9 +46,6 @@ static void
>  vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *s=
tats)
>  {
>         dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
> -
> -       stats->tx_packets =3D 0;
> -       stats->tx_bytes =3D 0;
>  }
>
>  static int vsockmon_is_valid_mtu(int new_mtu)
> --
> 2.39.3
>
>

