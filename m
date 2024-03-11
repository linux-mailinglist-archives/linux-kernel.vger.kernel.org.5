Return-Path: <linux-kernel+bounces-98403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125958779A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A471B21416
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03E7490;
	Mon, 11 Mar 2024 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+dc7uMG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CA7462
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121630; cv=none; b=jNC+jhdWMDybC/pwkQJjynbob3UWNkQyyepOL9HYZqW9h6/e2zCDlFULkVCG6ocUXkT1zzlVmYfcchBHAPFFnTFQ3MhsxVqKKjNnfAgXIYWXl0KAyldfaIvvWt+MgD30/wZorxaziYyC+l9PtyLYoMSG5cumAUp2G/CH4nEHzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121630; c=relaxed/simple;
	bh=x8vNQYnIKfWnz4IwxFgey2b527iwOpVxHgeN9LfHKNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NA/xJ95BmtrnoiSV/Xwdi0EwffgLhjPp1IfZvPG89yk7RqqPuUwMA71DHyP72SVpYNio7bzB/nPOhfpD3cRBLhcUjFDYiaiuJGUmzdydAqlIl9P4LUkJlAouFf8apPVP8EZUqzIf1ptCRU1gOcZuQnJOimoFUntY3A4G6XXSPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+dc7uMG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710121628; x=1741657628;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=x8vNQYnIKfWnz4IwxFgey2b527iwOpVxHgeN9LfHKNw=;
  b=W+dc7uMGrcpIOihRRkweoS9KqPxRFiPpLgqoVYx25N7+qCOj1EfBCLAG
   +nUwdUgjRuEdgc9uIlI1Aa5he9+WfUe6eXXUZUqfYAqVkLYKqulQ/1M0m
   03pYvg11uQFBu9yYMZy02KK3D5K2FT5UjxPe9msU84o1FgwzeZyVvFFff
   0PuocFDPggRYbvCzqjlRcrA4HiCocONR47IGlxbUdW5e50NRtWpFU99Qo
   y9ig71W5EaYDlZ2eW54Vr1o9FPmRvhM36hdBjHxCrVjxDSLVbDSJhWnAv
   LsE7p6nnx4V8vt0WViZSqmYgf9g6/XXnb9Z8A6+a3BpM+/oq1j1DDFcrS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4936331"
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="4936331"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 18:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,115,1708416000"; 
   d="scan'208";a="41945296"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 18:47:03 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Aneesh Kumar <aneesh.kumar@kernel.org>,
  Michal Hocko <mhocko@kernel.org>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Mel Gorman <mgorman@suse.de>,  Feng Tang
 <feng.tang@intel.com>,  Andrea Arcangeli <aarcange@redhat.com>,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Rik van
 Riel <riel@surriel.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Vlastimil Babka <vbabka@suse.cz>,  Dan
 Williams <dan.j.williams@intel.com>,  Hugh Dickins <hughd@google.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Suren Baghdasaryan
 <surenb@google.com>
Subject: Re: [PATCH v2 0/2] Allow migrate on protnone reference with
 MPOL_PREFERRED_MANY policy
In-Reply-To: <cover.1709909210.git.donettom@linux.ibm.com> (Donet Tom's
	message of "Fri, 8 Mar 2024 09:15:36 -0600")
References: <cover.1709909210.git.donettom@linux.ibm.com>
Date: Mon, 11 Mar 2024 09:45:08 +0800
Message-ID: <87zfv54k4b.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Donet Tom <donettom@linux.ibm.com> writes:

> This patchset is to optimize the cross-socket memory access with
> MPOL_PREFERRED_MANY policy.
>
> To test this patch we ran the following test on a 3 node system.
>  Node 0 - 2GB   - Tier 1
>  Node 1 - 11GB  - Tier 1
>  Node 6 - 10GB  - Tier 2
>
> Below changes are made to memcached to set the memory policy,
> It select Node0 and Node1 as preferred nodes.
>
>    #include <numaif.h>
>    #include <numa.h>
>
>     unsigned long nodemask;
>     int ret;
>
>     nodemask = 0x03;
>     ret = set_mempolicy(MPOL_PREFERRED_MANY | MPOL_F_NUMA_BALANCING,
>                                                &nodemask, 10);
>     /* If MPOL_F_NUMA_BALANCING isn't supported,
>      * fall back to MPOL_PREFERRED_MANY */
>     if (ret < 0 && errno == EINVAL){
>        printf("set mem policy normal\n");
>         ret = set_mempolicy(MPOL_PREFERRED_MANY, &nodemask, 10);
>     }
>     if (ret < 0) {
>        perror("Failed to call set_mempolicy");
>        exit(-1);
>     }
>
> Test Procedure:
> ===============
> 1. Make sure memory tiring and demotion are enabled.

Nit picking.

s/tiring/tiering/

--
Best Regards,
Huang, Ying

