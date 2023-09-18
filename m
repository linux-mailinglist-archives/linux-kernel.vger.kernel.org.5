Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A337A4521
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238986AbjIRIs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbjIRIsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:48:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3E39B;
        Mon, 18 Sep 2023 01:48:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38I8mDKZ128933;
        Mon, 18 Sep 2023 03:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695026893;
        bh=Pp6OIAY161J8G1DoDoYZo5L+G9eGynrg2fM+xFg0Tj4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Hx+jOvDUVF5rbYDyVSO3+iUE+6iYT1nB3jiwgDfDswknEZfztx75/tNHWd0BpL5UU
         BM5GG12frQZst+ddFkiTq2UJxtWnDLzAMR29B4ooDGIkWKNQq3mo6cencpt+4giXzW
         cfWNESiyL55jWx0vL9giIws1eCH75eiMDif3vLdM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38I8mDx2001792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Sep 2023 03:48:13 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Sep 2023 03:48:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Sep 2023 03:48:13 -0500
Received: from [10.249.139.100] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38I8m8v8120184;
        Mon, 18 Sep 2023 03:48:09 -0500
Message-ID: <6eb4608b-10e1-7fcc-b73f-4445150216e0@ti.com>
Date:   Mon, 18 Sep 2023 14:18:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Make DMAs optional
Content-Language: en-US
To:     Wadim Egorov <w.egorov@phytec.de>, <jic23@kernel.org>,
        <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <mugunthanvnm@ti.com>, <peter.ujfalusi@ti.com>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <upstream@lists.phytec.de>, <nm@ti.com>
References: <20230914121300.845493-1-w.egorov@phytec.de>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20230914121300.845493-1-w.egorov@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/09/23 17:43, Wadim Egorov wrote:
> DMAs are optional. Even if the DMA request is unsuccessfully,
> the ADC can still work properly.
> Make tiadc_request_dma() not fail if we do not provide dmas &
> dma-names properties.
>
> This actually fixes the wrong error handling of the tiadc_request_dma()
> result where the probing only failed if -EPROPE_DEFER was returned.
>
> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 8db7a01cb5fb..e14aa9254ab1 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -543,8 +543,11 @@ static int tiadc_request_dma(struct platform_device *pdev,
>  	if (IS_ERR(dma->chan)) {
>  		int ret = PTR_ERR(dma->chan);
>
> +		if (ret != -ENODEV)

Hi Wadim, Thanks for adding this fix but now there is no deferred probe

mechanism available here for the driver. We need to include that as well.

Regards

~B-Kapoor

> +			return dev_err_probe(&pdev->dev, ret,
> +					     "RX DMA channel request failed\n");
>  		dma->chan = NULL;
> -		return ret;
> +		return 0;
>  	}
>
>  	/* RX buffer */
> @@ -670,7 +673,7 @@ static int tiadc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, indio_dev);
>
>  	err = tiadc_request_dma(pdev, adc_dev);
> -	if (err && err == -EPROBE_DEFER)
> +	if (err)
>  		goto err_dma;
>
>  	return 0;
> --
> 2.25.1
>
>
>
