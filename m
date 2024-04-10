Return-Path: <linux-kernel+bounces-138215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152BB89EE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F8F1C21020
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D71155392;
	Wed, 10 Apr 2024 09:08:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A85155309;
	Wed, 10 Apr 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740124; cv=none; b=jkvP/mEJubKMVJeS3+yVPSMLtKX+3m2IWmMUSMZlv2BRJJSDgWSnGX/3hCaIZJHbM6Mp9V2+tbaaLFNMqVura8Zi9tuJSM7w0ad14DmRdu5UKvFb1JbHxyXAw51HzeDClY2TCOvQF+4vixokLCgZwwvFlkJKlBRCj5oLaztAUrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740124; c=relaxed/simple;
	bh=9DAQcUP4ItBGs09MwsSQs0C/Kdjx2J14q9I1HEfNmwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LwVNsAqx4mgQGIEdt4i+Ejx6fqUx9DuGvYLG+uCpaY8q0q9mXkCqVCo7o8NuucpTVFc2aAdlYVTmxf79STYeLE6pGg+i4R47XW7lqlCUFjYAjiVtT5jJlIS8vYRZ+jLVSntIYn9JbNuLsvAE7G293T5lrHIe8YW/Hs/BMYufwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F220139F;
	Wed, 10 Apr 2024 02:09:11 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83E2E3F6C4;
	Wed, 10 Apr 2024 02:08:39 -0700 (PDT)
Message-ID: <f5a367cf-4154-498d-8985-b4d5498ff201@arm.com>
Date: Wed, 10 Apr 2024 10:08:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] perf tests: Skip "test data symbol" on Neoverse N1
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Leo Yan <leo.yan@linux.dev>,
 linux-kernel@vger.kernel.org
References: <20240409084741.405433-1-james.clark@arm.com>
 <20240409084741.405433-4-james.clark@arm.com>
 <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXRODCKJexjxqkW_Wkf5MTxFJeq8zmu-iUbpEJM-9gjgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/04/2024 16:39, Ian Rogers wrote:
> On Tue, Apr 9, 2024 at 1:48 AM James Clark <james.clark@arm.com> wrote:
>>
>> To prevent anyone from seeing a test failure appear as a regression and
>> thinking that it was caused by their code change, just skip the test on
>> N1.
>>
>> It can be caused by any unrelated change that shifts the loop into an
>> unfortunate position in the Perf binary which is almost impossible to
>> debug as the root cause of the test failure. Ultimately it's caused by
>> the referenced errata.
>>
>> Fixes: 60abedb8aa90 ("perf test: Introduce script for data symbol testing")
>> Signed-off-by: James Clark <james.clark@arm.com>
> 
> This change makes me sad :-( Is there no hope of aligning the loop? We
> have little enough testing coverage for memory events and even precise
> events on ARM that anything take away testing coverage feels like we
> should try to do better.
> 
> Which models are we losing coverage for, presumably neoverse-n1 but
> what about neoverse-v1 and neoverse-n2-v2?
> 
> If aligning the loop doesn't work, could we use objdump and check its
> alignment skipping when it is off? Or run the test and turn fails to
> skip on neoverse-n1 - so we get some coverage testing.
> 
> It would also be nice if the change didn't add a dependency on lscpu
> for the sake of parsing /proc/cpuinfo, I see another arm test already
> did this test_arm_callgraph_fp.sh - that case looks like it should be
> using uname.
> 

I'll make the change to add the noise to the loop, which will drop this
lscpu addition. And I'll fix up test_arm_callgraph_fp.sh while I'm at it.

> Thanks,
> Ian
> 
>> ---
>>  tools/perf/tests/shell/test_data_symbol.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
>> index 3dfa91832aa8..ffc641d00aa4 100755
>> --- a/tools/perf/tests/shell/test_data_symbol.sh
>> +++ b/tools/perf/tests/shell/test_data_symbol.sh
>> @@ -16,6 +16,12 @@ skip_if_no_mem_event() {
>>         return 2
>>  }
>>
>> +# Skip on Arm N1 due to errata 1694299. Bias exists in SPE sampling
>> +# which can cause the load and store instructions to be skipped
>> +# entirely. This comes and goes randomly depending on the offset the
>> +# linker places the datasym loop at in the Perf binary.
>> +lscpu | grep -q "Neoverse-N1" && exit 2
>> +
>>  skip_if_no_mem_event || exit 2
>>
>>  skip_test_missing_symbol buf1
>> --
>> 2.34.1
>>

