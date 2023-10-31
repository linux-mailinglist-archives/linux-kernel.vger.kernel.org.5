Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F17DC8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjJaJA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjJaJAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:00:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202AEDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:00:20 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2E95D660739C;
        Tue, 31 Oct 2023 09:00:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698742818;
        bh=UU2Oj+y2TCzI0eezoMhW5iWMTGs/KOvv8ZSljxigaJs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Aoq291mUUwOEt3iyu4ZFQEpS4J97MOXmZVOrhDTJ77EhmhnGBrxnG0E6+2jCBibPF
         ua1xvjbDMCwVHuZt3iYQBcDo/TthQGsdXLDqJx3pEJ6q4dS2EjMX8JSlztgucKieXr
         jOPP4BlPqIvu6HPouFexZX+0l367OKFS+7wVMdfmaWGOFpvTMMsG+LwwUMTCxG0jnw
         gEWAalZHoxjeDFRE3Wo/h7ZL5MsCzvLHJK2Pmku6KZBpH97xQxgJw/UI47HJoNdNEU
         OauLtRLzdKxtjBtpCpv0pC7U1A51j1ME4UMw/F07VncVIGqeDVBKB8h4mywXd7rWLn
         coKyLVYVX0scg==
Message-ID: <85cc1cae-7135-4118-b70a-96eb8d3f0842@collabora.com>
Date:   Tue, 31 Oct 2023 10:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/panfrost: Implement ability to turn on/off
 regulators in suspend
Content-Language: en-US
To:     Steven Price <steven.price@arm.com>, boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231030132257.85379-1-angelogioacchino.delregno@collabora.com>
 <20231030132257.85379-4-angelogioacchino.delregno@collabora.com>
 <2b553f07-71d0-4d06-8f60-7cd8f29d78e1@arm.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2b553f07-71d0-4d06-8f60-7cd8f29d78e1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/10/23 15:57, Steven Price ha scritto:
> On 30/10/2023 13:22, AngeloGioacchino Del Regno wrote:
>> Some platforms/SoCs can power off the GPU entirely by completely cutting
>> off power, greatly enhancing battery time during system suspend: add a
>> new pm_feature GPU_PM_VREG_OFF to allow turning off the GPU regulators
>> during full suspend only on selected platforms.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/panfrost/panfrost_device.c | 19 ++++++++++++++++++-
>>   drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>> index 2022ed76a620..51b22eb0971d 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>> @@ -431,10 +431,21 @@ static int panfrost_device_resume(struct device *dev)
>>   	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>>   	int ret;
>>   
>> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF)) {
>> +		unsigned long freq = pfdev->pfdevfreq.fast_rate;
>> +		struct dev_pm_opp *opp;
>> +
>> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> +		if (IS_ERR(opp))
>> +			return PTR_ERR(opp);
>> +		dev_pm_opp_put(opp);
>> +		dev_pm_opp_set_opp(dev, opp);
> 
> These lines look the wrong way round - surely we want to hang onto the
> reference until the set_opp call is made?
> 

Whoops! Yes, thanks, this happened during a cleanup for whatever reason.
I'll invert those for v2.

Angelo

> Steve
> 
>> +	}
>> +
>>   	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS)) {
>>   		ret = clk_enable(pfdev->clock);
>>   		if (ret)
>> -			return ret;
>> +			goto err_clk;
>>   
>>   		if (pfdev->bus_clock) {
>>   			ret = clk_enable(pfdev->bus_clock);
>> @@ -455,6 +466,9 @@ static int panfrost_device_resume(struct device *dev)
>>   err_bus_clk:
>>   	if (pfdev->comp->pm_features & BIT(GPU_PM_CLK_DIS))
>>   		clk_disable(pfdev->clock);
>> +err_clk:
>> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
>> +		dev_pm_opp_set_opp(dev, NULL);
>>   	return ret;
>>   }
>>   
>> @@ -474,6 +488,9 @@ static int panfrost_device_suspend(struct device *dev)
>>   			clk_disable(pfdev->bus_clock);
>>   	}
>>   
>> +	if (pfdev->comp->pm_features & BIT(GPU_PM_VREG_OFF))
>> +		dev_pm_opp_set_opp(dev, NULL);
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
>> index d7f179eb8ea3..0fc558db6bfd 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>> @@ -28,9 +28,11 @@ struct panfrost_perfcnt;
>>   /**
>>    * enum panfrost_gpu_pm - Supported kernel power management features
>>    * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
>> + * @GPU_PM_VREG_OFF: Allow turning off regulators during system suspend
>>    */
>>   enum panfrost_gpu_pm {
>>   	GPU_PM_CLK_DIS,
>> +	GPU_PM_VREG_OFF,
>>   };
>>   
>>   struct panfrost_features {
> 
> _______________________________________________
> Kernel mailing list -- kernel@mailman.collabora.com
> To unsubscribe send an email to kernel-leave@mailman.collabora.com



