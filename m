Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3037BBEA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 20:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjJFSYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjJFSYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:24:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4CFBE;
        Fri,  6 Oct 2023 11:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67D8C433B9;
        Fri,  6 Oct 2023 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696616678;
        bh=XMRbzsY9A1FpB7Vearw0HGHjviPa4Dpe+NZgXwP5iv4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSahHaYaKVg4WEtqzwfvKNNUo0gzDdfLcPymxZt3Qn2Q7bcl5pfMEogdU4o/nZYur
         J6fuaWBP8lUXAvd1XfDJEVlHmCLJkKJM8FGNTuulgNI0UJ991JCaP/p4kVQ2aMw6UP
         EjwzCcoVGxlSMlD2wQzV+Xj2kjwUaAT2ePHEmBkqOQ3Ui9d50v5+KY4hs1FurXmohF
         uBOo4+sZgm1J2DWEEhGGnjRo2tSaH4Nr7uUYRTZjOsVshfCw2W8d0ZHGYzo+CapYoh
         vTQT8jDYtaj3SjJ0Z5W4GY8Fu1bGxnbgNW0THGzh5pLq3B6CjhB34RIGsNxFDhg7b3
         TqntO7l2Ly4Ag==
Message-ID: <df27b5a4-9010-e76c-e974-452ee8ee22c3@kernel.org>
Date:   Sat, 7 Oct 2023 03:24:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 11/26] PM / devfreq: rockchip-dfi: Handle LPDDR2
 correctly
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
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-12-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-12-s.hauer@pengutronix.de>
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
> According to the downstream driver the DDRMON_CTRL_LPDDR23 bit must be
> set for both LPDDR2 and LPDDR3. Add the missing LPDDR2 case and while
> at it turn the if/else if/else into switch/case which makes it easier
> to read.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 261d112580c9e..16cd5365671f7 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -82,12 +82,19 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>  		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
>  
>  	/* set ddr type to dfi */
> -	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
> +	switch (dfi->ddr_type) {
> +	case ROCKCHIP_DDRTYPE_LPDDR2:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
>  		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
>  			       dfi_regs + DDRMON_CTRL);
> -	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
>  		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
>  			       dfi_regs + DDRMON_CTRL);
> +		break;
> +	default:
> +		break;
> +	}
>  
>  	/* enable count, use software mode */
>  	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

