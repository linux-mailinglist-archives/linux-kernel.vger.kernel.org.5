Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60FD7BE617
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377163AbjJIQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJIQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:15:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3281492;
        Mon,  9 Oct 2023 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696868147; x=1728404147;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=kSRc3U+XdQD0Wx1crW7aMZ5DUH3qauCyrQrJWbPgz2E=;
  b=YXIEWPmO+kgs5ilg2p1f/JgekwjxBMyFnqNEkwoa01BacRs5stVLR9co
   jiQZgm0LV71LujO/z0uc0MnlrqkllIhFpZHRXgUeuiYk7M9lUv5DVBoY9
   JAuXfFjeThPVuBg1WBP9W0eYzvOHed4fr+7XT1L/uJd7Bky+ZXQqxGQf/
   LdgjgDVHMJ5I5J9X7Pl9LSbSq7cMXEkk+JKSQS5qVPGRf2S4vcKROB6Vh
   FC0sMuq7c1ATwQh/OkAEtcpfl3EpQzrz3pSIhmjDvv+1cj4nX4fLutYAQ
   lna48bvSIswtmIwFPoIkaRb4ha4qsd1Ccc6AiIQiPUt2V/vtng5Tv12Ny
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364474317"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="364474317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="818896663"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="818896663"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 09:15:40 -0700
Message-ID: <2118f573-0760-4dae-ab63-ff2768c7b437@intel.com>
Date:   Mon, 9 Oct 2023 19:15:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Switch to use
 acpi_evaluate_dsm_typed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231002135103.2602847-1-andriy.shevchenko@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231002135103.2602847-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 16:51, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 7c14feb5db77..025b31aa712c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -483,11 +483,12 @@ static int __intel_dsm(struct intel_host *intel_host, struct device *dev,
>  	int err = 0;
>  	size_t len;
>  
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL);
> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(dev), &intel_dsm_guid, 0, fn, NULL,
> +				      ACPI_TYPE_BUFFER);
>  	if (!obj)
>  		return -EOPNOTSUPP;
>  
> -	if (obj->type != ACPI_TYPE_BUFFER || obj->buffer.length < 1) {
> +	if (obj->buffer.length < 1) {
>  		err = -EINVAL;
>  		goto out;
>  	}

