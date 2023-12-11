Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8AB80C9A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343563AbjLKMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjLKMXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:23:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8224E173F;
        Mon, 11 Dec 2023 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297361; x=1733833361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLswjc4RBSsfOyyJdf5c/IbEKWgWc6rUpzTYzJ8+/xA=;
  b=bTUf0Np89ZzS3loGA0i4n7jnz3oMfuJwcEIQ8vrbbliRsuoOaoToAfGX
   XBoGDwIDX88zpEkMnfE6ZcUNowpFlBXonSj/ujDZDtbfC0+NSmy0/Qp8N
   LK4CIy0ssdh6mFNLfR5rEmaYNt1QysSqJ410zdVhDfgISjIBadS35EDYS
   ogIrUx5yBSgwHlct1eudIRfKemGApzj/ENho/otKHn3qKZZv9xFF5mpPu
   XrzvQ2qt9PfAJf/hJjZM8YMqbQQOX+9Q7l7lrgpJADttD4ktDnUu3ZrgW
   VAiqsrbyjOSO6TLBTungbZf3X5yW1ns32ucyTUi1AfSQRqs11SsgVucpR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="16192947"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="16192947"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="17581542"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:37 -0800
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
Subject: [PATCH v3 27/29] selftests/resctrl: Add helper to convert L2/3 to integer
Date:   Mon, 11 Dec 2023 14:18:24 +0200
Message-Id: <20231211121826.14392-28-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"L2"/"L3" conversion to integer is embedded into get_cache_size()
which prevents reuse.

Create a helper for the cache string to integer conversion to make
it reusable.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 28 +++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b989b5809902..bb7d3f3bc43a 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -94,6 +94,23 @@ int umount_resctrlfs(void)
 	return 0;
 }
 
+/*
+ * get_cache_level - Convert cache level from string to integer
+ * @cache_type:		Cache level as string
+ *
+ * Return: cache level as integer or -1 if @cache_type is invalid.
+ */
+static int get_cache_level(const char *cache_type)
+{
+	if (!strcmp(cache_type, "L3"))
+		return 3;
+	if (!strcmp(cache_type, "L2"))
+		return 2;
+
+	ksft_print_msg("Invalid cache level\n");
+	return -1;
+}
+
 /*
  * get_resource_id - Get socket number/l3 id for a specified CPU
  * @cpu_no:	CPU number
@@ -144,14 +161,9 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 	int length, i, cache_num;
 	FILE *fp;
 
-	if (!strcmp(cache_type, "L3")) {
-		cache_num = 3;
-	} else if (!strcmp(cache_type, "L2")) {
-		cache_num = 2;
-	} else {
-		ksft_print_msg("Invalid cache level\n");
-		return -1;
-	}
+	cache_num = get_cache_level(cache_type);
+	if (cache_num < 0)
+		return cache_num;
 
 	sprintf(cache_path, "/sys/bus/cpu/devices/cpu%d/cache/index%d/size",
 		cpu_no, cache_num);
-- 
2.30.2

