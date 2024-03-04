Return-Path: <linux-kernel+bounces-91209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BFC870B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BC91F21C46
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333E7A70D;
	Mon,  4 Mar 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JmKDPuZd"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820879DD2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583146; cv=none; b=UKUm5kBhOmlC7EBr6aWWIvsxepRBuSeQ3ptM2dZvdht8/aj2nHl+FaaMD6lrrVlG35EJKkYPrVROE7AxX5/NPwTHMWM4Sck0DfpKxr3uaTerJRex3ZETaWRrY2quhJLG8nZae/biKKUghPEA+dsgDR3fL1AwSxRKRCzjhroPets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583146; c=relaxed/simple;
	bh=9e1w14lVhFmrPtPSUWZqcNue3UJPDbsF7j742qbsVu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXB1RoTfCsXxgyJiPWJ+eO5ydbZbfmVF7xiOY4j0q+0J53aVj/7L990FSwePAi+lmrKBA8jP4a/bdz4iBcbe9WtkkO3Z2HHQZq4P7GVABfGGkJIF6AJGGMBvukaa+xMExxPDDH1vbeoqHXf7tn0aV4qaKCBNuSRwAQDXnxdu+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JmKDPuZd; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60983233a0dso40744887b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709583143; x=1710187943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAiT61kggRPd5YDuiyv4v5ZMae/k0uuT4kkoEq4NmCU=;
        b=JmKDPuZdkUWp65KnSpv+MevYQv7eI0Yc74bY4zjpl44bdDZRCCWZH4hcq/1WBcSCa2
         KHoMBEVM6w6wWILhtMEWU57DVieWgKXcpETKgsfPOiAmTAsjtTu5InqbRRy2aPq2IX7b
         jktsmts4LCGkTELXlCDqzrrb1Z353AVpXg21lT0H13XThZMGYKRwO2v1YPo2CL7jJx0E
         NGhwvQcaJ7XPRQrUBf3lYND916eaqV1ai95g2IFpiDLDarzA9aUACOZm2Ym+MH2l53Ma
         P08i6rPvY5PbMpCjbaXF8D0Ooo4lM56wjFqaRVGj8wElyDSUa4ls4VeVhpXc1bup/kEK
         yjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583143; x=1710187943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAiT61kggRPd5YDuiyv4v5ZMae/k0uuT4kkoEq4NmCU=;
        b=tZ7peHXMzx7L1GU4er/KxRPzgRn7L/+eQEwaBNY6UL9iNKIe3mlPOYYslREdeS4lvj
         UVTnrgnPBk49RgaqH2boxhXuYnV6/y1oE8EOlKhEgh7nLLSs70pLHaFzP0x2IEwg1K43
         g5UxXuTLhizjJJxCvvrk7PE5BdNe+dPrVsq6WQjhPDuzPbDP0LMWF9BbPwsbMrqmJkYM
         Fdd5B6NmDU9CpyS+rP5Sx1DJu6ZxAcuoM15jjfMr8g0Ns4A8Oh7jghZEcAxW1uS61o0+
         ZOWcMBRfdpSJW/Z4c8WUbQCNyoB/tXElh8hFtvmNYhJCYjSf+2b0FbcZdLoopsPMh7yr
         FxFw==
X-Forwarded-Encrypted: i=1; AJvYcCX9SJBWdD0FpZwJjNFdmZ1v93BO0ppRDzrbxYQgyb+bTky0IQfyX1HKt+4kYdGr8wW9j+JKJOFtAXhob45eKNaOpr595r1oKkcZk8pT
X-Gm-Message-State: AOJu0YyBqqAqqofyVRV3zg6KIFZk6PiXpc/8bg+wmxzIofqxBlBJDQs3
	SAT2Ut9xpTa9DU0pqWZ1pQQIaPPV98TEtXH7xuMQRh39H5wXhI1fEXed2yRP74f4NOdBcuNWGgG
	fgvxIehBnHp0w4R2I+pUdjoNh0WhXvhsmOekyug==
X-Google-Smtp-Source: AGHT+IEqPJr4eKDnDYSeNoerMYFKAQrjzVTavb++7VXTSjtLAfm4FVFMvf/uNcNvjlfalWRr+qEPl3nwmkUNiNJTO9E=
X-Received: by 2002:a25:5f51:0:b0:dc6:be64:cfd1 with SMTP id
 h17-20020a255f51000000b00dc6be64cfd1mr7740725ybm.36.1709583143696; Mon, 04
 Mar 2024 12:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304175606.1200076-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304175606.1200076-1-andriy.shevchenko@linux.intel.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 4 Mar 2024 14:12:12 -0600
Message-ID: <CAPLW+4nqhMdiVNjZ+HJykBN6pSrZmwaeG6CHxfBTZ=-zwheVJA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: dw_mmc: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yangtao Li <frank.li@vivo.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:56=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/mmc/host/dw_mmc-exynos.c | 1 -
>  drivers/mmc/host/dw_mmc.c        | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-e=
xynos.c
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
>

