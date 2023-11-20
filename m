Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098707F12C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjKTMI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKTMI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:08:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D7AA;
        Mon, 20 Nov 2023 04:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700482103; x=1732018103;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7XWloCuHC7NChubW8EsZ9g7boQ8KwEoxxh9wZjIhqjo=;
  b=nKJmmCkaaQ/wb+b55Dk5xVR3rZ88+ZxOqG7TFoTuaaUM+Megkh9azzIl
   FHVjl3NY4Wi0pfvG7TA/RqcoMTBL/Ovv8BVYlNUawR3PIEWZqhlt1ASBv
   R6KPuGNs4SoNV4ewGMF8IOS/7rR6xj/M6jUm7LWlgT0Cm1QaSFa4Zc5/q
   85rbXkRj5/GJ2TesJsAlAKSW5s0YW/pIdlnyFvYwpfpxKbKcwtzAJo5ak
   b9h75tn2uzBEyHuUVkxbo7RiK+zbgeMh6jKW+C4NbLecIZ1uF1uxqAv/7
   3C2p2xOGXqfYX0SHqFcLfKXu3LOee8RLFkplUWQfQzMhLerz2VxFNl1gk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="391390384"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="391390384"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="883839342"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="883839342"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.219.253])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:08:20 -0800
Message-ID: <4bf2e094-622c-4da2-ac46-994acb580bcf@intel.com>
Date:   Mon, 20 Nov 2023 14:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci_am654: Drop lookup for deprecated
 ti,otap-del-sel
Content-Language: en-US
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20231110072535.2695134-1-vigneshr@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231110072535.2695134-1-vigneshr@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 09:25, Vignesh Raghavendra wrote:
> ti,otap-del-sel has been deprecated since v5.7 and there are no users of
> this property and no documentation in the DT bindings either.
> Drop the fallback code looking for this property, this makes
> sdhci_am654_get_otap_delay() much easier to read as all the TAP values
> can be handled via a single iterator loop.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

One minor comment below, otherwise:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Based on discussions at [1]
> https://lore.kernel.org/linux-mmc/CAPDyKFrCSTW3G6H7qS89d+UQ6RJcAYcKSPULVT8J7XKsUDpHdw@mail.gmail.com/
> 
> CC'ing DT maintainers to see if there any objection to remove
> undocumented and deprecated property.
> 
>  drivers/mmc/host/sdhci_am654.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 967bd2dfcda1..402fba0fa418 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -577,32 +577,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>  	int i;
>  	int ret;
>  
> -	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
> -				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
> -	if (ret) {
> -		/*
> -		 * ti,otap-del-sel-legacy is mandatory, look for old binding
> -		 * if not found.
> -		 */
> -		ret = device_property_read_u32(dev, "ti,otap-del-sel",
> -					       &sdhci_am654->otap_del_sel[0]);
> -		if (ret) {
> -			dev_err(dev, "Couldn't find otap-del-sel\n");
> -
> -			return ret;
> -		}
> -
> -		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
> -		sdhci_am654->legacy_otapdly = true;

With this removal, legacy_otapdly is not used anymore and should be
removed also.

> -
> -		return 0;
> -	}
> -
>  	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>  
>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>  					       &sdhci_am654->otap_del_sel[i]);
>  		if (ret) {
> +			if (i == MMC_TIMING_LEGACY) {
> +				dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
> +				return ret;
> +			}
>  			dev_dbg(dev, "Couldn't find %s\n",
>  				td[i].otap_binding);
>  			/*

