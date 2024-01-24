Return-Path: <linux-kernel+bounces-36714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4C83A55D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759F61F21520
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C672182D8;
	Wed, 24 Jan 2024 09:24:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629418E1A;
	Wed, 24 Jan 2024 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088260; cv=none; b=VOpEUqTQR6cr1XQhZMvwrPrrGZoRyqWgN7IxH17wmFuAEx+kNbGX6FVl4Sxka6d4rtlvK64ji71cKQft+TbASkV+qFC3CcM53JOKFYf71h12Ppzh014svhhMwO9rXr3wXUfrRazNOnf55XBIqFiNyrSkrrNVcQ2k2swOMG/YqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088260; c=relaxed/simple;
	bh=Q6a5FvIQhKrjJBTVn7WeECsxsSrv+lamt5P5SCz3wUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgEaHbxqKWxhCxDSHOc52XrRS/7nu2SIEc9xYuCYiCqP4ZryAxnnoGtGxgWjTOPkG2DMHA6UzY1R7HAxyXBWM8ZpUSQH4l3A2myceoUVVH/rx6pJ8BpdGPbNJjkTuPr1Dbnn3GJqXzjeNcBqonXn00qwRpaQo0NHPclKcv5HwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 310C0FEC;
	Wed, 24 Jan 2024 01:25:03 -0800 (PST)
Received: from [10.57.86.221] (unknown [10.57.86.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8963F762;
	Wed, 24 Jan 2024 01:24:16 -0800 (PST)
Message-ID: <faba2e97-7e88-9dcc-756d-f256a6304836@arm.com>
Date: Wed, 24 Jan 2024 09:24:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] perf test: Skip test_arm_callgraph_fp.sh if unwinding
 isn't built in
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kajol Jain <kjain@linux.ibm.com>, Spoorthy S <spoorts2@in.ibm.com>,
 linux-kernel@vger.kernel.org
References: <20240123163903.350306-1-james.clark@arm.com>
 <20240123163903.350306-3-james.clark@arm.com>
 <CAP-5=fX4QQYNzEY7-6GyqWJTuH-RQxxc3jB5B1k8HZtDZCHmFw@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fX4QQYNzEY7-6GyqWJTuH-RQxxc3jB5B1k8HZtDZCHmFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/01/2024 17:41, Ian Rogers wrote:
> On Tue, Jan 23, 2024 at 8:39 AM James Clark <james.clark@arm.com> wrote:
>>
>> Even though this is a frame pointer unwind test, it's testing that a
>> frame pointer stack can be augmented correctly with a partial
>> Dwarf unwind. So add a feature check so that this test skips instead of
>> fails if Dwarf unwinding isn't present.
> 
> Hi James,
> 
> Is there value in testing without the partial Dwarf unwind? Presumably

Yeah I think we could add a test for just --call-graph=fp, I don't think
there is one. But that would be separate to this test, and would be
redundant if the tests are run with a dwarf unwinder present because
this test already requires the frame pointer unwinder to be correct.

> that is covered by the existing dwarf unwind test?

There is no overlap, this test test is for --call-graph=fp, and the
dwarf test is for --call-graph=dwarf

> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/dwarf-unwind.c?h=perf-tools-next
> If the issue is inlined functions I'm surprised addr2line isn't doing
> the job properly. Is there an addr2line perf script issue here?
> 

The issue isn't inlined functions, it's when the leaf frame doesn't
insert a frame pointer. In that case we use the link register to see
what the parent function of the leaf frame was and insert it into the
frame pointer stack.

Dwarf is only used in this case to confirm if the link register was
valid at that instruction.

See commit b9f6fbb for more info. Long story short this test was only
added for that feature and it requires a dwarf unwinder to pass despite
being called test_arm_callgraph_fp

> Thanks,
> Ian
> 


>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>  tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
>> index e342e6c8aa50..83b53591b1ea 100755
>> --- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
>> +++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
>> @@ -8,6 +8,12 @@ shelldir=$(dirname "$0")
>>
>>  lscpu | grep -q "aarch64" || exit 2
>>
>> +if perf version --build-options | grep HAVE_DWARF_UNWIND_SUPPORT | grep -q OFF
>> +then
>> +  echo "Skipping, no dwarf unwind support"
>> +  exit 2
>> +fi
>> +
>>  skip_test_missing_symbol leafloop
>>
>>  PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> --
>> 2.34.1
>>

