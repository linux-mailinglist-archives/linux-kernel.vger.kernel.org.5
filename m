Return-Path: <linux-kernel+bounces-138664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B989F8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88381F2F06E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF118133D;
	Wed, 10 Apr 2024 13:41:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B2180A8B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756486; cv=none; b=EVskou9tO/L4pXuPz1cvpZBcDaXtIOvipDw+0Kava9LnPKFOgbLjVkDNJ1w3L4o9Xf2nJX1hTDWI3naI1SZTbTxF4TlOfVjT3bLCpRoM2wSJx7FNdD6J0K6scfcL4HPgpFu3vzt8v77uwYjAM6HL1BJ+/biCWrh1o56MX4X0DiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756486; c=relaxed/simple;
	bh=E/R4WnmYuAxReinXHRFy49Y8WI9annFGpZ0d41P4xF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lVWbWTRm+9hMm/Gwwef2hZEU93g7WctvnW5Z+mheHuuc7B7lTw/wGr9Yjyl4EvnOg13VWUtHfqznyOx7kRT5+ifegduZ/71ySid7DO/PfCnljRXpcWjXrHg5v7ZGnIiuOeezOOHq6jYkdVZFZ803vaQsqbWk7dyG8U8ufzDnGg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCT-0003sC-Au; Wed, 10 Apr 2024 15:41:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCS-00BVN6-Tq; Wed, 10 Apr 2024 15:41:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruYCS-00HaVk-2i;
	Wed, 10 Apr 2024 15:41:16 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] HSI: omap_ssi_core: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:41:10 +0200
Message-ID:  <bc6b1caafa977346b33c1040d0f8e616bc0457bf.1712756364.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712756364.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=E/R4WnmYuAxReinXHRFy49Y8WI9annFGpZ0d41P4xF8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpb3ZL8wh8Q1x1FS2lw7F+HU7WWSyhYVj9RBu eMx6GQ88waJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaW9wAKCRCPgPtYfRL+ Tl0+CACbv5YxvkaezS/2dseRf2Y8pCoXnji9se8DRcOVmNXyABe/euTFjLW0xuhmxQuT4sdO6ZH I2ukNmDnFm9oqvBQ+qQTN4AXNaOarRySHRRNFjPjDPSQJR6mvuH7uod0okX7YktOIb8yUR6l5U/ Vvd0IZKHAM7AQKQzxbDQByMgnn917WnsJGnSRwfaAvdWxK8lljcmvFc27vJgqzg4RNVVQ7in8gS I4yS4wcVJvfiX2T1nVUgn0BuZaABZVMTgDWCXLxIYWSJck8ogHLyOX7b1knj5iru6RdYKyznMX6 AGmZX4tcmn4TfTAL+yQvPAKQFoVnyVkm/bPkPN5EautSevg+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hsi/controllers/omap_ssi_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 6802efb4d6cd..3140990a6164 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -547,7 +547,7 @@ static int ssi_probe(struct platform_device *pd)
 	return err;
 }
 
-static int ssi_remove(struct platform_device *pd)
+static void ssi_remove(struct platform_device *pd)
 {
 	struct hsi_controller *ssi = platform_get_drvdata(pd);
 
@@ -561,8 +561,6 @@ static int ssi_remove(struct platform_device *pd)
 	platform_set_drvdata(pd, NULL);
 
 	pm_runtime_disable(&pd->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -618,7 +616,7 @@ MODULE_DEVICE_TABLE(of, omap_ssi_of_match);
 
 static struct platform_driver ssi_pdriver = {
 	.probe = ssi_probe,
-	.remove	= ssi_remove,
+	.remove_new = ssi_remove,
 	.driver	= {
 		.name	= "omap_ssi",
 		.pm     = DEV_PM_OPS,
-- 
2.43.0


