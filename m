Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654D87FB550
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbjK1JMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjK1JMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:12:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6FED5D;
        Tue, 28 Nov 2023 01:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701162766; x=1732698766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rz3wQP6YChMUx4yVgNfLLjktHLywG5oQ9+P39e1uh98=;
  b=Pm9npnscT/E0t/5DA5Sj1X4mhGLpIjOH3orzbdT3U//mM6fHUi3TuwqR
   wPXR2IXiRotbcYkoyxKybZ7OFDQZbLzzayKt99GeO4Hdm2uOjq/Qm3eUq
   3yWAh3d7Zuhua4RFtqxRUnIljT7fV6GUtt0oGuKbT/ujqF76Z99yAmXef
   0wh8kcJvg8P/UL3nfywX6u6vzQPFjAiS0rIDADxfqzvjwtHV4rraK5ce8
   5vCwlHCj9pL+4+MzOsrqdnMPbTfS+frXUK7dNg/VAFOur+hNQ/UYX0+/h
   yGoHYDcVUCZZ+lps7a8o1YMgzQ0XcR/SOpyC8bQakdcjiWB5bO+40BXiP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373053635"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373053635"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:12:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1100025977"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1100025977"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:12:17 -0800
Message-ID: <4068ed64-b5d8-4491-b461-4a4eaddf92f1@intel.com>
Date:   Tue, 28 Nov 2023 11:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 12/21] mmc: sdhci-uhs2: add set_power() to support
 vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
 <20231117113149.9069-13-victorshihgli@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231117113149.9069-13-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/23 13:31, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's set_power operation.
> Use sdhci_uhs2_set_power() to set VDD2 for support UHS2 interface.
> VDD2, as well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V13:
>  - Drop use vmmc2.
>  - Modify comment message.
> 
> Updates in V10:
>  - Move some definitions of PatchV9[05/23] to PatchV10[11/23].
> 
> Updates in V9:
>  - Modify annotations in sdhci_get_vdd_value().
> 
> Updates in V8:
>  - Adjust the position of matching brackets.
>  - Add the initial value of the pwr in sdhci_uhs2_set_power().
> 
> Updates in V7:
>  - Add clear the power reg before setting a new value
>    in sdhci_uhs2_set_power().
>  - Add MMC_VDD_34_35 case and MMC_VDD_35_36 case in sdhci_get_vdd_value().
>  - Drop pwr variable in sdhci_get_vdd_value().
> 
> Updates in V6:
>  - Add mmc_opt_regulator_set_ocr().
>  - Remove unnecessary functions.
> 
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 61 +++++++++++++++++++----------------
>  drivers/mmc/host/sdhci.h      |  1 +
>  3 files changed, 82 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 066549526060..7d5070f58d00 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -59,6 +59,13 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>   *                                                                           *
>  \*****************************************************************************/
>  
> +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> +					    struct regulator *supply,
> +					    unsigned short vdd_bit)
> +{
> +	return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc, supply, vdd_bit);
> +}
> +
>  bool sdhci_uhs2_mode(struct sdhci_host *host)
>  {
>  	return	host->mmc->ios.timing == MMC_TIMING_UHS2_SPEED_A ||
> @@ -94,6 +101,47 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd)
> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr = 0;
> +
> +	if (mode != MMC_POWER_OFF) {
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr)
> +			WARN(1, "%s: Invalid vdd %#x\n",
> +			     mmc_hostname(host->mmc), vdd);
> +		pwr |= SDHCI_VDD2_POWER_180;
> +	}
> +
> +	if (host->pwr == pwr)
> +		return;
> +	host->pwr = pwr;
> +
> +	if (pwr == 0) {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);

mmc_regulator_set_vqmmc2() only sets the voltage, it doesn't
disable the regulator.

> +	} else {
> +		mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		/* support 1.8v only for now */
> +		mmc_regulator_set_vqmmc2(mmc, &mmc->ios);
> +
> +		/* Clear the power reg before setting a new value */
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		/* vdd first */
> +		pwr |= SDHCI_POWER_ON;
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +	}
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 27ea5b875c29..4d50cac7717d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -23,7 +23,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/of.h>
> -
> +#include <linux/bug.h>
>  #include <linux/leds.h>
>  
>  #include <linux/mmc/mmc.h>
> @@ -2061,41 +2061,46 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +	switch (1 << vdd) {
> +	case MMC_VDD_165_195:
> +	/*
> +	 * Without a regulator, SDHCI does not support 2.0v
> +	 * so we only get here if the driver deliberately
> +	 * added the 2.0v range to ocr_avail. Map it to 1.8v
> +	 * for the purpose of turning on the power.
> +	 */
> +	case MMC_VDD_20_21:
> +		return SDHCI_POWER_180;
> +	case MMC_VDD_29_30:
> +	case MMC_VDD_30_31:
> +		return SDHCI_POWER_300;
> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:
> +	/*
> +	 * 3.4V ~ 3.6V are valid only for those platforms where it's
> +	 * known that the voltage range is supported by hardware.
> +	 */
> +	case MMC_VDD_34_35:
> +	case MMC_VDD_35_36:
> +		return SDHCI_POWER_330;
> +	default:
> +		return 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> +
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd)
>  {
>  	u8 pwr = 0;
>  
>  	if (mode != MMC_POWER_OFF) {
> -		switch (1 << vdd) {
> -		case MMC_VDD_165_195:
> -		/*
> -		 * Without a regulator, SDHCI does not support 2.0v
> -		 * so we only get here if the driver deliberately
> -		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> -		 * for the purpose of turning on the power.
> -		 */
> -		case MMC_VDD_20_21:
> -			pwr = SDHCI_POWER_180;
> -			break;
> -		case MMC_VDD_29_30:
> -		case MMC_VDD_30_31:
> -			pwr = SDHCI_POWER_300;
> -			break;
> -		case MMC_VDD_32_33:
> -		case MMC_VDD_33_34:
> -		/*
> -		 * 3.4 ~ 3.6V are valid only for those platforms where it's
> -		 * known that the voltage range is supported by hardware.
> -		 */
> -		case MMC_VDD_34_35:
> -		case MMC_VDD_35_36:
> -			pwr = SDHCI_POWER_330;
> -			break;
> -		default:
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr) {
>  			WARN(1, "%s: Invalid vdd %#x\n",
>  			     mmc_hostname(host->mmc), vdd);
> -			break;
>  		}
>  	}
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 782c399fae15..cdb418d97c4d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -837,6 +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  int sdhci_get_cd_nogpio(struct mmc_host *mmc);

