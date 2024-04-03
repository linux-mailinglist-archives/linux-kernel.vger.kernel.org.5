Return-Path: <linux-kernel+bounces-130132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA893897478
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643B829226A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8714D450;
	Wed,  3 Apr 2024 15:49:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286714D426;
	Wed,  3 Apr 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159377; cv=none; b=F74yhoar9FdkTSCXwhM3CVoWy2EJz2rN3RlmISXJfASV1dcxy5DWKxDRIYZUlEoPt7Sq70RQCk3e0kVZ8S5umDWnId/fhiJHvgcRQi27Tvx91aVYACJDSUVonYKbDzLbigAurIXJXBWazkr+7kqyO80/J1cLtWMslLtQL/3N/qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159377; c=relaxed/simple;
	bh=tsqqYBX34+zq0nQoQwApKnQcjJcj3i0phv23JxR4wVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kaXO70fhTzjnGM0MX02xpkh2RRGYXtJXyJDWmvlzKiC/07SS4Bjepr6AQs1dH1qEyH3v3GIA9D2dyfa03VUrXczUuouNQW88hkeo629y/lgM7sCD5n7omMZ86MiOzJOsi4x/uG4y2okLQlhE93yGukUb1YgqcDIMLWF2/8dgaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E158D1595;
	Wed,  3 Apr 2024 08:50:06 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65B5D3F7B4;
	Wed,  3 Apr 2024 08:49:33 -0700 (PDT)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	linux-arm-kernel@lists.infradead.org,
	sboyd@kernel.org,
	nm@ti.com,
	linux-samsung-soc@vger.kernel.org,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	m.szyprowski@samsung.com,
	mhiramat@kernel.org
Subject: [PATCH v5 4/4] soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
Date: Wed,  3 Apr 2024 16:49:07 +0100
Message-Id: <20240403154907.1420245-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403154907.1420245-1-lukasz.luba@arm.com>
References: <20240403154907.1420245-1-lukasz.luba@arm.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/soc/samsung/exynos-asv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index d60af8acc3916..97006cc3b9461 100644
--- a/drivers/soc/samsung/exynos-asv.c
+++ b/drivers/soc/samsung/exynos-asv.c
@@ -11,6 +11,7 @@
 
 #include <linux/cpu.h>
 #include <linux/device.h>
+#include <linux/energy_model.h>
 #include <linux/errno.h>
 #include <linux/of.h>
 #include <linux/pm_opp.h>
@@ -97,9 +98,16 @@ static int exynos_asv_update_opps(struct exynos_asv *asv)
 			last_opp_table = opp_table;
 
 			ret = exynos_asv_update_cpu_opps(asv, cpu);
-			if (ret < 0)
+			if (!ret) {
+				/*
+				 * Update EM power values since OPP
+				 * voltage values may have changed.
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


