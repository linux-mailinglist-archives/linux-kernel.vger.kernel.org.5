Return-Path: <linux-kernel+bounces-85603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF8586B832
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B00E28A4FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39F15F301;
	Wed, 28 Feb 2024 19:33:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9B15DBB9
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148794; cv=none; b=ZbdAaQSkxMxhNS3mVHQ3fP0LsbpbqmKZkZH48l/UyhYLrTqQusEX/kF3z7y7tfyDs6I5htxsTdXdelEMbgnNd8GSHg+BO3bdlwBWwROmh1gT6WIkf/qCWxL0WXUgAyX6gTuFe9Gedke6Jpt9DTh0L7GQCncVdxC6RXGdh9Q5XL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148794; c=relaxed/simple;
	bh=R1HN6cNrtXWrVeHwA6L4bNTI2kbh4VCicV68kbU/F7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHubu61c2Zy9Y3dg00KlR5EvY/8oZQcCOVsIKJgsiHy7wpNL00ZKdVRaFzJakeUW54hOtK0kfj/Sj/n/M/eHDw17J7zxJNNxDBLrTL9M7VPyp9j5zb0yrpABjK3LUSsjB+yWT1csBJ5mh/AeKRiBzXNuZ1XycCds6Xqj/r5HDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E454CC15;
	Wed, 28 Feb 2024 11:33:49 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 510493F73F;
	Wed, 28 Feb 2024 11:33:09 -0800 (PST)
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
Subject: [PATCH 3/4] firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
Date: Wed, 28 Feb 2024 19:32:37 +0000
Message-ID: <20240228193238.2102157-4-cristian.marussi@arm.com>
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

Unregistering SCMI notifications using the managed devres interface can be
done providing as a reference simply the previously successfully registered
notification block since it could have been registered only on one kernel
notification_chain: drop any reference to SCMI protocol, events and
sources.

Devres internal helpers can search for the provided notification block
reference and, once found, the associated devres object will already
provide the above SCMI references for the event.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/notify.c | 30 ++++--------------------------
 include/linux/scmi_protocol.h      |  2 --
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 27c52531194d..e160ecb22948 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1513,17 +1513,12 @@ static int scmi_devm_notifier_register(struct scmi_device *sdev,
 static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
 {
 	struct scmi_notifier_devres *dres = res;
-	struct scmi_notifier_devres *xres = data;
+	struct notifier_block *nb = data;
 
-	if (WARN_ON(!dres || !xres))
+	if (WARN_ON(!dres || !nb))
 		return 0;
 
-	return dres->proto_id == xres->proto_id &&
-		dres->evt_id == xres->evt_id &&
-		dres->nb == xres->nb &&
-		((!dres->src_id && !xres->src_id) ||
-		  (dres->src_id && xres->src_id &&
-		   dres->__src_id == xres->__src_id));
+	return dres->nb == nb;
 }
 
 /**
@@ -1531,10 +1526,6 @@ static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
  * notifier_block for an event
  * @sdev: A reference to an scmi_device whose embedded struct device is to
  *	  be used for devres accounting.
- * @proto_id: Protocol ID
- * @evt_id: Event ID
- * @src_id: Source ID, when NULL register for events coming form ALL possible
- *	    sources
  * @nb: A standard notifier block to register for the specified event
  *
  * Generic devres managed helper to explicitly un-register a notifier_block
@@ -1544,25 +1535,12 @@ static int scmi_devm_notifier_match(struct device *dev, void *res, void *data)
  * Return: 0 on Success
  */
 static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
-					 u8 proto_id, u8 evt_id,
-					 const u32 *src_id,
 					 struct notifier_block *nb)
 {
 	int ret;
-	struct scmi_notifier_devres dres;
-
-	dres.handle = sdev->handle;
-	dres.proto_id = proto_id;
-	dres.evt_id = evt_id;
-	if (src_id) {
-		dres.__src_id = *src_id;
-		dres.src_id = &dres.__src_id;
-	} else {
-		dres.src_id = NULL;
-	}
 
 	ret = devres_release(&sdev->dev, scmi_devm_release_notifier,
-			     scmi_devm_notifier_match, &dres);
+			     scmi_devm_notifier_match, nb);
 
 	WARN_ON(ret);
 
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 2ee94ff0320c..305d89c02a94 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -775,8 +775,6 @@ struct scmi_notify_ops {
 					    const u32 *src_id,
 					    struct notifier_block *nb);
 	int (*devm_event_notifier_unregister)(struct scmi_device *sdev,
-					      u8 proto_id, u8 evt_id,
-					      const u32 *src_id,
 					      struct notifier_block *nb);
 	int (*event_notifier_register)(const struct scmi_handle *handle,
 				       u8 proto_id, u8 evt_id,
-- 
2.43.0


