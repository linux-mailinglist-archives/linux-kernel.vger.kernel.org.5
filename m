Return-Path: <linux-kernel+bounces-156923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4A08B0A64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A26B281BD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3282315B15A;
	Wed, 24 Apr 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kj/qOvn6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9315B159;
	Wed, 24 Apr 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963935; cv=none; b=rafroKhUM30dMkmpffjtM9VJV2DpAIZgLM0zn957f+6TMNtrIxDVXCfPyD+QhzaxqjHhZU89j0XQFwMh7L3zzvFajADCNJTGZbh8bKjKzFHJHweHA1nTTHEaqxcqg5AMzv0JNmlcGXpYlZyzB25SX5CLCts9soo1Th/+g85BN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963935; c=relaxed/simple;
	bh=xUkwDJI+0sKr7foO8qmRrScI6/JnFwKaztK/o/qF0as=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7J5/Xuc6+OpFfin/2L3wIkRR1jtWMT9KVm/HWqlWuTwy/BCXE9mTXK2I2dbdee0hSMLzOsYp8/Q1GtM0iCMneYZvW9zW+2QP8woeNAVR9J0BlBGYx4tx8+4aukDSOmft5Wrkoox2SeSC9SiLwXFSGUHKrc+xfk/RyEEGjY57As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kj/qOvn6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OD5EiY076780;
	Wed, 24 Apr 2024 08:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713963914;
	bh=q3Fy/Ibc5qZtK2bfrQr32IluwMsanIJO4c82EsXkxL0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Kj/qOvn6kN5VnB/zMQivKw+b+2zBLDYTY/bdGWwdibm2gRovNIueZvAyY193a5uDI
	 +s1IZhBDmU+cE367aTutztSdYTV74rtsi8NAFzhnIAH5fmYk+G8rYf0L+DgesRhTMv
	 hLbxzwpr3MM1CAcEm54ksIMfl4dBiIXQg+kJIj8g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OD5DwI002947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 08:05:13 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 08:05:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 08:05:13 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OD54bR029300;
	Wed, 24 Apr 2024 08:05:11 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <andersson@kernel.org>
CC: <mathieu.poirier@linaro.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
Subject: [PATCH v2 2/2] remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs
Date: Wed, 24 Apr 2024 18:35:04 +0530
Message-ID: <20240424130504.494916-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424130504.494916-1-b-padhi@ti.com>
References: <20240424130504.494916-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

PSC controller has a limitation that it can only power-up the second
core when the first core is in ON state. Power-state for core0 should be
equal to or higher than core1.

Therefore, prevent core1 from powering up before core0 during the start
process from sysfs. Similarly, prevent core0 from shutting down before
core1 has been shut down from sysfs.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index 5a9bd5d4a2ea..b9d2a16af563 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -548,7 +548,7 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
 	struct device *dev = kproc->dev;
-	struct k3_r5_core *core;
+	struct k3_r5_core *core0, *core;
 	u32 boot_addr;
 	int ret;
 
@@ -574,6 +574,15 @@ static int k3_r5_rproc_start(struct rproc *rproc)
 				goto unroll_core_run;
 		}
 	} else {
+		/* do not allow core 1 to start before core 0 */
+		core0 = list_first_entry(&cluster->cores, struct k3_r5_core,
+					 elem);
+		if (core != core0 && core0->rproc->state == RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not start core 1 before core 0\n",
+				__func__);
+			return -EPERM;
+		}
+
 		ret = k3_r5_core_run(core);
 		if (ret)
 			goto put_mbox;
@@ -619,7 +628,8 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 {
 	struct k3_r5_rproc *kproc = rproc->priv;
 	struct k3_r5_cluster *cluster = kproc->cluster;
-	struct k3_r5_core *core = kproc->core;
+	struct device *dev = kproc->dev;
+	struct k3_r5_core *core1, *core = kproc->core;
 	int ret;
 
 	/* halt all applicable cores */
@@ -632,6 +642,15 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 			}
 		}
 	} else {
+		/* do not allow core 0 to stop before core 1 */
+		core1 = list_last_entry(&cluster->cores, struct k3_r5_core,
+					elem);
+		if (core != core1 && core1->rproc->state != RPROC_OFFLINE) {
+			dev_err(dev, "%s: can not stop core 0 before core 1\n",
+				__func__);
+			return -EPERM;
+		}
+
 		ret = k3_r5_core_halt(core);
 		if (ret)
 			goto out;
-- 
2.34.1


