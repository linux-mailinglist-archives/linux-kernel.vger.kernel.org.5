Return-Path: <linux-kernel+bounces-15257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96EA822942
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA01C23077
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFB182AF;
	Wed,  3 Jan 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnAfYUUb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA784182A1;
	Wed,  3 Jan 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704269027; x=1735805027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l5+EuJwYQuWGCdbDvh2EC5LTG8OCKVkqFz6/bxydejg=;
  b=GnAfYUUbdC408XCXKaNQTv5VFgSBHky5aHOsUjqJD2B5YGqeB9KvG4QZ
   gaIKhPJ6Ru4BwQ+xNSWoYyzW1DJUdIIESiNkn2DA+W5efLZlVC8RGBl73
   OdOHbH2gF/tBUL+TGiJOoHYgy158vmHyPhMlIeYOtST/98EhmUCl2C12p
   IDaL6ZpaOAwuQoFZgL6tYlVjHvWVqNX8EsGxTx6LDLHw+G4Q+llz5IyrN
   Zhb1Mr8I1RlhvOCAn2+PrQ/TJxf92t3F2Ml/mvrS6Dd9mOQKcCT/4YVwb
   oQ+wMIEXjr5id9so7+yNRvauYsFAdG57Qq8+kqKQzGtaXWDUCyiBgrDDP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="387431571"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="387431571"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="756149623"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; 
   d="scan'208";a="756149623"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.51.162])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 00:03:42 -0800
