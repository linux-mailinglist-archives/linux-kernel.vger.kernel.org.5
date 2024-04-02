Return-Path: <linux-kernel+bounces-128708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854E2895E77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146BF1F23CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988C15E5AE;
	Tue,  2 Apr 2024 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl1dQTuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADF79DD4;
	Tue,  2 Apr 2024 21:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092211; cv=none; b=rLGEOvs2HF5pvWC3JI/MQl8fzH/TLWnRsc1GJrGmEO7cBE14ULK5RmoCnt1dDjc0lh1ckQJcgWOfNKHlRJwlCC9XJUEqm+lqntSKWWZ4eg6v5Sl6bLuFsqsmv54LktdaGVoz22DXvXxYLsQfrE8IXj6c92S9eLHifn4MBxL0iEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092211; c=relaxed/simple;
	bh=9FY3Z8lekHCyfNj7DyFkGw0JI0ghhBWmLt5KDKcGsxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpFhm2KgJMOlygfjhrRG9YnVCh47hKQTmcWgbqZ58zQqQVEpELCalVwwZ1DctEnEa2e6UDoBBjElYT4ZkX/ll9IZTLCv9oz4mDNctrZPFjlSgoiXVuROx9CVGAFTjsSNP8L3OZGiHRjlkE7HFqst+OCSpMp1eNnwHdZg3Dg1Qvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl1dQTuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DA4C433F1;
	Tue,  2 Apr 2024 21:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712092210;
	bh=9FY3Z8lekHCyfNj7DyFkGw0JI0ghhBWmLt5KDKcGsxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gl1dQTuNSaoO9NLCFkHmf4amzd1l1DDZL+TybgrYPuP/yCNRS0CqEuoDKL5BICIq3
	 k9BiAmJPPfalVgr7nlc8JoYtODAiSEUr+hTs8aVbtpG1Hm4gSgttRg0kss33Bh6tq+
	 hfIKj6Ajzi0DcNwuZFPPggt8F7HQHRUtarxvYQCjtnsSpKsdUSZ6CRDUnC5haX+6XD
	 dr+yeNJCuuAQqZlEeknLXEnIfKF0Egmb/gV69QoLFJS+jZQ1mVW5vCZaA5j4d/SEUq
	 RYPR13/AeWXRmFuFduZPR5DnZ9Vs75Qdd9qyyfXGmYcCw7fKXEknPKW+mvCNZqIlBm
	 QFrFX4Bk3XJ6w==
Date: Tue, 2 Apr 2024 18:10:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Yang Jihong <yangjihong@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf evsel: Use evsel__name_is() helper
Message-ID: <Zgx0Lwq_MIcRN9r5@x1>
References: <20240401062724.1006010-1-yangjihong@bytedance.com>
 <20240401062724.1006010-3-yangjihong@bytedance.com>
 <ZgxzmkCGNXLipMVg@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgxzmkCGNXLipMVg@x1>

