Return-Path: <linux-kernel+bounces-24053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58382B615
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0DCB26906
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221758225;
	Thu, 11 Jan 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d5VrmVml"
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828CE58AAC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id O1l4rDaqGsg4OO1l4rAocH; Thu, 11 Jan 2024 21:34:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705005275;
	bh=RLXbEOhYO7cx+Vn35fW6jbiCqUmAKgWTACteZwWafQ4=;
	h=From:To:Cc:Subject:Date;
	b=d5VrmVmlEiqOJEh58FzdOZRSx/wdg4VuBqSAXWOAqvuNIwJuHVdtq7xH4BYplz2Cg
	 YThE2r8GuvwLQYJOC2pz8JAVkDxXOOFdiB+94d4XumWDMafaj9vLAWQQoRNvfoXQl9
	 nglyVv6nWT+aF3ltC331ChTlp8p6lmXcmiRl2L1qGXiEppBlACYaoF7yOQnphTlPMl
	 BBkas+8aEgYxllVszp7E+vlcZqej5oP/LvZpWm/mHDbaudNHMcFlg6usuoD21hN1vA
	 1ikXwPmOQjXAMQSNewQD4ffrUixxZEV/gcNadUjCJ6n5M/iPRvca5y5UhStXAdMJ3I
	 Un5gHJ/+840QA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jan 2024 21:34:35 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] intel_th: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 11 Jan 2024 21:34:32 +0100
Message-Id: <9c092dc6db15984d98732510bb052bb00683489b.1705005258.git.christophe.jaillet@wanadoo.fr>
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
 drivers/hwtracing/intel_th/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..86c8efecd7c2 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -871,7 +871,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 	if (!th)
 		return ERR_PTR(-ENOMEM);
 
-	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
+	th->id = ida_alloc(&intel_th_ida, GFP_KERNEL);
 	if (th->id < 0) {
 		err = th->id;
 		goto err_alloc;
@@ -931,7 +931,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
 			    "intel_th/output");
 
 err_ida:
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 err_alloc:
 	kfree(th);
@@ -964,7 +964,7 @@ void intel_th_free(struct intel_th *th)
 	__unregister_chrdev(th->major, 0, TH_POSSIBLE_OUTPUTS,
 			    "intel_th/output");
 
-	ida_simple_remove(&intel_th_ida, th->id);
+	ida_free(&intel_th_ida, th->id);
 
 	kfree(th);
 }
-- 
2.34.1


