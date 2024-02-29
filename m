Return-Path: <linux-kernel+bounces-86159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544486C093
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C456287F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCE23C460;
	Thu, 29 Feb 2024 06:11:18 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F733A8F7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187077; cv=none; b=JtloXRnv9W16dMsQBMPh8uBvc0iG//npMLQ1I/hbKRFC2qntYHSD4kMITq7Nl2itEtUwUnga2dw8YyW6PiKhMNmRxtQ3vdH5fucWBe8JkmzGDLz+4I643JhxiSHpLmoOZUJMISx7j2UU57uOdJjP96uM5C3B9qgKb8o0eDwXo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187077; c=relaxed/simple;
	bh=BLrnwTzrImi8CoIKLbVdYDpj+nTmlfa/Kf2MgjaJF8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uw7eJQhAuBX/RP7Ow2Py4b7KPamSy9QbUaDFCyioCjdoj+nryDSO+k0Y3dspCOzZMIHgWny6y5eX2r0Xb0oHpD4rPg8NW78DNk+1N6D8WG5mZK4nIU9gkUVCtIsXLqnNvijdWfzjh5nxhJazuTX1qJu58MNpnEDEjy7zeX2MzhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-79-65e01ff546e5
Date: Thu, 29 Feb 2024 15:10:56 +0900
From: Byungchul Park <byungchul@sk.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, yuzhao@google.com, ying.huang@intel.com,
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it
 doesn't work
Message-ID: <20240229061056.GA72813@system.software.com>
References: <20240223054407.14829-1-byungchul@sk.com>
 <ZdyM1nS8a8UR1dw_@tiehlicka>
 <20240228223601.GA53666@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228223601.GA53666@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnoe43+QepBhcnM1vMWb+GzWL1Jl+L
	y7vmsFncW/Of1WLyu2eMFvf7HCxmN/YxWpycNZnF4t2EL6wOnB6H37xn9liwqdRj8Z6XTB6b
	Pk1i9zgx4zeLx/otV1k8ziw4wu6x+XS1x+dNcgGcUVw2Kak5mWWpRfp2CVwZ719JFjwIrrh5
	/DxLA+Ntuy5GTg4JAROJzd8PM8HYixZ+ZAexWQRUJQ68uMgMYrMJqEvcuPETzBYR0JC4tKiD
	rYuRi4NZ4DujxKqDu8CahQXCJTrm7mYFsXkFLCTeHvgAZgsJVEtc+HcMKi4ocXLmExYQm1lA
	S+LGv5dAvRxAtrTE8n8cIGFOAUOJi9f2MILYogLKEge2HWcC2SUhcJlN4tSuXcwQh0pKHFxx
	g2UCo8AsJGNnIRk7C2HsAkbmVYxCmXlluYmZOSZ6GZV5mRV6yfm5mxiB8bCs9k/0DsZPF4IP
	MQpwMCrx8CbY3E8VYk0sK67MPcQowcGsJMIrI3g3VYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv
	0bfyFCGB9MSS1OzU1ILUIpgsEwenVANjkIaNyVQho2r/Oy5Fe2/cvq+w78zOqYwP5awzly4u
	78oXNeBgEPhyt72G+4OQu+i2qqrbbkar+Y8vfKAnZvvLVuSRg+Dd2rliNkt7n7Nn/Luvtmxm
	3P1HHNvm3DKYsHlq9/vNl+LmWhyaYPmIfVVm4hKemPAH559NqFKesTTmu/ZmizUZhl/ElViK
	MxINtZiLihMBez/nXIMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrPtV/kGqwdKPZhZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rxeR3zxgt7vc5WMxu7GO0ODlrMovFuwlfWB24PA6/ec/ssWBTqcfi
	PS+ZPDZ9msTucWLGbxaPxS8+MHms33KVxePMgiPsHptPV3t83iQXwBXFZZOSmpNZllqkb5fA
	lfH+lWTBg+CKm8fPszQw3rbrYuTkkBAwkVi08CM7iM0ioCpx4MVFZhCbTUBd4saNn2C2iICG
	xKVFHWxdjFwczALfGSVWHdzFBJIQFgiX6Ji7mxXE5hWwkHh74AOYLSRQLXHh3zGouKDEyZlP
	WEBsZgEtiRv/XgL1cgDZ0hLL/3GAhDkFDCUuXtvDCGKLCihLHNh2nGkCI+8sJN2zkHTPQuhe
	wMi8ilEkM68sNzEzx1SvODujMi+zQi85P3cTIzC4l9X+mbiD8ctl90OMAhyMSjy8CTb3U4VY
	E8uKK3MPMUpwMCuJ8MoI3k0V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzusVnpogJJCeWJKanZpa
	kFoEk2Xi4JRqYAzL6Ncxs7banlfp42i9jXdHm+dXmXNlGt98I78Ir/u94UZvvOztf767HQxk
	ZobNCUrMfTtXeRLL+VmSSz45VYjYL817+1DX+4obm52M50LToIdXl8UdYek02n1qC9OH0ybz
	QvZZSLjXy1unBn2btnj/8eIXYR+CjH4sdJplUhfna/E5+o+8nRJLcUaioRZzUXEiAMR7Hthq
	AgAA
