Return-Path: <linux-kernel+bounces-100105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323DE8791DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56ED51C2134D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940179B75;
	Tue, 12 Mar 2024 10:23:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B607829A;
	Tue, 12 Mar 2024 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239027; cv=none; b=dsA9CE0eRnbrJ7wjgmVE/+d0FwlubgIY98k9MJU2t6JppNj6+ZIXiuarK7aOTUEj9YW3ULnD+yneRUIrRVNMWNqnJ4F9uA0ESeSyJlD6hVyoCKVBg23XCH+yG5jyjAGQ5wT4eoRe3AmqRlGR2legCUcVXzfeD1DR1SkYKiza0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239027; c=relaxed/simple;
	bh=PJhOAjp9EpDzLsBIfyRf0MkeuC3DD+JvG04z7Zkih5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUVk6byUkajfgOBbLVrUpqnxb0Jc9OliVsw6UhiqzI3V5Onb60nOx3rNQ6eOE78HkorxBk4xIDBh2yj8YuYoBen9a+cm6i9NScud3/fBzUX6aVfu3Oba2GyiaNQU3Bv7w9zfU846B+rkHSr7qal6NwNzcszseDvscOZlL24D4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A611007;
	Tue, 12 Mar 2024 03:24:22 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.52.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EC973F73F;
	Tue, 12 Mar 2024 03:23:40 -0700 (PDT)
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
Subject: [PATCH V6 02/11] coresight: stm: Extract device name from AMBA pid based table lookup
Date: Tue, 12 Mar 2024 15:53:09 +0530
Message-Id: <20240312102318.2285165-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312102318.2285165-1-anshuman.khandual@arm.com>
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
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


