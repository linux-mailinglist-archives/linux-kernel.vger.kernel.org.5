Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1424A805F38
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjLEUOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:14:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50948C0;
        Tue,  5 Dec 2023 12:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701807282; x=1733343282;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GnGrvzu1UAF60Na557V8KUh1lDWJwr/3iOhwXpIVSuE=;
  b=hKCRG6TiQ9XtUy/tRslOSMZ1gnMitRKcD4BhSvcswJdCKKy1EEDKEFI0
   mjrj9QSQfzeb6LgVoEUrlu0+IHJJHoPZbd/3vVwRHWuYd4QEbqCyc1Q+D
   ta2pTDW9WEpHNw/lYKuvRQrD+JdH+mocwLu84NqrqetTmMZ4D/gxbttA8
   4b3SuutEKOWlPv78/A1hJI6SBGuQ8augj1aLjZwFQdfdqEeDFBu0vR5NF
   3yrGXwJ83oSHGmm9mL4+SP+KdhbG1Q7gk76ZtgB2yAO3MpU9TcqdTJD9B
   MJ99FqhiWVMCXbNhXkAv7NzbTk1oKICs6F8btEdKaLXL02ywPS6s2NhFx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="460444233"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="460444233"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 12:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018326903"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="1018326903"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.77])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 12:14:37 -0800
Message-ID: <acd40f9b-a43a-4b74-bb78-3576a15d4d9b@intel.com>
Date:   Tue, 5 Dec 2023 22:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>, Avri.Altman@wdc.com,
        ulf.hansson@linaro.org, christian.loehle@arm.com
Cc:     jinpu.wang@ionos.com, axboe@kernel.dk, beanhuo@micron.com,
        yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw,
        asuk4.q@gmail.com, hkallweit1@gmail.com, yangyingliang@huawei.com,
        yebin10@huawei.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
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

On 5/12/23 22:12, Adrian Hunter wrote:
> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>> Requesting a retune before switching to the RPMB partition has been
>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
> 
> There are still 2 concerns:
> 1) We don't really know the root cause.  Have you determined
> if here are CRC errors in the main partition also?
> 2) Forcing this on everyone
> 
> The original idea was that because re-tuning cannot be
> done in RPMB, the need to re-rune in RPMB could be avoided
> by always re-tuning before switching to RPMB and then switching
> straight back. IIRC re-tuning should guarantee at least 4MB
> more I/O without issue.
> 
> The alternative to dropping re-tuning in this case could
> be to add a retry loop for MMC_DRV_OP_IOCTL_RPMB if the error
> is -EILSEQ

Actually, you could still do this patch as well because
a CRC error would cause re-tuning before the next retry.

> 
> 
>>
>> Since RPMB reads can not be retried, the clients would be directly
>> affected by the errors.
>>
>> This commit disables the request prior to RPMB switching while allowing
>> the pause interface to still request a retune before the pause for other
>> use cases.
>>
>> This was verified with the sdhci-of-arasan driver (ZynqMP) configured
>> for HS200 using two separate eMMC cards (DG4064 and 064GB2). In both
>> cases, the error was easy to reproduce triggering every few tenths of
>> reads.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
>> ---
>>  drivers/mmc/core/block.c | 2 +-
>>  drivers/mmc/core/host.c  | 7 ++++---
>>  drivers/mmc/core/host.h  | 2 +-
>>  3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index f9a5cffa64b1..1d69078ad9b2 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -859,7 +859,7 @@ static int mmc_blk_part_switch_pre(struct mmc_card *card,
>>  			if (ret)
>>  				return ret;
>>  		}
>> -		mmc_retune_pause(card->host);
>> +		mmc_retune_pause(card->host, false);
>>  	}
>>  
>>  	return ret;
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 096093f7be00..a9b95aaa2235 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -119,13 +119,14 @@ void mmc_retune_enable(struct mmc_host *host)
>>  
>>  /*
>>   * Pause re-tuning for a small set of operations.  The pause begins after the
>> - * next command and after first doing re-tuning.
>> + * next command and, if retune is set, after first doing re-tuning.
>>   */
>> -void mmc_retune_pause(struct mmc_host *host)
>> +void mmc_retune_pause(struct mmc_host *host, bool retune)
>>  {
>>  	if (!host->retune_paused) {
>>  		host->retune_paused = 1;
>> -		mmc_retune_needed(host);
>> +		if (retune)
>> +			mmc_retune_needed(host);
> 
> Better to just drop mmc_retune_needed(host);
> 
>>  		mmc_retune_hold(host);
> 
> There is still a small chance that re-tuning
> is needed anyway in which case it will still be done.
> 
>>  	}
>>  }
>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
>> index 48c4952512a5..321776b52270 100644
>> --- a/drivers/mmc/core/host.h
>> +++ b/drivers/mmc/core/host.h
>> @@ -18,7 +18,7 @@ void mmc_retune_disable(struct mmc_host *host);
>>  void mmc_retune_hold(struct mmc_host *host);
>>  void mmc_retune_release(struct mmc_host *host);
>>  int mmc_retune(struct mmc_host *host);
>> -void mmc_retune_pause(struct mmc_host *host);
>> +void mmc_retune_pause(struct mmc_host *host, bool retune);
>>  void mmc_retune_unpause(struct mmc_host *host);
>>  
>>  static inline void mmc_retune_clear(struct mmc_host *host)
> 

