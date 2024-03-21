Return-Path: <linux-kernel+bounces-110095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9198B8859F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05369B21708
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD0184A4D;
	Thu, 21 Mar 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4ba6nGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E784038;
	Thu, 21 Mar 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027899; cv=none; b=fP3MTomaM0+ftVnzSUAWg3BlOSOauEJN1vgO9d2UrYJxegC2UDHnsxXH5f824v6QpcW+cnu3RYlWAKokpY8rfrPvwmjGSWWABysOU2GsDndFnxw8rJAVnda7fO9n+bEimuquJC7Kb/+z33bDS7lr8SNHWgvdi7GVhCc5CX954vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027899; c=relaxed/simple;
	bh=Bh4EodqFgM9nVjjSAVSZ8P+J632vjPhrdTO1Ck6PnDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7HGD+deP52WQzHRgUDJlCYZ+E7JTkXSusVHqQcqcE9KQbMA4zGIXlXEO56keeXGYuUCocMl6+yw8x0JlfVzuDY38zbCQ5YzOBhJ8TGQ6T6qSr8u0vu9pBLwjH9D67NqlXP+7tD1Ag6uDThaRali4N2mvWb+knFinYyo7B91jWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4ba6nGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B83C433C7;
	Thu, 21 Mar 2024 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711027898;
	bh=Bh4EodqFgM9nVjjSAVSZ8P+J632vjPhrdTO1Ck6PnDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4ba6nGSLR9ekjdt5fUr9wKSr/Ci/1VVVgCadYKFoAWoo0g1LJlJQYm1ipbRF3Zyz
	 IvYiCE71CAeMN3z89D2P5/b3VL9L7PLp/LiSX/CnYgs4xR+Fd8OHsuwnui5fMTjwvw
	 AwUXU3Z/C0euGjKcHDsZ5GYsTaP0BmzwdqctpvmwoWH6zOdFOP+2EUBmDc6E3Va1g/
	 hZRBbDw1TFmKuwV99DRURh843IzQhBMMjBpuAXhGBd1/7KvNgLTw1BJDwQKwVXRg+w
	 32aHENbvsyDngp7DYRzt9VZwERXy9XCBLsClND60m99vP1h1k+S4hsDTWdSguntpa0
	 /u4ktpVYhMdDA==
Date: Thu, 21 Mar 2024 10:31:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] perf list: Give more details about raw event
 encodings
Message-ID: <Zfw2tR6R-Uvf6ity@x1>
References: <20240308001915.4060155-1-irogers@google.com>
 <20240308001915.4060155-5-irogers@google.com>
 <CAP-5=fVE3f-Q3Zcdi2qWb5EJSadp5c7xbhzWeq8PFw2NOZEEJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVE3f-Q3Zcdi2qWb5EJSadp5c7xbhzWeq8PFw2NOZEEJw@mail.gmail.com>

