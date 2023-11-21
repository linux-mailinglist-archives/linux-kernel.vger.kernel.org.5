Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6B37F26FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKUIJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKUIJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:09:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D210F;
        Tue, 21 Nov 2023 00:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700554167; x=1732090167;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGsju0ngCw+aQSwQpD5Iav/LAYk+iS8Jk1rUYC5r/Ew=;
  b=Tnnt7KuKmkAG/P0Qwro/K0PnENU6o1X/iGtfNDx6W2fQL2NiIKpnU3Gl
   ZwrdDcIj1xwiOycEFzhnUQZlt/X0phwfSUYzaJJAJbsU3LgqzhR0kkXhr
   GpY+mgTeSP7hvC1pOZzFVabllf9SINNI/ug2cRNtSIJQGpAHZRGAXtWuK
   AX+OKURRYTku7gR3t1J2e9Ffwv/Kyl6uff/Twni9PUa6vkRVvMN6RBPSR
   0iGHVA+VRX9yeURkNqR/PCqf/3KHK4KlhIo6Oz8RbkHDuqwLeSqpNdFV0
   6p3F4NL556MHQNMNnUs4zW7jhtDMY/jwLjILzDDc/f2+k/S96pDFtZ9l9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390644773"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="390644773"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8004754"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.230])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 00:08:55 -0800
Message-ID: <02251b86-d0ae-4e4a-af3c-b508a92e517f@intel.com>
Date:   Tue, 21 Nov 2023 10:08:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Content-Language: en-US
To:     Liming Sun <limings@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
 <47367cdc-f512-4f0d-958f-2d8fbe450cbf@intel.com>
 <BN9PR12MB50688354602B03E9E637C02FD3B4A@BN9PR12MB5068.namprd12.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <BN9PR12MB50688354602B03E9E637C02FD3B4A@BN9PR12MB5068.namprd12.prod.outlook.com>
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

On 20/11/23 17:18, Liming Sun wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Monday, November 20, 2023 1:49 AM
>> To: Liming Sun <limings@nvidia.com>; Ulf Hansson <ulf.hansson@linaro.org>;
>> David Thompson <davthompson@nvidia.com>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
>> BlueField-3 SoC
>>
>> On 18/11/23 15:46, Liming Sun wrote:
>>> This commit enables SDHCI_QUIRK_BROKEN_TIMEOUT_VAL to solve the
>>> intermittent eMMC timeout issue reported on some cards under eMMC
>>> stress test.
>>>
>>> Reported error message:
>>>   dwcmshc MLNXBF30:00: __mmc_blk_ioctl_cmd: data error -110
>>
>> Were you able to determine the root cause?  For example,
>> is the host controller timeout correct, is the eMMC
>> providing correct timeout values, is the mmc subsystem
>> calculating a correct value, is sdhci programming a correct
>> value?
>>
>> If there are problems outside the host controller then we
>> need to address them also.
> 
> It is caused by the host controller timeout, but is hard to tell whether the
> configuration provided by the card is good enough since it's
> intermittent under stress test the SoC needs to work with different eMMC vendors. 
> In UEFI eMMC driver similar max timeout (0xe) is used to avoid such
> issue. This commit tries to use existing quirk, which I think that it would work 
> if there is another way to adjust the TOUT_CNT register. Any concern or suggestions?

If cards are providing timeout values that are too low under stress,
it would be better to fix it in the mmc subsystem so that all host
controllers can benefit.

> 
>>
>>>
>>> Signed-off-by: Liming Sun <limings@nvidia.com>
>>
>> Fixes tag?
> 
> Will update it in v2.
> 
>>
>>> ---
>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 3a3bae6948a8..3c8fe8aec558 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -365,7 +365,8 @@ static const struct sdhci_pltfm_data
>> sdhci_dwcmshc_pdata = {
>>>  #ifdef CONFIG_ACPI
>>>  static const struct sdhci_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>>>  	.ops = &sdhci_dwcmshc_ops,
>>> -	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>> +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
>>> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
>>>  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>  		   SDHCI_QUIRK2_ACMD23_BROKEN,
>>>  };
> 

