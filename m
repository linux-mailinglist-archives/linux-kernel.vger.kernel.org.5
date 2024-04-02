Return-Path: <linux-kernel+bounces-127794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC83895113
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1170B26221
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64CC74262;
	Tue,  2 Apr 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iW6au1Wo"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843E36A8A5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055460; cv=none; b=XPgArUeJx7VuZCpTA3k2yS+GIpwi5PxIAWU/pLBzAT3qH2wrLK01+KCuBH3LZKj+QySI6zEZWwTaAzOoy8TtfUZj8wIYu8phehUJoOXngETjBQtrQGxQLWAoLF/fz66UyCUe+G+WQWmXLvYVCL70q3aXseD7ZUuBjz2f3vHJ2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055460; c=relaxed/simple;
	bh=wzQQNRkk/cIJeNXurzU1rbOp4yzYxebV0qz2Ei6O5JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiT3GLJy50N6kMZkSFaf6h4nFd7L79oe6Ix2qY4UbAfPZVefqlezz9I5ON54uiZb01nWM1eD70xRFjROvYYrchCGGlUb1l0W0xyalnmnukqpqPexQ5WlZmbDz5nncSAj+zEou01+2W+4vbohGTEflFMWfrf/o4k9yuPJA+38k2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iW6au1Wo; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61453963883so39599227b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055457; x=1712660257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4YHqSqNnvCBnfvFBqJv11ufJI1u3AY17gf0vN4REjDw=;
        b=iW6au1Wo7YSYvo37ijC5j0qTZTJV02WByLo7dB5iGY8QVEfxo454hmIKusFtg0syvi
         ONFe+HeV8x2IKzLY/kdUVsg5jh2N8gfq5I6mOGfT9/PNaMFfIVKEH5BZY0XD7RH2rwOw
         cGZm2mxF+Dn3psM2n3T4r8ydRT5G6SFfSl1sjBOgXhlEOI4KEmTTWaji1SeYbHWU9SaI
         KPJv8LadsP5rEANsXtlQZYKbAkCz9+AeuLT8kmwYs5c9M5PXM+ic0GYGwqNLmcLA4Nn8
         yEPuNmU/PTaf8zqq8BSnR6cBklqZBaQ7xsBsrj8ZZYvG3pj9u56ovME17NaRB/pJ2hrB
         HlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055457; x=1712660257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YHqSqNnvCBnfvFBqJv11ufJI1u3AY17gf0vN4REjDw=;
        b=gIkRzuvNEmVqDe02ygTg2Aw874JwTG2GZjUuZ4KKilbVngDyrj5PYuzRsAk7Zifs80
         FJPuitDviJcxFZ1akBcEwVJLPWBSa6//mog5Vy0PNBgVSlvybsfsWc0pzMRlFwH3F0pf
         AbR2I3OVA+kDk1/omTTROGEKN/c0miBgE9XpgNYgv4RmLD6cCJgJP7XsxUqtrpgxhhVQ
         1yShibPm4mi9n8PM0Q6bH77CiJl1sTAlJ/YOVbgYiPjpX6YwOvYrMJd3ibrp05+XjdQa
         I0IqS/XMJUilLH7oOUPi7KGP6+3NK1GF4rtYL0rfiJ2LrajiRGIZQ5tYpzGsQUZpGTH8
         spMQ==
X-Gm-Message-State: AOJu0YzgbChwsNWh6G0EMbVJwoMvm7FtlXu+qxJRySUd4RI3ayzkMXL4
	7apgpLvg/Bkizi5Jg5UOG3nOb6OJSa+EGeyFtKzwUiyK5dORIHhVq/cCeMzC1xP7fzonGHpr8GK
	sLtu3X9HouwHRvY7k3RM2+wqUR+4FPxudiBt7ivIICQTuBBp6
X-Google-Smtp-Source: AGHT+IGgzSZ2JPE3HDf7VGawmgSPSJjQToKcv+LLCVOO4BPYFSbmLubksF4TLEbW5Dw4jfNw/sq7EGDlqA7OfMewmEQ=
X-Received: by 2002:a81:710b:0:b0:60a:74d:7ff3 with SMTP id
 m11-20020a81710b000000b0060a074d7ff3mr11793721ywc.47.1712055456211; Tue, 02
 Apr 2024 03:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326164733.15271-1-adureghello@baylibre.com>
In-Reply-To: <20240326164733.15271-1-adureghello@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:57:00 +0200
Message-ID: <CAPDyKFruMSy0CQphbP6Z8YVeC1xP=N68C+MTV8jzVkdvjyEUuA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update Angelo Dureghello e-mail address
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 17:49, Angelo Dureghello
<adureghello@baylibre.com> wrote:
>
> Update my e-mail address to adureghello@baylibre.com.
>
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa3b947fb080..c3e365b9d759 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8512,7 +8512,7 @@ F:        Documentation/devicetree/bindings/crypto/fsl,sec-v4.0*
>  F:     drivers/crypto/caam/
>
>  FREESCALE COLDFIRE M5441X MMC DRIVER
> -M:     Angelo Dureghello <angelo.dureghello@timesys.com>
> +M:     Angelo Dureghello <adureghello@baylibre.com>
>  L:     linux-mmc@vger.kernel.org
>  S:     Maintained
>  F:     drivers/mmc/host/sdhci-esdhc-mcf.c
> --
> 2.43.1
>
>

