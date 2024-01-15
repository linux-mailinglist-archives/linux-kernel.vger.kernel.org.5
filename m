Return-Path: <linux-kernel+bounces-25910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4182D7F6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A601F22116
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F972208A;
	Mon, 15 Jan 2024 11:01:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25271DDC1;
	Mon, 15 Jan 2024 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4951E2F4;
	Mon, 15 Jan 2024 03:01:48 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.91.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524093F5A1;
	Mon, 15 Jan 2024 03:01:00 -0800 (PST)
Date: Mon, 15 Jan 2024 11:00:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf test hybrid failing on 14700K
Message-ID: <ZaUQaaT_Hi_c0JhO@FVFF77S0Q05N>
References: <ZYbm5L7tw7bdpDpE@kernel.org>
 <4d86f3b6-eaee-4673-bdf5-3b97c1c1ad17@linux.intel.com>
 <CAP-5=fUfJ-VBGS1D2+WM_eBu4uPGvxJ2KyD4WXzgKRCfGKHTQQ@mail.gmail.com>
 <ZZfwjG-HL5yOEh6z@FVFF77S0Q05N>
 <CAP-5=fUK+t1p0g3dKtgyP0g3oixM1G7Xm4BFneY5EMzRW_urdw@mail.gmail.com>
 <ZZ12PhUfA_wPAaRR@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWCn88KchSdQg87FRY0cpH4tVqO0UEYMhE=ioANeRBdwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWCn88KchSdQg87FRY0cpH4tVqO0UEYMhE=ioANeRBdwg@mail.gmail.com>

On Wed, Jan 10, 2024 at 08:29:18AM -0800, Ian Rogers wrote:
> On Tue, Jan 9, 2024 at 8:37 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Fri, Jan 05, 2024 at 09:21:21AM -0800, Ian Rogers wrote:
> > > While much has been done in the perf tool to work around latent issues
> > > with ARM's PMU drivers and the behavior changes they have instigated,
> > > except for 5c816728651a ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE
> > > capability") where I wrote the original version, there doesn't seem to
> > > have been progress made on the ARM PMU driver nor on ARM testing -
> > > which was why such an issue could exist for so long, across numerous
> > > Linux releases and ultimately break Hector and Martin.
> >
> > Ian, which latent issues in the PMU drivers are you referring to?
> 
> Core PMUs generally have a lookup from legacy to non-legacy event,
> from the past discussion this was missing on the problematic PMUs
> hence the sysfs versions.

I don't know what you mean there, so I think you may have the wrong end of the
stick.

All the ARM PMU drivers handle revelant PERF_EVENT_TYPE_HARDWARE events
directly; they check perf_event_attr::type, and interpret
perf_event_attr::config dependent upon this. 

For example, the Apple M1 PMU driver has a table mapping
PERF_COUNT_HW_CPU_CYCLES and PERF_COUNT_HW_INSTRUCTIONS to its native events:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/apple_m1_cpu_pmu.c?h=v6.7#n134

.. which is used by the m1_pmu_map_event() and m2_pmu_map_event() callbacks:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/apple_m1_cpu_pmu.c?h=v6.7#n485

.. which is used by __hw_perf_event_init() when called by armpmu_event_init,
which is used as the pmu::event_init() callback:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_pmu.c?h=v6.7#n443
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/arm_pmu.c?h=v6.7#n500

The sysfs events were added so that PMU-specific events (in the namespace of
the PMU's dynamic type id) could be advertised to userspace. Those weren't
added in lieu of the PERF_EVENT_TYPE_HARDWARE events.

When support for big.LITTLE was added (years prior to the introduction of the
extended HW type support), it was necessary to use those sysfs events to target
events to specific PMUs (since those used the PMU's dynamic type id, and would
only be handled by that specific PMU). Hence why Marc and Hector were using
those events on their systems.

AFAICT there's nothing missing from the drivers w.r.t. event mapping.

The problem Hector and Marc encountered was the result of a number of
interacting parts:

1) The logic in the perf tool to detect support for extended type support was
   not robust to PMUs requiring event filters and failed to detect support for
   the extended type for the Apple PMUs which require the exclude_guest filter.

2) The interpretation of 'pmu/event/' was changed to try to interpret 'event'
   as a PERF_EVENT_TYPE_HARDWARE event. For the Apple PMU, this changed the
   interpretation of 'apple_pmu_name/cycles/' and
   'apple_pmu_name/instructions/'.

3) Even in the absence of (detected) support for extended type support, the
   perf tool interpreted 'apple_pmu_name/cycles/' and
   'apple_pmu_name/instructions/' as PERF_EVENT_TYPE_HARDWARE events, but since
   it thought that the kernel didn't support the extended HW type, it didn't
   set the extended bits to target specific PMUs. Hence the kernel didn't know
   which PMUs to route the events to specifically, and those were handled by an
   arbitrary PMU which could handle PERF_EVENT_TYPE_HARDWARE events.

.. hence the issue that Hector and Marc reported with events going to a
different PMU from what they explicitly requested.

As I've said before, I think that (2) is a problem in its own right, since even
with (1) fixed, clashing event names could have different semantics, and it
would be better to have a distinct syntax for "PERF_EVENT_TYPE_HARDWARE event
on this specific PMU" vs "native event on this PMU".

> > I already pointed out that one of the problems you have claimed to be a driver
> > bug is actually due to userspace incorrectly detecting support for the extended
> > HW type, and I suggested some options which you have so far ignored:
> >
> >   https://lore.kernel.org/lkml/ZV-CUlQhlkdOzfFZ@FVFF77S0Q05N.cambridge.arm.com/
> >   https://lore.kernel.org/lkml/ZV-ItX1eMeIdo_00@FVFF77S0Q05N.cambridge.arm.com/
> 
> Those suggestions look fine but you seemed to be suggesting testing.

I was only asking for an opinion on the analysis/suggestion, no testing
necessary.

> Lacking hardware with the broken PMU(s) I'm not able to do this. Could
> you turn the suggestion into a patch and test on BIG.little? I can
> test on Intel Alderlake.

I've spun up the diff below, which works in local testing. I'll go write up a
commit message and send it out as a proper patch shortly.

Mark.

---->8----
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index b0fc48be623f..4f67e8f00a4d 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -232,7 +232,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 bool is_event_supported(u8 type, u64 config)
 {
 	bool ret = true;
-	int open_return;
 	struct evsel *evsel;
 	struct perf_event_attr attr = {
 		.type = type,
@@ -246,20 +245,32 @@ bool is_event_supported(u8 type, u64 config)
 
 	evsel = evsel__new(&attr);
 	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
+		ret = evsel__open(evsel, NULL, tmap) >= 0;
 
-		if (open_return == -EACCES) {
+		if (!ret) {
 			/*
-			 * This happens if the paranoid value
+			 * The event may fail to open if the paranoid value
 			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
+			 * Re-run with exclude_kernel set; we don't do that by
+			 * default as some ARM machines do not support it.
 			 */
 			evsel->core.attr.exclude_kernel = 1;
 			ret = evsel__open(evsel, NULL, tmap) >= 0;
 		}
+
+		if (!ret) {
+			/*
+			 * The event may fail to open if the PMU requires
+			 * exclude_guest to be set (e.g. as the Apple M1 PMU
+			 * requires).
+			 * Re-run with exclude_guest set; we don't do that by
+			 * default as it's equally legitimate for another PMU
+			 * driver to require that exclude_guest is clear.
+			 */
+			evsel->core.attr.exclude_guest = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+
 		evsel__delete(evsel);
 	}
 

