Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A68777277
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjHJINM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjHJINJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24435ED;
        Thu, 10 Aug 2023 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691655186; x=1723191186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O9Jsveli4yclURq0bNMJiXiGpid26w6a4aIJvzlJGho=;
  b=TT/xQ+tbgF/mo3ahFT0vmlwCX2c79vZ4ajN5ooAdIC6Ft+6/cNtJsWip
   ZTeH61cO5BibpRBNCzzB+jcIfdFTjmr7tig7PeRGnZkuKotDTNw2M/ro+
   u/ygLJaScZmAzcMp5vuEH0k1DpIX5h8pk6OaQLngUU2DuIcCt7zOLxkBy
   5/KoiWM+jxLKrgi0Q6xF5z0/nhIoCPNAf6SoLaboWTy5XRYfmgOph2yBF
   pGRbGWB1lP1EJSkQfhipvkmq1upq/x1lthq8MYoMqaj2F0iWxRHe8GNNW
   fkcxfVukWcQhpPDRLGune+ihcIyXkYkPUDg+i+U9E0k+yjiA9o66Cc1hk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368791385"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="368791385"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:12:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="978702520"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="978702520"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:12:53 -0700
Message-ID: <16047c7a-5bd1-868c-e6eb-e5f415e77fdd@intel.com>
Date:   Thu, 10 Aug 2023 11:12:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230808202319.191434-1-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230808202319.191434-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/08/23 23:23, Liming Sun wrote:
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
> v6->v7:
>     - Address Ulf's comment;
> v5->v6:
>     - Address Adrian's more comments and add coordination between
>       runtime PM and system PM;
> v4->v5:
>     - Address Adrian's comment to move the pm_enable to the end to
>       avoid race;
> v3->v4:
>     - Fix compiling reported by 'kernel test robot';
> v2->v3:
>     - Revise the commit message;
> v1->v2:
>     Updates for comments from Ulf:
>     - Make the runtime PM logic generic for sdhci-of-dwcmshc;
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..c8e145031429 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  
> @@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  
>  	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
>  	err = sdhci_setup_host(host);
>  	if (err)
> -		goto err_clk;
> +		goto err_rpm;
>  
>  	if (rk_priv)
>  		dwcmshc_rk35xx_postinit(host, priv);
> @@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_setup_host;
>  
> +	pm_runtime_put(dev);
> +
>  	return 0;
>  
>  err_setup_host:
>  	sdhci_cleanup_host(host);
> +err_rpm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
>  	clk_disable_unprepare(priv->bus_clk);
> @@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		sdhci_resume_host(host);
> +		return ret;
> +	}

Since you are only using the runtime PM callbacks to turn off the card
clock via SDHCI_CLOCK_CONTROL, pm_runtime_force_suspend() and
pm_runtime_force_resume() are not needed at all.

sdhci_suspend_host() does not care if SDHCI_CLOCK_CARD_EN is on or off.
(And you are disabling pltfm_host->clk and priv->bus_clk, so presumably
the result is no clock either way)

sdhci_resume_host() does not restore state unless
SDHCI_QUIRK2_HOST_OFF_CARD_ON is used, it just resets, so the internal clock
SDHCI_CLOCK_INT_EN is off which is consistent with either runtime suspended
or runtime resumed.

So it just needs some comments, for example:

+/*
+ * Note, runtime suspend changes only SDHCI_CLOCK_CARD_EN which has no effect on
+ * system suspend.
+ */
 static int dwcmshc_suspend(struct device *dev)
 
+/*
+ * Note, system resume leaves SDHCI_CLOCK_INT_EN off which is consistent with
+ * either runtime suspended or runtime resumed.
+ */
 static int dwcmshc_resume(struct device *dev)


> +
>  	clk_disable_unprepare(pltfm_host->clk);
>  	if (!IS_ERR(priv->bus_clk))
>  		clk_disable_unprepare(priv->bus_clk);
> @@ -625,6 +641,10 @@ static int dwcmshc_resume(struct device *dev)
>  	struct rk35xx_priv *rk_priv = priv->priv;
>  	int ret;
>  
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
>  	ret = clk_prepare_enable(pltfm_host->clk);
>  	if (ret)
>  		return ret;
> @@ -646,7 +666,55 @@ static int dwcmshc_resume(struct device *dev)
>  }
>  #endif
>  
> -static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
> +#ifdef CONFIG_PM
> +
> +static void dwcmshc_enable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
> +		ctrl |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	if (ctrl & SDHCI_CLOCK_CARD_EN) {
> +		ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
> +	}
> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +	dwcmshc_disable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +	dwcmshc_enable_card_clk(host);
> +
> +	return 0;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
> +	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +			   dwcmshc_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver sdhci_dwcmshc_driver = {
>  	.driver	= {

