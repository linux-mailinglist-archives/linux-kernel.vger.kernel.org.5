Return-Path: <linux-kernel+bounces-139004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A0D89FD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9EE1F2365F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727017BB0A;
	Wed, 10 Apr 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmX4cPSY"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638017B509;
	Wed, 10 Apr 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767340; cv=none; b=V6L3iXSPFjztN+QTIU0k24iaIcfSDPCk7obO1M9dCCsaR0ilzeFrojW9k+Fi3NsFVLfZSWgB9rk0ACNDx+nMr1BfzEgrtgc8sWPKbim6wV8sr4CmCJNV3bm+MdZDg8vjkLnt7vBZtMihgLIEt1ekP/wFVPZ6MVF6Mx9FSgHmNQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767340; c=relaxed/simple;
	bh=cGSRA9NRskOtx7BiKrdwMBb/GUB9hi1vnIfiQtqEtiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESqTHtmoy7HJa7zZoZBRR3xsR8EVcxvg+xESrjRr4NxG1tojtQgMHF8bhY0A6eJDolYrF856IFrtLKZFijAqxjuZcqBm2Q/OXiZZuHq8Csrz844f5gbLSy69eIZM8Q+gXby/QZKuT1UNnprDFX9PLLGLFl3jPmUnJJZqkL+C0M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmX4cPSY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e782e955adso6479907b3a.3;
        Wed, 10 Apr 2024 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712767338; x=1713372138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i1wmw2mMPSRkhuovOR1DZZ4vuH+o+We5P/YgCIA7CtU=;
        b=LmX4cPSYafu7y1Gteyl9Nb9rY/mqnxkCnQFLdXd0nNovwm8LzRdmvbZTHVaXvNB5Gt
         9bZzO+l18sq3vdqkEXFRbQ87mf0ojNY92OAqpSYpcoVlfr6xebgEvRbSNQxskRXakZQe
         KShFNECx/56y62//8c8k+3v3JOmf8EtQkkehPnN3T08LFh4NcyUEbOwAExERNvfguC0Z
         ys4JIJNOiJLUlJAlgI/NgZD2uJ9t/cwUX9wGZSpHcLdL1CVyljYUdEfT69NO8s/Bx5Tn
         pHKEsMQ0kYUE8x/7RgE/t6ZE0UWCxeSw2BflBZagkmI3ertZfQbanfE90sYpLv5JQsj5
         hrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767338; x=1713372138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1wmw2mMPSRkhuovOR1DZZ4vuH+o+We5P/YgCIA7CtU=;
        b=cMQk9+gqgUWBzREVBoy93FNJHYiY22n/3qXpNkY+K6z8iouqo0O9xg6nMw6761qDdj
         GxYzf5AjER2+FnorN84dy0wuUQH38fEVX5F8YRkQiW58o66tlWEVdi2Rk7bddk8SqRXQ
         ted6DPbx7Ku45LefSp5SR66iWXG+ZzfFwIs1ePoEWHyGLNH2FNlJ3pdNURmRqsY7iDEk
         8oKPd9xWAEWQ9OyEshM3SVoiAdM1j4MXC31mR9MsH887equbLLWZq4ZexvehN9JumXMB
         N1kfpXW6T2rDLwej+9o/RSdFNaAmMdkGzNnE0XID1/U/kf+B4oO5tSQJEgi3Y6k+5RpD
         zn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhZDnw0+tdS5EEzSeOsyI1gPJJqQFFeuk9SRt94BqpoxwezgN4mKczMcOKgu+N9O0u3Kzo6N9M6ZbSeauT1VAFK3u5QoWqRFAB+TNlA7mC3nytrREN8BkEkhRpACe+325ZxWNFoFTvqamyU0p1FRDc8O3md90tCaj7sVrHSti83/AfoPR5r6k014EUbevdIJwPDLjGC6nBO34PxAUTCM8fAC+03kMen6t00zU=
X-Gm-Message-State: AOJu0Yz2599gFz7wyGtgcDa3eFEWAB+G4eze4InMB4dJFo125m1HKJ8L
	250PXK0s0M/S4BbxHwbUyaVSaMEdp9+jLOMSk3JJ2n1iVYuMD5HR
