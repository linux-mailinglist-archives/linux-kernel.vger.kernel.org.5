Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9637CE0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjJRPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJRPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:05:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184B94;
        Wed, 18 Oct 2023 08:05:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C630C433C9;
        Wed, 18 Oct 2023 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641505;
        bh=1QoRzC9jJwTaFmGrM4LiozZejJzJBfoUoG9IBJ/e5TQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HryORvhyVhhLAZoAiFy39YrretnQ1CRqMzpISFzRh12yhMMjUTqHaJIbmmzxHiFNe
         W3FsgaW4p6gX5s1YES6KAaoc5SUvh7Q9AF9VclNyZkKTbWe9bnPl66zhBXskmPh+vZ
         EQqsSEfspbB+9mtMOJrQQBmPyhNugY+GDQHprxWdbweERs7goQGANR7DLeJkuW72lc
         uvPYGxRLUZgLWUenIhamhKTvYHB8iBB1MPfZOHiTbe5DwliXMNhkgwoz2ieH+CuLuq
         ezCPQXULeFAeGBWGtI4hGGBIQlR2hYNVTa401dWQhuoS3gFTyTVR07lsfJIwSZGJw0
         QM1LFRV7lnQqQ==
Message-ID: <d0fbe394-f038-49d2-8aac-508c7ff23735@kernel.org>
Date:   Thu, 19 Oct 2023 00:05:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/26] PM / devfreq: rockchip-dfi: dfi store raw values
 in counter struct
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
 <20231018061714.3553817-6-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231018061714.3553817-6-s.hauer@pengutronix.de>
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
> When adding perf support to the DFI driver the perf part will
> need the raw counter values, so move the fixed * 4 factor to
> rockchip_dfi_get_event().
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 6b1ef29df7048..680f629da64fc 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -97,7 +97,7 @@ static int rockchip_dfi_get_busier_ch(struct devfreq_event_dev *edev)
>  	/* Find out which channel is busier */
>  	for (i = 0; i < RK3399_DMC_NUM_CH; i++) {
>  		dfi->ch_usage[i].access = readl_relaxed(dfi_regs +
> -				DDRMON_CH0_DFI_ACCESS_NUM + i * 20) * 4;
> +				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
>  		dfi->ch_usage[i].total = readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
>  		tmp = dfi->ch_usage[i].access;
> @@ -149,7 +149,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
>  
>  	busier_ch = rockchip_dfi_get_busier_ch(edev);
>  
> -	edata->load_count = dfi->ch_usage[busier_ch].access;
> +	edata->load_count = dfi->ch_usage[busier_ch].access * 4;
>  	edata->total_count = dfi->ch_usage[busier_ch].total;
>  
>  	return 0;

Already applied it on v7.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

