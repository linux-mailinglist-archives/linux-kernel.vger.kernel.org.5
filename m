Return-Path: <linux-kernel+bounces-93016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0509872978
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4812899A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C312D1EF;
	Tue,  5 Mar 2024 21:32:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C842312CD85
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674353; cv=none; b=aUwX74LRlx5cM9TN4YwcK/LHJAC/TmCkvW/cmlLvq2vUouTxmmIvf5Bi10VgvvjYqyrpqi5jS9SsC0EiQPo7vxyd1Jl5amCkvuIqTrEn1xVzhuIh3mnpvRp3w85nCUb6eBycN01g+ogrP54AKTy1YRwu6mzqIjVeZy51iAIoULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674353; c=relaxed/simple;
	bh=ax4ocmWgdyR2S0Rp27gdwmhqKLnCwEq0x6qra/psAgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4RXpzHTzyN2sdabwYom4QLy0JZ5DWn66qPrRG1bIElEuA2TNpVd6fuqBzdlw0yc9W+zec+ZGXpA6Dv/kWGE7a9+9GS40N85kC8kgHq4xTptkK2sFBfk4tgJEKUGVgak0+TmCEqVRaIPsaWCtNjA0FHAC7Ri2BgC67fHgAHXdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-0006r5-NY; Tue, 05 Mar 2024 22:32:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-004cmH-8i; Tue, 05 Mar 2024 22:32:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhcOe-000ISx-0a;
	Tue, 05 Mar 2024 22:32:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] reset: meson-audio-arb: Convert to platform remove callback returning void
Date: Tue,  5 Mar 2024 22:32:03 +0100
Message-ID:  <dbca07bad345abe7ca421515004987acf1cb41c2.1709674157.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ax4ocmWgdyR2S0Rp27gdwmhqKLnCwEq0x6qra/psAgE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtTn/SExj8u8VgcX69yuiG7acTjXfv7ha9/s2ly/BNrt+ ayv57+uk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJrHjHwbDzZGJ1H4fz3tww 07/p8iaGmksUnohsDZULuv8sXqmF/02k+4x9/mI3VBLbDxTczjiQnDpl+rJd34RWshfrHJT9Et9 ftKEnVL00+bBXY5n9qzam3nVaxo1MRSlLb1tI7++7ERSjyMZf+a5Y/ue8qRY7J941mbQ6c53e/r n5FjeaWt+zPN8yfZJRfvVZpe9/chVaOmdv9xcXfrrr2yePJ0yz3of88qiZ7Hz2T4pf7cLKXbJSf 1Y5HJzvHnOI56P/u+To1PT3qg8u7b2lX+x86yOX+mTu10K6SkLHHttGOtgH6ogrXxDLnLOJmbPR 6I+O8HFuji4D83wnw9umGyqkPIJDS9SvMhpv+FvsPakMAA==
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
 drivers/reset/reset-meson-audio-arb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 7891d52fa899..8740f5f6abf8 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -120,7 +120,7 @@ static const struct of_device_id meson_audio_arb_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
 
-static int meson_audio_arb_remove(struct platform_device *pdev)
+static void meson_audio_arb_remove(struct platform_device *pdev)
 {
 	struct meson_audio_arb_data *arb = platform_get_drvdata(pdev);
 
@@ -130,8 +130,6 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
 	spin_unlock(&arb->lock);
 
 	clk_disable_unprepare(arb->clk);
-
-	return 0;
 }
 
 static int meson_audio_arb_probe(struct platform_device *pdev)
@@ -189,7 +187,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 
 static struct platform_driver meson_audio_arb_pdrv = {
 	.probe = meson_audio_arb_probe,
-	.remove = meson_audio_arb_remove,
+	.remove_new = meson_audio_arb_remove,
 	.driver = {
 		.name = "meson-audio-arb-reset",
 		.of_match_table = meson_audio_arb_of_match,
-- 
2.43.0


