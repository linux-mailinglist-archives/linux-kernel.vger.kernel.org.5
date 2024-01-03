Return-Path: <linux-kernel+bounces-15261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB06822952
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB68284E71
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0788182A8;
	Wed,  3 Jan 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBtKdz5K"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8E182A1;
	Wed,  3 Jan 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704269313; x=1735805313;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=N4mky9XPGDKkAGuaSOz5k3exB0vcewlbn6kHOC5dB5I=;
  b=HBtKdz5K7TzekCwv0YEvWU61swX6p9GZKBKuyN0PCrlZUeY5PmxZSjX0
   lBoIUqMiaR2A7mXphQgALeF6pCRbLktg+Mg5xNDQma/InIW/2MuthZSn4
   /rJx1mFzBTGFhJ2WMMAeAFrgGKKSpdG1G83NpYhF7o+lh9Lndt7gRUSXp
   ywb9Y4uPjuQpkZsVD1+aye+SeCW+QbBpvy+c2pVCJ+UP2pteZaAHSOay/
   Q9s8cy9pfzdDxSprVK/KUn05+yNlgqmy+hrX9JMaZBHI1x+Y9TbH9O8sU
   GVNyYdKDMs7D5ozyLLcdLdxtZkDXWCdnvxtR/LYoZXqE7vqffHVpITp65
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4321800"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="4321800"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="953155543"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="953155543"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:08:26 -0800
Message-ID: <4f320a33-b305-4cfb-9601-6d4ad389aa18@intel.com>
Date: Wed, 3 Jan 2024 10:08:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
To: Jorge Ramirez-Ortiz <jorge@foundries.io>, Avri.Altman@wdc.com,
 ulf.hansson@linaro.org, christian.loehle@arm.com
Cc: jinpu.wang@ionos.com, axboe@kernel.dk, beanhuo@micron.com,
 yibin.ding@unisoc.com, victor.shih@genesyslogic.com.tw, asuk4.q@gmail.com,
 hkallweit1@gmail.com, yangyingliang@huawei.com, yebin10@huawei.com,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204150111.3320071-1-jorge@foundries.io>
 <3df25974-1a98-4f1e-bb24-97519a9254de@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <3df25974-1a98-4f1e-bb24-97519a9254de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/01/24 21:02, Adrian Hunter wrote:
> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>> Requesting a retune before switching to the RPMB partition has been
>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
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
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Oops, this is the wrong patch.  I meant to ack the later one,
which I have now.

> 
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
>>  		mmc_retune_hold(host);
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


