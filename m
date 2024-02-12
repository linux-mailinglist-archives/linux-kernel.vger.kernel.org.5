Return-Path: <linux-kernel+bounces-61066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33715850CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C541B1F2454F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D221FB2;
	Mon, 12 Feb 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SN74vY/B"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D11848
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707704013; cv=none; b=OLnA8kyScvh0MDW3JnnuIwalHQql85OGyaAQSxZrzl4R6tr2W7r7yVB9+C/9u/qWlsGHLSjKIv/FzrjZcUc9S8XwX+1+q257CnedRwZ6qZPDu3CC0Vgsag53PyQBW1ovoez47LdLnkAhl3B5yjiwHFA0Dd3rRrTsDoZjk4aUN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707704013; c=relaxed/simple;
	bh=djg3HPaS0RaWqXpPqMTO7eBCfqDBxkC/z6vedEGpRpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSqC/YBEiDe9iH9tOTV4rI03WU9KqdgKXrQuFJVeOPDSrWVC/ftpHDR60hQMuj879nZcYq0FcOEUAV8qQl3iRtV9ZfTQ3pWJVO4hMRCfwwuyV9UcswfZVKELIsal06cikTiuUWSvJwEXfBGo534UV8U04tcrkgaPalal/p9zhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SN74vY/B; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0ed7cbd76so15326481fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707704010; x=1708308810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOVyEZPYJia2NiveSW6uDVnlUi32Gk4cYfRx/yFL4Wo=;
        b=SN74vY/B3iNBM+crpwyzgzMqPHzd4qziO/mvSKUa3dBa3hNZT7yeHAXsw48PQCqc0Y
         JxKTsoPWco7wFyfFR+xNgYj+JHF8JJI2mSKBF+bxVyailfgvbxY9SMsThzWN8ggj1gWA
         0yL/gLqSi6SCAa/S5NQxLPivfDUPrlDrOPmqhDC8kxmZ5tLP4KL1izV2yIi0PKTOrqrB
         DNgL9pTW+NGIaN8O7077MZ+aANZSgxm3n4vqqexiYwAlSLTR5I4aOA6Lpm7A//iTxWY/
         hogGcFIfaYHUirktbemfoF5+oZYBQkJz16Ufttz0txlh1lA4N1KQN9sj6Ys807rVdn6b
         L9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707704010; x=1708308810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOVyEZPYJia2NiveSW6uDVnlUi32Gk4cYfRx/yFL4Wo=;
        b=f3UvhgP03ebHi95vKmN1xW3YIvdKT+c1kGqB5YXD2IlzKKXRXvezBIOSu295X9jMD5
         22Y4XxzEhVzrJUe34WJU8y6Mc9zlmuqthe0wnQPhkXqM2zI1v+3X0Z0vNfveCDY0L9t4
         9XAaQirdkPfQvp9tAguT/WQ7hLNgwA/edeEdP6gQJJ3AvXFHEiz6pdOtjTxNlQTtAzck
         9Dahr6nzyVMIPITESx1D9MjMjBA1zzUT/SlyIsYZVXJKaSSf3JzmWlYCIE2XGC4lBPkM
         FbQUR2JM8APDZq+CRz2U4Q+JilaoumWx8FtcT/EegUi3dvGGzoqhzeU3o1Sm70n8h5/p
         Ibog==
X-Gm-Message-State: AOJu0YwSpjdLM0HDxtz71W9bDeZT4WjNo9H3oQxyg5jbMdxT4LHqw+Ep
	kKp8KA/dfDvUdqbmlvtFTXA1wi6G1/A5gPqT4UXD0IKLxbgb0XsRD/Lf+WR1ckNoIWpsUgdfRDd
	/+SOyDeK0v9cHNnwED+4eGy0ogK78wdXU9d0Fqw==
X-Google-Smtp-Source: AGHT+IEugA1vD35qiCK4jNXGBT4+P05yEXhAxZECPsbtGhBs1otlRtvU4Dl9G8T1OtYKKKdADoNvpKzEJlOLCg+aoBI=
X-Received: by 2002:a05:6512:ea8:b0:511:8b33:6c73 with SMTP id
 bi40-20020a0565120ea800b005118b336c73mr1957166lfb.52.1707704009637; Sun, 11
 Feb 2024 18:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206044217.1283849-1-songshuaishuai@tinylab.org>
In-Reply-To: <20240206044217.1283849-1-songshuaishuai@tinylab.org>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 12 Feb 2024 10:13:18 +0800
Message-ID: <CABgGipW_U2tx4FKeZ+SuS=oKas13KEoJH1-TQUNF22B2p0tGuQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fix a typo of preempt_v
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ebiggers@google.com, vincent.chen@sifive.com, greentime.hu@sifive.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:42=E2=80=AFPM Song Shuai <songshuaishuai@tinylab.=
org> wrote:
>
> The term "preempt_v" represents the RISCV_PREEMPT_V field of riscv_v_flag=
s
> and is used in lots of comments.
>
> Here corrects the miss-spelling "prempt_v".
>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/simd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/simd.h b/arch/riscv/include/asm/simd.=
h
> index 54efbf523d49..04baee713eff 100644
> --- a/arch/riscv/include/asm/simd.h
> +++ b/arch/riscv/include/asm/simd.h
> @@ -36,7 +36,7 @@ static __must_check inline bool may_use_simd(void)
>         /*
>          * Nesting is acheived in preempt_v by spreading the control for
>          * preemptible and non-preemptible kernel-mode Vector into two fi=
elds.
> -        * Always try to match with prempt_v if kernel V-context exists. =
Then,
> +        * Always try to match with preempt_v if kernel V-context exists.=
 Then,
>          * fallback to check non preempt_v if nesting happens, or if the =
config
>          * is not set.
>          */
> --
> 2.39.2
>

Please also do this:

s/acheived/achieved

With that,

Reviewed-by: Andy Chiu <andybnac@gmail.com>

Thanks!
Andy

