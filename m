Return-Path: <linux-kernel+bounces-117436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF76C88AB68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B51FA1EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9506CDC0;
	Mon, 25 Mar 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1JI8kZm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4D42058;
	Mon, 25 Mar 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382796; cv=none; b=ixENszgLuyfiH5UohuuSbkQ1EdUjVXnHAvxwrKzrQubrHknbNOKMepduwBVP+iAf7/NjmvQ6kuSYaexha7FRX8wVjd/WzBDnrVx+XffDY1FJ6pcRiT2lBmlL427JUnI7Pzwq4bjIpCB6WN0/0W+MfRaTODgKoK2X6jhxC2LULuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382796; c=relaxed/simple;
	bh=y/3hWyLLYdwPd2H6MxfXXqvOBBuPeOJ3qFta2ANbAcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDiIa+5ErKZIQcahrzjjUlCBmcF+b1tceMxJfH00nDUq4Z0Dlw8OgjawfBDe/vjjXQhwe8trcN12n3+Rbo2lh/sTo7bRW5QBIG/rowRNqL0zh7edPUDjDciz5d0DzyvS95YOhZ9GVRtSDsJH/B00z79TehQ8riuYIjKNZwMnGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1JI8kZm; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711382794; x=1742918794;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y/3hWyLLYdwPd2H6MxfXXqvOBBuPeOJ3qFta2ANbAcg=;
  b=I1JI8kZmsNotHvNJZWkRsRdWQ2KIQH6p+QrlDXUjABoaB68Cd8q7UZYB
   VRN3wijuyD+ix8j9P7Eiuckn1yMSj5tdLmqVwRIS1KvQ3cfETbLxueOds
   ytkjXlmm0qdBvZNB2e769DLXeTFqWJrUkveTrp5yC1mx66h4zx0Pt75sX
   pVq05X9XcDQQZ7l0ml7I9QvLQ9rAI1B7YneQGwB8sygz7nKqh1PM4SuXX
   fucYYIaLlpBSygypzWW4ud1leD850z4cV3lGL+FPdV82WeSGoophwS/YW
   UvwD4NCAojkVa+0XnvtpyaIrNZtJqAu3wP8oIkCLhOMaTXSkZEhmwBN+M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6256092"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6256092"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="20125309"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.211.155])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:06:28 -0700
Message-ID: <b91bc272-1524-4d14-9c73-dfbb334e8951@intel.com>
Date: Mon, 25 Mar 2024 18:06:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf intel-pt: Fix memory sanitizer
 use-of-uninitialized-value
To: Ian Rogers <irogers@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Liam Howlett <liam.howlett@oracle.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
References: <20240320162619.1272015-1-irogers@google.com>
 <CAP-5=fU0XQ_F2Bax0fzPMtP9BQv3XaNuiGWKQMRQ7g54yzM8xQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fU0XQ_F2Bax0fzPMtP9BQv3XaNuiGWKQMRQ7g54yzM8xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/24 17:44, Ian Rogers wrote:
