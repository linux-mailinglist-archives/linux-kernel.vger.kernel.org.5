Return-Path: <linux-kernel+bounces-74473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B1585D4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A672869F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B573FE44;
	Wed, 21 Feb 2024 09:54:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53C3FB29
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509261; cv=none; b=qoFCWPhpTrq2WMjs9CyhPYBaUU2il9fAa/2t/bkIocYIGDjHbfRx40ME7MY3Ha9w39Aeg2kxi5FkP1dc8LprAJPGmb6T3L1+qAt1LLv53Ka/bikiAEMTphoEYD5RFABoKuzKPd97Svm/G3aSlCXOaZVU/LWyD1ILHV+PxwRUK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509261; c=relaxed/simple;
	bh=wV5kOQQfXa7GmI/jCQbHnD85OwAc3mvAy5KiOozQ2RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdOAzhzmFhAGKit7NIf9IXZbtwbkLQG3Uy/v4Srxs2gRAd4E581+1sOy85dJgixLIP0i5JuxPvqSJzsZwTjt8zAhlcyoCS0x1GzvX4H4c+4jiDlAQmYIEhYyIT+6rByntTVc55Qq2IL6oPKW8sNT2c4gWHhfymnz6VHzJXmFNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007H1-MV; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020pg-9a; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZZ-0h;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] misc: sram: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:51 +0100
Message-ID:  <946ebc33a01bf700171257cd219fbe8626bc0c99.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=wV5kOQQfXa7GmI/jCQbHnD85OwAc3mvAy5KiOozQ2RI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cgyU0JVrN1V9zkvCCkVIv3zFiQ9RASp2zLO2 TXJgFhQxNiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXIMgAKCRCPgPtYfRL+ Tt0IB/4+erNGWGYeMSgID+MQEJcmU9vfMnLacTUdPxy2z0hZTGvKHZMHO0QnctylkeRNDsMKWIe faR2xZK05iHhn2xdEL94o3LW+5G8CpiSx/69zX7p5Jdq5tCtd/b/VTZe5b0bZjTOU8Rjzo3WKCA H6/R2DZOoDvzeF8Ft7Riukq2UZqArzqZVgW85qYRsMK0RAWfdKTSgxqI0iWgsJ93lgwCClX1NnH qOanxSL8Nq0vHI9mc0rruWscMeGFG4wR1FbPhVTGkUdnb5uU7kw2hH3+rbds3pXKrl53G4hOfNv TerGfXEJEim+xDev9xi7671TvTDex/E4drmQlEP3WNEnlYBw
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
 drivers/misc/sram.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index e248c0a8882f..546eb06a40d0 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -435,7 +435,7 @@ static int sram_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sram_remove(struct platform_device *pdev)
+static void sram_remove(struct platform_device *pdev)
 {
 	struct sram_dev *sram = platform_get_drvdata(pdev);
 
@@ -443,8 +443,6 @@ static int sram_remove(struct platform_device *pdev)
 
 	if (sram->pool && gen_pool_avail(sram->pool) < gen_pool_size(sram->pool))
 		dev_err(sram->dev, "removed while SRAM allocated\n");
-
-	return 0;
 }
 
 static struct platform_driver sram_driver = {
@@ -453,7 +451,7 @@ static struct platform_driver sram_driver = {
 		.of_match_table = sram_dt_ids,
 	},
 	.probe = sram_probe,
-	.remove = sram_remove,
+	.remove_new = sram_remove,
 };
 
 static int __init sram_init(void)
-- 
2.43.0


