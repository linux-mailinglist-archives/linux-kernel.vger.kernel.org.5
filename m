Return-Path: <linux-kernel+bounces-43015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC009840A47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7B41C216DC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBC3155303;
	Mon, 29 Jan 2024 15:41:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F37C1552E9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542896; cv=none; b=Jff9dOKrHL8dwNhJlMzNmGltITZ4y1d+XYMoBtt7xCyvGBqE2x3ftGBpoXlBK01eGwxPYN75T853SWIqUvCVH85uA9jL5gS7KnxQe04EvfaUMKmwa19PWobOJLi1N/S2Y5U7bU9KVdzGZ7X8gPAJSKfJpGf5tove1s6/KFSiw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542896; c=relaxed/simple;
	bh=mImXg8UpCITn7T6yfBNMloggvtr5MFhdUPNpoyuY0iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GT/YyheBKPF2VqY96YS9ayK/eWr10nOYNJiv7MgG4u2/8m9aLR9CizPAXFHGnYy9VZehgHcknS5AiKoy+k45zK6p204b75gjX9dnAd76YpP4GZz2n8xuzV7i+oBCB5GeDdtCdEH+s/ku1l6MwKxLOqnX31v+KgqXbak2PduODAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEEC4DA7;
	Mon, 29 Jan 2024 07:42:17 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DB033F738;
	Mon, 29 Jan 2024 07:41:31 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 03/12] coresight: Remove ops callback checks
Date: Mon, 29 Jan 2024 15:40:34 +0000
Message-Id: <20240129154050.569566-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129154050.569566-1-james.clark@arm.com>
References: <20240129154050.569566-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 2bb74ad8f68b..37767656bf9d 100644
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


