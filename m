Return-Path: <linux-kernel+bounces-53143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9684A135
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B341C2212E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683A945035;
	Mon,  5 Feb 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8TtvNPa"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B045956;
	Mon,  5 Feb 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155133; cv=none; b=gWAVcSIk+3cXwTgmekC8Ornns8vgrw0OmE1Op19fiILIvpFKnAfXWkftQoJk8B+eyPr0oHVxc2L96fVXiY2X/KU10ozNcpl+XclO9YSstHypDuRcRzfltsFrZySHtSDUiiqLOCYpI6dpAG7Ha3xN8MxP+uXfTBz2sUiKexETUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155133; c=relaxed/simple;
	bh=q8q3Eg7TN3B/c8h/YhNFwlgyrORWB5GQFswTspm1G8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p98myQJAwAhLq4ClS1Jsb7qeBdv/mB/6S2wuQiGi6wEIcSIumgCbCfnVyEj2ZCtMyJZ5v+eBOoSotuoACG9ejt//h05mzSb4ylhWweAm5uPr4y45ppxJnRcLoVh7/apZ2xblY9X/Im6qrjUdK0s/0GCYOs6umuRoC19sWtH4yYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8TtvNPa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fdc653665so8792105e9.3;
        Mon, 05 Feb 2024 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155130; x=1707759930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0wzRpVZw3TnGWQm+s3AU8BkpazXaoqZkM6kOW1G/WQ=;
        b=O8TtvNPagV6vJGSIsqRQVVTHIDq79CZ7BQZFH183e6cw1j8XPq6UAZVFncblFeMiNz
         6tj5Rjc7klGl3XjKij8/j0FPgKikOxuDcgPaRLmicmLLkh6jn1pcyT4iL00/Q9aST9kX
         WqlQbMqAhEXZQ25AqpcYJxCYBDPIVxf4JtnIxlGb9W2ol6TVF4yu6swxsnfbiUIXwJR3
         miXkW+7dL8us9umPE5ngxyAhczVg5czUn87bLldu7OfmayafYGIZ88j4idNGhn2DVYR/
         zGiKOmrXuz7nICZgLhMNPLKwAX6Njg1cnv0NdWO7/ryzFOSCBKFebvtsqC+5mTNqLBAI
         YBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155130; x=1707759930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0wzRpVZw3TnGWQm+s3AU8BkpazXaoqZkM6kOW1G/WQ=;
        b=QCGRXjwHCNDmuPMifA7orUqToFRPJtx2kJWsymbvv5EzCVLmAUQiftOZ5lfw5Y4F36
         qntQS8vPNzdCEyjVxKgxyeL7W+TwK1z14G0kOsEunsUtflChUTm/vMvX6sU1hk2rtQcc
         lS+26Y9VqLIyzzHmt9dhsn1j0Y72tB98EtD2B/cQtHDkrZxzS4xIAoYhwcsv5LD3DGcj
         l6ldBoUCaXvEvnkcpyENqWiD8w1284CEJbJDeP8rOKihGijgrXt1GCASnMBcfEHGAxGI
         wytpocOKcrDoh6wWkUy993Ty/7LgRjsLJL/c7naJHcrgIP0UIUOpSfpRzjDR4zz12fk2
         g7VA==
X-Gm-Message-State: AOJu0Yzk0/BaDxxKjzvgFRcLmWshkdVCs92Q8tjtAEVKyBrtl+SZVGHp
	8SdYcBpbQRlO7B12ltUjCpit+7ZbUJ0QFybwyWzl6pN5pVJpFp5r
