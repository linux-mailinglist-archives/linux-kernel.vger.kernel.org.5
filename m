Return-Path: <linux-kernel+bounces-74481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A2185D505
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A129B2883C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B8481A5;
	Wed, 21 Feb 2024 09:54:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551F945942
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509267; cv=none; b=rr/OGQu4M5QfJZ3dGkB4dyaoF8LDAHUFBYVCmkblTabOeEgTsmaApl1QdHo1FkodcdXMqIOGFUa9fHoNR1/uNkhszk9OJLliBGxsfX5FF+nz/HToBm4nGYJElF2hyie0bHpERKoCGy3C2Pq9ylmr2WGHvbJXtKQrYFkDrvlLd7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509267; c=relaxed/simple;
	bh=VxfuHppooGvLYcqyujJixgDeq0NOYDY6Z9s4et8wZLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NCkehV5qNdSLJWUvPyTphs5yDIrKIY9xgCXOZTtz1Wu+oSThCrmXu1KDRNV16TDHaOhobTeHA+bVu8EoTIA+DKWPoGREviZ0Af1bz2X0VOS1EkZXO/PXO3MPTJsHz6uXLdD3iGZCmDMnlUN79DP3MJESKmL6DUZq+IaYsGPqrYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIq-0007IJ-7A; Wed, 21 Feb 2024 10:54:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020ps-OU; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZl-2B;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] misc: xilinx_sdfec: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:54 +0100
Message-ID:  <705b89c3cd7c0a42ce3f482f202204f5e3377aa2.1708508896.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1818; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VxfuHppooGvLYcqyujJixgDeq0NOYDY6Z9s4et8wZLo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cg2clFZNoEecENcB6Zbo4fh4KajT1/bgMUhP rY2buIYSW+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXINgAKCRCPgPtYfRL+ Tv/BB/91akfTAn2h0Yk5ZAIm5zYDFPx58IDzHHkvqb5tNofqwSlKI1M8QJS5qBt9Cp2oJAEFBHo Iz8fJy0AFPsz6NXCijBB67WKMgP1QM6fDWp7VhbvrdxfAmvg3BYZdfsli2k9C6VLiUz6HV5ik2r vzaZXcvbn6IfsZgq2QbqN6cuzIw6o3JZnAWNCtD1Qbc5pCqtihs/tb4e9xH3g8o0qk828mEPdl4 ig5tVjYbZmDyI0RiNJH971F9zREqpBmCMnrDU1bdCcfTAK04gj2kq9/piSa+sQC9nvd3IuvOTTX Lbb8JXa7zmKluQXUKCIzc6HCoeUNWi62SFiPldsWqOiP3MeN
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
 drivers/misc/xilinx_sdfec.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 94a0ee19bf20..ea433695f4c4 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1420,7 +1420,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int xsdfec_remove(struct platform_device *pdev)
+static void xsdfec_remove(struct platform_device *pdev)
 {
 	struct xsdfec_dev *xsdfec;
 
@@ -1428,7 +1428,6 @@ static int xsdfec_remove(struct platform_device *pdev)
 	misc_deregister(&xsdfec->miscdev);
 	ida_free(&dev_nrs, xsdfec->dev_id);
 	xsdfec_disable_all_clks(&xsdfec->clks);
-	return 0;
 }
 
 static const struct of_device_id xsdfec_of_match[] = {
@@ -1445,7 +1444,7 @@ static struct platform_driver xsdfec_driver = {
 		.of_match_table = xsdfec_of_match,
 	},
 	.probe = xsdfec_probe,
-	.remove =  xsdfec_remove,
+	.remove_new =  xsdfec_remove,
 };
 
 module_platform_driver(xsdfec_driver);
-- 
2.43.0


