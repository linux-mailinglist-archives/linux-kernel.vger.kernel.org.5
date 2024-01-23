Return-Path: <linux-kernel+bounces-34734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0088386E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5092BB22BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC65C524C;
	Tue, 23 Jan 2024 05:46:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7181E5690;
	Tue, 23 Jan 2024 05:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988801; cv=none; b=IgzHQ2ql7o/kwtnoUM9BltTxO0NMW0wtcvzzqNCKdIgHz1yfsvfrOKB1iDowh0F2aqA7LmZiEj4/2YURcQ9HDm2qMB3EZGGZlpQ6ZhtEPc/9vMhaCDg2t0mlXdUdMDgJK+2iQmx2Y/kyDkyGJC8dEqW8yoxHTqFKGXdeafms/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988801; c=relaxed/simple;
	bh=yL5OLRgesBnWRwqPjOcPtiOchdKVa1hZNNUEdFB3DTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X1uuEbNtloWC1rGIs3Hskun1TOWpsoR86pD22ENhQ7RNbzQn+gDDClOKL+vSIYc9iFWE/yMaqRDNfzoykTNdjfVfdybP6ixLiTeODhGuh9so6NlSifAYmsu10Dk8Aq+MyIr8SJgjeohbsKYBcgw727Lng5AvSpNJXSU8Sz2mQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 350D11FB;
	Mon, 22 Jan 2024 21:47:24 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6ED173F762;
	Mon, 22 Jan 2024 21:46:34 -0800 (PST)
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
Subject: [PATCH V4 02/11] coresight: stm: Extract device name from AMBA pid based table lookup
Date: Tue, 23 Jan 2024 11:15:59 +0530
Message-Id: <20240123054608.1790189-3-anshuman.khandual@arm.com>
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

Instead of using AMBA private data field, extract the device name from AMBA
pid based table lookup using new coresight_get_uci_data_from_amba() helper.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 10 ++++++++++
 drivers/hwtracing/coresight/coresight-stm.c  | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e07970..68cbb036cec8 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -221,6 +221,16 @@ static inline void *coresight_get_uci_data(const struct amba_id *id)
 	return uci_id->data;
 }
 
+static inline void *coresight_get_uci_data_from_amba(const struct amba_id *table, u32 pid)
+{
+	while (table->mask) {
+		if ((table->id & table->mask) == pid)
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
index a1c27c901ad1..9cdca4f86cab 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -804,6 +804,18 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 	drvdata->stm.set_options = stm_generic_set_options;
 }
 
+#define STM_AMBA_MASK 0xfffff
+
+static const struct amba_id stm_ids[];
+
+static char *stm_csdev_name(struct coresight_device *csdev)
+{
+	u32 stm_pid = coresight_get_pid(&csdev->access) & STM_AMBA_MASK;
+	void *uci_data = coresight_get_uci_data_from_amba(stm_ids, stm_pid);
+
+	return uci_data ? (char *)uci_data : "STM";
+}
+
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret, trace_id;
@@ -900,7 +912,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
-		 (char *)coresight_get_uci_data(id));
+		 stm_csdev_name(drvdata->csdev));
 	return 0;
 
 cs_unregister:
-- 
2.25.1


