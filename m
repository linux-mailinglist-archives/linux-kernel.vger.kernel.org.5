Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A47BC4F9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbjJGGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 02:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343532AbjJGGYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 02:24:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F007BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696659887; x=1728195887;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wqsmBsrFVhBwMfcb7/vOHRtZdmYOe7LU00pD8fViK0Y=;
  b=llLbvnhaH2i0y3po1PB6+ZH7V/VrxH4ZpefcCzEuX+8wlVD5HRn7XaBS
   U4EKkzsYpP2jVgM4X6QtcAt2KfYJL/mDPAR0ENmriNa3mJxIzBPzihCzm
   731m4SAtul3xoM+bKV4+RYxjFQVoicJYMsth2LgZJ91GqNaqwmTIezGSC
   wAAcyZz2QjiRLroTPvqJgVZgoRA2VdfdOwl8Ct9GJ9+KSe4fhVa5gcToh
   XpSv/c8+a0+5RvmgPzZKHY0DKA9pQQFACrx+PDPV+jFfJAvPMzToI/86z
   WfkeaXQDFpaOhj6VTyEMVbcFsiD2JcIwDcHVb26ClWRdXi6Z9D/x9PObs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="382764843"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="382764843"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:24:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="787617302"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="787617302"
Received: from jieli7-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 23:24:42 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH -V2] mm: fix draining PCP of remote zone
Date:   Sat,  7 Oct 2023 14:23:56 +0800
Message-Id: <20231007062356.187621-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no memory allocation/freeing in the PCP (Per-CPU Pageset)
of a remote zone (zone in remote NUMA node) after some time (3 seconds
for now), the pages of the PCP of the remote zone will be drained to
avoid memory wastage.

This behavior was introduced in the commit 4ae7c03943fc ("[PATCH]
Periodically drain non local pagesets") and the commit
4037d452202e ("Move remote node draining out of slab allocators")

But, after the commit 7cc36bbddde5 ("vmstat: on-demand vmstat workers
V8"), the vmstat updater worker which is used to drain the PCP of
remote zones may not be re-queued when we are waiting for the
timeout (pcp->expire != 0) if there are no vmstat changes on this CPU,
for example, when the CPU goes idle or runs user space only workloads.
This may cause the pages of a remote zone be kept in PCP of this CPU
for long time.  So that, the page reclaiming of the remote zone may be
triggered prematurely.  This isn't a severe problem in practice,
because the PCP of the remote zone will be drained if some memory are
allocated/freed again on this CPU.  And, the PCP will eventually be
drained during the direct reclaiming if necessary.

Anyway, the problem still deserves a fix via guaranteeing that the
vmstat updater worker will always be re-queued when we are waiting for
the timeout.  In effect, this restores the original behavior before
the commit 7cc36bbddde5.

We can reproduce the bug via allocating/freeing pages from a remote
zone then go idle as follows.  And the patch can fix it.

- Run some workloads, use `numactl` to bind CPU to node 0 and memory to
  node 1.  So the PCP of the CPU on node 0 for zone on node 1 will be
  filled.

- After workloads finish, idle for 60s

- Check /proc/zoneinfo

With the original kernel, the number of pages in the PCP of the CPU on
node 0 for zone on node 1 is non-zero after idle.  With the patched
kernel, it becomes 0 after idle.  That is, we avoid to keep pages in
the remote PCP during idle.

Fixes: 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/vmstat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 00e81e99c6ee..7f1bf40e71e8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -855,8 +855,10 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
 				continue;
 			}
 
-			if (__this_cpu_dec_return(pcp->expire))
+			if (__this_cpu_dec_return(pcp->expire)) {
+				changes++;
 				continue;
+			}
 
 			if (__this_cpu_read(pcp->count)) {
 				drain_zone_pages(zone, this_cpu_ptr(pcp));
-- 
2.39.2

