Return-Path: <linux-kernel+bounces-25431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A882D027
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD211C20ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B751FCC;
	Sun, 14 Jan 2024 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WokYC7HL"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221C186B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OwwArzcRJMVYzOwwArhxJM; Sun, 14 Jan 2024 10:37:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705225072;
	bh=g/cnRG5kQoVFxCJ6XTY9uiVH37ch6zIzpDiOmb5ySos=;
	h=From:To:Cc:Subject:Date;
	b=WokYC7HLNqEwgZ7H2R8YxBu5WibjJ0DxLMMYUB9bZnfG2P41ogXIl4mTA+7y54B52
	 ylcgxHcwqVwDYY9AnGN129YpqLKIFkuACkW9sKPLvhvjHR8MYU44ijqnWTr7EG/b7+
	 sJ/6Z74m0LFlgREbLANLaZwSTVv8iNa6iaG0e303tiYObo/K1ITQ6taBkIkjnQ00Le
	 fgl8P/Qc9bmBL9JF1q7+AeVXKOH0lao6mzr0x24yked0QQLMoJh3tExjZnivvnv+wJ
	 lY1B7i55RTX5TaAT2fNFl5EEeLw+6L4xsrvBpHFW+U1Kic6uLsM0X/afCow5xLvNNu
	 dgekMzAPbX/Jg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 10:37:52 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH] rpmsg: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 10:37:43 +0100
Message-ID: <c09ee5b66d451bf97d14c167048549aa0824ee06.1705225049.git.christophe.jaillet@wanadoo.fr>
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
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/rpmsg/rpmsg_char.c | 12 ++++++------
 drivers/rpmsg/rpmsg_ctrl.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 09833ad05da7..1cb8d7474428 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -399,8 +399,8 @@ static void rpmsg_eptdev_release_device(struct device *dev)
 {
 	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
 
-	ida_simple_remove(&rpmsg_ept_ida, dev->id);
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
+	ida_free(&rpmsg_ept_ida, dev->id);
+	ida_free(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
 	kfree(eptdev);
 }
 
@@ -441,12 +441,12 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
 
 	eptdev->chinfo = chinfo;
 
-	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
+	ret = ida_alloc_max(&rpmsg_minor_ida, RPMSG_DEV_MAX - 1, GFP_KERNEL);
 	if (ret < 0)
 		goto free_eptdev;
 	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
 
-	ret = ida_simple_get(&rpmsg_ept_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&rpmsg_ept_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto free_minor_ida;
 	dev->id = ret;
@@ -462,9 +462,9 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
 	return ret;
 
 free_ept_ida:
-	ida_simple_remove(&rpmsg_ept_ida, dev->id);
+	ida_free(&rpmsg_ept_ida, dev->id);
 free_minor_ida:
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
 free_eptdev:
 	put_device(dev);
 	kfree(eptdev);
diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index 433253835690..c312794ba4b3 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -130,8 +130,8 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
 {
 	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
 
-	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+	ida_free(&rpmsg_ctrl_ida, dev->id);
+	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
 	kfree(ctrldev);
 }
 
@@ -156,12 +156,12 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
 	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
 	ctrldev->cdev.owner = THIS_MODULE;
 
-	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
+	ret = ida_alloc_max(&rpmsg_minor_ida, RPMSG_DEV_MAX - 1, GFP_KERNEL);
 	if (ret < 0)
 		goto free_ctrldev;
 	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
 
-	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&rpmsg_ctrl_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto free_minor_ida;
 	dev->id = ret;
@@ -179,9 +179,9 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
 	return ret;
 
 free_ctrl_ida:
-	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
+	ida_free(&rpmsg_ctrl_ida, dev->id);
 free_minor_ida:
-	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
+	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
 free_ctrldev:
 	put_device(dev);
 	kfree(ctrldev);
-- 
2.43.0