> 2. Start memcached.
>
>    # ./memcached -b 100000 -m 204800 -u root -c 1000000 -t 7
>        -d -s "/tmp/memcached.sock"
>
> 3. Run memtier_benchmark to store 3200000 keys.
>
>   #./memtier_benchmark -S "/tmp/memcached.sock" --protocol=memcache_binary
>     --threads=1 --pipeline=1 --ratio=1:0 --key-pattern=S:S --key-minimum=1
>     --key-maximum=3200000 -n allkeys -c 1 -R -x 1 -d 1024
>
> 4. Start a memory eater on node 0 and 1. This will demote all memcached
>    pages to node 6.
> 5. Make sure all the memcached pages got demoted to lower tier by reading
>    /proc/<memcaced PID>/numa_maps.
>
>     # cat /proc/2771/numa_maps
>      ---
>     default anon=1009 dirty=1009 active=0 N6=1009 kernelpagesize_kB=64
>     default anon=1009 dirty=1009 active=0 N6=1009 kernelpagesize_kB=64
>      ---
>
> 6. Kill memory eater.
> 7. Read the pgpromote_success counter.
> 8. Start reading the keys by running memtier_benchmark.
>
>   #./memtier_benchmark -S "/tmp/memcached.sock" --protocol=memcache_binary
>    --pipeline=1 --distinct-client-seed --ratio=0:3 --key-pattern=R:R
>    --key-minimum=1 --key-maximum=3200000 -n allkeys
>    --threads=64 -c 1 -R -x 6
>
> 9. Read the pgpromote_success counter.
>
> Test Results:
> =============
> Without Patch
> ------------------
> 1. pgpromote_success  before test
> Node 0:  pgpromote_success 11
> Node 1:  pgpromote_success 140974
>
> pgpromote_success  after test
> Node 0:  pgpromote_success 11
> Node 1:  pgpromote_success 140974
>
> 2. Memtier-benchmark result.
> AGGREGATED AVERAGE RESULTS (6 runs)
> ==================================================================
> Type    Ops/sec   Hits/sec   Misses/sec  Avg. Latency  p50 Latency
> ------------------------------------------------------------------
> Sets     0.00       ---         ---        ---          ---
> Gets    305792.03  305791.93   0.10       0.18949       0.16700
> Waits    0.00       ---         ---        ---          ---
> Totals  305792.03  305791.93   0.10       0.18949       0.16700
>
> ======================================
> p99 Latency  p99.9 Latency  KB/sec
> -------------------------------------
> ---          ---            0.00
> 0.44700     1.71100        11542.69
> ---           ---            ---
> 0.44700     1.71100        11542.69
>
> With Patch
> ---------------
> 1. pgpromote_success  before test
> Node 0:  pgpromote_success 5
> Node 1:  pgpromote_success 89386
>
> pgpromote_success  after test
> Node 0:  pgpromote_success 57895
> Node 1:  pgpromote_success 141463
>
> 2. Memtier-benchmark result.
> AGGREGATED AVERAGE RESULTS (6 runs)
> ====================================================================
> Type    Ops/sec    Hits/sec  Misses/sec  Avg. Latency  p50 Latency
> --------------------------------------------------------------------
> Sets     0.00        ---       ---        ---           ---
> Gets    521942.24  521942.07  0.17       0.11459        0.10300
> Waits    0.00        ---       ---         ---          ---
> Totals  521942.24  521942.07  0.17       0.11459        0.10300
>
> =======================================
> p99 Latency  p99.9 Latency  KB/sec
> ---------------------------------------
>  ---          ---            0.00
> 0.23100      0.31900        19701.68
> ---          ---             ---
> 0.23100      0.31900        19701.68
>
>
> Test Result Analysis:
> =====================
> 1. With patch we could observe pages are getting promoted.
> 2. Memtier-benchmark results shows that, with the patch,
>    performance has increased more than 50%.
>
>  Ops/sec without fix -  305792.03
>  Ops/sec with fix    -  521942.24
>
> Changes:
> v2:
> - Rebased on latest upstream (v6.8-rc7)
> - Used 'numa_node_id()' to get the current execution node ID, Added
>   'lockdep_assert_held' to make sure that the 'mpol_misplaced()' is
>   called with ptl held.
> - The migration condition has been updated; now, migration will only
>   occur if the execution node is present in the policy nodemask.
>
> -v1: https://lore.kernel.org/linux-mm/9c3f7b743477560d1c5b12b8c111a584a2cc92ee.1708097962.git.donettom@linux.ibm.com/#t
>
>
> Donet Tom (2):
>   mm/mempolicy: Use numa_node_id() instead of cpu_to_node()
>   mm/numa_balancing:Allow migrate on protnone reference with
>     MPOL_PREFERRED_MANY policy
>
>  include/linux/mempolicy.h |  5 +++--
>  mm/huge_memory.c          |  2 +-
>  mm/internal.h             |  2 +-
>  mm/memory.c               |  8 +++++---
>  mm/mempolicy.c            | 34 ++++++++++++++++++++++++++--------
>  5 files changed, 36 insertions(+), 15 deletions(-)

