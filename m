Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236E76FF9E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjHDLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHDLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:47:39 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7784180;
        Fri,  4 Aug 2023 04:47:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Vp0KRY2_1691149631;
Received: from 30.240.114.112(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vp0KRY2_1691149631)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 19:47:13 +0800
Message-ID: <e67bf29d-ba43-f13c-cd93-8ec73b767c3a@linux.alibaba.com>
Date:   Fri, 4 Aug 2023 19:47:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.1
Subject: Re: [PATCH v4 2/2] perf record: Update docs regarding the maximum
 limitation of AUX area
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>
Cc:     alexander.shishkin@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, bpf@vger.kernel.org
References: <20230804072945.85731-1-xueshuai@linux.alibaba.com>
 <20230804072945.85731-3-xueshuai@linux.alibaba.com>
 <20230804084643.GA589820@leoy-yangtze.lan>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20230804084643.GA589820@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/4 16:46, Leo Yan wrote:
> On Fri, Aug 04, 2023 at 03:29:45PM +0800, Shuai Xue wrote:
>> The maximum AUX area is limited by the page size of the system. Update
>> the documentation to reflect this.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  tools/perf/Documentation/perf-record.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 680396c56bd1..b0ee7b63da0e 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -292,6 +292,9 @@ OPTIONS
>>  	Also, by adding a comma, the number of mmap pages for AUX
>>  	area tracing can be specified.
>>  
>> +	The maximum AUX area is limited by the page size of the system. For
>> +	example with 4K pages configured, the maximum is 2GiB.
>> +
> 
> This statement is incorrect as it fails to give out prerequisites.
> 
> E.g., on Arm64, for 4KiB, 16KiB or 64KiB base page size, different page
> size has different default values for MAX_ORDER.  Furthermore, MAX_ORDER
> can be set by config ARCH_FORCE_MAX_ORDER, thus we cannot arbitrarily
> say the maximum allocation size is 2GiB for 4KiB page size.
> 

Hi, Leo,

You are right, thank you for point this out.

Maybe we could consider to use a formula to present the avaliable
> maximum buffer size:
> 
>      PAGE_SIZE << MAX_ORDER
>    ( ---------------------- ) * PAGE_SIZE
>       sizeof(page_pointer)
> 
>    PAGE_SIZE << MAX_ORDER : the size of maximal physically
>    contiguous allocations, which is the maximum size can be
>    allocated by slab/slub.

I agree that a formula to present that limitation is more accurate. But as
@James commented in last v3, "Minor nit: I wouldn't expect a Perf tool user
to know what "MAX_ORDER" is", how about to keep both:

  The maximum AUX area is limited by the maximum physically contiguous memory
  allocated from slab/slub. It can be calculated with following formula:


     PAGE_SIZE << MAX_ORDER
    ( ---------------------- ) * PAGE_SIZE
       sizeof(page_pointer)

  For example with 4K pages and MAX_ORDER=10 configured, the maximum AUX area
  is 2GiB.

Thank you.

Best Regards,
Shuai


