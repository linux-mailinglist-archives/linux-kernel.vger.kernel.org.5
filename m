Return-Path: <linux-kernel+bounces-4750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32C4818187
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252B21C2179B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA9881E;
	Tue, 19 Dec 2023 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZDfe7HEj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6F79F5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FTaqrVHNFVfJzFTarr61IL; Tue, 19 Dec 2023 07:28:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702967322;
	bh=ahkXp6xxCwU84PCUd14FBAK8cm1b4ujnP7B1xat+5CE=;
	h=From:To:Cc:Subject:Date;
	b=ZDfe7HEjjo4s8LLw37S+C8wFLEVQ2/MCiGJR3aoDQ6lVe/8b9N/djfDs9XW2g1iJb
	 wdCO1BQb2MWjdUtINT3SWM6B0nDNevmtglL0C0j4POPXf01aBe9euv8Tz7hF91RWZ1
	 Vxawkry5a3qQkITjZSVfCwm+Gp+IL0lPQcxCzqGFyPzM8pbEwxh8iP/vWCPPYUyZaQ
	 Z9nUqkFDiRmSmqxjvXfst0OsKZwH8psjvv9oQbjt+JOV+4+SQnK/2ORb3XKr92tH0w
	 qo4G7hajbyW4MHaDzTtr/x2iFQUI3RwVp047WPl0ZqfLxQCDGlJf57eNfTdpYVS79E
	 +ge4PYT7wNl2g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 07:28:42 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 07:28:39 +0100
Message-Id: <a899125f42c12fa782a881d341d147519cbb4a23.1702967302.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So change this change allows one more
device.

MINORMASK is	((1U << MINORBITS) - 1), so allowing MINORMASK as a maximum
value makes sense. It is also consistent with other "ida_.*MINORMASK" and
"ida_*MINOR()" usages.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only, review with care for the upper bound change.
---
 drivers/dma/idxd/cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 0423655f5a88..b00926abc69a 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -165,7 +165,7 @@ static void idxd_cdev_dev_release(struct device *dev)
 	struct idxd_wq *wq = idxd_cdev->wq;
 
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -463,7 +463,7 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 	cdev = &idxd_cdev->cdev;
 	dev = cdev_dev(idxd_cdev);
 	cdev_ctx = &ictx[wq->idxd->data->type];
-	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
+	minor = ida_alloc_max(&cdev_ctx->minor_ida, MINORMASK, GFP_KERNEL);
 	if (minor < 0) {
 		kfree(idxd_cdev);
 		return minor;
-- 
2.34.1


