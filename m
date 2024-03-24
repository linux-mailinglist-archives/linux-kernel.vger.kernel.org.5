Return-Path: <linux-kernel+bounces-114031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37A5888F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D32F28A8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067C22BBFF;
	Sun, 24 Mar 2024 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7s20LXM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B251FC0E7;
	Sun, 24 Mar 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321312; cv=none; b=X565GVyDQGNpG8EWztvOOJnxlBoQE2hxgnlrAnwPimyqh+MJVkjaG9Zkp84hKcfN4J8pc5w21GKVqlSR/ZVrWArvUZJXUmVlR81/iJosGDiX9vpo7InDdSA4j9yy/8HHYlQ0B7uau14H45a01FjhGzJmPj30KhBtp3JgWgYDWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321312; c=relaxed/simple;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qf5LVAYc9YmHomHo6hMTd1k77wsyJFqy+s2SgDtP4BgdpCZqXsxZKFRdhVM/hlh7ZX8HAj11xCi4r+mTmRVEukqYlx58Z0iE1XoA0mFdKgXOYBA1bnjRRAjQWZ1ZByQEQdT26I1uD4+GcnYdQotF7cTyzBamoLfKrcfHxY+/IAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7s20LXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9962AC43399;
	Sun, 24 Mar 2024 23:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321311;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7s20LXMiADAQcDy1CSaKC+0MDpPTMeNmyarj4O/JAZ6XeIzHW+zFIGjIqf10QnEm
	 BkbEDgzTDqaW9qNkf0uKG6KsZdZtAFDgrbS3XPT6uxKkdo3oRO6+L6B0HbdGNjyq0k
	 kunuZvYQ99ayW2NY10gUvDvPvXCIAPZWnIFEgdCsaLVo3ruPgbyjXffKMFaNQrm98F
	 PaS0V0BdzD6H2hNhu/0XUzmX9pF4GJ8ENo3kfjFZ5RmdNb+ir8wtHbSh3pOWS0Puwq
	 iQwYOPzLvF49QgwtNdZ48if8Zxx3JwlDCio7yNUrJzd/mOavHVVO7cIRjL0F4NTPut
	 HXW/Bre14kJPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hojin Nam <hj96.nam@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 034/638] perf: CXL: fix CPMU filter value mask length
Date: Sun, 24 Mar 2024 18:51:11 -0400
Message-ID: <20240324230116.1348576-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Hojin Nam <hj96.nam@samsung.com>

[ Upstream commit 802379b8f9e169293e9ba7089e5f1a6340e2e7a3 ]

CPMU filter value is described as 4B length in CXL r3.0 8.2.7.2.2.
However, it is used as 2B length in code and comments.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
Link: https://lore.kernel.org/r/20240216014522.32321-1-hj96.nam@samsung.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/cxl_pmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index bc0d414a6aff9..308c9969642e1 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -59,7 +59,7 @@
 #define   CXL_PMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK	GENMASK_ULL(63, 59)
 
 #define CXL_PMU_FILTER_CFG_REG(n, f)	(0x400 + 4 * ((f) + (n) * 8))
-#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(15, 0)
+#define   CXL_PMU_FILTER_CFG_VALUE_MSK			GENMASK(31, 0)
 
 #define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
 
@@ -314,9 +314,9 @@ static bool cxl_pmu_config1_get_edge(struct perf_event *event)
 }
 
 /*
- * CPMU specification allows for 8 filters, each with a 16 bit value...
- * So we need to find 8x16bits to store it in.
- * As the value used for disable is 0xffff, a separate enable switch
+ * CPMU specification allows for 8 filters, each with a 32 bit value...
+ * So we need to find 8x32bits to store it in.
+ * As the value used for disable is 0xffff_ffff, a separate enable switch
  * is needed.
  */
 
@@ -642,7 +642,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 		if (cxl_pmu_config1_hdm_filter_en(event))
 			cfg = cxl_pmu_config2_get_hdm_decoder(event);
 		else
-			cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
+			cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
 		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
 	}
 
-- 
2.43.0


