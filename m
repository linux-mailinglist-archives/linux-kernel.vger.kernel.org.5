Return-Path: <linux-kernel+bounces-12135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D081F06A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551A5B228EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBE495CF;
	Wed, 27 Dec 2023 16:27:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4848CDB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWk9-00059p-P6; Wed, 27 Dec 2023 17:26:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjx-001tZT-E1; Wed, 27 Dec 2023 17:26:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rIWjy-001Wmt-1O;
	Wed, 27 Dec 2023 17:26:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Thierry Reding <treding@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Hao Ge <gehao@kylinos.cn>,
	Rob Herring <robh@kernel.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] firmware: imx-dsp: Convert to platform remove callback returning void
Date: Wed, 27 Dec 2023 17:26:28 +0100
Message-ID:  <f4cc1ffe30b837d5eab96f2924f51999dfa9f671.1703693980.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1797; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MlqBx3QsOKLYhj8m2E2EGfokVOl5XV7UkQvCbxh8Dg8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBljFA2JBjZjJ80khzwObhQcArQ5cwJEx64zJY36 CtxgF7WSbyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYxQNgAKCRCPgPtYfRL+ TgByB/4kZis+maU+iwmZbE6Rj8EHJS/0bW1FPBZc3bFsDVcvmuiiduDOw8HVY6Kgtd8olF/jklr 6e9JAlfeFGPqi/HNkDXO/x9MCxCRjZHCuLL6Yo/9b481c7rDhEb4Z+n5je2qNU8zg32CqxA3jD/ PyMHg0Jh8UZuCTwsvgjzWG+Wuxy5trk2jF2zNQVlX1AGixbNOM7nGCCp6al65O2s0YOgY6ohRj2 tJ/IS4IYapHTbktUPR4bQ2a1/w8MhOOdkgrDxdchBkauQgNtbqT9gcb+Xp2Ec8ltF8pM6DnycHt /ySIHanZz7kGgxGI/agQ1ot69EXC5J/A09VnL8E8rtstvwbS
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
 drivers/firmware/imx/imx-dsp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a48a58e0c61f..01c8ef14eaec 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -160,7 +160,7 @@ static int imx_dsp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_dsp_remove(struct platform_device *pdev)
+static void imx_dsp_remove(struct platform_device *pdev)
 {
 	struct imx_dsp_chan *dsp_chan;
 	struct imx_dsp_ipc *dsp_ipc;
@@ -173,8 +173,6 @@ static int imx_dsp_remove(struct platform_device *pdev)
 		mbox_free_channel(dsp_chan->ch);
 		kfree(dsp_chan->name);
 	}
-
-	return 0;
 }
 
 static struct platform_driver imx_dsp_driver = {
@@ -182,7 +180,7 @@ static struct platform_driver imx_dsp_driver = {
 		.name = "imx-dsp",
 	},
 	.probe = imx_dsp_probe,
-	.remove = imx_dsp_remove,
+	.remove_new = imx_dsp_remove,
 };
 builtin_platform_driver(imx_dsp_driver);
 
-- 
2.43.0


