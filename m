Return-Path: <linux-kernel+bounces-2782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 689E88161C7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0A01C21BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A309481B2;
	Sun, 17 Dec 2023 19:31:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9A481AB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrh-0007Gf-0H; Sun, 17 Dec 2023 20:31:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-00GXTn-If; Sun, 17 Dec 2023 20:31:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEwrg-004owA-9V; Sun, 17 Dec 2023 20:31:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] memory: emif: Simplify code handling CONFIG_OF
Date: Sun, 17 Dec 2023 20:31:32 +0100
Message-ID:  <9d53683c34a730c8579a1468b643b11d1379106e.1702829744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702829744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UHloRVwjjpUa4EBDR6pja+PDlmCiXF568S5ktJTQgoc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlf0yXR76tMQcRZQjv60lpw/WVYuSOoAAM2PoLS ucd3JRLq7aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX9MlwAKCRCPgPtYfRL+ TsmeB/wM2bxYP6wMGCtl5hvyzR28sHfzThhCfKTnPAfEBBqUgqiKZkpzSO2CVcJhNgLVqV6cgQl wyyncvZe+Dv5+CIhpqlfsNUB8PGtCsN4HYlTa/kxGSgTulv53IzQtKPLiMVaetoMISHEpp2q/mR +N0eoiTwKf25+qC0YTaWuUV0qNt57I9KFRHYPGfcfFZk0oC+FATExB6NsHtog0veYBNSNmDvIVK OPpfiPojLpaBwXDHlZ/RmxSwbT20k0tBV7khG9kt+3+O/awc6q8TIYnSTV39O5Zry2eUfKSJEHL /5A3ZvMtySqt9Jfa2G6zZzsV+FsmGLKEYJyWDpuarMBn1PVk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The first thing that of_get_memory_device_details() does is calling
of_parse_phandle(). With CONFIG_OF=n this returns NULL in a static
inline function. So the compiler can determine that
of_get_memory_device_details() also returns NULL. bloat-o-meter confirms
that this patch has no effects on the size of the generated code for
CONFIG_OF=n builds.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/memory/emif.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index dd1d87f8fdc8..5a3194b9b3bc 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -826,7 +826,6 @@ static int is_custom_config_valid(struct emif_custom_configs *cust_cfgs,
 	return valid;
 }
 
-#if defined(CONFIG_OF)
 static void __init_or_module of_get_custom_configs(struct device_node *np_emif,
 		struct emif_data *emif)
 {
@@ -983,15 +982,6 @@ static struct emif_data * __init_or_module of_get_memory_device_details(
 	return emif;
 }
 
-#else
-
-static struct emif_data * __init_or_module of_get_memory_device_details(
-		struct device_node *np_emif, struct device *dev)
-{
-	return NULL;
-}
-#endif
-
 static struct emif_data *__init_or_module get_device_details(
 		struct platform_device *pdev)
 {
-- 
2.42.0


