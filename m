Return-Path: <linux-kernel+bounces-25488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36682D10C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF2281F34
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD1D2571;
	Sun, 14 Jan 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aO2iMp46"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A462B522F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id P1zvriYlCZnJmP1zvru354; Sun, 14 Jan 2024 16:02:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705244524;
	bh=ZtLkLsgrDIH5e5A0X7MYjDkRyJPsjPUPwNrNBrcfvVU=;
	h=From:To:Cc:Subject:Date;
	b=aO2iMp46nKuSxICxqVGoBBCSiQMdIrYeE6veHg/9yM8ks4qPFXdmogC94oSmF8pM/
	 WrGWcjvUO9nx6M+yx9rPu1ovDdzRYYYDQAQTc/avmJliv2vlzIDMfScOcFVj/e4TsM
	 ma3cHRUTp/ixyK55biyC7SmPi2WVRz1na9SWRyQMWSL41XzhWOYiLf7kKQxbHiu5H7
	 RRewYsdXJuSC5y9VOFLiIw4id2Jb2tJiA8wL5o6YA+0P2OIiRKEv0amHPDFQULTJ+v
	 MzjJLD2Ch/8kNafO5OMVdAESCPPF2y1mFOAImv8+OomqeUqKv1QXMsln+UoY0yEHUs
	 A3pBZCMWbL0DQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 16:02:04 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: core: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 16:01:57 +0100
Message-ID: <583c57d0ae09f9d3a1e1a7b80c1e39ada17954b7.1705244502.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/mmc/core/block.c | 12 ++++++------
 drivers/mmc/core/host.c  |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..a9b60b91e32f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -206,7 +206,7 @@ static void mmc_blk_kref_release(struct kref *ref)
 	int devidx;
 
 	devidx = mmc_get_devidx(md->disk);
-	ida_simple_remove(&mmc_blk_ida, devidx);
+	ida_free(&mmc_blk_ida, devidx);
 
 	mutex_lock(&open_lock);
 	md->disk->private_data = NULL;
@@ -2467,7 +2467,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	bool cache_enabled = false;
 	bool fua_enabled = false;
 
-	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
+	devidx = ida_alloc_max(&mmc_blk_ida, max_devices - 1, GFP_KERNEL);
 	if (devidx < 0) {
 		/*
 		 * We get -ENOSPC because there are no more any available
@@ -2577,7 +2577,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
  err_kfree:
 	kfree(md);
  out:
-	ida_simple_remove(&mmc_blk_ida, devidx);
+	ida_free(&mmc_blk_ida, devidx);
 	return ERR_PTR(ret);
 }
 
@@ -2703,7 +2703,7 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 {
 	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
 
-	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
+	ida_free(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 }
 
@@ -2719,13 +2719,13 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	struct mmc_rpmb_data *rpmb;
 
 	/* This creates the minor number for the RPMB char device */
-	devidx = ida_simple_get(&mmc_rpmb_ida, 0, max_devices, GFP_KERNEL);
+	devidx = ida_alloc_max(&mmc_rpmb_ida, max_devices - 1, GFP_KERNEL);
 	if (devidx < 0)
 		return devidx;
 
 	rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
 	if (!rpmb) {
-		ida_simple_remove(&mmc_rpmb_ida, devidx);
+		ida_free(&mmc_rpmb_ida, devidx);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index cf396e8f34e9..7cc9a33d28ca 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device *dev)
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
 	wakeup_source_unregister(host->ws);
 	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
-		ida_simple_remove(&mmc_host_ida, host->index);
+		ida_free(&mmc_host_ida, host->index);
 	kfree(host);
 }
 
@@ -538,7 +538,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
 		min_idx = mmc_first_nonreserved_index();
 		max_idx = 0;
 
-		index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
+		index = ida_alloc_range(&mmc_host_ida, min_idx, max_idx - 1,
+					GFP_KERNEL);
 		if (index < 0) {
 			kfree(host);
 			return NULL;
-- 
2.43.0


