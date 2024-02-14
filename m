Return-Path: <linux-kernel+bounces-64606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3458540CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113F8B22B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DC865C;
	Wed, 14 Feb 2024 00:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jJimc6gH"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772D370
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707870183; cv=none; b=KfFSk6pMVdR+OZhnir+3rd19imD5SY2qF5bOGwKsgJ2WgBsku7nySxRE1HJ4kUdiB8Ok6/RFJ0MVqtJByW7WFne8Df4SaW0ZISRDjcqiLhjS7iVFAcjm1/lT24N+1k49PkxolSEtJGbGYUX8rL63Lx9UsNiGGbIiL5cNdDDnWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707870183; c=relaxed/simple;
	bh=ds1jHombM1rmzITyFT/LkXRFY7v4NO/aeENbS+5oo6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbthYt3HQJl8cy57eJIcaKncpPeU0nNOJvhzbZSA3EvcNU5wXmSSGt3Dk8WsCtjma+d2fyMOh6ttaBtM5gKeDdxLHx6paWadaGtAMzmrApMP07S7t7sfgVbe17poB0C2khIdb5zRfDGNCYnss2bf6KteMoUdGH/VUv0Ub0pPHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jJimc6gH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3642281e4a6so2888735ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707870180; x=1708474980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/jWP8VrxhP1EJOZNrm4lfKLrk9GA9+9HRFG23gj3nBY=;
        b=jJimc6gHBAKgrxSZZ05CWOM7i4T2HKO8pFbhNqKPEE50d+6UigKIHUSqcYtadIoQOc
         fLVfX0o6E/FO+BhWrsv4VuKwDAKKDzWYkUVfyo0tv6t3NbWfs+GbBOkaDrAMAxHPMFLS
         CD/L+es5Z73GHiZLbrD4s5Jbl8NqvkFw5OXI2EsowDSa8/8FBTAOChYD2n9YGLr3gUNI
         wlrJJNLRo7aEfCLsD5bVLjmS6xNxzma98f8jf2ZJ48WoXe2q5Tc+VBO+4Zgv3eBu+fy2
         p1hW2Z/4frDRmr5eoKhNjZH11jDW1pkUVaUSFFkJky1UdEqdy6pusQR7BdY1aXAChiM1
         YYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707870180; x=1708474980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jWP8VrxhP1EJOZNrm4lfKLrk9GA9+9HRFG23gj3nBY=;
        b=bgEkBwWeFXhCg7jCqVahJPsbryiGPND9lq3AAhkIriNphv3Xa+TsQkEuYBaKbcK8mc
         J/lKh5UiH9e7IAnyLs/EK0N721oz3LlgIZ1ddBr/IAx/toYjOBW6uBGhLyBHXc0GjGOE
         8n2A/FmyTjOPuwFdCcYCiRNgDH9IIXIBfTOxP1X0Z2MyaTnqWFr4QkBIKPINT7kMFAkr
         LnxXowg+phqWLMtgIWAPn/FHXEyMxtqkrFcvYFtDphR1jzZ0K/gjClCWSgayhyIVXwxq
         O2GumXrGW+Yae/8YxSKsKpKB0JzgNu8lykASXTqnGwIKDulveeybWfoopfGa6nYyt9Up
         2QHw==
X-Forwarded-Encrypted: i=1; AJvYcCVK2bech0IN7WiWcosDxijp/iuNNRlbWwXnCI8KRIXWi7Od27fMWFYH+rC/2Hj9k9UEV2DuVfxxxYImtKUP0HDSZ5WWVbjCjxJtZ14s
X-Gm-Message-State: AOJu0YzVtRK7N3qa2mZOlJYDL3xvR740pTGaWjyi9EnXwWXn+w0TXObo
	qt/byisUOdVubvdhKxvQ99c7GR5pkiqP2mUMvgnQicdYy8mNrewVI0wPRE00bg==
