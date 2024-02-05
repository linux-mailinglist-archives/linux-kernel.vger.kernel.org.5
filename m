Return-Path: <linux-kernel+bounces-52597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C203E849A31
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C14128186C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7259E1BF27;
	Mon,  5 Feb 2024 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqNl0Y/I"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F81B978
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136175; cv=none; b=nnCYEMUbQGwSwfiTUpXJO9qABfjPlVeCBVvjNhm8XqeUbdpnX+8V+UazINx+c3iGwoah+ypO5x0paRFP4dclCpF1vhVPHlhkj8v1fP4LkrWynKp2GY44ALUuQVGc0WFtAAdsbbNtgR0LkgmGWRR2nEs6dPYMk2LHg6MdWqqhx7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136175; c=relaxed/simple;
	bh=p8w5ORQN85keSs4iHtLF0hAGuD3vblI//NXG+Z81rLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNRHpCjy8A49/QkWxOi9w0rn4XUodAvx5KyMYJgYh1Z2l0PfFV9Yb4MOHJGfcjtTSdgUJrhHg1sfqGI0+2Zp7KJmz5b8Ja2SmantTfwOwLKrLVpqcACtv8lGq18tMgWJsKRjGe9X/HtMCbardooa122uDSO4G6CCfsR3nqHUySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqNl0Y/I; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so15655a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 04:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707136172; x=1707740972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k24Uyhl1+vZMArgijwhf2EF1yCtOJQ6dhObCgbS2exo=;
        b=wqNl0Y/IleO1SJfGRzcCA4KjzTEUKCF+akmHWdzBDl+JWg/c4xNfpN9/wvRLPB1R6x
         /Raq89Df4qqPf8x87MfUMHMlgODHO608vMumBFD7iPW7IHA6n7LNfxF/pA8tjCFre5wR
         7dUrlBStos62GxDEj4e7VGnqy0Mv+pOy6c8476QIXCd4bkRAu0cShOieIabSb6V/ttts
         CePiPKEybBU3zGVgDiVQSS7EelULFo8Hx65Te1wPwxZmsaPZTmNl/w9SI2RPAKBr4pOT
         75TtLioSMOm/BGVN9hKue3+hlyuBenFFKUTZbcnhUUFT7gpSB3QGfdCxdyg8L12e3bkl
         A2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707136172; x=1707740972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k24Uyhl1+vZMArgijwhf2EF1yCtOJQ6dhObCgbS2exo=;
        b=GrXGScc7ROsPoMa5g8JFFw0XnZ5MKgkLMW/kOSSLWN+ZbjEaaNFzHFtCeErmlguzir
         d9sNF/AQXyt0wAHoTIa8pSSMd3oCnOtrpJ5l5+FWhslp7rNj5a+9rUXhG/7uG8kLlZo4
         FFgdIDbIuJreYP30yA4oKNKEz7E+jSMUaa8efwq/XiFJJuX+TEiRTvOp51HRnY3FRuWT
         nO6nTQgiYIwLevFxROVOgsj+8yHlZ17ZC0ZZhYU3HEQyUBzhZYBoiFI2hSoVHA2kBJW3
         aboCSb9zNkB246sT1GoP+UwArM7saQitfYdaFitLVc7QjTu6ShrUzqjY3fEMzjabLIT1
         7TFg==
X-Gm-Message-State: AOJu0YwAythwfC8hnAbtebdoOeZ9PfVeCRhpg/3gsyUJxCko3rEhC9uh
	ZFTfP2NyU5twxI9rx17pHgZltI7k4LZ8FglmfoCCytI+i1VqfCCu2bm30otYwjSvlrJP6IsSkrA
	DpxEQU9so6CEDmdZh+XCplJLRcP/e2QADD9r+
X-Google-Smtp-Source: AGHT+IFzdiEyEpD5bJtfFnXpWSSyxQQjI7i+MYv5KUUWd8tWIXJwZPoB4d2ch4wJ9Fg7pBr/KbrQhvHNNzaGSNgkJfg=
X-Received: by 2002:a50:8750:0:b0:55f:88de:bb03 with SMTP id
 16-20020a508750000000b0055f88debb03mr249754edv.4.1707136171790; Mon, 05 Feb
 2024 04:29:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205072013.427639-1-chentao@kylinos.cn> <20240205072013.427639-6-chentao@kylinos.cn>
In-Reply-To: <20240205072013.427639-6-chentao@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 5 Feb 2024 13:29:18 +0100
Message-ID: <CANn89iLkWvum6wSqSya_K+1eqnFvp=L2WLW=kAYrZTF8Ei4b7g@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] tcp: Simplify the allocation of slab caches
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:23=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wrot=
e:
>
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> And change cache name from 'tcp_bind_bucket' to 'inet_bind_bucket',
> 'tcp_bind2_bucket' to 'inet_bind2_bucket'.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/ipv4/tcp.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index a1c6de385cce..2dc3dd4323c2 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -4697,17 +4697,11 @@ void __init tcp_init(void)
>                             thash_entries, 21,  /* one slot per 2 MB*/
>                             0, 64 * 1024);
>         tcp_hashinfo.bind_bucket_cachep =3D
> -               kmem_cache_create("tcp_bind_bucket",
> -                                 sizeof(struct inet_bind_bucket), 0,
> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> -                                 SLAB_ACCOUNT,
> -                                 NULL);
> +               KMEM_CACHE(inet_bind_bucket,
> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT=
);

I would prefer we do not do this.

dccp is also using a kmem_cache_create() of "struct inet_bind_bucket"

We want different caches for TCP and DCCP.


>         tcp_hashinfo.bind2_bucket_cachep =3D
> -               kmem_cache_create("tcp_bind2_bucket",
> -                                 sizeof(struct inet_bind2_bucket), 0,
> -                                 SLAB_HWCACHE_ALIGN | SLAB_PANIC |
> -                                 SLAB_ACCOUNT,
> -                                 NULL);
> +               KMEM_CACHE(inet_bind2_bucket,
> +                          SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT=
);

Same here.

>
>         /* Size and allocate the main established and bind bucket
>          * hash tables.
> --
> 2.39.2
>

