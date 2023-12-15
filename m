Return-Path: <linux-kernel+bounces-1069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC68149EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35F6B23190
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6802D3C46B;
	Fri, 15 Dec 2023 13:59:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C285039FF1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-0002qG-KU; Fri, 15 Dec 2023 14:59:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iz-00G2aE-5u; Fri, 15 Dec 2023 14:59:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rE8iy-003cD5-SO; Fri, 15 Dec 2023 14:59:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] perf: qcom_l2: Convert to platform remove callback returning void
Date: Fri, 15 Dec 2023 14:59:16 +0100
Message-ID:  <a2587688c54834482d68fe2a44f415a649ad6477.1702648125.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VICxICa9rzVcpxd4YQzS3q7MnqlVMsOIGitfxpEhihs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlfFu3p7ogtYGPBuZCsFnYFvOZg9wLXH6J7bohW JxjI9JrbLSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXxbtwAKCRCPgPtYfRL+ ThOdB/4mmPoWmDYG5uyMcSwzK1WP92WjeDvUiQQBHkp31CnYoCZDmYf3AJ1RZgzA71ftT89NP2i J+cLLxvsIKrjQ3U3i0G19YYMR1Tglb6sueG4oEkAqW70R7o6o2/itPnTZ9Q2R+Wq8Q7ekDdxYxq BlW1X0FE2Izyor49KMINVvrLnQCBfeKqsVBvnYBuOjX2muGy9hthfxsi0aSuNDLaXcGFwf20U8i OKcHR08eDXQNS1ZDJIe9ol6PJaN9B5cQIq+nwg8Ao6rAHqjRzJjvUVKUZs8U652FRvkQUIs1vy+ I9Z5fboAp0nA9MFJcfavCbIjfX49SP1CiF6xwTbJN6LALack
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
 drivers/perf/qcom_l2_pmu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 3f9a98c17a89..148df5ae8ef8 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -965,7 +965,7 @@ static int l2_cache_pmu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int l2_cache_pmu_remove(struct platform_device *pdev)
+static void l2_cache_pmu_remove(struct platform_device *pdev)
 {
 	struct l2cache_pmu *l2cache_pmu =
 		to_l2cache_pmu(platform_get_drvdata(pdev));
@@ -973,7 +973,6 @@ static int l2_cache_pmu_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&l2cache_pmu->pmu);
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
 				    &l2cache_pmu->node);
-	return 0;
 }
 
 static struct platform_driver l2_cache_pmu_driver = {
@@ -983,7 +982,7 @@ static struct platform_driver l2_cache_pmu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe = l2_cache_pmu_probe,
-	.remove = l2_cache_pmu_remove,
+	.remove_new = l2_cache_pmu_remove,
 };
 
 static int __init register_l2_cache_pmu_driver(void)
-- 
2.42.0


