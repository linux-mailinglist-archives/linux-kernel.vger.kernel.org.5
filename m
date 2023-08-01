Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698BF76B8B1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjHAPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjHAPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:36:50 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E878E1B0;
        Tue,  1 Aug 2023 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690904209; x=1722440209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NkcmWqH8lFlBt8JVs8Fywn256uGO6JM0+7urScRc4+c=;
  b=HcmnZlDasiGeZ3F0q7F5Ur5xOe/ocoHmnT071UI/vU/hEQ7svbYVotG7
   ydzlYx5ttZmRMl2eI0+mcQn4BTbIRmaNs3/kVhw6BrCYz3Jy72gJVzxoU
   vLXwdA2Da9wMXULMXfL9agIi/XS3JXeVPoOc2FM2Hg2J/fSKHGFUgWylN
   zBboh8wt40ipHXDhziaFrOmGsV9G8OWHuJK5AProsk4zY7ML8DtUYbXWd
   E5phDMP6QGmb+ALYS9ah0jjTSvQ/PNtAuEl6ZLoYQdHaQOJKBuhfowH7g
   emLDL5Gm+jiSiH7VbGn3qK2p6Qv7yM8G2x5KWJwk6vfhTfLeaCVL5rkFy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="435657872"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="435657872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="794237498"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="794237498"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.126])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 08:36:46 -0700
Message-ID: <c1830d80-c8b2-19ec-fbfd-6bc3d2c806ce@intel.com>
Date:   Tue, 1 Aug 2023 18:36:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH v5] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230728122052.296488-1-limings@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230728122052.296488-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/23 15:20, Liming Sun wrote:
> This commit implements the runtime PM operations to disable eMMC
> card clock when idle.
> 
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
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
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 54 ++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index e68cd87998c8..5cee42d72257 100644
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
> @@ -559,6 +560,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_setup_host;
>  
> +	devm_pm_runtime_enable(dev);

By default, runtime PM regards the device as not active, so
typically drivers will use something like pm_runtime_set_active()
prior to pm_runtime_enable(dev)

In fact it is better to enable before adding the host but
increment the usage count to prevent runtime suspend.  That
means adding some get/puts, ending up with something like:

+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);

	err = sdhci_setup_host(host);
	if (err)
-		goto err_clk;
+		goto err_rpm;

	if (rk_priv)
		dwcmshc_rk35xx_postinit(host, priv);

	err = __sdhci_add_host(host);
	if (err)
		goto err_setup_host;

+	pm_runtime_put_sync(dev);

	return 0;

err_setup_host:
	sdhci_cleanup_host(host);
+ err_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
err_clk:
	clk_disable_unprepare(pltfm_host->clk);
	clk_disable_unprepare(priv->bus_clk);
	if (rk_priv)
		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
					   rk_priv->rockchip_clks);
free_pltfm:
	sdhci_pltfm_free(pdev);
	return err;

> +
>  	return 0;
>  
>  err_setup_host:
> @@ -646,7 +649,56 @@ static int dwcmshc_resume(struct device *dev)
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

You could save an mmio write:

	if (ctrl & SDHCI_CLOCK_INT_EN && !(ctrl & SDHCI_CLOCK_CARD_EN)) {

> +	ctrl |= SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);

	}

> +}
> +
> +static void dwcmshc_disable_card_clk(struct sdhci_host *host)
> +{
> +	u16 ctrl;
> +
> +	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

You could save an mmio write:

	if (ctrl & SDHCI_CLOCK_CARD_EN) {

> +	ctrl &= ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);

	}

> +}
> +
> +static int dwcmshc_runtime_suspend(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret = 0;

ret doesn't need initialization

> +
> +	ret = sdhci_runtime_suspend_host(host);

If you *only* want to disable the card clock, then
it is probably not necessary to call sdhci_runtime_suspend_host()
and sdhci_runtime_resume_host().

> +	if (!ret)
> +		dwcmshc_disable_card_clk(host);
> +
> +	return ret;
> +}
> +
> +static int dwcmshc_runtime_resume(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret = 0;

ret isn't needed

> +
> +	dwcmshc_enable_card_clk(host);
> +	ret = sdhci_runtime_resume_host(host, 0);

just
	return sdhci_runtime_resume_host(host, 0);

> +
> +	return ret;
> +}
> +
> +#endif
> +
> +static const struct dev_pm_ops dwcmshc_pmops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)

Typically you need a way to coordinate runtime PM and system PM, refer:

https://www.kernel.org/doc/html/latest/power/runtime_pm.html#runtime-pm-and-system-sleep

> +	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
> +			   dwcmshc_runtime_resume, NULL)
> +};
>  
>  static struct platform_driver sdhci_dwcmshc_driver = {
>  	.driver	= {