X-CFilter-Loop: Reflected

On Wed, Feb 28, 2024 at 05:36:01PM -0500, Johannes Weiner wrote:
> On Mon, Feb 26, 2024 at 02:06:30PM +0100, Michal Hocko wrote:
> > [CC Mel, Vlastimil and Johannes for awareness]
> > 
> > On Fri 23-02-24 14:44:07, Byungchul Park wrote:
> > > Changes from v2:
> > > 	1. Change the condition to stop cache_trim_mode.
> > > 
> > > 	   From - Stop it if it's at high scan priorities, 0 or 1.
> > > 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> > > 	          the mode didn't work in the previous turn.
> > > 
> > > 	   (feedbacked by Huang Ying)
> > > 
> > > 	2. Change the test result in the commit message after testing
> > > 	   with the new logic.
> > > 
> > > Changes from v1:
> > > 	1. Add a comment describing why this change is necessary in code
> > > 	   and rewrite the commit message with how to reproduce and what
> > > 	   the result is using vmstat. (feedbacked by Andrew Morton and
> > > 	   Yu Zhao)
> > > 	2. Change the condition to avoid cache_trim_mode from
> > > 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> > > 	   where the priority goes to zero all the way. (feedbacked by
> > > 	   Yu Zhao)
> > > 
> > > --->8---
> > > >From 05846e34bf02ac9b3e254324dc2d7afd97a025d9 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Fri, 23 Feb 2024 13:47:16 +0900
> > > Subject: [PATCH v3] mm, vmscan: do not turn on cache_trim_mode if it doesn't work
> > > 
> > > With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> > > pages.  However, it should be more careful to turn on the mode because
> > > it's going to prevent anon pages from being reclaimed even if there are
> > > a huge number of anon pages that are cold and should be reclaimed.  Even
> > > worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> > > stopping kswapd from functioning until direct reclaim eventually works
> > > to resume kswapd.
> > > 
> > > So do not turn on cache_trim_mode if the mode doesn't work, especially
> > > while the sytem is struggling against reclaim.
> > > 
> > > The problematic behavior can be reproduced by:
> > > 
> > >    CONFIG_NUMA_BALANCING enabled
> > >    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
> > >    numa node0 (8GB local memory, 16 CPUs)
> > >    numa node1 (8GB slow tier memory, no CPUs)
> > > 
> > >    Sequence:
> > > 
> > >    1) echo 3 > /proc/sys/vm/drop_caches
> > >    2) To emulate the system with full of cold memory in local DRAM, run
> > >       the following dummy program and never touch the region:
> > > 
> > >          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
> > > 	      MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> > > 
> > >    3) Run any memory intensive work e.g. XSBench.
> > >    4) Check if numa balancing is working e.i. promotion/demotion.
> > >    5) Iterate 1) ~ 4) until numa balancing stops.
> > > 
> > > With this, you could see that promotion/demotion are not working because
> > > kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> > > 
> > > Interesting vmstat delta's differences between before and after are like:
> > > 
> > >    +-----------------------+-------------------------------+
> > >    | interesting vmstat	   | before	   | after	   |
> > >    +-----------------------+-------------------------------+
> > >    | nr_inactive_anon	   | 321935	   | 1636737	   |
> > >    | nr_active_anon	   | 1780700	   | 465913	   |
> > >    | nr_inactive_file	   | 30425	   | 35711	   |
> > >    | nr_active_file	   | 14961	   | 8698	   |
> > >    | pgpromote_success	   | 356	   | 1267785	   |
> > >    | pgpromote_candidate   | 21953245	   | 1745631	   |
> > >    | pgactivate		   | 1844523	   | 3309867	   |
> > >    | pgdeactivate	   | 50634	   | 1545041	   |
> > >    | pgfault		   | 31100294	   | 6411036	   |
> > >    | pgdemote_kswapd	   | 30856	   | 2267467	   |
> > >    | pgscan_kswapd	   | 1861981	   | 7729231	   |
> > >    | pgscan_anon	   | 1822930	   | 7667544	   |
> > >    | pgscan_file	   | 39051	   | 61687	   |
> > >    | pgsteal_anon	   | 386	   | 2227217	   |
> > >    | pgsteal_file	   | 30470	   | 40250	   |
> > >    | pageoutrun		   | 30		   | 457	   |
> > >    | numa_hint_faults	   | 27418279	   | 2752289	   |
> > >    | numa_pages_migrated   | 356	   | 1267785 	   |
> > >    +-----------------------+-------------------------------+
> > > 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  mm/vmscan.c | 24 +++++++++++++++++++-----
> > >  1 file changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > index bba207f41b14..f7312d831fed 100644
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -127,6 +127,9 @@ struct scan_control {
> > >  	/* One of the zones is ready for compaction */
> > >  	unsigned int compaction_ready:1;
> > >  
> > > +	/* If the last try was reclaimable */
> > > +	unsigned int reclaimable:1;
> > > +
> > >  	/* There is easily reclaimable cold cache in the current node */
> > >  	unsigned int cache_trim_mode:1;
> > >  
> > > @@ -2266,9 +2269,14 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
> > >  	 * If we have plenty of inactive file pages that aren't
> > >  	 * thrashing, try to reclaim those first before touching
> > >  	 * anonymous pages.
> > > +	 *
> > > +	 * It doesn't make sense to keep cache_trim_mode on if the mode
> > > +	 * is not working while struggling against reclaim. So do not
> > > +	 * turn it on if so. Note the highest priority of kswapd is 1.
> > >  	 */
> > >  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> > > -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> > > +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> > > +	    !(sc->cache_trim_mode && !sc->reclaimable && sc->priority <= 1))
> > >  		sc->cache_trim_mode = 1;
> > >  	else
> > >  		sc->cache_trim_mode = 0;
> 
> The overall goal makes sense to me.
> 
> file >> priority is just a heuristic that there are enough potential
> candidate pages, not a guarantee that any forward progress will
> happen. So it makes sense to retry without before failing.
> 
> The way you wrote this conditional kind of hurts my head,
> though. Please don't write negations of complex terms like this.

