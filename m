Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93797B25C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjI1TO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjI1TON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:14:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD31AB;
        Thu, 28 Sep 2023 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928446; x=1727464446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mn6nYHQ+REP1+buEIYzgvASYIMVA5gLIDjoJUxkB0Ok=;
  b=duWY74iPCS0aoa5n5Gjw2tawpKPLUFeu/NI0PYnZv6O8k4rxd0uWWOX/
   PK7cKYgAWHc0XCTkgg/J4D0ezok4af01egNJRsDdcCUxNf/MJbWBJ3MyP
   afgLnuek101P3i38jS9+D+a8XCFtxLIsPCczd6HFrzMkw9+7kUbfZZH0L
   ZQQB6jq0b8CwfAR1RjeyHNKewWZfLdT4ezf1FOuKCbZUTps6k8gTLeaNi
   s5fVOX9eJb4qN87kpYXHrL1pWYExBeSH6rnaR7KxyuOT+ieJ8DMbSLWX8
   8X8n/hQLkF6FlRRhEWZuZ3PJjqwt4dJyGVlDtX7jm3EqE3CA3ACBYA3VY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367213958"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367213958"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:14:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779020047"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="779020047"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:14:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v6 8/8] x86/resctrl: Update documentation with Sub-NUMA cluster changes
Date:   Thu, 28 Sep 2023 12:13:49 -0700
Message-ID: <20230928191350.205703-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928191350.205703-1-tony.luck@intel.com>
References: <20230829234426.64421-1-tony.luck@intel.com>
 <20230928191350.205703-1-tony.luck@intel.com>
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

With Sub-NUMA Cluster mode enabled the scope of monitoring resources is
per-NODE instead of per-L3 cache. Suffixes of directories with "L3" in
their name refer to Sub-NUMA nodes instead of L3 cache ids.

Users should be aware that SNC mode also affects the amount of L3 cache
available for allocation within each SNC node.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v5:

Added addtional details about challenges tracking tasks when SNC
mode is enabled.
---
 Documentation/arch/x86/resctrl.rst | 34 +++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index cb05d90111b4..d6b6a4cfd967 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -345,9 +345,15 @@ When control is enabled all CTRL_MON groups will also contain:
 When monitoring is enabled all MON groups will also contain:
 
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
+	This contains a set of files organized by L3 domain or by NUMA
+	node (depending on whether Sub-NUMA Cluster (SNC) mode is disabled
+	or enabled respectively) and by RDT event. E.g. on a system with
+	SNC mode disabled with two L3 domains there will be subdirectories
+	"mon_L3_00" and "mon_L3_01". The numerical suffix refers to the
+	L3 cache id.  With SNC enabled the directory names are the same,
+	but the numerical suffix refers to the node id.
+	Mappings from node ids to CPUs are available in the
+	/sys/devices/system/node/node*/cpulist files. Each of these
 	directories have one file per event (e.g. "llc_occupancy",
 	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
 	files provide a read out of the current value of the event for
@@ -452,6 +458,28 @@ and 0xA are not.  On a system with a 20-bit mask each bit represents 5%
 of the capacity of the cache. You could partition the cache into four
 equal parts with masks: 0x1f, 0x3e0, 0x7c00, 0xf8000.
 
+Notes on Sub-NUMA Cluster mode
+==============================
+When SNC mode is enabled the "llc_occupancy", "mbm_total_bytes", and
+"mbm_local_bytes" will only give meaningful results for well behaved NUMA
+applications. I.e. those that perform the majority of memory accesses
+to memory on the local NUMA node to the CPU where the task is executing.
+Note that Linux may load balance tasks between Sub-NUMA nodes much
+more readily than between regular NUMA nodes since the CPUs on SNC
+share the same L3 cache and the system may report the NUMA distance
+between SNC nodes with a lower value than used for regular NUMA nodes.
+Tasks that migrate between nodes will have their traffic recorded by the
+counters in different SNC nodes so a user will need to read mon_data
+files from each node on which the task executed to get the full
+view of traffic for which the task was the source.
+
+
+The cache allocation feature still provides the same number of
+bits in a mask to control allocation into the L3 cache. But each
+of those ways has its capacity reduced because the cache is divided
+between the SNC nodes. The values reported in the resctrl
+"size" files are adjusted accordingly.
+
 Memory bandwidth Allocation and monitoring
 ==========================================
 
-- 
2.41.0

