Return-Path: <linux-kernel+bounces-33916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D749383702D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76FB41F2A40A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D5604BE;
	Mon, 22 Jan 2024 18:08:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BBB5FF05
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946905; cv=none; b=ChYA/v9j6rc6TmikYdyZAMm2WX+YP+zbj0yUlVcIuewoo6ao8jwSV8BAgwrcj0E6N5gjAHFto1PS3kCDgX5Nu/7qp2lncUWYA4SDT/Qcd+Aachjw5cGfkuQbYdWO8GobYML8HBIAC2Ri8uCj2XsO7DqB4Aj3Pe60t8CEgcPpT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946905; c=relaxed/simple;
	bh=/Yg1W2WDH9FF1Tn6OXe421fMQlr47i+9fDzZFse2hhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWMI1r78YUXGJwwpv98VR8tm546klU6lmc+8h1CY0Oucaq6BGlXQhZP36va02BBccc5+kYpy6S9ld8yhgFb/uUQ8WitOn0ahjd58/IYdnCXrAEw4HpQ/nTzcZq99iJeKb7jgTv50BTdDOFoaLk9UGntm7T/xvOYnikREFOpmmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-0001wr-Mk; Mon, 22 Jan 2024 19:08:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-001eQS-RW; Mon, 22 Jan 2024 19:08:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-005ZyB-2V;
	Mon, 22 Jan 2024 19:08:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/33] spi: cavium: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:15 +0100
Message-ID:  <bd19e062a6c38add3e44b7a6f19d7108c2251a9e.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=/Yg1W2WDH9FF1Tn6OXe421fMQlr47i+9fDzZFse2hhA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtR1625d5ajx7F2fEZkZ+MfVcI8VX+KWConwnSfWOX0JN 4uNeODZyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEmr6y/8+qex+yepLv3Yt3 84WLEjZbF+ltlI+uEmjT1FO4tdozos7TUGRJevX2/sOl9Sx17QzPvta9E5VJXavi7rzIaEpe9Yb 7/hWPnFyey55/ZW5c2Sy4cmvDpvtV5TyhmT1LdwZNtam7Ha1Tfsdoze0Tbdo2MX/0VXpWXNR94Z pt63XP+tSUKR8kDnC8e5n98wZXw5vcWzOyWsyfiM86Z/MkTlX34SVuBY64h3szmFQMr63ovqfnJ vg/cob/fX6rKJ7tXNmrv0QKva5Zebnn7O3Q/O7XvOfyzKuvzD/zOKhAc5VUX4FU+cbVB6JYNVOq J+2UTraS+ugmbWHa8DlBOuzbpiqfo3unXtglI5ikpKMDAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
some functions and struct members were renamed. To not break all drivers
compatibility macros were provided.

To be able to remove these compatibility macros push the renaming into
this driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cavium.c | 6 +++---
 drivers/spi/spi-cavium.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cavium.c b/drivers/spi/spi-cavium.c
index dfe224defd6e..26b8cd1c76e1 100644
--- a/drivers/spi/spi-cavium.c
+++ b/drivers/spi/spi-cavium.c
@@ -124,10 +124,10 @@ static int octeon_spi_do_transfer(struct octeon_spi *p,
 	return xfer->len;
 }
 
-int octeon_spi_transfer_one_message(struct spi_master *master,
+int octeon_spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg)
 {
-	struct octeon_spi *p = spi_master_get_devdata(master);
+	struct octeon_spi *p = spi_controller_get_devdata(ctlr);
 	unsigned int total_len = 0;
 	int status = 0;
 	struct spi_transfer *xfer;
@@ -145,6 +145,6 @@ int octeon_spi_transfer_one_message(struct spi_master *master,
 err:
 	msg->status = status;
 	msg->actual_length = total_len;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(ctlr);
 	return status;
 }
diff --git a/drivers/spi/spi-cavium.h b/drivers/spi/spi-cavium.h
index 1f3ac463a20b..af53a0c31476 100644
--- a/drivers/spi/spi-cavium.h
+++ b/drivers/spi/spi-cavium.h
@@ -28,7 +28,7 @@ struct octeon_spi {
 #define OCTEON_SPI_TX(x)	(x->regs.tx)
 #define OCTEON_SPI_DAT0(x)	(x->regs.data)
 
-int octeon_spi_transfer_one_message(struct spi_master *master,
+int octeon_spi_transfer_one_message(struct spi_controller *ctlr,
 				    struct spi_message *msg);
 
 /* MPI register descriptions */
-- 
2.43.0


