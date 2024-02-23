Return-Path: <linux-kernel+bounces-79271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF0861FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C46B216B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3348D14535B;
	Fri, 23 Feb 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KfEzgTLC"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B41419B3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727918; cv=none; b=qbS4nnyfdCBCDcYQji6bX60lFHr+J5bAmsUX97VHNrFiVK9dixFV1xLKbFFxyCjI/vdn/RBHObqWNppzPaLvINkr2AifdlmSr6TcUvO2HsqCev3+WLIsWuW7MRNX3lDuH3ZXaMUUxWF98IiBoir2XsDuUuScUkM2RiE0cfjeSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727918; c=relaxed/simple;
	bh=/jCUeu7nXGh0QOtFmPjVbAr9/0g7GWt4C7jvDYh8wWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpdTUrmseFB6PK3LxjMbHqpaYVn7eDuPWh2oQXhu7K4XNh48EQgn7N2C4YPo5HpOWclQDPl4O/CB7ETiYoM1P2wrymCy0dMzKsvs/NhPiI/ga8mMJDtBKIvq+3qlCCcI5zBWtNMukA98luu/j6f8OHFYy42A/kSMqAr0NaggCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KfEzgTLC; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-608841dfcafso9354287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708727915; x=1709332715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAKXOqgOGWSmhUPcdC7/ENyJvig0ojHYAsCruIdGP/A=;
        b=KfEzgTLCM2FgIhjpB49D78wZJaInQxqs4e+vQrMboltVoLg9Iz4ndyHAhE43Vhh3ue
         2XqUw21ZyzwY51v0e6zBSaXi0A22jvYxC4sh6w1ky0a/4epTumlCyR0xQXoTx938vpcV
         sE1x2Dy1VrmOKAgm7W2G30d3AF/ddiHMASyMlPSGTYXCRuNWcBMAau0L75tmgbja/vT5
         7PhxxFZmSwD84xnxEUdL2ksDPXpadu7K7x8UvuLPWnkCM8Sg1+xRdriYxegpMsz1ln0J
         chmmici8D8it5yN64pVEtxzK6CW6LV8Xc0lVWBp8I83ZuHFMJc94fB3CghzodXzRvyIx
         PVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727915; x=1709332715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAKXOqgOGWSmhUPcdC7/ENyJvig0ojHYAsCruIdGP/A=;
        b=Hvkv/9f6nxzUD3SjyEEhre3h+lOJ3iFok8OfsPcA2vK5w+7/bIgJWRicZCpsXw55y2
         zcrPwLfHWycALns+yRy0vI3fv/Gg8zQJz/xZFxveRkC4uVIdUGN/2Ba/dAE00PgMbMMe
         YqIy4CZ2PWUWhjJ8eU+kwgZgWENwts9kDpFiCAE7L23Ozq5IT2WtgrMAVGE0mrbOu5FU
         HXa0j58GQENqfKw/8yFsUofSUtyrZSgQXcyzwlviX7gbtS/MAyWSe2dkJ7Wq9PbyveEh
         HlDtf/llF4iAzrYgWyc4u2Gvi/1+adUvRIdaxBo6sugJP5qaeKuWgNigmgFDRXtf6Myk
         voow==
X-Forwarded-Encrypted: i=1; AJvYcCWshZy6Go/oeei2Nm6xLYh7YryWl9AnUiXOu72ubfoqdalqBcqr3E4c/TvSHN8LtOQUED6OduJDZXuSxjWE1JLqXJ9PSL3dLvf7ipT0
X-Gm-Message-State: AOJu0YypWciXX2o7Ytk3k60hxXSdibN+mW5tWVRa4SIXXGycz8aL55X4
	+76gZMFSkNpW6Xwn1qQPNFblitIBZE2n8xH9bl3PFvZ0Uf3YTI0d/ybwhPN2vvC8IXdGwMC/9ie
	ZRskyWziRWiYeqnLqU6h31MweBqllpH7tEFKh
X-Google-Smtp-Source: AGHT+IHDoLHVOgOhl9ACFI87pAyBbPsCzV9kA1Ruxbt9Wsum8wsTy8bJMxKzhyaZFx+mFATHpKWb3x+jTPinBsdO9v8=
X-Received: by 2002:a25:b126:0:b0:dcc:e9d:4a22 with SMTP id
 g38-20020a25b126000000b00dcc0e9d4a22mr1343216ybj.12.1708727915706; Fri, 23
 Feb 2024 14:38:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB77794B8F64015E2D2D606CE097552@CY8PR11MB7779.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB77794B8F64015E2D2D606CE097552@CY8PR11MB7779.namprd11.prod.outlook.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 17:38:24 -0500
Message-ID: <CAHC9VhTBhBj0h43UD8s6SBcN2UDh42wqfYHLiNkPmzOWGZEAkg@mail.gmail.com>
Subject: Re: [PATCH RESEND] cred: Use KMEM_CACHE instead of kmem_cache_create
To: Kunwu Chan <kunwu.chan@hotmail.com>
Cc: axboe@kernel.dk, elena.reshetova@intel.com, chentao@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 5:16=E2=80=AFAM Kunwu Chan <kunwu.chan@hotmail.com>=
 wrote:
>
> From: Kunwu Chan <chentao@kylinos.cn>
>
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>
> Notes:
>     I'am Kunwu.Chan, the problem(https://lore.kernel.org/all/CAHC9VhTJXfP=
ztz2W_V6sp41PJW8dzvZH0YdnRXd7tUZOF1Q09Q@mail.gmail.com/) may be caused by m=
y email server.
>     I change the email and send it to myself, the raw email seems ok.
>     So i resend it.
>
>  kernel/cred.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, that worked much better.  As the prior patch sat for weeks
without any objections I've gone ahead and merged this via the lsm/dev
tree; if anyone has any objections please let me know before the
upcoming merge window.

> diff --git a/kernel/cred.c b/kernel/cred.c
> index c033a201c808..02a96e9d9cfd 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -606,8 +606,8 @@ int set_cred_ucounts(struct cred *new)
>  void __init cred_init(void)
>  {
>         /* allocate a slab in which we can store credentials */
> -       cred_jar =3D kmem_cache_create("cred_jar", sizeof(struct cred), 0=
,
> -                       SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL)=
;
> +       cred_jar =3D KMEM_CACHE(cred,
> +                               SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_AC=
COUNT);
>  }
>
>  /**
> --
> 2.39.2

--=20
paul-moore.com

