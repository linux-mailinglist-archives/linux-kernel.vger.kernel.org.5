Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5714A78E85F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjHaIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbjHaIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:36:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F1DE75;
        Thu, 31 Aug 2023 01:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693470959; x=1725006959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fA57oYLGFg0kwbKul1wqjbHN6c9XpJtzg5SwFCiRtks=;
  b=RntLQpmY3HFKQP0eArHVwdglmRhR9VqS6SmS//gQvhuZxWi3kA4gCJSF
   O3LEEWXUQpMlJ+Y85cFHFe+jcVYx1oLqwIAA2Pd50AC2A2QmCQ0TbGEI4
   LqcDt8MRcUcIoNTt+lScPPD3i1INQGsf0AW/PUkCk6WaxKKLUaLw2FqsK
   9zq3hpKLXXXAYr7ASUKMkATK1Mo+Nx+7UfVVw2oAoBB9YJSUNUaypkRES
   GUzqskCM+jFf3kSRVHrABEBlmlHYkLgKOwVKKjeK0ma9r8WuYJnyPddTH
   3OBrZkYgpq2lYVhJ2CaCS4BYz4N9EaoX9/2vH75Zq/xTtC9lxFavz2nkd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355366248"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="355366248"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:34:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="809492361"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="809492361"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.245])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:34:54 -0700
