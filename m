Return-Path: <linux-kernel+bounces-156922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CD8B0A62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584B11C234A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772A015B15C;
	Wed, 24 Apr 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MZep/r7x"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D77315B56E;
	Wed, 24 Apr 2024 13:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963925; cv=none; b=EVvwHcCenfiWP+CIvF4OSCdFLEQlMs0sg+t1nWQKDjiA+KN2uScNSpFiwOz7W7hRdoDWmoHK85gPiDV53o7Jt0Pg8p7ZjjHcKw30OsGr3LoJQIaoLm4DIdSPWviOKQ3TqXa9zlj26v2/vQAIRkIo4QlIGmZFBeRVOcwazoiXF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963925; c=relaxed/simple;
	bh=aYUiQjx5T2telvYeBW2h9mlyvfpkugk6HRhiYmiCzf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKIJOlISQbhQWLGe5ZSWlrS7TA3G+l3MT1Qk+gGSaqtoTOkT281U4TJhtSKWhWxKq1Jyz5UolLA+SucyDGxVMMopKsg+GT22vT2nwIbIGP7VJdtgu8Cyh0wBhVhvdP+GqTWATjhyY/fGdFwRJeqV5B4g9D5QiTD/YsRvEZZkVTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MZep/r7x; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43OD5BEu037529;
	Wed, 24 Apr 2024 08:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713963911;
	bh=2gw3G8wmP2kkhlSTaXmiw8IfW3uBJt595tILnxRdmys=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MZep/r7xEKnF6WMBdjXNGO5JaM0CSR86P2ACedtaD+ssxkxYpdlPI0ENNwPGmDT61
	 lIDcdbjq07+Eu0Mdhvg0+C3gKYvJMOltxekE4qAC3/sc6XjDdi4w8bFEd7GUE319TA
	 Xw6bd8mo3CRh5HEEG56Ok1UkSfs/B5K0Ngee8hMs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43OD5BpN002842
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 08:05:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 08:05:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 08:05:10 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.69.66])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43OD54bQ029300;
	Wed, 24 Apr 2024 08:05:08 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <andersson@kernel.org>
CC: <mathieu.poirier@linaro.org>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <nm@ti.com>, <devarsht@ti.com>, <hnagalla@ti.com>
Subject: [PATCH v2 1/2] remoteproc: k3-r5: Wait for core0 power-up before powering up core1
Date: Wed, 24 Apr 2024 18:35:03 +0530
Message-ID: <20240424130504.494916-2-b-padhi@ti.com>
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

From: Apurva Nandan <a-nandan@ti.com>

PSC controller has a limitation that it can only power-up the second core
when the first core is in ON state. Power-state for core0 should be equal
to or higher than core1, else the kernel is seen hanging during rproc
loading.

Make the powering up of cores sequential, by waiting for the current core
to power-up before proceeding to the next core, with a timeout of 2sec.
Add a wait queue event in k3_r5_cluster_rproc_init call, that will wait
for the current core to be released from reset before proceeding with the
next core.

Fixes: 6dedbd1d5443 ("remoteproc: k3-r5: Add a remoteproc driver for R5F subsystem")

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/remoteproc/ti_k3_r5_remoteproc.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index ad3415a3851b..5a9bd5d4a2ea 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -103,12 +103,14 @@ struct k3_r5_soc_data {
  * @dev: cached device pointer
  * @mode: Mode to configure the Cluster - Split or LockStep
  * @cores: list of R5 cores within the cluster
+ * @core_transition: wait queue to sync core state changes
  * @soc_data: SoC-specific feature data for a R5FSS
  */
 struct k3_r5_cluster {
 	struct device *dev;
 	enum cluster_mode mode;
 	struct list_head cores;
+	wait_queue_head_t core_transition;
 	const struct k3_r5_soc_data *soc_data;
 };
 
@@ -128,6 +130,7 @@ struct k3_r5_cluster {
  * @atcm_enable: flag to control ATCM enablement
  * @btcm_enable: flag to control BTCM enablement
  * @loczrama: flag to dictate which TCM is at device address 0x0
+ * @released_from_reset: flag to signal when core is out of reset
  */
 struct k3_r5_core {
 	struct list_head elem;
@@ -144,6 +147,7 @@ struct k3_r5_core {
 	u32 atcm_enable;
 	u32 btcm_enable;
 	u32 loczrama;
+	bool released_from_reset;
 };
 
 /**
@@ -460,6 +464,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
 			ret);
 		return ret;
 	}
+	core->released_from_reset = true;
+	wake_up_interruptible(&cluster->core_transition);
 
 	/*
 	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
@@ -1140,6 +1146,7 @@ static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
 		return ret;
 	}
 
+	core->released_from_reset = c_state;
 	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
 				     &stat);
 	if (ret < 0) {
@@ -1280,6 +1287,26 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		    cluster->mode == CLUSTER_MODE_SINGLECPU ||
 		    cluster->mode == CLUSTER_MODE_SINGLECORE)
 			break;
+
+		/*
+		 * R5 cores require to be powered on sequentially, core0
+		 * should be in higher power state than core1 in a cluster
+		 * So, wait for current core to power up before proceeding
+		 * to next core and put timeout of 2sec for each core.
+		 *
+		 * This waiting mechanism is necessary because
+		 * rproc_auto_boot_callback() for core1 can be called before
+		 * core0 due to thread execution order.
+		 */
+		ret = wait_event_interruptible_timeout(cluster->core_transition,
+						       core->released_from_reset,
+						       msecs_to_jiffies(2000));
+		if (ret <= 0) {
+			dev_err(dev,
+				"Timed out waiting for %s core to power up!\n",
+				rproc->name);
+			return ret;
+		}
 	}
 
 	return 0;
@@ -1709,6 +1736,7 @@ static int k3_r5_probe(struct platform_device *pdev)
 	cluster->dev = dev;
 	cluster->soc_data = data;
 	INIT_LIST_HEAD(&cluster->cores);
+	init_waitqueue_head(&cluster->core_transition);
 
 	ret = of_property_read_u32(np, "ti,cluster-mode", &cluster->mode);
 	if (ret < 0 && ret != -EINVAL) {
-- 
2.34.1


