Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE6E7C9DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjJPDSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJPDSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:18:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A2F3AD
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:18:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD961FB;
        Sun, 15 Oct 2023 20:19:00 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6A7C3F64C;
        Sun, 15 Oct 2023 20:18:18 -0700 (PDT)
Message-ID: <7306df46-82e3-4fb8-ac76-1cb2f26783d9@arm.com>
Date:   Mon, 16 Oct 2023 08:48:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver: perf: arm_pmuv3: Identify 'event->attr.config1'
 based attributes
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20231009051753.179355-1-anshuman.khandual@arm.com>
 <ZSlKgGtrhsoWCDGT@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZSlKgGtrhsoWCDGT@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/23 19:17, Mark Rutland wrote:
> On Mon, Oct 09, 2023 at 10:47:53AM +0530, Anshuman Khandual wrote:
>> This defines macros to identify long and rdpmc attributes which get carried
>> inside 'event->attr.config1', thus making the code explicit and clear.
>>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.6-rc5.
>>
>>  drivers/perf/arm_pmuv3.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)

I am not sure, if I understand your concerns and/or suggestions properly.

> 
> I think this would make sense to do if we also used a common definition of
> these bits in the helper functions *and* their format attributes, but as-is

Common definitions of sysfs formats ? Which helper - linux/perf/arm_pmuv3.h ?

> this does nothing to relate the two, and I don't think that it improves
> legibility on its own.

Currently armv8pmu_event_is_64bit() and armv8pmu_event_want_user_access()
extracts required values from 'event->attr.config1' with hard coded masks
without any explicit co-relation with PMU_FORMAT_ATTR() described formats
above, unless some one really looks into the config1 bits layout.

Could you please provide some more details on how to go about making this
change better.

> 
> Mark.
> 
>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 94723d00548e..797ffd5a8fed 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -298,16 +298,19 @@ PMU_FORMAT_ATTR(event, "config:0-15");
>>  PMU_FORMAT_ATTR(long, "config1:0");
>>  PMU_FORMAT_ATTR(rdpmc, "config1:1");
>>  
>> +#define ARM_PMUV3_ATTR_LONG	0x01
>> +#define ARM_PMUV3_ATTR_RDPMC	0x02
>> +
>>  static int sysctl_perf_user_access __read_mostly;
>>  
>>  static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
>>  {
>> -	return event->attr.config1 & 0x1;
>> +	return event->attr.config1 & ARM_PMUV3_ATTR_LONG;
>>  }
>>  
>>  static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
>>  {
>> -	return event->attr.config1 & 0x2;
>> +	return event->attr.config1 & ARM_PMUV3_ATTR_RDPMC;
>>  }
>>  
>>  static struct attribute *armv8_pmuv3_format_attrs[] = {
>> -- 
>> 2.25.1
>>