Message-ID: <e8ed5409-5a00-9478-5b91-85d54b7fb2bb@intel.com>
Date:   Thu, 31 Aug 2023 11:34:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH V10 20/23] mmc: sdhci-uhs2: add add_host() and others to
 set up the driver
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-21-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230818100217.12725-21-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/23 13:02, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's add_host/remove_host operation.
> Any sdhci drivers which are capable of handling UHS-II cards must
> call those functions instead of the corresponding sdhci's.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V10:
>  - Move some definitions of PatchV9[05/23] to PatchV10[20/23].
> 
> Updates in V8:
>  - Change return type to void for __sdhci_uhs2_add_host_v4().
>  - Remove unused variables in __sdhci_uhs2_add_host_v4().
> 
> Updates in V7:
>  - __sdhci_add_host() to instead of __sdhci_uhs2_add_host()
>    in sdhci_uhs2_add_host().
>  - Cancel export state of some functions.
> 
> Updates in V6:
>  - Add complete_work_fn/thread_irq_fn variables in struct sdhci_host.
>  - Use complete_work_fn/thread_irq_fn variables in
>    sdhci_alloc_host() and sdhci_uhs2_add_host().
>  - Use sdhci_uhs2_mode() to simplify code in __sdhci_uhs2_remove_host().
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 102 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |   2 +
>  drivers/mmc/host/sdhci.c      |   7 ++-
>  drivers/mmc/host/sdhci.h      |   3 +
>  include/linux/mmc/host.h      |   1 +
>  5 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 8d1be670af49..80eafacc8b9f 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -16,6 +16,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/host.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-uhs2.h"
> @@ -997,6 +998,107 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*****************************************************************************\
> + *
> + * Device allocation/registration                                            *
> + *                                                                           *
> +\*****************************************************************************/
> +
> +static void __sdhci_uhs2_add_host_v4(struct sdhci_host *host, u32 caps1)
> +{
> +	struct mmc_host *mmc;
> +	u32 max_current_caps2;
> +
> +	mmc = host->mmc;
> +
> +	/* Support UHS2 */
> +	if (caps1 & SDHCI_SUPPORT_UHS2)
> +		mmc->caps2 |= MMC_CAP2_SD_UHS2;
> +
> +	max_current_caps2 = sdhci_readl(host, SDHCI_MAX_CURRENT_1);
> +
> +	if ((caps1 & SDHCI_CAN_VDD2_180) &&
> +	    !max_current_caps2 &&
> +	    !IS_ERR(mmc->supply.vmmc2)) {
> +		/* UHS2 - VDD2 */
> +		int curr = regulator_get_current_limit(mmc->supply.vmmc2);
> +
> +		if (curr > 0) {
> +			/* convert to SDHCI_MAX_CURRENT format */
> +			curr = curr / 1000;  /* convert to mA */
> +			curr = curr / SDHCI_MAX_CURRENT_MULTIPLIER;
> +			curr = min_t(u32, curr, SDHCI_MAX_CURRENT_LIMIT);
> +			max_current_caps2 = curr;
> +		}
> +	}
> +
> +	if (caps1 & SDHCI_CAN_VDD2_180)
> +		mmc->ocr_avail_uhs2 |= MMC_VDD_165_195;
> +	else
> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +}
> +
> +static int sdhci_uhs2_host_ops_init(struct sdhci_host *host);
> +
> +static void __sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> +{
> +	if (!sdhci_uhs2_mode(host))
> +		return;
> +
> +	if (!dead)
> +		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_FULL);
> +}
> +
> +int sdhci_uhs2_add_host(struct sdhci_host *host)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	int ret;
> +
> +	ret = sdhci_setup_host(host);
> +	if (ret)
> +		return ret;
> +
> +	if (host->version >= SDHCI_SPEC_400)
> +		__sdhci_uhs2_add_host_v4(host, host->caps1);
> +
> +	if ((mmc->caps2 & MMC_CAP2_SD_UHS2) && !host->v4_mode)
> +		/* host doesn't want to enable UHS2 support */
> +		mmc->caps2 &= ~MMC_CAP2_SD_UHS2;
> +
> +	/* overwrite ops */
> +	if (mmc->caps2 & MMC_CAP2_SD_UHS2)
> +		sdhci_uhs2_host_ops_init(host);
> +
> +	host->complete_work_fn = sdhci_uhs2_complete_work;
> +	host->thread_irq_fn    = sdhci_uhs2_thread_irq;
> +
> +	/* LED support not implemented for UHS2 */
> +	host->quirks |= SDHCI_QUIRK_NO_LED;
> +
> +	ret = __sdhci_add_host(host);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	if (host->version >= SDHCI_SPEC_400)
> +		__sdhci_uhs2_remove_host(host, 0);
> +
> +	sdhci_cleanup_host(host);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_add_host);
> +
> +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead)
> +{
> +	__sdhci_uhs2_remove_host(host, dead);
> +
> +	sdhci_remove_host(host, dead);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_remove_host);
> +
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 3aa2cb4b39d6..bd5aae054c6f 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -186,5 +186,7 @@ void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_uhs2_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask);
> +int sdhci_uhs2_add_host(struct sdhci_host *host);
> +void sdhci_uhs2_remove_host(struct sdhci_host *host, int dead);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 318d4830732f..b3de7e30ba54 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4104,6 +4104,9 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>  
>  	host->max_timeout_count = 0xE;
>  
> +	host->complete_work_fn = sdhci_complete_work;
> +	host->thread_irq_fn    = sdhci_thread_irq;
> +
>  	return host;
>  }
>  
> @@ -4853,7 +4856,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  	if (!host->complete_wq)
>  		return -ENOMEM;
>  
> -	INIT_WORK(&host->complete_work, sdhci_complete_work);
> +	INIT_WORK(&host->complete_work, host->complete_work_fn);
>  
>  	timer_setup(&host->timer, sdhci_timeout_timer, 0);
>  	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
> @@ -4862,7 +4865,7 @@ int __sdhci_add_host(struct sdhci_host *host)
>  
>  	sdhci_init(host, 0);
>  
> -	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
> +	ret = request_threaded_irq(host->irq, sdhci_irq, host->thread_irq_fn,
>  				   IRQF_SHARED,	mmc_hostname(mmc), host);
>  	if (ret) {
>  		pr_err("%s: Failed to request IRQ %d: %d\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6bbb9f073f29..5235f2da6568 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -626,6 +626,9 @@ struct sdhci_host {
>  	struct timer_list timer;	/* Timer for timeouts */
>  	struct timer_list data_timer;	/* Timer for data timeouts */
>  
> +	void		(*complete_work_fn)(struct work_struct *work);
> +	irqreturn_t	(*thread_irq_fn)(int irq, void *dev_id);
> +
>  #if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
>  	struct dma_chan *rx_chan;
>  	struct dma_chan *tx_chan;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1eba64228725..918d4998c1de 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -379,6 +379,7 @@ struct mmc_host {
>  	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
>  	u32			ocr_avail_sd;	/* SD-specific OCR */
>  	u32			ocr_avail_mmc;	/* MMC-specific OCR */
> +	u32			ocr_avail_uhs2; /* UHS2-specific OCR */

ocr_avail_uhs2 gets set but doesn't seem to be used

>  	struct wakeup_source	*ws;		/* Enable consume of uevents */
>  	u32			max_current_330;
>  	u32			max_current_300;

