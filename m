Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6825F786E55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjHXLrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241185AbjHXLrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:47:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539561736;
        Thu, 24 Aug 2023 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692877624; x=1724413624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qHoKoLKO/0YJo/mDA5gVCccZ1A4ufMlOaXW0F6Ph7LQ=;
  b=T299j48Z2eXdeMcWfrDFnb+kJDZt5Ociq7nFV55axDfAFvoLDFAGI8K7
   wBbJimW/wUmmMB/z+13Im9qXeRrRBgx5it+HNnUn+WBAiGP/KBV3neKE5
   pwrYO7SDV9lN6Wd4RjsC7lwaWmXnV3QLtBtRQzvNIh/0l1HKDmBIPkpnk
   1P1fNIDAkQi+uchgODIEJycb3WslDbluvtJ6ydTjj1oFH09AZUW8Am1t1
   RscNMc0lND9lU8ggAwLlRXhH91BBogZb2GUm92cjW4CwTmZDgtCBGV4sW
   rO7Dhhxx9yTjjZ/alO9bHBXWVNitclsdbmhXUV5UQd4J1o9qqK3OqZ2AQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405422673"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405422673"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="740150009"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="740150009"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.187])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 04:47:00 -0700
Message-ID: <e22c4a5f-c592-7121-7173-eef669ebdf89@intel.com>
Date:   Thu, 24 Aug 2023 14:46:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
Content-Language: en-US
To:     Sven van Ashbrook <svenva@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org
Cc:     jason.lai@genesyslogic.com.tw, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        linux-mmc@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        stable@vger.kernel.org
References: <20230823174134.v2.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230823174134.v2.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Looks OK - a few minor comments below

On 23/08/23 20:41, Sven van Ashbrook wrote:
> To improve the r/w performance of GL9763E, the current driver inhibits LPM
> negotiation while the device is active.
> 
> This prevents a large number of SoCs from suspending, notably x86 systems

If possible, can you give example of which SoCs / products

> which use S0ix as the suspend mechanism:
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
>      # on gladios device
>      # on 15590.0.0 with v5.10 and upstream (v6.4) kernels
> 

3 extraneous lines here - please remove

> ---
> 
> Changes in v2:
> - improved symmetry and error path in s2idle suspend callback (internal review)
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 102 +++++++++++++++++++------------
>  1 file changed, 64 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 1792665c9494a..19f577cc8bceb 100644
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
> @@ -1029,6 +993,68 @@ static int gl9763e_runtime_resume(struct sdhci_pci_chip *chip)
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
> +	/* Disable LPM negotiation to bring device back in sync
> +	 * with its runtime_pm state.
> +	 */

I would prefer the comment style:

	/*
	 * Blah, blah ...
	 * Blah, blah, blah.
	 */

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
> +	/* Certain SoCs can suspend only with the bus in low-

Ditto re comment style

> +	 * power state, notably x86 SoCs when using S0ix.
> +	 * Re-enable LPM negotiation to allow entering L1 state
> +	 * and entering system suspend.
> +	 */
> +	gl9763e_set_low_power_negotiation(slot, true);

Couldn't this be at the end of the function, save
an error path

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
> @@ -1113,8 +1139,8 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
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

