Return-Path: <linux-kernel+bounces-117985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CC788B205
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A0B1C35DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE33112838B;
	Mon, 25 Mar 2024 20:46:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1770CC2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399607; cv=none; b=A96raJJBquKGAsX5eR1gt91K+gpOtKbhFFhxpPaXEUEbELuTblJYM69xp6fXV6tmti01Kt94RA6zHlsuYfduPPK9u+vHWaLf5Am3gYZen6uLxsSiGsAcg6EZ4AJnsOd088GOBb0CGxnMX55qDp5x/Hw1BLMbMT0/VuTosyPpXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399607; c=relaxed/simple;
	bh=5N73T9GLJexFRc9xgbr743q+8aZOE0ro0e7hvr8o8gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl2ZBtGia+B+o4pgT3m5abpurYXWOlQSpA7J7W6OV06ouROqx+WXSlHxBosgNBjCjRp1/qTXkjqha6HG7oF5TAUMLHfJ/9nukSkWQwTh4f6AGeXzk3rI65LnjhpR8N7PYv0GF774l/qMU2Zys1obpfcq+UyIiUY2wuz8XjA6xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F5321595;
	Mon, 25 Mar 2024 13:47:18 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5EF23F64C;
	Mon, 25 Mar 2024 13:46:43 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 4/5] firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
Date: Mon, 25 Mar 2024 20:46:19 +0000
Message-ID: <20240325204620.1437237-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325204620.1437237-1-cristian.marussi@arm.com>
References: <20240325204620.1437237-1-cristian.marussi@arm.com>
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
index b807141acc14..a3addb07e00a 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -783,8 +783,6 @@ struct scmi_notify_ops {
 					    const u32 *src_id,
 					    struct notifier_block *nb);
 	int (*devm_event_notifier_unregister)(struct scmi_device *sdev,
-					      u8 proto_id, u8 evt_id,
-					      const u32 *src_id,
 					      struct notifier_block *nb);
 	int (*event_notifier_register)(const struct scmi_handle *handle,
 				       u8 proto_id, u8 evt_id,
-- 
2.44.0


