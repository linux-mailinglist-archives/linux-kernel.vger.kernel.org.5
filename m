Return-Path: <linux-kernel+bounces-74472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F385D4FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941B51C226B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5B3FE36;
	Wed, 21 Feb 2024 09:54:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B933FB07
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509261; cv=none; b=ClKc0hFntk9t2F51CzwOBE2+J6bhu+QLebAo81vfXKAWloHNMBb1LEsqaBC26WXOcK1B/2tEr/omjNGfQ6/xPCYBlrm7eNPjXnG0KzPaAeZC+OkmGYD2LDLbR5Em8b1GjiHzc8r0SmxneabuEO3ZUVKqveEjLDr7pT4pBbPnGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509261; c=relaxed/simple;
	bh=Z0Jdss8Z9N+X/4fQqWurmfEHx8ej0cUV7yavwKcWUYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xbt3g6geMLNhSzaCIU8/iBNpaIBMO5nh1eaSKAqqOCFzVWTquCJc3aP6eeu4GLtWpOsN2nmy75Afg8YV9dSsKU7zy6O/cvqa+GakbklGfWMggkMLOosm9VmbjB2bFiaIwI8lQIGScJpWt5mXWi6EjUI3DMM39h3dxl0wsLdFLRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIq-0007Ha-07; Wed, 21 Feb 2024 10:54:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-0020pn-JA; Wed, 21 Feb 2024 10:54:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rcjIp-008mZh-1e;
	Wed, 21 Feb 2024 10:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] misc: vcpu_stall_detector: Convert to platform remove callback returning void
Date: Wed, 21 Feb 2024 10:53:53 +0100
Message-ID:  <4b964bd133f5af11cabd51a4d8ed95025583eb93.1708508896.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Z0Jdss8Z9N+X/4fQqWurmfEHx8ej0cUV7yavwKcWUYQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl1cg1Zgtpxn81Nmf1C4B2gjhJAWay7ZKxRNAmC cIykPiy3SGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdXINQAKCRCPgPtYfRL+ Ti2oB/9djHRbvore2tsWl0WNdQ7Y9WUHziJ2s44R9yJzRFpf+POxHER8z/IyIoq0IxFaaZk6+Qi CPoopjpGUTxVeAoEeCfC1/rTyLC0A6tRdx1vn2sm5ZEYtyjd9V1dd160bDflDUWtYVa30wi9pxh YHVO8nhwZd5XMHfKBoDvEAV1gXPKvh0n6NhqterWPONvPCLJ3KsZo+3KApxpoMLIkjUe+IOeqxS 925Joz9+kVRcKPiMqXl7LKgxZiDLEbS3h2/B2z4uNjGvGkvMe/uRfRgyu2B5QD+DePFDJAFhWxO XaVodlKUvE/gLCe30VqVT2ZBCXwaSwyIx/Gqx6Vh6eLBWTop
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
 drivers/misc/vcpu_stall_detector.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index 6479c962da1a..e2015c87f03f 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -187,7 +187,7 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int vcpu_stall_detect_remove(struct platform_device *pdev)
+static void vcpu_stall_detect_remove(struct platform_device *pdev)
 {
 	int cpu;
 
@@ -195,8 +195,6 @@ static int vcpu_stall_detect_remove(struct platform_device *pdev)
 
 	for_each_possible_cpu(cpu)
 		stop_stall_detector_cpu(cpu);
-
-	return 0;
 }
 
 static const struct of_device_id vcpu_stall_detect_of_match[] = {
@@ -208,7 +206,7 @@ MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);
 
 static struct platform_driver vcpu_stall_detect_driver = {
 	.probe  = vcpu_stall_detect_probe,
-	.remove = vcpu_stall_detect_remove,
+	.remove_new = vcpu_stall_detect_remove,
 	.driver = {
 		.name           = KBUILD_MODNAME,
 		.of_match_table = vcpu_stall_detect_of_match,
-- 
2.43.0


