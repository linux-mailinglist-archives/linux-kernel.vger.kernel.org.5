Return-Path: <linux-kernel+bounces-151060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586208AA87B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A16B225B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5048237168;
	Fri, 19 Apr 2024 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="G6zrlZsu"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18422F19
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508537; cv=none; b=X0Qtcj+GoRg5eZj31JWSl5V4R1CRYM+HPcR6BKGD5sLo8cPwP2TUafjl66zgrw9Gq/km33Rjyr6CcffEACyHf/N1Y+b/yqTFYK/0iINXS12QtiOVicCUvMOcvH3KVj1OpRTlxmUGEG4pHTqURgNWGcXsxGvsSor095NZusjVQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508537; c=relaxed/simple;
	bh=4rgHwkNtpkrPbHZ/6mKa2CrtRQuMWmRvT91ji1xehRY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XkvVkWq6YYrlLYZXICCo11YUAb6U1HZQHOymTA8vh971O27sl5WE/xtuiU8T3kCGXn8ISe3kcRTWlS5lAwpeulQAfhO6MabHYHyEHRPi1mtGVh9ZmKGsDYkhRg9RtdDzl9FCaxJzg/03qNpDU7H/8IfHycAzNCHsJFdABAE11tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=G6zrlZsu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2779469e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713508533; x=1714113333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cDLuzJx8FTKyJYvAzzyclCy6wt3NJpANs9C+tvdEryo=;
        b=G6zrlZsuDlPgykuxC/eJLn2bbav/qJGPUQCH/+tsG0WEau98E30IZkIDV9IpUJuyut
         g3b4h+wZk1SpRgMwVmkgQ194Fq9WfoN0fxYsYhITq5VqXaaRPnQlcXB6h6MmUWUN/f9G
         O8Le4uajdCU8tm+S+Q6f82jkP1vR2tx4UI0A1k5hQquxmv0TAIAZgUwMVeI1nous4z2v
         rKj48nXoXwdy0rNLnCGXx7kUmZFMY9HNnC7YstOxogBL+CjHgQFmuis6ZRmuelcHcMyM
         hnVTsyxw3E/O6uVbNtilYEjsIxDd53zjm40+xFqwLEbv2CppugsPWf1hwAmSzvPaPsre
         6UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508533; x=1714113333;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDLuzJx8FTKyJYvAzzyclCy6wt3NJpANs9C+tvdEryo=;
        b=j86/B6SaVnDbS0qx3/HIc3q+yVICt3XnGpkPbYmMmsc3ufep2u/wLDDyVGoHA20VfN
         hNXBVwX/Fa+5OjdG77VIbJ/4SXUqhWy9sEeI+JmdGuijD4J6vPtjdxfpbwshxn5L7V/q
         5V3qK5g528Isim3suqkIPYxTezQHZeAfhJC9DIEr1hfsCbGU7pLPIL4CWiV0ZLM2pm7X
         znuumWdat20TnHbw2Wpxil7T7BMhMVe2ADAhKLtBYgaHijVzTaa4fWNqFJpX6gb4x2kk
         FO0dCSSB9LpBcOZa2hKUpe4M14N523VHQ6Ji5POJ3E6h+6GN/+A9SiMIn1dWZ+J/v3/u
         jkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpYdSkjJyIdA2bKr6V8FWolHq/1ea8bX8h84PmdqmVGzpGNJURuGfmrhZlFopPbeTcCjvOwN/mefViJyeRrmReRLmh9KEe3NMbOUBW
X-Gm-Message-State: AOJu0YwuWWJY/9DPEOUpNbwRCFcd0JkUZf4DPtinDLxDsKYWW2oykCQ5
	qv3Dd1SNq9BiIL8IllcLySTTuiPG9u0knOvakkbRIRceNU+mOFmSFMDrRN1YGDbTw2OuxECPtnC
	Q
X-Google-Smtp-Source: AGHT+IFkMziwODTbzJ0/8seXSzEe66wdxvo6cFw/12UzX7ADiLrcWrfwxM4DGHZPm1r3DgKZXBzOMA==
X-Received: by 2002:ac2:5445:0:b0:517:8e01:266f with SMTP id d5-20020ac25445000000b005178e01266fmr838929lfn.2.1713508532687;
        Thu, 18 Apr 2024 23:35:32 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id kn9-20020a170906aa4900b00a534000d525sm1787597ejb.158.2024.04.18.23.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 23:35:32 -0700 (PDT)
Message-ID: <941bca2c-3a70-4c57-9d47-8334c320e8ce@tuxon.dev>
Date: Fri, 19 Apr 2024 09:35:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] pinctrl: renesas: rzg2l: Configure the interrupt type
 on resume
From: claudiu beznea <claudiu.beznea@tuxon.dev>
To: geert+renesas@glider.be, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, tglx@linutronix.de
Cc: linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240419061924.3363667-1-claudiu.beznea.uj@bp.renesas.com>
Content-Language: en-US
In-Reply-To: <20240419061924.3363667-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.04.2024 09:19, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
> source at the same time") removed the setup of TINT from
> rzg2l_irqc_irq_enable(). To address the spourious interrupt issue the setup
> of TINT has been moved in rzg2l_tint_set_edge() though
> rzg2l_disable_tint_and_set_tint_source(). With this, the interrupts are
> not properly re-configured after a suspend-to-RAM cycle. To address
> this issue and avoid spurious interrupts while resumming set the
> interrupt type before enabling it.
> 
> Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v3:

I just noticed I used the wrong versioning here and in patch title. Sorry
for that. I'll send an update.

Please ignore this patch.

Thank you,
Claudiu Beznea

> - moved dev_crit() out of critical section
> 
> Changes in v2:
> - none; this patch was part of series at [1] and added in v2 of that
>   series
> 
> [1] https://lore.kernel.org/all/20240320104230.446400-1-claudiu.beznea.uj@bp.renesas.com/
> 
>  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index 93916553bcc7..20425afc6b33 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -2045,7 +2045,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>  
>  	for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
>  		struct irq_data *data;
> +		unsigned long flags;
>  		unsigned int virq;
> +		int ret;
>  
>  		if (!pctrl->hwirq[i])
>  			continue;
> @@ -2063,17 +2065,18 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>  			continue;
>  		}
>  
> -		if (!irqd_irq_disabled(data)) {
> -			unsigned long flags;
> -
> -			/*
> -			 * This has to be atomically executed to protect against a concurrent
> -			 * interrupt.
> -			 */
> -			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +		/*
> +		 * This has to be atomically executed to protect against a concurrent
> +		 * interrupt.
> +		 */
> +		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
> +		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
> +		if (!ret && !irqd_irq_disabled(data))
>  			rzg2l_gpio_irq_enable(data);
> -			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
> -		}
> +		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
> +
> +		if (ret)
> +			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
>  	}
>  }
>  

