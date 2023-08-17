Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC27E77F820
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351596AbjHQN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351603AbjHQNzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:55:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA8192D56
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:55:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CFD3D75;
        Thu, 17 Aug 2023 06:56:22 -0700 (PDT)
Received: from [10.57.34.77] (unknown [10.57.34.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4816C3F6C4;
        Thu, 17 Aug 2023 06:55:40 -0700 (PDT)
Message-ID: <70fa68e9-d8e0-fefa-4f25-421c09b8243a@arm.com>
Date:   Thu, 17 Aug 2023 14:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] coresight: tmc: Make etr buffer mode user configurable
 from sysfs
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        Steve Clevenger <scclevenger@os.amperecomputing.com>
References: <20230728084837.276551-1-anshuman.khandual@arm.com>
 <a34eff4b-37f2-5b96-7be1-9e32c04dd4e0@arm.com>
 <7c19feb3-6311-64e7-83d2-58be07cee7ad@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <7c19feb3-6311-64e7-83d2-58be07cee7ad@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 06:39, Anshuman Khandual wrote:
> 
> 
> On 8/11/23 20:03, Suzuki K Poulose wrote:
>> On 28/07/2023 09:48, Anshuman Khandual wrote:
>>> Currently TMC-ETR automatically selects the buffer mode from all available
>>> methods in the following sequentially fallback manner - also in that order.
>>>
>>> 1. FLAT mode with or without IOMMU
>>> 2. TMC-ETR-SG (scatter gather) mode when available
>>> 3. CATU mode when available
>>>
>>> But this order might not be ideal for all situations. For example if there
>>> is a CATU connected to ETR, it may be better to use TMC-ETR scatter gather
>>> method, rather than CATU.
>>
>> The statement is wrong.
>>
>> But hard coding such order changes will prevent
> 
>>> us from testing or using a particular mode. This change provides following
>>> new sysfs tunables for the user to control TMC-ETR buffer mode explicitly,
>>> if required.
>>>
>>> /sys/bus/coresight/devices/tmc_etr<N>/etr_buf_modes_available
>>> /sys/bus/coresight/devices/tmc_etr<N>/etr_buf_mode_current
>>
>> Given this only appears for TMC-ETR, could this be simple :
>>
>> available_buf_modes and
>>
>> preferred_buf_mode.
> 
> Make sense, will drop 'etr' from these sysfs file names, and update the documentation
> as required. But Mike Leach had suggested earlier to have common sub strings right at
> the beginning for both these sysfs file names. Hence will just keep them in the same
> format i.e
> 
> * buf_modes_available
> * buf_mode_preferred	(as you are suggesting to replace 'current' with 'preferred')
> 
>>
>> We should fall back to the auto logic to use an appropriate mode
>> if the "perferred" mode cannot satisfy the request. (e.g., flat mode
>> with a large buffer. This may be possible on a system without much
>> load).
> 
> That's a semantics change from the current proposal, which does not try to fallback on
> anything, in case the requested buffer mode does not work. Instead it expects the user
> to try a different buffer mode in such cases.

True, but I prefer a fallback to something works mode, given there are
different ways this can be used and leaving the control in an unusable
state is not ideal.


> 
>>
>>> $ cat etr_buf_modes_available
>>> auto flat tmc-sg catu    ------------------> Supported TMC-ETR buffer modes
>>> $ echo catu > etr_buf_mode_current -------> Explicit buffer mode request
>>>
>>> But explicit user request has to be within supported ETR buffer modes only.
>>> These sysfs interface files are exclussive to ETR, and hence not available
>>> for other TMC devices such as ETB or ETF etc.
>>
>>
>>   This required separating out
>>> new 'coresight_etr_groups' from common 'coresight_tmc_groups'.
>>
>> strip this, you don't need implementation commentary.
>>
>>>
>>> This adds a new element 'etr_mode' in 'struct tmc_drvdata' which will track
>>> such explicit user directives.
>>
>> this too.
> 
> Although I could understand not mentioning about refactoring 'coresight_tmc_groups', is
> not this comment necessary in explaining why 'tmc_drvdata' structure is expanded here ?

Not needed, instead the code and the comment in the structure is self 
explanatory.

> 
>>
>>   'auto' mode has been added to help fallback
>>> to the existing default behaviour.
>>
>>
>> ETR_MODE_FLAT mode availability follows
>>> existing logic as in tmc_alloc_etr_buf() creating a common helper function
>>> i.e etr_supports_flat_mode().
>>
>> this too.
> 
> I believe parts of the comments above in the commit message are still important but
> will try and reorganize them better for clarity.
> 
>>
>>>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: Leo Yan <leo.yan@linaro.org>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    .../testing/sysfs-bus-coresight-devices-tmc   |  16 +++
>>>    .../hwtracing/coresight/coresight-tmc-core.c  | 103 +++++++++++++++++-
>>>    .../hwtracing/coresight/coresight-tmc-etr.c   |  27 +++--
>>>    drivers/hwtracing/coresight/coresight-tmc.h   |  10 ++
>>>    4 files changed, 143 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>> index 6aa527296c71..956a2f090950 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
>>> @@ -91,3 +91,19 @@ Contact:    Mathieu Poirier <mathieu.poirier@linaro.org>
>>>    Description:    (RW) Size of the trace buffer for TMC-ETR when used in SYSFS
>>>            mode. Writable only for TMC-ETR configurations. The value
>>>            should be aligned to the kernel pagesize.
>>> +
>>> +What:        /sys/bus/coresight/devices/<memory_map>.tmc/etr_buf_modes_available
>>> +Date:        July 2023
>>> +KernelVersion:    6.6
>>> +Contact:    Anshuman Khandual <anshuman.khandual@arm.com>
>>> +Description:    (Read) Shows all supported Coresight TMC-ETR buffer modes available
>>> +        for the users to configure explicitly. This file is avaialble only
>>> +        for TMC ETR devices.
>>> +
>>> +What:        /sys/bus/coresight/devices/<memory_map>.tmc/etr_buf_mode_current
>>> +Date:        July 2023
>>> +KernelVersion:    6.6
>>> +Contact:    Anshuman Khandual <anshuman.khandual@arm.com>
>>> +Description:    (RW) Current Coresight TMC-ETR buffer mode selected. But user could
>>> +        only provide a mode which is supported for a given ETR device. This
>>> +        file is available only for TMC ETR devices.
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> index c106d142e632..ce97ff5e0997 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
>>> @@ -10,6 +10,7 @@
>>>    #include <linux/device.h>
>>>    #include <linux/idr.h>
>>>    #include <linux/io.h>
>>> +#include <linux/iommu.h>
>>>    #include <linux/err.h>
>>>    #include <linux/fs.h>
>>>    #include <linux/miscdevice.h>
>>> @@ -329,6 +330,85 @@ static ssize_t buffer_size_store(struct device *dev,
>>>      static DEVICE_ATTR_RW(buffer_size);
>>>    +static const char *const buf_modes_str[] = {
>>> +    [ETR_MODE_FLAT]        = "flat",
>>> +    [ETR_MODE_ETR_SG]    = "tmc-sg",
>>> +    [ETR_MODE_CATU]        = "catu",
>>> +    [ETR_MODE_AUTO]        = "auto",
>>> +};
>>> +
>>> +void get_etr_buf_hw(struct device *dev, struct etr_buf_hw *buf_hw)
>>> +{
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +
>>> +    buf_hw->has_iommu = iommu_get_domain_for_dev(dev->parent);
>>> +    buf_hw->has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>>> +    buf_hw->has_catu = !!tmc_etr_get_catu_device(drvdata);
>>> +}
>>> +
>>> +bool etr_supports_flat_mode(struct etr_buf_hw *buf_hw, ssize_t etr_buf_size)
>>> +{
>>> +    bool has_sg = buf_hw->has_catu || buf_hw->has_etr_sg;
>>> +
>>> +    return !has_sg || buf_hw->has_iommu || etr_buf_size < SZ_1M;
>>> +}
>>> +
>>
>> Flat mode is always supported and the user must be allowed to "prefer"
>> it. This logic can be applied to the "auto mode" though and should be
>> renamed to
>>
>> etr_can_use_flat_mode(buf_hw, size)
> 
> Sure, will rename the function here but not sure if I understand this completely.
> Are you suggesting anything else which needs to be done here ?

My point is, this helper must be only used for "auto" mode. Not
for etr_mode == flat. If the user requests "flat" try it (without
checking the size required) and let it fallthrough to the auto mode.

> 
>>
>>
>>
>>> +static ssize_t etr_buf_modes_available_show(struct device *dev,
>>> +                        struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    struct etr_buf_hw buf_hw;
>>> +    ssize_t size = 0;
>>> +
>>> +    get_etr_buf_hw(dev, &buf_hw);
>>> +    size += sysfs_emit(buf, "%s ", buf_modes_str[ETR_MODE_AUTO]);
>>> +    if (etr_supports_flat_mode(&buf_hw, drvdata->size))
>>> +        size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_FLAT]);
>>
>> Always supported and must be available
> 
> But if etr_can_use_flat_mode() returns negative, should it still be shown here as
> an option at all ? Could flat mode be offered for buffer mode preference, if it

The point is the check is made on a "size" that is set via sysfs. For 
perf mode we may get a size from the perf handle. It doesn't make sense
for denying the option based on the size.

As I said above, "flat" mode is always supported and let the user select
it (irrespective of the size) and try it (without checking the size).

So, we don't need the check here, instead it can be used for the "auto" 
mode only.


> cannot be used as determined via etr_can_use_flat_mode().
> 
>>
>>> +
>>> +    if (buf_hw.has_etr_sg)
>>> +        size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_ETR_SG]);
>>> +
>>> +    if (buf_hw.has_catu)
>>> +        size += sysfs_emit_at(buf, size, "%s ", buf_modes_str[ETR_MODE_CATU]);
>>> +
>>> +    size += sysfs_emit_at(buf, size, "\n");
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_RO(etr_buf_modes_available);
>>> +
>>> +static ssize_t etr_buf_mode_current_show(struct device *dev,
>>> +                     struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +
>>> +    return sysfs_emit(buf, "%s\n", buf_modes_str[drvdata->etr_mode]);
>>> +}
>>> +
>>> +static ssize_t etr_buf_mode_current_store(struct device *dev,
>>> +                      struct device_attribute *attr,
>>> +                      const char *buf, size_t size)
>>> +{
>>> +    struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +    struct etr_buf_hw buf_hw;
>>> +
>>> +    get_etr_buf_hw(dev, &buf_hw);
>>> +    if (sysfs_streq(buf, buf_modes_str[ETR_MODE_FLAT]) &&
>>> +        etr_supports_flat_mode(&buf_hw, drvdata->size))
>>
>> Please remove this check, given the input is a "preference"
> 
> But could flat mode be accepted for preference, if it cannot be used as determined
> via etr_can_use_flat_mode() ?

As explained above, can_use_flat_mode() only for auto mode.

> 
>>
>>> +        drvdata->etr_mode = ETR_MODE_FLAT;
>>> +    else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_ETR_SG]) && buf_hw.has_etr_sg)
>>> +        drvdata->etr_mode = ETR_MODE_ETR_SG;
>>> +    else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_CATU]) && buf_hw.has_catu)
>>> +        drvdata->etr_mode = ETR_MODE_CATU;
>>> +    else if (sysfs_streq(buf, buf_modes_str[ETR_MODE_AUTO]))
>>> +        drvdata->etr_mode = ETR_MODE_AUTO;
>>> +    else
>>> +        return -EINVAL;
>>> +
>>> +    return size;
>>> +
>>> +}
>>> +static DEVICE_ATTR_RW(etr_buf_mode_current);
>>> +
>>>    static struct attribute *coresight_tmc_attrs[] = {
>>>        &dev_attr_trigger_cntr.attr,
>>>        &dev_attr_buffer_size.attr,
>>> @@ -350,6 +430,24 @@ static const struct attribute_group *coresight_tmc_groups[] = {
>>>        NULL,
>>>    };
>>>    +static struct attribute *coresight_etr_attrs[] = {
>>> +    &dev_attr_trigger_cntr.attr,
>>> +    &dev_attr_buffer_size.attr,
>>
>> Why don't we reuse the tmc_attrs in the etr_groups ? That way,
>> it is much cleaner and easy to reason about. Also rename the
> 
> I suppose you are suggesting to reuse coresight_tmc_group[] to bring in both 'trigger_cntr'
> and 'buffer_size' sysfs files for the ETR listing. Following change does what is required.
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index ad0efa528731..c8d108dd39d8 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -431,8 +431,6 @@ static const struct attribute_group *coresight_tmc_groups[] = {
>   };
>   
>   static struct attribute *coresight_etr_attrs[] = {
> -       &dev_attr_trigger_cntr.attr,
> -       &dev_attr_buffer_size.attr,
>          &dev_attr_buf_modes_available.attr,
>          &dev_attr_buf_mode_preferred.attr,
>          NULL,
> @@ -444,6 +442,7 @@ static const struct attribute_group coresight_etr_group = {
>   
>   static const struct attribute_group *coresight_etr_groups[] = {
>          &coresight_etr_group,
> +       &coresight_tmc_group,
>          &coresight_tmc_mgmt_group,
>          NULL,
>   };

Yes

> 
>> coresight_tmc_groups => coresight_etf_groups (inline with
>> the driver file name, coresight-tmc-etf.c )
> 
> Sure, will do that.
> 
>>
>>
>>> +    &dev_attr_etr_buf_modes_available.attr,
>>> +    &dev_attr_etr_buf_mode_current.attr,
>>> +    NULL,
>>> +};
>>> +
>>> +static const struct attribute_group coresight_etr_group = {
>>> +    .attrs = coresight_etr_attrs,
>>> +};
>>> +
>>> +static const struct attribute_group *coresight_etr_groups[] = {
>>> +    &coresight_etr_group,
>>
>> and add:
>>
>>   +    &coresight_tmc_group,
> 
> Right, included in the change set as suggested.
> 
>>
>>> +    &coresight_tmc_mgmt_group,
>>> +    NULL,
>>> +};
>>> +
>>
>> All of the above functions and the coresight_etr_group and related attributes could live in coresight-tmc-etr.c and we could simply
>> expose the coresight_etr_group to the tmc-core.c
>>
>> That way, the code is all contained in coresight-tmc-etr.c and
>> you don't have to expose the functions way at the bottom.
> 
> These attribute group assignments happen inside tmc_probe(), so the definitions need
> to be in the same file itself. This is applicable for both ETF and ETR. I am trying

Surely could do :

const struct attribute_group coresight_etr_group;

and  in the coresight-tmc-etr.c

static struct attribute *coresight_etr_attrs[] = {
	&dev_attr_etr_buf_modes_available.attr,
	&dev_attr_etr_buf_mode_current.attr,
};

const struct attribute_group coresight_etr_group = {
	.attrs = coresight_etr_attrs,
};


> to see how this is beneficial. Besides, this reorganization could be accomplished in
> a subsequent patch and should not be included in this proposed change IMHO.

On the other hand you are moving a lot of ETR specific functions to this
core file, which doesn't look nice. Instead, we simply make the 
coresight_etr_group global (not "exported").

> 
>>
>>>    static inline bool tmc_etr_can_use_sg(struct device *dev)
>>>    {
>>>        return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
>>> @@ -465,6 +563,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>>        drvdata->memwidth = tmc_get_memwidth(devid);
>>>        /* This device is not associated with a session */
>>>        drvdata->pid = -1;
>>> +    drvdata->etr_mode = ETR_MODE_AUTO;
>>>          if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
>>>            drvdata->size = tmc_etr_get_default_buffer_size(dev);
>>> @@ -474,16 +573,17 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>>        }
>>>          desc.dev = dev;
>>> -    desc.groups = coresight_tmc_groups;
>>>          switch (drvdata->config_type) {
>>>        case TMC_CONFIG_TYPE_ETB:
>>> +        desc.groups = coresight_tmc_groups;
>>>            desc.type = CORESIGHT_DEV_TYPE_SINK;
>>>            desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>>>            desc.ops = &tmc_etb_cs_ops;
>>>            dev_list = &etb_devs;
>>>            break;
>>>        case TMC_CONFIG_TYPE_ETR:
>>> +        desc.groups = coresight_etr_groups;
>>>            desc.type = CORESIGHT_DEV_TYPE_SINK;
>>>            desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
>>>            desc.ops = &tmc_etr_cs_ops;
>>> @@ -496,6 +596,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
>>>            dev_list = &etr_devs;
>>>            break;
>>>        case TMC_CONFIG_TYPE_ETF:
>>> +        desc.groups = coresight_tmc_groups;
>>>            desc.type = CORESIGHT_DEV_TYPE_LINKSINK;
>>>            desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>>>            desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> index 766325de0e29..d48455188243 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
>>> @@ -841,23 +841,27 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>>>                         int node, void **pages)
>>>    {
>>>        int rc = -ENOMEM;
>>> -    bool has_etr_sg, has_iommu;
>>> -    bool has_sg, has_catu;
>>>        struct etr_buf *etr_buf;
>>> +    struct etr_buf_hw buf_hw;
>>>        struct device *dev = &drvdata->csdev->dev;
>>>    -    has_etr_sg = tmc_etr_has_cap(drvdata, TMC_ETR_SG);
>>> -    has_iommu = iommu_get_domain_for_dev(dev->parent);
>>> -    has_catu = !!tmc_etr_get_catu_device(drvdata);
>>> -
>>> -    has_sg = has_catu || has_etr_sg;
>>> -
>>> +    get_etr_buf_hw(dev, &buf_hw);
>>>        etr_buf = kzalloc(sizeof(*etr_buf), GFP_KERNEL);
>>>        if (!etr_buf)
>>>            return ERR_PTR(-ENOMEM);
>>>          etr_buf->size = size;
>>>    +    /* If there is user directive for buffer mode, try that first */
>>> +    if (drvdata->etr_mode != ETR_MODE_AUTO) {
>>> +        rc = tmc_etr_mode_alloc_buf(drvdata->etr_mode, drvdata,
>>> +                        etr_buf, node, pages);
>>
>> As mentioned above we should fall back to the AUTO mode of action if the
>> above fails. Given the ETR could be used in sysfs (size via sysfs) vs
>> perf mode (size via perf aux_buf) and the sizes controlled by different
>> entities, a tunable set in the sysfs could cause failures.
>>
>> We should treat the user selection as a "preferred" mode and try that
>> first. If that is not available, we should fallback to the "auto" logic
>> (without resetting the preferred mode), skipping the "preferred" mode.
>> See below.
>>
>>
>>> +        if (rc) {
>>> +            kfree(etr_buf);
>>> +            return ERR_PTR(rc);>> +        }
>>> +    }
> 
> The suggested auto mode fallback could be achieved by just dropping off the
> above code hunk which tests 'rc' return value.
> 
>>> +
>>>        /*
>>>         * If we have to use an existing list of pages, we cannot reliably
>>>         * use a contiguous DMA memory (even if we have an IOMMU). Otherwise,
>>> @@ -870,14 +874,13 @@ static struct etr_buf *tmc_alloc_etr_buf(struct tmc_drvdata *drvdata,
>>>         * Fallback to available mechanisms.
>>>         *
>>>         */
>>> -    if (!pages &&
>>> -        (!has_sg || has_iommu || size < SZ_1M))
>>> +    if (!pages && etr_supports_flat_mode(&buf_hw, size))
>>>            rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
>>>                            etr_buf, node, pages);
>>> -    if (rc && has_etr_sg)
>>> +    if (rc && buf_hw.has_etr_sg)
>>>            rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
>>>                            etr_buf, node, pages);
>>> -    if (rc && has_catu)
>>> +    if (rc && buf_hw.has_catu)
>>>            rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
>>>                            etr_buf, node, pages);
>>
>> We could do :
>>
>>      do {
>>          if (etr_mode != ETR_MODE_FLAT &&
>>              !pages && etr_can_use_flat_mode(buf_hw, size))
>>              rc = tmc_etr_mode_alloc_buf(ETR_MODE_FLAT, drvdata,
>>                              etr_buf, node, pages);
>>          if (!rc)
>>              break;
>>          if (etr_mode != ETR_MODE_ETR_SG && buf_hw.has_etr_sg)
>>              rc = tmc_etr_mode_alloc_buf(ETR_MODE_ETR_SG, drvdata,
>>                                            etr_buf, node, pages);
>>          if (!rc)
>>              break;
>>          if (etr_mode != ETR_MODE_ETR_CATU && buf_hw.has_catu)
>>              rc = tmc_etr_mode_alloc_buf(ETR_MODE_CATU, drvdata,
>>                          etr_buf, node, pages);
>>
>>      } while (0);
> 
> I guess you meant 'etr_mode ==' in all the above conditional checks instead ? Besides,

I meant, etr_mode !=.. i.e., if the preferred mode is the same as the 
one we are trying to check, we could skip it as it already failed.

> what is benefit of converting all this into a do { } while (0) block apart from just
> those nice !rc breakouts ?

To avoid the number of gotos. Or we could do :

	if (rc && ...

Suzuki
