Return-Path: <linux-kernel+bounces-1065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5D8149E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334771C223D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C44336B17;
	Fri, 15 Dec 2023 13:59:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BF34CEF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iw-0002lt-07; Fri, 15 Dec 2023 14:59:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-00G2ZZ-GT; Fri, 15 Dec 2023 14:59:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iv-003cCM-6y; Fri, 15 Dec 2023 14:59:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/18] perf: arm_cspmu: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:06 +0100
Message-ID:  <9ff5a467569dd51b2fc44e11594ad5db7ea15f57.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=iD85+6TB8xZ09uwwdBXf03XK6NMXrN2+ozmtzMTXttY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFur3mWCsTZ86/mocSQ45ul+pTIzr/UQuUm4F y0mpEKykPeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbqwAKCRCPgPtYfRL+ Tq6oCACP7hKGGnlzlmcvQgf4nkNUaeLKlAPgMCQdyZ0osuj2C2NgpL1+vFuAF49i+xnFDzSWHx5 cFIdv+uqL1DQYFS7IQtjXivdUirncexZl8ICb771sPGL04cEHuD64Wu9Rz+bvVMGvQubWywHjE7 C9OxuDIJTeRKBJAFuQU1tVOIZwGhkKqlsI8pDPaXkhuTxQ/I2l4hsYw0ylM4v2ZvSc+aKAxHocl aPeWW8BWq4toRCOGsN3lrJFEOKy4Li4C1BZIt/hqmjN/NPc3c3ldakJjkp908CbIiHeL4lBIHEF a0PIaknWlp/z9xDdH9nCXSHGXfh9Mlof++TiXd6u7WC28sR+
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
 drivers/perf/arm_cspmu/arm_cspmu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 50b89b989ce7..3513bf50fefa 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1252,14 +1252,12 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int arm_cspmu_device_remove(struct platform_device *pdev)
+static void arm_cspmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_cspmu *cspmu = platform_get_drvdata(pdev);
 
 	perf_pmu_unregister(&cspmu->pmu);
 	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
-
-	return 0;
 }
 
 static const struct platform_device_id arm_cspmu_id[] = {
@@ -1274,7 +1272,7 @@ static struct platform_driver arm_cspmu_driver = {
 			.suppress_bind_attrs = true,
 		},
 	.probe = arm_cspmu_device_probe,
-	.remove = arm_cspmu_device_remove,
+	.remove_new = arm_cspmu_device_remove,
 	.id_table = arm_cspmu_id,
 };
 
-- 
2.42.0


