Return-Path: <linux-kernel+bounces-39196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B36B83CC5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A88B29D9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A513B7A1;
	Thu, 25 Jan 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjVIobPd"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989713AA5E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211254; cv=none; b=Lr3IBoFjiuzqc2J7MXuRV7UrVzmCKb9wq3lFkmM3+qhVycsCiB2Zyvnrb20zMa4+gbYihJ/bjk+wcIaFsm6CeLUeduldMKCc/8P4Lz/30RKb6Sn+DSAwYK1iPHnOg1cWA4IoxRquBJyVSXp7gBjxcLYDTGbpPXET2se3JPDsFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211254; c=relaxed/simple;
	bh=euenOEJWbKMReqmGzBSFxRmeY7+pAw/n2DDD6pBCMOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbaJXYULBaKX3D6lYG4mY0q0IDnXqkwcisRltmHPerbWwwM5ec00kfJ1apKG1a3A/jgqnnArvi6UCkbAgc0W/96ozNlbLYmHbGkcitRTXyT/22jwH1XEzSvH7HorW7sTTV6XCD3f7g/RTys6Ctd2oO1G7ZK0aD4t/GpLsHIvKDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjVIobPd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55d1d32d781so2454a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706211251; x=1706816051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8aKo14reNbBvflPUZQ5aXL5UqBMo2rfTkLL7mrvQHA=;
        b=MjVIobPdwgdRBT64fxSRe/sJ0dK95M5Tw6uFkt+S2bgOhAsx+x3PWWYer0XvxcyR3K
         bKtXWbzTTwcUFhb9GBNtdKZJ/7lJXpiqC5+qQ6klkKXkOdENAqmkU3pRo6bPZRP5axZi
         Yekzy7tFU3lG0M6loSRir2FgOr6IClQpSGd/m/p/gb93wm7JhUFK1mka4UWkVeDXb5ve
         HOOY6T3Op4Izp55MgUNsfxeU79gTJ526yT/Uk6+j6WEr8lTUI2co9jXhu81syMGS4ST5
         vMzLHshzpNegXEvzAPsIRLVcZBBIuFC8pi4ny1XeBCEdJAAZ9+CBd5MADcffABHUlQK9
         adrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211251; x=1706816051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8aKo14reNbBvflPUZQ5aXL5UqBMo2rfTkLL7mrvQHA=;
        b=a/ky4XzLKpVH+qiQzo2brG4u2Krithe7LfNbnf0OjqnRkLVTmud0rQp1ZYjI4L66f/
         s/E7SfklTOVieNPeiZCm3qla5N2hlBY8maGn5hiRhvFTUWRoDBdqqSasz/HZxKVYIUJB
         GaZzpFXYkHrSbMlOSPiOwf3xhx/t7EeBO3s2exS/pc0fN/3zfFnIw7979G3bbeEvRYRd
         DkC/g/bHlSV0Tstu5QgaKdqlBgGLqtiLoSxcaC6E3s4sKhBjbVZBKqQhgZng9BC8kiTl
         uqSRgeAGsvOpfwvP0j1GHnyi1uUPz0g2xO2PNIHkg8SDYdcv1i51WSg8hyOzTpIyf6U7
         fx4g==
X-Gm-Message-State: AOJu0YyVoHD6zcEQMlBzpu60/LRaIiSYJ47Weo9Gra1TI2E5TuscM5vx
	eMqtFnwP3BCcYWBZTkKlQRcijoDUXUmXcC1P0Im8Ae+/2ThvjiVQgkXk7iH6WyYmvVWg++dMOOq
	XUevP780KGveHf0KAYHlWmciGDgR6kEIihBbj
X-Google-Smtp-Source: AGHT+IEpMi+NmSM6UzeX1Az5Tw5KfRkgmi7J8s3iBPlxb9oU3Gl6GyDR56rBqH4qqaqN93W4MCGtA2sQMjjZqtpZWDc=
X-Received: by 2002:a05:6402:b57:b0:55d:2163:7ed1 with SMTP id
 bx23-20020a0564020b5700b0055d21637ed1mr14684edb.1.1706211250620; Thu, 25 Jan
 2024 11:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125191840.6740-1-jdamato@fastly.com>
In-Reply-To: <20240125191840.6740-1-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jan 2024 20:33:56 +0100
Message-ID: <CANn89i+uXsdSVFiQT9fDfGw+h_5QOcuHwPdWi9J=5U6oLXkQTA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: print error if SO_BUSY_POLL_BUDGET is large
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, dhowells@redhat.com, 
	alexander@mihalicyn.com, leitao@debian.org, wuyun.abel@bytedance.com, 
	kuniyu@amazon.com, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:18=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> When drivers call netif_napi_add_weight with a weight that is larger
> than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
> prints an error.
>
> Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
> specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
> error.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  net/core/sock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a..ed243bd0dd77 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int o=
ptname,
>                         return -EPERM;
>                 if (val < 0 || val > U16_MAX)
>                         return -EINVAL;
> +               if (val > NAPI_POLL_WEIGHT)
> +                       pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested =
maximum %u\n", val,
> +                              NAPI_POLL_WEIGHT);
>                 WRITE_ONCE(sk->sk_busy_poll_budget, val);
>                 return 0;

This is code run by privileged (CAP_NET_ADMIN) users,
please do not spam the console with such a message.

My point was : Do not allow an unpriv user to set an arbitrary value.

netif_napi_add_weight() is used from kernel drivers, we network
maintainers usually object
if a driver attempts to use a big value, at code review time.

