Return-Path: <linux-kernel+bounces-133599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8E89A621
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233B01F225EB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FAD17554F;
	Fri,  5 Apr 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9se4gYT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04150174EEA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353208; cv=none; b=O80eDc1HWnVnB1QVUnj5PSopV6rB6uiJ6W3l27IVrXpXM0wtyjux0enHoy6NPHtmFJ93HZtv91Q8AzLelfsBZsDs2AYW6blXSzQakA7CK/fl9VrqvTsPXV19dkuwcqp8Dq7F6eKwK760Bh7s/7zb/gkJKc19e1jcjypAxYCLOKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353208; c=relaxed/simple;
	bh=MWViFiV2oxg4tnMs/wG+1axaltDwW1RpJ9QKG08kA9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8INxJsQn+yXNGOsVLT1icNmMUNIYTJuKO8siSYJLiNj/pTpqKwM7XbNEPeS8wbf9NQXcco03vComOcpvmdST3m6XwyjD0LKgJdJjpyR1opFbYpIE6Ks5Ljyuq7KYsGZiMm2mOBBMShN4KsBnVVRgT8Slkasxylz2VrNG1wXXE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9se4gYT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712353205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8yBgVsN5LppqIbArLWzBgh9/VT+hGJdZqFj/5b4sX08=;
	b=V9se4gYTShwRE9s24TD6tSg8LG07h2Xi7M6LqHwd405fZzy2UUb3J30kkf5EpdBmwTR94O
	XR/TR//IB8VB+qscSxi1510PVna+2Wk+zLlH1CQ1HOobJpwWzL2N3WF4wiUXaTYgpl+DDy
	9HVC/UTL2DuelWm1/ltMzSRZCM/bsGk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-WZJh4Fj-Owy4mxAPrd_JZg-1; Fri, 05 Apr 2024 17:40:04 -0400
X-MC-Unique: WZJh4Fj-Owy4mxAPrd_JZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 976C0811E81;
	Fri,  5 Apr 2024 21:40:03 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DCDAF400D69A;
	Fri,  5 Apr 2024 21:40:02 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dmaengine: idxd: Check for driver name match before sva user feature
Date: Fri,  5 Apr 2024 14:39:41 -0700
Message-ID: <20240405213941.3629709-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Currently if the user driver is probed on a workqueue configured for
another driver with SVA not enabled on the system, it will print
out a number of probe failing messages like the following:

    [   264.831140] user: probe of wq13.0 failed with error -95

On some systems, such as GNR, the number of messages can
reach over 100.

Move the SVA feature check to be after the driver name match
check.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
v2:
 - Fix typo.
 - Add Reviewed-by tags for Dave and Fenghua

 drivers/dma/idxd/cdev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 8078ab9acfbc..a4b771781afc 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -517,6 +517,14 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return -ENXIO;
 
+	mutex_lock(&wq->wq_lock);
+
+	if (!idxd_wq_driver_name_match(wq, dev)) {
+		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
+		rc = -ENODEV;
+		goto wq_err;
+	}
+
 	/*
 	 * User type WQ is enabled only when SVA is enabled for two reasons:
 	 *   - If no IOMMU or IOMMU Passthrough without SVA, userspace
@@ -532,14 +540,7 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 		dev_dbg(&idxd->pdev->dev,
 			"User type WQ cannot be enabled without SVA.\n");
 
-		return -EOPNOTSUPP;
-	}
-
-	mutex_lock(&wq->wq_lock);
-
-	if (!idxd_wq_driver_name_match(wq, dev)) {
-		idxd->cmd_status = IDXD_SCMD_WQ_NO_DRV_NAME;
-		rc = -ENODEV;
+		rc = -EOPNOTSUPP;
 		goto wq_err;
 	}
 
-- 
2.44.0


