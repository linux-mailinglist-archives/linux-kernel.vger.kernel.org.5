Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA27F72A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjKXLYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjKXLYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:24:41 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD4C410F4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:24:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C9FD1063;
        Fri, 24 Nov 2023 03:25:33 -0800 (PST)
Received: from [10.57.5.4] (unknown [10.57.5.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C05CE3F7A6;
        Fri, 24 Nov 2023 03:24:43 -0800 (PST)
Message-ID: <905087cc-9c79-0c9f-ad2a-8472bdf3ac79@arm.com>
Date:   Fri, 24 Nov 2023 11:24:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/6] coresight: Pass guest TRFCR value to KVM
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     broonie@kernel.org, Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Fuad Tabba <tabba@google.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, maz@kernel.org
References: <20231019165510.1966367-1-james.clark@arm.com>
 <20231019165510.1966367-7-james.clark@arm.com>
 <c2552b30-92ee-435b-a50c-9c34c25bc421@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <c2552b30-92ee-435b-a50c-9c34c25bc421@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/2023 19:37, Suzuki K Poulose wrote:
> On 19/10/2023 17:55, James Clark wrote:
>> Currently the userspace and kernel filters for guests are never set, so
>> no trace will be generated for them. Add support for tracing guests by
>> passing the desired TRFCR value to KVM so it can be applied to the
>> guest.
>>
>> By writing either E1TRE or E0TRE, filtering on either guest kernel or
>> guest userspace is also supported. And if both E1TRE and E0TRE are
>> cleared when exclude_guest is set, that option is supported too. This
>> change also brings exclude_host support which is difficult to add as a
>> separate commit without excess churn and resulting in no trace at all.
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
>> Guest user only (only 5 addresses because the guest runs slowly in the
>> model):
>>
>>    $ perf record -e cs_etm//Gu -a -- true
>>      5 EL0
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
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 42 ++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
>>   drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
>>   3 files changed, 40 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 77b0271ce6eb..292f9da6aeaf 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -6,6 +6,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/bitops.h>
>>   #include <linux/kernel.h>
>> +#include <linux/kvm_host.h>
>>   #include <linux/moduleparam.h>
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>> @@ -271,9 +272,22 @@ static void etm4x_prohibit_trace(struct
>> etmv4_drvdata *drvdata)
>>       /* If the CPU doesn't support FEAT_TRF, nothing to do */
>>       if (!drvdata->trfcr)
>>           return;
>> +    kvm_etm_set_guest_trfcr(0);
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
>> @@ -286,18 +300,28 @@ static void etm4x_prohibit_trace(struct
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
>> +    /* Set filters for guests and pass to KVM */
>> +    if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
>> +        trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
>> +    else
>> +        trfcr = etm4x_get_kern_user_filter(drvdata);
>> +
>> +    /* TRFCR_EL1 doesn't have CX so mask it out. */
>> +    trfcr &= ~TRFCR_EL2_CX;
> 
> Here we are using the Guest "Virtual time" for the trace, which could be
> different from that of the "host" (if the trace covers both). Thus
> correlating the trace could be difficult if someone wants to do that.
> 

I don't think it would be difficult, you need to have a perf recording
from inside the guest anyway to capture the DSO mappings and switch
events. So that recording would have the guest's time conversion event
in it.

It might require a perf change to handle two different time conversion
packets, or you'd probably just want to use the guest one anyway which
might already work. I haven't really tested it in that much detail.

> We could switch to using Physical time, for the guest trace always,
> matching the host time for correlating the events. (Assuming we are not
> a Guest Hypervisor).
> 

I think Physical time would be less useful, because eventually we want
to be able to handle things like overlapping mmaps around execs etc so
we need the virtual time.

Physical time is only good for ordering events, and the virtual time can
do that too.

One thing that we might want to do is make TRFCR_ELx_TS_VIRTUAL
configurable via a config option if you want to be able to correlate
host and guest trace together with physical time. But I think that would
be an extra change because it's already hard coded to on, and you can
already trace nVHE guests. We should probably keep this change just
about the filtering only.

> Rest looks fine to me.
> 
>> +    kvm_etm_set_guest_trfcr(trfcr);
>>   }
>>     #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>> @@ -655,6 +679,12 @@ static int etm4_parse_event_config(struct
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
> 
> nit: Some day, we should move to using the "event->attrs" directly, than
> translating them to these values.
> 

Yeah we could do that, that would be a good cleanup.

> Suzuki
> 
> 
