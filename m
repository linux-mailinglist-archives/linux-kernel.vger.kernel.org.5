Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4D775C3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjGUKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGUKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:03:47 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885AAB7;
        Fri, 21 Jul 2023 03:03:43 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E5D8F120007;
        Fri, 21 Jul 2023 13:03:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E5D8F120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689933819;
        bh=DqYbWBT8rrvZaiN/vfHY6TUpbGWQJDc5EEX0zSuH7m0=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
        b=nxAlNY4/bcTHXRBO9hlrmtGSP1C0YklMIovxWQHCrYON8w+2wxuoAQ/hINKM3D9es
         RNqPtZaPQ83y8TdWwnXr/t5V0OpBohbfw3nNukwIqdC6RovuapDF1RREtpjAsvD6uY
         +GdetcfFTDBdkoXVzPVm70otvIgjdyv5L5752oJNFRUpJUpt/wzmzELGzp1w/HzlXa
         wj4KfddynKN0rKPfKpWU4vyN+BgqF9V1rzB4/XJsP3D11Xuobkrs606o0ayUNSerd2
         Ws3eI85fQZCIWQHC65M2I4L0eU64IjiYd0NvUqg6cj42akkMaPmZqsLdL2PxBLkzeW
         GonQdkur6zcsw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 13:03:39 +0300 (MSK)
Received: from [192.168.1.127] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 13:03:39 +0300
Message-ID: <e028c2dc-07e3-71d3-422d-08c6e3a4a99f@sberdevices.ru>
Date:   Fri, 21 Jul 2023 12:58:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] iio: adc: meson: fix core clock enable/disable
 moment
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
References: <20230714190320.308320-1-gnstark@sberdevices.ru>
 <20230714190320.308320-2-gnstark@sberdevices.ru>
 <20230715182121.29f83d76@jic23-huawei>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <20230715182121.29f83d76@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178772 [Jul 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 525 525 723604743bfbdb7e16728748c3fa45e9eba05f7d, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/21 05:36:00 #21651174
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan

Thanks for the feedback.

On 7/15/23 20:21, Jonathan Cameron wrote:
> On Fri, 14 Jul 2023 22:03:15 +0300
> George Stark <gnstark@sberdevices.ru> wrote:
> 
>> Enable core clock at probe stage and disable it at remove stage.
>> Core clock is responsible for turning on/off the entire SoC module so
>> it should be on before the first module register is touched and be off
>> at very last moment.
>>
>> Signed-off-by: George Stark <gnstark@sberdevices.ru>
> 
> This sounds to me like this should perhaps have a fixes tag?
ack
> 
> Given where it is in the new sequence you can also use
> devm_clk_get_enabled() though that makes a potential backport of
> the fix trickier...
> 
> I'd go with it anyway as it will make this change quite a bit simpler.
ack
> 
> More comments inline
> 
> Jonathan
> 
>> ---
>>   drivers/iio/adc/meson_saradc.c | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
>> index fe066c9fab83..5a5bb5cc1320 100644
>> --- a/drivers/iio/adc/meson_saradc.c
>> +++ b/drivers/iio/adc/meson_saradc.c
>> @@ -1055,12 +1055,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>>   		goto err_vref;
>>   	}
>>   
>> -	ret = clk_prepare_enable(priv->core_clk);
>> -	if (ret) {
>> -		dev_err(dev, "failed to enable core clk\n");
>> -		goto err_core_clk;
>> -	}
>> -
>>   	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
>>   	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>>   			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
>> @@ -1087,8 +1081,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>>   	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>>   			   MESON_SAR_ADC_REG3_ADC_EN, 0);
>>   	meson_sar_adc_set_bandgap(indio_dev, false);
>> -	clk_disable_unprepare(priv->core_clk);
>> -err_core_clk:
>>   	regulator_disable(priv->vref);
>>   err_vref:
>>   	meson_sar_adc_unlock(indio_dev);
>> @@ -1116,8 +1108,6 @@ static void meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
>>   
>>   	meson_sar_adc_set_bandgap(indio_dev, false);
>>   
>> -	clk_disable_unprepare(priv->core_clk);
>> -
>>   	regulator_disable(priv->vref);
>>   
>>   	if (!ret)
>> @@ -1420,6 +1410,12 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>>   			ARRAY_SIZE(meson_sar_adc_iio_channels);
>>   	}
>>   
>> +	ret = clk_prepare_enable(priv->core_clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable core clk\n");
>> +		goto err;
> 
> If clk_prepare_enable() failed, then you shoudl not call clk_disable_unprepare()
yes, but with devm_clk_get_enabled we dont't need this line anymore
> 
>> +	}
>> +
>>   	ret = meson_sar_adc_init(indio_dev);
>>   	if (ret)
>>   		goto err;
>> @@ -1445,17 +1441,21 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>>   err_hw:
>>   	meson_sar_adc_hw_disable(indio_dev);
>>   err:
>> +	clk_disable_unprepare(priv->core_clk);
> 
> Nothing to do with your patch, but this driver previously did some odd mixing
> of direct returns and going to an empty label which definitely doesn't help
> make this clear to follow.
I made additional patch adding log messages to all errors those can 
break probe stage
> 
>>   	return ret;
>>   }
>>   
>>   static int meson_sar_adc_remove(struct platform_device *pdev)
>>   {
>>   	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>>   
>>   	iio_device_unregister(indio_dev);
>>   
>>   	meson_sar_adc_hw_disable(indio_dev);
>>   
>> +	clk_disable_unprepare(priv->core_clk);
>> +
>>   	return 0;
>>   }
>>   
> 

-- 
Best regards
George
