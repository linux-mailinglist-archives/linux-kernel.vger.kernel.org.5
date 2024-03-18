Return-Path: <linux-kernel+bounces-106434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CB487EE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5005628399A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCBD55772;
	Mon, 18 Mar 2024 17:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AaUbH/lU"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419954FB2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710782371; cv=none; b=SuY9mkDjmxBWzvhkoUHHwyzMmokRPgLMLOJSUZIJ0hnALrH+El1EWLB/WxbOq2f8kWBmt6ZzwyogZiqlWBmugt7ixDmD9lTvQsTAdHJ+tQrhpADbsvHWdpBwQkr1otjcvqC0n94k5uvwhfx88ox0WHuA2dBJd0IvYK3SNmdCQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710782371; c=relaxed/simple;
	bh=NipOqWcaGtie6YlGlJBGhNEiVysAImFex/86T3xnNXA=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzVL6t3cus2wZGgcFiDgUBTbTl26XWzFTDS19CnHNCS+RsmlGGdZFschQ3a4eQWg6b0d/uBnWDV2nINc0phtzORcD6CfA0jfrHa63Q3fJH0zP+OgXW10Rg6HzZREjFxmAKEaAMtCkD0IrXGk7WvwnfVFzUq9MrOlITLcK6OAW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=AaUbH/lU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 873E53F10A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710781939;
	bh=RHlFPdlhlD864SJZUhjfxgbABspep+IYfDLVWgg2pJg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AaUbH/lUr5TuNuXGV8Kboiq3jnqe7sSPayG42+aXWW7fmgiRRqGlc9RfCNTcqEjXQ
	 oZylYg9uU2YVPFUxpVnFXEUUFbzZk6xKQuy1KX0hJ+ozmmXawvLhKmfnXeS4ZI8mgp
	 vhULNGuhz9+NJ1AuzvwjnGkMj5qYGQy5mhWYmD/vlCfxkQF+bqNdcP8X354uENoQWL
	 cA7Q3qSILZh0qvIQs+49XAZuZR2239kXwh7AZSUfSrUFDAA3nM8c0dgTrPKJwGNKGe
	 PDRfGwIoGtb7MyxW4MgoK6DsYBAr8h07Otgkrv/EekBUaNDp76VnZPIHDl4hN/Q9Q2
	 kYNqa8XSGGzbg==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-43095bdc7caso53815561cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781938; x=1711386738;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHlFPdlhlD864SJZUhjfxgbABspep+IYfDLVWgg2pJg=;
        b=YpzWyuy9YxLqTI9uByXfb+wbYm/BXdw9uCtl2otjPOctTuWsJjKcuoNwZK/Xzk+QxR
         9WI7paYz7OL5tNagiy5h3ISdvbn6uQ/Vc57jfe2Lm5e/Hrsh2hNgON6HqFsxOEq+yUs3
         FWj2Hupj0EOk05uCpC5vNgpRhsKm68z1wIH5lmnnIaE4UHGPOciu1YAN83mFqZwGFiv8
         m/QO7BxGPY9cuAzAGkfodaJdRuC0tdb6cx3PNm/oOoGcl8MSxAJEBueiQyQB2lHwAhtk
         xKuc3f2QC4yGUHE0nm2R0z+ikpidhd+Xre7C1YszgGaJx2VSxzjNxLQF9TBb3I0398QG
         Sq9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPgak20LrjOoQOAf+kwGOV3DeXI1BWZ09HtNUWNs/eWgdzzn0kcB/XCxeCFh4kzN3k0kxNPhr/Y7yR6c0PXTvYtIbzRVmNTYITJr76
X-Gm-Message-State: AOJu0YxT/MjeQQcyeXGJajOzX8qUe1w/lX89XRwfXO6eKx1mpo/ojY/q
	TB+VouxVOjSCAe64+6wvAPrLmcPdPdGCYknFIq3pSWWhs2eQEvQW/YkFY5qx6uDmKW+fP/4/QBL
	mWaPJeuqZG/CLm6979Bkt1ZZJ07hgO2l6XJANzao6VkD2n68xPBaWvurXmbCBNDbIzMoHLOqzHm
	ze52o8Kh8z8ffL3ImUTKxCP7t/qtKYG6qYnZPUQ0n7DYRVoYFTvuCM
X-Received: by 2002:a05:622a:49:b0:42e:f7cf:ff98 with SMTP id y9-20020a05622a004900b0042ef7cfff98mr13273227qtw.16.1710781938491;
        Mon, 18 Mar 2024 10:12:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIdRe+ShfPpkWIqNza89+B1bp5+Xj+Ait5mURceCooCGFBZ2x0UImLi2Iek0huAH9NY6RsAslH53iOtRgxPsw=
X-Received: by 2002:a05:622a:49:b0:42e:f7cf:ff98 with SMTP id
 y9-20020a05622a004900b0042ef7cfff98mr13273206qtw.16.1710781938216; Mon, 18
 Mar 2024 10:12:18 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Mar 2024 10:12:17 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240318-emphatic-rally-f177a4fe1bdc@spud>
References: <20240318-emphatic-rally-f177a4fe1bdc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 18 Mar 2024 10:12:17 -0700
Message-ID: <CAJM55Z9vR0+KwQX6BQZak4NeAfLdiJuZJuZJMj8kfF9EHBCF5A@mail.gmail.com>
Subject: Re: [PATCH v1] perf: starfive: fix 64-bit only COMPILE_TEST condition
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> ARCH_STARFIVE is not restricted to 64-bit platforms, so while Will's
> addition of a 64-bit only condition satisfied the build robots doing
> COMPILE_TEST builds, Palmer ran into the same problems with writeq()
> being undefined during regular rv32 builds.
>
> Promote the dependency on 64-bit to its own `depends on` so that the
> driver can never be included in 32-bit builds.
>
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: c2b24812f7bc ("perf: starfive: Add StarLink PMU support")
> Fixes: f0dbc6d0de38 ("perf: starfive: Only allow COMPILE_TEST for 64-bit architectures")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> CC: Will Deacon <will@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> CC: linux-arm-kernel@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  drivers/perf/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 5060e1f1ea10..7526a9e714fa 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -87,7 +87,8 @@ config RISCV_PMU_SBI
>  	  filtering, counter configuration.
>
>  config STARFIVE_STARLINK_PMU
> -	depends on ARCH_STARFIVE || (COMPILE_TEST && 64BIT)
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	depends on 64BIT
>  	bool "StarFive StarLink PMU"
>  	help
>  	   Provide support for StarLink Performance Monitor Unit.
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

