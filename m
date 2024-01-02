Return-Path: <linux-kernel+bounces-14757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9FC8221AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 20:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABEB1F21143
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38801168A6;
	Tue,  2 Jan 2024 19:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOy5AefK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600316417;
	Tue,  2 Jan 2024 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704222119; x=1735758119;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yyKY9btDV6FoXwV8LI1+9t8NXiIEeTdUHQ0lV4FyNQ8=;
  b=FOy5AefKbZNts3MIZDMcacbQv63WT7gPWuBO09TWyX5Zu01J5Rghxb/7
   NklJcXjOJafrhjSLK9EZR8LwR/GyB927XJ3DWn/pkSNsJIHQIbPaDS9aJ
   iZGuyeQacBpJquJncaXSh65jvUVeaempZUKEIEeKoY2UNQYj1HsM5SJTU
   54Ih0NgzcBOw7QcSQT+d9oTBikC7Rcy1P2QoUZbuYtlGuoF67VX+PJGGY
   K+2mKrGs0l8v+42dKRtLGyYR9TvXQ0Yu+FCO09bwtok1fy8Re+o6nt/eV
   isDHIZtst1BbyjrIt2U5W30BAXcpCd366mW2n+96HA7kDCbE/jUJ0OlgQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3723477"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="3723477"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:01:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="870334430"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="870334430"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.83])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:01:54 -0800
Message-ID: <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com>
Date: Tue, 2 Jan 2024 21:01:52 +0200
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
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZZPoRPxdWXuT+cEo@trax>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/01/24 12:41, Jorge Ramirez-Ortiz, Foundries wrote:
> On 11/12/23 09:00:06, Jorge Ramirez-Ortiz, Foundries wrote:
>> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
>>> On 06/12/23 07:02:43, Avri Altman wrote:
>>>>>
>>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>>>>>> Requesting a retune before switching to the RPMB partition has been
>>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>>>>>
>>>>> There are still 2 concerns:
>>>>> 1) We don't really know the root cause.  Have you determined if here are
>>>>> CRC errors in the main partition also?
>>>
>>> right, and I don't disagree with that.
>>>
>>> As a test I created a 4GB file from /dev/random which I then copied
>>> several times (dd if= ....)
>>>
>>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
>>> # Command Timeout Occurred:      0
>>> # Command CRC Errors Occurred:   0
>>> # Data Timeout Occurred:         0
>>> # Data CRC Errors Occurred:      0
>>> # Auto-Cmd Error Occurred:       0
>>> # ADMA Error Occurred:   0
>>> # Tuning Error Occurred:         0
>>> # CMDQ RED Errors:       0
>>> # CMDQ GCE Errors:       0
>>> # CMDQ ICCE Errors:      0
>>> # Request Timedout:      0
>>> # CMDQ Request Timedout:         0
>>> # ICE Config Errors:     0
>>> # Controller Timedout errors:    0
>>> # Unexpected IRQ errors:         0
>>>
>>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
>>>
>>> I/TC: RPMB: Using generated key
>>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>>> E/TC:? 0
>>> E/TC:? 0 TA panicked with code 0xffff0000
>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>>> E/LD:   arch: aarch64
>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
>>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
>>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
>>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
>>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
>>> E/LD:  Call stack:
>>> E/LD:   0xc0051a14
>>> E/LD:   0xc004f31c
>>> E/LD:   0xc0052d40
>>> E/LD:   0xc004f624
>>>
>>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
>>> # Command Timeout Occurred:      0
>>> # Command CRC Errors Occurred:   0
>>> # Data Timeout Occurred:         0
>>> # Data CRC Errors Occurred:      1
>>> # Auto-Cmd Error Occurred:       0
>>> # ADMA Error Occurred:   0
>>> # Tuning Error Occurred:         0
>>> # CMDQ RED Errors:       0
>>> # CMDQ GCE Errors:       0
>>> # CMDQ ICCE Errors:      0
>>> # Request Timedout:      0
>>> # CMDQ Request Timedout:         0
>>> # ICE Config Errors:     0
>>> # Controller Timedout errors:    0
>>> # Unexpected IRQ errors:         0
>>>
>>>>> 2) Forcing this on everyone
>>>>>
>>>>> The original idea was that because re-tuning cannot be done in RPMB, the
>>>>> need to re-rune in RPMB could be avoided by always re-tuning before
>>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
>>>>> guarantee at least 4MB more I/O without issue.
>>>> Performance is hardly an issue in the context of RPMB access -
>>>> For most cases it’s a single frame.
>>>
>>> Yes, the security use case typically stores hashes, variables
>>> (bootcount, upgrade_available, versions, that sort of thing) and
>>> certificates in RPMB.
>>>
>>> Since you mentioned, I am seeing that tuning before switching to RPMB
>>> has an impact on performance. As a practical test, just reading a 6 byte
>>> variable incurs in 50ms penalty in kernel space due to the need to
>>> retune 5 times. Not great since the request is coming from a Trusted
>>> Application via OP-TEE through the supplicant meaning this TEE thread
>>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
>>> quite a bit of time.
>>>
>>> Roughly:
>>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
>>
>> To add more detail to the timing above, when using RPMB, OP-TEE stores
>> the secure filesystem on RPMB as well, so accessing one of the variables
>> stored in the filesystem consists on a number (~5) of individual RPMB
>> requests (each one forcing a retune, each retune taking around 10ms).
> 
> Adrian, please could you comment on the above.
> 
> The current code is a performance drag for systems that implement their
> secure filesystems on RPMB (i.e: OP-TEE) causing each read operation (of
> variables consisting of a few bytes stored in such a filesystem) to
> perform 5 consecutive retune requests.
> 
> I am just thinking whether the original use case that forces a call to
> retune prior to processing the RPMB request remains valid.

I am not sure what you are asking.

For some transfer modes, re-tuning is expected to deal with sampling
point drift over time, mainly due to temperature changes.  It is done
either periodically (tuning timer) or after a CRC error.

There is no reason to assume RPMB is immune from that.

Certainly re-tuning before switching to RPMB is not optimal for
performance, and we can leave that out, but a CRC error before
or during RPMB operations will *still* result in re-tuning
after switching back from RPMB.

In your case, re-tuning makes things worse, which is a bit of a
mystery.  Running the new re-tuning test would tell us whether
it makes things worse in general, or only for RPMB.

> 
> Independently of the fact that not doing so fixes the problem I was
> working on - and with the information I have - I dont think RPMB is
> generally used to store larger files (maybe you have more information
> about the average use case? are you aware of systems using RPMB to store
> binaries or images?)
> 
> I still I have to execute the test you shared some weeks ago. Bit of a
> pain to NFS boot this system...will try to do it this week.

Other options are to boot with an initrd only, or after boot switch
to a RAM-based file system.

I was waiting for this, since it is good to try to get closer to a
root cause, but as you point out, the change is good for performance
also, so I will Ack it.


> 
> TIA
> 
>>
>> BTW, I also tried delaying the timing between those consecutive retunes
>> (up to 1 second), but the issue still persisted.
>>
>>>
>>> Adrian, I couldn't find the original performance justification for
>>> enabling this feature globally. At which point do you think it becomes
>>> beneficial to retune before accessing RPMB?
>>
>> How should we proceed with this patch then? can it be merged as I
>> proposed? should I rewrite it differently? not sure what is next
>>
>> TIA
>> Jorge


