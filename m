Return-Path: <linux-kernel+bounces-4701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 049BC8180C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42854B2153D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53980129EE2;
	Tue, 19 Dec 2023 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="G7InHElt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4FC123
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FSDkr12EOmDWRFSDkrW92Z; Tue, 19 Dec 2023 06:00:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702962045;
	bh=XY0QlJMcPU7Xxpry3VlrLRsMZ3Hy51PgSnqRo3LknqY=;
	h=From:To:Cc:Subject:Date;
	b=G7InHEltsCFWlwRYeoWU8Ff7ExYyW/l90sclEYv0imJcncXNRAKqkM7DQ5oEBfUce
	 NdyaglGIpq/C7lIh5Zn+7FXlIhg4Qk4EBg9SGfVUam2g4un8GBWxyA5UDwDk/vrZMi
	 0P+t6BwpU1PVJdzolgvRLWvzIxx/gYoGzNZ+VjvSciEXSpJR0w8XbetGballZ1uLH/
	 /ZLlq0VeQ8csvlCmxSzs9qSUfsC3maMuguhcGi5wqR1WzrwjC5XmqhLSzcyiRSF9i7
	 8kp6o8a6Dgz+htBqpJkj/DewdYEiKccOikJbtmmfHlglDqi22UQj9pTTfJGO3mKtxE
	 6edoP3SOTVG4g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 06:00:45 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	openipmi-developer@lists.sourceforge.net
Subject: [PATCH] ipmi: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 06:00:39 +0100
Message-Id: <b1a7a75263400742e5fda6bd7ba426772dc8ef11.1702961986.git.christophe.jaillet@wanadoo.fr>
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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/char/ipmi/ipmi_msghandler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index d6f14279684d..b0eedc4595b3 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3053,7 +3053,7 @@ static void cleanup_bmc_work(struct work_struct *work)
 	int id = bmc->pdev.id; /* Unregister overwrites id */
 
 	platform_device_unregister(&bmc->pdev);
-	ida_simple_remove(&ipmi_bmc_ida, id);
+	ida_free(&ipmi_bmc_ida, id);
 }
 
 static void
@@ -3169,7 +3169,7 @@ static int __ipmi_bmc_register(struct ipmi_smi *intf,
 
 		bmc->pdev.name = "ipmi_bmc";
 
-		rv = ida_simple_get(&ipmi_bmc_ida, 0, 0, GFP_KERNEL);
+		rv = ida_alloc(&ipmi_bmc_ida, GFP_KERNEL);
 		if (rv < 0) {
 			kfree(bmc);
 			goto out;
-- 
2.34.1


