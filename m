Return-Path: <linux-kernel+bounces-93017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87297872979
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C2C1F2237F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D412D206;
	Tue,  5 Mar 2024 21:32:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A612D1F7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674355; cv=none; b=G0OvtHwots2BQiv9r3HBoiWxJHaDEO2N9ur5GLXxEfkV/H2oPgLx4ctx7+MpqZJqIQvunYjt42k5FlsU29Qumn10H7yU/q16QvJR+rWtx5XfpzXKjA65lqSFl+0Gn7GWHveCTMsR1XtHJ5qQ62Q/bKpKP+LqMXMZFK6OLTGiPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674355; c=relaxed/simple;
	bh=0KCo74JW0R7cj4rrSXgXdNuuxSCj5INfxzKV5DEPMwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFXyZdFky7ZB0iZ9+KaMkoWUVzwK73Uf5yEH4PUNXnqv1Wqf3McgbOeLqLzQeASLA9Rf+7OezjGekwDdF5XxXHX4mqvUECAczRjbPZ2VTuHrjfSur6t7BIr+mNvxKnrYBUvSfmYRP0bnrAcIaiZXDYiIjE/dAG1Wr9/spz4swnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOf-0006re-CA; Tue, 05 Mar 2024 22:32:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-004cmN-N6; Tue, 05 Mar 2024 22:32:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-000IT5-22;
	Tue, 05 Mar 2024 22:32:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] reset: ti-sci: Convert to platform remove callback returning void
Date: Tue,  5 Mar 2024 22:32:05 +0100
Message-ID:  <ab374da386cafd6748aac5bdf66e6be3e1860509.1709674157.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709674157.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0KCo74JW0R7cj4rrSXgXdNuuxSCj5INfxzKV5DEPMwA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl549WCXF5BB4pcMzdyMRiMUfC7yDpKh2iaJHow RBlvhGCM+qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeePVgAKCRCPgPtYfRL+ TtJsCACwBOqedx5DD+BLQigiE6xZs8ztjqp5kRLf//PAGCMnfX/ObpPhFqIhvSyD3otWmb9MGFn OYMdWzA9bXwJYnwhCI7WZ39j+2/9BOdpgspbWxJqRhlC1LAuouekvnUQfwnZqppChsys1oWjFkX WOUJYgObSAkljvVJs+U5i57UHsGKnQDW5LWz3ZsNvojHh+XptjjQtxY5z9oBkS5YX5k8jOsqhp+ J15eFel536801i1Im7KsOGtGzkb26fvbHI5sv1mDUAzvaEwla+4S6+swMmQK/30/lIJmHQ/jv0u qy/WCGuCqnHYLWv6u3IAgICb1ThFIq2R7Tjh3LlImw8eAYei
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
 drivers/reset/reset-ti-sci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
index cc01fa5b0bea..d384da0982fa 100644
--- a/drivers/reset/reset-ti-sci.c
+++ b/drivers/reset/reset-ti-sci.c
@@ -235,20 +235,18 @@ static int ti_sci_reset_probe(struct platform_device *pdev)
 	return reset_controller_register(&data->rcdev);
 }
 
-static int ti_sci_reset_remove(struct platform_device *pdev)
+static void ti_sci_reset_remove(struct platform_device *pdev)
 {
 	struct ti_sci_reset_data *data = platform_get_drvdata(pdev);
 
 	reset_controller_unregister(&data->rcdev);
 
 	idr_destroy(&data->idr);
-
-	return 0;
 }
 
 static struct platform_driver ti_sci_reset_driver = {
 	.probe = ti_sci_reset_probe,
-	.remove = ti_sci_reset_remove,
+	.remove_new = ti_sci_reset_remove,
 	.driver = {
 		.name = "ti-sci-reset",
 		.of_match_table = ti_sci_reset_of_match,
-- 
2.43.0


