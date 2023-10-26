Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA297D7D45
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbjJZHEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJZHD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:03:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE018F;
        Thu, 26 Oct 2023 00:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698303836; x=1729839836;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YxU303+m39Yv4GTRJupSV8Bxd9dtq3XFXeF+ddxruSk=;
  b=N1kpmNVlc1sUTyRFRV2dNuNXYIzjd21MLpgrSo/Wpuyjm7Oxf2Tei015
   nHWYp5hX1oGPETS01f7svT3V7qQi4eq2/YK4PHCnpzdlsoyT2hiZ/McN3
   an5SuZZTpW6Pa/fL79oS45N0P8XE6FFgvl0wTyFCDvlQw+XIPqLh2O6P4
   vQhLrNu9pEFPk3cUSExQNdTQW/AYlnV5rgpCknB9R+HM1L5NLMidkfRWc
   vcG4I/zc8qUzrATNuvvPcHbbqNEdH10i5y83LH1FJ8nfNB7wW9otCwK2B
   NGQfj9B9ZXRAsVfQxReexAPB4++tInMW2bv60Qr6BhoAyA3aDnxsuEjGX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391345794"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391345794"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:03:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="762722336"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="762722336"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.218])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 00:03:53 -0700
Message-ID: <8148dae9-e3fc-4589-ba57-a3f7a3e63b80@intel.com>
Date:   Thu, 26 Oct 2023 10:03:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci_am654: fix start loop index for TAP value
 parsing
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Nitin Yadav <n-yadav@ti.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231026061458.1116276-1-n-yadav@ti.com>
 <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <8b7f948d-316c-4135-875a-de455ff4849c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/23 10:00, Adrian Hunter wrote:
> On 26/10/23 09:14, Nitin Yadav wrote:
>> ti,otap-del-sel-legacy/ti,itap-del-sel-legacy passed from DT
>> are currently ignored for all SD/MMC and eMMC modes. Fix this
>> by making start loop index to MMC_TIMING_LEGACY.
>>
>> Fixes: 8ee5fc0e0b3be ("mmc: sdhci_am654: Update OTAPDLY writes")
>>
> 
> There isn't usually a blank line here
> 
> Perhaps a Cc: stable@vger.kernel.org tag?
> 
>> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> 
> Nevertheless:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Sorry, sent that prematurely - see comment below

> 
> 
>> ---
>>  drivers/mmc/host/sdhci_am654.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index 544aaaf5cb0f..aae9d255c6a1 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -606,7 +606,7 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
>>  		return 0;
>>  	}
>>  

Isn't the MMC_TIMING_LEGACY information read at the top of
sdhci_am654_get_otap_delay()?

>> -	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
>> +	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
>>  
>>  		ret = device_property_read_u32(dev, td[i].otap_binding,
>>  					       &sdhci_am654->otap_del_sel[i]);
> 

