Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC7C7BB9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjJFOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjJFOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3E83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:02:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B5EC433C8;
        Fri,  6 Oct 2023 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696600937;
        bh=GnDBzLeiJO9rHGMgH38lgzbD5twKIk+stCdHyTXedMo=;
        h=From:To:Cc:Subject:Date:From;
        b=o7MKdSoTcIH7SF3QLc6b7GGwb65MtiejbWn6YIukJCXeQpkM9uO2iJAio0UAiP+vr
         i7dRVkrLETyiCtAK+y4eNg5HYEIWQ4UgDx2GFs3SN+XeCmaGM8sOCcf9FNh9bkAXTS
         2I2/UKXDAFCfqxmbq52kGosVyhKdtc14Wg+f5SrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     nvdimm@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] testing: nvdimm: make struct class structures constant
Date:   Fri,  6 Oct 2023 16:02:12 +0200
Message-ID: <2023100611-platinum-galleria-ceb3@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Lines:  114
X-Developer-Signature: v=1; a=openpgp-sha256; l=3750; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=GnDBzLeiJO9rHGMgH38lgzbD5twKIk+stCdHyTXedMo=; b=owGbwMvMwCRo6H6F97bub03G02pJDKkKwinCWzlbNitWcoaeiP6f4rl5tc+2bUIKfpuZ9mof4 6o26DzSEcvCIMjEICumyPJlG8/R/RWHFL0MbU/DzGFlAhnCwMUpABORe8uw4KKak7PTQr4S9wfb Pp6QKtrw2fnQPYYFU6z27X0h/fm+a1W590G/k9tll35WAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver core allows for struct class to be in read-only
memory, we should make all 'class' structures declared at build time
placing them into read-only memory, instead of having to be dynamically
allocated at runtime.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/nvdimm/test/ndtest.c | 17 +++++++++--------
 tools/testing/nvdimm/test/nfit.c   | 14 +++++++-------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 3eba10c1e3e8..fd26189d53be 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -38,7 +38,11 @@ enum {
 
 static DEFINE_SPINLOCK(ndtest_lock);
 static struct ndtest_priv *instances[NUM_INSTANCES];
-static struct class *ndtest_dimm_class;
+
+static const struct class ndtest_dimm_class = {
+	.name = "nfit_test_dimm",
+};
+
 static struct gen_pool *ndtest_pool;
 
 static struct ndtest_dimm dimm_group1[] = {
@@ -737,7 +741,7 @@ static int ndtest_dimm_register(struct ndtest_priv *priv,
 		return -ENXIO;
 	}
 
-	dimm->dev = device_create_with_groups(ndtest_dimm_class,
+	dimm->dev = device_create_with_groups(&ndtest_dimm_class,
 					     &priv->pdev.dev,
 					     0, dimm, dimm_attribute_groups,
 					     "test_dimm%d", id);
@@ -906,8 +910,7 @@ static void cleanup_devices(void)
 		gen_pool_destroy(ndtest_pool);
 
 
-	if (ndtest_dimm_class)
-		class_destroy(ndtest_dimm_class);
+	class_unregister(&ndtest_dimm_class);
 }
 
 static __init int ndtest_init(void)
@@ -921,11 +924,9 @@ static __init int ndtest_init(void)
 
 	nfit_test_setup(ndtest_resource_lookup, NULL);
 
-	ndtest_dimm_class = class_create("nfit_test_dimm");
-	if (IS_ERR(ndtest_dimm_class)) {
-		rc = PTR_ERR(ndtest_dimm_class);
+	rc = class_regster(&ndtest_dimm_class);
+	if (rc)
 		goto err_register;
-	}
 
 	ndtest_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
 	if (!ndtest_pool) {
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 005043bd9623..a61df347a33d 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1712,7 +1712,9 @@ static void put_dimms(void *data)
 			device_unregister(t->dimm_dev[i]);
 }
 
-static struct class *nfit_test_dimm;
+static const struct class nfit_test_dimm = {
+	.name = "nfit_test_dimm",
+};
 
 static int dimm_name_to_id(struct device *dev)
 {
@@ -1830,7 +1832,7 @@ static int nfit_test_dimm_init(struct nfit_test *t)
 	if (devm_add_action_or_reset(&t->pdev.dev, put_dimms, t))
 		return -ENOMEM;
 	for (i = 0; i < t->num_dcr; i++) {
-		t->dimm_dev[i] = device_create_with_groups(nfit_test_dimm,
+		t->dimm_dev[i] = device_create_with_groups(&nfit_test_dimm,
 				&t->pdev.dev, 0, NULL,
 				nfit_test_dimm_attribute_groups,
 				"test_dimm%d", i + t->dcr_idx);
@@ -3276,11 +3278,9 @@ static __init int nfit_test_init(void)
 	if (!nfit_wq)
 		return -ENOMEM;
 
-	nfit_test_dimm = class_create("nfit_test_dimm");
-	if (IS_ERR(nfit_test_dimm)) {
-		rc = PTR_ERR(nfit_test_dimm);
+	rc = class_register(&nfit_test_dimm);
+	if (rc)
 		goto err_register;
-	}
 
 	nfit_pool = gen_pool_create(ilog2(SZ_4M), NUMA_NO_NODE);
 	if (!nfit_pool) {
@@ -3377,7 +3377,7 @@ static __exit void nfit_test_exit(void)
 
 	for (i = 0; i < NUM_NFITS; i++)
 		put_device(&instances[i]->pdev.dev);
-	class_destroy(nfit_test_dimm);
+	class_unregister(&nfit_test_dimm);
 }
 
 module_init(nfit_test_init);
-- 
2.42.0

