Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68D37BF8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJJK3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjJJK3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:29:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBD9D;
        Tue, 10 Oct 2023 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696933755; x=1728469755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O4aDq82eXBCAHz+6n1RPtBENZjjOhVyVVALQ2vKheRU=;
  b=Ym6pKpkw0nlesaHxZTJxgMu+YXZI7tUAD8i2cLZeEuTU9Zn2+JLNYee9
   gCFlpI7B7sSZT5bkJ6GJhtx/UBcAo17R5Gtv+HBs7w16t1ZuaVxc7u/Y0
   Tfac+XxurRns5D4PdUasuVUBbhCNqHi10Cs/Qy15gpbxQ0vg6e+2Ot1gV
   69qmPpZ6LKUvGni2k9TloZqZAkXgZBhMqAX5Ag9wSqtfxdnRKFWJ3mMdw
   p64OYsiyQNXkGzgWiLWQjE0lzhcZHj/7xhCtsMSUIgXlrbA6FH8YdXLOe
   cz8VgnIbvnG98fqPFdKr6c/ILF+X2+NWEzstU75NQirBk7xTiqP1H6wyg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="374701701"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="374701701"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:29:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="747030135"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747030135"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.106])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:29:10 -0700
Message-ID: <d76a9fff-5536-4e3e-b1c3-234de427d031@intel.com>
Date:   Tue, 10 Oct 2023 13:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Victor Shih <victorshihgli@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com>
 <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
 <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com>
 <CAPDyKFqidGZ242P-9xnxokSCeGxk8uziqR=AteWt=iQFz5fA9g@mail.gmail.com>
 <81bf38cd-b6a4-4a6f-a51d-bc916e3b8f96@intel.com>
 <CAPDyKFoc0phsXuX5W0PqFu2En57Lc9D-+MTGxAYtJhPpHcVZ2g@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFoc0phsXuX5W0PqFu2En57Lc9D-+MTGxAYtJhPpHcVZ2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 11:35, Ulf Hansson wrote:
