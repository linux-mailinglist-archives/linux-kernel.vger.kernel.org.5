Return-Path: <linux-kernel+bounces-17100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD3824840
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC151B229F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4328E1E;
	Thu,  4 Jan 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gto5M3Hf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE328E06;
	Thu,  4 Jan 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704393260; x=1735929260;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y5ZQ7s14+htsLTJ2CXBXwYk88AqUJQslodDbp6R4bpA=;
  b=Gto5M3HfEypJ+ZiifwIViGA/ybx3FCpNOF2GF/2xmvaXfi4Olh0QFa6a
   hptFOXtHg/oDmXhYXmyuPjS9VJaEimzjc3qNJczvbemohe8ugzFAvHStm
   R6ShHEh/UB5aYR7GytRXkKeq6ZhABHmIk7lZbIa+a37MaGpWvMFQ0e6Wd
   NOD2jxBB5YuHv7vgLC5vGOAjgfk9EvwZ3DdegmgvJUWvbJeOrCocgCBra
   kqEgpyJn4kXqeplOQV0crCJoptZ+dNaf4G3ELEKqTRwCYnlW8QoJIL4S0
   UINl2LEK+LbrXt3jsB0a2au3fKpTw5jV3DeCFop2pVPB1074v4nPnKCtA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="10717824"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="10717824"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="773615135"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="773615135"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.85])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 10:34:14 -0800
Message-ID: <29dc26a4-b95c-42d5-94f8-fbd23c589eaa@intel.com>
Date: Thu, 4 Jan 2024 20:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Avri Altman <Avri.Altman@wdc.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "christian.loehle@arm.com" <christian.loehle@arm.com>,
 "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "beanhuo@micron.com"
 <beanhuo@micron.com>, "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
 "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
 "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "yebin10@huawei.com" <yebin10@huawei.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax> <ZXbBhjZIn5sj6EYO@trax> <ZZPoRPxdWXuT+cEo@trax>
 <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com> <ZZSH1ykwP45fZaLh@trax>
 <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com> <ZZUm68tU9zHsC+X+@trux>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZZUm68tU9zHsC+X+@trux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/01/24 11:20, Jorge Ramirez-Ortiz, Foundries wrote:
> On 03/01/24 10:03:38, Adrian Hunter wrote:
>> Thanks for doing that!  That seems to explain the mystery.
>>
>> You could hack the test to get an idea of how many successful
>> iterations there are before getting an error.
>>
>> For SDHCI, one difference between tuning and re-tuning is the
>> setting of bit-7 "Sampling Clock Select" of "Host Control 2 Register".
>> It is initially 0 and then set to 1 after the successful tuning.
>> Essentially, leaving it set to 1 is meant to speed up the re-tuning.
>> You could try setting it to zero instead, and see if that helps.
>> e.g.
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index c79f73459915..714d8cc39709 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2732,6 +2732,7 @@ void sdhci_start_tuning(struct sdhci_host *host)
>>  	ctrl |= SDHCI_CTRL_EXEC_TUNING;
>>  	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
>>  		ctrl |= SDHCI_CTRL_TUNED_CLK;
>> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
>>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>>  	/*
>>
> 
> 
> Yes with that change, the re-tuning reliability test does pass.
> 
> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0#  echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
> [  237.833585] mmc0: Starting tests of card mmc0:0001...
> [  237.838759] mmc0: Test case 52. Re-tuning reliability...
> [  267.845403] mmc0: Result: OK
> [  267.848365] mmc0: Tests completed.
> 
> 
> Unfortunately I still see the error when looping on RPMB reads.
> 
> For instance with this test script
>  $ while true; do rpmb_read m4hash; usleep 300; done
> 
> I can see the error triggering on the serial port after a minute or so.
> [  151.682907] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> 
> Causing OP-TEE to panic since the RPMB read returns an error
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> E/LD:   arch: aarch64
> [...]
> 
> if anything else springs to your mind I am happy to test of course - there are
> so many tunnables in this subsystem that experience is this area has exponential
> value (and I dont have much).
> 
> Would it make sense if re-tuning requests are rejected unless a minimum number
> of jiffies have passed? should I try that as a change?
> 
> or maybe delay a bit longer the RPMB access after a retune request?

It seems re-tuning is not working properly, so ideally the
SoC vendor / driver implementer would provide a solution.

There is also mmc_doing_retune() which could be used to skip
tuning execution entirely in the case of re-tuning.