X-Google-Smtp-Source: AGHT+IHDzn+x37VJ4FfaK12jdyWyrj6HN0Ue2YwTRPprISDD+A1uWFfuwbmrJ9tOHYqi9adBbIFrKQ==
X-Received: by 2002:a05:600c:3011:b0:40f:ddb1:dff6 with SMTP id j17-20020a05600c301100b0040fddb1dff6mr376290wmh.28.1707155129866;
        Mon, 05 Feb 2024 09:45:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0iRwJ4iK/1l5nccg8ejnbUpry1gNIfzjuLEOOT/5O1SnadHX8mF30Lt3dBquSMQ9iBWZaAoK5LYPVtw1BvDa73qNxIRIEekrw9/tuSsE5FzQt8XqtRIPnpXQ5cBWwzSiyse3B9eo51Np58H2ro7TB/GI/P/+CiHaHz9l4Le+ywVgofn63hBmTW+4vTMr9if42Vwn/dFxY+ZoTJO/4Bbs7c2Pmq4TiVExtmgujQocrxxEfWCd87n9GOQkCjgtFaKP/4JvXK+xvBpDrHK4CNj2wgp8h2GcBza2Gryvws8wnBOfFmbl1fL0/Cki6IYQ/19GQzIiRsikzV1xeytnJRhJzMjXH/HgPSktAktmvacMmOrTc27BBfSsxAcKCD/RwdZdN6utM9vwri1vyVZFbjwetOyIut79zZ+5d4g6jB1n4zLn1puq56QGYEHZVkxdnVD6UfOBCEMjn3FDx+gMRd1AgLnMuyWx/m1ENdeCIhAEdosVo2qjy9NEJlCNXhcpHWTP0Xk9O1mVBuJfKvCqNe+9ibSfD5ULoPlfEY7EzcpDDSDCNWa+nWgN6gC2dI7Hx1NlJXasSQMEDTDJZtP/CVz57zJIbVlcGNKGpgGof8Fv5KYPm03vyNz6Q2m+mMgPqqO69hb240frSev4L8YN8ugz7sHcK2k0XYvOn48j3wO+GP6KwVjX7XHv3AQ5KNx+fiauVQqvytkLaskwKk8P3CQRoi3zlNdwsuY4qSgZRAIl7VDRi/9pVggsxdyZfaqTsgbT9c5hy+uXxRA==
Received: from jernej-laptop.localnet (82-149-13-182.dynamic.telemach.net. [82.149.13.182])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b0040e541ddcb1sm499607wms.33.2024.02.05.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:45:29 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH v2 1/6] clk: sunxi-ng: nkm: Support constraints on m/n ratio and
 parent rate
Date: Mon, 05 Feb 2024 18:45:27 +0100
Message-ID: <2717565.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240205-pinephone-pll-fixes-v2-1-96a46a2d8c9b@oltmanns.dev>
References:
 <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-1-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 05. februar 2024 ob 16:22:24 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraints for the
> PLL-MIPI clock:
>  - M/N <= 3
>  - (PLL_VIDEO0)/M >= 24MHz
> 
> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
> these constraints.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Haven't we discussed that this patch is unnecessary because same effect can
be reached by limiting minimum frequency?

Best regards,
Jernej

> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 21 +++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 853f84398e2b..1168d894d636 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -16,6 +16,20 @@ struct _ccu_nkm {
>  	unsigned long	m, min_m, max_m;
>  };
>  
> +static bool ccu_nkm_is_valid_rate(struct ccu_common *common, unsigned long parent,
> +				  unsigned long n, unsigned long m)
> +{
> +	struct ccu_nkm *nkm = container_of(common, struct ccu_nkm, common);
> +
> +	if (nkm->max_m_n_ratio && (m > nkm->max_m_n_ratio * n))
> +		return false;
> +
> +	if (nkm->min_parent_m_ratio && (parent < nkm->min_parent_m_ratio * m))
> +		return false;
> +
> +	return true;
> +}
> +
>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
>  						       struct clk_hw *parent_hw,
>  						       unsigned long *parent, unsigned long rate,
> @@ -31,6 +45,10 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
>  				unsigned long tmp_rate, tmp_parent;
>  
>  				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
> +
> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
> +					continue;
> +
>  				tmp_rate = tmp_parent * _n * _k / _m;
>  
>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
> @@ -64,6 +82,9 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
> +				if (!ccu_nkm_is_valid_rate(common, parent, _n, _m))
> +					continue;
> +
>  				unsigned long tmp_rate;
>  
>  				tmp_rate = parent * _n * _k / _m;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index 6601defb3f38..c409212ee40e 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -27,6 +27,8 @@ struct ccu_nkm {
>  	struct ccu_mux_internal	mux;
>  
>  	unsigned int		fixed_post_div;
> +	unsigned long		max_m_n_ratio;
> +	unsigned long		min_parent_m_ratio;
>  
>  	struct ccu_common	common;
>  };
> 
> 





