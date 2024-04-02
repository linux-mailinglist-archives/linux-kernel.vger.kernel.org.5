Return-Path: <linux-kernel+bounces-128303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B833E895911
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E970C1C2399D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857B136648;
	Tue,  2 Apr 2024 15:59:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76652131720;
	Tue,  2 Apr 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073549; cv=none; b=ndM2xQq5T3Wr75mqxjcIwCb2joZBExCKstXKqeMaX8eNrq6sulT0qie0vsEvKFEDt26qdyz9kJOSVPcr5TKwChm+zkAVBYvgKelIDMUEN9a0wgTcIBP+YdFwpuVqu0E2/vzf0iuavZmVOLfPkcrKaE/BqC2cwroQ3yaqfz2bAuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073549; c=relaxed/simple;
	bh=qnN9weQ8zePSFzOoB2/Nqdch/QqBxOvQUT/3iZ1s9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDi9EuK11EhSYuUks0f/JWp1AnvHDSizHhExFuaF91OM0EdXZIdDlbaEHod9J66/sQUFIi1Ks8hjYymP23C/2F95R3+jSoGFxGoJk1WqF2/3V1d/CCASs4YaGZGHIr2tMb9OsCP9aba6VcO5A/lOF+JGoPjrquG36gc1JjzmmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CB3A1042;
	Tue,  2 Apr 2024 08:59:38 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.72.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 514333F64C;
	Tue,  2 Apr 2024 08:59:04 -0700 (PDT)
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
Subject: [PATCH v4 4/4] soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
Date: Tue,  2 Apr 2024 16:58:22 +0100
Message-Id: <20240402155822.505491-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240402155822.505491-1-lukasz.luba@arm.com>
References: <20240402155822.505491-1-lukasz.luba@arm.com>
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
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/soc/samsung/exynos-asv.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-asv.c b/drivers/soc/samsung/exynos-asv.c
index d60af8acc3916..d6d003e3a81ab 100644
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
+				 * When the voltage for OPPs could be changed,
+				 * make sure to update the EM power values, to
+				 * reflect the reality and not use stale data.
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


