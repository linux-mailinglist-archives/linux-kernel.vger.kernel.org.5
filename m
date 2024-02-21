Return-Path: <linux-kernel+bounces-74476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167A85D500
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F23C1C224DC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49545BEA;
	Wed, 21 Feb 2024 09:54:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CA741C63
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509264; cv=none; b=dBUGIuN4wlP0YYLqIK9GOS3fIZN64kuF77Y8XBoy6OFRhrv2Bwi34u0NrLv4h1kYwFix1cTOvXFlQEFjb5DSOzJGKpN/Sh1Njk+PktnUFOMOEEgDDpIQDP5Jbh6zXS68DdIXgrXVXT9IcxB6Fkl0yS3VssN6TQqGPv7V5cW9vsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509264; c=relaxed/simple;
	bh=OnqiDENxLgv+Hdr/2dddEJW1stD4i0Wo/6jjciqiaTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZU+1Y+3EaW6D5VQvhSATrXpZ6WpNoPuGX8zLbB4alRNhYaGOTmXkE7AoTGnixrCdAMygpuFYVrhKtUL5CYnA5Xc4bvW9bMG+7vuBlaX5sSj9ox6nw+JSAmqz4OdMMDYAIz5PASdzdA5z/iBuyW4ppZ5Ti2btbl1tfNeOPzr0Aag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007Gf-U7; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-0020pR-Lq; Wed, 21 Feb 2024 10:54:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIo-008mZJ-1t;
	Wed, 21 Feb 2024 10:54:10 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] misc: fastrpc: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:47 +0100
Message-ID:  <d138bc7f6ec39038d2b5a23478fc036a41988bde.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=OnqiDENxLgv+Hdr/2dddEJW1stD4i0Wo/6jjciqiaTE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cguyuD3xtkWfev8vaKM8wwcSRnbzBHzwrofI qZ5Jb33IlyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXILgAKCRCPgPtYfRL+ TrJAB/937rVXXIrU6xLenhr5DP9/kGRz5bnAUD40kOuLGbiouZwQn1jl6jXmCPcSlHnJYH1KIjp VEj9kngIHiZEzmIQKhPP1PGtMTL1YdLdxaRG/Uj+BWjwAmaS/Tk923kPHx8dbJxGUNZ+nO//PQs Rp82zzqv9TkoNEkF7bnDSrsXf5+P2LYT4dNVJTZECPISPNKCkarxxXO5CiQ8o/fisL+TfWsegE2 DhS9vJn+Atd16osTyVrFskEV6QVvtabMj4xmQedKbjInl+6UaIj1KqJHN1ATWQXeQcueUqO7Np4 FEsUw7jA1fXzq6fjIYZklGs225Te2PBvMkwy31g6BbPbCBUg
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
 drivers/misc/fastrpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 03319a1fa97f..0bfff1d42da2 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2183,7 +2183,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int fastrpc_cb_remove(struct platform_device *pdev)
+static void fastrpc_cb_remove(struct platform_device *pdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(pdev->dev.parent);
 	struct fastrpc_session_ctx *sess = dev_get_drvdata(&pdev->dev);
@@ -2198,8 +2198,6 @@ static int fastrpc_cb_remove(struct platform_device *pdev)
 		}
 	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
-
-	return 0;
 }
 
 static const struct of_device_id fastrpc_match_table[] = {
@@ -2209,7 +2207,7 @@ static const struct of_device_id fastrpc_match_table[] = {
 
 static struct platform_driver fastrpc_cb_driver = {
 	.probe = fastrpc_cb_probe,
-	.remove = fastrpc_cb_remove,
+	.remove_new = fastrpc_cb_remove,
 	.driver = {
 		.name = "qcom,fastrpc-cb",
 		.of_match_table = fastrpc_match_table,
-- 
2.43.0


