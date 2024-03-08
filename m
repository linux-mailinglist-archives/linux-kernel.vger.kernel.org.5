Return-Path: <linux-kernel+bounces-96702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615387603E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F053B22EC8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA43454673;
	Fri,  8 Mar 2024 08:52:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4953800
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887921; cv=none; b=srr1ZoTt/G8uFvhabUf8wQgWlietqdV01KjXTDiKmyLICB0w3yCBE3v0WbjIShrcw8+k1ft11YFy4oPCJbFyJECCyD6Ccxdo85SVlAcVzpcGSasHD5Vmd+PeA6x4Z1CdKL2YmShYqPM7mm5UdGf+1KJ+0gtB+UIbGt1z6IcirPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887921; c=relaxed/simple;
	bh=sXsUJ/nA3ljECdr2wQLCY2YJOOmYnvXDCnq7JtNFB5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VSQC/Jvc29XL21X6TpIJQRtGXhLscQ3LCz+Yc9phv8q5AK9U6nnGlFUTUg6M/A5jfgkOCvSOI7WrZw81ZC2HgXHwtUZAq89h54y/2GYswqpdzXXWh2dj+xHM5phHdvg6s+IahrMVODehK3fzPfbN58d1sXhRW68DQmiJGaDM+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0006vM-Ef; Fri, 08 Mar 2024 09:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxE-0056N0-Uz; Fri, 08 Mar 2024 09:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxE-00245N-2n;
	Fri, 08 Mar 2024 09:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] cdx: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:05 +0100
Message-ID:  <5d40f57e978bcce003133306712ec96439e93595.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sXsUJ/nA3ljECdr2wQLCY2YJOOmYnvXDCnq7JtNFB5A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tF7S13dCqHL9wkrsa6kktj7ECADySZY+bKUp 4TALkVKpAyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRewAKCRCPgPtYfRL+ TvBzB/9oPV4E0q8Tm//+Fza+nF/CrqlKC8BLShGDMZ3abGZKccQEBrS/tE2jPE4dnyBTqOHpCXx ryesufTeoq+H8OazJmrYDhIJrKYIUTzGVogorIuNnW23trctkLNF1lCLy4KgRin2yHXPukHv+cH 1BrVQd6FUKYXy8e6qcCAI2pWf6sKEcP+QYxb46PlrzcKeRih00u4zIZo1WqG+5w68FGMFaQ+pvh 9t+DUk12hXWfYpDymH55UEczL1EzF8sBRiPwLF5gVE19au+rCyYDsdeO76ohwhu6ybogUKRd2BI e9oZ+fwueAOhlTx5QmnQJ1l5oB6VBhNJoblTIz23wb2VgIzM
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
 drivers/cdx/controller/cdx_controller.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index 85fe4b1c4e5e..9e99baf43db1 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -198,7 +198,7 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xlnx_cdx_remove(struct platform_device *pdev)
+static void xlnx_cdx_remove(struct platform_device *pdev)
 {
 	struct cdx_controller *cdx = platform_get_drvdata(pdev);
 	struct cdx_mcdi *cdx_mcdi = cdx->priv;
@@ -209,8 +209,6 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
 	cdx_mcdi_finish(cdx_mcdi);
 	kfree(cdx_mcdi);
-
-	return 0;
 }
 
 static const struct of_device_id cdx_match_table[] = {
@@ -227,7 +225,7 @@ static struct platform_driver cdx_pdriver = {
 		   .of_match_table = cdx_match_table,
 		   },
 	.probe = xlnx_cdx_probe,
-	.remove = xlnx_cdx_remove,
+	.remove_new = xlnx_cdx_remove,
 };
 
 static int __init cdx_controller_init(void)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


