Return-Path: <linux-kernel+bounces-37671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D7983B368
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE01F23AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD91C1350DE;
	Wed, 24 Jan 2024 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4h0trHV"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D3B811E4;
	Wed, 24 Jan 2024 20:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129909; cv=none; b=uWYD3kht5Jfm47oZZ3u6bE/Lr84jPhJd87riBoC/dj2SkUDlbOuNYHwz9o+L0dYoK0c5Z7ZpC8Eivs8kNyCcS77I0iY+WMKz0aepk+nyLy/0YGJ0qQU8yULQnCkiA3hIplaQJpJt7zjjGTfuUxQQFDavjoz5/e0yrod9gUMIatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129909; c=relaxed/simple;
	bh=oRZyBk4xN+U2BmP37TiRzcG4wQHneKczqa+lVweiFV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCjV6GMy1aW5cC8nRG+R98RaORUiD6z9zIZYxIPZypjGT0vh/mMgt/y22EcbwVUAwYE2FpXsdYAhWw29GDW0unHvsxB0jOGEKrjCJvet1NoTFN+D8MC2rKQsSon0CyZ90dRTcBxDC2i24nzQrRtY7GSpG/2MmrU+L4u3n9JWKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4h0trHV; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a313b51cf1fso15027366b.0;
        Wed, 24 Jan 2024 12:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129906; x=1706734706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvIma4Hp1tTx3eIr9boX1gjmScOYBle3eU0PR0ZkDAs=;
        b=Z4h0trHVfx2RXSGGTT4phCwTE/kWCCRfRn+xVtKhJZjdwDpOdgP5+j7BbaNl8KEOMS
         WSf4eft69tuCGI+vuXedktVcuONInwr9AjYvzzvVbuxOd+fIpvQ/h3UDZSVjK0ZwuuJq
         7y48CazgvNSPP3YQgDaZS6K+Eyfu5xZknFkZfOguL4p0pY9iSvIb+ZX6pdMc2fSb4Lhs
         EXfBwHh8HvbmEGRpQcLeOxnTnKGMCNXz0LC9TnswvYitOS3Qlb3YTvQIUDAWxtl/qHhw
         0GwtNZV8wfgXYMzGUJMpR5dIJWwH3DjCZLO0EdC6DpYbGw5rhV90zpRtOU9sOE8k8mD3
         GnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129906; x=1706734706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvIma4Hp1tTx3eIr9boX1gjmScOYBle3eU0PR0ZkDAs=;
        b=NZ881TIwG7vQtG2sAmODkbBIaPA5eC8D6w1aEIJdG3DUoQyQTOBdSgpc6aEDxb8POv
         DaGStp1n7Fav+ubdnEglsLGiydYfU2t10p456fhtEFhv3kG2BHqAMpcUr97q8IR3Ajj8
         pFJgRLL6WOLHCWge+kkG2qMjQpcLOBtQzyj4HuITq5EioGoYE0M6FGC1lMzdBG1q07xv
         a1zyQsjy1yKxllyHBUl+s0RRig/bZZRT9GgXda4uCzqCax/n3oHOdTpcm+7bFEKQrS1R
         vke5FedMtomMCJnSNsrJ/elOfpUvmhyRhfWlPbw/9S2/EUdqtm6JLogQW6rW3jpJezeZ
         oeKQ==
X-Gm-Message-State: AOJu0YwjrryIi8OvTcfMzRqbIHUYZjbrP0wQuMUVYSyRTFWxbqtnEVqY
	HUXJV6ujel1woDiese+MK4IWxkM+BHNdUZX+1ziuamFkpnTjsEL6vRfC6zgKSx6m6d62Fhajzz8
	zruh3SJsmpIk6H56FlxwS/7nDMMw=
X-Google-Smtp-Source: AGHT+IE4lTolYWHa99lJvZsscH4sVwoa/SEtVdWBjozI0Wnb+XMG10MlRl6sH5qzu3xXFTTwxAjMS7QN/w5TxVyLKVs=
X-Received: by 2002:a17:906:858:b0:a31:3417:218e with SMTP id
 f24-20020a170906085800b00a313417218emr214223ejd.77.1706129905580; Wed, 24 Jan
 2024 12:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124153016.1541616-1-ckeepax@opensource.cirrus.com> <20240124153016.1541616-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20240124153016.1541616-2-ckeepax@opensource.cirrus.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 24 Jan 2024 22:57:49 +0200
Message-ID: <CAHp75Vea6odZHUKQrFuOg-Nj1UXuj_+X9qKJZJ58dQa+R78OFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mfd: cs42l43: Tidy up header includes
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lee@kernel.org, broonie@kernel.org, alsa-devel@alsa-project.org, 
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:30=E2=80=AFPM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> Use more forward declarations, move header guards to cover other
> includes, and rely less on including headers through other headers.

Thanks for doing this!
My comments below.

..

> +++ b/drivers/mfd/cs42l43.h

> -#include <linux/pm.h>
> -#include <linux/regmap.h>

> +struct dev_pm_ops;
> +struct reg_default;
> +
>  extern const struct dev_pm_ops cs42l43_pm_ops;
>  extern const struct reg_default cs42l43_reg_default[CS42L43_N_DEFAULTS];

As far as I understand C, these two changes are incorrect as the
header _is_ the user of them, i.e. it needs to know the definitions of
the used data types because they are not POD (plain old data) types.
But I will learn something new if I'm mistaken.

--
With Best Regards,
Andy Shevchenko

