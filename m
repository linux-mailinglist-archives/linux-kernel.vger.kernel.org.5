Return-Path: <linux-kernel+bounces-71967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A585AD2D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72590B23BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434315339E;
	Mon, 19 Feb 2024 20:29:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720A51037
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374555; cv=none; b=nnkf9q94PIzpwbRIeIVYyxO2bHpKaiOFLM8Al438jd1E8emehiZiiUgRh113uXTI7VrC5qHH81/23PxjGkjGdBV+6SO43SMT7cybtGu11BD92dGsjxFtJPTnR3bihS5YZ0ZuxZ3VB3BeeSMkEiQmNtxw4g8pqiofCTchVcP1tos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374555; c=relaxed/simple;
	bh=ZP/nBJDy/7TZiOH+/d+Y9CHtVeb5MnzHiWAONgPk/vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0fdSvrCRB8oHDN2CV5STluqp5itqokCum8kUqgZisXyS+fT8p+mxVtSBbjYw2aNCrJonTSomi4gkj+TVyFBdn81mBFJwy+yrWqiBhfcOzWhOzK6qTxj217lSEx+A/aaR0L+RsK6oAnxO2loZVORHGLpd/y51e4mHYlV8bXDjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGG-0007Jk-5i; Mon, 19 Feb 2024 21:29:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGF-001iQB-D8; Mon, 19 Feb 2024 21:29:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcAGF-0084Bl-13;
	Mon, 19 Feb 2024 21:29:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] w1: mxc_w1: Convert to platform remove callback returning void
Date: Mon, 19 Feb 2024 21:28:35 +0100
Message-ID:  <d805f3ccc5bc59584c2575b7b33a56a33f6812c7.1708340114.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708340114.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZP/nBJDy/7TZiOH+/d+Y9CHtVeb5MnzHiWAONgPk/vM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl07n0d/ApK5c9A+8JWLF4qO1B375vgyNbiw9yI zfgzjo2ZiiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdO59AAKCRCPgPtYfRL+ TpDQB/9Kn0NBnSIwi/LA+oTPYqp8tenw2jQFT9nNgzt6CAlKoRoumPGk6lZ8cYTQxX/KNhb2pr9 ZXZf50Y+f7bhr8mvZRK3RYoxHR8lLTbLOTNb8SgVuG4UI7mjZthBa6eKJwFFmtEOi7Nwn/slKpw Y7dPir39d+wrbU0SXxmph31jszgBizOgvb/dL0hTJsugaZd3SnYCS1jslxF+eQLxWqAEEQexap8 0TiQV69xUxF/+s3y7WyOmoyVOel69iz6vjo3IB6U4Xpd6RIfuVEv5CIKEUbCcMmTGVmz/wyG/B6 kU/ZmriAKKPCkPG8urS+cHGy2eFfsLwb5/oOLAg4gKY2ipUd
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
 drivers/w1/masters/mxc_w1.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 090cbbf9e1e2..ba1d0866d1c4 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -151,15 +151,13 @@ static int mxc_w1_probe(struct platform_device *pdev)
 /*
  * disassociate the w1 device from the driver
  */
-static int mxc_w1_remove(struct platform_device *pdev)
+static void mxc_w1_remove(struct platform_device *pdev)
 {
 	struct mxc_w1_device *mdev = platform_get_drvdata(pdev);
 
 	w1_remove_master_device(&mdev->bus_master);
 
 	clk_disable_unprepare(mdev->clk);
-
-	return 0;
 }
 
 static const struct of_device_id mxc_w1_dt_ids[] = {
@@ -174,7 +172,7 @@ static struct platform_driver mxc_w1_driver = {
 		.of_match_table = mxc_w1_dt_ids,
 	},
 	.probe = mxc_w1_probe,
-	.remove = mxc_w1_remove,
+	.remove_new = mxc_w1_remove,
 };
 module_platform_driver(mxc_w1_driver);
 
-- 
2.43.0


