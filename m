Return-Path: <linux-kernel+bounces-24095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D337B82B6BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C501F250A8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6D58138;
	Thu, 11 Jan 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tRJryxdv"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A871B58139
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id O2kvrjK5uEoWxO2kvr1liJ; Thu, 11 Jan 2024 22:38:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705009111;
	bh=qNcz+UO2mUsUFAtzyQkwuTcfkJ/hn5W8acDGOdU1jWM=;
	h=From:To:Cc:Subject:Date;
	b=tRJryxdvfdFID44/dVQIU+QTaPrDzj/4z5TzBszlXQAK4ngnwjPJWkRzBUDGVDSVj
	 EHNLswr4KvA3NmAZyA98L3J4M9spEtqpUbgspTj6bzUGKiz3+q21fLTmYFZqJT0v87
	 oMj2c7TXrMl2p23szPc1o9S512OXrVZuKDjhIMkaR/+vTGlZqRMoRg1FKC4eurTKpT
	 yoh/MAAJjEw7IyWMQxGBtB7CsHbWEXb9mQO5EtSffokkiyk7CUS2RigGqKfF8OKafW
	 eexYE2FaTX39QBYNBnLFq7/+99PvwCjU0pmi6AkQB7ScoUNeX1coKrpZXmDjNuVNhN
	 0Ds9cbbPDUErA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jan 2024 22:38:31 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: core: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 11 Jan 2024 22:38:25 +0100
Message-Id: <bc5b82db59ccac69f2612ba104e2f5100401a862.1705009009.git.christophe.jaillet@wanadoo.fr>
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

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added when
needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/watchdog/watchdog_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 5b55ccae06d4..aff2c3912ead 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -260,12 +260,12 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	if (wdd->parent) {
 		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
 		if (ret >= 0)
-			id = ida_simple_get(&watchdog_ida, ret,
-					    ret + 1, GFP_KERNEL);
+			id = ida_alloc_range(&watchdog_ida, ret, ret,
+					     GFP_KERNEL);
 	}
 
 	if (id < 0)
-		id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
+		id = ida_alloc_max(&watchdog_ida, MAX_DOGS - 1, GFP_KERNEL);
 
 	if (id < 0)
 		return id;
@@ -273,19 +273,20 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 
 	ret = watchdog_dev_register(wdd);
 	if (ret) {
-		ida_simple_remove(&watchdog_ida, id);
+		ida_free(&watchdog_ida, id);
 		if (!(id == 0 && ret == -EBUSY))
 			return ret;
 
 		/* Retry in case a legacy watchdog module exists */
-		id = ida_simple_get(&watchdog_ida, 1, MAX_DOGS, GFP_KERNEL);
+		id = ida_alloc_range(&watchdog_ida, 1, MAX_DOGS - 1,
+				     GFP_KERNEL);
 		if (id < 0)
 			return id;
 		wdd->id = id;
 
 		ret = watchdog_dev_register(wdd);
 		if (ret) {
-			ida_simple_remove(&watchdog_ida, id);
+			ida_free(&watchdog_ida, id);
 			return ret;
 		}
 	}
@@ -309,7 +310,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 				pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
 					wdd->id, ret);
 				watchdog_dev_unregister(wdd);
-				ida_simple_remove(&watchdog_ida, id);
+				ida_free(&watchdog_ida, id);
 				return ret;
 			}
 		}
@@ -382,7 +383,7 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 		unregister_reboot_notifier(&wdd->reboot_nb);
 
 	watchdog_dev_unregister(wdd);
-	ida_simple_remove(&watchdog_ida, wdd->id);
+	ida_free(&watchdog_ida, wdd->id);
 }
 
 /**
-- 
2.34.1


