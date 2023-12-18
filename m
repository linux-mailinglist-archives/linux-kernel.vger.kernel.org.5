Return-Path: <linux-kernel+bounces-4173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6B28178C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAFE1C24E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBD45A875;
	Mon, 18 Dec 2023 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="QZq2hHey"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF22125C8;
	Mon, 18 Dec 2023 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sv6MX6LDzz9sp7;
	Mon, 18 Dec 2023 18:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1702920728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+vve0NiBqF/ep9e79zQnM4N2qRMtt/LCYu4PuzewmJ0=;
	b=QZq2hHeyxhgZWBwpbBlpRX5VLY/977BHVX6kCqLDDjCUMrNBHnvN7SIPIneOtBnKlkjMmC
	iL89+dK142E8S9UB7gyrpj/QdCIratTBdOK61d5RGJogDWj7BcgsfioU/ZG0efG3gOxI2J
	WLIEovlqlukfGthr9hjkicgKNe/JuVFvIZIe0ykW47p4XXTlhjVff6bjOnAsW8L5Q3fl7k
	RMQ2eDrZcOYd/fiXy+waNgXtKFFWs858qVZ29wnY2wSo5SgFZYvg9Ldw8420NCTrakhywn
	x3/XY/u2ZqDgfjA2u/pizqRWIC1RqlVAYAdqBwM0EVYpcvGKp1uVgIu3+0uMRw==
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-1-e238b6ed6dc1@oltmanns.dev>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Guido
 =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, Purism Kernel Team
 <kernel@puri.sm>, Ondrej
 Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica
 Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/5] clk: sunxi-ng: nkm: Support constraints on m/n
 ratio and parent rate
Date: Mon, 18 Dec 2023 18:26:51 +0100
In-reply-to: <20231218-pinephone-pll-fixes-v1-1-e238b6ed6dc1@oltmanns.dev>
Message-ID: <8734vz1kok.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2023-12-18 at 14:35:19 +0100, Frank Oltmanns <frank@oltmanns.dev> wrote:
> The Allwinner A64 manual lists the following constraints for the
> PLL-MIPI clock:
>  - M/N >= 3
>  - (PLL_VIDEO0)/M >= 24MHz
>
> The PLL-MIPI clock is implemented as ccu_nkm. Therefore, add support for
> these constraints.
>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 23 +++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  8 ++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index eed64547ad42..2af5c1ebd527 100644
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
> +	if (nkm->max_mn_ratio && (m > nkm->max_mn_ratio * n))
> +		return false;
> +
> +	if (nkm->parent_wo_nk && (parent < nkm->parent_wo_nk * m))
> +		return false;
> +
> +	return true;
> +}
> +
>  static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common,
>  						       struct clk_hw *parent_hw,
>  						       unsigned long *parent, unsigned long rate,
> @@ -32,6 +46,9 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
>
>  				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
>
> +				if (!ccu_nkm_is_valid_rate(common, tmp_parent, _n, _m))
> +					continue;
> +
>  				tmp_rate = tmp_parent * _n * _k / _m;
>
>  				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
> @@ -65,6 +82,12 @@ static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
>  	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
>  		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
>  			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
> +				if ((common->reg == 0x040) && (_m > 3 * _n))
> +					break;
> +
> +				if ((common->reg == 0x040) && (parent < 24000000 * _m))
> +					continue;
> +

This, of course, is rubbish and should be this instead:
+				if (!ccu_nkm_is_valid_rate(common, parent, _n, _m))
+					continue;
+

I'll submit a V2 after receiving some feedback.

>  				unsigned long tmp_rate;
>
>  				tmp_rate = parent * _n * _k / _m;
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index 6601defb3f38..d3d3eaf55faf 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -16,6 +16,12 @@
>   * struct ccu_nkm - Definition of an N-K-M clock
>   *
>   * Clocks based on the formula parent * N * K / M
> + *
> + * @max_mn_ratio:	Maximum value for M / N.
> + * @parent_wo_nk:	The minimum rate the parent must provide after applying the divisor,
> + *			but without applying the multipliers, i.e. the contstraint
> + *			   (parent rate)/M >= parent_wo_nk
> + *			must be fulfilled.
>   */
>  struct ccu_nkm {
>  	u32			enable;
> @@ -27,6 +33,8 @@ struct ccu_nkm {
>  	struct ccu_mux_internal	mux;
>
>  	unsigned int		fixed_post_div;
> +	unsigned long		max_mn_ratio;
> +	unsigned long           parent_wo_nk;
>
>  	struct ccu_common	common;
>  };

