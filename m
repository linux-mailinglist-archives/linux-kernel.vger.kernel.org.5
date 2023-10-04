Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F007B814B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbjJDNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbjJDNsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:48:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E98BA1;
        Wed,  4 Oct 2023 06:48:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7708DDA7;
        Wed,  4 Oct 2023 06:48:45 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15BB73F59C;
        Wed,  4 Oct 2023 06:48:04 -0700 (PDT)
Message-ID: <9b519a19-548c-dec0-ed69-52695ff12a69@arm.com>
Date:   Wed, 4 Oct 2023 14:48:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/7] coresight: tmc: Add support for reading tracedata
 from previous boot
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     Linu Cherian <lcherian@marvell.com>, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, sgoutham@marvell.com,
        gcherian@marvell.com, Anil Kumar Reddy <areddy3@marvell.com>,
        Tanmay Jagdale <tanmay@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
 <20230929133754.857678-6-lcherian@marvell.com>
 <acc2a406-2cff-eb3b-7661-1a93d4749bf2@arm.com>
In-Reply-To: <acc2a406-2cff-eb3b-7661-1a93d4749bf2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/10/2023 17:43, James Clark wrote:
> 
> 
> On 29/09/2023 14:37, Linu Cherian wrote:
>> * Introduce a new mode CS_MODE_READ_PREVBOOT for reading tracedata
>>   captured in previous boot.
>>
>> * Add special handlers for preparing ETR/ETF for this special mode
>>
>> * User can read the trace data as below
>>
>>   For example, for reading trace data from tmc_etf sink
>>
>>   1. cd /sys/bus/coresight/devices/tmc_etfXX/
>>
>>   2. Change mode to READ_PREVBOOT
>>
>>      #echo 1 > read_prevboot
>>
>>   3. Dump trace buffer data to a file,
>>
>>      #dd if=/dev/tmc_etrXX of=~/cstrace.bin
>>
>>   4. Reset back to normal mode
>>
>>      #echo 0 > read_prevboot
>>
>> Signed-off-by: Anil Kumar Reddy <areddy3@marvell.com>
>> Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
>> Signed-off-by: Linu Cherian <lcherian@marvell.com>
>> ---
>>  .../coresight/coresight-etm4x-core.c          |   1 +
>>  .../hwtracing/coresight/coresight-tmc-core.c  |  81 +++++++++-
>>  .../hwtracing/coresight/coresight-tmc-etf.c   |  62 ++++++++
>>  .../hwtracing/coresight/coresight-tmc-etr.c   | 145 +++++++++++++++++-
>>  drivers/hwtracing/coresight/coresight-tmc.h   |   6 +
>>  include/linux/coresight.h                     |  13 ++
>>  6 files changed, 306 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 77b0271ce6eb..513baf681280 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -1010,6 +1010,7 @@ static void etm4_disable(struct coresight_device *csdev,
>>  
>>  	switch (mode) {
>>  	case CS_MODE_DISABLED:
>> +	case CS_MODE_READ_PREVBOOT:
>>  		break;
>>  	case CS_MODE_SYSFS:
>>  		etm4_disable_sysfs(csdev);
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> index 6658ce76777b..65c15c9f821b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>> @@ -103,6 +103,45 @@ u32 tmc_get_memwidth_mask(struct tmc_drvdata *drvdata)
>>  	return mask;
>>  }
>>  
>> +int tmc_read_prepare_prevboot(struct tmc_drvdata *drvdata)
>> +{
>> +	int ret = 0;
>> +	struct tmc_register_snapshot *reg_ptr;
>> +	struct coresight_device *csdev = drvdata->csdev;
>> +
>> +	if (!drvdata->metadata.vaddr) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	reg_ptr = drvdata->metadata.vaddr;
>> +	if (!reg_ptr->valid) {
>> +		dev_err(&drvdata->csdev->dev,
>> +			"Invalid metadata captured from previous boot\n");
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
> 
> I'm wondering if a more robust check is needed than the valid flag, like
> a checksum or something. I didn't debug it yet but I ended up with an
> invalid set of metadata after a panic reboot, see below. I'm not sure if
> it's just a logic bug or something got lost during the reboot, I didn't
> debug it yet. But I suppose unless you assume the panic didn't affect
> writing the metadata, then it could be partially written and shouldn't
> be trusted?
> 
> [...]
>> +
>> +static int tmc_etr_sync_prevboot_buf(struct tmc_drvdata *drvdata)
>> +{
>> +	u32 status;
>> +	u64 rrp, rwp, dba;
>> +	struct tmc_register_snapshot *reg_ptr;
>> +	struct etr_buf *etr_buf = drvdata->prevboot_buf;
>> +
>> +	reg_ptr = drvdata->metadata.vaddr;
>> +
>> +	rrp = reg_ptr->rrp;
>> +	rwp = reg_ptr->rwp;
>> +	dba = reg_ptr->dba;
>> +	status = reg_ptr->sts;
>> +
>> +	etr_buf->full = !!(status & TMC_STS_FULL);
>> +
>> +	/* Sync the buffer pointers */
>> +	etr_buf->offset = rrp - dba;
>> +	if (etr_buf->full)
>> +		etr_buf->len = etr_buf->size;
>> +	else
>> +		etr_buf->len = rwp - rrp;
>> +
>> +	/* Sanity checks for validating metadata */
>> +	if ((etr_buf->offset > etr_buf->size) ||
>> +	    (etr_buf->len > etr_buf->size))
>> +		return -EINVAL;
> 
> The values I got here are 0x781b67182aa346f9 0x8000000 0x8000000 for
> offset, size and len respectively. This fails the first check. It would
> also be nice to have a dev_dbg here as well, it's basically the same as
> the valid check above which does have one.
> 

So I debugged it and the issue is that after the panic I was doing a
cold boot rather than a warm boot and the memory was being randomised.

The reason that 0x8000000 seemed to be initialised is because they are
based on the reserved region size, rather than anything from the
metadata. When I examined the metadata it was all randomised.

That leads me to think that the single bit for 'valid' is insufficient.
There is a simple hashing function in include/linux/stringhash.h that we
could use on the whole metadata struct, but that specifically says:

 * These hash functions are NOT GUARANTEED STABLE between kernel
 * versions, architectures, or even repeated boots of the same kernel.
 * (E.g. they may depend on boot-time hardware detection or be
 * deliberately randomized.)

Although I'm not sure how true the repeated boots of the same kernel
part is.

Maybe something in include/crypto/hash.h could be used instead, or make
our own simple hash.

