Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C427BBD98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjJFRVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjJFRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:21:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668D0AD;
        Fri,  6 Oct 2023 10:21:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01861C433C7;
        Fri,  6 Oct 2023 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696612913;
        bh=I9kMV6YHHWl7kEzLyCCZBt1jRmjIHEwtjspZslV57tE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JcjrsC2dHORytaoLa4PuqRfJkkPcEDYbk5hMKa8qvFKPlZsALYXEa+d+vqkda2pwE
         LPe8PoyenxpLGZrRRkNtZS1jwXwUpYqVf3cWuwJIEZsrsC26QwK06yDT52R8LO9RKZ
         iFN2VHL4Dy/qdcGbLukJSa7OQq3MG3LCyI55mAj25Cr5+zRIMBIJ8lgELKiEEkGgNL
         4Cd6CJU4AdMWEcvuJk1PGE0RoV+VaC+ZtykGLAP7+MD3gwPJOoLkNGvAAqVat6DSU4
         Ou2S8Sf7o9oDF9aKW+axRBvoJnDZI5f4avR3RlN+YpULsvkGSB2rqutYX4xP+BCwRP
         xSJ44589zhzfQ==
Message-ID: <6c66fa8b-9810-ceee-37cf-1881ab1ffb77@kernel.org>
Date:   Sat, 7 Oct 2023 02:21:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 06/26] PM / devfreq: rockchip-dfi: Use free running
 counter
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
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-7-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-7-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 4. 18:32, Sascha Hauer wrote:
> The DDR_MON counters are free running counters. These are resetted to 0
> when starting them over like currently done when reading the current
> counter values.
> 
> Resetting the counters becomes a problem with perf support we want to
> add later, because perf needs counters that are not modified elsewhere.
> 
> This patch removes resetting the counters and keeps them running
> instead. That means we no longer use the absolute counter values but
> instead compare them with the counter values we read last time. Not
> stopping the counters also has the impact that they are running while
> we are reading them. We cannot read multiple timers atomically, so
> the values do not exactly fit together. The effect should be negligible
> though as the time between two measurements is some orders of magnitude
> bigger than the time we need to read multiple registers.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v4:
>     - rephrase commit message
>     - Drop unused variable
> 
>  drivers/devfreq/event/rockchip-dfi.c | 52 ++++++++++++++++------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 680f629da64fc..126bb744645b6 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -38,11 +38,15 @@
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>  
> -struct dmc_usage {
> +struct dmc_count_channel {
>  	u32 access;
>  	u32 total;
>  };
>  
> +struct dmc_count {
> +	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
> +};
> +
>  /*
>   * The dfi controller can monitor DDR load. It has an upper and lower threshold
>   * for the operating points. Whenever the usage leaves these bounds an event is
> @@ -51,7 +55,7 @@ struct dmc_usage {
>  struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
>  	struct devfreq_event_desc desc;
> -	struct dmc_usage ch_usage[RK3399_DMC_NUM_CH];
> +	struct dmc_count last_event_count;
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
> @@ -85,30 +89,18 @@ static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
>  	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
>  }
>  
> -static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
> +static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dmc_count *count)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> -	u32 tmp, max = 0;
> -	u32 i, busier_ch = 0;
> +	u32 i;
>  	void __iomem *dfi_regs = dfi->regs;
>  
> -	rockchip_dfi_stop_hardware_counter(edev);
> -
> -	/* Find out which channel is busier */
>  	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> -		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
> +		count->c[i].access = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
> +		count->c[i].total = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
> -		tmp = dfi->ch_usage[i].access;
> -		if (tmp > max) {
> -			busier_ch = i;
> -			max = tmp;
> -		}
>  	}
> -	rockchip_dfi_start_hardware_counter(edev);
> -
> -	return busier_ch;
>  }
>  
>  static int rockchip_dfi_disable(struct devfreq_event_dev *edev)
> @@ -145,12 +137,28 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
>  				  struct devfreq_event_data *edata)
>  {
>  	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
> -	int busier_ch;
> +	struct dmc_count count;
> +	struct dmc_count *last = &dfi->last_event_count;
> +	u32 access = 0, total = 0;
> +	int i;
> +
> +	rockchip_dfi_read_counters(edev, &count);
> +
> +	/* We can only report one channel, so find the busiest one */
> +	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> +		u32 a = count.c[i].access - last->c[i].access;
> +		u32 t = count.c[i].total - last->c[i].total;
> +
> +		if (a > access) {
> +			access = a;
> +			total = t;
> +		}
> +	}
>  
> -	busier_ch = rockchip_dfi_get_busier_ch(edev);
> +	edata->load_count = access * 4;
> +	edata->total_count = total;
>  
> -	edata->load_count = dfi->ch_usage[busier_ch].access * 4;
> -	edata->total_count = dfi->ch_usage[busier_ch].total;
> +	dfi->last_event_count = count;
>  
>  	return 0;
>  }

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

