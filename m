Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961377FFAEA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjK3TM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjK3TMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:12:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFF910E2;
        Thu, 30 Nov 2023 11:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701371577; x=1732907577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nMu57xPUsxY5mP6t563nAkcs2XKcGfXgn93cIC3yPY0=;
  b=mRbdZN6IvteQV+tUsXEVNUjB7xAmVRxUebCxyID5o2mhMLLz83cJ+iF/
   aD9fcDg7pOUNU9aOkqwDxeZe+irbcmIBCbWlHzEo5bYiudTAswcxE5Af/
   602NoeVYZyNEnwLRgItA9CvR0KJQdkjeiy6tvu+N8fyYxMFwh36A7pbJg
   w7TPPYVLGt+kYQVOoWZAImJcd1MG23H9Y4c/3zlQ0wZMg83XxA56DRljp
   M/rOjcysmhemehbr5amwdVV2mAlyBFdGbneV0dl1AxbfyLf9SWJUEpq7N
   949PvvIqPDwrfRCBIa3mRlRwoRFlNgC1lYDtvuCvyrEn0rLLh40mErbpw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="374404"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="374404"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 11:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="803793369"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="803793369"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.116])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 11:12:32 -0800
Message-ID: <fbc82848-d402-4075-8176-de9ed0345d78@intel.com>
Date:   Thu, 30 Nov 2023 21:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] mmc: rpmb: add quirk MMC_QUIRK_BROKEN_RPMB_RETUNE
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     CLoehle@hyperstone.com, jinpu.wang@ionos.com, hare@suse.de,
        Ulf Hansson <ulf.hansson@linaro.org>, beanhuo@micron.com,
        yangyingliang@huawei.com, asuk4.q@gmail.com, yibin.ding@unisoc.com,
        victor.shih@genesyslogic.com.tw, marex@denx.de,
        rafael.beims@toradex.com, robimarko@gmail.com,
        ricardo@foundries.io, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129160533.2827458-1-jorge@foundries.io>
 <CAPDyKFpg+7W1ODGHw5oXy_wzWA1Qqzg9w_12rhQ8qW4o--6dWg@mail.gmail.com>
 <ZWiNDgUFF8ug7gZf@trax>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZWiNDgUFF8ug7gZf@trax>
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

On 30/11/23 15:24, Jorge Ramirez-Ortiz, Foundries wrote:
> On 30/11/23 11:34:18, Ulf Hansson wrote:
>> On Wed, 29 Nov 2023 at 17:05, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>>>
>>> On the eMMC SanDisk iNAND 7250 configured with HS200, requesting a
>>> re-tune before switching to the RPMB partition would randomly cause
>>> subsequent RPMB requests to fail with EILSEQ:
>>> * data error -84, tigggered in __mmc_blk_ioctl_cmd()
>>>
>>> This commit skips the retune when switching to RPMB.
>>> Tested over several days with per minute RPMB reads.
>>
>> This sounds weird to me and needs more testing/debugging in my
>> opinion, especially at the host driver level. Perhaps add some new
>> tests in mmc_test, that does a partition switch to/from any partition
>> and then run regular I/O again to see if the problem is easier to
>> reproduce?
> 
> hi Uffe
> 
> ok I'll have a look - I have never used this driver before, so if you
> have anything in the works I'll be glad to integrated and adapt.
> 
>>
>> The point is, I wonder what is so special with RPMB here? Note that,
>> it has been quite common that host drivers/controllers have had issues
>> with their tuning support, so I would not be surprised if that is the
>> case here too.
> 
> Right, it is just that the tuning function for of-arasan is the generic
> __sdhci_execute_tuning() - only wrapped around arasan DLL reset
> calls. Hence why I aimed for the card: __sdhci_execute_tuning and ZynqMP
> are not recent functions or architectures.
> 
> 
>> Certainly I would be surprised if the problem is at
>> the eMMC card side, but I may be wrong.
> 
> How do maintainers test the tuning methods? is there anything else for
> me to do other than forcing a retune with different partitions?
> 
>>
>> Kind regards
>> Uffe
> 
> For completeness this is the error message - notice that we have a
> trusted application (fiovb) going through OP-TEE and back to the TEE
> supplicant issuing an rpmb read of a variable (pretty normal these days,
> we use it on many different platforms - ST, NXP, AMD/Xilinx, TI..).
> 
> The issue on this Zynqmp platform is scarily simple to reproduce; you
> can ignore the OP-TEE trace, it is just the TEE way of reporting that
> the RPMB read failed.
> 
> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# fiovb_printenv m4hash
> [  461.775084] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> E/LD:  region  6: va 0xc0019000 pa 0x816b31fc8 size 0x001000 flags rw-- (param)
> E/LD:  region  7: va 0xc001a000 pa 0x816aa1fc8 size 0x002000 flags rw-- (param)
> E/LD:  region  8: va 0xc006b000 pa 0x00001000 size 0x014000 flags r-xs [0]
> E/LD:  region  9: va 0xc007f000 pa 0x00015000 size 0x008000 flags rw-s [0]
> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc006b000
> E/LD:  Call stack:
> E/LD:   0xc006de58
> E/LD:   0xc006b388
> E/LD:   0xc006ed40
> E/LD:   0xc006b624
> Read persistent value for m4hash failed: Exec format error

Have you tried dynamic debug for mmc

    Kernel must be configured:

        CONFIG_DYNAMIC_DEBUG=y

    To enable mmc debug via sysfs:

        echo 'file drivers/mmc/core/* +p' > /sys/kernel/debug/dynamic_debug/control
        echo 'file drivers/mmc/host/* +p' > /sys/kernel/debug/dynamic_debug/control


