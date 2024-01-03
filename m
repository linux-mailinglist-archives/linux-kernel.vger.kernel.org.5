Return-Path: <linux-kernel+bounces-15560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C63822E20
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE1B285D92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E39199A4;
	Wed,  3 Jan 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ifHJ2JQk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E2199A7;
	Wed,  3 Jan 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704288005;
	bh=s7vTp6LFjuarM7eEnLjgpp6xTiC2/ovPwGE/gEID388=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ifHJ2JQk2Xx0eDuhX/RT6938DRzpEPREv4f71QxEvJQ2oGLjZMMBPnbsDGNTuVhOT
	 zSkXooUUb5pOf7mRGvLPBw8auZLztlvWX61KC6ec5mlOWGlP7vVMn4VoaY2ZAeUeS7
	 bMER8BT+AgPg46qevggFAMLCKPDh6BGvKMZgiK5COtQ+apa+3E4Vld9XOTpYJVfnNK
	 vQybCKDEiBzlsC8eq6f5nJMzVDfK8m27JmOYYBOq0ND1YjQllFWqbkpSHnURUBUMYQ
	 qWv9t3Z4guGa1TMRbN0w77d9wue9HJEqBG+qHhVA+WFhg0WuYU3wNo/h1Bp1l2zoww
	 B1S/xHNL+YNCQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B1B0037813F8;
	Wed,  3 Jan 2024 13:20:04 +0000 (UTC)
Message-ID: <5520e8e3-c75b-480f-b831-c40b5cca029f@collabora.com>
Date: Wed, 3 Jan 2024 15:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] clk: mediatek: Introduce need_pm_runtime to
 mtk_clk_desc
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Pin-yen Lin <treapking@chromium.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Weiyi Lu <weiyi.lu@mediatek.com>, linux-mediatek@lists.infradead.org
References: <20240102081402.1226795-1-treapking@chromium.org>
 <eed88b36-ae56-40d3-8588-0d5d75da71a6@collabora.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <eed88b36-ae56-40d3-8588-0d5d75da71a6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/24 14:19, AngeloGioacchino Del Regno wrote:
> Il 02/01/24 09:12, Pin-yen Lin ha scritto:
>> Introduce a new need_pm_runtime variable to mtk_clk_desc to indicate
>> this clock needs a runtime PM get on the clock controller during the
>> probing stage.
>>
>> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 
> Hello Pin-yen,
> 
> We have experienced something similar, but it was really hard to reproduce after
> some changes.
> 
> In an effort to try to solve this issue (but again, reproducing is really hard),
> Eugen has sent a commit in the hope that someone else found a way to easily
> reproduce. Please look at [1].
> 
> I'm also adding Eugen to the Cc's of this email.
> 
> Cheers,
> Angelo
> 
> [1]: 
> https://patchwork.kernel.org/project/linux-pm/patch/20231225133615.78993-1-eugen.hristev@collabora.com/

Hello Pin-yen,

Can you try my patch and let me know if this changes anything for you ?

If it does not change anything, can you also try this one as well ? It's another
attempt to fix the synchronization with genpd.

https://lore.kernel.org/linux-arm-kernel/20231129113120.4907-1-eugen.hristev@collabora.com/

Thanks,
Eugen

> 
>> ---
>>
>> Changes in v2:
>> - Fix the order of error handling
>> - Update the commit message and add a comment before the runtime PM call
>>
>>   drivers/clk/mediatek/clk-mtk.c | 15 +++++++++++++++
>>   drivers/clk/mediatek/clk-mtk.h |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>> index 2e55368dc4d8..c31e535909c8 100644
>> --- a/drivers/clk/mediatek/clk-mtk.c
>> +++ b/drivers/clk/mediatek/clk-mtk.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_address.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>   #include <linux/slab.h>
>>   
>>   #include "clk-mtk.h"
>> @@ -494,6 +495,14 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>   			return IS_ERR(base) ? PTR_ERR(base) : -ENOMEM;
>>   	}
>>   
>> +
>> +	if (mcd->need_runtime_pm) {
>> +		devm_pm_runtime_enable(&pdev->dev);
>> +		r = pm_runtime_resume_and_get(&pdev->dev);
>> +		if (r)
>> +			return r;
>> +	}
>> +
>>   	/* Calculate how many clk_hw_onecell_data entries to allocate */
>>   	num_clks = mcd->num_clks + mcd->num_composite_clks;
>>   	num_clks += mcd->num_fixed_clks + mcd->num_factor_clks;
>> @@ -574,6 +583,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>   			goto unregister_clks;
>>   	}
>>   
>> +	if (mcd->need_runtime_pm)
>> +		pm_runtime_put(&pdev->dev);
>> +
>>   	return r;
>>   
>>   unregister_clks:
>> @@ -604,6 +616,9 @@ static int __mtk_clk_simple_probe(struct platform_device *pdev,
>>   free_base:
>>   	if (mcd->shared_io && base)
>>   		iounmap(base);
>> +
>> +	if (mcd->need_runtime_pm)
>> +		pm_runtime_put(&pdev->dev);
>>   	return r;
>>   }
>>   
>> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
>> index 22096501a60a..c17fe1c2d732 100644
>> --- a/drivers/clk/mediatek/clk-mtk.h
>> +++ b/drivers/clk/mediatek/clk-mtk.h
>> @@ -237,6 +237,8 @@ struct mtk_clk_desc {
>>   
>>   	int (*clk_notifier_func)(struct device *dev, struct clk *clk);
>>   	unsigned int mfg_clk_idx;
>> +
>> +	bool need_runtime_pm;
>>   };
>>   
>>   int mtk_clk_pdev_probe(struct platform_device *pdev);
> 
> 
> 
> 


