Return-Path: <linux-kernel+bounces-123392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A568907D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CD22A5494
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B600131BB7;
	Thu, 28 Mar 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rBxOLjEC"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF512AAD3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648830; cv=none; b=DO+OGRWgMPSI2hVY9xbcwx21b0sRFyz6dfArupWho9jeXUkNOKL8ML6iM+YQVyb8tYWLyuPPa8Az0Avp8kLMsUX2wC7QVdjxywRchxO/A6NPNbmO6gPombxOs9j+a66t2rbxrBIHGsFeZZCfaCzEeyPk60O0tiAjfSa9xDXzQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648830; c=relaxed/simple;
	bh=OUydAPp6uAcvd+QU+kjZdkJNOn3bbSBOUwQje8ZcuGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooK2fpWb4D6piMKSaNFDWRi3R8iTKlhHFDlyKE0U41TPoBMKRBioDR4fvmbrZsaAYEOd/a280kbOk3LQ1OZBU6Gzw6SwX+E0ruXJFjjNuHIDfMiRC+Ty6drLxomlkAzIJACiVdP3l9zoijaQI/rs0Y74edZ5Ndbg75ewrfU6jvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rBxOLjEC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1235748276.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711648828; x=1712253628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKbfion+n4fQpm3TAmkfKQ03jeIchA2VK+TIGXUHdDw=;
        b=rBxOLjECmakZ0P+Jgp7LTlJ7fJhdQmE5hePtGDoMgrR/wXhtheIid6NF8DLlVG/O0t
         gDsm29z+5LKfrRf0VV8ICRTkCrJf49JPAVUgWLih/IBz1RLRbKgKrAzvSZ/XQNt3gD6U
         5rGxTtnJtqtfwe6dz7tEvTCYbXUnAgJ+SqD6O2tXdqKdzpBxM2+EgC6p+gBMx85PKR3E
         wLtu9H8Eyr1+lVGsicdSZG5Jh8J1aMOZ/YlfQ8Mq7MTbBXTMtr6JDYHrv3ueyA9zqskZ
         2TeumASDhN4N7R/jXyHS1yQgL0ewG1YpSknwpEGGX3tVTWSDgTMXQ3d1JHYf1rD9HLb0
         uchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648828; x=1712253628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKbfion+n4fQpm3TAmkfKQ03jeIchA2VK+TIGXUHdDw=;
        b=P/H0CL07p+fcyfrhzfuE5nXhNOli8oLWEHsjGkf1L1rm/1tXeMN2O9NHTtknwifC1N
         RbP/z+n0HGiF3UjO7EQOPbtxVM2w1j68C2+9v3m2Tn38w48e0PyWp1qS33URNJ5q1KTN
         BFmqRoUcNePQl7BT3tgxFgrQVlwIcPKC3yTz6fYugnvYqMKjmAGFpxNSrAdWu+aoiHl9
         5raedfoTGOs/pKvlyVANf4CB4ZbTAhrjjAdmMIdFJwHP/HDypxr92RgBSR2W7AIB7kJU
         ui2aEuF0wo6b+24js7VOatX7B5LOk/wnRP7JB2WpB256S8OE17wn7r6uRSVoyldYoMcJ
         c7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUH718fHgQil0Ksco7jJM/HnSnXtk3n97HIIkmkF0fuHG/eYhQr9HkX4XtPPCIBIWV+X3nCaW6qwfcH6iimQGFwbEa3nLvApgiW3WzR
X-Gm-Message-State: AOJu0YyplFS+9KVjxd2DfDwk1VztcCeqnwETYSIMBPQWtDvCQvMefXUG
	gSQYwYRX7+jDkRKbS3lMblIcL0QUSN8pe21cIM8TEA2FOe0XImWX3iQaKJBTtwbdh8t+TjGg3/W
	hmb5qWj17Qdx9NGBRFvzv1q0PmyQP/GnIH3kdYA==
X-Google-Smtp-Source: AGHT+IGHxMl2tnOV7GPTKo3pBywdHk3iGeVuT0X7oDfIzsFuQvKcAYE+hyVJY60/3ItdBMDUUFGB2g/T+7vhTuvUDjQ=
X-Received: by 2002:a25:b989:0:b0:dbd:8f9:a71 with SMTP id r9-20020a25b989000000b00dbd08f90a71mr44716ybg.28.1711648828232;
 Thu, 28 Mar 2024 11:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240328091426epcas2p4f227abb6cd7e710f49f4e61aa022f74f@epcas2p4.samsung.com>
 <20240328091000.17660-1-jaewon02.kim@samsung.com>
In-Reply-To: <20240328091000.17660-1-jaewon02.kim@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 28 Mar 2024 13:00:17 -0500
Message-ID: <CAPLW+4=kW3-h69_Ctx=MNE2c_k3iyTqZf7242wixRBz-gRkzkQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: exynosautov9: fix wrong pll clock id value
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:14=E2=80=AFAM Jaewon Kim <jaewon02.kim@samsung.co=
m> wrote:
>
> All PLL id values of CMU_TOP were incorrectly set to FOUT_SHARED0_PLL.
> It modified to the correct PLL clock id value.
>
> Fixes: 6587c62f69dc ("clk: samsung: add top clock support for Exynos Auto=
 v9 SoC")
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/clk/samsung/clk-exynosautov9.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung=
/clk-exynosautov9.c
> index e9c06eb93e66..f04bacacab2c 100644
> --- a/drivers/clk/samsung/clk-exynosautov9.c
> +++ b/drivers/clk/samsung/clk-exynosautov9.c
> @@ -352,13 +352,13 @@ static const struct samsung_pll_clock top_pll_clks[=
] __initconst =3D {
>         /* CMU_TOP_PURECLKCOMP */
>         PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
>             PLL_LOCKTIME_PLL_SHARED0, PLL_CON3_PLL_SHARED0, NULL),
> -       PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared1_pll", "oscclk",
> +       PLL(pll_0822x, FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
>             PLL_LOCKTIME_PLL_SHARED1, PLL_CON3_PLL_SHARED1, NULL),
> -       PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared2_pll", "oscclk",
> +       PLL(pll_0822x, FOUT_SHARED2_PLL, "fout_shared2_pll", "oscclk",
>             PLL_LOCKTIME_PLL_SHARED2, PLL_CON3_PLL_SHARED2, NULL),
> -       PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared3_pll", "oscclk",
> +       PLL(pll_0822x, FOUT_SHARED3_PLL, "fout_shared3_pll", "oscclk",
>             PLL_LOCKTIME_PLL_SHARED3, PLL_CON3_PLL_SHARED3, NULL),
> -       PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared4_pll", "oscclk",
> +       PLL(pll_0822x, FOUT_SHARED4_PLL, "fout_shared4_pll", "oscclk",
>             PLL_LOCKTIME_PLL_SHARED4, PLL_CON3_PLL_SHARED4, NULL),
>  };
>
> --
> 2.43.2
>
>

