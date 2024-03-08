Return-Path: <linux-kernel+bounces-96701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081FE876038
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A391F278E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A1537E5;
	Fri,  8 Mar 2024 08:51:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772DF208AD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887918; cv=none; b=VpGw9XYXCMBGEd9slVPWprLwi+ua4cI1dN1vER+pswF5zjwASNhtc72GKfUzpRsbdGKCTSz9T9bCPhcGpslKahuUpect0KQsi5etiNbNTcNB8WYvUrla0fTo0GnBUewKNd9ihltN+m5kt8DcPYu6oV0KRL4dxVHmf68OABMZ1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887918; c=relaxed/simple;
	bh=aVN8+EY/uO3cH4FEyS7VfiUXi1DIt1cu/7mR+1Q406s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LjSob8jXUotiVmPydxYC1IXYzsyVpId9xN64z0mtGA7PlyPXLakPuQj6ObNG+kB+mbWRlhVIjc0RbJo4m7mJzazqggslud37yh/wl9Dza9LtrO5s2/xKixv2qRD6UUqpd/YxpwBL2h9sSvd40CPdbW34sGNaBtitfkN+44mrFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0006wb-Ea; Fri, 08 Mar 2024 09:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0056NT-1J; Fri, 08 Mar 2024 09:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-00245s-35;
	Fri, 08 Mar 2024 09:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH] phy: xilinx: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:13 +0100
Message-ID:  <57a3338a1cec683ac84d48e00dbf197e15ee5481.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aVN8+EY/uO3cH4FEyS7VfiUXi1DIt1cu/7mR+1Q406s=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRXF1si/vb/PSe45SCjRmGIw8xerZNOGfblPP3qfFvys zrFV+7qZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiKc7s/8tcY5vkpm0St7Tb s9f2PWug6qxKa5X7KqK9Zza+OT9d1r+68h9vYWX8cZYTPa+uf2C/fU911ep9+gYXZjHWRimkNJx YevbjwnXL7DN5G1bpM83M7WeLiVFw6v94Q8dP5vZ20eaKsCTt+I3hSgv8zj8z5ZNJuslx2Ydzg3 aguh2PgIrh1snVue4BkxY2nXEq3tGkofxz7c7OkvLjnbKzFfe5n0l+l9j5lKfTWmiutZKMlRrb2 TnZAZsMHp4K6DOTXPHeaPlut/dmK+/7HPojLeMYsTF1tXuzSNTXjSwOp89nNas2v+bZKyi8S1Gs MZLjRvPOpb2MctJPr0wUEVnLdW3O3N/rb/64embNjqJ3AA==
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
 drivers/phy/xilinx/phy-zynqmp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index f72c5257d712..dc8319bda43d 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -995,15 +995,13 @@ static int xpsgtr_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xpsgtr_remove(struct platform_device *pdev)
+static void xpsgtr_remove(struct platform_device *pdev)
 {
 	struct xpsgtr_dev *gtr_dev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(gtr_dev->dev);
 	pm_runtime_put_noidle(gtr_dev->dev);
 	pm_runtime_set_suspended(gtr_dev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id xpsgtr_of_match[] = {
@@ -1015,7 +1013,7 @@ MODULE_DEVICE_TABLE(of, xpsgtr_of_match);
 
 static struct platform_driver xpsgtr_driver = {
 	.probe = xpsgtr_probe,
-	.remove	= xpsgtr_remove,
+	.remove_new = xpsgtr_remove,
 	.driver = {
 		.name = "xilinx-psgtr",
 		.of_match_table	= xpsgtr_of_match,

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


