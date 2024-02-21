Return-Path: <linux-kernel+bounces-74478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B385D502
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBA11C232F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7146557;
	Wed, 21 Feb 2024 09:54:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529E45953
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509266; cv=none; b=AQ7jhWJl2rAQa7VYxM+hl5stUhuQ+t64m8Ts7IVEebj8ZLQ704/mOfFad/ZZlUxz0fGWhnVZsu+rtxiwXbbzw6hEhT1SmH6m3xXJABiPquDRd5fo2+goCIHHt5pKJ5LfxwcGEUCedhYkTfIu9lfMXYqeZhEb7ZGK6BXbiKvK7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509266; c=relaxed/simple;
	bh=aVX7CawhH3qa0cDrgvRo+u3JaL3iPMKiw1wYFuGdRaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBjCzgvqF499pdlfM6I3PL349qz1Fjg82Z4bEo/1RXxvMV09KqlZkQHl1Hotwz/9bWbilcq/BsKNa+mTKZuipgL9MCdUJnDrfcykleYDNYI9CDWzYSKqrvrWPGNlLDPXzPQ0ZV703nCCbbu+ohUhtw7m9Md8jcVfIok6tyVpthw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIq-0007Ik-Ec; Wed, 21 Feb 2024 10:54:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020pw-TW; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZp-2h;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] misc: xilinx_tmr_inject: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:55 +0100
Message-ID:  <198112757eac0fc004677a4757ce48ae7c7194ab.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aVX7CawhH3qa0cDrgvRo+u3JaL3iPMKiw1wYFuGdRaA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cg3i12P3AFF5hN9xxxKjObFB8Opb/S6JiL7Y QyrNxpImmuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXINwAKCRCPgPtYfRL+ TkIDB/40DS+jNpK7mW/zj5sYEayFRQSSPz+4UZyoeR+sn9fVwBQa7GRLchbqI+O0PU72agCU/sa ifrDHoMM3ErDbjQ4wP5m3ABLfT96BtYkAtvMdSCi3k/TuVIKWklzZF4jvnv4IZ23xO1wih3Ibcn 55Rt3k928CsxAY1O3rwc8ajXJ3juNX/zQ/M6iQg2vkLPKaNa62+9abmBwiayzX5XmAk0F8z/sPy 3sHR2OjHxZNP3ia5S664f/Z5qBBtz8dVEMHGTj0HRN7toPOKK9z2YhQfoqT+CeQvQvc2wy4k1D6 /rBQuL7EvJ3qe5zU2KbqjGVu1YPvHG6Q5fLYQC22gi2Q8a9u
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
 drivers/misc/xilinx_tmr_inject.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
index 9fc5835bfebc..73c6da7d0963 100644
--- a/drivers/misc/xilinx_tmr_inject.c
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -143,11 +143,10 @@ static int xtmr_inject_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int xtmr_inject_remove(struct platform_device *pdev)
+static void xtmr_inject_remove(struct platform_device *pdev)
 {
 	debugfs_remove_recursive(dbgfs_root);
 	dbgfs_root = NULL;
-	return 0;
 }
 
 static const struct of_device_id xtmr_inject_of_match[] = {
@@ -164,7 +163,7 @@ static struct platform_driver xtmr_inject_driver = {
 		.of_match_table = xtmr_inject_of_match,
 	},
 	.probe = xtmr_inject_probe,
-	.remove = xtmr_inject_remove,
+	.remove_new = xtmr_inject_remove,
 };
 module_platform_driver(xtmr_inject_driver);
 MODULE_AUTHOR("Advanced Micro Devices, Inc");
-- 
2.43.0


