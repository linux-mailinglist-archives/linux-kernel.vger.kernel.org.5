Return-Path: <linux-kernel+bounces-87449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2E86D48B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCDF1C21A92
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A02154429;
	Thu, 29 Feb 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pn9r1q9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6841153BE6;
	Thu, 29 Feb 2024 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239084; cv=none; b=JEyr/T8dPIuAlyuRNOl4CWN+pn1yRrDHDIaH+DoVYLt/edMKlqSRu7CqSoDaZDLpXDzSV6yuSxh+nzHVIlT4CeidUnfiWEl57V0h+jQfR46WQFSTKOJuqfLUmoQs+MOEnXIH6BniTUF5VcASHh74LuD1qNTo0vDtMIQ5gxPaKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239084; c=relaxed/simple;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMLQmoSYvKuBkqI+qpmMaJlyfQAKMHXRZiK4WbM7okDL2BPm6pl0webmmKz3k6mz0lgmZ3V0AArqPBGcGx40njNwPVXVGxpQBUKEb4L3S/c3Jsar8OWcNmX6e4wdJvbeEvLQn8vXiY/Wsp8EocT2zKv3HFGruR95vRtke96QllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pn9r1q9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39702C433C7;
	Thu, 29 Feb 2024 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239083;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pn9r1q9R0WLyERB/yDfHBti8aaF0pJO7UJqRLn0JqgGfbuIZ0w0whZ/5MzSYtLG3h
	 eNrOe/5zpYwxaArEgFDuEr0CU2EpTsQ5enyKodU/RdoG8PeCjvoFdnslChJt/D7kpV
	 v5mRcow+a2GVoUzocNqTwoDPFR/aGsYWCRIlHbWuIpPfPv8QxLEFHEpRBH0zJohOP9
	 fxaMuXeyK/imGaknu86I001Xq11RGz+h2WVCo4XTaKoUttIZuiZ6zvJVDjOMjzAqhj
	 V/nXAU0XqHNwuw9jJdmRz822V9Ted4y2Rl3hKGN+Z89Nrhj8rMHCWPOd0hzvA5asdc
	 Hfr/Sf/NqBNuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hojin Nam <hj96.nam@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jonathan.cameron@huawei.com,
	mark.rutland@arm.com,
	linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 16/24] perf: CXL: fix CPMU filter value mask length
Date: Thu, 29 Feb 2024 15:36:56 -0500
Message-ID: <20240229203729.2860356-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203729.2860356-1-sashal@kernel.org>
References: <20240229203729.2860356-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.6
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


