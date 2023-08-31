Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181578E7F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbjHaI1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242431AbjHaI1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:27:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0139CE4;
        Thu, 31 Aug 2023 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693470420; x=1725006420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k7uX3zhTntvTb9eTANpkB2CvVy81lTZFLgI6nkSLnvI=;
  b=btiNiwL4embbQmBFGeb/1i3AJnkWCTUoctTLZrNHBDZFM6hGGyVAZz6P
   hWvBB9L19QsEj0CuUurLpKal4CAuC3kZC493xtUIcTuQ1F5wgeTyAcohj
   ZxlmOre/VEbDL28DuA/D+8+rRY8ppGepK587HppJDgIxH5XcpgXzQW6Xz
   h60KeAbilNTP5Ww9mdPyC7C4n2CectDXuGsd0pU6Rha3QZYPJsF7RfndT
   GB2NrTmPV6pFQwuS90hEz2YNWMMo+FlouCs2VOkXSqBwSW3mt/aGNZq7I
   bUcu1I/suGD5rdXyWalplRjrODjUVTjaMYtZ6YbZ4hzsQVFcLS9JkYR7C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="406854038"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="406854038"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="804875056"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="804875056"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:26:56 -0700
Message-ID: <8cf236b8-d214-0bb5-f986-3083f84d8f21@intel.com>
Date:   Thu, 31 Aug 2023 11:26:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH V10 11/23] mmc: sdhci-uhs2: add set_power() to support
 vdd2
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
 <20230818100217.12725-12-victorshihgli@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230818100217.12725-12-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/23 13:02, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> This is a UHS-II version of sdhci's set_power operation. VDD2, as
