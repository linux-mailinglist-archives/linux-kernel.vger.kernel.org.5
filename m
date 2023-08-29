Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5B78D0C9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbjH2Xo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbjH2Xoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:44:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332181BB;
        Tue, 29 Aug 2023 16:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693352684; x=1724888684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+1T9Do0MpE3rexZYVFZx+fj/FcnYDzdw9uIqJHZ+mV4=;
  b=cwzK/P/uWTFMt27jICrS8euvoysFaQaFPP9XRy1XQl7y+XQahYg+zpGL
   vtc/3IRnLU6LQIuAowK0oRzBRzEe37sJrXNNcHv/vI2Ai/0JnQbNzJ0xi
   oKFE/GN0KuK8JYXxFP6kMYvLabC8MmTGKoH8vMa9XqV4OYzXJzsDIempP
   AcwWuQtDLDtE8GCPlNiuMS6DZrQtUd0A/HT+rknvIpx8EKCw1fLglSwP6
   Gyh/oEGBkm9JXgF85FKYOwNmqeNKJAteFspYKbGwxxELfNFl/wLbyvELx
   0LhsGJnpyD2wKo27hI7R/QisX/ascM6D2qt9JXDz428SRYPO7gWV6f7XC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355015494"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="355015494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="688691042"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="688691042"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 16:44:42 -0700
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
Subject: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size when SNC enabled
Date:   Tue, 29 Aug 2023 16:44:26 -0700
Message-ID: <20230829234426.64421-9-tony.luck@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829234426.64421-1-tony.luck@intel.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
nodes. Systems may support splitting into either two or four nodes.

When SNC mode is enabled the effective amount of L3 cache available
for allocation is divided by the number of nodes per L3.

Detect which SNC mode is active by comparing the number of CPUs
that share a cache with CPU0, with the number of CPUs on node0.

This gives some hope of tests passing. But additional test
infrastructure changes are needed to bind tests to nodes and
guarantee memory allocation from the local node.

Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 57 +++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 87e39456dee0..a8b43210b573 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -13,6 +13,7 @@
 #include <signal.h>
 #include <dirent.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <sys/mount.h>
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index fb00245dee92..79eecbf9f863 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -130,6 +130,61 @@ int get_resource_id(int cpu_no, int *resource_id)
 	return 0;
 }
 
+/*
+ * Count number of CPUs in a /sys bit map
+ */
+static int count_sys_bitmap_bits(char *name)
+{
+	FILE *fp = fopen(name, "r");
+	int count = 0, c;
+
+	if (!fp)
+		return 0;
+
+	while ((c = fgetc(fp)) != EOF) {
+		if (!isxdigit(c))
+			continue;
+		switch (c) {
+		case 'f':
+			count++;
+		case '7': case 'b': case 'd': case 'e':
+			count++;
+		case '3': case '5': case '6': case '9': case 'a': case 'c':
+			count++;
+		case '1': case '2': case '4': case '8':
+			count++;
+		}
+	}
+	fclose(fp);
+
+	return count;
+}
+
+/*
+ * Detect SNC by compating #CPUs in node0 with #CPUs sharing LLC with CPU0
+ * Try to get this right, even if a few CPUs are offline so that the number
+ * of CPUs in node0 is not exactly half or a quarter of the CPUs sharing the
+ * LLC of CPU0.
+ */
+static int snc_ways(void)
+{
+	int node_cpus, cache_cpus;
+
+	node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
+	cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
+
+	if (!node_cpus || !cache_cpus) {
+		fprintf(stderr, "Warning could not determine Sub-NUMA Cluster mode\n");
+		return 1;
+	}
+
+	if (4 * node_cpus >= cache_cpus)
+		return 4;
+	else if (2 * node_cpus >= cache_cpus)
+		return 2;
+	return 1;
+}
+
 /*
  * get_cache_size - Get cache size for a specified CPU
  * @cpu_no:	CPU number
@@ -190,6 +245,8 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 			break;
 	}
 
+	if (cache_num == 3)
+		*cache_size /= snc_ways();
 	return 0;
 }
 
-- 
2.41.0

