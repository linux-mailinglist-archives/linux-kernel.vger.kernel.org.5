Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4B7B6816
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbjJCLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJCLhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:37:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AEC8E;
        Tue,  3 Oct 2023 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696333050; x=1727869050;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C32ByUo447YYv+RlPWVC6MinO3qaNAkiZax9oAqDLHg=;
  b=Rx2ObdGErZQg+C/yarFH08mmd+74aaPDSx7eLzC7SAv9MX4XGt/eMZSv
   HGgK5TdAiwuJTsUphRnkER63yY7PzuYKNd7nyffwv8y5yY+VW4+9S5XrC
   UmqVT86cIdDd07jute3yvHoEQIDOOAlZTGvtJs/kCga3SrhSsc8V9pmlq
   gxrcgHr5APmdQugHVRETwwXL/nUdhiOP377YXkZ7OUT7WV8HJG9CoZwTH
   o/yDbS499kPLAt4HL+c8VXmTPhOhT2GcxRP5jW3mbtTQLa/F1aAvQ0MPB
   3Hh4oB+nQIXCauQpDZpv+KjzgmQfdjEziYmEI1e/i48H+V41kU+0Gklvy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="413765305"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="413765305"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="997984639"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="997984639"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 04:37:27 -0700
Message-ID: <afa2aeed-7296-4075-a7e0-62f3d59bfdf4@intel.com>
Date:   Tue, 3 Oct 2023 14:37:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 10/23] mmc: sdhci-uhs2: add reset function and
 uhs2_mode function
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Victor Shih <victorshihgli@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
 <20230915094351.11120-11-victorshihgli@gmail.com>
 <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAPDyKFrynugse6+vwummTQ73egwvGAfKreH=iihv9bhFN1SJYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 13:30, Ulf Hansson wrote:
> On Fri, 15 Sept 2023 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>>
>> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>>
>> Sdhci_uhs2_reset() does a UHS-II specific reset operation.
>>
>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>
>> Updates in V8:
>>  - Adjust the position of matching brackets.
>>
>> Updates in V6:
>>  - Remove unnecessary functions and simplify code.
>>
>> ---
>>
>>  drivers/mmc/host/sdhci-uhs2.c | 45 +++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/sdhci-uhs2.h |  2 ++
>>  2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>> index e339821d3504..dfc80a7f1bad 100644
>> --- a/drivers/mmc/host/sdhci-uhs2.c
>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>> @@ -10,7 +10,9 @@
>>   *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>   */
>>
>> +#include <linux/delay.h>
>>  #include <linux/module.h>
>> +#include <linux/iopoll.h>
>>
>>  #include "sdhci.h"
>>  #include "sdhci-uhs2.h"
>> @@ -49,6 +51,49 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>>
>> +/*****************************************************************************\
>> + *                                                                           *
>> + * Low level functions                                                       *
>> + *                                                                           *
>> +\*****************************************************************************/
>> +
>> +bool sdhci_uhs2_mode(struct sdhci_host *host)
>> +{
>> +       return host->mmc->flags & MMC_UHS2_SUPPORT;
> 
> The MMC_UHS2_SUPPORT bit looks redundant to me. Instead, I think we
> should be using mmc->ios.timings, which already indicates whether we
> are using UHS2 (MMC_TIMING_UHS2_SPEED_*). See patch2 where we added
> this.
> 
> That said, I think we should drop the sdhci_uhs2_mode() function
> altogether and instead use mmc_card_uhs2(), which means we should move
> it to include/linux/mmc/host.h, so it becomes available for host
> drivers.
> 

UHS2 mode starts at UHS2 initialization and ends either when UHS2
initialization fails, or the card is removed.

So it includes re-initialization and reset when the transfer mode
currently transitions through MMC_TIMING_LEGACY.

So mmc_card_uhs2() won't work correctly for the host callbacks
unless something is done about that.

