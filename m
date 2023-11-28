Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3EC7FB551
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjK1JMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjK1JMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:12:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2410CD72;
        Tue, 28 Nov 2023 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701162769; x=1732698769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Un1oCC8/yCEZbKgPQ5cvJgMpihh9zk4TGbWwvRUSGUU=;
  b=K70CKCYz6kp8wUEGy6e4Tjx95lOOScuNk63HhQHAZVQRxzHc5Xe8ebYq
   V7bXkNELqIrjDW1FuoZLalYsIbtSuKPhuvkG5+WarUCILbrvj+J3A8gV8
   l4alWX+SCkhURwAvofYphq8bTOz+l2KTQp4sYW/AexFeIlQB9tv1OT65E
   anpkeeJFQBARv/lrl3+orFz5JY8KpwVXMUjwgY0DDZFu1E7GV0VmWCIuy
   E2ow5cR/pHEovk2Udsf+dW0EeuvHwn058GLQxGzUL4CWotjEFHlaTrvK3
   pWlQXGAUnyzaFZagn5FmgDSrkoNIev/MdthYVp9Ab+qVpcDnsicHwZS46
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="373053667"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="373053667"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:12:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="1100026063"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="1100026063"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.84])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 01:12:32 -0800
Message-ID: <66166245-f906-4057-8b44-16ec5a33e6e2@intel.com>
Date:   Tue, 28 Nov 2023 11:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 14/21] mmc: sdhci-uhs2: add set_ios()
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20231117113149.9069-1-victorshihgli@gmail.com>
 <20231117113149.9069-15-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231117113149.9069-15-victorshihgli@gmail.com>
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
> This is a sdhci version of mmc's set_ios operation.
> THis is used to handle basic IO bus setting.
> It covers both UHS-I and UHS-II.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V13:
>  - Add judgment condition for power mode in the __sdhci_uhs2_set_ios().
>  - Modify comment message.
> 
> Updates in V9:
>  - Simplity the turning_on_clk in sdhci_set_ios().
> 
> Updates in V8:
>  - Add the judgment formula for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
>    and MMC_TIMING_SPEED_B_HD in __sdhci_uhs2_set_ios().
>  - Add the switch case for MMC_TIMING_SPEED_A_HD, MMC_TIMING_SPEED_B
>    and MMC_TIMING_SPEED_B_HD in sdhci_get_preset_value().
>  - mmc_opt_regulator_set_ocr() to instead of mmc_regulator_set_ocr()
>    in sdhci_uhs2_set_ios().
> 
> Updates in V7:
>  - Remove unnecessary functions.
> 
> Updates in V6:
>  - Modify return value in some functions.
>  - Remove unnecessary functions.
> 
> ---
> 
>  drivers/mmc/host/sdhci-uhs2.c | 95 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  1 +
>  drivers/mmc/host/sdhci.c      | 55 ++++++++++++--------
>  drivers/mmc/host/sdhci.h      |  2 +
>  4 files changed, 132 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 5a79dd29aa38..a55b910f3615 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -214,6 +214,101 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
>  
> +/**
> + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
> + * @host:	SDHCI host
> + * @clear:	bit-wise clear mask
> + * @set:	bit-wise set mask
> + *
> + * Set/unset bits in UHS-II Error Interrupt Status Enable register
> + */
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> +{
> +	u32 ier;
> +
> +	ier = sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	ier &= ~clear;
> +	ier |= set;
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_STATUS_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_UHS2_INT_SIGNAL_ENABLE);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
> +
> +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	u8 cmd_res, dead_lock;
> +	u16 ctrl_2;
> +
> +	/* UHS2 Timeout Control */
> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
> +
> +	/* change to use calculate value */
> +	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
> +
> +	sdhci_uhs2_clear_set_irqs(host,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT,
> +				  0);
> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
> +	sdhci_uhs2_clear_set_irqs(host, 0,
> +				  SDHCI_UHS2_INT_CMD_TIMEOUT |
> +				  SDHCI_UHS2_INT_DEADLOCK_TIMEOUT);
> +
> +	/* UHS2 timing. Note, UHS2 timing is disabled when powering off */
> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	if (ios->power_mode != MMC_POWER_OFF &&
> +	    (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_B ||
> +	     ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
> +		ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
> +	else
> +		ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +	host->timing = ios->timing;
> +
> +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
> +		sdhci_enable_preset_value(host, true);
> +
> +	if (host->ops->set_power)
> +		host->ops->set_power(host, ios->power_mode, ios->vdd);
> +	else
> +		sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
> +
> +	sdhci_set_clock(host, host->clock);
> +}
> +
> +static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +
> +	pr_debug("%s: clock %uHz powermode %u Vdd %u timing %u\n",
> +		 mmc_hostname(mmc), ios->clock, ios->power_mode, ios->vdd, ios->timing);
> +
> +	if (!sdhci_uhs2_mode(host)) {
> +		sdhci_set_ios(mmc, ios);
> +		return 0;
> +	}
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return 0;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (ios->power_mode == MMC_POWER_OFF) {
> +			mmc_opt_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +			mmc_regulator_set_vqmmc2(mmc, ios);

mmc_regulator_set_vqmmc2() only sets the voltage, it doesn't
disable the regulator.

> +		}
> +		return -1;
> +	}
> +
> +	sdhci_set_ios_common(mmc, ios);
> +
> +	__sdhci_uhs2_set_ios(mmc, ios);
> +
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index ccf4e1834c2d..a3641c5f8c77 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -181,5 +181,6 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  bool sdhci_uhs2_mode(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4d50cac7717d..64704f6537e0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -47,8 +47,6 @@
>  static unsigned int debug_quirks = 0;
>  static unsigned int debug_quirks2;
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> -
>  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
>  
>  void sdhci_dumpregs(struct sdhci_host *host)
> @@ -1877,6 +1875,12 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  	case MMC_TIMING_MMC_HS400:
>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>  		break;
> +	case MMC_TIMING_UHS2_SPEED_A:
> +	case MMC_TIMING_UHS2_SPEED_A_HD:
> +	case MMC_TIMING_UHS2_SPEED_B:
> +	case MMC_TIMING_UHS2_SPEED_B_HD:
> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
> +		break;
>  	default:
>  		pr_warn("%s: Invalid UHS-I mode selected\n",
>  			mmc_hostname(host->mmc));
> @@ -2323,24 +2327,9 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
>  	       (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
>  }
>  
> -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>  	struct sdhci_host *host = mmc_priv(mmc);
> -	bool reinit_uhs = host->reinit_uhs;
> -	bool turning_on_clk = false;
> -	u8 ctrl;
> -
> -	host->reinit_uhs = false;
> -
> -	if (ios->power_mode == MMC_POWER_UNDEFINED)
> -		return;
> -
> -	if (host->flags & SDHCI_DEVICE_DEAD) {
> -		if (!IS_ERR(mmc->supply.vmmc) &&
> -		    ios->power_mode == MMC_POWER_OFF)
> -			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> -		return;
> -	}
>  
>  	/*
>  	 * Reset the chip on each power off.
> @@ -2357,8 +2346,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		sdhci_enable_preset_value(host, false);
>  
>  	if (!ios->clock || ios->clock != host->clock) {
> -		turning_on_clk = ios->clock && !host->clock;
> -
>  		host->ops->set_clock(host, ios->clock);
>  		host->clock = ios->clock;
>  
> @@ -2374,6 +2361,31 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  			mmc->max_busy_timeout /= host->timeout_clk;
>  		}
>  	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
> +
> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	bool reinit_uhs = host->reinit_uhs;
> +	bool turning_on_clk;
> +	u8 ctrl;
> +
> +	host->reinit_uhs = false;
> +
> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
> +		return;
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD) {
> +		if (!IS_ERR(mmc->supply.vmmc) &&
> +		    ios->power_mode == MMC_POWER_OFF)
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		return;
> +	}
> +
> +	turning_on_clk = ios->clock != host->clock && ios->clock && !host->clock;
> +
> +	sdhci_set_ios_common(mmc, ios);
>  
>  	if (host->ops->set_power)
>  		host->ops->set_power(host, ios->power_mode, ios->vdd);
> @@ -2958,7 +2970,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>  
> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  {
>  	/* Host Controller v3.00 defines preset value registers */
>  	if (host->version < SDHCI_SPEC_300)
> @@ -2986,6 +2998,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  		host->preset_enabled = enable;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
>  
>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  				int err)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index cdb418d97c4d..b2e425dfac95 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -848,6 +848,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask);
>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>  int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>  				      struct mmc_ios *ios);

