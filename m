Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1413075DE35
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 21:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGVTIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 15:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGVTH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 15:07:56 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA4E65;
        Sat, 22 Jul 2023 12:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690052875; x=1721588875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QLPVmH8OKhS156FijxUUbjl5TQT038tMDl99vshP4rU=;
  b=XjrTHdOPIuuIRs1WPJF78uvUA0y0U/DWXpQemXmZhp+c1F0R9UlxwD0n
   6KSYR6eMGkD3pbAwgdEiWoCl/LWOwJZ963zZQ/ceXz+rJvfUBTBRTRGO9
   qeREIjfvxOe8z+XZgym6knAz2d5EuKtdzaTm98HWl4oWbHWIKDOLIsFUE
   3cSGm6OTvkzp+anaNf1jv1QDuZJpiPVGuxM5Bmi/+9HnUIrfdYpyOakVu
   +L+etQTw7qkfcOOJUcBCH3Jr/4SWEixPyz27Pl33sNL7jy4VGO832cf19
   i6LpJTDlqka57SJdxc4WSBE03qTvUgDM5EoAIpc2Jlo+cqbiDCZAlEVRx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346823994"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346823994"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="815368098"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="815368098"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 12:07:52 -0700
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
Subject: [PATCH v4 7/7] selftests/resctrl: Adjust effective L3 cache size when SNC enabled
Date:   Sat, 22 Jul 2023 12:07:40 -0700
Message-Id: <20230722190740.326190-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230722190740.326190-1-tony.luck@intel.com>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Reported-by: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Closes: https://lore.kernel.org/r/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com
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
2.40.1