> On Wed, Mar 20, 2024 at 9:26 AM Ian Rogers <irogers@google.com> wrote:
>>
>> Running the test "Miscellaneous Intel PT testing" with a build with
>> -fsanitize=memory and -fsanitize-memory-track-origins I saw:
>>
>> ```
>> ==1257749==WARNING: MemorySanitizer: use-of-uninitialized-value
>>     #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c:1527:17
>>     #1 0x5581c00c5cf6 in intel_pt_run_decoder tools/perf/util/intel-pt.c:2961:3
>>     #2 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util/intel-pt.c:3074:4
>>     #3 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.c:3482:10
>>     #4 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace.c:2830:9
>>     #5 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/session.c:1649:8
>>     #6 0x5581bfba1d7f in perf_session__process_event tools/perf/util/session.c:1891:9
>>     #7 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
>>     #8 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:2381:14
>>     #9 0x5581bfbad942 in reader__process_events tools/perf/util/session.c:2430:8
>>     #10 0x5581bfb78256 in __perf_session__process_events tools/perf/util/session.c:2477:8
>>     #11 0x5581bfb702c4 in perf_session__process_events tools/perf/util/session.c:2643:9
>>     #12 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
>>     #13 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
>>     #14 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
>>     #15 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
>>     #16 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
>>     #17 0x5581bf669d2d in main tools/perf/perf.c:561:3
>>
>>   Uninitialized value was stored to memory at
>>     #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1256:25
>>     #1 0x5581c001a932 in intel_pt_walk_fup tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:1428:9
>>     #2 0x5581c000f76c in intel_pt_walk_trace tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:3299:10
>>     #3 0x5581c000899b in intel_pt_decode tools/perf/util/intel-pt-decoder/intel-pt-decoder.c:3988:10
>>     #4 0x5581c00c5180 in intel_pt_run_decoder tools/perf/util/intel-pt.c:2941:11
>>     #5 0x5581c00968f8 in intel_pt_process_timeless_queues tools/perf/util/intel-pt.c:3074:4
>>     #6 0x5581c007cf49 in intel_pt_process_event tools/perf/util/intel-pt.c:3482:10
>>     #7 0x5581bffa269a in auxtrace__process_event tools/perf/util/auxtrace.c:2830:9
>>     #8 0x5581bfb826c0 in perf_session__deliver_event tools/perf/util/session.c:1649:8
>>     #9 0x5581bfba1d7f in perf_session__process_event tools/perf/util/session.c:1891:9
>>     #10 0x5581bfba82e4 in process_simple tools/perf/util/session.c:2452:9
>>     #11 0x5581bfbabcc3 in reader__read_event tools/perf/util/session.c:2381:14
>>     #12 0x5581bfbad942 in reader__process_events tools/perf/util/session.c:2430:8
>>     #13 0x5581bfb78256 in __perf_session__process_events tools/perf/util/session.c:2477:8
>>     #14 0x5581bfb702c4 in perf_session__process_events tools/perf/util/session.c:2643:9
>>     #15 0x5581bf2da266 in __cmd_script tools/perf/builtin-script.c:2855:8
>>     #16 0x5581bf2bfcdd in cmd_script tools/perf/builtin-script.c:4402:8
>>     #17 0x5581bf67004b in run_builtin tools/perf/perf.c:350:11
>>     #18 0x5581bf66b8ea in handle_internal_command tools/perf/perf.c:403:8
>>     #19 0x5581bf66f527 in run_argv tools/perf/perf.c:447:2
>> ```
>>
>> Adding a curly brace initializer for the intel_pt_insn in
>> intel_pt_walk_fup rectifies this, however, there may be other issues
>> lurking behind this so initialize all similar instances.
>>
>> Fixes: f4aa081949e7 ("perf tools: Add Intel PT decoder")
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Adrian, could you take a look at this for the sake of tests passing with msan.

I did have a look, but I found msan so slow and full of errors
that it never gave any results.

However, it is easy enough to instrument some debugging which is
what I am still looking at.

Just initializing intel_pt_insn is not quite right, so I need
to check things a bit more.

> 
> Thanks,
> Ian
> 
>> ---
>>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> index b450178e3420..b4a95af2e4cc 100644
>> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
>> @@ -1115,7 +1115,7 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
>>   */
>>  static void intel_pt_sample_fup_insn(struct intel_pt_decoder *decoder)
>>  {
>> -       struct intel_pt_insn intel_pt_insn;
>> +       struct intel_pt_insn intel_pt_insn = {};
>>         uint64_t max_insn_cnt, insn_cnt = 0;
>>         int err;
>>
>> @@ -1418,7 +1418,7 @@ static inline bool intel_pt_fup_with_nlip(struct intel_pt_decoder *decoder,
>>
>>  static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
>>  {
>> -       struct intel_pt_insn intel_pt_insn;
>> +       struct intel_pt_insn intel_pt_insn = {};
>>         uint64_t ip;
>>         int err;
>>
>> @@ -1461,7 +1461,7 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
>>
>>  static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
>>  {
>> -       struct intel_pt_insn intel_pt_insn;
>> +       struct intel_pt_insn intel_pt_insn = {};
>>         int err;
>>
>>         err = intel_pt_walk_insn(decoder, &intel_pt_insn, 0);
>> @@ -1626,7 +1626,7 @@ static int intel_pt_emulated_ptwrite(struct intel_pt_decoder *decoder)
>>
>>  static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
>>  {
>> -       struct intel_pt_insn intel_pt_insn;
>> +       struct intel_pt_insn intel_pt_insn = {};
>>         int err;
>>
>>         while (1) {
>> --
>> 2.44.0.291.gc1ea87d7ee-goog
>>


