Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4267CE0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbjJRPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344665AbjJRPMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:12:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E02AB;
        Wed, 18 Oct 2023 08:12:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629BFC433C8;
        Wed, 18 Oct 2023 15:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641950;
        bh=FQeLVQ03xYeQQtOosvC2A7mk735Ug07ldWBeoCuDr3s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lc5skqHjb9nLqfPWMcQdGrtNQbKYW7tLWgJ7EmXjCYfOth4McrikeqUJJSx3Nk7gS
         PMtid+U3FzR+w7VBzky/ruQEJE5Q1n8a+QJUzZnFdjW0/Y4BsEeuNZd37cyPMQvBmf
         BGVWFvVYQj8Wn5+SgMBw9lc+sR6aIdHWFBMpBD+TE5CzaYwkQYdrPn8VoRh0wDjS2m
         IHlr9OQQKVcZvfrwQ3INzwWQIw/DYkdScfX0rRAzc1Y4BK14McX6IpQSx/dfkRk6+f
         cYD2Hic3sozJpE6cWTHNbSIH+ro1IknzQV/m8rd6MBsx63solU9VbxJlis/z62sqRg
         oTjbGS7llg3OQ==
Message-ID: <ffcf4521-5bf0-4933-a25c-22574035f774@kernel.org>
Date:   Thu, 19 Oct 2023 00:12:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/26] PM / devfreq: rockchip-dfi: add support for
 RK3588
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20231018061714.3553817-1-s.hauer@pengutronix.de>
 <20231018061714.3553817-20-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231018061714.3553817-20-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 18. 15:17, Sascha Hauer wrote:
> Add support for the RK3588 to the driver. The RK3588 has four DDR
> channels with a register stride of 0x4000 between the channel
> registers, also it has a DDRMON_CTRL register per channel.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 36 +++++++++++++++++++++++++++-
>  include/soc/rockchip/rk3588_grf.h    | 18 ++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 include/soc/rockchip/rk3588_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index bf38829a2a4af..794f36e7eebd1 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,8 +26,9 @@
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
>  #include <soc/rockchip/rk3568_grf.h>
> +#include <soc/rockchip/rk3588_grf.h>
>  
> -#define DMC_MAX_CHANNELS	2
> +#define DMC_MAX_CHANNELS	4
>  
>  #define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
>  
> @@ -723,9 +724,42 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
>  	return 0;
>  };
>  
> +static int rk3588_dfi_init(struct rockchip_dfi *dfi)
> +{
> +	struct regmap *regmap_pmu = dfi->regmap_pmu;
> +	u32 reg2, reg3, reg4;
> +
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG2, &reg2);
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG3, &reg3);
> +	regmap_read(regmap_pmu, RK3588_PMUGRF_OS_REG4, &reg4);
> +
> +	/* lower 3 bits of the DDR type */
> +	dfi->ddr_type = FIELD_GET(RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO, reg2);
> +
> +	/*
> +	 * For version three and higher the upper two bits of the DDR type are
> +	 * in RK3588_PMUGRF_OS_REG3
> +	 */
> +	if (FIELD_GET(RK3588_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >= 0x3)
> +		dfi->ddr_type |= FIELD_GET(RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
> +
> +	dfi->buswidth[0] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH0, reg2) == 0 ? 4 : 2;
> +	dfi->buswidth[1] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg2) == 0 ? 4 : 2;
> +	dfi->buswidth[2] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg4) == 0 ? 4 : 2;
> +	dfi->buswidth[3] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg4) == 0 ? 4 : 2;
> +	dfi->channel_mask = FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg2) |
> +			    FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg4) << 2;
> +	dfi->max_channels = 4;
> +
> +	dfi->ddrmon_stride = 0x4000;
> +
> +	return 0;
> +};
> +
>  static const struct of_device_id rockchip_dfi_id_match[] = {
>  	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
>  	{ .compatible = "rockchip,rk3568-dfi", .data = rk3568_dfi_init },
> +	{ .compatible = "rockchip,rk3588-dfi", .data = rk3588_dfi_init },
>  	{ },
>  };
>  
> diff --git a/include/soc/rockchip/rk3588_grf.h b/include/soc/rockchip/rk3588_grf.h
> new file mode 100644
> index 0000000000000..630b35a550640
> --- /dev/null
> +++ b/include/soc/rockchip/rk3588_grf.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __SOC_RK3588_GRF_H
> +#define __SOC_RK3588_GRF_H
> +
> +#define RK3588_PMUGRF_OS_REG2		0x208
> +#define RK3588_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
> +#define RK3588_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
> +#define RK3588_PMUGRF_OS_REG2_BW_CH1                    GENMASK(19, 18)
> +#define RK3588_PMUGRF_OS_REG2_CH_INFO                   GENMASK(29, 28)
> +
> +#define RK3588_PMUGRF_OS_REG3		0x20c
> +#define RK3588_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
> +#define RK3588_PMUGRF_OS_REG3_SYSREG_VERSION		GENMASK(31, 28)
> +
> +#define RK3588_PMUGRF_OS_REG4           0x210
> +#define RK3588_PMUGRF_OS_REG5           0x214
> +
> +#endif /* __SOC_RK3588_GRF_H */

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

