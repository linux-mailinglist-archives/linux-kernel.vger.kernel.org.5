Return-Path: <linux-kernel+bounces-56822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E5A84CFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C51611F23C2B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0CB823DB;
	Wed,  7 Feb 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRS4/4Zx"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16217823D2
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326641; cv=none; b=E+sALX/B47AgKR6q+hsDUicBf5z/2f6BAq4i6iPpgopXvSzbCds7WOZtBeE75bZrmUOq4kaw23+tABrXXrj/9LXzQ1z0HhRXgMIYmVrSl97skx3Fj3L6hPHO2dgGsf/YKunzj6qR/5Rp/mmWcEUI3jOtzsi58ANAJVOf+iIt3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326641; c=relaxed/simple;
	bh=t+dNL8ajVst+djkWIBJwuyrhqa6AWnfWs+exL6JJTwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+xHGdzCD2qLGU5DdbR0MD0YnmLDgQdU4rRo89Urw8lIJI87DiLBSAwq65MeY2BS0bs9Ni6j9pDykLshvp7Bxlc36+ohhda8y4yxpxXzYn3vjbUSLHAG1CW9SU5G5TFT9hVo5mumrBjivcMf4cW4mJl1p+GZRZtAP9stYVg4fQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRS4/4Zx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-60492003050so8428407b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707326639; x=1707931439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+0FKXmQhnpOuWx6P6CoEBm1fYjHsOnkUW1Pee1IpEOM=;
        b=SRS4/4Zxhow7s0fsWAVpXDDn2FJC/CYBgh0nCosmR4PTSZu1htmfgjEGtC9v9gHu8d
         gLDbczjKO1GyANtXR41gpy2jGef74/fJtuZrgb0MG9Gj530imwEYxFAjFDLXrmJaWqrb
         04Tn5x4PBzse1RyObG2+06nG6sHnzZ11Ps8aT0Y0J5nf4B57DZqWyPrcozFhXcaOx9yX
         /u93XS0XjPmzJuBs0WpowogLfeXN8pqoM0J/9WH6IM9zoLZbX9PuAulImGHG2ysaxgR/
         0Iw9zkUrhXS/D8SlrZZH6Kp27cNs8VrRtkDeELh94pHw9dLAbtbX6i2KrcQLdKZuXnpY
         o7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326639; x=1707931439;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0FKXmQhnpOuWx6P6CoEBm1fYjHsOnkUW1Pee1IpEOM=;
        b=dG709B3O+2+olzo4ekqqgQQovz4NMoj50m2HntWrQnjXsDAVB6ZSeCRElT4pkUvHHL
         rJjs+1t5WM18c2iVEiWBoEo6G8rtDqfBJAERxAI5t7q6qcx1RbF95mHPdEkPMwDgfUvi
         AWQn7358sTMgHPY9520HR8vMKUpusLwaE5R8TlJufR89ekoteKuCjsjwFWDpzQ2SzRBX
         nYVIHx2xjP13G+3muCeKUhCTvuUOk3zDKsu04vYviIWqt9bIHbyt4SCyF3gwpHsIMKZF
         ytR0HpNBvj+zKNgWQeuhQBZVUVCgEmTHaTmd8r6rMXsjLB0h+y4BF5wsdAaqYeeCnHzM
         Y31A==
X-Gm-Message-State: AOJu0YzUS5jqz7/KCRofc+zzw8xI8uOxOgR0fVEoc7U0LEXn/B4I0awe
	20qP/hpGgYx9iDkh8mi/8FDodFDT0BCC9ksEPrNN3lOKfGjONOZZpiRQfiabvBQc+rF/pvjviK3
	EaJJ29Cwl+GkI7rjMhL2qbJdwUCg9faFKn0X89NC1cUC1jT8sZ0f8tA==
X-Google-Smtp-Source: AGHT+IGeCnmsxolePZ4ZnDhSAuANwHYjndNsJgU7gynZNwoZHY3zUbqi/DMbBIogisjXY6k5w+lV6vOHqBjo8OemdgQ=
X-Received: by 2002:a81:e901:0:b0:602:b7d3:9314 with SMTP id
 d1-20020a81e901000000b00602b7d39314mr6323538ywm.35.1707326638972; Wed, 07 Feb
 2024 09:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207170425.478558-1-enachman@marvell.com> <20240207170425.478558-2-enachman@marvell.com>
In-Reply-To: <20240207170425.478558-2-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 7 Feb 2024 18:23:22 +0100
Message-ID: <CAPDyKFqQ0bF3j3XQmTbEo-mzHXsH=2cvhTi1p1se1=rPmo90Wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: xenon: fix PHY init clock stability
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 18:04, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Each time SD/mmc phy is initialized, at times, in some of
> the attempts, phy fails to completes its initialization
> which results into timeout error. Per the HW spec, it is
> a pre-requisite to ensure a stable SD clock before a phy
> initialization is attempted.
>
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/mmc/host/sdhci-xenon-phy.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-xenon-phy.c b/drivers/mmc/host/sdhci-xenon-phy.c
> index 8cf3a375de65..4e99197b62c3 100644
> --- a/drivers/mmc/host/sdhci-xenon-phy.c
> +++ b/drivers/mmc/host/sdhci-xenon-phy.c
> @@ -216,6 +216,24 @@ static int xenon_alloc_emmc_phy(struct sdhci_host *host)
>         return 0;
>  }
>
> +static int xenon_check_stability_internal_clk(struct sdhci_host *host)
> +{
> +       u32 reg;
> +       ktime_t timeout;
> +
> +       /* Wait max 20 ms */
> +       timeout = ktime_add_ms(ktime_get(), 20);
> +       while (!((reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +               & SDHCI_CLOCK_INT_STABLE)) {
> +               if (ktime_after(ktime_get(), timeout)) {
> +                       dev_err(mmc_dev(host->mmc), "phy_init: Internal clock never stabilized.\n");
> +                       return -ETIMEDOUT;
> +               }
> +               usleep_range(900, 1100);
> +       }
> +       return 0;

Please convert the above into readx_poll_timeout() or similar.

> +}
> +
>  /*
>   * eMMC 5.0/5.1 PHY init/re-init.
>   * eMMC PHY init should be executed after:
> @@ -232,6 +250,11 @@ static int xenon_emmc_phy_init(struct sdhci_host *host)
>         struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         struct xenon_emmc_phy_regs *phy_regs = priv->emmc_phy_regs;
>
> +       int ret = xenon_check_stability_internal_clk(host);
> +
> +       if (ret)
> +               return ret;
> +
>         reg = sdhci_readl(host, phy_regs->timing_adj);
>         reg |= XENON_PHY_INITIALIZAION;
>         sdhci_writel(host, reg, phy_regs->timing_adj);

Kind regards
Uffe

