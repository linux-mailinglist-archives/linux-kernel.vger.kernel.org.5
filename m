Return-Path: <linux-kernel+bounces-85604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00FB86B833
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B1D289E60
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA72160865;
	Wed, 28 Feb 2024 19:33:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD774413
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148795; cv=none; b=dlhFaRNUrYcOJ9ImGvP7IYpGgoe8t6DPgm1K6l7p9Jl0iCbEySQmdIFfVNnSABhvKr1hoUB749xhWXMt+TRnPfvQjfyaTd8eWEcrPPnJmEDQpkviVdJvywnRxciTCYUYOm4IQKaYQgwnzmIgcqYMQQ6ZprIo3/RiI1WX/jiRquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148795; c=relaxed/simple;
	bh=VlygoFXI9hR5tbz+SuSs/dkPVV9lWxWrx5MkcSEsv/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TAU12RPaJMwlYG4Xmj6rKVcY2kr3ShgIIHc2TLtNco+MvV0MJtAga5mvzstT7e9Be0th+BwXbDL8rUcnEu6cpXrnhjpEf//pQlxNkbESLDt8hZSspB1qX4a1LvzOt2bamUv8vakx41ReB92i0IpnE5v2AX2jgqo4tIozAHe2qbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5EB9DA7;
	Wed, 28 Feb 2024 11:33:51 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21E4A3F73F;
	Wed, 28 Feb 2024 11:33:11 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 4/4] firmware: arm_scmi: Use dev_err_probe to bail out
Date: Wed, 28 Feb 2024 19:32:38 +0000
Message-ID: <20240228193238.2102157-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228193238.2102157-1-cristian.marussi@arm.com>
References: <20240228193238.2102157-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use dev_err_probe on the failure path of SCMI core probing.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 34 +++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index a3182199f123..7329f3a1c1de 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2522,6 +2522,10 @@ scmi_txrx_setup(struct scmi_info *info, struct device_node *of_node,
 			ret = 0;
 	}
 
+	if (ret)
+		dev_err(info->dev,
+			"failed to setup channel for protocol:0x%X\n", prot_id);
+
 	return ret;
 }
 
@@ -2791,6 +2795,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
+	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
 	struct scmi_info *info;
@@ -2841,27 +2846,37 @@ static int scmi_probe(struct platform_device *pdev)
 
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
-		if (ret)
+		if (ret) {
+			err_str = "transport not ready\n";
 			goto clear_ida;
+		}
 	}
 
 	/* Setup all channels described in the DT at first */
 	ret = scmi_channels_setup(info);
-	if (ret)
+	if (ret) {
+		err_str = "failed to setup channels\n";
 		goto clear_ida;
+	}
 
 	ret = bus_register_notifier(&scmi_bus_type, &info->bus_nb);
-	if (ret)
+	if (ret) {
+		err_str = "failed to register bus notifier\n";
 		goto clear_txrx_setup;
+	}
 
 	ret = blocking_notifier_chain_register(&scmi_requested_devices_nh,
 					       &info->dev_req_nb);
-	if (ret)
+	if (ret) {
+		err_str = "failed to register device notifier\n";
 		goto clear_bus_notifier;
+	}
 
 	ret = scmi_xfer_info_init(info);
-	if (ret)
+	if (ret) {
+		err_str = "failed to init xfers pool\n";
 		goto clear_dev_req_notifier;
+	}
 
 	if (scmi_top_dentry) {
 		info->dbg = scmi_debugfs_common_setup(info);
@@ -2898,9 +2913,11 @@ static int scmi_probe(struct platform_device *pdev)
 	 */
 	ret = scmi_protocol_acquire(handle, SCMI_PROTOCOL_BASE);
 	if (ret) {
-		dev_err(dev, "unable to communicate with SCMI\n");
-		if (coex)
+		err_str = "unable to communicate with SCMI\n";
+		if (coex) {
+			dev_err(dev, err_str);
 			return 0;
+		}
 		goto notification_exit;
 	}
 
@@ -2954,7 +2971,8 @@ static int scmi_probe(struct platform_device *pdev)
 	scmi_cleanup_txrx_channels(info);
 clear_ida:
 	ida_free(&scmi_id, info->id);
-	return ret;
+
+	return dev_err_probe(dev, ret, err_str);
 }
 
 static void scmi_remove(struct platform_device *pdev)
-- 
2.43.0


