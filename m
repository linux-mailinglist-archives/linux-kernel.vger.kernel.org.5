Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC58F7F147D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjKTNdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjKTNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:33:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F39ED2;
        Mon, 20 Nov 2023 05:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700487229; x=1732023229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5HVMU6JZtizeU63fvBk5p0s7a2delV+ya6C0pApQPfA=;
  b=bMQKt3nG0fiajH85eNchRSUFrkDf64ixyrK5YhSwgs9CwETBZFn0fFpO
   9vo5Oc5LdwOyLAsyBdnPikmfR0FLAb2/gq8DMDzubZdISMBZtbuibSUHX
   quqrfB9Bt3sGRLBUBeLTF/LUzQu+t83wQiaNyhjbTgx4FD9bRWSzUExJe
   DHKpr2e5Ek29WUdsHD4rM1OF/TMXKhG6lDU+P21/riUY78IGv7FwCnW8i
   tctBxfeCFoprOFnC5r4V3auS9hIKd4Fxs1fI7i7L110fcQ7xlUwhahuXe
   kWYSNEhflmyZMUhd4ALOkehpzpcl9YaLcL+mztK7XhRXVBymLLthCo6kf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395545875"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="395545875"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:33:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="856989747"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="856989747"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.253])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 05:33:45 -0800
Message-ID: <eab96b0a-bcd3-4c9c-94c6-8b00889807b4@intel.com>
Date:   Mon, 20 Nov 2023 15:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: Disable LPM during initialization
Content-Language: en-US
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sven van Ashbrook <svenva@google.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
References: <20231114115516.1585361-1-korneld@chromium.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231114115516.1585361-1-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/23 13:54, Kornel Dulęba wrote:
> To address IO performance commit f9e5b33934ce
> ("mmc: host: Improve I/O read/write performance for GL9763E")
> limited LPM negotiation to runtime suspend state.
> The problem is that it only flips the switch in the runtime PM
> resume/suspend logic.
> 
> Disable LPM negotiation in gl9763e_add_host.
> This helps in two ways:
> 1. It was found that the LPM switch stays in the same position after
>    warm reboot. Having it set in init helps with consistency.
> 2. Disabling LPM during the first runtime resume leaves us susceptible
>    to the performance issue in the time window between boot and the
>    first runtime suspend.
> 
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for GL9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> v2: Move up gl9763e_set_low_power_negotiation to avoid having to forward
>     declare it.
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 54 +++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d8a991b349a8..77911a57b12c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1189,6 +1189,32 @@ static void gl9763e_hs400_enhanced_strobe(struct mmc_host *mmc,
>  	sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
>  }
>  
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot,
> +					      bool enable)
> +{
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 value;
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +	if (enable)
> +		value &= ~GLI_9763E_CFG_LPSN_DIS;
> +	else
> +		value |= GLI_9763E_CFG_LPSN_DIS;
> +
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +	value &= ~GLI_9763E_VHS_REV;
> +	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>  					unsigned int timing)
>  {
> @@ -1297,6 +1323,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
>  	if (ret)
>  		goto cleanup;
>  
> +	/* Disable LPM negotiation to avoid entering L1 state. */
> +	gl9763e_set_low_power_negotiation(slot, false);
> +
>  	return 0;
>  
>  cleanup:
> @@ -1340,31 +1369,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  }
>  
>  #ifdef CONFIG_PM
> -static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slot, bool enable)
> -{
> -	struct pci_dev *pdev = slot->chip->pdev;
> -	u32 value;
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -	value &= ~GLI_9763E_VHS_REV;
> -	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> -
> -	if (enable)
> -		value &= ~GLI_9763E_CFG_LPSN_DIS;
> -	else
> -		value |= GLI_9763E_CFG_LPSN_DIS;
> -
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> -
> -	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -	value &= ~GLI_9763E_VHS_REV;
> -	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> -	pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -}
> -
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>  	struct sdhci_pci_slot *slot = chip->slots[0];

