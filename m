Return-Path: <linux-kernel+bounces-1068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B228149EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C9B1C22643
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B139FFD;
	Fri, 15 Dec 2023 13:59:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6E036AEC
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-0002lM-3E; Fri, 15 Dec 2023 14:59:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iu-00G2ZJ-5O; Fri, 15 Dec 2023 14:59:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8it-003cC6-RU; Fri, 15 Dec 2023 14:59:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/18] perf: amlogic: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:02 +0100
Message-ID:  <33dbadf246eb323edd9e09ac744111216c167a55.1702648124.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JQzThqbYJP0QqESsItg7VkQxjf7NhjUZgsGroMmrOZc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFunAL8ycJpqtt6tJDjG+TMfdjLtm1rASeztS gl+kihZlRqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbpwAKCRCPgPtYfRL+ TohvCACm7G4Swx+T76FjE6UsHXXIG1J+cbT4v9Z3seGjq6SJJgxd/XZI+9sThyUM0hr75yQ+KpS jE0G6cKisaCLXR79HtR5VSEvyrG7PhR6WMmKdDI+pBmcfP5v3XQ69go7jN9lLOEt4oPYIU5iYbJ XunL0YeN0g0LeGgz9Gkk7FmM4LPwIyF+a2+3kHbrFww67ebezxwk5CWO6LQeMAc2NxnUJCLnW4z yZAIEt5KxjFywnR3E9IwFoq9d0jUKGig/POvSBV9AihktZICVmOoVYdMNZd0ET96RzGJUPBGs1x vrxU0Ykd14+Mfgv6oNbwZaIw96Aj6yDImRvhOCTpJyDXxOv8
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
 drivers/perf/amlogic/meson_g12_ddr_pmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/amlogic/meson_g12_ddr_pmu.c b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
index 15d52ab3276a..99cc791892bc 100644
--- a/drivers/perf/amlogic/meson_g12_ddr_pmu.c
+++ b/drivers/perf/amlogic/meson_g12_ddr_pmu.c
@@ -355,11 +355,9 @@ static int g12_ddr_pmu_probe(struct platform_device *pdev)
 	return meson_ddr_pmu_create(pdev);
 }
 
-static int g12_ddr_pmu_remove(struct platform_device *pdev)
+static void g12_ddr_pmu_remove(struct platform_device *pdev)
 {
 	meson_ddr_pmu_remove(pdev);
-
-	return 0;
 }
 
 static const struct of_device_id meson_ddr_pmu_dt_match[] = {
@@ -381,7 +379,7 @@ MODULE_DEVICE_TABLE(of, meson_ddr_pmu_dt_match);
 
 static struct platform_driver g12_ddr_pmu_driver = {
 	.probe = g12_ddr_pmu_probe,
-	.remove = g12_ddr_pmu_remove,
+	.remove_new = g12_ddr_pmu_remove,
 
 	.driver = {
 		.name = "meson-g12-ddr-pmu",
-- 
2.42.0


