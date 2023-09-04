Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D5D7915CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350859AbjIDKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIDKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:42:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E4318F;
        Mon,  4 Sep 2023 03:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824135; x=1725360135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NmjbENqzKSzQkxAGRkl0EHa0SKlj9pMr5261k013CkQ=;
  b=fCGHlZ/mVthEN72D+Gq/68PPzJORKJhePmds8QTRVhIsFyZap4tgIQfv
   2bN/4yPCiympaJGIZkWF0XykihXeu6zVIscD7coHpCOBYfhJVpwhk2K5k
   f/o7XlcNIpcym33k8DTWadEEcbODi99DuuTebOHN4scxO+fIyfnwVQOK9
   H6LTWiMFmXXThcW6DLqPO+nLtFNlj8Zs5uZXZtEvfyiz1QBo757xgKE02
   BAv/4ttkyrQuu/HjS19WMu74NBKmCEA2dnult+npt4mG7WKCp1nFrJJEw
   L6HH8w+7VFmGNQfnXdeNlS4y5S/YkWlrrKrKsogfVqs867QkMxdb4nU15
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="375465152"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375465152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806223682"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806223682"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:39:18 -0700
Message-ID: <8d88df6b-20c8-cc8e-c08a-e9f09466dc41@intel.com>
Date:   Mon, 4 Sep 2023 13:39:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v3] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
Content-Language: en-US
To:     Sven van Ashbrook <svenva@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org
Cc:     ben.chuang@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        rafael.j.wysocki@intel.com, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org, SeanHY.chen@genesyslogic.com.tw,
        victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230831160055.v3.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/23 19:00, Sven van Ashbrook wrote:
> To improve the r/w performance of GL9763E, the current driver inhibits LPM
> negotiation while the device is active.
> 
> This prevents a large number of SoCs from suspending, notably x86 systems
> which commonly use S0ix as the suspend mechanism - for example, Intel
> Alder Lake and Raptor Lake processors.
> 
> Failure description:
> 1. Userspace initiates s2idle suspend (e.g. via writing to
>    /sys/power/state)
> 2. This switches the runtime_pm device state to active, which disables
>    LPM negotiation, then calls the "regular" suspend callback
> 3. With LPM negotiation disabled, the bus cannot enter low-power state
> 4. On a large number of SoCs, if the bus not in a low-power state, S0ix
>    cannot be entered, which in turn prevents the SoC from entering
>    suspend.
> 
> Fix by re-enabling LPM negotiation in the device's suspend callback.
> 
> Suggested-by: Stanislaw Kardach <skardach@google.com>
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sven van Ashbrook <svenva@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes in v3:
> - applied maintainer feedback from https://lore.kernel.org/lkml/CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com/T/#m7cea7b6b987d1ab1ca95feedf2c6f9da5783da5c
> 
> Changes in v2:
> - improved symmetry and error path in s2idle suspend callback (internal review)
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 104 ++++++++++++++++++++-----------
>  1 file changed, 66 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 1792665c9494a..a4ccb6c3e27a6 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -745,42 +745,6 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>  	return value;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -	struct sdhci_pci_slot *slot = chip->slots[0];
> -
> -	pci_free_irq_vectors(slot->chip->pdev);
> -	gli_pcie_enable_msi(slot);
> -
> -	return sdhci_pci_resume_host(chip);
> -}
> -
> -static int sdhci_cqhci_gli_resume(struct sdhci_pci_chip *chip)
> -{
> -	struct sdhci_pci_slot *slot = chip->slots[0];
> -	int ret;
> -
> -	ret = sdhci_pci_gli_resume(chip);
> -	if (ret)
> -		return ret;
> -
> -	return cqhci_resume(slot->host->mmc);
> -}
> -
> -static int sdhci_cqhci_gli_suspend(struct sdhci_pci_chip *chip)
> -{
> -	struct sdhci_pci_slot *slot = chip->slots[0];
> -	int ret;
> -
> -	ret = cqhci_suspend(slot->host->mmc);
> -	if (ret)
> -		return ret;
> -
> -	return sdhci_suspend_host(slot->host);
> -}
> -#endif
> -
>  static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
>  					  struct mmc_ios *ios)
>  {
> @@ -1029,6 +993,70 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
>  }
>  #endif
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +
> +	pci_free_irq_vectors(slot->chip->pdev);
> +	gli_pcie_enable_msi(slot);
> +
> +	return sdhci_pci_resume_host(chip);
> +}
> +
> +static int gl9763e_resume(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +	int ret;
> +
> +	ret = sdhci_pci_gli_resume(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = cqhci_resume(slot->host->mmc);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Disable LPM negotiation to bring device back in sync
> +	 * with its runtime_pm state.
> +	 */
> +	gl9763e_set_low_power_negotiation(slot, false);
> +
> +	return 0;
> +}
> +
> +static int gl9763e_suspend(struct sdhci_pci_chip *chip)
> +{
> +	struct sdhci_pci_slot *slot = chip->slots[0];
> +	int ret;
> +
> +	/*
> +	 * Certain SoCs can suspend only with the bus in low-
> +	 * power state, notably x86 SoCs when using S0ix.
> +	 * Re-enable LPM negotiation to allow entering L1 state
> +	 * and entering system suspend.
> +	 */
> +	gl9763e_set_low_power_negotiation(slot, true);
> +
> +	ret = cqhci_suspend(slot->host->mmc);
> +	if (ret)
> +		goto err_suspend;
> +
> +	ret = sdhci_suspend_host(slot->host);
> +	if (ret)
> +		goto err_suspend_host;
> +
> +	return 0;
> +
> +err_suspend_host:
> +	cqhci_resume(slot->host->mmc);
> +err_suspend:
> +	gl9763e_set_low_power_negotiation(slot, false);
> +	return ret;
> +}
> +#endif
> +
>  static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
>  {
>  	struct pci_dev *pdev = slot->chip->pdev;
> @@ -1113,8 +1141,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
>  	.probe_slot	= gli_probe_slot_gl9763e,
>  	.ops            = &sdhci_gl9763e_ops,
>  #ifdef CONFIG_PM_SLEEP
> -	.resume		= sdhci_cqhci_gli_resume,
> -	.suspend	= sdhci_cqhci_gli_suspend,
> +	.resume		= gl9763e_resume,
> +	.suspend	= gl9763e_suspend,
>  #endif
>  #ifdef CONFIG_PM
>  	.runtime_suspend = gl9763e_runtime_suspend,

