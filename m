Return-Path: <linux-kernel+bounces-2635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22133815FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C91285343
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C8A46BB1;
	Sun, 17 Dec 2023 14:30:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E42045957
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9e-0006VL-T4; Sun, 17 Dec 2023 15:30:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9c-00GUhA-95; Sun, 17 Dec 2023 15:30:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rEs9b-004hyw-W6; Sun, 17 Dec 2023 15:30:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/15] memory: brcmstb_memc: Convert to platform remove callback returning void
Date: Sun, 17 Dec 2023 15:29:28 +0100
Message-ID:  <e4f3c86270161ce231cd0e4f3be9c632578e17a2.1702822744.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=SpMi1wg6uau+YqEvL4zWCt8cnKaO+rNdF1rNrAv67zI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfwXHmWa9sJ09D5q7RteC6J2eSV0osYkFrjnhH GFnMTS5CiKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZX8FxwAKCRCPgPtYfRL+ Tv08B/9jWNWVJdwg3eqyaHMspo0t4LNc4AS+YH6ZaFbvzn9MbVijqfopM3kx8fgJ91XdeKYJORL LWTgeid/MeA++pW7lAKZZtW+GHuRnndT8NgbXy2NyM8se82jcfVKSFGRDiom/MEqvPQPeTmNzqp j7SvQ0Igl8YTs0dWfgpfwe+xT1vFFp6Bkx3qfRdZXbT0pBAeTNhpHuzJNwDLo6xhKL3A3qZ548v go+HQS7OwjXD/22sZvYqQd8Qk9SQf+d22Atn3maaigOFc/shB+x0EE3Ez2J1jGC6MwfSCKiOP6o w28Sfrrobm7lWlTnMgH++7AwU+o+p4YZojmCgkVxFaxhsZ5s
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
 drivers/memory/brcmstb_memc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index a6ea51996522..ea9213f7152e 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -152,13 +152,11 @@ static int brcmstb_memc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int brcmstb_memc_remove(struct platform_device *pdev)
+static void brcmstb_memc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
 	sysfs_remove_group(&dev->kobj, &dev_attr_group);
-
-	return 0;
 }
 
 enum brcmstb_memc_hwtype {
@@ -284,7 +282,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_memc_pm_ops, brcmstb_memc_suspend,
 
 static struct platform_driver brcmstb_memc_driver = {
 	.probe = brcmstb_memc_probe,
-	.remove = brcmstb_memc_remove,
+	.remove_new = brcmstb_memc_remove,
 	.driver = {
 		.name		= "brcmstb_memc",
 		.of_match_table	= brcmstb_memc_of_match,
-- 
2.42.0


