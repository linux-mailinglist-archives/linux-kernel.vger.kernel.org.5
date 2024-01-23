Return-Path: <linux-kernel+bounces-34735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833F48386ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D4282123
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378CC5C85;
	Tue, 23 Jan 2024 05:46:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE92C8DD;
	Tue, 23 Jan 2024 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988805; cv=none; b=pJogscWKjlkmQ6p+yqupNPjPnYwKWqICKUCOF3VBK6BoUCsW+gq2wKV6nRLYom3cuayvqutCSJ/9CZnCthKDIpmyoV/mdKqHhiaRZv4sryTCXBncycf6qsnGmkrZZacIv/9isODjNA+xVviCSkFCXzXFeXdhyVAiywSlljSzN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988805; c=relaxed/simple;
	bh=0mjJxnCmvKiSTYuVDSEK+hlxIecGTkYr/y/sD7YUgkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkaX0w53+vhlbX1YotkeMPXRcu+GfS4+Xv84kkQ//BCT/Lr2LLnwlPtpibm1H5jz87l6pfAsHUbzK1b58jGYLK+93a9z+FzlgOihhjQPLfx3V3PICW864bY/3/3V+N7VUGNte0LlKv2XBltH9F0CVmxcwagixo5aryzorfa7wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FCE41FB;
	Mon, 22 Jan 2024 21:47:29 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AB8B3F762;
	Mon, 22 Jan 2024 21:46:39 -0800 (PST)
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
Subject: [PATCH V4 03/11] coresight: tmc: Extract device properties from AMBA pid based table lookup
Date: Tue, 23 Jan 2024 11:16:00 +0530
Message-Id: <20240123054608.1790189-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123054608.1790189-1-anshuman.khandual@arm.com>
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extracts device properties from AMBA pid based table lookup. This also
defers tmc_etr_setup_caps() after the coresight device has been initialized
so that PID value can be read.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..e71db3099a29 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -370,16 +370,24 @@ static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
 	return (auth & TMC_AUTH_NSID_MASK) == 0x3;
 }
 
+#define TMC_AMBA_MASK 0xfffff
+
+static const struct amba_id tmc_ids[];
+
 /* Detect and initialise the capabilities of a TMC ETR */
-static int tmc_etr_setup_caps(struct device *parent, u32 devid, void *dev_caps)
+static int tmc_etr_setup_caps(struct device *parent, u32 devid)
 {
 	int rc;
-	u32 dma_mask = 0;
+	u32 tmc_pid, dma_mask = 0;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(parent);
+	void *dev_caps;
 
 	if (!tmc_etr_has_non_secure_access(drvdata))
 		return -EACCES;
 
+	tmc_pid = coresight_get_pid(&drvdata->csdev->access) & TMC_AMBA_MASK;
+	dev_caps = coresight_get_uci_data_from_amba(tmc_ids, tmc_pid);
+
 	/* Set the unadvertised capabilities */
 	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
 
@@ -497,10 +505,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM;
 		desc.ops = &tmc_etr_cs_ops;
-		ret = tmc_etr_setup_caps(dev, devid,
-					 coresight_get_uci_data(id));
-		if (ret)
-			goto out;
 		idr_init(&drvdata->idr);
 		mutex_init(&drvdata->idr_mutex);
 		dev_list = &etr_devs;
@@ -539,6 +543,9 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out;
 	}
 
+	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
+		ret = tmc_etr_setup_caps(dev, devid);
+
 	drvdata->miscdev.name = desc.name;
 	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
 	drvdata->miscdev.fops = &tmc_fops;
-- 
2.25.1