Okay. I won't.

> It expands to this:
> 
> 	!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1
> 
> which I'm not sure makes sense. Surely it should be something like
> 
> 	!sc->cache_trim_mode && sc->reclaimable && sc->priority > 1

It's a totally different condition as you know.

> instead?
> 
> Also
> 
> 	if (!sc->cache_trim_mode)
> 		sc->cache_trim_mode = 1
> 	else
> 		sc->cache_trim_mode = 0
> 
> will toggle on every loop. So if direct reclaim runs through a
> zonelist, it'll cache trim every other numa node...?

No way to toggle on every loop.

What I tried was that:

	1. Don't turn it on again if it didn't work in the previous try.
	2. Let it go as it was if the priority is not that high though,
	   to keep the code as conservatively as possible.

So again, the following condition is needed.

	(the original condition) &&
	(!sc->cache_trim_mode || sc->reclaimable || sc->priority > 1)

> > > @@ -5862,7 +5870,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >  {
> > >  	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
> > >  	struct lruvec *target_lruvec;
> > > -	bool reclaimable = false;
> > >  
> > >  	if (lru_gen_enabled() && root_reclaim(sc)) {
> > >  		lru_gen_shrink_node(pgdat, sc);
> > > @@ -5877,6 +5884,14 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >  	nr_reclaimed = sc->nr_reclaimed;
> > >  	nr_scanned = sc->nr_scanned;
> > >  
> > > +	/*
> > > +	 * Reset to the default values at the start.
> > > +	 */
> > > +	if (sc->priority == DEF_PRIORITY) {

This might need to be fixed if reclaim happens to start with other than
DEF_PRIORITY. For now, reclaim always starts with the priority though.

> > > +		sc->reclaimable = 1;
> > > +		sc->cache_trim_mode = 0;
> > > +	}

For each shrink_node(), initialize all the variable at the start.

> > > +
> > >  	prepare_scan_control(pgdat, sc);
> > >  
> > >  	shrink_node_memcgs(pgdat, sc);
> > > @@ -5890,8 +5905,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> > >  		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > >  			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
> > >  
> > > -	if (nr_node_reclaimed)
> > > -		reclaimable = true;
> > > +	sc->reclaimable = !!nr_node_reclaimed;
> 
> The scope of this doesn't quite make sense. If direct reclaim scans
> multiple nodes, reclaim failure on the first node would disable cache
> trim mode on the second node, which is totally unrelated.

As I mentioned, reclaim for every node would start with an initialized
value because *each node is totally unrelated to another*.

> I think it needs separate paths for direct reclaim and kswapd. For
> direct reclaim, the retry should be before these similar retry catches
> in do_try_to_free_pages(), after all zones have been considered:

Remind sc->reclaimable and sc->cache_trim_mode will be initialized every
shrink_node() in my patch.

> 	/*
> 	 * We make inactive:active ratio decisions based on the node's
> 	 * composition of memory, but a restrictive reclaim_idx or a
> 	 * memory.low cgroup setting can exempt large amounts of
> 	 * memory from reclaim. Neither of which are very common, so
> 	 * instead of doing costly eligibility calculations of the
> 	 * entire cgroup subtree up front, we assume the estimates are
> 	 * good, and retry with forcible deactivation if that fails.
> 	 */
> 	if (sc->skipped_deactivate) {
> 		sc->priority = initial_priority;
> 		sc->force_deactivate = 1;
> 		sc->skipped_deactivate = 0;
> 		goto retry;
> 	}
> 
> 	/* Untapped cgroup reserves?  Don't OOM, retry. */
> 	if (sc->memcg_low_skipped) {
> 		sc->priority = initial_priority;
> 		sc->force_deactivate = 0;
> 		sc->memcg_low_reclaim = 1;
> 		sc->memcg_low_skipped = 0;
> 		goto retry;
> 	}
> 
> and for kswapd it looks like it should be in balance_pgdat(), after
> the priority loop, before increasing kswapd_failures.
> 
> Instead of sc->reclaimable, which is very broad, it would be better to
> call it sc->may_cache_trim_mode. This is in line with a bunch of other
> such mechanisms in scan_control.

Or am I missing something?

	Byungchul


