Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD37CE05F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344955AbjJROvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJROvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:51:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464794;
        Wed, 18 Oct 2023 07:51:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24527C433C7;
        Wed, 18 Oct 2023 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697640667;
        bh=/nVpBEadMIgZ+gxlnKonNNjTqY37ybItw/nlqmFc0n0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bBefqQarWerlAjrezIqYxtpiAu1FxseZNEKYwanHhVc3DQejDqAaz/AiHU9OU/8zZ
         YSnpmoQqGTAd+5SfCDBYbgZU53E/ZaT4ITDjIA6P8rLwc6nGoD4rM05YGnEyYR38NS
         oo/a37jKh7IDzQgSSuSQaGhKOmx+Md4uWyCyKorP+XG8Lg40qXfNeJXHzDhTcTQt0F
         CSesjLhuUglQRfgz3a06Pv1711tahlabqyZdN4kr68BLDW05+l0v3bFJZ+9DwKoNId
         THxfIRaYJvOhWITcixnIsAITByCr0y3od6785g/O+1j7u0r1FhDNt3byKAqE1jHTCv
         PUOb9vR/KwA7Q==
Message-ID: <d4a2a659-407f-4a8a-b8b3-9c56021d0990@kernel.org>
Date:   Wed, 18 Oct 2023 23:51:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/26] PM / devfreq: rockchip-dfi: Make pmu regmap
 mandatory
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
 <20231018061714.3553817-2-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231018061714.3553817-2-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 18. 15:16, Sascha Hauer wrote:
> As a matter of fact the regmap_pmu already is mandatory because
> it is used unconditionally in the driver. Bail out gracefully in
> probe() rather than crashing later.
> 
> Fixes: b9d1262bca0af ("PM / devfreq: event: support rockchip dfi controller")
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>      - move to beginning of the series to make it easier to backport to stable
>      - Add a Fixes: tag
>      - add missing of_node_put()
> 
>  drivers/devfreq/event/rockchip-dfi.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 39ac069cabc75..74893c06aa087 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -193,14 +193,15 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(data->clk),
>  				     "Cannot get the clk pclk_ddr_mon\n");
>  
> -	/* try to find the optional reference to the pmu syscon */
>  	node = of_parse_phandle(np, "rockchip,pmu", 0);
> -	if (node) {
> -		data->regmap_pmu = syscon_node_to_regmap(node);
> -		of_node_put(node);
> -		if (IS_ERR(data->regmap_pmu))
> -			return PTR_ERR(data->regmap_pmu);
> -	}
> +	if (!node)
> +		return dev_err_probe(&pdev->dev, -ENODEV, "Can't find pmu_grf registers\n");
> +
> +	data->regmap_pmu = syscon_node_to_regmap(node);
> +	of_node_put(node);
> +	if (IS_ERR(data->regmap_pmu))
> +		return PTR_ERR(data->regmap_pmu);
> +
>  	data->dev = dev;
>  
>  	desc = devm_kzalloc(dev, sizeof(*desc), GFP_KERNEL);

Already applied it on v7.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

