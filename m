Return-Path: <linux-kernel+bounces-109904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C2188578E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A20428468C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3261657301;
	Thu, 21 Mar 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1LcEzz/"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB256B68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017449; cv=none; b=S4KOMt9Brp5wMKUb9lM4PGIW9+RKzqLCcMXHKSAC6/gKwJJFaSzWpa97RSgzSw8kyyRHsyoXGAVs7DXqo4niYuiqDhTQo0kUZYWVxKAeobRPvCCGO6RdNmt62S9rQVfBqmKi+cC/z0iCZxLwrLCohUlYI8jWgSuL6WXFJZqftek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017449; c=relaxed/simple;
	bh=Q5HIPUafMl6eXevlnHQ/URvfVcm3dyhh3w+1UjS8SKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsR0oceWU1HVY5MJU4ejjiCbEswOrzbaxUko96e/uc0BAoTSAU76HvXl8/73geEGCKTFtHHuSOG9ZB2164vp1tLQlMwOnxzEkh7N1xZDQDcKhT1SSp+WByjg3Y2RH1P1/oOw9M9um/jwIOJ8xH6XKKeV5jWhm+rTPe8QsnLCybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a1LcEzz/; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-610e272028aso14896697b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711017447; x=1711622247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rgS7vN2/6Af+74Byj9OlnJ0H2zeuQGC5P3Z2OCbZVfM=;
        b=a1LcEzz/X2gNicqmhPQDL0qaKaEqhPmy3KaTuYNzEwowyPmBPMEcudiIYiTOdHpN9z
         4vB9UM7pns9KfD4BYVw7HHxdmSdVxC4+QjLzPzRvJuQxgVZT9xhHZslwMZF5of9LCpFu
         TDR8QBjnqsRAFK1FcRfju9rwbVz6vycJPH5Y+Nq9iTpgzjHpkoGWyS0cllfp3sUZ196l
         X7bjBN6w05fflwitx2AH1B3qCd9lwS/fMtZefDz8EDhewWaIDLcN9piOqGv8zLsj9Hvi
         S8WoeHgVpGstjC6Lf092Q5IVVQLEIVxAuddbE1Za9CmIbqeD2KDFaMuxnpJYaxxyN+n/
         u0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711017447; x=1711622247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgS7vN2/6Af+74Byj9OlnJ0H2zeuQGC5P3Z2OCbZVfM=;
        b=pD87EO/UZPiYm6fu1kwRQRhSYxP8MvSqE2rkhyRDsk1qKuBDf5g4OGDUcQogNBCOJp
         COa5fFEE/QWKs7eOo2Zyjt0gaAFJ0z6Hv+HY8YmwJEUqwgQaKIgcB7r7zHedcVzxK5kc
         txJWlXzglFosFoU63IYSvEJvCTBftg2UrXKwQiwsGNhAOpFyAkzEDPEEfxS17bWrNxuY
         oET07eT10P1Ct/pNke1zfJ419eRm2Axi39c5FhM3qHX0DppJd7wix454b+XNMCmk7G2P
         J++NtS7tjhSSgsbdh39IdM/kvNJEN+u175QnNTlkMIu/HL6LkRcHjwHILAGK5ybH7xyV
         UxEw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ99JkPjt8cZCxruUetXSKkH61UqDf6JL53NHhJjS9H9TquQ0fDbAVAL1lvn9delJju4fjPmKvtJzEGBdoRCC9wmWJdH2fD1bwbbZb
X-Gm-Message-State: AOJu0Yy3MzOxPDiRtN+mR6tulWJ3433bUH7ZNcJC0eVgUeeJ+hBYRaxS
	JlhbrObf0UM6G2bBW9XZQg0I9GplEVlRlL3d8VvxNAN4vnXLS25XEpeL4H5crl57SlJNIQlJC38
	EEuW7Q3pLzQq7DJb1Y/XRVEietddoNBBh0n+81Q==
