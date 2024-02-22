Return-Path: <linux-kernel+bounces-76084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18E285F2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5A01F22D36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA221B59C;
	Thu, 22 Feb 2024 08:22:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06D2232D;
	Thu, 22 Feb 2024 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590139; cv=none; b=lHOXaL/N/Svo1mO/szZyzLD/9Xit9mnG+JpFM3HBbQWTixEOIHY6eJC8e/ZpFUCPM08GhiVTn+hf37w7pomwMMxGWmIO2zvRGXF0wnTZ7puBksQlZdq9hf7b0UlAUgNxP0JIH130xr1K1e71yf9A0nSNqlDgTDcRBt13FR46k1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590139; c=relaxed/simple;
	bh=AXFYcuYN3g5ZirUZbpsxyvNQu0ugVEt9rj0ERr0kW9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtL3SjfYVQZ3uzaQW0NLYnLrPsjfK3+d5HIccgAI0I4FNpWQN4Jq35NUDwy+JoSBKXBiaY0zsInuZ6OUdyfcPDHSMuIBrc44WaLVrB+4RoLqWC2BINIm3AUnPIYO8/Djd2XS1F8YFe+iTfaI9TOgTMsuKxapdDS3WlxUbudlWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 707A81576;
	Thu, 22 Feb 2024 00:22:55 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF8F63F762;
	Thu, 22 Feb 2024 00:22:12 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V5 03/11] coresight: tmc: Extract device properties from AMBA pid based table lookup
Date: Thu, 22 Feb 2024 13:51:34 +0530
Message-Id: <20240222082142.3663983-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222082142.3663983-1-anshuman.khandual@arm.com>
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extracts device properties from AMBA pid based table lookup. But first
this modifies tmc_etr_setup_caps() to accept csdev access.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V5:

- Modified tmc_etr_setup_caps() to accept struct csdev_access argument
- Reverted back tmc_etr_setup_caps() call site position in tmc_probe()
- Dropped custom mask TMC_AMBA_MASK

 drivers/hwtracing/coresight/coresight-tmc-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..43874fa4def0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -370,16 +370,23 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 	return (auth & TMC_AUTH_NSID_MASK) == 0x3;
 }
 
+static const struct amba_id tmc_ids[];
+
 /* Detect and initialise the capabilities of a TMC ETR */
-static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
+static int tmc_etr_setup_caps(struct device *parent, u32 devid,
+			      struct csdev_access *access)
 {
 	int rc;
-	u32 dma_mask = 0;
+	u32 tmc_pid, dma_mask = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	void *dev_caps;
 
 	if (!tmc_etr_has_non_secure_access(drvdata))
 		return -EACCES;
 
+	tmc_pid = coresight_get_pid(access);
+	dev_caps = coresight_get_uci_data_from_amba(tmc_ids, tmc_pid);
+
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
@@ -497,8 +504,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(dev, devid,
-					 coresight_get_uci_data(id));
+		ret = tmc_etr_setup_caps(dev, devid, &desc.access);
 		if (ret)
 			goto out;
 		idr_init(&drvdata->idr);
-- 
2.25.1


