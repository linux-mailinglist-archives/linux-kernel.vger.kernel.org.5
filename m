Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E717778972
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjHKJIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjHKJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:08:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9F2D78
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691744911; x=1723280911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4zCoxQNaeT/5ThBR5TbY5aUu/39R4oWKDboADgANSxI=;
  b=fg6ZLzQ6JInuqDDeQHoe/6q/p8BqB/xw6e6i6mSAqnq4OoQKh91hq+4y
   mrzt2QQ5VHvcEayMhUqro/QG0mDxqj8eet3TSq7z4FTfmkELhDfcAAc68
   YRQPHLiyg9lW+PHfvVN3UWqsRfCoSOkgifZM6bhWffsmic9CKfUaY+Jen
   FW4autpeq44oW9IOL75ZlUgK9+mHduyrdIaGUD/gIBlkLpWRlvwdJre//
   oo/+9E29T5Ro3g7J6OdPgsqPC4EQEGusc68DVTGcwPca4DMYTbkwRPmno
   hmm9Ns3rbAB+lqxl0tKZrfSSZuTy1L0GBuibCWnSL0pBAKtTuWG+Ik/TQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361776277"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361776277"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="876091008"
Received: from jallred-mobl.amr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.249])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:08:32 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] mm: fix draining remote pageset
Date:   Fri, 11 Aug 2023 17:08:19 +0800
Message-Id: <20230811090819.60845-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no memory allocation/freeing in the remote pageset after
some time (3 seconds for now), the remote pageset will be drained to
avoid memory wastage.

But in the current implementation, vmstat updater worker may not be
re-queued when we are waiting for the timeout (pcp->expire != 0) if
there are no vmstat changes, for example, when CPU goes idle.

This is fixed via guaranteeing that the vmstat updater worker will
always be re-queued when we are waiting for the timeout.

We can reproduce the bug via allocating/freeing pages from remote
node, then go idle.  And the patch can fix it.

Fixes: 7cc36bbddde5 ("vmstat: on-demand vmstat workers V8")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/vmstat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index b731d57996c5..111118741abf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -856,8 +856,10 @@ static int refresh_cpu_vm_stats(bool do_pagesets)
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

