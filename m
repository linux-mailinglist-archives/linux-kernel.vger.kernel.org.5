Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B37722E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHGLlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjHGLlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:41:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5304F46BA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:38:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 578BA1FB;
        Mon,  7 Aug 2023 04:38:12 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A82633F59C;
        Mon,  7 Aug 2023 04:37:27 -0700 (PDT)
Message-ID: <177702e7-e68f-fa7a-4507-48dc82fcc030@arm.com>
Date:   Mon, 7 Aug 2023 12:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH V3 4/4] coresight: trbe: Enable ACPI based TRBE devices
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
References: <20230803055652.1322801-1-anshuman.khandual@arm.com>
 <20230803055652.1322801-5-anshuman.khandual@arm.com>
 <f6a5aaf2-4669-cbc2-1358-e8cfb341b9c5@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <f6a5aaf2-4669-cbc2-1358-e8cfb341b9c5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 05:43, Anshuman Khandual wrote:
> 
> 
> On 8/3/23 11:26, Anshuman Khandual wrote:
>> This detects and enables ACPI based TRBE devices via the dummy platform
>> device created earlier for this purpose.
>>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-trbe.c | 9 +++++++++
>>   drivers/hwtracing/coresight/coresight-trbe.h | 1 +
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index e1d9d06e7725..f884883e9018 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -1537,7 +1537,16 @@ static const struct of_device_id arm_trbe_of_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, arm_trbe_of_match);
>>   
>> +#ifdef CONFIG_ACPI
>> +static const struct platform_device_id arm_trbe_acpi_match[] = {
>> +	{ ARMV8_TRBE_PDEV_NAME, 0 },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(platform, arm_trbe_acpi_match);
>> +#endif
>> +
>>   static struct platform_driver arm_trbe_driver = {
>> +	.id_table = arm_trbe_acpi_match,
> 
> The build problem [1] reported on the first version of the series still exists
> here i.e arm_trbe_acpi_match is hidden without CONFIG_ACPI. I had assumed that
> CONFIG_CORESIGHT always enables CONFIG_ACPI, which is not the case. Following
> random config (with CONFIG_ACPI=n and CONFIG_CORESIGHT_TRBE=y) easily triggers
> the build problem.
> 
> https://download.01.org/0day-ci/archive/20230805/202308052123.uqR35d19-lkp@intel.com/config
> 
>   make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 -s -j 128
> drivers/hwtracing/coresight/coresight-trbe.c:1563:23: error: implicit declaration of function ‘ACPI_PTR’ [-Werror=implicit-function-declaration]
>   1563 |   .acpi_match_table = ACPI_PTR(arm_trbe_acpi_match),
>        |                       ^~~~~~~~
> drivers/hwtracing/coresight/coresight-trbe.c:1563:32: error: ‘arm_trbe_acpi_match’ undeclared here (not in a function); did you mean ‘arm_trbe_of_match’?
>   1563 |   .acpi_match_table = ACPI_PTR(arm_trbe_acpi_match),
>        |                                ^~~~~~~~~~~~~~~~~~~
>        |                                arm_trbe_of_match
> 
> Following config wrap around fixes the problem.
> 
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1557,7 +1557,9 @@ MODULE_DEVICE_TABLE(platform, arm_trbe_acpi_match);
>   #endif
>   
>   static struct platform_driver arm_trbe_driver = {
> +#ifdef CONFIG_ACPI
>          .id_table = arm_trbe_acpi_match,
> +#endif
>          .driver = {
>                  .name = DRVNAME,
>                  .of_match_table = of_match_ptr(arm_trbe_of_match),
> 
> Please not that unlike other coresight drivers, TRBE is not using 'acpi_device_id'
> based "acpi_match_table = ACPI_PTR" construct. But regardless, ACPI_PTR() seems to
> be an alternate (probably better) solution as well.
> 
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1557,7 +1557,7 @@ MODULE_DEVICE_TABLE(platform, arm_trbe_acpi_match);
>   #endif
>   
>   static struct platform_driver arm_trbe_driver = {
> -       .id_table = arm_trbe_acpi_match,
> +       .id_table = ACPI_PTR(arm_trbe_acpi_match),

This is preferred.

>          .driver = {
>                  .name = DRVNAME,
>                  .of_match_table = of_match_ptr(arm_trbe_of_match),
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.h b/drivers/hwtracing/coresight/coresight-trbe.h
> index 94e67009848a..fce1735d5c58 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.h
> +++ b/drivers/hwtracing/coresight/coresight-trbe.h
> @@ -7,6 +7,7 @@
>    *
>    * Author: Anshuman Khandual <anshuman.khandual@arm.com>
>    */
> +#include <linux/acpi.h>

Shouldn't this be added in trbe.c ? Does trbe.h depend on any ACPI headers ?

Suzuki
