Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0408B780651
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358177AbjHRH1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358175AbjHRH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:27:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468C930DF;
        Fri, 18 Aug 2023 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692343627; x=1723879627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cJ+NA0LkrvKJPwbzMDuKahQyVlN8JReUuKTQwdJCkM4=;
  b=jxOkVCqTlhWqmxFqVBj23O9GU8+0QfOp6bMAxhclb4lZj4ND0oSfjSOq
   kgfdmDlQ7mwCRyAy3nTjsqDuZydibfscaz/pevqDIfS0BUDgZpr26rzRY
   kxHJ51NTkTnaY2nTfZwGuL3bf0BBlmw6T/ITXfNnBmqxdJc78iPcPUstL
   hH4r+SKIXuJySuaNcMbQrZDWIHoVr398LlkTXu7owdSPLwpVuDl+6ELEa
   xsLbz3Xwzl/2eway1yOzZZ5sJ53DpORpSUFF0a9isNgAdMlljRxy0HyBD
   yN4uNrERxgmyk/MFuSiVgXW1UYnKEJu5akidonP8cPtiwgPY6p7CvfvB4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="353340464"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="353340464"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:27:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="764467201"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="764467201"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:27:04 -0700
Message-ID: <a77d1cc6-e932-6568-fb0f-3afff7fcfb3f@intel.com>
Date:   Fri, 18 Aug 2023 10:27:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v8] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230817010608.211329-1-limings@nvidia.com>
 <d802a8c9-aca1-ea47-f4c9-1d76e0fae9c9@intel.com>
 <BN9PR12MB50686B97FCE49645CC849DF6D31AA@BN9PR12MB5068.namprd12.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <BN9PR12MB50686B97FCE49645CC849DF6D31AA@BN9PR12MB5068.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/23 19:22, Liming Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Thursday, August 17, 2023 3:36 AM
