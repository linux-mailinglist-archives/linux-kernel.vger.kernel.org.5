Return-Path: <linux-kernel+bounces-111353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AD886B11
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB067287310
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464164174F;
	Fri, 22 Mar 2024 11:09:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796740872;
	Fri, 22 Mar 2024 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105752; cv=none; b=Pn03bbjf0R9S9NxrmYOzUTXv5xg6WcdtR+9cb04lZzhC4vUBFI2FXiwT0QlPdGCel3AEymVD/NMNC4L7emvcF3jpj6JD/qabQCzsqIbeYT0S1vSg3RIlSrxFs0yovkThT5bUQRJJstgGHSdezZtuZKkMEw8ZkgrQ2IIrjevhiOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105752; c=relaxed/simple;
	bh=mzHk+OCGnE2cjK/GID6NafKHM6xvW+nmtg17CRUaB+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5jK35DHdLfVDk6CV0BALIV8COgJE/kzCeJVhiO4X5j7vaNxZF4XaPg6CSPZStFpN6iygZk5CPriY8SeqvTyAgen/r5izm0QvLE7R1g7K5BIyH0/UEmWrJ4VM9wIl+mLsPODfDVD5njicCRzDY+g8tTtsDXH/RFDztgf/h4dPnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F38331063;
	Fri, 22 Mar 2024 04:09:44 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.71.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 763B63F64C;
	Fri, 22 Mar 2024 04:09:08 -0700 (PDT)
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
Subject: [RESEND][PATCH v2 4/4] soc: samsung: exynos-asv: Update Energy Model after adjusting voltage
Date: Fri, 22 Mar 2024 11:08:50 +0000
Message-Id: <20240322110850.77086-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240322110850.77086-1-lukasz.luba@arm.com>
References: <20240322110850.77086-1-lukasz.luba@arm.com>
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


