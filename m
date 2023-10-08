Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31BB7BD0EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344876AbjJHW3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:29:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7159BA3;
        Sun,  8 Oct 2023 15:29:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC245C433C7;
        Sun,  8 Oct 2023 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696804167;
        bh=/YmEAaMKXea2h3RFQj0heMwVmlKcgwyx3HWrdcuv5Is=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GwB+tSsrg70utOUtt1D0VO5lZdsaGrmMXVpA/dER1oCQhI2Ww/FuiyUS2Gle9gJys
         QjFBdDWAfPqtSvamPEuyY/k86sh4yrTazXkCx+7ZolsON/WLTecZGpMZMA3dMgbxvq
         O8mVSr27Y0ZKGwNpU/jEaftN+LPjVOxjT2ar3JhPh62Pm0mi2p6auuynxGOOqF1NTL
         4IEmI+W3HzuXrXFHDQBxunpCR3Z9ecXhcT49UkfuhY18//05T4b8EkSV++6cRVkGN+
         nHv1bN8Pz+d+XY9aCe58pRFzLEpPrBGplBRRMa7KTSkdLde4LyELPAy67QRbkIgDPC
         uoNjsyyeTbk+Q==
Message-ID: <2d9156ac-f524-4ab8-016d-c0882b0ef307@kernel.org>
Date:   Mon, 9 Oct 2023 07:29:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: Use device_get_match_data()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231006213854.333261-1-robh@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20231006213854.333261-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 7. 06:38, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/event/exynos-ppmu.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
> index 896a6cc93b00..56bac4702006 100644
> --- a/drivers/devfreq/event/exynos-ppmu.c
> +++ b/drivers/devfreq/event/exynos-ppmu.c
> @@ -12,9 +12,9 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/suspend.h>
>  #include <linux/devfreq-event.h>
> @@ -507,7 +507,6 @@ static int of_get_devfreq_events(struct device_node *np,
>  	struct device *dev = info->dev;
>  	struct device_node *events_np, *node;
>  	int i, j, count;
> -	const struct of_device_id *of_id;
>  	int ret;
>  
>  	events_np = of_get_child_by_name(np, "events");
> @@ -525,13 +524,7 @@ static int of_get_devfreq_events(struct device_node *np,
>  	}
>  	info->num_events = count;
>  
> -	of_id = of_match_device(exynos_ppmu_id_match, dev);
> -	if (of_id)
> -		info->ppmu_type = (enum exynos_ppmu_type)of_id->data;
> -	else {
> -		of_node_put(events_np);
> -		return -EINVAL;
> -	}
> +	info->ppmu_type = (enum exynos_ppmu_type)device_get_match_data(dev);
>  
>  	j = 0;
>  	for_each_child_of_node(events_np, node) {


Applied it.
Thanks.
-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

