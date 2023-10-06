Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92A7BBDE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjJFRnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjJFRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:43:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15236CE;
        Fri,  6 Oct 2023 10:43:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BDCC433C7;
        Fri,  6 Oct 2023 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696614190;
        bh=3pHBD8r/iPh/v5cgOzJJy4If3hivbFUEGjN+b6bqFKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OvPbzaM2D/+mLKHaRTMMFrEpSKvYejfKtoC/+RB+YAabg/6A0VNDQRGB+7TAtZuak
         uS64Q/Sft1qfwBN87fAPShxrS7YYollPm7HQlVrSl4w+8Hnap/mYjI8utfUE3Jo2XN
         /I4fS8KyXJfgv0wbgfQM9uVPr+JIU2/Sn/pJmg9xyPWj7wHBvSmxz1dM2Znfd80spl
         FHbIf7UeIREC89a4S8JbzrDSKg26GiJilhrzCNvELcupBvD8/LGtqzEE9KPV+TPDUS
         pmaNKW7CLwgRk67DkXeq5yjKGSVIKm5sSpEkNaErN0y7HOgag4Oqz3CikmAxgbODEF
         TvQO2dMbhDbnA==
Message-ID: <f142ae65-0609-ccf2-5908-663cd2ecab73@kernel.org>
Date:   Sat, 7 Oct 2023 02:43:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 08/26] PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE
 defines
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
 <20230704093242.583575-9-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-9-s.hauer@pengutronix.de>
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
> The DDRTYPE defines are named to be RK3399 specific, but they can be
> used for other Rockchip SoCs as well, so replace the RK3399_PMUGRF_
> prefix with ROCKCHIP_. They are defined in a SoC specific header
> file, so when generalizing the prefix also move the new defines to
> a SoC agnostic header file. While at it use GENMASK to define the
> DDRTYPE bitfield and give it a name including the full register name.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c |  9 +++++----
>  drivers/devfreq/rk3399_dmc.c         | 10 +++++-----
>  include/soc/rockchip/rk3399_grf.h    |  7 +------
>  include/soc/rockchip/rockchip_grf.h  | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+), 15 deletions(-)
>  create mode 100644 include/soc/rockchip/rockchip_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 82de24a027579..6bccb6fbcfc0c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -18,8 +18,10 @@
>  #include <linux/list.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  
> +#include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  
>  #define DMC_MAX_CHANNELS	2
> @@ -74,9 +76,9 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
> +	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
>  		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
> +	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
>  		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>  
>  	/* enable count, use software mode */
> @@ -191,8 +193,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  
>  	/* get ddr type */
>  	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -			RK3399_PMUGRF_DDRTYPE_MASK;
> +	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
>  
>  	dfi->channel_mask = GENMASK(1, 0);
>  
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index daff407026157..fd2c5ffedf41e 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -22,6 +22,7 @@
>  #include <linux/suspend.h>
>  
>  #include <soc/rockchip/pm_domains.h>
> +#include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rockchip_sip.h>
>  
> @@ -381,17 +382,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>  	}
>  
>  	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> -		    RK3399_PMUGRF_DDRTYPE_MASK;
> +	ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
>  
>  	switch (ddr_type) {
> -	case RK3399_PMUGRF_DDRTYPE_DDR3:
> +	case ROCKCHIP_DDRTYPE_DDR3:
>  		data->odt_dis_freq = data->ddr3_odt_dis_freq;
>  		break;
> -	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
>  		data->odt_dis_freq = data->lpddr3_odt_dis_freq;
>  		break;
> -	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
>  		data->odt_dis_freq = data->lpddr4_odt_dis_freq;
>  		break;
>  	default:
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> index 3eebabcb28123..775f8444bea8d 100644
> --- a/include/soc/rockchip/rk3399_grf.h
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -11,11 +11,6 @@
>  
>  /* PMU GRF Registers */
>  #define RK3399_PMUGRF_OS_REG2		0x308
> -#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> -#define RK3399_PMUGRF_DDRTYPE_MASK	7
> -#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> -#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +#define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
>  
>  #endif
> diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/rockchip_grf.h
> new file mode 100644
> index 0000000000000..dde1a9796ccb5
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_grf.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip General Register Files definitions
> + */
> +
> +#ifndef __SOC_ROCKCHIP_GRF_H
> +#define __SOC_ROCKCHIP_GRF_H
> +
> +/* Rockchip DDRTYPE defines */
> +enum {
> +	ROCKCHIP_DDRTYPE_DDR3	= 3,
> +	ROCKCHIP_DDRTYPE_LPDDR2	= 5,
> +	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
> +	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
> +};
> +
> +#endif /* __SOC_ROCKCHIP_GRF_H */


Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

This patch must require Ack of rockchip Maintainer (Heiko Stuebner)
because of include/soc/rockchip.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

