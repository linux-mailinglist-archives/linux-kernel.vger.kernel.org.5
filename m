Return-Path: <linux-kernel+bounces-1063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE18149DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D2286093
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2E43588D;
	Fri, 15 Dec 2023 13:59:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4C31A73
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-0002mX-Ni; Fri, 15 Dec 2023 14:59:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8ix-00G2Zt-9c; Fri, 15 Dec 2023 14:59:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-003cCg-Vu; Fri, 15 Dec 2023 14:59:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] perf: fsl_imx8_ddr: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:11 +0100
Message-ID:  <c5b76bf352385d8ef6211ee8c43352c74eee064d.1702648125.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702648124.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=T+20pqO282TURQ3KdX9THzy7jvQJXD3iKvoD14JC1QE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFuxbrW2Q2PBwqQM4KAykWSBx75C886HAfiiG N9zzX46qnyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbsQAKCRCPgPtYfRL+ TqngCACUznhYhR8/BzUWG4hp303BWa3SfxSmsN5tbFkOpRb0acP7jKPKS4I7sOqxOeGneQWBCRy 5ZzIULjqO0zTyhnEn9S84dJL619cRTzQGlhi8D0nR33rRCL77eHWD7VIAgwubHYwpVpPX7lXOMS yAwjU2ryhwe7oezSSMrwBK1gv7W/2/wP6UlECKixF4SGK8Nl5xQlEYstnUkbV1pWQt7nit0bsGx dUBQJPvnCQIzi+U2WD5o1vix9RJSi8JTRUMZweWk9h5cMqdkla+cdKjN1rTw12munZhHlOZHVqb eZbhrpDVcuiFaV3nn2FLb6y/8q9hNNfQloQaA7pNifjITj90
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
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 7dbfaee372c7..4e8fa5a48fcf 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -826,7 +826,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ddr_perf_remove(struct platform_device *pdev)
+static void ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
@@ -836,7 +836,6 @@ static int ddr_perf_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&pmu->pmu);
 
 	ida_free(&ddr_ida, pmu->id);
-	return 0;
 }
 
 static struct platform_driver imx_ddr_pmu_driver = {
@@ -846,7 +845,7 @@ static struct platform_driver imx_ddr_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe          = ddr_perf_probe,
-	.remove         = ddr_perf_remove,
+	.remove_new     = ddr_perf_remove,
 };
 
 module_platform_driver(imx_ddr_pmu_driver);
-- 
2.42.0


