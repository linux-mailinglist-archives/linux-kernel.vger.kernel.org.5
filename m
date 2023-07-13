Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AAB752B79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjGMUNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjGMUNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:13:04 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1612D6A;
        Thu, 13 Jul 2023 13:12:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DKC4Xq112372;
        Thu, 13 Jul 2023 15:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689279124;
        bh=0S2ewqAxg7ILJY9MxheLt4LbCdAki+6jXINxMjiX69o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=ZQAWguTaq0oJyQamAR6Zivi6qbRIvLgQIWQZlx9J9WE73yHjbhCjKyIr/MYZLwpdF
         dTaCJ5AJghWNnFi9etSLlrvI1SIeazIKE1zeBVsd/8CDCrwfB9PG+grWocrVjP1fAG
         wvN41ffEpVziD/63jxogNJQs8JhftAKMGYqLKIUU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DKC4Bp026133
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 15:12:04 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 15:12:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 15:12:03 -0500
Received: from [10.250.32.50] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DKC3Fc081261;
        Thu, 13 Jul 2023 15:12:03 -0500
Message-ID: <b16568ec-0428-981b-01ca-571cc5d52704@ti.com>
Date:   Thu, 13 Jul 2023 15:12:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] mux: mmio: use reg property when parent device is not
 a syscon
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230605154153.24025-1-afd@ti.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230605154153.24025-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 10:41 AM, Andrew Davis wrote:
> The DT binding for the reg-mux compatible states it can be used when the
> "parent device of mux controller is not syscon device". It also allows
> for a reg property. When the reg property is provided, use that to
> identify the address space for this mux. If not provided fallback to
> using the parent device as a regmap provider.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Ping, still needed and applies cleanly on v6.5-rc1.

Andrew

> 
> Changes from v1:
>   - Flip logic as suggested in v1[0]
> 
> [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
> 
>   drivers/mux/mmio.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
> index 44a7a0e885b8d..2c9e4df9d6f2c 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>   	int ret;
>   	int i;
>   
> -	if (of_device_is_compatible(np, "mmio-mux"))
> +	if (of_device_is_compatible(np, "mmio-mux")) {
>   		regmap = syscon_node_to_regmap(np->parent);
> -	else
> -		regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	} else {
> +		regmap = device_node_to_regmap(np);
> +		if (IS_ERR(regmap))
> +			regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
> +	}
>   	if (IS_ERR(regmap)) {
>   		ret = PTR_ERR(regmap);
>   		dev_err(dev, "failed to get regmap: %d\n", ret);
