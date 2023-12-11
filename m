Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42F780C662
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbjLKKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjLKKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:25:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D4FCB;
        Mon, 11 Dec 2023 02:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702290326; x=1733826326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OgH2Ii4TMi5UPL6lkYbLTLXe+FxbxtmlREmovQ2xGVY=;
  b=n9BArrKKp4f4pTrqFQOWBEI7N/HIWTQ5obY8kT8I2nLiAbTZulVYT4C9
   kggns4z/ENRCAgZ47v9FI8vJvpkcBI3UAFkqXi28vLuuQMDWXnkq2JbRK
   dRQIaCWTdJktJO/haESBAU4Cq6HLuKVGN7hmNPzWADVWpnCjYnhIFx5xu
   MO9dlfrx2jOBvMIjYkXMuSmVh47cC8FYTZCMIkqdPvx1veDCRQpZfo2Eh
   NA5TieADI3muhGI4QdLx+mbCSx0Mn0ySeWtyDAIsMK53CGV0V5rsMF0/3
   fzry/L/7WwBbCPt6frWors7tZxvE/vX+WyzQNt+tOqPjdWEiq4MGpmmkF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="391793000"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="391793000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:25:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843456507"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="843456507"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.23])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:25:22 -0800
Message-ID: <7443a730-411a-4dd3-b911-241356493516@intel.com>
Date:   Mon, 11 Dec 2023 12:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Content-Language: en-US
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "christian.loehle@arm.com" <christian.loehle@arm.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
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
 <ZXBGTxS7sUSILtLs@trax> <ZXbBhjZIn5sj6EYO@trax>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZXbBhjZIn5sj6EYO@trax>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 10:00, Jorge Ramirez-Ortiz, Foundries wrote:
> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
>> On 06/12/23 07:02:43, Avri Altman wrote:
>>>>
>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>>>>> Requesting a retune before switching to the RPMB partition has been
>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>>>>
>>>> There are still 2 concerns:
>>>> 1) We don't really know the root cause.  Have you determined if here are
>>>> CRC errors in the main partition also?
>>
>> right, and I don't disagree with that.
>>
>> As a test I created a 4GB file from /dev/random which I then copied
>> several times (dd if= ....)
>>
>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
>> # Command Timeout Occurred:      0
>> # Command CRC Errors Occurred:   0
>> # Data Timeout Occurred:         0
>> # Data CRC Errors Occurred:      0
>> # Auto-Cmd Error Occurred:       0
>> # ADMA Error Occurred:   0
>> # Tuning Error Occurred:         0
>> # CMDQ RED Errors:       0
>> # CMDQ GCE Errors:       0
>> # CMDQ ICCE Errors:      0
>> # Request Timedout:      0
>> # CMDQ Request Timedout:         0
>> # ICE Config Errors:     0
>> # Controller Timedout errors:    0
>> # Unexpected IRQ errors:         0
>>
>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
>>
>> I/TC: RPMB: Using generated key
>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>> E/TC:? 0
>> E/TC:? 0 TA panicked with code 0xffff0000
>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>> E/LD:   arch: aarch64
>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
>> E/LD:  Call stack:
>> E/LD:   0xc0051a14
>> E/LD:   0xc004f31c
>> E/LD:   0xc0052d40
>> E/LD:   0xc004f624
>>
>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
>> # Command Timeout Occurred:      0
>> # Command CRC Errors Occurred:   0
>> # Data Timeout Occurred:         0
>> # Data CRC Errors Occurred:      1
>> # Auto-Cmd Error Occurred:       0
>> # ADMA Error Occurred:   0
>> # Tuning Error Occurred:         0
>> # CMDQ RED Errors:       0
>> # CMDQ GCE Errors:       0
>> # CMDQ ICCE Errors:      0
>> # Request Timedout:      0
>> # CMDQ Request Timedout:         0
>> # ICE Config Errors:     0
>> # Controller Timedout errors:    0
>> # Unexpected IRQ errors:         0
>>
>>>> 2) Forcing this on everyone
>>>>
>>>> The original idea was that because re-tuning cannot be done in RPMB, the
>>>> need to re-rune in RPMB could be avoided by always re-tuning before
>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
>>>> guarantee at least 4MB more I/O without issue.
>>> Performance is hardly an issue in the context of RPMB access -
>>> For most cases it’s a single frame.
>>
>> Yes, the security use case typically stores hashes, variables
>> (bootcount, upgrade_available, versions, that sort of thing) and
>> certificates in RPMB.
>>
>> Since you mentioned, I am seeing that tuning before switching to RPMB
>> has an impact on performance. As a practical test, just reading a 6 byte
>> variable incurs in 50ms penalty in kernel space due to the need to
>> retune 5 times. Not great since the request is coming from a Trusted
>> Application via OP-TEE through the supplicant meaning this TEE thread
>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
>> quite a bit of time.
>>
>> Roughly:
>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
> 
> To add more detail to the timing above, when using RPMB, OP-TEE stores
> the secure filesystem on RPMB as well, so accessing one of the variables
> stored in the filesystem consists on a number (~5) of individual RPMB
> requests (each one forcing a retune, each retune taking around 10ms).
> 
> BTW, I also tried delaying the timing between those consecutive retunes
> (up to 1 second), but the issue still persisted.
> 
>>
>> Adrian, I couldn't find the original performance justification for
>> enabling this feature globally. At which point do you think it becomes
>> beneficial to retune before accessing RPMB?
> 
> How should we proceed with this patch then? can it be merged as I
> proposed? should I rewrite it differently? not sure what is next

It would be good to try to determine if the error happens when the
switch command comes immediately after tuning.  For example, add
a delay after tuning and see if that makes any difference. e.g.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..6b168659282a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2867,8 +2867,10 @@ int __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
-			if (ctrl & SDHCI_CTRL_TUNED_CLK)
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				msleep(10);
 				return 0; /* Success! */
+			}
 			break;
 		}
 

