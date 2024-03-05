Return-Path: <linux-kernel+bounces-92342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624A4871ED3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48B5B23BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3015B67B;
	Tue,  5 Mar 2024 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/RhHz5V"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047D5BAC9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640923; cv=none; b=pMX9yFMS+Qvxi4pr4RFwUuaNpfpaRaknsNjkwb3ezLJic55IfSWDQ2geCr3J7QruJ+vD9TQEcu1UAHvQTaQitlloobIv0B2dzHW9nSWHpOUVu5rpe5WnZbPLMzooN4SmiGD0i24HSIRP7oq81zmF9bbS+rPIrg+3aV2CC+VnWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640923; c=relaxed/simple;
	bh=aIbb1y6977IQBkZ/bp56H879bh0Vy937a+tWbyOg/JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQKF1iGyb/sbmzL8tbboXqhALw1YiG2h/NvLRiBiTWUUVnlkDY2VWsbLUunzSN1Y8JwNSiOO/aSUbj15p7VijhqmCpVd4D4h2LHVbO0xDZrENMF+p8dRmmqDIRKH7InyTyqxXFvpRIcgG5UxY/Fl5qNogMCsOnHi86536uAj930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/RhHz5V; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso5606712276.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 04:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640920; x=1710245720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nd1S7MkPmJaZzvq5t+fXqIlS8Ad6jgg8iGnh7IRKP9Y=;
        b=D/RhHz5VxiZFbdNLT39hRVrgt+QlwaqILNtKeBxHBlC1S2SjEiT7MODYiPhTY0kHTb
         S4ESrVCZQqgWrUVByj1bp8qVn1jyCwI+e5KZCYswQ9cXK4U2InM24AbKSqMxLjc/ccgk
         ofSn6H0KxBAz/LlAq2xdFle3r8hVXGzJXwSFjoVRRtb2dr6HxD878uOFHjMdga0mxJui
         086fH5CM1YclSI2ZdiKMLqHBsl9Fui8895lYx/BOVxKD26mDHMb60xLIRBIx/MUzFuPL
         5m2Dcil9HMGFW67WAarepFEXPPRrryj42Zwp26gbHMKhYyo1eqGpX5e2Hnfobtx+R4+H
         Mh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640920; x=1710245720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nd1S7MkPmJaZzvq5t+fXqIlS8Ad6jgg8iGnh7IRKP9Y=;
        b=AjzoROHwnj32VLESvw+tqIOfsZ27OZ7Kk83NYIxSryOe5YFUmPGPpWyZ1+I6Cyb/SV
         bAAj3Vx5LQdvcW1l4Mwg/pJIEddfHvFpDoiC/50CaPjDZHAbPu5iX6OJE2zhobGFLnb/
         2VTElcSoTPqD2bvT84lUiVofUg5hdFaFGXLWmMUZNjhrF2KDpI8fIztfgZMrLrVQ7eV7
         dsBMDy+5UeaRL9LcdGkLMOye83/+MJnNA9PYgPjhlc+2y0PId0EweiGI64hjv4FzakSr
         +7A7oKCSTKyvLWdtVW4B0n/GinoQ3cX71+68PAVOKGNbnApC1SYS8R/I4galn7AIkMQD
         uAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6pdqoKs8vCED3fg6ndDfgca0nG1Mw36rFPXbxRlYuThuVBsZo4AZj0uW2/ey0kD4d6EjXrpYR+X0KpD/9YCgBlmNmrhT95rQWeDgi
X-Gm-Message-State: AOJu0YxpPbEr36RjFw/gZqzpmbptDDBkJQM8zVZmc85Rj5wsg2utv4V1
	yaJEtxNkt8OoYqxY8YgrYToQ2bAjcL5aUc3zV8do/o8NJvxqKHZoGm0KTHc/UgAOygsb9WLWX9h
	QfXlGBkADmIHpzupn+1Stf92DNKSZtQ5+k6ufOg==
X-Google-Smtp-Source: AGHT+IFb38GsRgce2KGsx0/Wwj0pEhfFF3NHBc9eAjpDvVHaHE04kKB+/yJB06PXTECa9X+ixXBG3PBFirGsewNigKc=
X-Received: by 2002:a25:adde:0:b0:dc7:3166:ad25 with SMTP id
 d30-20020a25adde000000b00dc73166ad25mr8366161ybe.25.1709640920491; Tue, 05
 Mar 2024 04:15:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304175606.1200076-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304175606.1200076-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:44 +0100
Message-ID: <CAPDyKFqKYhhEGvyhHuCh-U_nybXvyvVxnkbfQG682UfVZ5hkMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yangtao Li <frank.li@vivo.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 18:56, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 1 -
>  drivers/mmc/host/dw_mmc.c        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 698408e8bad0..6dc057718d2c 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -11,7 +11,6 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 829af2c98a44..8e2d676b9239 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -35,7 +35,6 @@
>  #include <linux/bitops.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/mmc/slot-gpio.h>
>
>  #include "dw_mmc.h"
> --
> 2.43.0.rc1.1.gbec44491f096
>

