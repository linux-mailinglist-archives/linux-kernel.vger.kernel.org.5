Return-Path: <linux-kernel+bounces-163805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D08B712B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CBA1C222A7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300812CD96;
	Tue, 30 Apr 2024 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zVhEXNeL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC9F12E1CA;
	Tue, 30 Apr 2024 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474402; cv=none; b=rOR72G+kKb4YOYUlSE2sXCrFkw/vD2mijC4RU+gWD3A8Ip+KueD7BKvEARULF9vFxEnBFwNIsxTk/mLpaF4ikCSOhmUuBILIAKFXAvDKy5bDeIljJ6IO+SrVZCdB7FoUYrdI1PzPxZxktPlPcwvIP95SQ15ztaS+6cAE7BJ5CLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474402; c=relaxed/simple;
	bh=SI7SkEbPILK7EIZFJ4b+5oO16k1J0ru5blwRmlgF3sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/yd/DlPCvCV+bSWaMcKxMQa24CwohChpM1eqc03zeTv9AR1B9q9QelYe4z617W6twA96zpJV3q3TY+kHNTmAzSNKqkIKljnEXvMfsJ5DYe2DARL5g5jDYIMqcwU1P6DJoU9Aj9jd/OL5IH6DpyVisHvMrxQMvM8pOdJb0feTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zVhEXNeL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UArHEu114705;
	Tue, 30 Apr 2024 05:53:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714474397;
	bh=wgPLkkxkDTgxSHcoII06upNv5M+DDJ6JR1sK5fYgaeM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zVhEXNeLWpjfk+DzutqzI6dkolekbr+ozSfOQ4D52E21MxJKfuNTsrpv3mGgilTdg
	 SPj3RUHnNqN9gg8Cv9xQK4kGnCGw4oymLQhjrMBE1wMAON0J0iWqNs142TOjETLiyz
	 fmFWtEbjdYAoBfmodu5WdGdKPpjSzvkJ17J7sfdw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UArHNn033848
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 05:53:17 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:53:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:53:17 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAr8Dr038508;
	Tue, 30 Apr 2024 05:53:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <andersson@kernel.org>
CC: <mathieu.poirier@linaro.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
Subject: [PATCH v3 2/2] remoteproc: k3-r5: Do not allow core1 to power up before core0 via sysfs
Date: Tue, 30 Apr 2024 16:23:07 +0530
Message-ID: <20240430105307.1190615-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430105307.1190615-1-b-padhi@ti.com>
References: <20240430105307.1190615-1-b-padhi@ti.com>
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
index 6d6afd6beb3a..1799b4f6d11e 100644
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


