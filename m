Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E78175B21F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjGTPOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGTPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A28BB;
        Thu, 20 Jul 2023 08:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C92D66192B;
        Thu, 20 Jul 2023 15:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA680C433C8;
        Thu, 20 Jul 2023 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866024;
        bh=dNi3pxGPfJjCfyqOiKYv3XKeqhPxPVccbSeSA7NRShs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVKBt9F2CXh3aLSukqejA1yyluENPufmbTS468PvC4z1UGLmaMdL0rdBaJKsuSnPA
         WOwwaSIa51cSFJoJrym8j0HEU64XNIOL53KJpR0rsD1TUPEZFHC2o2RxBKMY54XqU/
         cDu2g4jDqVqgnOI/y//RVaLXjUULGLtSnbcWYA43eBZR6+ye3NCAvpLckVWwhDA/DS
         4SqiLZLqXwvp5gnoXukwmee3GhD5hYMV+2D7OLk++RTPlKEGvZqoPGAPbfWFRoRTDF
         m0+IhluiABAwJ2oFF0d5dGgzrcx63w1ydo8iFEMD6lKzK2csxdLqJAawdvfQ1Oy6tr
         do0Ehth1eo97w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12B2740516; Thu, 20 Jul 2023 12:13:41 -0300 (-03)
Date:   Thu, 20 Jul 2023 12:13:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] perf scripts python: Implement add sample
 function and thread processing
Message-ID: <ZLlPJU6N1XHjWVBl@kernel.org>
References: <cover.1689718662.git.anupnewsmail@gmail.com>
 <6771dcadf7507ad8916ba2398d22f873579b0505.1689718662.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6771dcadf7507ad8916ba2398d22f873579b0505.1689718662.git.anupnewsmail@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 19, 2023 at 04:22:13AM +0530, Anup Sharma escreveu:
> The stack has been created for storing func and dso from the callchain.
> The sample has been added to a specific thread. It first checks if the
> thread exists in the Thread class. Then it call _add_sample function
> which is responsible for appending a new entry to the samples list.

At the end of the series it produces JSON output, I was expecting that
at this point you would provide a way for us to use this output and see
it rendered somewhere, can you add instructions for that in this cset
comment?

Also it isn't working when I try to see just the start of the output:

[root@five ~]# perf script firefox-gecko-converter.py | head
{
  "meta": {
    "interval": 1,
    "processType": 0,
    "product": "x86_64 GNU/Linux",
    "stackwalk": 1,
    "debug": 0,
    "gcpoison": 0,
    "asyncstack": 1,
    "startTime": 6796435.569,
Traceback (most recent call last):
  File "/var/home/acme/libexec/perf-core/scripts/python/firefox-gecko-converter.py", line 308, in trace_end
    json.dump(gecko_profile_with_meta, sys.stdout, indent=2)
  File "/usr/lib64/python3.10/json/__init__.py", line 180, in dump
    fp.write(chunk)
BrokenPipeError: [Errno 32] Broken pipe
Fatal Python error: handler_call_die: problem in Python trace event handler
Python runtime state: initialized

Current thread 0x00007fc21c0ebf40 (most recent call first):
  <no Python frame>

Extension modules: perf_trace_context (total: 1)
[root@five ~]#
 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> index ae69c0a4af13..9c4393787daa 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -156,6 +156,25 @@ class Thread:
>  		))
>  		return frame_id
>  
> +	def _add_sample(self, comm: str, stack: List[str], time_ms: Milliseconds) -> None:
> +		"""Add a timestamped stack trace sample to the thread builder.
> +		Args:
> +			comm: command-line (name) of the thread at this sample
> +			stack: sampled stack frames. Root first, leaf last.
> +			time_ms: timestamp of sample in milliseconds.
> +		"""
> +		# Ihreads may not set their names right after they are created.
> +		# Instead, they might do it later. In such situations, to use the latest name they have set.
> +		if self.comm != comm:
> +			self.comm = comm
> +
> +		prefix_stack_id = reduce(lambda prefix_id, frame: self._intern_stack
> +						(self._intern_frame(frame), prefix_id), stack, None)
> +		if prefix_stack_id is not None:
> +			self.samples.append(Sample(stack_id=prefix_stack_id,
> +									time_ms=time_ms,
> +									responsiveness=0))
> +
>  	def _to_json_dict(self) -> Dict:
>  		"""Converts current Thread to GeckoThread JSON format."""
>  		# Gecko profile format is row-oriented data as List[List],
> @@ -234,9 +253,36 @@ def process_event(param_dict: Dict) -> None:
>  	if not start_time:
>  		start_time = time_stamp
>  
> +	# Parse and append the callchain of the current sample into a stack.
> +	stack = []
> +	if param_dict['callchain']:
> +		for call in param_dict['callchain']:
> +			if 'sym' not in call:
> +				continue
> +			stack.append(f'{call["sym"]["name"]} (in {call["dso"]})')
> +		if len(stack) != 0:
> +			# Reverse the stack, as root come first and the leaf at the end.
> +			stack = stack[::-1]
> +
> +	# During perf record if -g is not used, the callchain is not available.
> +	# In that case, the symbol and dso are available in the event parameters.
> +	else:
> +		func = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
> +		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
> +		stack.append(f'{func} (in {dso})')
> +
> +	# Add sample to the specific thread.
> +	thread = tid_to_thread.get(tid)
> +	if thread is None:
> +		thread = Thread(comm=comm, pid=pid, tid=tid)
> +		tid_to_thread[tid] = thread
> +	thread._add_sample(comm=comm, stack=stack, time_ms=time_stamp)
> +
>  # Trace_end runs at the end and will be used to aggregate
>  # the data into the final json object and print it out to stdout.
>  def trace_end() -> None:
> +	threads = [thread._to_json_dict() for thread in tid_to_thread.values()]
> +
>  	# Schema: https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L305
>  	gecko_profile_with_meta = {
>  		"meta": {
> -- 
> 2.34.1
> 

-- 

- Arnaldo