X-Google-Smtp-Source: AGHT+IGi6VVf6G6G8U5GGlsAZixQm5utU4tQarB9++MQ9JBSEGLE5FtrB605cWFIAkOkehjJn7O4vg==
X-Received: by 2002:a05:6e02:dd3:b0:363:9eb7:46ce with SMTP id l19-20020a056e020dd300b003639eb746cemr1293877ilj.11.1707870180370;
        Tue, 13 Feb 2024 16:23:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJKMkm18l+fATv5w8BOBEKdFq5seFQbl5h8/yelfPushV4gdBWN7jKSCWpz1BhL0Sti/1SuJTgYJ/fcVNH6XkrSm0NoaHSTSiI/fHwLilNsRJJtzimpBrGCTjtT9d3s2Ax3XegIe224IxqH7rcEwDA/kG7pamQItEMG58Jw4j5Ztxy29vglNeTsEkMdK0qDj8iMdP55M3/SCtxrS7QqjBNmHKuqoD07nm1SOMqL4/+aRObxOrky5V8t79knGogtBK/fly+mKEsz6LWFLZ/wRwleXiVozK6opOE16Q1C7tq1q89SonCNFWA89DU4D2TqFFavCW50sbPG+21GohBloHyGfw0ifOY2bFFrKJpEW3nXIMdIk7lVG+8R/xWdpNr5QXw1S7YliqMm+3mZOK0/P1E6lS9JjXddM/7Krxk56meFswS3dbQgAEWldQtjWJza6FMFw9c/mH20D+fWerx4TZ/afCihkwC1TzV+rBBmcZJRaKcldG2sFu38nMuPrF6aGgtI8dpeqPq8y0bVNRQfBUdTcdcWkCYI2pY3Cm0qX1G3/4M+87FoJzMfaTmNQydVUReHzA5OP8dyUn5MgQ=
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id s11-20020a056e021a0b00b00363a91effdbsm2807134ild.76.2024.02.13.16.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:22:59 -0800 (PST)
Date: Wed, 14 Feb 2024 00:22:57 +0000
From: Justin Stitt <justinstitt@google.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2 1/2] ASoC: meson: aiu: fix function pointer type
 mismatch
Message-ID: <20240214002257.bfp6wk5j3wsaq6f6@google.com>
References: <20240213215807.3326688-1-jbrunet@baylibre.com>
 <20240213215807.3326688-2-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213215807.3326688-2-jbrunet@baylibre.com>

Hi,

On Tue, Feb 13, 2024 at 10:58:03PM +0100, Jerome Brunet wrote:
> clang-16 warns about casting functions to incompatible types, as is done
> here to call clk_disable_unprepare:
>
> sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   243 |                                        (void(*)(void *))clk_disable_unprepare,
>
> The pattern of getting, enabling and setting a disable callback for a
> clock can be replaced with devm_clk_get_enabled(), which also fixes
> this warning.
>
> Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Silences the warning and makes the code more readable without adding any
new helpers. Awesome!

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  sound/soc/meson/aiu.c | 19 ++++---------------
>  sound/soc/meson/aiu.h |  1 -
>  2 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
> index 7109b81cc3d0..5d1419ed7a62 100644
> --- a/sound/soc/meson/aiu.c
> +++ b/sound/soc/meson/aiu.c
> @@ -212,11 +212,12 @@ static const char * const aiu_spdif_ids[] = {
>  static int aiu_clk_get(struct device *dev)
>  {
>  	struct aiu *aiu = dev_get_drvdata(dev);
> +	struct clk *pclk;
>  	int ret;
>
> -	aiu->pclk = devm_clk_get(dev, "pclk");
> -	if (IS_ERR(aiu->pclk))
> -		return dev_err_probe(dev, PTR_ERR(aiu->pclk), "Can't get the aiu pclk\n");
> +	pclk = devm_clk_get_enabled(dev, "pclk");
> +	if (IS_ERR(pclk))
> +		return dev_err_probe(dev, PTR_ERR(pclk), "Can't get the aiu pclk\n");
>
>  	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
>  	if (IS_ERR(aiu->spdif_mclk))
> @@ -233,18 +234,6 @@ static int aiu_clk_get(struct device *dev)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
>
> -	ret = clk_prepare_enable(aiu->pclk);
> -	if (ret) {
> -		dev_err(dev, "peripheral clock enable failed\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(dev,
> -				       (void(*)(void *))clk_disable_unprepare,
> -				       aiu->pclk);
> -	if (ret)
> -		dev_err(dev, "failed to add reset action on pclk");
> -
>  	return ret;
>  }
>
> diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
> index 393b6c2307e4..0f94c8bf6081 100644
> --- a/sound/soc/meson/aiu.h
> +++ b/sound/soc/meson/aiu.h
> @@ -33,7 +33,6 @@ struct aiu_platform_data {
>  };
>
>  struct aiu {
> -	struct clk *pclk;
>  	struct clk *spdif_mclk;
>  	struct aiu_interface i2s;
>  	struct aiu_interface spdif;
> --
> 2.43.0
>
Thanks
Justin

