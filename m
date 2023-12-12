Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A580A80F22F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376990AbjLLP42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjLLPzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:55:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42E5CD7F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:55:37 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37A2B1516;
        Tue, 12 Dec 2023 07:56:23 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62DE23F738;
        Tue, 12 Dec 2023 07:55:35 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 8/8] coresight: Remove unused stubs
Date:   Tue, 12 Dec 2023 15:54:05 +0000
Message-Id: <20231212155407.1429121-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212155407.1429121-1-james.clark@arm.com>
References: <20231212155407.1429121-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are a bit annoying to keep up to date when the function signatures
change. But if CONFIG_CORESIGHT isn't enabled, then they're not used
anyway so just delete them.

Signed-off-by: James Clark <james.clark@arm.com>
---
 include/linux/coresight.h | 79 ---------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4400d554a16b..c5be46d7f85c 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -391,8 +391,6 @@ struct coresight_ops {
 	const struct coresight_ops_helper *helper_ops;
 };
 
-#if IS_ENABLED(CONFIG_CORESIGHT)
-
 static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
 					      u32 offset)
 {
@@ -611,83 +609,6 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
-#else
-static inline struct coresight_device *
-coresight_register(struct coresight_desc *desc) { return NULL; }
-static inline void coresight_unregister(struct coresight_device *csdev) {}
-static inline int
-coresight_enable_sysfs(struct coresight_device *csdev) { return -ENOSYS; }
-static inline void coresight_disable_sysfs(struct coresight_device *csdev) {}
-
-static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
-				    int position, int value)
-{
-	return 1;
-}
-
-static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
-{
-	return -EINVAL;
-}
-
-static inline int coresight_claim_device(struct coresight_device *csdev)
-{
-	return -EINVAL;
-}
-
-static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
-static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
-
-static inline bool coresight_loses_context_with_cpu(struct device *dev)
-{
-	return false;
-}
-
-static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
-{
-}
-
-static inline void coresight_relaxed_write32(struct coresight_device *csdev,
-					     u32 val, u32 offset)
-{
-}
-
-static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
-					   u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
-{
-	WARN_ON_ONCE(1);
-	return 0;
-}
-
-static inline void coresight_relaxed_write64(struct coresight_device *csdev,
-					     u64 val, u32 offset)
-{
-}
-
-static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
-{
-}
-
-#endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
-
 extern int coresight_get_cpu(struct device *dev);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
-- 
2.34.1

