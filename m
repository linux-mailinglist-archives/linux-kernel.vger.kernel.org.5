Return-Path: <linux-kernel+bounces-166246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930FE8B9802
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5281D282A26
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118FE56448;
	Thu,  2 May 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAfQwcFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7355783;
	Thu,  2 May 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643120; cv=none; b=JmONAqOM+RmrQMLnu5V9vT6CZaWNXunjfR5TobAWdrmvMrgFKTyVJU6tipS8736IKVYlRVtuRegIwHpmYiR0sDiCs+IoyXOyGgcuGBEhMEDueMUDGINC2uDfYGZdU9fBdXdOrqfKkGRWX626c+/p3h10CCXcRS9KWWxjYRToi/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643120; c=relaxed/simple;
	bh=KMKmbjNxDjaQW/0y4bty5ahkkoXZGQdtL8KqJYUhwyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jye0JU9wZma8jHPfRlVCgkwzVu6n+DQpIxCY9sZDFapxY2O6jRUBoSSr1MbvX33rsWrxPV5dYCjw+Qb+Ya3lHsFLcRo3AhkW9g0w6h++bd4VEcLxeJn4TpIV4BCkgT1S7Cgp4OASuPm+0D5g311Urw6qX2rif6Ri0Qz3CVRAUB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAfQwcFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6A9C113CC;
	Thu,  2 May 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714643119;
	bh=KMKmbjNxDjaQW/0y4bty5ahkkoXZGQdtL8KqJYUhwyE=;
	h=Date:Subject:List-Id:To:Cc:References:From:In-Reply-To:From;
	b=oAfQwcFEFQ4YSvMqY1Xbh/lsc5LPNSzumgD/oGqD14ngGgVPaEs7MibpgzzKx9oki
	 Zagn8sEO8gj46WZhp4lLi4tBXFTB+pnYiA73nYZaFmp60rxFnqFwc6JU+DjWzL67dG
	 /MZ0o36PB32nJVFZyZuANe63Rb2438n1oBk0vqlifHQrplthsktdyd/SJ9MqUjTqSh
	 S4MhcJVVnSWRNuZQtI579Q7AgypadRVel2Bn/9DPwLpuM9kooXWaDgrnlLnFOcgFi9
	 WcmGesxwuIsoxe8I2o27QKIei0xaWcNAItuJ4mp51iYpDI3BxfZTFiHOR9LfE7YUv9
	 8qqWoV1TVGUXg==
Message-ID: <dfde41a3-9d7d-4253-8297-c7684372f6f0@kernel.org>
Date: Thu, 2 May 2024 18:45:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] pinctrl: k210: Use scope based of_node_put()
 cleanups
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
 Wells Lu <wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Emil Renner Berthing <kernel@esmil.dk>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
 Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heiko Stuebner <heiko@sntech.de>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
 imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
 openbmc@lists.ozlabs.org, Peng Fan <peng.fan@nxp.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <20240501-pinctrl-cleanup-v1-12-797ceca46e5c@nxp.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240501-pinctrl-cleanup-v1-12-797ceca46e5c@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/24 21:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Use scope based of_node_put() cleanup to simplify code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pinctrl/pinctrl-k210.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
> index b6d1ed9ec9a3..2753e14c3e38 100644
> --- a/drivers/pinctrl/pinctrl-k210.c
> +++ b/drivers/pinctrl/pinctrl-k210.c
> @@ -849,7 +849,6 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  				       unsigned int *num_maps)
>  {
>  	unsigned int reserved_maps;
> -	struct device_node *np;
>  	int ret;
>  
>  	reserved_maps = 0;
> @@ -861,13 +860,11 @@ static int k210_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  	if (ret < 0)
>  		goto err;
>  
> -	for_each_available_child_of_node(np_config, np) {
> +	for_each_available_child_of_node_scoped(np_config, np) {
>  		ret = k210_pinctrl_dt_subnode_to_map(pctldev, np, map,
>  						     &reserved_maps, num_maps);
> -		if (ret < 0) {
> -			of_node_put(np);

Personally, I am really not a fan of things that hide code like that scoped
thing... If I want a language that hides code, I would be doing C++ :)
That said, I am not opposed to this so I will let Linus (Walleij) decide.

Also, I think that "for_each_available_child_of_node" is a bad name... It really
should be something like for_each_available_child_of_node_get() to make it clear
that a of_node_put() is needed.

> +		if (ret < 0)
>  			goto err;
> -		}
>  	}
>  	return 0;
>  
> 

-- 
Damien Le Moal
Western Digital Research


