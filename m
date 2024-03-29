Return-Path: <linux-kernel+bounces-125441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30A8925F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946D2284B25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A24313CA94;
	Fri, 29 Mar 2024 21:12:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0B13BC2E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746728; cv=none; b=U/7pNRxkssgwqbKSUqtPkCegrRGJz22QTSyVs/v7vs0vSPUlnI0rJ+JhsLeu8gQ95I49I9cpJc2wnqWmh7uacq+xTPyqsUM5l5K7F5bbBvrmcdnVkkipwoWO7cKVkJ/xXkQxxDQG3CoKE1t2Fi6Rk02J90dVZt2/oIfzpZWMOVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746728; c=relaxed/simple;
	bh=hv4dYqlWt4P94v21pCLxlYrQxDhe3mmII1wfhthO9mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5RlueeUH502pWHA7yp6Lekrlw853tBUctK4iWd1BNV2fHH7xCPnTxpXtE72hN27DWG/KUByM/HMTuukQwXhy/D0WC9lNweTrMB5jkTx7b76jcIAv8hx2Qd1RnDfbHdwKKxqwuv0T+nx/FdUVwRl8Z49uMN8W4gPBu05nfYXMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-0001zX-Dx; Fri, 29 Mar 2024 22:11:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVy-009GFa-0f; Fri, 29 Mar 2024 22:11:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rqJVx-00DTc6-32;
	Fri, 29 Mar 2024 22:11:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] scsi: mac_scsi: Mark driver struct with __refdata to prevent section mismatch
Date: Fri, 29 Mar 2024 22:11:44 +0100
Message-ID:  <e41d10906948a980e985f6065485445d9bbbd2f7.1711746359.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
References: <cover.1711746359.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=hv4dYqlWt4P94v21pCLxlYrQxDhe3mmII1wfhthO9mE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmBy6SQtf+uF6JNIYVg7RWhEJ8ApxpMhe4bCFFK ON6mZMWQ4OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgcukgAKCRCPgPtYfRL+ TtDOB/4z467zTs9ge4dbmmquGbKz1kkfgjwfnj6G5UJcLnA91KyHgLDvNDotqQ6S22j46HQ5LK8 RiWYLZ5/2r91Ho5AR4Qk6PBGUWjpPerRTsv8OrNBwDWWkom+9RgLedRyqfB+de6mF9yIR90lgGm 63WmPhJdBtMSU+ziML3WR+zhkYtu5i7JW4W6rcH1OCD2aA4nkr5jEmGAnwELWvXi8FbVei/u2Io P7a0siHVtNBg+aTum1RU1eR+ngLe1tygANO3lCDRXQLq4oM5HWHyrAVwb95qP2uF3SNrBJ28DcN ElXuKf/p49F8DqmcuWkBwyLI1Qj5qVtJcMKf6KMZmf8FGe/g
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

As described in the added code comment, a reference to .exit.text is ok
for drivers registered via module_platform_driver_probe(). Make this
explicit to prevent the following section mismatch warning

	WARNING: modpost: drivers/scsi/mac_scsi: section mismatch in reference: mac_scsi_driver+0x8 (section: .data) -> mac_scsi_remove (section: .exit.text)

that triggers on an allmodconfig W=1 build.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/scsi/mac_scsi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 181f16899fdc..a402c4dc4645 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -534,7 +534,13 @@ static void __exit mac_scsi_remove(struct platform_device *pdev)
 	scsi_host_put(instance);
 }
 
-static struct platform_driver mac_scsi_driver = {
+/*
+ * mac_scsi_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound at
+ * runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver mac_scsi_driver __refdata = {
 	.remove_new = __exit_p(mac_scsi_remove),
 	.driver = {
 		.name	= DRV_MODULE_NAME,
-- 
2.43.0


