Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6680EF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376983AbjLLOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376969AbjLLOxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:53:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3784EB;
        Tue, 12 Dec 2023 06:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702392803; x=1733928803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qo202yzdW9FjkslWfPMmIkndsLvL+V5BLV3JStn7eyw=;
  b=APKBhwtqjI+K6C+Q6mkeiVnM/jaC47UDxSp3G/yoQe73ubc26YAjLRuT
   az7ZQTqaa9MP8EwdDtWKMssKBWT00ghyXzrbAWXnMDePFOY1gd4VUF/IW
   wyhLRVmQJ+plx2NFoX2DQsqkdlsdv83jhlREFAda9mZlsxv59zA5P4v8n
   EoTfv/Ab2BDC8F+dIIo6E7PDeU9AdYGgHxDJel7Pk6gJBiDUl2kVwxZaw
   Ny5XQh9qn4DAE/Wq0oqCc8g1OvE8MJ//wfLZWR9EKeOz+zxQGrioRJure
   oaJSehEYVZU+V+JOAEr4QNhhK/yUEHprsobLoUbev4oDn0p54AzAVvseL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481014340"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481014340"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="15023957"
Received: from mdabrows-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.5.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:21 -0800
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] selftests/resctrl: Add helpers for the non-contiguous test
Date:   Tue, 12 Dec 2023 15:52:52 +0100
Message-ID: <c7b66a4682829894ec72d8a1f78e324233ef0535.1702392177.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CAT non-contiguous selftests have to read the file responsible for
reporting support of non-contiguous CBMs in Intel CAT. Then the test
compares if that information matches what is reported by CPUID output.

Add a generic helper function to read a chosen functionality support
information.

Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Added this patch.

 tools/testing/selftests/resctrl/resctrl.h   |  1 +
 tools/testing/selftests/resctrl/resctrlfs.c | 25 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 739e16d08a7b..8f72d94b9cbe 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -161,6 +161,7 @@ unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_full_cbm(const char *cache_type, unsigned long *mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
 int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
+int read_info_res_file(const char *resource, const char *filename);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 0e97036a64b8..70333440ff2f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -249,6 +249,31 @@ static int get_bit_mask(const char *filename, unsigned long *mask)
 	return 0;
 }
 
+int read_info_res_file(const char *resource, const char *filename)
+{
+	char file_path[PATH_MAX];
+	FILE *fp;
+	int ret;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s/%s", INFO_PATH, resource,
+		 filename);
+
+	fp = fopen(file_path, "r");
+	if (!fp) {
+		perror("Error in opening sparse_masks file\n");
+		return -1;
+	}
+
+	if (fscanf(fp, "%u", &ret) <= 0) {
+		perror("Could not get sparse_masks contents\n");
+		fclose(fp);
+		return -1;
+	}
+
+	fclose(fp);
+	return ret;
+}
+
 /*
  * create_bit_mask- Create bit mask from start, len pair
  * @start:	LSB of the mask
-- 
2.43.0

