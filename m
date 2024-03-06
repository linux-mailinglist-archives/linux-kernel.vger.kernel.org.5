Return-Path: <linux-kernel+bounces-94352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAED873DD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19B77B2127D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5AA13C9D6;
	Wed,  6 Mar 2024 17:57:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBC136987
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747839; cv=none; b=umJGEK2M5RLLprtfyOBzK/5iAe84FtBaSbJuNFifJzAWKJpcEJGZsjfCHfuQqy3RNwOLUhEwcPsbJCyccoGzJmeiG/4MibfmdQwTGcTlmySAG6qEtDBb7HwyiNybuIL2ATr1Jr+Q14Qm5Y70D0D0x37B6EslImD2V5079MkB7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747839; c=relaxed/simple;
	bh=kkX6BTdc1ryQj7fgIQCDJyq35Q1Vik6KHEiij+hMoRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uNGsCGqXc0r/gsqWVcDW3Ij/uVlKUxj5f40BxRshkB9fqlAcGGAZdl7y/YjXkfNrn52W2nEag1pZvJHyoZdfwBoWV5hwWjbTvjJ4k2teD2tZau6KmbGgfyGObwmsq/sjARz+caMujJZHnzremvqq/RrYmXLaNsINRa6BtqR2/mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvVy-0008Su-FF; Wed, 06 Mar 2024 18:57:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvVx-004n7L-Nr; Wed, 06 Mar 2024 18:57:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhvVx-000o8H-26;
	Wed, 06 Mar 2024 18:57:13 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Eli Billauer <eli.billauer@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] char: xillybus: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 18:57:10 +0100
Message-ID: <20240306175710.82569-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kkX6BTdc1ryQj7fgIQCDJyq35Q1Vik6KHEiij+hMoRA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6K52KsrpqyyuBjasHigGxdGVbTw4gEXGTfWF3 mqydt/1GAiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeiudgAKCRCPgPtYfRL+ Tj6WCACN4YneiHGbSn6AOXZbwnOMLiBXY3Ix2iB0dJQrdSTsnqLkI5cMALtj9qHAAy71z9XyrYY 1fK9e2IUH/roiBS8hb52l7DPEgqbH5IYiLZkEA4hKzXVdtFJMKB25qMUTPeIkEuZiGwR5TyLRVB nxs0Uq8vD0512N2XUfTQciJmI/qS+wY4g/4k03nID78O2TGKQZKVSk6IvwlZrz1fQYbWDnXlRTC +p7O9Vbod/jPqSZDmAVvKxDmU0wul/+z6JlO92iMrEWJZxVCKNzcOiNtt8MTOU7dbs6jb9/Bo3u zjL9cnJn7GqldDvhl7nq6f/gYOEForyUxBsdM5qlUAOAJ6/1
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
 drivers/char/xillybus/xillybus_of.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_of.c b/drivers/char/xillybus/xillybus_of.c
index e5372e45d211..8802e2a6fd20 100644
--- a/drivers/char/xillybus/xillybus_of.c
+++ b/drivers/char/xillybus/xillybus_of.c
@@ -64,19 +64,17 @@ static int xilly_drv_probe(struct platform_device *op)
 	return xillybus_endpoint_discovery(endpoint);
 }
 
-static int xilly_drv_remove(struct platform_device *op)
+static void xilly_drv_remove(struct platform_device *op)
 {
 	struct device *dev = &op->dev;
 	struct xilly_endpoint *endpoint = dev_get_drvdata(dev);
 
 	xillybus_endpoint_remove(endpoint);
-
-	return 0;
 }
 
 static struct platform_driver xillybus_platform_driver = {
 	.probe = xilly_drv_probe,
-	.remove = xilly_drv_remove,
+	.remove_new = xilly_drv_remove,
 	.driver = {
 		.name = xillyname,
 		.of_match_table = xillybus_of_match,

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0


