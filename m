Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFC78E9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjHaKNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbjHaKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:13:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9FCFA;
        Thu, 31 Aug 2023 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693476790; x=1725012790;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6wMeydwdwJo7Op9ZodxUKdYeGX1D4JWReZ6mfZiqEJQ=;
  b=cSWAQ/VXdkQjrLXTtPB9sYdYs+3R3gWbaRB8JvDhhHvItzuAGjvk/uNd
   fxnteKzspMal9naeL1Hd38VUFEiU0NZU2IRKdLZVWwcr2lpJ9NlPD/aMO
   GTUAQjRc2SHSj4pK/jS2vibD3xCKRJhnhCT9oLDKX0RGHzcxn+fI0l54W
   MEmYF+cFSYc7oi4MWESxseM7jX662SNQDnFz0Cqbqh/u0z9PJ+eWKe3Cp
   WFRLblDZijkmnfEe8q40zXeHtQC1HYHxxtShPJLm/X+kblrSmAZfPRCZD
   flgFE9NotKM5SmmXU9NCE6T0N4+aaJ9a30D5saSwtFQWoL9NZctH8M7JL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="366087236"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="366087236"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739449071"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="739449071"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.57.245])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 03:13:05 -0700
Message-ID: <603dc4b9-31ae-1525-5668-7dbb1f64420b@intel.com>
Date:   Thu, 31 Aug 2023 13:13:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v7 0/6] perf record: Track sideband events for all CPUs
 when tracing selected CPUs
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>, acme@kernel.org,
        irogers@google.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230826032608.107261-1-yangjihong1@huawei.com>
 <bcfabb85-4dc1-e642-4a82-f3b8cc009b0b@amd.com>
 <93abb0e0-1691-a887-f7b2-7591f83a8618@huawei.com>
 <929ddd1f-dc15-079c-331d-13cc5f25a1a2@amd.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <929ddd1f-dc15-079c-331d-13cc5f25a1a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/23 15:24, Ravi Bangoria wrote:
>>> Number of actual samples are same ~38K. However, the perf.data file is 5x
>>> bigger because of additional sideband data.
>>
>> Yes, if record system wide sideband data, the amount of sideband events will increase proportionally, which is expected.
>>
>>>
>>> I'm pretty sure we don't need most of those additional data. So, thinking
>>> loud, should we post-process perf.data file and filter out unnecessary data?
>>>
>>
>> I wonder if we can add a new function in perf inject.
> 
> Ok. perf inject is one option. But shall we do it bydefault in perf-record?
> It's needed only when profiling target is set of cpus, not for systemwide or
> per-process mode.
> 
>> By reading perf.data and comparing tid of SAMPLE events and sideband events, we can filter out the sideband data of unmatched tasks.
> 
> Yup. But AFAIK, perf-record keeps writing to perf.data and never does post-
> processing on it. So adding support for this will take a bit of effort. Not
> sure if we should do it as part of this series.

I agree there could be more work, but probably better for a separate patch set.

