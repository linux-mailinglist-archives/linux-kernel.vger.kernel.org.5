Return-Path: <linux-kernel+bounces-160304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A048B3BA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F191C23A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572415253B;
	Fri, 26 Apr 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2p1+m/33"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19360149C75
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145594; cv=none; b=E6LMC7ANeV9RFSDXdHT3JZSmrI91hypUhAZbFFIaArhFKu/irysDKqo8eo5DAC+s7vpdfCKl4gWwqpf12BsIM++X32JriACrn3psd61grvAsVJj7n259WgcOmSkrnw/5LqWwMz6d5yXA2NDE3WOu8meGe85grOC/9UX6nMB2owI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145594; c=relaxed/simple;
	bh=a+x+9QJcOjAjsTEqVdunD6qiMm7jqBNR+SHC13THGg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9T8iEblBG6Y/r9yEVbgcsf2WFGW6zal9jzNZva+dK/VpftYm/t4oZjnBTjNu0OHqC+2IZk2bEbGCZXicUTNjwxtIZooe73MZd3QhTo7SthbRKjimPUGfeGIb2rFwmGa5pkfgF/y5oOhbJhm3kz63Cc9amwycQEWN4lEzYxYOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2p1+m/33; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so12148a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714145591; x=1714750391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQAKSfeSiNMwx23jPVYzccmGjENnrcaTmn472bWM+dw=;
        b=2p1+m/33Ca229cGyj8MM8xvQ+TcRFoJ5xMFZZC4LEEYy5EM0ZGUdWs1cOe92gh1e0y
         JgoHocZlnSAN8Uj3vgLz0qJfUFhaScjKB3VJK53KAOhuiJDfYdNDDqqW624fng+DW54+
         Lv3xFHGsu/kK8XBY2VG84oLE7lg9vmFVzoxghp+b9ZEiRDU/yU6BftsY1PUt+qn5tYHw
         LG/hSeeCa/jzquXS+FURC9pnA+7fRnoi9ZIYsTpxKZNbW/vtROvlZ40vKA7Qi1+Nk6z1
         MLUNKpBhqRWA6cpytWhwrbEPR4kP2wsC3XOkkukKVvTTyYJo2GVvkkmQSgEBHwC7Ql3f
         dXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145591; x=1714750391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQAKSfeSiNMwx23jPVYzccmGjENnrcaTmn472bWM+dw=;
        b=Ny0K1Ll/ujYQKBr3eKjGe3/skinhTEiOikPSvTxMUu/ny6hkIIrUqwXPy+TMw1LrFw
         Zrb5F4+Wg8Gk2dL3V5TEVn8ZpkFuneoKVcvIBHFDkHh9lssyetP1hWIxWl3vUl4syLMD
         VmyM2MY8Hv8dMXuJhvPIKNzccFT/B2avd7LN//yzrZ+VA9CKEN9Gyqogy0WXQifTRyeS
         4mEz6YUlDVaJ5s3lJQUWWASNdpylHnNXawRtvj1FKxHsc8MBstVL/PqUhiZQ8Fu8kQjc
         0CA1ycUZtsqeGB/s9OKIuICoFlyJnkWLkH9934F116qDrMf5Zqnpjv4WbSrlzTRYff4g
         /WaA==
X-Forwarded-Encrypted: i=1; AJvYcCUf9lZznlvNv3lDCKd0dNSjjbefdIQVYUhxcJSPYSgbn/z/BwgihPITJDFlP7fzmAVD+RQ+Np1eoaeWe4NCAjMI9JVDNinb+tmlHk2L
X-Gm-Message-State: AOJu0YxgwbNpNUxvaVRanByw3hpAWeCsHIq7l6NUaMUaE8cb+c7Y8u3X
	l5LiZzH3sG4/Nd8pRtPbhRzTb7I8wB9OtJ7AgZ1M93J6Y44e6BhvxNks+EbmDNBRj7Nwh70Z6go
	avK3hyfOTdoaX9CNfHzqe0DRiWc0lSbggMp+/
X-Google-Smtp-Source: AGHT+IGFBkaX99SfmSYIhlRZCqbmREadhrxpgL9UrFo0Boe2aUlXFOiVrXsSsyd0ZAOJCYWvbdHlbxWVGOxfkpsUpkE=
X-Received: by 2002:aa7:d497:0:b0:572:25e4:26eb with SMTP id
 b23-20020aa7d497000000b0057225e426ebmr146199edr.7.1714145591147; Fri, 26 Apr
 2024 08:33:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426152011.37069-1-richard120310@gmail.com>
In-Reply-To: <20240426152011.37069-1-richard120310@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 17:32:57 +0200
Message-ID: <CANn89iKenW5SxMGm753z8eawg+7drUz7oZcTR06habjcFmdqVg@mail.gmail.com>
Subject: Re: [PATCH] tcp_bbr: replace lambda expression with bitwise operation
 for bit flip
To: I Hsin Cheng <richard120310@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:20=E2=80=AFPM I Hsin Cheng <richard120310@gmail.c=
om> wrote:
>
> In the origin implementation in function bbr_update_ack_aggregation(),
> we utilize a lambda expression to flip the bit value of
> bbr->extra_acked_win_idx. Since the data type of
> bbr->extra_acked_win_idx is simply a single bit, we are actually trying
> to perform a bit flip operation, under the fact we can simply perform a
> bitwise not operation on bbr->extra_acked_win_idx.
>
> This way we can elimate the need of possible branches which generate by
> the lambda function, they could result in branch misses sometimes.
> Perform a bitwise not operation is more straightforward and wouldn't
> generate branches.
>
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> ---
>  net/ipv4/tcp_bbr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 146792cd2..75068ba25 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
> @@ -829,8 +829,7 @@ static void bbr_update_ack_aggregation(struct sock *s=
k,
>                                                 bbr->extra_acked_win_rtts=
 + 1);
>                 if (bbr->extra_acked_win_rtts >=3D bbr_extra_acked_win_rt=
ts) {
>                         bbr->extra_acked_win_rtts =3D 0;
> -                       bbr->extra_acked_win_idx =3D bbr->extra_acked_win=
_idx ?
> -                                                  0 : 1;
> +                       bbr->extra_acked_win_idx =3D ~(bbr->extra_acked_w=
in_idx);
>                         bbr->extra_acked[bbr->extra_acked_win_idx] =3D 0;
>                 }
>         }

Or

bbr->extra_acked_win_idx ^=3D 1;

Note that C compilers generate the same code, for the 3 variants.

They do not generate branches for something simple like this.

