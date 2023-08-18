Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B1F7808BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359279AbjHRJg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359300AbjHRJgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:36:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471053A82;
        Fri, 18 Aug 2023 02:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692351366; x=1723887366;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BPgvkIqGen4FeI4mN2LHggkpXTy5qZYtRQxWQNdLyWw=;
  b=h3L68pVHPuhVWYwDRDJVNqkT2kgMi9dHG1m8tfrV9OwXhAR+U4fXjrn4
   gKgkFsY1PuzBD2tvEFnBsCbum3Uiu1MVGheZU6Av6OAgQHaE+G3cJ4jZT
   CKdOlt1rqGpTvDb7AiSRfXDFRRHQJ6IZhMmQxRV5FGovU38vCej0nLSaA
   MQX3FNgOCn3tStNToHrmRqASmFEhwg0TeosiwRL+uqWpPJj1IUCqPzCeQ
   yLjDrtbaszbH7tlhQaSzIun2raQK6ATlbmUcenRU25jzT0WM5S7PgACWI
   dUUY3puyr47tUPB+WFx6ZKD6fyYLZUB5/QLiMqsW/uM1ucIub8XxQs+4X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404044216"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="404044216"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="805088961"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="805088961"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.27])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:36:03 -0700
Message-ID: <c5f59dfd-a0dd-3b77-55fb-1087cbbbef25@intel.com>
Date:   Fri, 18 Aug 2023 12:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Liming Sun <limings@nvidia.com>
Cc:     David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230817162159.242087-1-limings@nvidia.com>
 <CAPDyKFpezrjPk6Y+TS1A1E2tK4WbjdpTjPwPxLaAUD9fcaQonQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFpezrjPk6Y+TS1A1E2tK4WbjdpTjPwPxLaAUD9fcaQonQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/23 12:00, Ulf Hansson wrote:
> On Thu, 17 Aug 2023 at 18:22, Liming Sun <limings@nvidia.com> wrote:
>>
>> This commit implements the runtime PM operations to disable eMMC
>> card clock when idle.
>>
>> Reviewed-by: David Thompson <davthompson@nvidia.com>
>> Signed-off-by: Liming Sun <limings@nvidia.com>
>> ---
>> v8->v9:
>>     - Address Adrian's comment to do the pm_runtime_put() in
>>       dwcmshc_resume() instead; Error path changes not included yet.
>> v7->v8:
>>     - Address Ulf's comment (option-1);
>>     - Updates for Adrian's comment to remove the force_suspend/resume
>>       in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
>>       dwcmshc_resume()/dwcmshc_suspend();
>> v6->v7:
>>     - Address Ulf's comment;
>> v5->v6:
>>     - Address Adrian's more comments and add coordination between
>>       runtime PM and system PM;
>> v4->v5:
>>     - Address Adrian's comment to move the pm_enable to the end to
>>       avoid race;
>> v3->v4:
>>     - Fix compiling reported by 'kernel test robot';
>> v2->v3:
>>     - Revise the commit message;
>> v1->v2:
>>     Updates for comments from Ulf:
>>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
>> v1: Initial version.
>> ---
>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 76 +++++++++++++++++++++++++++--
>>  1 file changed, 72 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index e68cd87998c8..3b40f55ce2a4 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/reset.h>
>>  #include <linux/sizes.h>
>>
>> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>
>>         host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>>
>> +       pm_runtime_get_noresume(dev);
>> +       pm_runtime_set_active(dev);
>> +       pm_runtime_enable(dev);
>> +
>>         err = sdhci_setup_host(host);
>>         if (err)
>> -               goto err_clk;
>> +               goto err_rpm;
>>
>>         if (rk_priv)
>>                 dwcmshc_rk35xx_postinit(host, priv);
>> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>>         if (err)
>>                 goto err_setup_host;
>>
>> +       pm_runtime_put(dev);
>> +
>>         return 0;
>>
>>  err_setup_host:
>>         sdhci_cleanup_host(host);
>> +err_rpm:
>> +       pm_runtime_disable(dev);
>> +       pm_runtime_put_noidle(dev);
>>  err_clk:
>>         clk_disable_unprepare(pltfm_host->clk);
>>         clk_disable_unprepare(priv->bus_clk);
>> @@ -602,9 +612,13 @@ static int dwcmshc_suspend(struct device *dev)
>>         struct rk35xx_priv *rk_priv = priv->priv;
>>         int ret;
>>
>> +       pm_runtime_get_sync(dev);
>> +
>>         ret = sdhci_suspend_host(host);
>> -       if (ret)
>> +       if (ret) {
>> +               pm_runtime_put(dev);
>>                 return ret;
>> +       }
>>
>>         clk_disable_unprepare(pltfm_host->clk);
>>         if (!IS_ERR(priv->bus_clk))
>> @@ -642,11 +656,65 @@ static int dwcmshc_resume(struct device *dev)
>>                         return ret;
>>         }
>>
>> -       return sdhci_resume_host(host);
>> +       ret = sdhci_resume_host(host);
>> +       if (ret)
>> +               return ret;
>> +
>> +       pm_runtime_put(dev);
> 
> To simplify the error path, I would suggest that you move the call to
> pm_runtime_put() to dwcmshc_suspend(). In fact what you need is just a
> call to pm_runtime_put_noidle(), somewhere after the call to
> pm_runtime_get_sync().
> 
> This is because runtime suspend is prevented by the PM core as it
> bumps the usage count with a pm_runtime_get_noresume() in the
> device_prepare() phase.

I thought you didn't want to assume that, because in that case
it can just be pm_runtime_resume() instead of pm_runtime_get_sync(),
and then no 'put' is needed at all.

> 
>> +
>> +       return 0;
>>  }
>>  #endif
> 
> [...]
> 
> Kind regards
> Uffe

