Return-Path: <linux-kernel+bounces-115044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB07888CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B741C2A431
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3812EE7C9;
	Mon, 25 Mar 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njn3pCEL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D252853E1;
	Sun, 24 Mar 2024 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323827; cv=none; b=kdPX2Mwd/+D8BV/Xsq5QqtIuW81abLvb05kFwrH98iYCx8JR+NGsfdSiMuWqKpje+4Mr/SdawxkqV02ApO3b4oH+4MM7jAaxRmi4lcALOmwXztwRviXYWmvHptEwaf6KyNL27d1AgIFskE3UOVXR/32haGrd0f29z6wuOBDvltI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323827; c=relaxed/simple;
	bh=yD4s/Cc2n0W607Y/9dSf8d3YTH3Ld1KqT/zEpJQqr0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sum1rnwcAfbREzxfZSRsm8Cwq5EPcxaBEykCb5Gikq9qVghw+qFxu29ptD29SXrJcSOu0jrOvLD494vBDWP+yDwNiYOSvnkAmHsph8jCyBxYviqER5UXZL4xB/xVZmhmLGX8FAbtD9omuxeF9t+o4ZAOWnSdt5MWfBsf0ceMmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njn3pCEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B6C433C7;
	Sun, 24 Mar 2024 23:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323826;
	bh=yD4s/Cc2n0W607Y/9dSf8d3YTH3Ld1KqT/zEpJQqr0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Njn3pCELI8bpEQ3NYaRack6MI3rmVdhz5cjiqQdzpEZh4iaGbhwwp5UWX9D8X5Gob
	 mHfjl8FR6hLdOU0+3w8UrD0f48ZyLRPPVkW9O4x0hjSVQ4j67NSODjNoHHYOO1r+bZ
	 saxdku33LrhvAD7jPTBx34HlaU1j/8mIkllqXOqYlKEo5ZS+hA2ja3cOsGby6A5ZE5
	 tNrO7rm626GhBchEe3mZF5rCU5KcK/txnCNEKSa2wUBGk3WV+YTVZi7uyncRwXsVsu
	 0dXhmILacKG+h9ogm5xsHnjgrtKpaGTpKKwB+FOWZLysSmaqtl9myjbwaeaFYoheqd
	 aLNI3JN0zawVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 205/238] remoteproc: Add new get_loaded_rsc_table() to rproc_ops
Date: Sun, 24 Mar 2024 19:39:53 -0400
Message-ID: <20240324234027.1354210-206-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Mathieu Poirier <mathieu.poirier@linaro.org>

[ Upstream commit 1a631382be1d22ddab0582dae3498b3d28e2e44a ]

Add a new get_loaded_rsc_table() operation in order to support
scenarios where the remoteproc core has booted a remote processor
and detaches from it.  When re-attaching to the remote processor,
the core needs to know where the resource table has been placed
in memory.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Link: https://lore.kernel.org/r/20210312162453.1234145-6-mathieu.poirier@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 32381bbccba4 ("remoteproc: stm32: Fix incorrect type in assignment for va")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/remoteproc_core.c     | 32 ++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h | 10 ++++++++
 include/linux/remoteproc.h               |  6 ++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index cc55ff0128cf2..a933e345683c4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1539,6 +1539,32 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
+static int rproc_set_rsc_table(struct rproc *rproc)
+{
+	struct resource_table *table_ptr;
+	struct device *dev = &rproc->dev;
+	size_t table_sz;
+	int ret;
+
+	table_ptr = rproc_get_loaded_rsc_table(rproc, &table_sz);
+	if (!table_ptr) {
+		/* Not having a resource table is acceptable */
+		return 0;
+	}
+
+	if (IS_ERR(table_ptr)) {
+		ret = PTR_ERR(table_ptr);
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		return ret;
+	}
+
+	rproc->cached_table = NULL;
+	rproc->table_ptr = table_ptr;
+	rproc->table_sz = table_sz;
+
+	return 0;
+}
+
 /*
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
@@ -1558,6 +1584,12 @@ static int rproc_actuate(struct rproc *rproc)
 		return ret;
 	}
 
+	ret = rproc_set_rsc_table(rproc);
+	if (ret) {
+		dev_err(dev, "can't load resource table: %d\n", ret);
+		goto disable_iommu;
+	}
+
 	/* reset max_notifyid */
 	rproc->max_notifyid = -1;
 
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index c34002888d2c3..4f73aac7e60d1 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -177,6 +177,16 @@ struct resource_table *rproc_find_loaded_rsc_table(struct rproc *rproc,
 	return NULL;
 }
 
+static inline
+struct resource_table *rproc_get_loaded_rsc_table(struct rproc *rproc,
+						  size_t *size)
+{
+	if (rproc->ops->get_loaded_rsc_table)
+		return rproc->ops->get_loaded_rsc_table(rproc, size);
+
+	return NULL;
+}
+
 static inline
 bool rproc_u64_fit_in_size_t(u64 val)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 3fa3ba6498e87..2546758f13eb0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -368,7 +368,9 @@ enum rsc_handling_status {
  * RSC_HANDLED if resource was handled, RSC_IGNORED if not handled and a
  * negative value on error
  * @load_rsc_table:	load resource table from firmware image
- * @find_loaded_rsc_table: find the loaded resouce table
+ * @find_loaded_rsc_table: find the loaded resource table from firmware image
+ * @get_loaded_rsc_table: get resource table installed in memory
+ *			  by external entity
  * @load:		load firmware to memory, where the remote processor
  *			expects to find it
  * @sanity_check:	sanity check the fw image
@@ -389,6 +391,8 @@ struct rproc_ops {
 			  int offset, int avail);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
+	struct resource_table *(*get_loaded_rsc_table)(
+				struct rproc *rproc, size_t *size);
 	int (*load)(struct rproc *rproc, const struct firmware *fw);
 	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
-- 
2.43.0