> On Tue, 3 Oct 2023 at 17:03, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 3/10/23 15:22, Ulf Hansson wrote:
>>> On Tue, 3 Oct 2023 at 13:37, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> On 3/10/23 13:30, Ulf Hansson wrote:
>>>>> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>>>>>>
>>>>>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>>>
>>>>>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
>>>>>>
>>>>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>>>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>>>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>>>> ---
>>>>>>
>>>>>> Updates in V8:
>>>>>>  - Adjust the position of matching brackets.
>>>>>>
>>>>>> Updates in V6:
>>>>>>  - Remove unnecessary functions and simplify code.
>>>>>>
>>>>>> ---
>>>>>>
>>>>>>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
>>>>>>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
>>>>>>  2 files changed, 47 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>>>>> index e339821d3504..dfc80a7f1bad 100644
>>>>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>>>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>>>>> @@ -10,7 +10,9 @@
>>>>>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>>>>>   */
>>>>>>
>>>>>> +#include <linux/delay.h>
>>>>>>  #include <linux/module.h>
>>>>>> +#include <linux/iopoll.h>
>>>>>>
>>>>>>  #include "sdhci.h"
>>>>>>  #include "sdhci-uhs2.h"
>>>>>> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>>>>>
>>>>>> +/*****************************************************************************\
>>>>>> + *                                                                           *
>>>>>> + * Low level functions                                                       *
>>>>>> + *                                                                           *
>>>>>> +\*****************************************************************************/
>>>>>> +
>>>>>> +bool sdhci_uhs2_mode(struct sdhci_host *host)
>>>>>> +{
>>>>>> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
>>>>>
>>>>> The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
>>>>> should be using mmc->ios.timings, which already indicates whether we
>>>>> are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
>>>>> this.
>>>>>
>>>>> That said, I think we should drop the sdhci_uhs2_mode() function
>>>>> altogether and instead use mmc_card_uhs2(), which means we should move
>>>>> it to include/linux/mmc/host.h, so it becomes available for host
>>>>> drivers.
>>>>>
>>>>
>>>> UHS2 mode starts at UHS2 initialization and ends either when UHS2
>>>> initialization fails, or the card is removed.
>>>>
>>>> So it includes re-initialization and reset when the transfer mode
>>>> currently transitions through MMC_TIMING_LEGACY.
>>>>
>>>> So mmc_card_uhs2() won't work correctly for the host callbacks
>>>> unless something is done about that.
>>>
>>> Right, thanks for clarifying!
>>>
>>> In that case I wonder if we couldn't change the way we update the
>>> ->ios.timing for UHS2. It seems silly to have two (similar) ways to
>>> indicate that we have moved to UHS2.
>>
>> Perhaps something like below:
>>
>> diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
>> index aacefdd6bc9e..e39d63d46041 100644
>> --- a/drivers/mmc/core/sd_uhs2.c
>> +++ b/drivers/mmc/core/sd_uhs2.c
>> @@ -70,7 +70,8 @@ static int sd_uhs2_power_off(struct mmc_host *host)
>>
>>         host->ios.vdd = 0;
>>         host->ios.clock = 0;
>> -       host->ios.timing = MMC_TIMING_LEGACY;
>> +       /* Must set UHS2 timing to identify UHS2 mode */
>> +       host->ios.timing = MMC_TIMING_UHS2_SPEED_A;
>>         host->ios.power_mode = MMC_POWER_OFF;
>>         if (host->flags & MMC_UHS2_SD_TRAN)
>>                 host->flags &= ~MMC_UHS2_SD_TRAN;
>> @@ -1095,7 +1096,8 @@ static void sd_uhs2_detect(struct mmc_host *host)
>>                 mmc_claim_host(host);
>>                 mmc_detach_bus(host);
>>                 sd_uhs2_power_off(host);
>> -               host->flags &= ~MMC_UHS2_SUPPORT;
>> +               /* Remove UHS2 timing to indicate the end of UHS2 mode */
>> +               host->ios.timing = MMC_TIMING_LEGACY;
>>                 mmc_release_host(host);
>>         }
>>  }
>> @@ -1338,7 +1340,8 @@ static int sd_uhs2_attach(struct mmc_host *host)
>>  err:
>>         mmc_detach_bus(host);
>>         sd_uhs2_power_off(host);
>> -       host->flags &= ~MMC_UHS2_SUPPORT;
>> +       /* Remove UHS2 timing to indicate the end of UHS2 mode */
>> +       host->ios.timing = MMC_TIMING_LEGACY;
>>         return err;
>>  }
> 
> I wouldn't mind changing to the above. But, maybe an even better
> option is to use the ->timing variable in the struct sdhci_host, as
> it's there already to keep track of the current/previous timing state.
> Would that work too?

The host does not really have enough information.

> 
>>
>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>> index 517c497112f4..d1f3318b7d3a 100644
>> --- a/drivers/mmc/host/sdhci-uhs2.c
>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>> @@ -267,10 +267,11 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>         /* UHS2 timing. Note, UHS2 timing is disabled when powering off */
>>         ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>> -       if (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
>> -           ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
>> -           ios->timing == MMC_TIMING_UHS2_SPEED_B ||
>> -           ios->timing == MMC_TIMING_UHS2_SPEED_B_HD)
>> +       if (ios->power_mode != MMC_POWER_OFF &&
>> +           (ios->timing == MMC_TIMING_UHS2_SPEED_A ||
>> +            ios->timing == MMC_TIMING_UHS2_SPEED_A_HD ||
>> +            ios->timing == MMC_TIMING_UHS2_SPEED_B ||
>> +            ios->timing == MMC_TIMING_UHS2_SPEED_B_HD))
>>                 ctrl_2 |= SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE;
>>         else
>>                 ctrl_2 &= ~(SDHCI_CTRL_UHS2 | SDHCI_CTRL_UHS2_ENABLE);
>>
>>
> 
> Kind regards
> Uffe

