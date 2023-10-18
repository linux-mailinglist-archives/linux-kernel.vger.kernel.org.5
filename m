Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB47CE0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjJRPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjJRPFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:05:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4FEEA;
        Wed, 18 Oct 2023 08:05:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AECCC433C7;
        Wed, 18 Oct 2023 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641537;
        bh=PIiIXKenjlTWbp5gHz845HTrHDmcuL0MzMQD6MsERgo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U3bPPdQvqZ+XEXd7ak7qMUBqO7WZuOCU4DR5EpGHN4/6IAlxRPknFvV/Gt5TCvGi1
         PAk/iRwWaeJlZF1g/G6fqiPIofi0cWU92B1Jj7UtMkuRfbufllIFvkvMCZx7XYmLIA
         ZIu9prqmZ1/W/1atPM/q0MAkVmHQHSqZqA9PuS6jzJuiNCkfJ6nN0B/Fe/XjzSX/j+
         CCysyr74f+UDVlwSojvutLUU/IMdeGFrN+GttW/MwCrjGC4pgmmyy8lN7I3igncsyO
         ezdWEi9s2VcTfz+Mcos0nTaI4MAtil+RetoEulJeVB8m+o0rc3w15q+KjPzADeIqgq
         Qow1ONdjj7oUg==
Message-ID: <99477a81-08d1-4e5d-8b20-22da58921041@kernel.org>
Date:   Thu, 19 Oct 2023 00:05:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/26] PM / devfreq: rockchip-dfi: introduce channel
 mask
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
 <20231018061714.3553817-8-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231018061714.3553817-8-s.hauer@pengutronix.de>
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
> Different Rockchip SoC variants have a different number of channels.
> Introduce a channel mask to make the number of channels configurable
> from SoC initialization code.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v7:
>      - Loop only over channels present on a SoC
> 
>  drivers/devfreq/event/rockchip-dfi.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 126bb744645b6..28c18bbf6baa5 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -18,10 +18,11 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/bits.h>
>  
>  #include <soc/rockchip/rk3399_grf.h>
>  
> -#define RK3399_DMC_NUM_CH	2
> +#define DMC_MAX_CHANNELS	2
>  
>  /* DDRMON_CTRL */
>  #define DDRMON_CTRL	0x04
> @@ -44,7 +45,7 @@ struct dmc_count_channel {
>  };
>  
>  struct dmc_count {
> -	struct dmc_count_channel c[RK3399_DMC_NUM_CH];
> +	struct dmc_count_channel c[DMC_MAX_CHANNELS];
>  };
>  
>  /*
> @@ -61,6 +62,8 @@ struct rockchip_dfi {
>  	struct regmap *regmap_pmu;
>  	struct clk *clk;
>  	u32 ddr_type;
> +	unsigned int channel_mask;
> +	unsigned int max_channels;
>  };
>  
>  static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
> @@ -95,7 +98,9 @@ static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dm
>  	u32 i;
>  	void __iomem *dfi_regs = dfi->regs;
>  
> -	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> +	for (i = 0; i < dfi->max_channels; i++) {
> +		if (!(dfi->channel_mask & BIT(i)))
> +			continue;
>  		count->c[i].access = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
>  		count->c[i].total = readl_relaxed(dfi_regs +
> @@ -145,9 +150,14 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
>  	rockchip_dfi_read_counters(edev, &count);
>  
>  	/* We can only report one channel, so find the busiest one */
> -	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
> -		u32 a = count.c[i].access - last->c[i].access;
> -		u32 t = count.c[i].total - last->c[i].total;
> +	for (i = 0; i < dfi->max_channels; i++) {
> +		u32 a, t;
> +
> +		if (!(dfi->channel_mask & BIT(i)))
> +			continue;
> +
> +		a = count.c[i].access - last->c[i].access;
> +		t = count.c[i].total - last->c[i].total;
>  
>  		if (a > access) {
>  			access = a;
> @@ -185,6 +195,9 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
>  			RK3399_PMUGRF_DDRTYPE_MASK;
>  
> +	dfi->channel_mask = GENMASK(1, 0);
> +	dfi->max_channels = 2;
> +
>  	return 0;
>  };
>  

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

