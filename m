Return-Path: <linux-kernel+bounces-20736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14580828462
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CAB226F8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA7C36AE7;
	Tue,  9 Jan 2024 10:59:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C336AE0;
	Tue,  9 Jan 2024 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E70B5C15;
	Tue,  9 Jan 2024 02:59:48 -0800 (PST)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2173F73F;
	Tue,  9 Jan 2024 02:59:01 -0800 (PST)
Message-ID: <8d37d907-68c3-4e77-995b-bc85a0c3b8f0@arm.com>
Date: Tue, 9 Jan 2024 10:59:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] coresight: tmc: Stop trace capture on FlIn
Content-Language: en-US
To: Mike Leach <mike.leach@linaro.org>, Linu Cherian <lcherian@marvell.com>
Cc: james.clark@arm.com, leo.yan@linaro.org,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20240105055840.1977897-1-lcherian@marvell.com>
 <20240105055840.1977897-7-lcherian@marvell.com>
 <CAJ9a7VhStuDsNz-BiVe-bW5E91UxQttKTbE4x+M+8NmdEKtAJw@mail.gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAJ9a7VhStuDsNz-BiVe-bW5E91UxQttKTbE4x+M+8NmdEKtAJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/01/2024 16:11, Mike Leach wrote:
> Hi,
> 
> On Fri, 5 Jan 2024 at 05:59, Linu Cherian <lcherian@marvell.com> wrote:
>>
>> Configure TMC ETR and ETF to flush and stop trace capture
>> on FlIn event. As a side effect, do manual flush only if
>> auto flush fails.
>>
>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>> ---
>> Changelog from v5:
>> * No changes
>>
>>   drivers/hwtracing/coresight/coresight-tmc-etf.c | 10 ++++++++--
>>   drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 ++++++++--
>>   drivers/hwtracing/coresight/coresight-tmc.h     |  3 +++
>>   3 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> index 72c2315f4e23..57a9a9300d36 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
>> @@ -34,7 +34,7 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>>          writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
>>          writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
>>                         TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
>> -                      TMC_FFCR_TRIGON_TRIGIN,
>> +                      TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
>>                         drvdata->base + TMC_FFCR);
>>
> 
> This is a problem. Setting TMC_FFCR_STOP_ON_FLUSH changes the
> fundamentals of trigger event handling. Without this bit ETM can
> generate multiple event  + triggers which are then embedded into the
> formatted trace stream for later search.
> With this new bit the capture will stop on the first event. Setting
> this bit should be dependent on the mode being set to ETR_MODE_RESRV
> 
> 
> 
>>          writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>> @@ -615,7 +615,13 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
>>          if (val != TMC_MODE_CIRCULAR_BUFFER)
>>                  goto out;
>>
>> -       tmc_flush_and_stop(drvdata);
>> +       val = readl(drvdata->base + TMC_FFSR);
>> +       /* Do manual flush and stop only if its not auto-stopped */
>> +       if (!(val & TMC_FFSR_FT_STOPPED)) {
>> +               dev_info(&csdev->dev,
>> +                        "%s: Triggering manual flush\n", __func__);
>> +               tmc_flush_and_stop(drvdata);
>> +       }
>>
> Is there some reason to believe that the stop on flush will not work?
> 
> Using this conditional skips the  tmc_wait_for_tmcready() called by
> tmc_flush_and_stop() if the formatter is stopped - which is a
> different condition test on a different register.

Or even a new sysfs handle to turn this on ? e.g.,

/sys/bus/coresight/devices/tmc_etfN/stop_on_flush

That can be honoured only in the sysfs mode and set accordingly by the
user ?

e.g.,

for f in $(find /sys/bus/coresight/devices/  -maxdepth 1 -name tmc_\*)
do
     echo 1 > $f/stop_on_flush
done


Suzuki


> 
> Why is this block of code not in the patch that introduces the
> tmc_panic_sync_etf()
> 
>>          /* Sync registers from hardware to metadata region */
>>          mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> index ab7521bbb2f5..4b3c7ec7f62b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>> @@ -1113,7 +1113,7 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
>>
>>          writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
>>                         TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
>> -                      TMC_FFCR_TRIGON_TRIGIN,
>> +                      TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
>>                         drvdata->base + TMC_FFCR);
>>          writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
>>          tmc_enable_hw(drvdata);
>> @@ -1846,7 +1846,13 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
>>          if (!(val & TMC_CTL_CAPT_EN))
>>                  goto out;
>>
>> -       tmc_flush_and_stop(drvdata);
>> +       val = readl(drvdata->base + TMC_FFSR);
>> +       /* Do manual flush and stop only if its not auto-stopped */
>> +       if (!(val & TMC_FFSR_FT_STOPPED)) {
>> +               dev_info(&csdev->dev,
>> +                        "%s: Triggering manual flush\n", __func__);
>> +               tmc_flush_and_stop(drvdata);
>> +       }
>>
> 
> Above comments for etf apply equally to etr.
> 
> Regards
> 
> Mike
> 
>>          /* Sync registers from hardware to metadata region */
>>          mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
>> index 6e1e910d5ea4..cf9313b302c7 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>> @@ -77,6 +77,9 @@
>>   #define TMC_AXICTL_AXCACHE_OS  (0xf << 2)
>>   #define TMC_AXICTL_ARCACHE_OS  (0xf << 16)
>>
>> +/* TMC_FFSR - 0x300 */
>> +#define TMC_FFSR_FT_STOPPED    BIT(1)
>> +
>>   /* TMC_FFCR - 0x304 */
>>   #define TMC_FFCR_FLUSHMAN_BIT  6
>>   #define TMC_FFCR_EN_FMT                BIT(0)
>> --
>> 2.34.1
>>
> 
> 
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK


