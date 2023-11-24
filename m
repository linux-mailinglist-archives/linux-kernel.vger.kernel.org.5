Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC027F7377
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjKXML2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXML0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:11:26 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB318B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 04:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1700827886; x=1703419886;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ueaYiJio+rr5h9VoUpW5qtG1LvpMOX1vur0Jso/gkfY=;
        b=YdJHiUpvrpQRqBSnlgDhuaWdI+HaD0yE2FmihhWDZO86Dz34jKv4n2ZXU/mTbByC
        plqzo1dnOz7oiCdgO8eUtLi0B+AWtFC9RWdQex+NwOIyCtrSY2SuGc+TyehQ5XZF
        AnPAPxUDj0UmkE35MNaJSf2RXa1SPTp3g8QTjr60Www=;
X-AuditID: ac14000a-fbefe7000000290d-17-656092eda846
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C1.7D.10509.DE290656; Fri, 24 Nov 2023 13:11:25 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 24 Nov
 2023 13:11:24 +0100
Message-ID: <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
Date:   Fri, 24 Nov 2023 13:11:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>,
        Bhavya Kapoor <b-kapoor@ti.com>
References: <20230925134427.214556-1-w.egorov@phytec.de>
 <20231005150917.2d0c833e@jic23-huawei>
From:   Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231005150917.2d0c833e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBV/ftpIRUgwmvrCxWbn/OaPH/0WtW
        iwdNq5gslkyez2ox78g7FovLu+awWVx9UG7x5sdZJotZH3+wWvzfs4PdovudugO3x6ZVnWwe
        /d0trB5L3hxi9dh+bR6zx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4Mr4/OYAY8F83oodZ1qZ
        GxhPcHUxcnJICJhI3G9/z9jFyMUhJLCYSeJ172sWCOcuo8SjT02sIFW8AjYSWz69YQSxWQRU
        JX4sO8ACEReUODnzCZgtKiAvcf/WDHYQW1ggQWLWzjVsIDazgLjErSfzmUBsEQF1iWkzrjCB
        LGAW+MEosXjfC7CEkECixIfDc8BsNqCiOxu+gS3mFDCWmPtpDzvEIAuJxW8OQtnyEtvfzmGG
        6JWXeHFpOQvEO/IS0869ZoawQyXmr/nOPoFReBaSW2chuWkWkrGzkIxdwMiyilEoNzM5O7Uo
        M1uvIKOyJDVZLyV1EyMo4kQYuHYw9s3xOMTIxMF4iFGCg1lJhDf3T3yqEG9KYmVValF+fFFp
        TmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBsYtZr6rnbJ94lZ//fV+7y27qcmn
        1qxdHLzAlWVb9oer2oZpCjo52qEebSFnk577BH2QD9kR26wat+NxR5+b8K6EB3kfxO7veBMr
        9cu2Y972C0uteOf4ydxeMGPy+tBwrkm9mgdtths873u6vrnmvMTuST68Ntvjl2yoL92+Wsa7
        vOl5Ybzcv7NKLMUZiYZazEXFiQAcMclBpgIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 05.10.23 um 16:09 schrieb Jonathan Cameron:
> On Mon, 25 Sep 2023 15:44:27 +0200
> Wadim Egorov <w.egorov@phytec.de> wrote:
>
>> Fix wrong handling of a DMA request where the probing only failed
>> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
>> value is returned. This makes DMAs explicitly optional. Even if the
>> DMA request is unsuccessfully, the ADC can still work properly.
>> We do also handle the defer probe case by making use of dev_err_probe().
>>
>> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> +CC Bhavya,
>
> Could you take a look at this given you had comments on v1.

Bhavya, any comments on this?
If not, is there anything else that is blocking this patch?

Regards,
Wadim

>
> Thanks,
>
> Jonathan
>
>> ---
>> v2:
>>    - Update description
>>    - Drop line break after Fixes tag
>>    - Move decision about optional DMA into probe/caller
>> ---
>>   drivers/iio/adc/ti_am335x_adc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index 8db7a01cb5fb..5f8795986995 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, indio_dev);
>>   
>>   	err = tiadc_request_dma(pdev, adc_dev);
>> -	if (err && err == -EPROBE_DEFER)
>> +	if (err && err != -ENODEV) {
>> +		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
>>   		goto err_dma;
>> +	}
>>   
>>   	return 0;
>>   
