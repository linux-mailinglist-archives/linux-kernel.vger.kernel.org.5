Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC37CD847
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjJRJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjJRJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:36:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D73102
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:36:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F2732F4;
        Wed, 18 Oct 2023 02:37:15 -0700 (PDT)
Received: from [10.57.3.139] (unknown [10.57.3.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750DD3F64C;
        Wed, 18 Oct 2023 02:36:33 -0700 (PDT)
Message-ID: <bc4a0623-16bc-199a-957c-e167a629e582@arm.com>
Date:   Wed, 18 Oct 2023 10:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: etm4x: Enable ETE device accessed via MMIO
To:     Ruidong Tian <tianruidong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org
References: <20231018070506.65320-1-tianruidong@linux.alibaba.com>
 <f7ccb9c4-60f4-7037-085d-3f36ae024219@arm.com>
 <206d5b79-dcd8-05b7-86c8-d6fb5790439e@linux.alibaba.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <206d5b79-dcd8-05b7-86c8-d6fb5790439e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 18/10/2023 10:30, Ruidong Tian wrote:
> Hi Suzuki,
> 
> Now ETM4X driver use MMIO or system instruction depends on this check in 
> function etm4_init_csdev_access:
> 
>          if (drvdata->base)
>                  return etm4_init_iomem_access(drvdata, csa);
> 
> This check always true if firmware provides a address range in ACPI
> table of ETE, and as a result, the ETE device in this case cannot be
> successfully probed.
> 
> I think OS should be compatible with this situation, no matter firmware
> how to organize ETE information in ACPI table. How do you feel about
> it?

My question is not about "What the patch does". But, why can't we use
system instructions on your system, when ETE was designed to be used
with that in the first place and get rid of the MMIO.

Suzuki

> 
> Thank you
> 
> Ruidong Tian
> 在 2023/10/18 16:28, Suzuki K Poulose 写道:
>> On 18/10/2023 08:05, Ruidong Tian wrote:
>>> The ETM4X driver now assume that all ETE as CPU system instructions
>>> accessed device, in fact the ETE device on some machines also accessed
>>> via MMIO.
>>>
>>> Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
>>
>> Why are we going backwards to MMIO from system instructions ? Is it 
>> because of an "unfriendly" hypervisor preventing access ?
>>
>> As such, without a sufficiently acceptable explanation, I am reluctant
>> to make this change
>>
>> Suzuki
>>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
>>> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index 285539104bcc..ad298c9cc87e 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -1103,8 +1103,9 @@ static bool etm4_init_iomem_access(struct 
>>> etmv4_drvdata *drvdata,
>>>        * with MMIO. But we cannot touch the OSLK until we are
>>>        * sure this is an ETM. So rely only on the TRCDEVARCH.
>>>        */
>>> -    if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
>>> -        pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
>>> +    if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH &&
>>> +        (devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETE_ARCH) {
>>> +        pr_warn_once("TRCDEVARCH doesn't match ETMv4/ETE 
>>> architecture\n");
>>>           return false;
>>>       }