> well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Updates in V10: - Move some definitions of PatchV9[05/23] to
> PatchV10[11/23].
> 
> Updates in V9: - Modify annotations in sdhci_get_vdd_value().
> 
> Updates in V8: - Adjust the position of matching brackets. - Add the
> initial value of the pwr in sdhci_uhs2_set_power().
> 
> Updates in V7: - Add clear the power reg before setting a new value 
> in sdhci_uhs2_set_power(). - Add MMC_VDD_34_35 case and MMC_VDD_35_36
> case in sdhci_get_vdd_value(). - Drop pwr variable in
> sdhci_get_vdd_value().
> 
> Updates in V6: - Add mmc_opt_regulator_set_ocr(). - Remove
> unnecessary functions.
> 
> ---
> 
> drivers/mmc/host/sdhci-uhs2.c | 48 +++++++++++++++++++++++++++ 
> drivers/mmc/host/sdhci.c      | 61
> +++++++++++++++++++---------------- drivers/mmc/host/sdhci.h      |
> 1 + include/linux/mmc/host.h      |  1 + 4 files changed, 83
> insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c
> b/drivers/mmc/host/sdhci-uhs2.c index dfc80a7f1bad..fc37a34629c2
> 100644 --- a/drivers/mmc/host/sdhci-uhs2.c +++
> b/drivers/mmc/host/sdhci-uhs2.c @@ -57,6 +57,13 @@
> EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs); *
> * 
> \*****************************************************************************/
>
>  +static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc, +
> struct regulator *supply, +					    unsigned short vdd_bit) +{ +
> return IS_ERR_OR_NULL(supply) ? 0 : mmc_regulator_set_ocr(mmc,
> supply, vdd_bit); +} + bool sdhci_uhs2_mode(struct sdhci_host *host) 
> { return host->mmc->flags & MMC_UHS2_SUPPORT; @@ -94,6 +101,47 @@
> void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask) } 
> EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
> 
> +static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned
> char mode, unsigned short vdd) +{ +	struct mmc_host *mmc =
> host->mmc; +	u8 pwr = 0; + +	if (mode != MMC_POWER_OFF) { +		pwr =
> sdhci_get_vdd_value(vdd); +		if (!pwr) +			WARN(1, "%s: Invalid vdd
> %#x\n", +			     mmc_hostname(host->mmc), vdd); +		pwr |=
> SDHCI_VDD2_POWER_180; +	} + +	if (host->pwr == pwr) +		return; +
> host->pwr = pwr; + +	if (pwr == 0) { +		sdhci_writeb(host, 0,
> SDHCI_POWER_CONTROL); + +		mmc_opt_regulator_set_ocr(mmc,
> mmc->supply.vmmc, 0); +		mmc_opt_regulator_set_ocr(mmc,
> mmc->supply.vmmc2, 0); +	} else { +		mmc_opt_regulator_set_ocr(mmc,
> mmc->supply.vmmc, vdd); +		/* support 1.8v only for now */ +
> mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc2,
> fls(MMC_VDD_165_195) - 1); + +		/* Clear the power reg before setting
> a new value */ +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL); + +		/*
> vdd first */ +		pwr |= SDHCI_POWER_ON; +		sdhci_writeb(host, pwr &
> 0xf, SDHCI_POWER_CONTROL); +		mdelay(5); + +		pwr |=
> SDHCI_VDD2_POWER_ON; +		sdhci_writeb(host, pwr,
> SDHCI_POWER_CONTROL); +		mdelay(5); +	} +} + 
> /*****************************************************************************\
>
> 
*                                                                           *
> * Driver init/exit
> * diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c 
> index 753b251179f2..eca54a16e7fc 100644 ---
> a/drivers/mmc/host/sdhci.c +++ b/drivers/mmc/host/sdhci.c @@ -23,7
> +23,7 @@ #include <linux/regulator/consumer.h> #include
> <linux/pm_runtime.h> #include <linux/of.h> - +#include <linux/bug.h> 
> #include <linux/leds.h>
> 
> #include <linux/mmc/mmc.h> @@ -2061,41 +2061,46 @@ static void
> sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode, 
> sdhci_writeb(host, 0, SDHCI_POWER_CONTROL); }
> 
> +unsigned short sdhci_get_vdd_value(unsigned short vdd) +{ +	switch
> (1 << vdd) { +	case MMC_VDD_165_195: +	/* +	 * Without a regulator,
> SDHCI does not support 2.0v +	 * so we only get here if the driver
> deliberately +	 * added the 2.0v range to ocr_avail. Map it to 1.8v +
> * for the purpose of turning on the power. +	 */ +	case
> MMC_VDD_20_21: +		return SDHCI_POWER_180; +	case MMC_VDD_29_30: +
> case MMC_VDD_30_31: +		return SDHCI_POWER_300; +	case MMC_VDD_32_33: 
> +	case MMC_VDD_33_34: +	/* +	 * 3.4V ~ 3.6V are valid only for those
> platforms where it's +	 * known that the voltage range is supported
> by hardware. +	 */ +	case MMC_VDD_34_35: +	case MMC_VDD_35_36: +
> return SDHCI_POWER_330; +	default: +		return 0; +	} +} 
> +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value); + void
> sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode, 
> unsigned short vdd) { u8 pwr = 0;
> 
> if (mode != MMC_POWER_OFF) { -		switch (1 << vdd) { -		case
> MMC_VDD_165_195: -		/* -		 * Without a regulator, SDHCI does not
> support 2.0v -		 * so we only get here if the driver deliberately -
> * added the 2.0v range to ocr_avail. Map it to 1.8v -		 * for the
> purpose of turning on the power. -		 */ -		case MMC_VDD_20_21: -
> pwr = SDHCI_POWER_180; -			break; -		case MMC_VDD_29_30: -		case
> MMC_VDD_30_31: -			pwr = SDHCI_POWER_300; -			break; -		case
> MMC_VDD_32_33: -		case MMC_VDD_33_34: -		/* -		 * 3.4 ~ 3.6V are
> valid only for those platforms where it's -		 * known that the
> voltage range is supported by hardware. -		 */ -		case
> MMC_VDD_34_35: -		case MMC_VDD_35_36: -			pwr = SDHCI_POWER_330; -
> break; -		default: +		pwr = sdhci_get_vdd_value(vdd); +		if (!pwr) { 
> WARN(1, "%s: Invalid vdd %#x\n", mmc_hostname(host->mmc), vdd); -
> break; } }
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h 
> index 43ad3f4b7672..f3bd558b337f 100644 ---
> a/drivers/mmc/host/sdhci.h +++ b/drivers/mmc/host/sdhci.h @@ -837,6
> +837,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char
> mode, void sdhci_set_power_and_bus_voltage(struct sdhci_host *host, 
> unsigned char mode, unsigned short vdd); +unsigned short
> sdhci_get_vdd_value(unsigned short vdd); void
> sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode, 
> unsigned short vdd); int sdhci_get_cd_nogpio(struct mmc_host *mmc); 
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h 
> index e38c45392079..1eba64228725 100644 ---
> a/include/linux/mmc/host.h +++ b/include/linux/mmc/host.h @@ -357,6
> +357,7 @@ struct mmc_pwrseq;
> 
> struct mmc_supply { struct regulator *vmmc;		/* Card power supply */ 
> +	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */ struct
> regulator *vqmmc;	/* Optional Vccq supply */ struct regulator
> *vqmmc2;	/* Optional supply for phy */ };

