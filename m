Return-Path: <linux-kernel+bounces-148898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6448A88BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36AC1F21E05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D50114883D;
	Wed, 17 Apr 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnYqRRpU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D084E14;
	Wed, 17 Apr 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370895; cv=none; b=X4hbGu7/K+FfhcqN/P3reNAzM7yXfElVkUnJmb0zPEa2/aHNkv6Q0p2gL6y1oEMFB2MmKNgSceYDdEttiFQ7GZYNwKL/DmsMWU4Z9pbe8oRSuuDkeroOgVxq9Ix+29eoaPwAfSV6VH/X7ipCtUxnsw9ttYb4n9Jk/r/2RAav+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370895; c=relaxed/simple;
	bh=J3FQVL9iRcFEAIRpNm/D0Zmcow0IikX+upco464NSvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKlLUAzzPoDuylgi81eUJkAXh3fPkciehqjP06MSPiMH3P0POJ9TjyC9uQ4+9QfeeS8f4h8nrzRmzLuby0sFcPF0jBIVZuHLdCmQXPhRjUxZQ3rj7dO0zI9ayEWVy67atUdiwVV7vgVfsahOvHNWm8yh+cpYD+8wi7aqXmQR+GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnYqRRpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A72C2BD11;
	Wed, 17 Apr 2024 16:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370895;
	bh=J3FQVL9iRcFEAIRpNm/D0Zmcow0IikX+upco464NSvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnYqRRpUic+FDelR4GktLivA+b2yziRIAN2h2lw7leM6sB1YUFVG72LGEu2c25hCP
	 5h+cUHg+WzEWyX6qXkv/yTrEWmZmZ3TpEm+hxvkiIcAhFqSP9hIOl39DQpda5HKDd6
	 /C2hYWNANCQlsxuM7BljkzDDWsZIj1CJZOMUwcfOSyQgeEfN9eL4IQNQHUqyibiUis
	 FxZHNEa6/Wr2iArt7ZUzEv5aW+fficEYRzWAJkkUWmFJUK6Layj1nB4qyAaK5ohi9A
	 5rAMq+K2mRxMXtLqcoG0sui26o5eO9zR/bc2sp1CIWMFThaPncO/I8fTWsSE+qnFTt
	 GPzuIHv8wdsew==
Date: Wed, 17 Apr 2024 13:21:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: weilin.wang@intel.com, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v5 01/16] perf stat: Add new field in stat_config to
 enable hardware aware grouping.
Message-ID: <Zh_3C47MQ-PiIuXD@x1>
References: <20240412210756.309828-1-weilin.wang@intel.com>
 <20240412210756.309828-2-weilin.wang@intel.com>
 <CAP-5=fWNREXxROJhKC2T+Oaw+PBjM=VYdpm_eiaCgc1DLnbm3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWNREXxROJhKC2T+Oaw+PBjM=VYdpm_eiaCgc1DLnbm3A@mail.gmail.com>

On Tue, Apr 16, 2024 at 08:49:21PM -0700, Ian Rogers wrote:
> On Fri, Apr 12, 2024 at 2:08 PM <weilin.wang@intel.com> wrote:
> >
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > Hardware counter and event information could be used to help creating event
> > groups that better utilize hardware counters and improve multiplexing.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> > ---
> >  tools/perf/builtin-stat.c     | 5 +++++
> >  tools/perf/util/metricgroup.c | 5 +++++
> >  tools/perf/util/metricgroup.h | 1 +
> >  tools/perf/util/stat.h        | 1 +
> >  4 files changed, 12 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 6bba1a89d030..c4a5f0984295 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -2106,6 +2106,7 @@ static int add_default_attributes(void)
> >                                                 stat_config.metric_no_threshold,
> >                                                 stat_config.user_requested_cpu_list,
> >                                                 stat_config.system_wide,
> > +                                               stat_config.hardware_aware_grouping,
> >                                                 &stat_config.metric_events);
> >         }
> >
> > @@ -2139,6 +2140,7 @@ static int add_default_attributes(void)
> >                                                 stat_config.metric_no_threshold,
> >                                                 stat_config.user_requested_cpu_list,
> >                                                 stat_config.system_wide,
> > +                                               stat_config.hardware_aware_grouping,
> >                                                 &stat_config.metric_events);
> >         }
> >
> > @@ -2173,6 +2175,7 @@ static int add_default_attributes(void)
> >                                                 /*metric_no_threshold=*/true,
> >                                                 stat_config.user_requested_cpu_list,
> >                                                 stat_config.system_wide,
> > +                                               stat_config.hardware_aware_grouping,
> >                                                 &stat_config.metric_events) < 0)
> >                         return -1;
> >         }
> > @@ -2214,6 +2217,7 @@ static int add_default_attributes(void)
> >                                                         /*metric_no_threshold=*/true,
> >                                                         stat_config.user_requested_cpu_list,
> >                                                         stat_config.system_wide,
> > +                                                       stat_config.hardware_aware_grouping,
> >                                                         &stat_config.metric_events) < 0)
> >                                 return -1;
> >
> > @@ -2748,6 +2752,7 @@ int cmd_stat(int argc, const char **argv)
> >                                                 stat_config.metric_no_threshold,
> >                                                 stat_config.user_requested_cpu_list,
> >                                                 stat_config.system_wide,
> > +                                               stat_config.hardware_aware_grouping,
> >                                                 &stat_config.metric_events);
> >
> >                 zfree(&metrics);
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 79ef6095ab28..11613450725a 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
> >                               bool metric_no_threshold,
> >                               const char *user_requested_cpu_list,
> >                               bool system_wide,
> > +                             bool hardware_aware_grouping,
> >                               struct rblist *metric_events)
> >  {
> >         const struct pmu_metrics_table *table = pmu_metrics_table__find();
> >
> >         if (!table)
> >                 return -EINVAL;
> > +       if (hardware_aware_grouping) {
> > +               pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
> > +       }
> 
> nit: single line if statements shouldn't have curlies:
> https://www.kernel.org/doc/html/v6.8/process/coding-style.html#placing-braces-and-spaces

Fixed  this while applying this patch.

- Arnaldo

