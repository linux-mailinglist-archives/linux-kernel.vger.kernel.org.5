Return-Path: <linux-kernel+bounces-95987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB968755AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB85B24340
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EE8131756;
	Thu,  7 Mar 2024 17:59:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FC1EB41
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709834353; cv=none; b=SPaw0GdX1QcLLbixPer7l8I+zjwgkDy1V3F9PBCUkzWoDWidf33c0rvGiLPwtpzywuMwdIIgymNcZeB2CdsBzGV43QWz6VOdchwisQKAlH/xIJODJfvxmxqq+Y8v9tvom5GfY+5825nmJ/y4WTHyykhy4QVPX7uOupn5oC+RJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709834353; c=relaxed/simple;
	bh=/F3L6EUgDhWCdLmZZ9eUNAUZH3WBSnnyUUVDdWplyBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mSKruFQ6xPf3ly8uEgJdakKWxmebDm/xvQz+sDrbSJ698ZM7TL/gHc7JErvMNRVkhhXwG242hcA00YlP1jqYv8YsnrRHxHxm2ENgOsXpfEw/tvpjoWOZSTxnSkpWwBDXWKmYMZvbkfHrc34yOg71Kf5FXC0MTeFoDqX1aK5fwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI1K-0001YB-T9; Thu, 07 Mar 2024 18:59:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI1K-004zCE-DM; Thu, 07 Mar 2024 18:59:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI1K-001SWj-13;
	Thu, 07 Mar 2024 18:59:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] mcb: lpc: Convert to platform remove callback returning void
Date: Thu,  7 Mar 2024 18:59:03 +0100
Message-ID: <20240307175903.189283-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/F3L6EUgDhWCdLmZZ9eUNAUZH3WBSnnyUUVDdWplyBA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6gBnjAEgCQKRcr5RVHr0e9nxoys9ODmHFov4v bekggazU0SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeoAZwAKCRCPgPtYfRL+ Tso9CACabXtyn6SYLDvA+46dFn/oO/9a3GI7jDyyMv/0JFR8yFhAJ5GDYo80DQRtMDVgDNzZ2BJ rKSauWtrvpR0Q3QBOpCDKmX//uooygJSvuiEBxe0nYdBzy4ZrhX62AcwxVif471y0iz8Tik86Nk GWc4HVpTo171zOCQEjm36WI301/bX86PC/xNuB9NtVDlv8FCg9jOxyw/UJDwf0NnB8jml3UZxX7 8vUnkmBPuwxU3KxEWg2xiYTwpuQWCjJ5acMcGzqujkprtxWSqkLiHMlcqMkBPWIKhYcmfvx/PcG PoaaMzrokc5s8nxryJqoogWz79pR6DefBHF+giSmSpN18ytF
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
 drivers/mcb/mcb-lpc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mcb/mcb-lpc.c b/drivers/mcb/mcb-lpc.c
index a851e0236464..2bec2086ee17 100644
--- a/drivers/mcb/mcb-lpc.c
+++ b/drivers/mcb/mcb-lpc.c
@@ -97,13 +97,11 @@ static int mcb_lpc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mcb_lpc_remove(struct platform_device *pdev)
+static void mcb_lpc_remove(struct platform_device *pdev)
 {
 	struct priv *priv = platform_get_drvdata(pdev);
 
 	mcb_release_bus(priv->bus);
-
-	return 0;
 }
 
 static struct platform_device *mcb_lpc_pdev;
@@ -140,7 +138,7 @@ static struct platform_driver mcb_lpc_driver = {
 		.name = "mcb-lpc",
 	},
 	.probe		= mcb_lpc_probe,
-	.remove		= mcb_lpc_remove,
+	.remove_new	= mcb_lpc_remove,
 };
 
 static const struct dmi_system_id mcb_lpc_dmi_table[] = {

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