>> To: Liming Sun <limings@nvidia.com>; Ulf Hansson <ulf.hansson@linaro.org>;
>> David Thompson <davthompson@nvidia.com>; Shawn Lin <shawn.lin@rock-
>> chips.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v8] mmc: sdhci-of-dwcmshc: Add runtime PM operations
>>
>> On 17/08/23 04:06, Liming Sun wrote:
>>> This commit implements the runtime PM operations to disable eMMC
>>> card clock when idle.
>>>
>>> Reviewed-by: David Thompson <davthompson@nvidia.com>
>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>> ---
>>> v7->v8:
>>>     - Address Ulf's comment (option-1);
>>>     - Updates for Adrian;s comment to remove the force_suspend/resume
>>>       in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
>>>       dwcmshc_resume()/dwcmshc_suspend();
>>> v6->v7:
>>>     - Address Ulf's comment;
>>> v5->v6:
>>>     - Address Adrian's more comments and add coordination between
>>>       runtime PM and system PM;
>>> v4->v5:
>>>     - Address Adrian's comment to move the pm_enable to the end to
>>>       avoid race;
>>> v3->v4:
>>>     - Fix compiling reported by 'kernel test robot';
>>> v2->v3:
>>>     - Revise the commit message;
>>> v1->v2:
>>>     Updates for comments from Ulf:
>>>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
>>> v1: Initial version.
>>> ---
>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76
>> +++++++++++++++++++++++++++--
>>>  1 file changed, 73 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-
>> of-dwcmshc.c
>>> index e68cd87998c8..2196218c9d79 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -15,6 +15,7 @@
>>>  #include <linux/module.h>
>>>  #include <linux/of.h>
>>>  #include <linux/of_device.h>
>>> +#include <linux/pm_runtime.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/sizes.h>
>>>
>>> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device
>> *pdev)
>>>
>>>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>>
>>> +	pm_runtime_get_noresume(dev);
>>> +	pm_runtime_set_active(dev);
>>> +	pm_runtime_enable(dev);
>>> +
>>>  	err = sdhci_setup_host(host);
>>>  	if (err)
>>> -		goto err_clk;
>>> +		goto err_rpm;
>>>
>>>  	if (rk_priv)
>>>  		dwcmshc_rk35xx_postinit(host, priv);
>>> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device
>> *pdev)
>>>  	if (err)
>>>  		goto err_setup_host;
>>>
>>> +	pm_runtime_put(dev);
>>> +
>>>  	return 0;
>>>
>>>  err_setup_host:
>>>  	sdhci_cleanup_host(host);
>>> +err_rpm:
>>> +	pm_runtime_disable(dev);
>>> +	pm_runtime_put_noidle(dev);
>>>  err_clk:
>>>  	clk_disable_unprepare(pltfm_host->clk);
>>>  	clk_disable_unprepare(priv->bus_clk);
>>> @@ -594,6 +604,10 @@ static int dwcmshc_remove(struct platform_device
>> *pdev)
>>>  }
>>>
>>>  #ifdef CONFIG_PM_SLEEP
>>> +/*
>>> + * Note, runtime suspend changes only SDHCI_CLOCK_CARD_EN which has
>> no effect on
>>> + * system suspend.
>>> + */
>>
>> This comment isn't needed since pm_runtime_get_sync() will
>> always runtime resume the device if needed.
> 
> Updated in v9.
> 
>>
>>>  static int dwcmshc_suspend(struct device *dev)
>>>  {
>>>  	struct sdhci_host *host = dev_get_drvdata(dev);
>>> @@ -602,9 +616,11 @@ static int dwcmshc_suspend(struct device *dev)
>>>  	struct rk35xx_priv *rk_priv = priv->priv;
>>>  	int ret;
>>>
>>> +	pm_runtime_get_sync(dev);
>>
>> This needs a corresponding pm_runtime_put() at the end of
>> dwcmshc_resume().
> 
> Updated in v9.
> 
>>
>>> +
>>>  	ret = sdhci_suspend_host(host);
>>>  	if (ret)
>>> -		return ret;
>>> +		goto err_suspend;
>>>
>>>  	clk_disable_unprepare(pltfm_host->clk);
>>>  	if (!IS_ERR(priv->bus_clk))
>>> @@ -614,9 +630,15 @@ static int dwcmshc_suspend(struct device *dev)
>>>  		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
>>>  					   rk_priv->rockchip_clks);
>>>
>>> +err_suspend:
>>> +	pm_runtime_put_noidle(dev);
>>>  	return ret;
>>>  }
>>>
>>> +/*
>>> + * Note, system resume leaves SDHCI_CLOCK_INT_EN off which is consistent
>> with
>>> + * either runtime suspended or runtime resumed.
>>> + */
>>
>> As above, this comment isn't needed.
> 
> Updated in v9.
> 
>>
>>>  static int dwcmshc_resume(struct device *dev)
>>
>>
>> As mentioned above, dwcmshc_resume() needs a pm_runtime_put()
>> to balance the pm_runtime_get_sync().
> 
> Updated in v9.
> 
>>
>> Could fix up the error path too, but that should be a
>> separate prior patch.
>>
>> Probably end up looking like:
>>
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-
>> of-dwcmshc.c
>> index 20aa9b6327d2..c9b020b7a3f6 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -652,17 +652,33 @@ static int dwcmshc_resume(struct device *dev)
>>  	if (!IS_ERR(priv->bus_clk)) {
>>  		ret = clk_prepare_enable(priv->bus_clk);
>>  		if (ret)
>> -			return ret;
>> +			goto disable_clk;
>>  	}
>>
>>  	if (rk_priv) {
>>  		ret = clk_bulk_prepare_enable(RK35xx_MAX_CLKS,
>>  					      rk_priv->rockchip_clks);
>>  		if (ret)
>> -			return ret;
>> +			goto disable_bus_clk;
>>  	}
>>
>> -	return sdhci_resume_host(host);
>> +	ret = sdhci_resume_host(host);
>> +	if (ret)
>> +		goto disable_rockchip_clks;
>> +
>> +	pm_runtime_put(dev);
>> +
>> +	return 0;
>> +
>> +disable_rockchip_clks:
>> +	if (rk_priv)
>> +		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS, rk_priv-
>>> rockchip_clks);
>> +disable_bus_clk:
>> +	if (!IS_ERR(priv->bus_clk))
>> +		clk_disable_unprepare(priv->bus_clk);
>> +disable_clk:
>> +	clk_disable_unprepare(pltfm_host->clk);
>> +	return ret;
>>  }
>>  #endif
>>
>>
> 
> Do you mean a separate 'post' patch? I left it out in v9 and could post another one for this error path. Or do you prefer the same patch series?

Same patch series, 2 patches.  First patch fixes the error paths in dwcmshc_resume().
Second patch adds runtime pm.

> 
>>
>>
>>>  {
>>>  	struct sdhci_host *host = dev_get_drvdata(dev);
>>> @@ -646,7 +668,55 @@ static int dwcmshc_resume(struct device *dev)
>>>  }
>>>  #endif
>>>
>>> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend,
>> dwcmshc_resume);
>>> +#ifdef CONFIG_PM
>>> +
>>> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
>>> +{
>>> +	u16 ctrl;
>>> +
>>> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>> +	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl &
>> SDHCI_CLOCK_CARD_EN)) {
>>> +		ctrl |= SDHCI_CLOCK_CARD_EN;
>>> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
>>> +	}
>>> +}
>>> +
>>> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
>>> +{
>>> +	u16 ctrl;
>>> +
>>> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>>> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
>>> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
>>> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
>>> +	}
>>> +}
>>> +
>>> +static int dwcmshc_runtime_suspend(struct device *dev)
>>> +{
>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>> +
>>> +	dwcmshc_disable_card_clk(host);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int dwcmshc_runtime_resume(struct device *dev)
>>> +{
>>> +	struct sdhci_host *host = dev_get_drvdata(dev);
>>> +
>>> +	dwcmshc_enable_card_clk(host);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +#endif
>>> +
>>> +static const struct dev_pm_ops dwcmshc_pmops = {
>>> +	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
>>> +	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
>>> +			   dwcmshc_runtime_resume, NULL)
>>> +};
>>>
>>>  static struct platform_driver sdhci_dwcmshc_driver = {
>>>  	.driver	= {
> 

