Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEF75BF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGUHJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjGUHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:09:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257D273E;
        Fri, 21 Jul 2023 00:09:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5BB261416;
        Fri, 21 Jul 2023 07:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA145C433CA;
        Fri, 21 Jul 2023 07:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689923378;
        bh=MY8zoSsf9fgRkDcy3MJpnTeax5YDOFKq4s0E/rUA/rE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=QCz4J47ztfPLM+FQOIBqYlXwzBrf8lVvgOXQs8+oRZor1xHKr/BZXOze6pUVPQS4E
         Udm99VWZyU8iIYwg9ip5koylLFCXWKi7dTusE58hOuOXsccSAyYdPFng9GDdYcLqXK
         6dpRD1zvipmV9paBFQS0kEsnYUaDVbOXrqezqa407/3PzGY1sPIIKg/vBLDSzL8OMU
         IKr+hG0PvIR24pX30uh+iPIr1B2lT45H1Mg8v7NjHYNX4L0A7tJ+2F2MTwQR2e9Tzv
         Dt0kK1G8VxM19aeJafN5k7RiDOiuj9XEovkOEXWOLdF+vUmQpblZMbRMz3gcxtBA85
         8bg/PNwOVDyVA==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Fri, 21 Jul 2023 09:09:32 +0200
Subject: [PATCH 1/2] clk: Introduce kunit wrapper around
 clk_hw_init_rate_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-clk-fix-kunit-lockdep-v1-1-32cdba4c8fc1@kernel.org>
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
In-Reply-To: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        kernel test robot <yujie.liu@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3879; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MY8zoSsf9fgRkDcy3MJpnTeax5YDOFKq4s0E/rUA/rE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCm79HW2OW2yclFfd3DdyTpX94aposc1xc5XpVi8lBBd2
 3vc89uUjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkXQcjw4tV517GiWVOnvC7
 6XCb8NHrta7rbx35M7F5LU9hdVFR7xKG/x6yuttlIhkalnwKjyux35p69rlqY2u0+eFJHG9Xyk+
 NZQEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some kunit tests are meant to test the behaviour of providers (and
most notably __clk_determine_rate()), but don't run those functions with
the clk prepare_lock held which results in lockdep warning.

clk_hw_init_rate_request is one of the functions being executed from a
test which should have the lock held. Let's introduce a wrapper around
it meant to be used only by kunit tests.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/linux-clk/2b594e50-2bbf-4a2d-88e6-49fc39f3957a@roeck-us.net/
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/oe-lkp/202301310919.b9d56ee3-yujie.liu@intel.com
Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
 drivers/clk/clk_test.c       |  2 +-
 include/linux/clk-provider.h | 11 +++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..8ee9bd02af76 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -6,6 +6,7 @@
  * Standard functionality for the common clock API.  See Documentation/driver-api/clk.rst
  */
 
+#include <kunit/test-bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
@@ -1556,6 +1557,31 @@ void clk_hw_init_rate_request(const struct clk_hw *hw,
 }
 EXPORT_SYMBOL_GPL(clk_hw_init_rate_request);
 
+#if IS_ENABLED(CONFIG_KUNIT)
+/**
+ * clk_kunit_init_rate_request - Initializes a clk_rate_request
+ * @hw: the clk for which we want to submit a rate request
+ * @req: the clk_rate_request structure we want to initialise
+ * @rate: the rate which is to be requested
+ *
+ * Initializes a clk_rate_request structure to submit to
+ * __clk_determine_rate() or similar functions. Only usable in kunit
+ * test contexts, use clk_hw_init_rate_request() otherwise.
+ */
+void clk_kunit_init_rate_request(const struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long rate)
+{
+	if (!kunit_get_current_test())
+		return;
+
+	clk_prepare_lock();
+	clk_hw_init_rate_request(hw, req, rate);
+	clk_prepare_unlock();
+}
+EXPORT_SYMBOL_GPL(clk_kunit_init_rate_request);
+#endif
+
 /**
  * clk_hw_forward_rate_request - Forwards a clk_rate_request to a clock's parent
  * @hw: the original clock that got the rate request
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index a154ec9d0111..a64f7036baa3 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2230,7 +2230,7 @@ static void clk_leaf_mux_set_rate_parent_determine_rate(struct kunit *test)
 	rate = clk_get_rate(clk);
 	KUNIT_ASSERT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
 
-	clk_hw_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
+	clk_kunit_init_rate_request(hw, &req, DUMMY_CLOCK_RATE_2);
 
 	ret = __clk_determine_rate(hw, &req);
 	KUNIT_ASSERT_EQ(test, ret, 0);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0f0cd01906b4..efdebfa3fce9 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -67,6 +67,17 @@ struct clk_rate_request {
 void clk_hw_init_rate_request(const struct clk_hw *hw,
 			      struct clk_rate_request *req,
 			      unsigned long rate);
+#if IS_ENABLED(CONFIG_KUNIT)
+void clk_kunit_init_rate_request(const struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long rate);
+#else
+static inline void clk_kunit_init_rate_request(const struct clk_hw *hw,
+					       struct clk_rate_request *req,
+					       unsigned long rate)
+{
+}
+#endif
 void clk_hw_forward_rate_request(const struct clk_hw *core,
 				 const struct clk_rate_request *old_req,
 				 const struct clk_hw *parent,

-- 
2.41.0

