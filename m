Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33517F4671
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjKVMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjKVMl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:41:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D12E7;
        Wed, 22 Nov 2023 04:41:23 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63FFF6607286;
        Wed, 22 Nov 2023 12:41:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700656881;
        bh=S07GE5Evlp8wz8GDG6gCdX6gFUE//1gN9B0MVvjvdJo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k2UOjMXZUuaJpe6a/ieoqkAsnboxK4czoceIqJ/3TKI2LwE1POXpHmBtOIVzofmUQ
         USjmEG4I7ejnCm4+2Ovp/4EdcxRyfzbr+Vq9zslZmRvTPJEpAK7zu4ZXF1Ny1OYnjx
         0r4enlSxTcUC0uabr8pullCZ98p1x0YuvVQE4LVVgIhdsKiZLk3Qi5rRgh6SxYrX6G
         8gB8DBPxxTYXpIVdvZBZOxKa8pdrZLRTScp++nDMoBNcasoQatNSUeVpwSX4JL129d
         VoG5n7S/SS/5wGUGnWHgB4aSVj1Vcbp2cmqe6+9Q+E5IVSFlVwfBvZbgU2AzE9dY8U
         /ay4c6qg6e2MA==
Message-ID: <43982a3c-eb10-442e-acca-fd4b944a7612@collabora.com>
Date:   Wed, 22 Nov 2023 13:41:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/20] soc: mediatek: mtk-svs: Move t-calibration-data
 retrieval to svs_probe()
Content-Language: en-US
To:     Eugen Hristev <eugen.hristev@collabora.com>, matthias.bgg@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231121125044.78642-1-angelogioacchino.delregno@collabora.com>
 <20231121125044.78642-10-angelogioacchino.delregno@collabora.com>
 <6018ec3f-d3e6-4fe0-b57f-9a7994f983a5@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6018ec3f-d3e6-4fe0-b57f-9a7994f983a5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/11/23 12:23, Eugen Hristev ha scritto:
> On 11/21/23 14:50, AngeloGioacchino Del Regno wrote:
>> The t-calibration-data (SVS-Thermal calibration data) shall exist for
>> all SoCs or SVS won't work anyway: move it to the common svs_probe()
>> function and remove it from all of the per-SoC efuse_parsing() probe
>> callbacks.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/soc/mediatek/mtk-svs.c | 32 ++++++--------------------------
>>   1 file changed, 6 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
>> index ab564d48092b..1042af2aee3f 100644
>> --- a/drivers/soc/mediatek/mtk-svs.c
>> +++ b/drivers/soc/mediatek/mtk-svs.c
>> @@ -1884,11 +1884,6 @@ static bool svs_mt8195_efuse_parsing(struct svs_platform 
>> *svsp)
>>           svsb->vmax += svsb->dvt_fixed;
>>       }
>> -    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> -                 &svsp->tefuse, &svsp->tefuse_max);
>> -    if (ret)
>> -        return false;
>> -
> 
> Hello Angelo,
> 
> if you removed the code using `ret` in this patch, it makes sense to also remove 
> the variable here instead of doing it in patch 18.
> It will avoid unused variable warnings for this patch.
> 
> 

Yes, though the comment is not for this function, but rather for 8183. Anyway, that
makes sense, but if it's the only change of this v3, it's something that I can fix
while applying instead of sending another 20 patches round. Thanks.

>>       for (i = 0; i < svsp->tefuse_max; i++)
>>           if (svsp->tefuse[i] != 0)
>>               break;
>> @@ -1949,11 +1944,6 @@ static bool svs_mt8192_efuse_parsing(struct svs_platform 
>> *svsp)
>>           svsb->vmax += svsb->dvt_fixed;
>>       }
>> -    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> -                 &svsp->tefuse, &svsp->tefuse_max);
>> -    if (ret)
>> -        return false;
>> -
>>       for (i = 0; i < svsp->tefuse_max; i++)
>>           if (svsp->tefuse[i] != 0)
>>               break;
>> @@ -2009,11 +1999,6 @@ static bool svs_mt8188_efuse_parsing(struct svs_platform 
>> *svsp)
>>           svsb->vmax += svsb->dvt_fixed;
>>       }
>> -    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> -                 &svsp->tefuse, &svsp->tefuse_max);
>> -    if (ret)
>> -        return false;
>> -
>>       for (i = 0; i < svsp->tefuse_max; i++)
>>           if (svsp->tefuse[i] != 0)
>>               break;
>> @@ -2097,11 +2082,6 @@ static bool svs_mt8186_efuse_parsing(struct svs_platform 
>> *svsp)
>>           svsb->vmax += svsb->dvt_fixed;
>>       }
>> -    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> -                 &svsp->tefuse, &svsp->tefuse_max);
>> -    if (ret)
>> -        return false;
>> -
>>       golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
>>       if (!golden_temp)
>>           golden_temp = 50;
>> @@ -2198,11 +2178,6 @@ static bool svs_mt8183_efuse_parsing(struct svs_platform 
>> *svsp)
>>           }
>>       }
>> -    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> -                 &svsp->tefuse, &svsp->tefuse_max);
>> -    if (ret)
>> -        return false;
>> -
>>       /* Thermal efuse parsing */
>>       adc_ge_t = (svsp->tefuse[1] >> 22) & GENMASK(9, 0);
>>       adc_oe_t = (svsp->tefuse[1] >> 12) & GENMASK(9, 0);
>> @@ -3040,8 +3015,13 @@ static int svs_probe(struct platform_device *pdev)
>>       ret = svs_get_efuse_data(svsp, "svs-calibration-data",
>>                    &svsp->efuse, &svsp->efuse_max);
>> +    if (ret)
>> +        return dev_err_probe(&pdev->dev, ret, "Cannot read SVS calibration\n");
> 
> With the previous code, if svs-calibration-data could not be read, the code would 
> go to svs_probe_free_efuse. In your case, it returns directly.
> I believe that svs_get_efuse_data using nvmem_cell_read does not allocate the 
> buffer for the efuse , hence no more need to free it ? The exit code is checking if 
> it's ERR or NULL, but still, if the buffer was not allocated, it doesn't make sense 
> to jump there indeed.
> In that case, you are also changing the behavior here , and your commit appears to 
> do more than a simple move.
> 

I'm not changing the behavior: the previous behavior was to fail and free the efuse
variable if previously allocated, the current behavior is to fail and free the
efuse variable if previously allocated, and the tefuse variable if previously
allocated, which is a result of the actual move of the retrieval of the thermal
fuse calibration data.

I really don't see anything implicit here.

>> +
>> +    ret = svs_get_efuse_data(svsp, "t-calibration-data",
>> +                 &svsp->tefuse, &svsp->tefuse_max);
>>       if (ret) {
>> -        ret = -EPERM;
>> +        dev_err_probe(&pdev->dev, ret, "Cannot read SVS-Thermal calibration\n");
>>           goto svs_probe_free_efuse;
> 
> again in this case the tefuse has not been allocated I assume.
> 
> So previous code was a bit excessive in trying to free the efuse/tefuse ?

The previous code was performing an useless error check on something that was not
supposed to be allocated *yet*. Yes, it was wrong before.

Cheers,
Angelo
