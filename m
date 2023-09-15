Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A367A1F39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjIOMwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjIOMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:52:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE35219AE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:51:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAE2E1FB;
        Fri, 15 Sep 2023 05:52:25 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E0123F5A1;
        Fri, 15 Sep 2023 05:51:46 -0700 (PDT)
Message-ID: <b116b736-8d4b-5809-0e1e-0c22fe5ceac3@arm.com>
Date:   Fri, 15 Sep 2023 13:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] coresight: Allow guests to be traced when FEAT_TRF
 and VHE are present
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
References: <20230904140705.1620708-1-james.clark@arm.com>
 <20230904140705.1620708-3-james.clark@arm.com>
 <a50a7468-923b-fbb2-32b9-7e371710a1d5@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <a50a7468-923b-fbb2-32b9-7e371710a1d5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 18:37, Suzuki K Poulose wrote:
> Hi James
> 
> 
> On 04/09/2023 15:07, James Clark wrote:
>> Currently the userspace and kernel filters for guests are never set, so
>> no trace will be generated for them. Add it by writing to the guest
>> filters when exclude_guest isn't set. By writing either E1TRE or E0TRE,
>> filtering on either guest kernel or guest userspace is also supported.
>>
>> Since TRFCR_EL1 access is trapped, this can't be  modified by the guest.
>>
>> This change also brings exclude_host support which is difficult to add
>> as a separate commit without excess churn and resulting in no trace at
>> all.
>>
>> Testing
>> =======
>>
>> The addresses were counted with the following:
>>
>>    $ perf report -D | grep -Eo 'EL2|EL1|EL0' | sort | uniq -c
>>
>> Guest kernel only:
>>
>>    $ perf record -e cs_etm//Gk -a -- true
>>      535 EL1
>>        1 EL2
>>
>> Guest user only (0 addresses expected because the guest OS hasn't reached
>> userspace yet):
>>
>>    $ perf record -e cs_etm//Gu -a -- true
>>
>> Host kernel only:
>>
>>    $  perf record -e cs_etm//Hk -a -- true
>>     3501 EL2
>>
>> Host userspace only:
>>
>>    $  perf record -e cs_etm//Hu -a -- true
>>      408 EL0
>>        1 EL2
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org> (sysreg)
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   arch/arm64/tools/sysreg                       |  4 ++
>>   .../coresight/coresight-etm4x-core.c          | 51 ++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
>>   drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
>>   4 files changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 6ca7db69d6c9..cae9139b6c05 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -2531,3 +2531,7 @@ EndSysreg
>>   Sysreg    TRFCR_EL2    3    4    1    2    1
>>   Fields    TRFCR_EL2
>>   EndSysreg
>> +
>> +Sysreg TRFCR_EL12    3    5    1    2    1
>> +Fields    TRFCR_ELx
>> +EndSysreg
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 77b0271ce6eb..6c16a14d6fbe 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -274,6 +274,18 @@ static void etm4x_prohibit_trace(struct
>> etmv4_drvdata *drvdata)
>>       cpu_prohibit_trace();
>>   }
>>   +static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
>> +{
>> +    u64 trfcr = drvdata->trfcr;
>> +
>> +    if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
>> +        trfcr &= ~TRFCR_ELx_ExTRE;
>> +    if (drvdata->config.mode & ETM_MODE_EXCL_USER)
>> +        trfcr &= ~TRFCR_ELx_E0TRE;
>> +
>> +    return trfcr;
>> +}
>> +
>>   /*
>>    * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
>>    * as configured by the drvdata->config.mode for the current
>> @@ -286,18 +298,39 @@ static void etm4x_prohibit_trace(struct
>> etmv4_drvdata *drvdata)
>>    */
>>   static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
>>   {
>> -    u64 trfcr = drvdata->trfcr;
>> +    u64 trfcr;
>>         /* If the CPU doesn't support FEAT_TRF, nothing to do */
>> -    if (!trfcr)
>> +    if (!drvdata->trfcr)
>>           return;
>>   -    if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
>> -        trfcr &= ~TRFCR_ELx_ExTRE;
>> -    if (drvdata->config.mode & ETM_MODE_EXCL_USER)
>> -        trfcr &= ~TRFCR_ELx_E0TRE;
>> +    if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
>> +        trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
>> +    else
>> +        trfcr = etm4x_get_kern_user_filter(drvdata);
>>         write_trfcr(trfcr);
>> +
>> +    /*
>> +     * Filters for EL1 and EL0 (when running a guest) are stored in
>> +     * TRFCR_EL1 so write it there for VHE. For nVHE, the filters in
>> +     * have to be re-applied when switching to the guest instead.
>> +     */
>> +    if (!is_kernel_in_hyp_mode())
>> +        return;
>> +
>> +    if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
>> +        trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
>> +    else
>> +        trfcr = etm4x_get_kern_user_filter(drvdata);
>> +
>> +    /*
>> +     * TRFCR_EL1 doesn't have CX and TRFCR_EL1.TS has no effect when
>> TS is
>> +     * set in EL2 so mask them out.
>> +     */
>> +    trfcr &= ~(TRFCR_ELx_TS_MASK | TRFCR_EL2_CX);
>> +
>> +    write_sysreg_s(trfcr, SYS_TRFCR_EL12);
> 
> 
> 
> While I agree with the intention of the patch, I am not sure if we
> should do the TRFCR_EL1 (via TRFCR_EL12) updates from CoreSight driver.
> 
> It might be much better to do it from the KVM for both VHE and nVHE.
> 

For the next version of the nVHE change [1] I planned to re-write it
just in terms of the guest trfcr register value rather than
exclude_guest/exclude host. That means that it would be pretty easy to
move the write to SYS_TRFCR_EL12 to the VHE implementation of
kvm_etm_set_guest_trfcr(). So yes I can make this change I think it
makes sense.

[1]:
https://lore.kernel.org/kvmarm/20230804101317.460697-1-james.clark@arm.com/

James

> 
> Marc
> 
> What are your thoughts on this ?
> 
> Suzuki
> 
> 
>>   }
>>     #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>> @@ -655,6 +688,12 @@ static int etm4_parse_event_config(struct
>> coresight_device *csdev,
>>       if (attr->exclude_user)
>>           config->mode = ETM_MODE_EXCL_USER;
>>   +    if (attr->exclude_host)
>> +        config->mode |= ETM_MODE_EXCL_HOST;
>> +
>> +    if (attr->exclude_guest)
>> +        config->mode |= ETM_MODE_EXCL_GUEST;
>> +
>>       /* Always start from the default config */
>>       etm4_set_default_config(config);
>>   diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h
>> b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 20e2e4cb7614..3f170599822f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -841,7 +841,7 @@ enum etm_impdef_type {
>>    * @s_ex_level: Secure ELs where tracing is supported.
>>    */
>>   struct etmv4_config {
>> -    u32                mode;
>> +    u64                mode;
>>       u32                pe_sel;
>>       u32                cfg;
>>       u32                eventctrl0;
>> diff --git a/drivers/hwtracing/coresight/coresight-priv.h
>> b/drivers/hwtracing/coresight/coresight-priv.h
>> index 767076e07970..727dd27ba800 100644
>> --- a/drivers/hwtracing/coresight/coresight-priv.h
>> +++ b/drivers/hwtracing/coresight/coresight-priv.h
>> @@ -39,6 +39,9 @@
>>     #define ETM_MODE_EXCL_KERN    BIT(30)
>>   #define ETM_MODE_EXCL_USER    BIT(31)
>> +#define ETM_MODE_EXCL_HOST    BIT(32)
>> +#define ETM_MODE_EXCL_GUEST    BIT(33)
>> +
>>   struct cs_pair_attribute {
>>       struct device_attribute attr;
>>       u32 lo_off;
> 
