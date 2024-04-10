Return-Path: <linux-kernel+bounces-138061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F1189EBAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4D61C21771
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9B13CFA2;
	Wed, 10 Apr 2024 07:17:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9613C916
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733449; cv=none; b=mJuH3tgQe7D00qow7aW5P/LOe1D1N3Q/DdTjiu4ONC4gLCUI5dx0DRvIjHJKwY7iqf1SiO+V2TWSbK8YKggS4CNHzDqhbbpIOM7q5q+GucGpUdVII1opcdTCYL6n3dXrlKXDv5HEgxplpnwWsgUdNTjkl7qm4/Zkoa/zF0YwPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733449; c=relaxed/simple;
	bh=7M6GxdU+Qx1cq5JsMTSSXBCuCLJoumFg+NqADPAkAGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dW/cV5e1ontJ8kFPOENJihGoJugYj7bj/PhxnApRJvgNYSJa+G2wsw1IvHzna4Zcz7raGLcc8kvBf+VenGPRcThejxHfdr5L489vHS2JUdur5Kx8LC64uC7Zag2anpHuzm/NTzDEBMNj26VwLZWlo9qtAnHye3RZhozhjjTbYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCk-0007Oh-C6; Wed, 10 Apr 2024 09:17:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCi-00BRwN-Sz; Wed, 10 Apr 2024 09:17:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCi-00HPjQ-2d;
	Wed, 10 Apr 2024 09:17:08 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] x86: platform: iris: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:16:51 +0200
Message-ID:  <adb9b0aca77d7aa8e54d0a664a4ee290834a60a1.1712732665.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712732665.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712732665.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1671; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7M6GxdU+Qx1cq5JsMTSSXBCuCLJoumFg+NqADPAkAGE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFjzk8WXIlzsfdIcgLQ98mfT2M+ZRFfylvLnGB WqznffqRBmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhY85AAKCRCPgPtYfRL+ TgrcB/95SwnDVkR6RLvGR9moOyosr/g6ZgoWP9EJxktRfkz9e4W2sd6hs/KXyZ5F+PABc034bmn 4G1r+unIG3Sxcs5zcxboZDyh3nDDzob1gj899YovU06z36uUZ14LWXhC6jxgqbaGm+GxTRmaKzd 08MO2NkSuswLMBxg4d1orDe5lisrhYx64Iu8sIlSWVXexoouNZ4g/IFsf4+zOroqgPomysQBlwf +ncjXcb/1XKkPbJ44sUI1qU2UOFBZL0u65U4+TEXAvGNawpMsVvTE4HKysnK4inQROJa5bHP0TA 9hNfsgH1dQg3HJw9bDBXkR8Mi9g1b4ObRDIClBkTo0TD3q/X
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
 arch/x86/platform/iris/iris.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/iris/iris.c b/arch/x86/platform/iris/iris.c
index b42bfdab01a9..c5f3bbdbdcfe 100644
--- a/arch/x86/platform/iris/iris.c
+++ b/arch/x86/platform/iris/iris.c
@@ -62,11 +62,10 @@ static int iris_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int iris_remove(struct platform_device *pdev)
+static void iris_remove(struct platform_device *pdev)
 {
 	pm_power_off = old_pm_power_off;
 	printk(KERN_INFO "Iris power_off handler uninstalled.\n");
-	return 0;
 }
 
 static struct platform_driver iris_driver = {
@@ -74,7 +73,7 @@ static struct platform_driver iris_driver = {
 		.name   = "iris",
 	},
 	.probe          = iris_probe,
-	.remove         = iris_remove,
+	.remove_new     = iris_remove,
 };
 
 static struct resource iris_resources[] = {
-- 
2.43.0


