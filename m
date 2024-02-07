Return-Path: <linux-kernel+bounces-56928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5291984D188
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0719B1F236D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B1F129A71;
	Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DE85953
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331403; cv=none; b=UxRdQqdt9dGlVXkvq1jhdI5vTvOm2aO2nnQ+kGGrdEXsBdrLsSgsagILEGRapkhqJfcv77ZvXA9Ji3WkkCRLDsr1gK3hCn8IwCk6E28Tz9wpwUkUDEJJXnHzW9cibxfDmgjV7eL2oNPBr26A0/1vVfbPAPTEp2LMzbGkENjaY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331403; c=relaxed/simple;
	bh=4wYu7Xc9eR22LmfUrJP6PrWGCG5RVj4kh+07Xr06lbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDdYLhwGIqM0TxHXelF3ItHhXPEBV+aC2+xfzAavvbwIB2DdDj7Nz5t9IChFoaIrrGNBEx8TXE2jVuluT/AnGCsRPZ7ll5xhhOzWkuQNckTQEnlG4nWYF3rvd1NF5cEL+nRsoJz8fneVfcT94i6gBRaO331WxAaVhoDw8c4Jafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0007mU-RQ; Wed, 07 Feb 2024 19:43:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-0054Y0-Ee; Wed, 07 Feb 2024 19:43:15 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmt9-00HRt0-1B;
	Wed, 07 Feb 2024 19:43:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 19/32] spi: cavium: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:33 +0100
Message-ID:  <8aa122cffa6c8c18cc3367def872f81cd9471f2a.1707324794.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4wYu7Xc9eR22LmfUrJP6PrWGCG5RVj4kh+07Xr06lbI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw86wqlDvFCYYlimi5Xl/f9sNAl28lWhxwDESB PRBb6RZCTeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPOsAAKCRCPgPtYfRL+ TlhwB/9wJIDWQA6DRjbZ+vEgqOeuVDb9PtgXaQbpGYxCmht57WivI7IxbP70onTdaPX9Tt38Q+9 1CL8hB3Ra7mt4yKam5rQv82KhgAoVOQ9Hqkz78xIeJqk+7LvaX9xQ7nvXUWbtkaJ98M0C9FroLP /dHAQfRw43WFG/g1hE8MNpccYMADgnBDN6EEzkUd7h9n2nhAv000NH6gb50ZjZ1Zmo7/4p74VQO H1igC/trEgoSvPE0FJ1DQrFTP3F8H0IbmuYPNKplCabuhHGYSG/jBwCK2W9CSDn74a3mBKlGQBa U+A5XG/HhiZG/w87bMmoPxo10ZGuli7xDcqAwm8bXX+mRh7v
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

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