Message-ID: <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com>
Date: Wed, 3 Jan 2024 10:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZZSH1ykwP45fZaLh@trax>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/01/24 00:01, Jorge Ramirez-Ortiz, Foundries wrote:
> On 02/01/24 21:01:52, Adrian Hunter wrote:
>> On 2/01/24 12:41, Jorge Ramirez-Ortiz, Foundries wrote:
>>> On 11/12/23 09:00:06, Jorge Ramirez-Ortiz, Foundries wrote:
>>>> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
>>>>> On 06/12/23 07:02:43, Avri Altman wrote:
>>>>>>>
>>>>>>> On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
>>>>>>>> Requesting a retune before switching to the RPMB partition has been
>>>>>>>> observed to cause CRC errors on the RPMB reads (-EILSEQ).
>>>>>>>
>>>>>>> There are still 2 concerns:
>>>>>>> 1) We don't really know the root cause.  Have you determined if here are
>>>>>>> CRC errors in the main partition also?
>>>>>
>>>>> right, and I don't disagree with that.
>>>>>
>>>>> As a test I created a 4GB file from /dev/random which I then copied
>>>>> several times (dd if= ....)
>>>>>
>>>>> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
>>>>> # Command Timeout Occurred:      0
>>>>> # Command CRC Errors Occurred:   0
>>>>> # Data Timeout Occurred:         0
>>>>> # Data CRC Errors Occurred:      0
>>>>> # Auto-Cmd Error Occurred:       0
>>>>> # ADMA Error Occurred:   0
>>>>> # Tuning Error Occurred:         0
>>>>> # CMDQ RED Errors:       0
>>>>> # CMDQ GCE Errors:       0
>>>>> # CMDQ ICCE Errors:      0
>>>>> # Request Timedout:      0
>>>>> # CMDQ Request Timedout:         0
>>>>> # ICE Config Errors:     0
>>>>> # Controller Timedout errors:    0
>>>>> # Unexpected IRQ errors:         0
>>>>>
>>>>> However as soon as I access RPMB and fails (it takes just a few tries) I see:
>>>>>
>>>>> I/TC: RPMB: Using generated key
>>>>> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
>>>>> E/TC:? 0
>>>>> E/TC:? 0 TA panicked with code 0xffff0000
>>>>> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
>>>>> E/LD:   arch: aarch64
>>>>> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
>>>>> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
>>>>> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
>>>>> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
>>>>> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
>>>>> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
>>>>> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
>>>>> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
>>>>> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
>>>>> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
>>>>> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
>>>>> E/LD:  Call stack:
>>>>> E/LD:   0xc0051a14
>>>>> E/LD:   0xc004f31c
>>>>> E/LD:   0xc0052d40
>>>>> E/LD:   0xc004f624
>>>>>
>>>>> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
>>>>> # Command Timeout Occurred:      0
>>>>> # Command CRC Errors Occurred:   0
>>>>> # Data Timeout Occurred:         0
>>>>> # Data CRC Errors Occurred:      1
>>>>> # Auto-Cmd Error Occurred:       0
>>>>> # ADMA Error Occurred:   0
>>>>> # Tuning Error Occurred:         0
>>>>> # CMDQ RED Errors:       0
>>>>> # CMDQ GCE Errors:       0
>>>>> # CMDQ ICCE Errors:      0
>>>>> # Request Timedout:      0
>>>>> # CMDQ Request Timedout:         0
>>>>> # ICE Config Errors:     0
>>>>> # Controller Timedout errors:    0
>>>>> # Unexpected IRQ errors:         0
>>>>>
>>>>>>> 2) Forcing this on everyone
>>>>>>>
>>>>>>> The original idea was that because re-tuning cannot be done in RPMB, the
>>>>>>> need to re-rune in RPMB could be avoided by always re-tuning before
>>>>>>> switching to RPMB and then switching straight back. IIRC re-tuning should
>>>>>>> guarantee at least 4MB more I/O without issue.
>>>>>> Performance is hardly an issue in the context of RPMB access -
>>>>>> For most cases it’s a single frame.
>>>>>
>>>>> Yes, the security use case typically stores hashes, variables
>>>>> (bootcount, upgrade_available, versions, that sort of thing) and
>>>>> certificates in RPMB.
>>>>>
>>>>> Since you mentioned, I am seeing that tuning before switching to RPMB
>>>>> has an impact on performance. As a practical test, just reading a 6 byte
>>>>> variable incurs in 50ms penalty in kernel space due to the need to
>>>>> retune 5 times. Not great since the request is coming from a Trusted
>>>>> Application via OP-TEE through the supplicant meaning this TEE thread
>>>>> (they are statically allocated CFG_NUM_THREADS) will be reserved for
>>>>> quite a bit of time.
>>>>>
>>>>> Roughly:
>>>>> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
>>>>
>>>> To add more detail to the timing above, when using RPMB, OP-TEE stores
>>>> the secure filesystem on RPMB as well, so accessing one of the variables
>>>> stored in the filesystem consists on a number (~5) of individual RPMB
>>>> requests (each one forcing a retune, each retune taking around 10ms).
>>>
>>> Adrian, please could you comment on the above.
>>>
>>> The current code is a performance drag for systems that implement their
>>> secure filesystems on RPMB (i.e: OP-TEE) causing each read operation (of
>>> variables consisting of a few bytes stored in such a filesystem) to
>>> perform 5 consecutive retune requests.
>>>
>>> I am just thinking whether the original use case that forces a call to
>>> retune prior to processing the RPMB request remains valid.
>>
>> I am not sure what you are asking.
>>
>> For some transfer modes, re-tuning is expected to deal with sampling
>> point drift over time, mainly due to temperature changes.  It is done
>> either periodically (tuning timer) or after a CRC error.
>>
>> There is no reason to assume RPMB is immune from that.
>>
>> Certainly re-tuning before switching to RPMB is not optimal for
>> performance, and we can leave that out, but a CRC error before
>> or during RPMB operations will *still* result in re-tuning
>> after switching back from RPMB.
>>
>> In your case, re-tuning makes things worse, which is a bit of a
>> mystery.  Running the new re-tuning test would tell us whether
>> it makes things worse in general, or only for RPMB.
>>
>>>
>>> Independently of the fact that not doing so fixes the problem I was
>>> working on - and with the information I have - I dont think RPMB is
>>> generally used to store larger files (maybe you have more information
>>> about the average use case? are you aware of systems using RPMB to store
>>> binaries or images?)
>>>
>>> I still I have to execute the test you shared some weeks ago. Bit of a
>>> pain to NFS boot this system...will try to do it this week.
>>
>> Other options are to boot with an initrd only, or after boot switch
>> to a RAM-based file system.
>>
>> I was waiting for this, since it is good to try to get closer to a
>> root cause, but as you point out, the change is good for performance
>> also, so I will Ack it.
> 
> great, thanks!
> I was finally able to nfs mount this project (was a bit of a pain since
> the board is using ostree).
> 
> The test failed. See below
> 
> root@uz3cg-dwg-sec:/# uname -a
> Linux uz3cg-dwg-sec 5.15.64-lmp-standard #1 SMP Thu Sep 1 02:40:19 UTC 2022 aarch64 GNU/Linux
> 
> root@uz3cg-dwg-sec:/# cat /proc/cmdline
> earlycon console=ttyPS0,115200 clk_ignore_unused root=/dev/nfs nfsroot=192.168.1.9:/srv/nfs/rootfs rootwait rw nfsrootdebug ip=dhcp rootfstype=ext4 ostree=ostree/boot.1.1/lmp/5c73dc21eb70c12363747b90c04302115715fa46063a9099841cf23cc70c09a6/0
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# cd mmcblk/
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc/drivers/mmcblk# ls
> bind       mmc0:0001  uevent     unbind
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc/drivers/mmcblk# echo 'mmc0:0001' > unbind
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# echo 'mmc0:0001' > mmc_test/bind
> [  284.253261] mmc_test mmc0:0001: Card claimed for testing.
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc/drivers# cd ..
> root@uz3cg-dwg-sec:/sys/bus/mmc# ls
> devices            drivers            drivers_autoprobe  drivers_probe      uevent
> 
> root@uz3cg-dwg-sec:/sys/bus/mmc# cd /
> 
> root@uz3cg-dwg-sec:/# cat /sys/kernel/debug/mmc0/mmc0\:0001/test
> test      testlist
> 
> root@uz3cg-dwg-sec:/# cat /sys/kernel/debug/mmc0/mmc0\:0001/testlist | grep tuning
> 52:     Re-tuning reliability
> 
> root@uz3cg-dwg-sec:/# echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
> [  352.283447] mmc0: Starting tests of card mmc0:0001...
> [  352.288597] mmc0: Test case 52. Re-tuning reliability...
> [  354.265441] mmc0: Result: ERROR (-84)
> [  354.269142] mmc0: Tests completed.
> 
> root@uz3cg-dwg-sec:/#

