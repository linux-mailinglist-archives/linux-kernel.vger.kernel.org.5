Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7B7CFBD4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjJSN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbjJSN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:58:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150B126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697723914; x=1729259914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8se5bsLPsrdIbV1A1QejzTC7H8TGODO2GUXhmqAc3FM=;
  b=niPheduJkaf6bTmysp+6i4HKDb8z2I4lLE9Eje/UdJOB6CC+2Q4BZIEf
   Nk/wylCjsebORmdJchFKFduQghDvH2Yx6YaWKcI2SPtbKtJBg4+WZE1WB
   oJPKGn3z4068dzpXNUL/5f1OJqEUyW1xSKsWLd6z301K5dDVjbZMt97qn
   wqVuU814BqK5mK0XogjYD/F5Xg/2IlVz9DIIgNBcrcMNi8D5qdIblHru/
   tE5HFo7MaNDkQBEkvQ0ANCx04eF6GHP3kjtXb96sMwVAvHjYSiCHfBQ14
   9PPetqmSNAcxMCY4U5vLptTx7uov9NSurG6CLTQOVjZYRqbluQysJYpJh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390146035"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="390146035"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750515754"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="750515754"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 06:58:33 -0700
Received: from [10.212.5.13] (kliang2-mobl1.ccr.corp.intel.com [10.212.5.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B7151580D4F;
        Thu, 19 Oct 2023 06:58:31 -0700 (PDT)
Message-ID: <fa719c37-109b-4ab6-8ac0-2700430cd912@linux.intel.com>
Date:   Thu, 19 Oct 2023 09:58:30 -0400
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
 <20231019092643.GF36211@noisy.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231019092643.GF36211@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-19 5:26 a.m., Peter Zijlstra wrote:
> On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +
>>  static struct attribute *lbr_attrs[] = {
>>  	&dev_attr_branches.attr,
>> +	&dev_attr_branch_counter_nr.attr,
>> +	&dev_attr_branch_counter_width.attr,
>>  	NULL
>>  };
>>  
>> @@ -5590,7 +5665,11 @@ mem_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  static umode_t
>>  lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
>>  {
>> -	return x86_pmu.lbr_nr ? attr->mode : 0;
>> +	/* branches */
>> +	if (i == 0)
>> +		return x86_pmu.lbr_nr ? attr->mode : 0;
>> +
>> +	return (x86_pmu.flags & PMU_FL_LBR_EVENT) ? attr->mode : 0;
>>  }
> 
> As in the patch this is fairly readable, but I just checked and in the
> code lbr_attrs and lbr_is_visible() are rather far away from one another
> which makes the whole i thing hard to interpret.
> 
> Should we re-organize that a little?

Sure, I will implement a separate patch to re-organize it.

It seems there are only two attribute groups which have both .attrs and
.is_visible, group_default and group_caps_lbr. I will re-organize for
both of them.

Thanks,
Kan
