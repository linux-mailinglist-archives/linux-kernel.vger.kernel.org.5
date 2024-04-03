Return-Path: <linux-kernel+bounces-129047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF668963CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E3D2859B7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7CA46430;
	Wed,  3 Apr 2024 05:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTB41jC5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4836645
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 05:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120843; cv=none; b=PLbXTC4EgNlhBHZbpZ5zxYK4ZXPmcy1+/Q1TVrxVYpijPTjY9abx7zW4HefHIk5iZ8DIS6pbIqT+7IUoDj8U5rH7L2G090sdRNN8zLWuypLZD6nhgf5kqm6k7mgZHmFcIh9qJXy0HXAn7qxsFpiHc+eoXxmrfmWvxyEHBk4wO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120843; c=relaxed/simple;
	bh=uvWao2mn/QCa6M71siHuy06flWafHCr48kklj/WsPkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GpRdT55UriEMs6bSvegndNH17epLs5oc9nU/x57u5CPjrug6yt4XMk3HvDgLN6H1aq74VqKD4Jy1TU/S+2wTtGh//56ilN/OAhLvzZaE+BEzMwUsDI88QSGiutKUVTctbMG/XivH0K8fEPlWWwoPOAT6QhK6sRLoW2q44qPaaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTB41jC5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712120840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aHJbY1AL7kS10XXrZeU4sZOSE7Yjz01/4yh0mXYiu2w=;
	b=XTB41jC5527YtGs3vIC6tOs75ZRjurYrb8JetQa0rGV8e73EkxbA4xeTdjzygBcA9hzTGv
	9OFH22W86FEJ0e+2hvKZh7ALjUbrsjJsDfNpQfxgcj1d0SSI1QkBw/GzzzYl4GZRYzWaJM
	ATgOVVMTGddyy5euhTi4gQHTXThba2s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-3DDwmYdjMTuRimH_8CvZVg-1; Wed,
 03 Apr 2024 01:07:17 -0400
X-MC-Unique: 3DDwmYdjMTuRimH_8CvZVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E23B41C2CBEE;
	Wed,  3 Apr 2024 05:07:16 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.17.41])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5596CC01600;
	Wed,  3 Apr 2024 05:07:16 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Check for driver name match before sva user feature
Date: Tue,  2 Apr 2024 22:07:10 -0700
Message-ID: <20240403050710.2874197-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Currenty if the user driver is probed on a workqueue configured for
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
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
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


