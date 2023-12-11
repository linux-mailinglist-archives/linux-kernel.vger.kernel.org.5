Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87A180C9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjLKMXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjLKMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:23:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393191FCA;
        Mon, 11 Dec 2023 04:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297381; x=1733833381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dfZf4sHJCZjWtcW+3k/zvEdVAH3BOuwxHN/qA+pRkPA=;
  b=RH0rDKgLvJ97gi1pi3dGHijRfQbvxf90VatBgsvCrW412gyZGvnMzOKc
   wi7bTqlVWM8Tp/oTlAUqRBy2g+moM9Xi0iQ9hMepxZZqy0pWeFVtBloUn
   QkvorkaA/xH09DstXkcUnu0st5Lp28bglo1J+MQ5vB6IL3KbXZAX8KLbU
   B+wjPsu7dmW6RWsfD5+j/of4IJvXPmRfdojmDKdxfffYTnZk1JZwpET/f
   2DakBQRl4RksIMEGm1gdgWG2NTzB56Bh/l16PfoNwZyNQ0EKLnPJXwTS/
   8edEyclwWJAVE3eo+JjIMjgr7YmMKnd4RyA3MJcZt2OEF4DTvuRxpJ0XT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1450215"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1450215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="839012104"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="839012104"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:54 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 29/29] selftests/resctrl: Get domain id from cache id
Date:   Mon, 11 Dec 2023 14:18:26 +0200
Message-Id: <20231211121826.14392-30-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Domain id is acquired differently depending on CPU. AMD tests use id
from L3 cache, whereas CPUs from other vendors base the id on topology
package id. In order to support L2 CAT test, this has to be
generalized.

The driver side code seems to get the domain ids from cache ids so the
approach used by the AMD branch seems to match the kernel-side code. It
will also work with L2 domain IDs as long as the cache level is
generalized.

Using the topology id was always fragile due to mismatch with the
kernel-side way to acquire the domain id. It got incorrect domain id,
e.g., when Cluster-on-Die (CoD) is enabled for CPU (but CoD is not well
suited for resctrl in the first place so it has not been a big issue if
tests don't work correctly with it).

Taking all the above into account, generalize acquiring the domain id
by taking it from the cache id and do not hard-code the cache level.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 27 ++++++++++++-------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4d8cd8535749..c54efcf1412a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -129,7 +129,7 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int get_domain_id(int cpu_no, int *domain_id);
+int get_domain_id(const char *resource, int cpu_no, int *domain_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 47394e434c11..9743344fb040 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -415,7 +415,7 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("MB", cpu_no, &domain_id) < 0) {
 		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
@@ -584,7 +584,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 {
 	int domain_id;
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id("L3", cpu_no, &domain_id) < 0) {
 		ksft_print_msg("Could not get domain ID\n");
 		return;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index a00f512fb64f..0e97036a64b8 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -111,28 +111,37 @@ static int get_cache_level(const char *cache_type)
 	return -1;
 }
 
+static int get_resource_cache_level(const char *resource)
+{
+	/* "MB" use L3 (LLC) as resource */
+	if (!strcmp(resource, "MB"))
+		return 3;
+	return get_cache_level(resource);
+}
+
 /*
  * get_domain_id - Get resctrl domain ID for a specified CPU
+ * @resource:	resource name
  * @cpu_no:	CPU number
  * @domain_id:	domain ID (cache ID; for MB, L3 cache ID)
  *
  * Return: >= 0 on success, < 0 on failure.
  */
-int get_domain_id(int cpu_no, int *domain_id)
+int get_domain_id(const char *resource, int cpu_no, int *domain_id)
 {
 	char phys_pkg_path[1024];
+	int cache_num;
 	FILE *fp;
 
-	if (get_vendor() == ARCH_AMD)
-		sprintf(phys_pkg_path, "%s%d/cache/index3/id",
-			PHYS_ID_PATH, cpu_no);
-	else
-		sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
-			PHYS_ID_PATH, cpu_no);
+	cache_num = get_resource_cache_level(resource);
+	if (cache_num < 0)
+		return cache_num;
+
+	sprintf(phys_pkg_path, "%s%d/cache/index%d/id", PHYS_ID_PATH, cpu_no, cache_num);
 
 	fp = fopen(phys_pkg_path, "r");
 	if (!fp) {
-		ksft_perror("Failed to open physical_package_id");
+		ksft_perror("Failed to open cache id file");
 
 		return -1;
 	}
@@ -559,7 +568,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resour
 		return -1;
 	}
 
-	if (get_domain_id(cpu_no, &domain_id) < 0) {
+	if (get_domain_id(resource, cpu_no, &domain_id) < 0) {
 		sprintf(reason, "Failed to get domain ID");
 		ret = -1;
 
-- 
2.30.2

