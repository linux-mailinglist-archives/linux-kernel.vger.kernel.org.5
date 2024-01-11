Return-Path: <linux-kernel+bounces-24090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E24082B6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226AF1F2455A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B458208;
	Thu, 11 Jan 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tQPfcVEY"
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248C58202
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id O2gQrjIMaEoWxO2gQr1lEn; Thu, 11 Jan 2024 22:33:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705008831;
	bh=Gio5dE3n1eUfk5KMSgT5ASvtSznc7hTtsqMjtYfQM6o=;
	h=From:To:Cc:Subject:Date;
	b=tQPfcVEYnzX/dh5g0qSG9kJOUOksYTfDoj7wmGU0+RxBcySjyF6VkjK4XKWOT0dVS
	 8BgLn8UcZuq3hsbuSKwGgn3vRIjuKLgez2ZRuyK3Kw4To9pW063iVTG0Yr16yvK2vg
	 Vw1n2y3rjCIzSffEjuUJqDnIJhMRvOsqmLs0z+bIwEyaQcLC/auU6jNM9jglB8D6yA
	 IxqZ7LRYQSIM57j0l/DQLutuEOP6LscRi+X0dwdppx2+kPDhXcbg+N1drJNtzR1tKJ
	 XpF6v9Ou7TCwNoarbpTqe8iEq9gX87l41nPjdnXuJ5aOMRWzUY/b04hUG9hfyDL/Ba
	 HiU4RKXSicZRw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 11 Jan 2024 22:33:51 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-media@vger.kernel.org
Subject: [PATCH] media: dvb-frontends/dvb-pll: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 11 Jan 2024 22:33:44 +0100
Message-Id: <920639b9e05775eea56ecb9cd5ed38ad292a96a8.1705008803.git.christophe.jaillet@wanadoo.fr>
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
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/media/dvb-frontends/dvb-pll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-frontends/dvb-pll.c b/drivers/media/dvb-frontends/dvb-pll.c
index ef697ab6bc2e..1775a4aa0a18 100644
--- a/drivers/media/dvb-frontends/dvb-pll.c
+++ b/drivers/media/dvb-frontends/dvb-pll.c
@@ -796,7 +796,7 @@ struct dvb_frontend *dvb_pll_attach(struct dvb_frontend *fe, int pll_addr,
 	b1[0] = 0;
 	msg.buf = b1;
 
-	nr = ida_simple_get(&pll_ida, 0, DVB_PLL_MAX, GFP_KERNEL);
+	nr = ida_alloc_max(&pll_ida, DVB_PLL_MAX - 1, GFP_KERNEL);
 	if (nr < 0) {
 		kfree(b1);
 		return NULL;
@@ -862,7 +862,7 @@ struct dvb_frontend *dvb_pll_attach(struct dvb_frontend *fe, int pll_addr,
 	return fe;
 out:
 	kfree(b1);
-	ida_simple_remove(&pll_ida, nr);
+	ida_free(&pll_ida, nr);
 
 	return NULL;
 }
@@ -905,7 +905,7 @@ static void dvb_pll_remove(struct i2c_client *client)
 	struct dvb_frontend *fe = i2c_get_clientdata(client);
 	struct dvb_pll_priv *priv = fe->tuner_priv;
 
-	ida_simple_remove(&pll_ida, priv->nr);
+	ida_free(&pll_ida, priv->nr);
 	dvb_pll_release(fe);
 }
 
-- 
2.34.1


