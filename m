Return-Path: <linux-kernel+bounces-102832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBF487B79F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751371F20610
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048125543;
	Thu, 14 Mar 2024 05:59:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51A250EB;
	Thu, 14 Mar 2024 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395967; cv=none; b=FRDyhERIA468wAbIx1PxpxdpUz3OOC0jVQV2WG5E0k64l/2K+FW2MU6/oLEKn9K5/3e3B++HZ2enESedyTdo9Tj9tZtZ7mx9Dc9KIO03HD2XIqjtog5sHTVsEhBqjjcK+J6QbQU01EaP+asKsC+NrzcyhGzUkCk6WNmTQK4GN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395967; c=relaxed/simple;
	bh=PJhOAjp9EpDzLsBIfyRf0MkeuC3DD+JvG04z7Zkih5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijavkdn/VsLrAqgxZ5YNfF+vRRZGathEXCk90TtJQyNaTrNGrG5Isx8NGVNS5dY0kavTkFZBx01z0UTRPGtygH1dx0IPtmhnfZ+s38GmDQQeeKIM2DR3CLKlvKl43IO+1CwGuU0bIIIX0iz3skOOV13n5WgNSqlGMRv2PCt/U9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D03A11FB;
	Wed, 13 Mar 2024 23:00:02 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.53.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 010483F73F;
	Wed, 13 Mar 2024 22:59:21 -0700 (PDT)
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
Subject: [PATCH V7 02/11] coresight: stm: Extract device name from AMBA pid based table lookup
Date: Thu, 14 Mar 2024 11:28:34 +0530
Message-Id: <20240314055843.2625883-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314055843.2625883-1-anshuman.khandual@arm.com>
References: <20240314055843.2625883-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using AMBA private data field, extract the device name from AMBA
pid based table lookup using new coresight_get_uci_data_from_amba() helper.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 10 ++++++++++
 drivers/hwtracing/coresight/coresight-stm.c  | 12 +++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index eb365236f9a9..fc3617642b01 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -222,6 +222,16 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 	return uci_id->data;
 }
 
+static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
+{
+	while (table->mask) {
+		if ((pid & table->mask) == table->id)
+			return coresight_get_uci_data(table);
+		table++;
+	};
+	return NULL;
+}
+
 void coresight_release_platform_data(struct coresight_device *csdev,
 				     struct device *dev,
 				     struct coresight_platform_data *pdata);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 974d37e5f94c..5ae24c33c846 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -800,6 +800,16 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 	drvdata->stm.set_options = stm_generic_set_options;
 }
 
+static const struct amba_id stm_ids[];
+
+static char *stm_csdev_name(struct coresight_device *csdev)
+{
+	u32 stm_pid = coresight_get_pid(&csdev->access);
+	void *uci_data = coresight_get_uci_data_from_amba(stm_ids, stm_pid);
+
+	return uci_data ? (char *)uci_data : "STM";
+}
+
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret, trace_id;
@@ -896,7 +906,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
-		 (char *)coresight_get_uci_data(id));
+		 stm_csdev_name(drvdata->csdev));
 	return 0;
 
 cs_unregister:
-- 
2.25.1


