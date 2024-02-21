Return-Path: <linux-kernel+bounces-74477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816385D501
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63471C21B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C945BFE;
	Wed, 21 Feb 2024 09:54:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2F41C7C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509265; cv=none; b=e135Gd7V/BMzRqWlz9EQiMmS5L9jleMHktRf2/CU/l6qrzEC28bDnU2zQR2OmL7EU2xmYgyWrvkpLvN73Udb5yRw+QIVhsjWbIKUBxHV7dWJ+F+FCNU98C5OIzA6rPcwP/vVD720GC5KRKXy9w7h6hLfMoSisYPK5S/WiMvdXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509265; c=relaxed/simple;
	bh=aE2QGkb/6v1mhMB4aBC3dwinRin5nmjBq8EsbULi2eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkEDkEytATl9fu6GUIV5EOrz6desSteO/XTUFf5+hVI7RgH1dyxMJtChUXuSYNfnVPSfx1kHxnjWLKMUuAck/7mWwmmVnvrhE3z4vc0JYLV7I6Hz2kbvYFEKGacEBsHkkaFHXCIn+M/fTgS+xmleQfsbvt+hUIH7zwOiVZqHbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0007HE-Sj; Wed, 21 Feb 2024 10:54:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020pk-Eo; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZd-1D;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] misc: ti-st: st_kim: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:52 +0100
Message-ID:  <250337c967bdb5019a3c9fe8e0d082cd65400227.1708508896.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1888; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aE2QGkb/6v1mhMB4aBC3dwinRin5nmjBq8EsbULi2eA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cg0VyGHhH5aEiLrau5zEWJKmdo3VSy8JU2JK /8AmoaGesyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXINAAKCRCPgPtYfRL+ Tg+wCACJqAUmJJeiHN3VJX89/LpaNfHZTU8DqYeEtV3tbDV6DLtnLj48kNZ7B+nBdyV4RNBSIgx QlPp9RmR0sIcwSMXIQ/9IrRyyi+a3dpiXCCxEVNgyrkVBIDleBvOmH8/porxH5w4lqt9eZksOAF o/Tq4+suHDB0R3ix88Sg7/NJXcTVZ3msKth4JcyftBSTtKS0LzUnFzLEmj7KFPMB6vQb8gwPS/9 XQ0y7Cts8mGL1SfsQran2oGCQEtmdDn2EEWXKg5xQWtGyCQUbk0vNDUMIZCp0HSL+F3WC9zxgyS FJoui8e5Rsf+yB736dRJCNsHQ+iuXLbO0yWdKyJhBdhaDZUq
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
 drivers/misc/ti-st/st_kim.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index 4b1be0bb6ac0..47ebe80bf849 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -774,7 +774,7 @@ static int kim_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int kim_remove(struct platform_device *pdev)
+static void kim_remove(struct platform_device *pdev)
 {
 	/* free the GPIOs requested */
 	struct ti_st_plat_data	*pdata = pdev->dev.platform_data;
@@ -798,7 +798,6 @@ static int kim_remove(struct platform_device *pdev)
 
 	kfree(kim_gdata);
 	kim_gdata = NULL;
-	return 0;
 }
 
 static int kim_suspend(struct platform_device *pdev, pm_message_t state)
@@ -825,7 +824,7 @@ static int kim_resume(struct platform_device *pdev)
 /* entry point for ST KIM module, called in from ST Core */
 static struct platform_driver kim_platform_driver = {
 	.probe = kim_probe,
-	.remove = kim_remove,
+	.remove_new = kim_remove,
 	.suspend = kim_suspend,
 	.resume = kim_resume,
 	.driver = {
-- 
2.43.0


