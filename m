Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B776FD37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjHDJZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjHDJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:25:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55B30F4;
        Fri,  4 Aug 2023 02:24:54 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DB05324E2E3;
        Fri,  4 Aug 2023 17:24:38 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 17:24:39 +0800
Received: from [192.168.125.128] (183.27.98.54) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 4 Aug
 2023 17:24:37 +0800
Message-ID: <00553fc1-a033-5d4b-e8db-18f265f08492@starfivetech.com>
Date:   Fri, 4 Aug 2023 17:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 3/5] ASoC: dwc: i2s: Add StarFive JH7110 SoC support
Content-Language: en-US
To:     Maxim Kochetkov <fido_max@inbox.ru>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
References: <20230802084301.134122-1-xingyu.wu@starfivetech.com>
 <20230802084301.134122-4-xingyu.wu@starfivetech.com>
 <fdd771cc-9354-208b-e8be-50d2ec6a40c9@inbox.ru>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <fdd771cc-9354-208b-e8be-50d2ec6a40c9@inbox.ru>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [183.27.98.54]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/3 13:16, Maxim Kochetkov wrote:
> 
> 
> On 02.08.2023 11:42, Xingyu Wu wrote:
> 
>> diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
>> index c076090a9864..4dfbd8ddbcf5 100644
>> --- a/sound/soc/dwc/dwc-i2s.c
>> +++ b/sound/soc/dwc/dwc-i2s.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/init.h>
>>   #include <linux/io.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/mfd/syscon.h>
>>   #include <linux/module.h>
>>   #include <linux/reset.h>
>>   #include <linux/slab.h>
>> @@ -198,7 +199,7 @@ static void i2s_start(struct dw_i2s_dev *dev,
>>       else
>>           i2s_write_reg(dev->i2s_base, IRER, 1);
>>   -    if (dev->use_pio)
>> +    if (dev->use_pio || dev->is_jh7110)
>>           i2s_enable_irqs(dev, substream->stream, config->chan_nr);
>>       else
>>           i2s_enable_dma(dev, substream->stream);
>> @@ -216,7 +217,7 @@ static void i2s_stop(struct dw_i2s_dev *dev,
>>       else
>>           i2s_write_reg(dev->i2s_base, IRER, 0);
>>   -    if (dev->use_pio)
>> +    if (dev->use_pio || dev->is_jh7110)
>>           i2s_disable_irqs(dev, substream->stream, 8);
>>       else
>>           i2s_disable_dma(dev, substream->stream);
> 
> Why do we need to enable interrupts for DMA mode?

This is special mechanism about data transmission by DMA controller on the
StarFive JH7110 SoC.
The DMA controller needs to make a handshake with I2S interrupt and cannot
move the audio data without enabling the I2S interrupt.
So I should keep the I2S interrupt enabled in both interrupt or DMA mode.

> 
>> @@ -227,6 +228,21 @@ static void i2s_stop(struct dw_i2s_dev *dev,
>>       }
>>   }
>>   +static int dw_i2s_startup(struct snd_pcm_substream *substream,
>> +              struct snd_soc_dai *cpu_dai)
>> +{
>> +    struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> +    if (dev->is_jh7110) {
>> +        struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
>> +        struct snd_soc_dai_link *dai_link = rtd->dai_link;
>> +
>> +        dai_link->trigger_stop = SND_SOC_TRIGGER_ORDER_LDC;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
>>   {
>>       u32 ch_reg;
>> @@ -267,6 +283,11 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
>>           config->data_width = 16;
>>           dev->ccr = 0x00;
>>           dev->xfer_resolution = 0x02;
>> +        /* Set DMA buswidth on JH7110 */
>> +        if (dev->is_jh7110) {
>> +            dev->play_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +            dev->capture_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +        }
> 
> Not needed.
> See: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20230802&id=6f80197f40515853814d0f22e5209d53f899ab91
> Proper bus width calculations is performed by snd_hwparams_to_dma_slave_config()

Will use this ops instead.

> 
>>           break;
>>         case SNDRV_PCM_FORMAT_S24_LE:
>> @@ -279,6 +300,11 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
>>           config->data_width = 32;
>>           dev->ccr = 0x10;
>>           dev->xfer_resolution = 0x05;
>> +        /* Set DMA buswidth on JH7110 */
>> +        if (dev->is_jh7110) {
>> +            dev->play_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +            dev->capture_dma_data.dt.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
>> +        }
> 
> Not needed
Will drop.

> 

Thanks,
Xingyu Wu

