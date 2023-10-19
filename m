Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF67CFC85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346108AbjJSO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbjJSO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:28:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1DB134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697725738; x=1729261738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V/kslxMcngujt96Vh/coI6ImjBlQYF9tepCmAIzXbNc=;
  b=lhHWFPnbX6fi804PUsnpW7VdGRJCb+sRPyvpijH8JVcXq6pqT+PBldoG
   ZG9VmBCk3JxTZ1cGvquF82SehaQ9WB2v2zAPcgT1ZbeOndqOvS8l92oKg
   EMlTsGKqrFPClug6u3v2WcnbqtsHSdS1f1xYIbIw9bPzuMAEcrBCTW5yK
   AKCweYv1yhxcYQn6ko+TlP/Stg+4RI4B2qEbqoWHqzzjDWB36ZT9cEMrA
   sV2Wuph+817aDL9Ea3SXWAi4xANcwWIt1L6JIQE/Xh9pBDHV/CUcyo3VF
   g74q92BUvI2pTjHwF5pi7U1zxtAKQWeEGYNlH/zMLi3qMezVP6jFZgVLX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="417381381"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="417381381"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="900767998"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="900767998"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 07:26:49 -0700
Received: from [10.212.5.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EA539580BE3;
        Thu, 19 Oct 2023 07:28:53 -0700 (PDT)
Message-ID: <6850dc71-e709-42ce-9113-9cb5a7a590f7@linux.intel.com>
Date:   Thu, 19 Oct 2023 10:28:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
 <20231019110056.GH36211@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019110056.GH36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 7:00 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +static ssize_t branch_counter_width_show(struct device *cdev,
>> +					 struct device_attribute *attr,
>> +					 char *buf)
>> +{
>> +	return snprintf(buf, PAGE_SIZE, "2\n");
>> +}
> 
>> +#define ARCH_LBR_EVENT_LOG_WIDTH	2
> 
> I'm assuming this is the same '2' ? And having it hard-coded in two
> locations is awesome..
> 
>> +#define ARCH_LBR_EVENT_LOG_MASK		0x3
> 
> Should probably be ((1<<2)-1)
> 
> As per that other email, the naming is confusing, should this not be:
> 
> ARCH_LBR_EVENT_COUNTER_BITS
> 
> or, since it's all local to lbr.c something shorter still, like:
> 
> LBR_COUNTER_BITS
> 
> hmm?

Sure, I will use the name LBR_COUNTER_BITS.

Thanks,
Kan