On Tue, Apr 02, 2024 at 06:07:42PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 01, 2024 at 02:27:24PM +0800, Yang Jihong wrote:
> > Code cleanup, replace strcmp(evsel__name(evsel, {NAME})) with
> > evsel__name_is() helper.
> > 
> > No functional change.
> 
> Well, its not building:
> 
> builtin-trace.c: In function ‘cmd_trace’:
> builtin-trace.c:4919:90: error: macro "assert" passed 2 arguments, but takes just 1
>  4919 |         assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augmented_syscalls__");
>       |                                                                                          ^
> In file included from /home/acme/git/perf-tools-next/tools/include/linux/kernel.h:7,
>                  from /home/acme/git/perf-tools-next/tools/include/linux/refcount.h:42,
>                  from util/cgroup.h:6,
>                  from builtin-trace.c:29:
> /usr/include/assert.h:50: note: macro "assert" defined here
> 
> I'll fix it, but please test build things next time.
> 
> - Arnaldo
>  
> > Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-kmem.c               |  2 +-
> >  tools/perf/builtin-sched.c              |  4 +--
> >  tools/perf/builtin-script.c             |  2 +-
> >  tools/perf/builtin-trace.c              |  4 +--
> >  tools/perf/tests/evsel-roundtrip-name.c |  4 +--
> >  tools/perf/tests/parse-events.c         | 39 +++++++++----------------
> >  6 files changed, 22 insertions(+), 33 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index 9714327fd0ea..6fd95be5032b 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -1408,7 +1408,7 @@ static int __cmd_kmem(struct perf_session *session)
> >  	}
> >  
> >  	evlist__for_each_entry(session->evlist, evsel) {
> > -		if (!strcmp(evsel__name(evsel), "kmem:mm_page_alloc") &&
> > +		if (evsel__name_is(evsel, "kmem:mm_page_alloc") &&
> >  		    evsel__field(evsel, "pfn")) {
> >  			use_pfn = true;
> >  			break;
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 1bfb22347371..0fce7d8986c0 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -2148,7 +2148,7 @@ static bool is_idle_sample(struct perf_sample *sample,
> >  			   struct evsel *evsel)
> >  {
> >  	/* pid 0 == swapper == idle task */
> > -	if (strcmp(evsel__name(evsel), "sched:sched_switch") == 0)
> > +	if (evsel__name_is(evsel, "sched:sched_switch"))
> >  		return evsel__intval(evsel, sample, "prev_pid") == 0;
> >  
> >  	return sample->pid == 0;
> > @@ -2375,7 +2375,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
> >  	}
> >  
> >  	if (sched->idle_hist) {
> > -		if (strcmp(evsel__name(evsel), "sched:sched_switch"))
> > +		if (!evsel__name_is(evsel, "sched:sched_switch"))
> >  			rc = true;
> >  		else if (evsel__intval(evsel, sample, "prev_pid") != 0 &&
> >  			 evsel__intval(evsel, sample, "next_pid") != 0)
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 37088cc0ff1b..cc981531ec00 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -3471,7 +3471,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
> >  
> >  			match = 0;
> >  			evlist__for_each_entry(session->evlist, pos) {
> > -				if (!strcmp(evsel__name(pos), evname)) {
> > +				if (evsel__name_is(pos, evname)) {
> >  					match = 1;
> >  					break;
> >  				}
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 90eaff8c0f6e..9b93807a1906 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -4902,7 +4902,7 @@ int cmd_trace(int argc, const char **argv)
> >  		goto out;
> >  	}
> >  	trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
> > -	assert(!strcmp(evsel__name(trace.syscalls.events.bpf_output), "__augmented_syscalls__"));
> > +	assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augmented_syscalls__");


This:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cdb64ed243c416bf..e5fef39c34bf40ff 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4916,7 +4916,7 @@ int cmd_trace(int argc, const char **argv)
                goto out;
        }
        trace.syscalls.events.bpf_output = evlist__last(trace.evlist);
-       assert(evsel__name_is(trace.syscalls.events.bpf_output), "__augmented_syscalls__");
+       assert(evsel__name_is(trace.syscalls.events.bpf_output, "__augmented_syscalls__"));
 skip_augmentation:
 #endif
        err = -1;
⬢[acme@toolbox perf-tools-next]$

> >  skip_augmentation:
> >  #endif
> >  	err = -1;
> > @@ -4959,7 +4959,7 @@ int cmd_trace(int argc, const char **argv)
> >  	 */
> >  	if (trace.syscalls.events.bpf_output) {
> >  		evlist__for_each_entry(trace.evlist, evsel) {
> > -			bool raw_syscalls_sys_exit = strcmp(evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
> > +			bool raw_syscalls_sys_exit = evsel__name_is(evsel, "raw_syscalls:sys_exit");
> >  
> >  			if (raw_syscalls_sys_exit) {
> >  				trace.raw_augmented_syscalls = true;
> > diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
> > index 15ff86f9da0b..1922cac13a24 100644
> > --- a/tools/perf/tests/evsel-roundtrip-name.c
> > +++ b/tools/perf/tests/evsel-roundtrip-name.c
> > @@ -37,7 +37,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
> >  					continue;
> >  				}
> >  				evlist__for_each_entry(evlist, evsel) {
> > -					if (strcmp(evsel__name(evsel), name)) {
> > +					if (!evsel__name_is(evsel, name)) {
> >  						pr_debug("%s != %s\n", evsel__name(evsel), name);
> >  						ret = TEST_FAIL;
> >  					}
> > @@ -71,7 +71,7 @@ static int perf_evsel__name_array_test(const char *const names[], int nr_names)
> >  			continue;
> >  		}
> >  		evlist__for_each_entry(evlist, evsel) {
> > -			if (strcmp(evsel__name(evsel), names[i])) {
> > +			if (!evsel__name_is(evsel, names[i])) {
> >  				pr_debug("%s != %s\n", evsel__name(evsel), names[i]);
> >  				ret = TEST_FAIL;
> >  			}
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index feb5727584d1..0b70451451b3 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -470,8 +470,7 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "mem:0:u"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:u"));
> >  
> >  	return test__checkevent_breakpoint(evlist);
> >  }
> > @@ -484,8 +483,7 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "mem:0:x:k"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:x:k"));
> >  
> >  	return test__checkevent_breakpoint_x(evlist);
> >  }
> > @@ -498,8 +496,7 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "mem:0:r:hp"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:r:hp"));
> >  
> >  	return test__checkevent_breakpoint_r(evlist);
> >  }
> > @@ -512,8 +509,7 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "mem:0:w:up"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:w:up"));
> >  
> >  	return test__checkevent_breakpoint_w(evlist);
> >  }
> > @@ -526,8 +522,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "mem:0:rw:kp"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "mem:0:rw:kp"));
> >  
> >  	return test__checkevent_breakpoint_rw(evlist);
> >  }
> > @@ -540,8 +535,7 @@ static int test__checkevent_breakpoint_modifier_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "breakpoint"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
> >  
> >  	return test__checkevent_breakpoint(evlist);
> >  }
> > @@ -554,8 +548,7 @@ static int test__checkevent_breakpoint_x_modifier_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "breakpoint"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
> >  
> >  	return test__checkevent_breakpoint_x(evlist);
> >  }
> > @@ -568,8 +561,7 @@ static int test__checkevent_breakpoint_r_modifier_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "breakpoint"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
> >  
> >  	return test__checkevent_breakpoint_r(evlist);
> >  }
> > @@ -582,8 +574,7 @@ static int test__checkevent_breakpoint_w_modifier_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "breakpoint"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
> >  
> >  	return test__checkevent_breakpoint_w(evlist);
> >  }
> > @@ -596,8 +587,7 @@ static int test__checkevent_breakpoint_rw_modifier_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
> >  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> >  	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "breakpoint"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint"));
> >  
> >  	return test__checkevent_breakpoint_rw(evlist);
> >  }
> > @@ -609,12 +599,12 @@ static int test__checkevent_breakpoint_2_events(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> >  
> >  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> > -	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint1"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint1"));
> >  
> >  	evsel = evsel__next(evsel);
> >  
> >  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_BREAKPOINT == evsel->core.attr.type);
> > -	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "breakpoint2"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "breakpoint2"));
> >  
> >  	return TEST_OK;
> >  }
> > @@ -691,15 +681,14 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
> >  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> >  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> >  	TEST_ASSERT_VAL("wrong config", test_config(evsel, 1));
> > -	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "krava"));
> >  
> >  	/* cpu/config=2/u" */
> >  	evsel = evsel__next(evsel);
> >  	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
> >  	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
> >  	TEST_ASSERT_VAL("wrong config", test_config(evsel, 2));
> > -	TEST_ASSERT_VAL("wrong name",
> > -			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
> > +	TEST_ASSERT_VAL("wrong name", evsel__name_is(evsel, "cpu/config=2/u"));
> >  
> >  	return TEST_OK;
> >  }
> > -- 
> > 2.25.1

