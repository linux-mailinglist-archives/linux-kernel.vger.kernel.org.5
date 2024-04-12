Return-Path: <linux-kernel+bounces-142229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8958A2936
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CEB2826A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EAF5027B;
	Fri, 12 Apr 2024 08:22:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87964502B2;
	Fri, 12 Apr 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910152; cv=none; b=kSBsiAb43wNcm5OxH24qu9hDz4rC5x87QsEHxiVB9h2gRPjLc/vNNyD4S2AoFDLjaLEfLBPnkSQVJi6IEjdTHHQwPwpxB70SvTpQfDUaaaOt0ziaLDHG8fkjfXXdv8yE7fvaVxzg5Ol7vysRTIpS90PaWy2AwTJjuieNlLpbA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910152; c=relaxed/simple;
	bh=peYTgt9uBIcWrdPc00owGJXHu/yjGHl8jXUFuJL+vS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flWnQfM8oNMNuQ9u3K/o5XT3Jq6Iq0cX92ktP6Irgbb1RU/ygnveF9aQsEb9TEZDQqqMtR/0rvfFsUYU9ORqx/8jzzwgj4danT6svOasXeTJK38MnPM8kph9wVc0NBuL8zKb8//jLLZBM/bSe004BPgQuoA19YSGWiKYM9kRZzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16402339;
	Fri, 12 Apr 2024 01:22:58 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069173F6C4;
	Fri, 12 Apr 2024 01:22:26 -0700 (PDT)
Message-ID: <7f5c32dd-edc6-4b53-9cdd-780756f5536c@arm.com>
Date: Fri, 12 Apr 2024 09:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Increase buffer size for Coresight basic tests
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-perf-users@vger.kernel.org
Cc: Mike Leach <mike.leach@linaro.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240326113749.257250-1-james.clark@arm.com>
 <5a4023aa-af9b-48d2-84f3-a0b9b30dc54e@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <5a4023aa-af9b-48d2-84f3-a0b9b30dc54e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/04/2024 08:04, Anshuman Khandual wrote:
> 
> 
> On 3/26/24 17:07, James Clark wrote:
>> These tests record in a mode that includes kernel trace but look for
>> samples of a userspace process. This makes them sensitive to any kernel
>> compilation options that increase the amount of time spent in the
>> kernel. If the trace buffer is completely filled before userspace is
>> reached then the test will fail. Double the buffer size to fix this.
> 
> This is a valid concern to address, but just wondering how did we arrive
> at the conclusion that doubling the buffer size i.e making that 8M will
> solve the problem positively for vast number of kerne build scenarios ?
> 

Nobody else has reported anything yet, if it happens again we can always
increase it again if that is what the issue is. I had most of the kernel
debugging stuff turned on like memory debugging etc, which is probably
why I ran into it and 8MB fixed it for me. So I'm not sure if there is
much more that could be added.

>>
>> The other tests in the same file aren't sensitive to this for various
>> reasons, for example the iterate devices test filters by userspace
>> trace only. But in order to keep coverage of all the modes, increase the
>> buffer size rather than filtering by userspace for the basic tests.
>>
>> Fixes: d1efa4a0a696 ("perf cs-etm: Add separate decode paths for timeless and per-thread modes")
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/shell/test_arm_coresight.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
>> index 65dd85207125..3302ea0b9672 100755
>> --- a/tools/perf/tests/shell/test_arm_coresight.sh
>> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
>> @@ -188,7 +188,7 @@ arm_cs_etm_snapshot_test() {
>>  
>>  arm_cs_etm_basic_test() {
>>  	echo "Recording trace with '$*'"
>> -	perf record -o ${perfdata} "$@" -- ls > /dev/null 2>&1
>> +	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
>>  
>>  	perf_script_branch_samples ls &&
>>  	perf_report_branch_samples ls &&

