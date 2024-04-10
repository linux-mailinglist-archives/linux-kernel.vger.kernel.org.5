Return-Path: <linux-kernel+bounces-139312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 442FD8A0142
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF228543B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD532181BA7;
	Wed, 10 Apr 2024 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ay0TbH4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A5176FB8;
	Wed, 10 Apr 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780697; cv=none; b=RFoDlUZ0ZMY1h8FbwGLma78YJ9Mny13EUZh12TUfayTPXO069G4HE3fd5xXNZyxh9YZN5jJROOPVkXhKo11pzyc/h4wuvXnwds/YLBDSCpKp4q34Dl+5dgv9q+QCKibK9JZE7X2Mee05SNaCXMjzkVAp6GeTLKmRD9Mr7P+Jq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780697; c=relaxed/simple;
	bh=1wfBUsJCbQY0OYHC3CGkFSjCqUflGJiynmYV4VBpTbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6oFe6S2DQyXXqA7zP63VhX5jyRzCVzG7llnuc0G7eaifWw7TNrSnLYt6uL1RVpl/wRFGeVk/aK1P6okibQQtP4LMEo0WvdlRBuPBU65GjaapDAdjQ3Dvx4outp+60SQOQUG9Q+fqF2V5K9WlQIZXE0Gbz4sMJB8NhH2v7XBmDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ay0TbH4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC7DC433F1;
	Wed, 10 Apr 2024 20:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712780696;
	bh=1wfBUsJCbQY0OYHC3CGkFSjCqUflGJiynmYV4VBpTbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay0TbH4al9Gl3oA+hKHC9Dv3pcwhmzCUMqLcTFaD/QSwkBIuMlOOpruFOfozNGCvm
	 +ks1IuhvhFrQ3rNRp7SMGa0784QAWEAO3uQqQxj9jMVxxGlvQMuQjr7mtJEPhcb4Om
	 j5lTMcK6JJq6KttnJCmtVRpP6Hsh4rN2wQ1I6tI6vbMhQHJ2Jw5zPKEXow2ickTdjr
	 wFushff1VbRWY8K6WNBu6iFXUEbDseRtUZ8FdPBCsxAsmswb6sopC1IqCdQ2CzOlkn
	 wkZhTgdx4O7TW6E7WqGPNhlgQpZ0Mk3W37Tj+Xw+FFshEaMBc5i9bp1LXFL0Vk8DCz
	 RVDczWHr1x7wQ==
Date: Wed, 10 Apr 2024 17:24:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf annotate-data: Support event group display in
 TUI
Message-ID: <Zhb1lZYuk1cfiFOD@x1>
References: <20240409235000.1893969-1-namhyung@kernel.org>
 <20240409235000.1893969-5-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409235000.1893969-5-namhyung@kernel.org>

On Tue, Apr 09, 2024 at 04:49:58PM -0700, Namhyung Kim wrote:
> Like in stdio, it should print all events in a group together.

How to test this?

You mean something like:

root@number:~# perf record -a -e '{cpu_core/mem-loads,ldlat=30/P,cpu_core/mem-stores/P}'
^C[ perf record: Woken up 8 times to write data ]
[ perf record: Captured and wrote 4.980 MB perf.data (55825 samples) ]

root@number:~#

root@number:~# perf annotate --stdio --data-type

And then having the same output in the TUI?

Trying this...

