Return-Path: <linux-kernel+bounces-138059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FA89EBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EBD2857C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A513C9D1;
	Wed, 10 Apr 2024 07:17:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2413C90E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733448; cv=none; b=QkyLUAYiUqrK8gcBrGIlJqb7UrWpfjkgAy3NpMN7zq2My9MuXcTNWFW931w2t5srKLhOsWCqpKmxa1+f5+Oc8VHr9azyUb1SYMHwr3uDVkpmTUfOtn8nDRvefrQy2MerHhJTPCkdeCWjjSDTOrLynWjrS4WYuunFveop2b7cCtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733448; c=relaxed/simple;
	bh=FZYfk1Hsrzp0URGjsfoL+rqF8k33Q3nofmMMSYezWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdmImO2Eo8ZF+swSnoF/479kkAV58hmLkwaFZZXxKvLWMvPskgErX9gV40fJX9W/iVybDGnKYNZsuIXvBwkKHuN4sGaMrp3hWjvJ4piRnArA7pyWNG/TIKL8jARLMgCYhI5QszJZ4k3w+y0orjY1trma/rY7Dg4kpFaHMMTGeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCk-0007Oj-C6; Wed, 10 Apr 2024 09:17:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCj-00BRwT-7Y; Wed, 10 Apr 2024 09:17:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSCj-00HPjZ-0U;
	Wed, 10 Apr 2024 09:17:09 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/3] x86: platform: olpc-xo1-sci: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:16:53 +0200
Message-ID:  <63c9d1e6b07296916e4218c63f59a2dd6c6b6b16.1712732665.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FZYfk1Hsrzp0URGjsfoL+rqF8k33Q3nofmMMSYezWc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFjzmBZipNnJs1KOoDFs1Ui6idlkVW0oaQ5ejN LjqhwiJQm+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhY85gAKCRCPgPtYfRL+ Thx+CACoBIAz2XK8MeCgcQupEQyzzkIh3vv1iYpKPXGj4XUxOcADxnxfvdK5QG/EKd+QM63Ex/H jjTMLkim/Pf47SCVHGfnhnlM+nL0rKsgOu5YqbBkE+5Oy5UJs7R3x8xmH9HWsmXcefCqLMEG08u M65rlCKaqqsxlAdZBmilR6j3ITOHIJsH9bsUUZada4gVx0IKIta2FXRB7Mb7jkczzDBzLQU6ARK foMKV/a2A+JxZWbd4hkSwaw8EUc7krGxygOBJZSj1h6pZDsJC0CejY29ZzBL9ahUf78a1FyxidP sU8JnTlQ9/KwvDCwWSDU89SzSJrO2AEOb97bKbPzYGiRI2H9
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
 arch/x86/platform/olpc/olpc-xo1-sci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 89f25af4b3c3..46d42ff6e18a 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -598,7 +598,7 @@ static int xo1_sci_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int xo1_sci_remove(struct platform_device *pdev)
+static void xo1_sci_remove(struct platform_device *pdev)
 {
 	free_irq(sci_irq, pdev);
 	cancel_work_sync(&sci_work);
@@ -608,7 +608,6 @@ static int xo1_sci_remove(struct platform_device *pdev)
 	free_ebook_switch();
 	free_power_button();
 	acpi_base = 0;
-	return 0;
 }
 
 static struct platform_driver xo1_sci_driver = {
@@ -617,7 +616,7 @@ static struct platform_driver xo1_sci_driver = {
 		.dev_groups = lid_groups,
 	},
 	.probe = xo1_sci_probe,
-	.remove = xo1_sci_remove,
+	.remove_new = xo1_sci_remove,
 	.suspend = xo1_sci_suspend,
 	.resume = xo1_sci_resume,
 };
-- 
2.43.0


