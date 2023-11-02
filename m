Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C327DEF00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbjKBJf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 05:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjKBJf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 05:35:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E943133;
        Thu,  2 Nov 2023 02:35:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D9E12F4;
        Thu,  2 Nov 2023 02:36:03 -0700 (PDT)
Received: from [10.57.70.106] (unknown [10.57.70.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A813F67D;
        Thu,  2 Nov 2023 02:35:19 -0700 (PDT)
Message-ID: <e519b424-0a4b-34b1-c9e8-069c058f031f@arm.com>
Date:   Thu, 2 Nov 2023 09:35:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] coresight: etm4x: Fix width of CCITMIN field
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     stable@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231030102940.115078-1-james.clark@arm.com>
 <afc147f5-4bf5-4d8f-88de-df6067b8ab52@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <afc147f5-4bf5-4d8f-88de-df6067b8ab52@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2023 04:14, Anshuman Khandual wrote:
> 
> 
> On 10/30/23 15:59, James Clark wrote:
>> CCITMIN is a 12 bit field and doesn't fit in a u8, so extend it to u16.
>> This probably wasn't an issue previously because values higher than 255
>> never occurred.
>>
>> But since commit 0f55b43dedcd ("coresight: etm: Override TRCIDR3.CCITMIN
>> on errata affected cpus"), a comparison with 256 was done to enable the
>> errata, generating the following W=1 build error:
>>
>>    coresight-etm4x-core.c:1188:24: error: result of comparison of
>>    constant 256 with expression of type 'u8' (aka 'unsigned char') is
>>    always false [-Werror,-Wtautological-constant-out-of-range-compare]
>>
>>     if (drvdata->ccitmin == 256)
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 20e2e4cb7614..da17b6c49b0f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -1036,7 +1036,7 @@ struct etmv4_drvdata {
>>   	u8				ctxid_size;
>>   	u8				vmid_size;
>>   	u8				ccsize;
>> -	u8				ccitmin;
>> +	u16				ccitmin;
>>   	u8				s_ex_level;
>>   	u8				ns_ex_level;
>>   	u8				q_support;
> 
> Thanks James, so this takes care of the Smatch static checker
> warning as reported by Dan Carpenter earlier.
> 

I didn't see that report, but it was in "[linux-next:master]
BUILD REGRESSION c503e3eec382ac708ee7adf874add37b77c5d312"

> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