X-Google-Smtp-Source: AGHT+IEUEp7kz6r7w9N/UbMUVKnvLaS4UEgK6qAeoZJfe6ieW5hu5mzajzM5kQ0xwKXtI+Zl89Mrvw==
X-Received: by 2002:a17:902:9348:b0:1e2:a449:da15 with SMTP id g8-20020a170902934800b001e2a449da15mr2794508plp.15.1712767337944;
        Wed, 10 Apr 2024 09:42:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902ed4600b001e0b5eeee41sm10953339plb.38.2024.04.10.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:42:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 09:42:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH RESEND v8 07/10] watchdog: rzg2l_wdt: Rely on the reset
 driver for doing proper reset
Message-ID: <e39ba4c9-a577-4fe3-8dc5-e3a2aaeb1b38@roeck-us.net>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-8-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134044.2138310-8-claudiu.beznea.uj@bp.renesas.com>

On Wed, Apr 10, 2024 at 04:40:41PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The reset driver has been adapted in commit da235d2fac21
> ("clk: renesas: rzg2l: Check reset monitor registers") to check the reset
> monitor bits before declaring reset asserts/de-asserts as
> successful/failure operations. With that, there is no need to keep the
> reset workaround for RZ/V2M in place in the watchdog driver.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - none
> 
> Changes in v6:
> - none
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - collected tag
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - none
> 
>  drivers/watchdog/rzg2l_wdt.c | 39 ++++--------------------------------
>  1 file changed, 4 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 29eb47bcf984..42f1d5d6f07e 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -8,7 +8,6 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -54,35 +53,11 @@ struct rzg2l_wdt_priv {
>  	struct reset_control *rstc;
>  	unsigned long osc_clk_rate;
>  	unsigned long delay;
> -	unsigned long minimum_assertion_period;
>  	struct clk *pclk;
>  	struct clk *osc_clk;
>  	enum rz_wdt_type devtype;
>  };
>  
> -static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
> -{
> -	int err, status;
> -
> -	if (priv->devtype == WDT_RZV2M) {
> -		/* WDT needs TYPE-B reset control */
> -		err = reset_control_assert(priv->rstc);
> -		if (err)
> -			return err;
> -		ndelay(priv->minimum_assertion_period);
> -		err = reset_control_deassert(priv->rstc);
> -		if (err)
> -			return err;
> -		err = read_poll_timeout(reset_control_status, status,
> -					status != 1, 0, 1000, false,
> -					priv->rstc);
> -	} else {
> -		err = reset_control_reset(priv->rstc);
> -	}
> -
> -	return err;
> -}
> -
>  static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
>  {
>  	/* delay timer when change the setting register */
> @@ -187,13 +162,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  			     unsigned long action, void *data)
>  {
>  	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +	int ret;
>  
>  	clk_prepare_enable(priv->pclk);
>  	clk_prepare_enable(priv->osc_clk);
>  
>  	if (priv->devtype == WDT_RZG2L) {
> -		int ret;
> -
>  		ret = reset_control_deassert(priv->rstc);
>  		if (ret)
>  			return ret;
> @@ -205,7 +179,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>  		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
>  	} else {
>  		/* RZ/V2M doesn't have parity error registers */
> -		rzg2l_wdt_reset(priv);
> +		ret = reset_control_reset(priv->rstc);
> +		if (ret)
> +			return ret;
>  
>  		wdev->timeout = 0;
>  
> @@ -297,13 +273,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
>  
>  	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
>  
> -	if (priv->devtype == WDT_RZV2M) {
> -		priv->minimum_assertion_period = RZV2M_A_NSEC +
> -			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
> -			max(F2CYCLE_NSEC(priv->osc_clk_rate),
> -			    F2CYCLE_NSEC(pclk_rate));
> -	}
> -
>  	pm_runtime_enable(&pdev->dev);
>  
>  	priv->wdev.info = &rzg2l_wdt_ident;
> -- 
> 2.39.2
> 

