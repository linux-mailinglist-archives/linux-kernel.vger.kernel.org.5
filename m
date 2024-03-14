Return-Path: <linux-kernel+bounces-103349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047B187BE66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F991C21FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7824471723;
	Thu, 14 Mar 2024 14:04:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F666FE1E;
	Thu, 14 Mar 2024 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425096; cv=none; b=EynTQ8UAC4B+u3bCVnkbRG3+O3iIw2EW8dzVwSWWCGuGztGwkQXqlLEzoaOsNe4adYTnjOez92gKsP5YGXlCJyPM7VkaiRRSc6f8IVEJqXF/Z4M070RQuWe/zzfeRz3a/2ufFU8F/xb8Jr4LNyuzrJ+yOeBFFdv/lrXAzcjrA8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425096; c=relaxed/simple;
	bh=mzHk+OCGnE2cjK/GID6NafKHM6xvW+nmtg17CRUaB+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B2k5BU0YNIGxbRVoAygt3HuKUn9Tu9rT0H2Wm8I+pbMTVv3nptJHnq60Cnp8J7p689evomKtAmD3tjtKwKAiLU/ekIDqSqvooRo8VGW/wakycjpattZNu6XTV/+rdjWKajBNda+DF/RFtNORekav26dNaufA54U0d0N71Y4awjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 340A61063;
	Thu, 14 Mar 2024 07:05:29 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.13.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D8253F762;
	Thu, 14 Mar 2024 07:04:50 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: [PATCH 4/4] soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
Date: Thu, 14 Mar 2024 14:04:21 +0000
Message-Id: <20240314140421.3563571-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314140421.3563571-1-lukasz.luba@arm.com>
References: <20240314140421.3563571-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the voltage for OPPs is adjusted there is a need to also update
Energy Model framework. The EM data contains power values which depend
on voltage values. The EM structure is used for thermal (IPA governor)
and in scheduler task placement (EAS) so it should reflect the real HW
model as best as possible to operate properly.

Based on data on Exynos5422 ASV tables the maximum power difference might
be ~29%. An Odroid-XU4 (with a random sample SoC in this chip lottery)
showed power difference for some OPPs ~20%. Therefore, it's worth to
update the EM.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/soc/samsung/exynos-asv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index d60af8acc3916..bd6bb2cab2cd8 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -11,6 +11,7 @@
 
 #include <linux/cpu.h>
 #include <linux/device.h>
+#include <linux/energy_model.h>
 #include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -97,9 +98,17 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
 			last_opp_table = opp_table;
 
 			ret = exynos_asv_update_cpu_opps(asv, cpu);
-			if (ret < 0)
+			if (!ret) {
+				/*
+				 * When the voltage for OPPs successfully
+				 * changed, update the EM power values to
+				 * reflect the reality and not use stale data
+				 */
+				em_dev_update_chip_binning(cpu);
+			} else {
 				dev_err(asv->dev, "Couldn't udate OPPs for cpu%d\n",
 					cpuid);
+			}
 		}
 
 		dev_pm_opp_put_opp_table(opp_table);
-- 
2.25.1