Thanks for doing that!  That seems to explain the mystery.

You could hack the test to get an idea of how many successful
iterations there are before getting an error.

For SDHCI, one difference between tuning and re-tuning is the
setting of bit-7 "Sampling Clock Select" of "Host Control 2 Register".
It is initially 0 and then set to 1 after the successful tuning.
Essentially, leaving it set to 1 is meant to speed up the re-tuning.
You could try setting it to zero instead, and see if that helps.
e.g.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c79f73459915..714d8cc39709 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2732,6 +2732,7 @@ void sdhci_start_tuning(struct sdhci_host *host)
 	ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
 		ctrl |= SDHCI_CTRL_TUNED_CLK;
+	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 	/*


> 
> 
> 
> 
>>
>>
>>>
>>> TIA
>>>
>>>>
>>>> BTW, I also tried delaying the timing between those consecutive retunes
>>>> (up to 1 second), but the issue still persisted.
>>>>
>>>>>
>>>>> Adrian, I couldn't find the original performance justification for
>>>>> enabling this feature globally. At which point do you think it becomes
>>>>> beneficial to retune before accessing RPMB?
>>>>
>>>> How should we proceed with this patch then? can it be merged as I
>>>> proposed? should I rewrite it differently? not sure what is next
>>>>
>>>> TIA
>>>> Jorge
>>


