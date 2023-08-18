Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953CE780778
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358764AbjHRIvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358757AbjHRIud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:50:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79AD23A96;
        Fri, 18 Aug 2023 01:50:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC4ED75;
        Fri, 18 Aug 2023 01:51:08 -0700 (PDT)
Received: from [10.57.4.78] (unknown [10.57.4.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC253F762;
        Fri, 18 Aug 2023 01:50:26 -0700 (PDT)
Message-ID: <99811457-740c-69a0-7662-dbe24fa2a1c1@arm.com>
Date:   Fri, 18 Aug 2023 09:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V3 1/3] coresight: etm: Override TRCIDR3.CCITMIN on errata
 affected cpus
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230811034600.944386-1-anshuman.khandual@arm.com>
 <20230811034600.944386-2-anshuman.khandual@arm.com>
 <CAJ9a7Vgd8C_yGa7aoppGHuNhHMzD=7+yjLHU9X4=NJ2CDJA+mQ@mail.gmail.com>
 <9b9d8928-ab4a-990e-9391-41657f5a54ae@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9b9d8928-ab4a-990e-9391-41657f5a54ae@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 09:45, Anshuman Khandual wrote:
> 
> 
> On 8/11/23 14:33, Mike Leach wrote:
>> Hi Anshuman,
>>
>> A few minor points.
>>
>> On Fri, 11 Aug 2023 at 04:46, Anshuman Khandual
>> <anshuman.khandual@arm.com> wrote:
>>>
>>> This work arounds errata 1490853 on Cortex-A76, and Neoverse-N1, errata
>>> 1491015 on Cortex-A77, errata 1502854 on Cortex-X1, and errata 1619801 on
>>> Neoverse-V1, based affected cpus, where software read for TRCIDR3.CCITMIN
>>> field in ETM gets an wrong value.
>>>
>>> If software uses the value returned by the TRCIDR3.CCITMIN register field,
>>> then it will limit the range which could be used for programming the ETM.
>>> In reality, the ETM could be programmed with a much smaller value than what
>>> is indicated by the TRCIDR3.CCITMIN field and still function correctly.
>>>
>>> If software reads the TRCIDR3.CCITMIN register field, corresponding to the
>>> instruction trace counting minimum threshold, observe the value 0x100 or a
>>> minimum cycle count threshold of 256. The correct value should be 0x4 or a
>>> minimum cycle count threshold of 4.
>>>
>>> This work arounds the problem via storing 4 in drvdata->ccitmin on affected
>>> systems where the TRCIDR3.CCITMIN has been 256, thus preserving cycle count
>>> threshold granularity.
>>>
>>> These errata information has been updated in arch/arm64/silicon-errata.rst,
>>> but without their corresponding configs because these have been implemented
>>> directly in the driver.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Cc: James Clark <james.clark@arm.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: coresight@lists.linaro.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>   Documentation/arch/arm64/silicon-errata.rst   | 10 +++++
>>>   .../coresight/coresight-etm4x-core.c          | 37 +++++++++++++++++++
>>>   2 files changed, 47 insertions(+)
>>>
>>> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
>>> index bedd3a1d7b42..b08f33eda5f1 100644
>>> --- a/Documentation/arch/arm64/silicon-errata.rst
>>> +++ b/Documentation/arch/arm64/silicon-errata.rst
>>> @@ -107,6 +107,10 @@ stable kernels.
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>> +| ARM            | Cortex-A76      | #1490853        | N/A                         |
>>> ++----------------+-----------------+-----------------+-----------------------------+
>>> +| ARM            | Cortex-A77      | #1491015        | N/A                         |
>>> ++----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
>>> @@ -125,6 +129,8 @@ stable kernels.
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>> +| ARM            | Cortex-X1       | #1502854        | N/A                         |
>>> ++----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
>>> @@ -133,6 +139,8 @@ stable kernels.
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Neoverse-N1     | #1349291        | N/A                         |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>> +| ARM            | Neoverse-N1     | #1490853        | N/A                         |
>>> ++----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
>>> @@ -141,6 +149,8 @@ stable kernels.
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>> +| ARM            | Neoverse-V1     | #1619801        | N/A                         |
>>> ++----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | MMU-500         | #841119,826419  | N/A                         |
>>>   +----------------+-----------------+-----------------+-----------------------------+
>>>   | ARM            | MMU-600         | #1076982,1209401| N/A                         |
>>
>> Could these doc changes not go in patch 3?
> 
> As Suzuki had explained earlier, will keep this errata documentation here in this patch.
> 
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> index 703b6fcbb6a5..1f3d29a639ff 100644
>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>> @@ -1150,6 +1150,31 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
>>>          drvdata->trfcr = trfcr;
>>>   }
>>>
>>> +/*
>>> + * The following errata on applicable cpu rangess affect the CCITMIN filed
>>
>> s/rangess/ranges
> 
> Fixed.
> 
>>
>>> + * in TCRIDR3 register. Software read for the field returns 0x100 limiting
>>> + * the cycle threshold granularity, where as the right value should have
>>> + * been 0x4, which is well supported in the hardware.
>>> + */
>>> +static struct midr_range etm_wrong_ccitmin_cpus[] = {
>>> +       /* Erratum #1490853 - Cortex-A76 */
>>> +       MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 4, 0),
>>> +       /* Erratum #1490853 - Neoverse-N1 */
>>> +       MIDR_RANGE(MIDR_NEOVERSE_N1, 0, 0, 4, 0),
>>> +       /* Erratum #1491015 - Cortex-A77 */
>>> +       MIDR_RANGE(MIDR_CORTEX_A77, 0, 0, 1, 0),
>>> +       /* Erratum #1502854 - Cortex-X1 */
>>> +       MIDR_REV(MIDR_CORTEX_X1, 0, 0),
>>> +       /* Erratum #1619801 - Neoverse-V1 */
>>> +       MIDR_REV(MIDR_NEOVERSE_V1, 0, 0),
>>> +       {},
>>> +};
>>> +
>>> +static bool etm4_work_around_wrong_ccitmin(void)
>>
>> This is not the actual work around - perhaps this should be
>> etm4_core_reads_wrong_ccitmin()?
> 
> Sounds better, will rename the function.

Or even move the drvdata->ccitmin == 256 check to this function,
pass in the drvdata as an argument. That way, the function
completes its meaning. i.e., it reads wrong value only if the value
is 256.

Suzuki

