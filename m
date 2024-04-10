Return-Path: <linux-kernel+bounces-138062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2454589EBAB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3546285B11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429413D25B;
	Wed, 10 Apr 2024 07:17:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18913C919
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733450; cv=none; b=im2LN2lcy1yhqO3Dy8nLbJo04BGkTV9/51hYC8D+APxfuXDOW85QdJIQizwUt96mUclH8KoGJUFnvRNf/FxgdvhLqmCy13gVI+x6BXbYpuBu6nK2t/l8pVJxdPTJQLoouiOdOP2b8Hfxw1QgiiRjYWgt8Q6ClvM4D7c3rVi+qHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733450; c=relaxed/simple;
	bh=xjGSy5q5TlMsAw/77BdDo4FYmGhQLPPWsYgO5Uu+b4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NI0QP/wUiG9V29Icjr2rBnvGJyHeDq2N8N/mmC2uXQS16dslAZEJLhTEMEiTcVi7lLAPtMSGM6s9jtqGVIc/GZQYdaIvBUEe/vv9uZM2AJfK5gv7mVzL1D3klUF8iA+lyP6yX5d49YMwP1tidlusTWjFYACbImmvGz4K/XZygEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCk-0007Oi-C6; Wed, 10 Apr 2024 09:17:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCj-00BRwQ-25; Wed, 10 Apr 2024 09:17:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCi-00HPjV-3A;
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
Subject: [PATCH 2/3] x86: platform: olpc-x01-pm: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:16:52 +0200
Message-ID:  <c7d669d8b0c994c77fb4c3bc7bec78aeb8659c74.1712732665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xjGSy5q5TlMsAw/77BdDo4FYmGhQLPPWsYgO5Uu+b4I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFjzlRHNFNl8BBJRELTBYoYJ5tCmyJb6vKFGLk drInaCCh0GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhY85QAKCRCPgPtYfRL+ Tue8CACeindFgQ3nJcnLoI8VB+H0oqYlk/qfdkSqXoliq4QbpWcpJ4+hdteAYcPj407aQk5z4GD 9t6LWltmahWiqteCBthP98xNUfdLedlg3+bb89h95oIXdQo+nDYf1ct0RB4ohwpgPH8J0/iNMJl ZW3KnSsusz4jPfAe4GMlZRKIV3Fyht9HOtExRqe519oaAQ2poVI18k9ZLVeuvdZPjgq9pja/HYQ op7XJ4wHOrmgeLVTZV+uvNnSUrw6WxrwES1OSLVOmv3QUKgKcYEfSzSTBFJ2eu+U7OKHUzHkHci cfDKAMkzIE+Lk9xKnOjmWFifZ9O+X1Gti/LDdodZY/AEpOyV
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
 arch/x86/platform/olpc/olpc-xo1-pm.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-pm.c b/arch/x86/platform/olpc/olpc-xo1-pm.c
index f067ac780ba7..6a9c42de74e7 100644
--- a/arch/x86/platform/olpc/olpc-xo1-pm.c
+++ b/arch/x86/platform/olpc/olpc-xo1-pm.c
@@ -144,7 +144,7 @@ static int xo1_pm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xo1_pm_remove(struct platform_device *pdev)
+static void xo1_pm_remove(struct platform_device *pdev)
 {
 	if (strcmp(pdev->name, "cs5535-pms") == 0)
 		pms_base = 0;
@@ -152,7 +152,6 @@ static int xo1_pm_remove(struct platform_device *pdev)
 		acpi_base = 0;
 
 	pm_power_off = NULL;
-	return 0;
 }
 
 static struct platform_driver cs5535_pms_driver = {
@@ -160,7 +159,7 @@ static struct platform_driver cs5535_pms_driver = {
 		.name = "cs5535-pms",
 	},
 	.probe = xo1_pm_probe,
-	.remove = xo1_pm_remove,
+	.remove_new = xo1_pm_remove,
 };
 
 static struct platform_driver cs5535_acpi_driver = {
@@ -168,7 +167,7 @@ static struct platform_driver cs5535_acpi_driver = {
 		.name = "olpc-xo1-pm-acpi",
 	},
 	.probe = xo1_pm_probe,
-	.remove = xo1_pm_remove,
+	.remove_new = xo1_pm_remove,
 };
 
 static int __init xo1_pm_init(void)
-- 
2.43.0


