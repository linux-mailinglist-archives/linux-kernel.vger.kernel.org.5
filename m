Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E07DEB0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjKBC5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjKBC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:57:01 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DA101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:56:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="138343930"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="138343930"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 11:56:57 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id D9439CA243
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 19E1ED5C4F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:54 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A425FE368B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:56:53 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by edo.cn.fujitsu.com (Postfix) with ESMTP id CD1211A0071;
        Thu,  2 Nov 2023 10:56:52 +0800 (CST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-mm@kvack.org
Cc:     ying.huang@intel.com, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Subject: [PATCH RFC 0/4] Demotion Profiling Improvements
Date:   Thu,  2 Nov 2023 10:56:44 +0800
Message-Id: <20231102025648.1285477-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27972.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27972.004
X-TMASE-Result: 10--5.312400-10.000000
X-TMASE-MatchedRID: dfhOzwlbDPU5qS/ZlxNfrN+pIjqKanRoYTIx8XXCXvctg96xGBa1qzkS
        mbZ6cnyurQupIilee/fds6WtD+l5NsUMduPRt7B5R+GtoiXVeDHRTRRZJlWECtZVatUD7z4JPLv
        PGJ0eFimnceLJy5PCoM7J33yvU/7hcGWImpDN9/zjpxdo/JwVm3oCBx19i+GMF0dwcR3eNq8v+q
        EP3Q3LyrvlPk1VIqp1gDLqnrRlXrYyF7rbsD7xod0H8LFZNFG7bkV4e2xSge7abS7MXz+efk79l
        dntgWBfDWBLHj2+4Pgwg9a480Bt50sMHBii02BH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the deployment of high-capacity CXL Type 3 memory, HBM and Nvdimm,
the kernel now supports memory tiering. Building on this foundation
and aiming to further enhance memory efficiency, the kernel has
introduced demotion and promotion features.

To provide users with a more intuitive way to observe information
related to demotion, we have made several improvements to demotion
profiling, primarily in two aspects:

Patch 1 introduces a new interface: /sys/devices/system/node/node0/demotion_nodes
This interface is used to display the target nodes to which a node can demote.

Patch 2, Patch 3, and Patch 4 are improvements to demotion statistics.
Patch 2 changes the granularity of demotion statistics from global to per-node.
Patch 3 and Patch 4 further differentiate demotion statistics into demotion
source and demotion destination.

The names of the statistics are open to discussion; they could be named something
like pgdemote_from/to_* etc.
One issue with this patch set is that SUM(pgdemote_src_*) always equals SUM(pgdemote_dst_*)
in the global statistics (/proc/vmstat). Should we hide one of them?

Any feedback is welcome.

TO: Andrew Morton <akpm@linux-foundation.org> 
TO: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
TO: "Rafael J. Wysocki" <rafael@kernel.org> 
CC: "Huang, Ying" <ying.huang@intel.com>
CC: y-goto@fujitsu.com
CC: linux-kernel@vger.kernel.org 
TO: linux-mm@kvack.org 

Li Zhijian (4):
  drivers/base/node: Add demotion_nodes sys infterface
  mm/vmstat: Move pgdemote_* to per-node stats
  mm/vmstat: rename pgdemote_* to pgdemote_dst_* and add pgdemote_src_*
  drivers/base/node: add demote_src and demote_dst to numastat

 drivers/base/node.c           | 29 +++++++++++++++++++++++++++--
 include/linux/memory-tiers.h  |  6 ++++++
 include/linux/mmzone.h        |  7 +++++++
 include/linux/vm_event_item.h |  3 ---
 mm/memory-tiers.c             |  8 ++++++++
 mm/vmscan.c                   | 14 +++++++++++---
 mm/vmstat.c                   |  9 ++++++---
 7 files changed, 65 insertions(+), 11 deletions(-)

-- 
2.29.2