On Wed, Mar 20, 2024 at 07:59:06PM -0700, Ian Rogers wrote:
> On Thu, Mar 7, 2024 at 4:19 PM Ian Rogers <irogers@google.com> wrote:
> >
> > List all the PMUs, not just the first core one, and list real format
> > specifiers with value ranges.
> >
> > Before:
> > ```
> > $ perf list
> > ...
> >   rNNN                                               [Raw hardware event descriptor]
> >   cpu/t1=v1[,t2=v2,t3 ...]/modifier                  [Raw hardware event descriptor]
> >        [(see 'man perf-list' on how to encode it)]
> >   mem:<addr>[/len][:access]                          [Hardware breakpoint]
> > ...
> > ```
> >
> > After:
> > ```
> > $ perf list
> > ...
> >   rNNN                                               [Raw event descriptor]
> >   cpu/event=0..255,pc,edge,.../modifier              [Raw event descriptor]
> >        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
> >   breakpoint//modifier                               [Raw event descriptor]
> >   cstate_core/event=0..0xffffffffffffffff/modifier   [Raw event descriptor]
> >   cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw event descriptor]
> >   i915/i915_eventid=0..0x1fffff/modifier             [Raw event descriptor]
> >   intel_bts//modifier                                [Raw event descriptor]
> >   intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw event descriptor]
> >   kprobe/retprobe/modifier                           [Raw event descriptor]
> >   msr/event=0..0xffffffffffffffff/modifier           [Raw event descriptor]
> >   power/event=0..255/modifier                        [Raw event descriptor]
> >   software//modifier                                 [Raw event descriptor]
> >   tracepoint//modifier                               [Raw event descriptor]
> >   uncore_arb/event=0..255,edge,inv,.../modifier      [Raw event descriptor]
> >   uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw event descriptor]
> >   uncore_clock/event=0..255/modifier                 [Raw event descriptor]
> >   uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw event descriptor]
> >   uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw event descriptor]
> >   mem:<addr>[/len][:access]                          [Hardware breakpoint]
> > ...
> > ```
> >
> > With '--details' provide more details on the formats encoding:
> > ```
> >   cpu/event=0..255,pc,edge,.../modifier              [Raw event descriptor]
> >        [(see 'man perf-list' or 'man perf-record' on how to encode it)]
> >         cpu/event=0..255,pc,edge,offcore_rsp=0..0xffffffffffffffff,ldlat=0..0xffff,inv,
> >         umask=0..255,frontend=0..0xffffff,cmask=0..255,config=0..0xffffffffffffffff,
> >         config1=0..0xffffffffffffffff,config2=0..0xffffffffffffffff,config3=0..0xffffffffffffffff,
> >         name=string,period=number,freq=number,branch_type=(u|k|hv|any|...),time,
> >         call-graph=(fp|dwarf|lbr),stack-size=number,max-stack=number,nr=number,inherit,no-inherit,
> >         overwrite,no-overwrite,percore,aux-output,aux-sample-size=number/modifier
> >   breakpoint//modifier                               [Raw event descriptor]
> >         breakpoint//modifier
> >   cstate_core/event=0..0xffffffffffffffff/modifier   [Raw event descriptor]
> >         cstate_core/event=0..0xffffffffffffffff/modifier
> >   cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw event descriptor]
> >         cstate_pkg/event=0..0xffffffffffffffff/modifier
> >   i915/i915_eventid=0..0x1fffff/modifier             [Raw event descriptor]
> >         i915/i915_eventid=0..0x1fffff/modifier
> >   intel_bts//modifier                                [Raw event descriptor]
> >         intel_bts//modifier
> >   intel_pt/ptw,event,cyc_thresh=0..15,.../modifier   [Raw event descriptor]
> >         intel_pt/ptw,event,cyc_thresh=0..15,pt,notnt,branch,tsc,pwr_evt,fup_on_ptw,cyc,noretcomp,
> >         mtc,psb_period=0..15,mtc_period=0..15/modifier
> >   kprobe/retprobe/modifier                           [Raw event descriptor]
> >         kprobe/retprobe/modifier
> >   msr/event=0..0xffffffffffffffff/modifier           [Raw event descriptor]
> >         msr/event=0..0xffffffffffffffff/modifier
> >   power/event=0..255/modifier                        [Raw event descriptor]
> >         power/event=0..255/modifier
> >   software//modifier                                 [Raw event descriptor]
> >         software//modifier
> >   tracepoint//modifier                               [Raw event descriptor]
> >         tracepoint//modifier
> >   uncore_arb/event=0..255,edge,inv,.../modifier      [Raw event descriptor]
> >         uncore_arb/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
> >   uncore_cbox/event=0..255,edge,inv,.../modifier     [Raw event descriptor]
> >         uncore_cbox/event=0..255,edge,inv,umask=0..255,cmask=0..31/modifier
> >   uncore_clock/event=0..255/modifier                 [Raw event descriptor]
> >         uncore_clock/event=0..255/modifier
> >   uncore_imc_free_running/event=0..255,umask=0..255/modifier[Raw event descriptor]
> >         uncore_imc_free_running/event=0..255,umask=0..255/modifier
> >   uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier[Raw event descriptor]
> >         uprobe/ref_ctr_offset=0..0xffffffff,retprobe/modifier
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.c          | 61 +++++++++++++++++++++-
> >  tools/perf/util/pmu.h          |  3 ++
> >  tools/perf/util/pmus.c         | 94 ++++++++++++++++++++++++++++++++++
> >  tools/perf/util/pmus.h         |  1 +
> >  tools/perf/util/print-events.c | 20 +-------
> >  5 files changed, 160 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 24be587e3537..e24bc3b8f696 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -1603,6 +1603,61 @@ bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name)
> >         return false;
> >  }
> >
> > +int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb)
> > +{
> > +       static const char *const terms[] = {
> > +               "config=0..0xffffffffffffffff",
> > +               "config1=0..0xffffffffffffffff",
> > +               "config2=0..0xffffffffffffffff",
> > +               "config3=0..0xffffffffffffffff",
> > +               "name=string",
> > +               "period=number",
> > +               "freq=number",
> > +               "branch_type=(u|k|hv|any|...)",
> > +               "time",
> > +               "call-graph=(fp|dwarf|lbr)",
> > +               "stack-size=number",
> > +               "max-stack=number",
> > +               "nr=number",
> > +               "inherit",
> > +               "no-inherit",
> > +               "overwrite",
> > +               "no-overwrite",
> > +               "percore",
> > +               "aux-output",
> > +               "aux-sample-size=number",
> > +       };
> > +       struct perf_pmu_format *format;
> > +       int ret;
> > +
> > +       /*
> > +        * max-events and driver-config are missing above as are the internal
> > +        * types user, metric-id, raw, legacy cache and hardware. Assert against
> > +        * the enum parse_events__term_type so they are kept in sync.
> > +        */
> > +       _Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6);
> 
> For C11 it is required that a 2nd message argument be passed:
> https://en.cppreference.com/w/c/language/_Static_assert
> 
> This line needs to be something like:
> _Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6,
> "Unexpected array size");
> 
> Let me know if we I should send a fix, resend all the patches or if
> you can fix in tmp.perf-tools-next.

I added this, no need to resend.

- Arnaldo

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e24bc3b8f696a9f5..81952c6cd3c6f5e8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1635,7 +1635,8 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_call
 	 * types user, metric-id, raw, legacy cache and hardware. Assert against
 	 * the enum parse_events__term_type so they are kept in sync.
 	 */
-	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6);
+	_Static_assert(ARRAY_SIZE(terms) == __PARSE_EVENTS__TERM_TYPE_NR - 6,
+		       "perf_pmu__for_each_format()'s terms must be kept in sync with enum parse_events__term_type");
 	list_for_each_entry(format, &pmu->format, list) {
 		perf_pmu_format__load(pmu, format);
 		ret = cb(state, format->name, (int)format->value, format->bits);

