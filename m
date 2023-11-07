Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E447E485C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjKGSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGSgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:36:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50680B9;
        Tue,  7 Nov 2023 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699382201; x=1730918201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=niQ8FAZVB7tsHM0LZXi5A+2Rr2dzc9RtaVvyV81wfiw=;
  b=h8Z4lKZSQmtZhnCBjXDw/pRo0S/U7h+T/2s6S4U/FcRQZ4gb0ikZjBCy
   pZHa1cim3L/BJfen0dQRjLfHW7XYjyYpCChDhYmDTZojQhzWwgs/LwX1Q
   UKYiRYYI6t6D8Xo5NshDte1OHRdRw4RLGeqmDSFnBoux/2dL+axRRo0NC
   njU/DPE6l2wnLmVJcg7+NQ/1Y3Wq3LaN2ZgOpC8Th0W9cuXOxLeVJ1Smp
   Dys/iPKxht3EJM0fm91LEXFkN2dcdhy0ALu1IeeRTCHRRbXopJayUlWVP
   c4xGSF+SNiz0x5bI9ELCn0oPWszASjnBNBdGMhDjXPz3H3+ULKNRld9Hu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="386761366"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="386761366"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:36:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="1094232376"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="1094232376"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 10:36:40 -0800
Received: from [10.209.174.91] (kliang2-mobl1.ccr.corp.intel.com [10.209.174.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B83DC580D9B;
        Tue,  7 Nov 2023 10:36:38 -0800 (PST)
Message-ID: <eff62fd6-10f4-4548-8fab-c6c56338be66@linux.intel.com>
Date:   Tue, 7 Nov 2023 13:36:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Basic branch counter support
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, tinghao.zhang@intel.com
References: <20231107174411.1496958-1-kan.liang@linux.intel.com>
 <CAP-5=fWjXS43xBujQ2DOAeo41WX5L4hfTfJVEV8h6i1Uu2HBEA@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fWjXS43xBujQ2DOAeo41WX5L4hfTfJVEV8h6i1Uu2HBEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-11-07 1:05 p.m., Ian Rogers wrote:
> On Tue, Nov 7, 2023 at 9:44 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Add a basic test for the branch counter feature.
>>
>> The test verifies that
>> - The new filter can be successfully applied on the supported platforms.
>> - The counter value can be outputted via the perf report -D
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks Kan!
> 
>> ---
>>  tools/perf/tests/shell/record.sh | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 4fbc74805d52..2783e867c07c 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -11,6 +11,9 @@ err=0
>>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>>  testprog="perf test -w thloop"
>>  testsym="test_loop"
>> +cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
>> +br_cntr_file="/caps/branch_counter_nr"
>> +br_cntr_output="branch stack counters"
>>
>>  cleanup() {
>>    rm -rf "${perfdata}"
>> @@ -154,10 +157,37 @@ test_workload() {
>>    echo "Basic target workload test [Success]"
>>  }
>>
>> +test_branch_counter() {
>> +  echo "Basic branch counter test"
>> +  # Check if the branch counter feature is supported
> 
> If $cpu_pmu_dir is empty, e.g. ARM and S390, this should also skip.
> 

Yes, I've tested with a fake unsupported dir. The test case is skipped
as well.

>> +  for dir in $cpu_pmu_dir
>> +  do
>> +    if [ ! -e "$dir$br_cntr_file" ]
>> +    then
>> +      echo "Not support branch counter feature [Skipped]"
> 
> Perhaps here it'd be clearer to output:
> echo "branch counter feature not supported on all core PMUs ($dir) [Skipped]"
> 

Sure, I will change it in V2.

Thanks,
Kan

> Thanks,
> Ian
> 
>> +      return
>> +    fi
>> +  done
>> +  if ! perf record -o "${perfdata}" -j any,counter ${testprog} 2> /dev/null
>> +  then
>> +    echo "Basic branch counter test [Failed record]"
>> +    err=1
>> +    return
>> +  fi
>> +  if ! perf report -i "${perfdata}" -D -q | grep -q "$br_cntr_output"
>> +  then
>> +    echo "Basic branch record test [Failed missing output]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Basic branch counter test [Success]"
>> +}
>> +
>>  test_per_thread
>>  test_register_capture
>>  test_system_wide
>>  test_workload
>> +test_branch_counter
>>
>>  cleanup
>>  exit $err
>> --
>> 2.35.1
>>
> 
