Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A7980F19D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbjLLPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376735AbjLLPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:55:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D95712F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:55:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05E23143D;
        Tue, 12 Dec 2023 07:56:03 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 322E13F738;
        Tue, 12 Dec 2023 07:55:15 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/8] coresight: Remove ops callback checks
Date:   Tue, 12 Dec 2023 15:54:00 +0000
Message-Id: <20231212155407.1429121-4-james.clark@arm.com>
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

The check for the existence of callbacks before using them implies that
this happens and is supported. There are no devices without
enable/disable callbacks, and it wouldn't be possible to add a new
working device without adding them either, so just remove them.

Furthermore, there are more callbacks than just enable and disable that
are already used unguarded in other places.

The comment about new session compatibility doesn't seem to match up to
the line of code that it's on so remove it. I think it's alluding to the
fact that sinks will check if they were already enabled via sysfs or
Perf and fail the enable. But there are more detailed comments at those
places, and this one isn't very useful.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 51 +++++---------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index f79aa9ff9b64..ab226441e5f4 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -279,16 +279,8 @@ EXPORT_SYMBOL_GPL(coresight_add_helper);
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 enum cs_mode mode, void *data)
 {
-	int ret;
-
-	/*
-	 * We need to make sure the "new" session is compatible with the
-	 * existing "mode" of operation.
-	 */
-	if (!sink_ops(csdev)->enable)
-		return -EINVAL;
+	int ret = sink_ops(csdev)->enable(csdev, mode, data);
 
-	ret = sink_ops(csdev)->enable(csdev, mode, data);
 	if (ret)
 		return ret;
 
@@ -299,12 +291,7 @@ static int coresight_enable_sink(struct coresight_device *csdev,
 
 static void coresight_disable_sink(struct coresight_device *csdev)
 {
-	int ret;
-
-	if (!sink_ops(csdev)->disable)
-		return;
-
-	ret = sink_ops(csdev)->disable(csdev);
+	int ret = sink_ops(csdev)->disable(csdev);
 	if (ret)
 		return;
 	csdev->enable = false;
@@ -330,11 +317,9 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && IS_ERR(outconn))
 		return PTR_ERR(outconn);
 
-	if (link_ops(csdev)->enable) {
-		ret = link_ops(csdev)->enable(csdev, inconn, outconn);
-		if (!ret)
-			csdev->enable = true;
-	}
+	ret = link_ops(csdev)->enable(csdev, inconn, outconn);
+	if (!ret)
+		csdev->enable = true;
 
 	return ret;
 }
@@ -354,9 +339,7 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	outconn = coresight_find_out_connection(csdev, child);
 	link_subtype = csdev->subtype.link_subtype;
 
-	if (link_ops(csdev)->disable) {
-		link_ops(csdev)->disable(csdev, inconn, outconn);
-	}
+	link_ops(csdev)->disable(csdev, inconn, outconn);
 
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
 		for (i = 0; i < csdev->pdata->nr_inconns; i++)
@@ -382,11 +365,9 @@ int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
 	int ret;
 
 	if (!csdev->enable) {
-		if (source_ops(csdev)->enable) {
-			ret = source_ops(csdev)->enable(csdev, data, mode);
-			if (ret)
-				return ret;
-		}
+		ret = source_ops(csdev)->enable(csdev, data, mode);
+		if (ret)
+			return ret;
 		csdev->enable = true;
 	}
 
@@ -404,11 +385,8 @@ static bool coresight_is_helper(struct coresight_device *csdev)
 static int coresight_enable_helper(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data)
 {
-	int ret;
+	int ret = helper_ops(csdev)->enable(csdev, mode, data);
 
-	if (!helper_ops(csdev)->enable)
-		return 0;
-	ret = helper_ops(csdev)->enable(csdev, mode, data);
 	if (ret)
 		return ret;
 
@@ -418,12 +396,8 @@ static int coresight_enable_helper(struct coresight_device *csdev,
 
 static void coresight_disable_helper(struct coresight_device *csdev)
 {
-	int ret;
-
-	if (!helper_ops(csdev)->disable)
-		return;
+	int ret = helper_ops(csdev)->disable(csdev, NULL);
 
-	ret = helper_ops(csdev)->disable(csdev, NULL);
 	if (ret)
 		return;
 	csdev->enable = false;
@@ -453,8 +427,7 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
  */
 void coresight_disable_source(struct coresight_device *csdev, void *data)
 {
-	if (source_ops(csdev)->disable)
-		source_ops(csdev)->disable(csdev, data);
+	source_ops(csdev)->disable(csdev, data);
 	coresight_disable_helpers(csdev);
 }
 EXPORT_SYMBOL_GPL(coresight_disable_source);
-- 
2.34.1

