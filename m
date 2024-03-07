Return-Path: <linux-kernel+bounces-95295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E67874BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F981C217C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45C12AAD0;
	Thu,  7 Mar 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qj8U/JRm"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E64129A9D;
	Thu,  7 Mar 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805816; cv=none; b=ksxWS8TEOw104dXSl4G8RT+Ere0fZUcMVyL+8CxoNS0ZhipOEF26jtgiizBy/+GiBfe2a7Cbx/UFIZ7LDtd2CLEIZtprKZPjlHF+nUB4kervKElGG8kLhMQja+4FuHVC9DMJU+eUybjlr8cN4gCeqk0lEXVlwRhKROEhBS6js4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805816; c=relaxed/simple;
	bh=ZmM/KDvL4dsGZN7+nQnXpHO7MKx8VXGPnCH7JpgtyqY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLY0LYDRBbKLFei3Y4AUzpAjTrT9BohKrrPMIJyuRMTzIYwtkEeHrS9d5a2InMdvfWhUicNS9A9guNUDztO83qnlAQavGrlPIAYmO98hGIbli792pPMmOSrTraLi9iYxZfbv1KWHRyzrVa2o3qPtPgioesJRl/yRHpj2uaiOKdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qj8U/JRm; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52EB5C000E;
	Thu,  7 Mar 2024 10:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709805807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d/AxLRpsUHIVLv5pAaSheWeekhAHfnPjwxXQfah+6YU=;
	b=Qj8U/JRmx+7EoLMa7KGqnsUrERG4eKO3WkyNvqdMaHf+F+FS51elY5zNcM83F7cBUVVo3H
	TIALt9cEtANxEtLjHm6wipmzdgXMrEsHTyCA4Jr6sRlLX10Lps6MMIVb7O0y9hnw9x3anP
	AUWCeDHdFvCPKGQZSUdBwn5lE9PtNMs6WbrlwMDOo/wuz3yu5bI5ENuBOtI+TPbwZDK3kT
	CO7vJ88N3r9yNKo2KfCL+ypGZ0D2z2rzi/tx8UHhGuAJ3DDIbkGI3Dspz496RQ8p6hnO82
	TZXJYQ9GFvUxD9M6zY0MzrlZOufVcpJfayMu9Dnr4t3b7Oim0c6UQSBGBwuoug==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net-next] ptp: Move from simple ida to xarray
Date: Thu,  7 Mar 2024 11:03:26 +0100
Message-Id: <20240307100327.887758-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Move from simple ida to xarray for storing and loading the ptp_clock
pointer. This prepares support for future hardware timestamp selection by
being able to link the ptp clock index to its pointer.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
---
 drivers/ptp/ptp_clock.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 3aaf1a3430c5..392c880d9f34 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -31,7 +31,7 @@ struct class *ptp_class;
 
 static dev_t ptp_devt;
 
-static DEFINE_IDA(ptp_clocks_map);
+static DEFINE_XARRAY_ALLOC(ptp_clocks_map);
 
 /* time stamp event queue operations */
 
@@ -201,7 +201,7 @@ static void ptp_clock_release(struct device *dev)
 	bitmap_free(tsevq->mask);
 	kfree(tsevq);
 	debugfs_remove(ptp->debugfs_root);
-	ida_free(&ptp_clocks_map, ptp->index);
+	xa_erase(&ptp_clocks_map, ptp->index);
 	kfree(ptp);
 }
 
@@ -246,11 +246,10 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	if (ptp == NULL)
 		goto no_memory;
 
-	index = ida_alloc_max(&ptp_clocks_map, MINORMASK, GFP_KERNEL);
-	if (index < 0) {
-		err = index;
+	err = xa_alloc(&ptp_clocks_map, &index, ptp, xa_limit_31b,
+		       GFP_KERNEL);
+	if (err)
 		goto no_slot;
-	}
 
 	ptp->clock.ops = ptp_clock_ops;
 	ptp->info = info;
@@ -378,7 +377,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
 	list_del(&queue->qlist);
 	kfree(queue);
 no_memory_queue:
-	ida_free(&ptp_clocks_map, index);
+	xa_erase(&ptp_clocks_map, index);
 no_slot:
 	kfree(ptp);
 no_memory:
@@ -511,7 +510,7 @@ static void __exit ptp_exit(void)
 {
 	class_destroy(ptp_class);
 	unregister_chrdev_region(ptp_devt, MINORMASK + 1);
-	ida_destroy(&ptp_clocks_map);
+	xa_destroy(&ptp_clocks_map);
 }
 
 static int __init ptp_init(void)
-- 
2.25.1


