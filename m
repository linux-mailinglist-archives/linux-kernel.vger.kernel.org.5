Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE280EF5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376962AbjLLOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376965AbjLLOxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:53:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72115E3;
        Tue, 12 Dec 2023 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702392797; x=1733928797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jcr2FtX75/VKzbUe5j+yQUXHStpz5ABl2PqxNo5qGOI=;
  b=B0XUR+4k0SBkrwiCKGCYuueNdNp08wqhdmXpJKaTTIqZknkN/PH/WyrS
   RvQqM2W6R+yKcZgjkJn1sKQQxGIP5hr9zDeLqTwbNyquIIpDMuDZwRnNL
   z1ZoL6eSTWJBNm11uRTrRgbR8VRg8ucHfnrv6ylzPxNTnhD9vwAZKc4ax
   8ypWsmeG2sMDikKB/EU+hCaMkpqQ6jH+3b8fevXL7v+4ABBauIjxOzeQr
   gaPK6pNV3k69UymEZlAn3bhG2i6/zwUrJoSDH5Paoqk+e2h4B1orJ36IT
   oIj5b/G+yuzmCqhNc6s8joA21og+LlME10fNsl4gOrdG9M/aZU1/u8kKl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="481014336"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="481014336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="15023887"
Received: from mdabrows-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.5.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 06:53:14 -0800
From:   Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/4] selftests/resctrl: Add test groups and name L3 CAT test L3_CAT
Date:   Tue, 12 Dec 2023 15:52:51 +0100
Message-ID: <de2ea86256f0026989e6836f9e731be3667c7afe.1702392177.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
References: <cover.1702392177.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

To select test to run -t parameter can be used. However, -t cat
currently maps to L3 CAT test which is confusing after more CAT related
tests are added.

Allow selecting tests as groups and call L3 CAT test "L3_CAT", "CAT"
group will enable all CAT related tests.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
Changelog v2:
- Move this patch from Ilpo's series here (Ilpo).

 tools/testing/selftests/resctrl/cat_test.c      |  3 ++-
 tools/testing/selftests/resctrl/resctrl.h       |  2 ++
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++++++++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 24af8310288a..39fc9303b8e8 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -295,7 +295,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 }
 
 struct resctrl_test l3_cat_test = {
-	.name = "CAT",
+	.name = "L3_CAT",
+	.group = "CAT",
 	.resource = "L3",
 	.feature_check = test_resource_feature_check,
 	.run_test = cat_run_test,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c54efcf1412a..739e16d08a7b 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -65,6 +65,7 @@ struct user_params {
 /*
  * resctrl_test:	resctrl test definition
  * @name:		Test name
+ * @group:		Test group (e.g., L2 and L3 CAT test belong to CAT group), can be NULL
  * @resource:		Resource to test (e.g., MB, L3, L2, etc.)
  * @vendor_specific:	Bitmask for vendor-specific tests (can be 0 for universal tests)
  * @disabled:		Test is disabled
@@ -73,6 +74,7 @@ struct user_params {
  */
 struct resctrl_test {
 	const char	*name;
+	const char	*group;
 	const char	*resource;
 	unsigned int	vendor_specific;
 	bool		disabled;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 75fc49ba3efb..3044179ee6e9 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -65,11 +65,15 @@ static void cmd_help(void)
 	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
 	printf("\t-b benchmark_cmd [option]...: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
-	printf("\t-t test list: run tests specified in the test list, ");
+	printf("\t-t test list: run tests/groups specified by the list, ");
 	printf("e.g. -t mbm,mba,cmt,cat\n");
-	printf("\t\tSupported tests:\n");
-	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
-		printf("\t\t\t%s\n", resctrl_tests[i]->name);
+	printf("\t\tSupported tests (group):\n");
+	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
+		if (resctrl_tests[i]->group)
+			printf("\t\t\t%s (%s)\n", resctrl_tests[i]->name, resctrl_tests[i]->group);
+		else
+			printf("\t\t\t%s\n", resctrl_tests[i]->name);
+	}
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -199,7 +203,9 @@ int main(int argc, char **argv)
 				bool found = false;
 
 				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
-					if (!strcasecmp(token, resctrl_tests[i]->name)) {
+					if (!strcasecmp(token, resctrl_tests[i]->name) ||
+					    (resctrl_tests[i]->group &&
+					     !strcasecmp(token, resctrl_tests[i]->group))) {
 						if (resctrl_tests[i]->disabled)
 							tests++;
 						resctrl_tests[i]->disabled = false;
-- 
2.43.0

