Return-Path: <linux-kernel+bounces-113507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43B8884DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC757284013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4571BA695;
	Sun, 24 Mar 2024 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L38ysjeI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1F1BA678;
	Sun, 24 Mar 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320308; cv=none; b=bc3jaNP3gh6Lu5+HZz/fXuowZQ/rwv9ISK6bww/NsdA8jGxA+x6EgaJfidUveWOYIeE2TyDsLrHcvkipMXITifkAYNSMTNzwblaZnN9tEG783MLVdrM5kJwC5DwIxhbGY9rJy23FlKDCNrkUtSpvZbxcppSvKl/8RNq9co1ab4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320308; c=relaxed/simple;
	bh=8vpEhollN7cagCjBWs/Y6TSOmi/aAVQfQQl8Hl6qOKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpEO+Pa7QcjvmJhL36fwtwBdaLrUSOrXRV/7kOya9yL87ysX0WChTew/t2grO9s0ZO1zs0ii6iR5isV6zd1yRY6SYWv87y+Bkv25yFzvrm4FAPy1kRYEp+TrDqn+V00yntaQlp5QBuvkaIdVRHz4UtSKb3Axyf+2WFprnLnBN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L38ysjeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0200C433B2;
	Sun, 24 Mar 2024 22:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320308;
	bh=8vpEhollN7cagCjBWs/Y6TSOmi/aAVQfQQl8Hl6qOKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L38ysjeIcE7sCKvEJh13DxA5r4WUXDBDB9qr6Rs6i+4InYBe+rYscsXcUNy5ZpzzW
	 VPDsn76td8PUEGJwv5uywuw5IWl5QKQLScLod+WIDjww6ayL4RIwmYcKukcQx1YGyB
	 JjHjcVEgadIK1etTlyNNpape1MkYpfEcyuaZSOQn4S/RPNzF+lPdq1Cy9cliXMI9G4
	 6OSn0i6Nt8cHf+HGvS3HuNBAifJpyTJscf05iXOt34LElZGd7D9GrIm6nA4mKHGOxK
	 1iYAWlpHkGzJAygxxd7eWoc8eTb9oDyIc0l1Oh5guJWKwGcCVyKvvAAub4PvgegpwP
	 qh9llwfO6crpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 616/715] coresight: Fix issue where a source device's helpers aren't disabled
Date: Sun, 24 Mar 2024 18:33:15 -0400
Message-ID: <20240324223455.1342824-617-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

[ Upstream commit f68bbe4dcfa303164922bc331d2e8d38ed2d4f23 ]

The linked commit reverts the change that accidentally used some sysfs
enable/disable functions from Perf which broke the refcounting, but it
also removes the fact that the sysfs disable function disabled the
helpers.

Add a new wrapper function that does both which is used by both Perf and
sysfs, and label the sysfs disable function appropriately. The naming of
all of the functions will be tidied up later to avoid this happening
again.

Fixes: 287e82cf69aa ("coresight: Fix crash when Perf and sysfs modes are used concurrently")
Signed-off-by: James Clark <james.clark@arm.com>
Link: https://lore.kernel.org/r/20240129154050.569566-2-james.clark@arm.com
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c  | 30 ++++++++++++++-----
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d7f0e231feb99..965bb6d4e1bf4 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -441,8 +441,26 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
 	}
 }
 
+/*
+ * Helper function to call source_ops(csdev)->disable and also disable the
+ * helpers.
+ *
+ * There is an imbalance between coresight_enable_path() and
+ * coresight_disable_path(). Enabling also enables the source's helpers as part
+ * of the path, but disabling always skips the first item in the path (which is
+ * the source), so sources and their helpers don't get disabled as part of that
+ * function and we need the extra step here.
+ */
+void coresight_disable_source(struct coresight_device *csdev, void *data)
+{
+	if (source_ops(csdev)->disable)
+		source_ops(csdev)->disable(csdev, data);
+	coresight_disable_helpers(csdev);
+}
+EXPORT_SYMBOL_GPL(coresight_disable_source);
+
 /**
- *  coresight_disable_source - Drop the reference count by 1 and disable
+ *  coresight_disable_source_sysfs - Drop the reference count by 1 and disable
  *  the device if there are no users left.
  *
  *  @csdev: The coresight device to disable
@@ -451,17 +469,15 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
  *
  *  Returns true if the device has been disabled.
  */
-bool coresight_disable_source(struct coresight_device *csdev, void *data)
+static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
+					   void *data)
 {
 	if (atomic_dec_return(&csdev->refcnt) == 0) {
-		if (source_ops(csdev)->disable)
-			source_ops(csdev)->disable(csdev, data);
-		coresight_disable_helpers(csdev);
+		coresight_disable_source(csdev, data);
 		csdev->enable = false;
 	}
 	return !csdev->enable;
 }
-EXPORT_SYMBOL_GPL(coresight_disable_source);
 
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
@@ -1204,7 +1220,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable || !coresight_disable_source(csdev, NULL))
+	if (!csdev->enable || !coresight_disable_source_sysfs(csdev, NULL))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index a52cfcce25d6d..c0c60e6a1703e 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -589,7 +589,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	/* stop tracer */
-	source_ops(csdev)->disable(csdev, event);
+	coresight_disable_source(csdev, event);
 
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e079701..30c051055e54b 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -233,6 +233,6 @@ void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
 struct coresight_device *coresight_get_percpu_sink(int cpu);
 int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
 			    void *data);
-bool coresight_disable_source(struct coresight_device *csdev, void *data);
+void coresight_disable_source(struct coresight_device *csdev, void *data);
 
 #endif
-- 
2.43.0


