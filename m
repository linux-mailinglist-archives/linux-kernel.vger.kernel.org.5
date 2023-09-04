Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4AD791259
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbjIDHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjIDHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:38:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2D0D3;
        Mon,  4 Sep 2023 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693813099; x=1725349099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pxioTKTutxNDiFXKYNZhBSCDvsQd+k7UsSb2LQ2IIYQ=;
  b=aBSTQMA1ryB4qvdJ+Y9beVOC/6z3e/NxkJP/DSGg4IVpAopVh4MzVXyV
   C/Fnc7+sVqYLaPJtI/1GHdvwJWurY2X02sqtuy4Fuhcpr+HNcDw1cgQVZ
   ePBSS7SWILku83S9cGN5eSh/CaolPk3rYF5h9IJ2OsQ6Uq92rW2/6kBN7
   cUBYMY5IcsWOKwBV3Srg5TCB6qDWQi824NtRDq8p7Q/T7LHhEtjn1JJSm
   tbm4JALm9L2DPYXhvEwaXEMDFDtiLxPxcz2+/mQOQJUWh0+pcCMZ7m/FZ
   HQShhOGN1PX0YI0UM00eailh7xHeTelOETEN6h3Tt6fmAxNVZYuzH0NGg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="361563097"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="361563097"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="775748018"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="775748018"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:38:14 -0700
Message-ID: <096e9122-23b8-5a36-7779-28994187c620@intel.com>
Date:   Mon, 4 Sep 2023 10:38:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH] mmc: Fix force card detect in sdhci
Content-Language: en-US
To:     mathieu <mathieu.moneyron@gmail.com>,
        ludovic.desroches@microchip.com, ulf.hansson@linaro.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Eugen Hristev

On 30/08/23 12:23, mathieu wrote:
> From: Mathieu Moneyron <mathieu.moneyron@gmail.com>
> 
> On the ATMEL at91 when using the non-removable flag in device tree and not
> using the card-detect pin inside the device-tree pinctrl, the card detect
> pin is physically still used which can cause unknown behaviour when this
> pin is used for other purposes.
> 
> From my interpretation this seems to be caused by a hardware design flaw
> and the real hardware is not working as intended by the documentation.
> 
> Signed-off-by: Mathieu Moneyron <mathieu.moneyron@gmail.com>
> ---
>  drivers/mmc/host/sdhci-of-at91.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 69fef88e7..4fd6bfbf6 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -51,10 +51,15 @@ struct sdhci_at91_priv {
>  static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
>  {
>  	u8 mc1r;
> +	u8 ctrl;
>  
>  	mc1r = readb(host->ioaddr + SDMMC_MC1R);
>  	mc1r |= SDMMC_MC1R_FCD;
>  	writeb(mc1r, host->ioaddr + SDMMC_MC1R);
> +
> +	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
> +	ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
> +	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>  }
>  
>  static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)