X-Google-Smtp-Source: AGHT+IG2RUQPgEXkiyPfIu42ue8IopFBcxsPMrsI45xpnMh6qrZimyfxJTyJ0YmVvs0DIScxCwEfz3O2Hzr3FChTGMA=
X-Received: by 2002:a25:808f:0:b0:dc6:d513:cd3 with SMTP id
 n15-20020a25808f000000b00dc6d5130cd3mr1365059ybk.31.1711017446673; Thu, 21
 Mar 2024 03:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com> <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
In-Reply-To: <20240321-apss-ipq-pll-cleanup-v2-3-201f3cf79fd4@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Mar 2024 12:37:15 +0200
Message-ID: <CAA8EJprr4E1CM4f+eBzdRN41nm33xY-hRPQDn3peR94vLyJsYQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] clk: qcom: apss-ipq-pll: remove 'pll_type' field
 from struct 'apss_pll_data'
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 09:50, Gabor Juhos <j4g8y7@gmail.com> wrote:
>
> The value of the 'pll_type' field of 'struct apps_pll_data'
> is used only by the probe function to decide which config
> function should be called for the actual PLL. However this
> can be derived also from the 'pll' field  which makes the
> 'pll_type' field redundant.
>
> Additionally, the CLK_ALPHA_PLL_TYPE_* enumeration values
> are meant to be used as indices to the 'clk_alpha_pll_regs'
> array so using those to define the pll type in this driver
> is misleading anyway.
>
> Change the probe function to use the 'pll' field to determine
> the configuration function to be used, and remove the
> 'pll_type' field to simplify the code.

I can't fully appreciate this idea. There can be cases when different
PLL types share the set of ops. I think having a type is more
versatile and makes the code more obvious.

>
> No functional changes.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
> Changes in v2:
>  - no changes
>  - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-3-52f795429d5d@gmail.com
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index 8cf17374a2e2a..816b0d1f8d8c8 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -131,37 +131,31 @@ static const struct alpha_pll_config ipq9574_pll_config = {
>  };
>
>  struct apss_pll_data {
> -       int pll_type;
>         struct clk_alpha_pll *pll;
>         const struct alpha_pll_config *pll_config;
>  };
>
>  static const struct apss_pll_data ipq5018_pll_data = {
> -       .pll_type = CLK_ALPHA_PLL_TYPE_STROMER,
>         .pll = &ipq_pll_stromer,
>         .pll_config = &ipq5018_pll_config,
>  };
>
>  static struct apss_pll_data ipq5332_pll_data = {
> -       .pll_type = CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
>         .pll = &ipq_pll_stromer_plus,
>         .pll_config = &ipq5332_pll_config,
>  };
>
>  static struct apss_pll_data ipq8074_pll_data = {
> -       .pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>         .pll = &ipq_pll_huayra,
>         .pll_config = &ipq8074_pll_config,
>  };
>
>  static struct apss_pll_data ipq6018_pll_data = {
> -       .pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>         .pll = &ipq_pll_huayra,
>         .pll_config = &ipq6018_pll_config,
>  };
>
>  static struct apss_pll_data ipq9574_pll_data = {
> -       .pll_type = CLK_ALPHA_PLL_TYPE_HUAYRA,
>         .pll = &ipq_pll_huayra,
>         .pll_config = &ipq9574_pll_config,
>  };
> @@ -194,10 +188,10 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENODEV;
>
> -       if (data->pll_type == CLK_ALPHA_PLL_TYPE_HUAYRA)
> +       if (data->pll == &ipq_pll_huayra)
>                 clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
> -       else if (data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER ||
> -                data->pll_type == CLK_ALPHA_PLL_TYPE_STROMER_PLUS)
> +       else if (data->pll == &ipq_pll_stromer ||
> +                data->pll == &ipq_pll_stromer_plus)
>                 clk_stromer_pll_configure(data->pll, regmap, data->pll_config);
>
>         ret = devm_clk_register_regmap(dev, &data->pll->clkr);
>
> --
> 2.44.0
>


-- 
With best wishes
Dmitry

