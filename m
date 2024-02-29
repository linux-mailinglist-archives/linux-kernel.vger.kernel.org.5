Return-Path: <linux-kernel+bounces-87474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 236E386D4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C911F243B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94315FE29;
	Thu, 29 Feb 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy3/fMOt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15E15FE17;
	Thu, 29 Feb 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239207; cv=none; b=bFYunWaqQHwym84RpqLAOupmWEnmR6WLWCpz5fr8wSgt/Ou+vjiExlR8w34TdxSabefRWokKMldYAsegfcV5iQoX6llML4jsbEtwDx8r6cKK84MxB5zRPJ0KUupcNbZNWoceX6nu/ELI1GOPxH+SY1y2JZofQZke6Vgo9n8XCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239207; c=relaxed/simple;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=la/8w98spqavpPkM4TeXooC2liQUqizdC2xPINLjwRKnGMUVxV+XmsrTnkJFux24G27ve8VoXwzmiE4wcymYyi/wz84UlNPZ8qvP3JnvkEYDCNjKWU/vQPq1sxg8QDfbDG0fkl0y2AThN8UeaayOO1oBcEHs15xVedhwvH+GJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy3/fMOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F4FC43399;
	Thu, 29 Feb 2024 20:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239206;
	bh=45ZrZ9a6InGLOX3zCd/VX2084a+7yRSkog5VZIcOYcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gy3/fMOti/adMjE74HoKA8FR6MWUiXGnnMcm5UvGvd04Cf/uKsFpfk224VBNsmN5s
	 RYMAcePPOkuzzRopwKhjo6Y3Bb1YskqBvdpSGEv/kdd9TKDkaQ7+kSiXPhV8d1HmLz
	 1FlA169eh+7lV4QkFi2NDXGq3WK2g24uvhT1rrsIH1jufLUMroUviY6v58IKD+6YC0
	 xxL2ZfgvacWtLjjUiHtJKRD7APgwqImIRAs0tkKgE8iACRl4+pjlwR/rVH4jbVCbJX
	 urExGHfWNLsyrh+WhXp77Nt11Qckcl3iBh878Ere93N/QvDenKLPemcGlv1v/P2Oh3
	 TG1AaSQRld8Qw==
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
Subject: [PATCH AUTOSEL 6.6 15/22] perf: CXL: fix CPMU filter value mask length
Date: Thu, 29 Feb 2024 15:39:08 -0500
Message-ID: <20240229203933.2861006-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229203933.2861006-1-sashal@kernel.org>
References: <20240229203933.2861006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


