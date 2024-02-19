Return-Path: <linux-kernel+bounces-71163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B185A182
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5515EB220A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D1C2C19F;
	Mon, 19 Feb 2024 10:59:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D892328DD0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340381; cv=none; b=FiHl4OR7lXmI4tv5R9Wv6lsqnJVqNwYhhW5RHwJfxQZwGznfx61Apaw0A2+ytZdzqnyj7npPDBJyVQszqxYfLPv6uMpeJlz3hqOSqDZX6eiVVeiP2dS9uzqnuTUBxfBzcSUL4KbojvTRIVhZ6NkXNPWfre761zsW5ia/zd+3HGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340381; c=relaxed/simple;
	bh=LeFkUhF7INlM3yuDLb1Rsn627568Wm2uaSf9+/UNkoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaCZ/xJUD9HfQDdq+IoV3jLov2ANUESL3m2DwOgeeh0FQyf37ReFRSiSZZXZu3CconoAkbi4KRgD6OsOwCFer0Vw5jpmwJBKK1TPWSBN+HJQN7FukhjjU6YYJUTqzevJvkXLVJTUBhc6MhMtDGb5cxDgLwIWMJ5mlS8lFNBWdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N2-0007t1-8l; Mon, 19 Feb 2024 11:59:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N1-001dBA-S9; Mon, 19 Feb 2024 11:59:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rc1N1-007lm1-2Y;
	Mon, 19 Feb 2024 11:59:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] w1: omap_hdq: Convert to platform remove callback returning void
Date: Mon, 19 Feb 2024 11:59:28 +0100
Message-ID:  <f3a7eaee59020bf879249304eaaf9839c7e17222.1708340114.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LeFkUhF7INlM3yuDLb1Rsn627568Wm2uaSf9+/UNkoc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl0zSQzv197BQttr+MmgiSNlxIVPdKy8hHHTXuy aHDevX/JKmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdM0kAAKCRCPgPtYfRL+ To/gCACEbqrpt26gtKcuJmYLXGd59FyHz2ICXd2bZHcLu4NwXNrd1CzunUdeXdpB1umeHcoXNRS 7rHWwIAVDNvsnNrKQ/p6Rna1xrIqk6St/6roDK903rwCogvgHqk/FhcEy9bzJQQjNt0yI8ERym7 sZ/vxWvTf97kJE/l+BdQrXYyBx8cbTKBufMl5BSbmwuAuRPGDGNkfF1ostHHmAmT/oKHMf534i5 ncWyeu4MtuJ+KFMGmif788caBXtjZNiWzlZRgKUzpLDrNvq2W40/22lbuAar666xUcSnVWo2l2+ piKSoWh2aveY8xTbVMxkXO25RIGpwfyh4IymKp2W4Sv3Vb1l
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
 drivers/w1/masters/omap_hdq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 6a39b71eb718..d1cb5190445a 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -647,7 +647,7 @@ static int omap_hdq_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int omap_hdq_remove(struct platform_device *pdev)
+static void omap_hdq_remove(struct platform_device *pdev)
 {
 	int active;
 
@@ -661,8 +661,6 @@ static int omap_hdq_remove(struct platform_device *pdev)
 	if (active >= 0)
 		pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id omap_hdq_dt_ids[] = {
@@ -674,7 +672,7 @@ MODULE_DEVICE_TABLE(of, omap_hdq_dt_ids);
 
 static struct platform_driver omap_hdq_driver = {
 	.probe = omap_hdq_probe,
-	.remove = omap_hdq_remove,
+	.remove_new = omap_hdq_remove,
 	.driver = {
 		.name =	"omap_hdq",
 		.of_match_table = omap_hdq_dt_ids,
-- 
2.43.0