- Arnaldo
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/ui/browsers/annotate-data.c | 50 ++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
> index fefacaaf16db..a4a0f042f201 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c
> @@ -10,20 +10,27 @@
>  #include "util/annotate.h"
>  #include "util/annotate-data.h"
>  #include "util/evsel.h"
> +#include "util/evlist.h"
>  #include "util/sort.h"
>  
>  struct annotated_data_browser {
>  	struct ui_browser b;
>  	struct list_head entries;
> +	int nr_events;
>  };
>  
>  struct browser_entry {
>  	struct list_head node;
>  	struct annotated_member *data;
> -	struct type_hist_entry hists;
> +	struct type_hist_entry *hists;
>  	int indent;
>  };
>  
> +static struct annotated_data_browser *get_browser(struct ui_browser *uib)
> +{
> +	return container_of(uib, struct annotated_data_browser, b);
> +}
> +
>  static void update_hist_entry(struct type_hist_entry *dst,
>  			      struct type_hist_entry *src)
>  {
> @@ -33,17 +40,21 @@ static void update_hist_entry(struct type_hist_entry *dst,
>  
>  static int get_member_overhead(struct annotated_data_type *adt,
>  			       struct browser_entry *entry,
> -			       struct evsel *evsel)
> +			       struct evsel *leader)
>  {
>  	struct annotated_member *member = entry->data;
> -	int i;
> +	int i, k;
>  
>  	for (i = 0; i < member->size; i++) {
>  		struct type_hist *h;
> +		struct evsel *evsel;
>  		int offset = member->offset + i;
>  
> -		h = adt->histograms[evsel->core.idx];
> -		update_hist_entry(&entry->hists, &h->addr[offset]);
> +		for_each_group_evsel(evsel, leader) {
> +			h = adt->histograms[evsel->core.idx];
> +			k = evsel__group_idx(evsel);
> +			update_hist_entry(&entry->hists[k], &h->addr[offset]);
> +		}
>  	}
>  	return 0;
>  }
> @@ -61,6 +72,12 @@ static int add_child_entries(struct annotated_data_browser *browser,
>  	if (entry == NULL)
>  		return -1;
>  
> +	entry->hists = calloc(browser->nr_events, sizeof(*entry->hists));
> +	if (entry->hists == NULL) {
> +		free(entry);
> +		return -1;
> +	}
> +
>  	entry->data = member;
>  	entry->indent = indent;
>  	if (get_member_overhead(adt, entry, evsel) < 0) {
> @@ -113,6 +130,7 @@ static void annotated_data_browser__delete_entries(struct annotated_data_browser
>  
>  	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
>  		list_del_init(&pos->node);
> +		free(pos->hists);
>  		free(pos);
>  	}
>  }
> @@ -126,6 +144,7 @@ static int browser__show(struct ui_browser *uib)
>  {
>  	struct hist_entry *he = uib->priv;
>  	struct annotated_data_type *adt = he->mem_type;
> +	struct annotated_data_browser *browser = get_browser(uib);
>  	const char *help = "Press 'h' for help on key bindings";
>  	char title[256];
>  
> @@ -146,7 +165,8 @@ static int browser__show(struct ui_browser *uib)
>  	else
>  		strcpy(title, "Percent");
>  
> -	ui_browser__printf(uib, " %10s %10s %10s  %s",
> +	ui_browser__printf(uib, "%*s %10s %10s %10s  %s",
> +			   11 * (browser->nr_events - 1), "",
>  			   title, "Offset", "Size", "Field");
>  	ui_browser__write_nstring(uib, "", uib->width);
>  	return 0;
> @@ -175,18 +195,20 @@ static void browser__write_overhead(struct ui_browser *uib,
>  
>  static void browser__write(struct ui_browser *uib, void *entry, int row)
>  {
> +	struct annotated_data_browser *browser = get_browser(uib);
>  	struct browser_entry *be = entry;
>  	struct annotated_member *member = be->data;
>  	struct hist_entry *he = uib->priv;
>  	struct annotated_data_type *adt = he->mem_type;
> -	struct evsel *evsel = hists_to_evsel(he->hists);
> +	struct evsel *leader = hists_to_evsel(he->hists);
> +	struct evsel *evsel;
>  
>  	if (member == NULL) {
>  		bool current = ui_browser__is_current_entry(uib, row);
>  
>  		/* print the closing bracket */
>  		ui_browser__set_percent_color(uib, 0, current);
> -		ui_browser__write_nstring(uib, "", 11);
> +		ui_browser__write_nstring(uib, "", 11 * browser->nr_events);
>  		ui_browser__printf(uib, " %10s %10s  %*s};",
>  				   "", "", be->indent * 4, "");
>  		ui_browser__write_nstring(uib, "", uib->width);
> @@ -194,8 +216,12 @@ static void browser__write(struct ui_browser *uib, void *entry, int row)
>  	}
>  
>  	/* print the number */
> -	browser__write_overhead(uib, adt->histograms[evsel->core.idx],
> -				&be->hists, row);
> +	for_each_group_evsel(evsel, leader) {
> +		struct type_hist *h = adt->histograms[evsel->core.idx];
> +		int idx = evsel__group_idx(evsel);
> +
> +		browser__write_overhead(uib, h, &be->hists[idx], row);
> +	}
>  
>  	/* print type info */
>  	if (be->indent == 0 && !member->var_name) {
> @@ -267,11 +293,15 @@ int hist_entry__annotate_data_tui(struct hist_entry *he, struct evsel *evsel,
>  			.priv	 = he,
>  			.extra_title_lines = 1,
>  		},
> +		.nr_events = 1,
>  	};
>  	int ret;
>  
>  	ui_helpline__push("Press ESC to exit");
>  
> +	if (evsel__is_group_event(evsel))
> +		browser.nr_events = evsel->core.nr_members;
> +
>  	ret = annotated_data_browser__collect_entries(&browser);
>  	if (ret == 0)
>  		ret = annotated_data_browser__run(&browser, evsel, hbt);
> -- 
> 2.44.0.478.gd926399ef9-goog

