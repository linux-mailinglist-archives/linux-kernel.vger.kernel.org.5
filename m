Return-Path: <linux-kernel+bounces-33931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199E98371FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B3CB38AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763961668;
	Mon, 22 Jan 2024 18:08:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122D60BA9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946912; cv=none; b=lBaqE3wLq6e4+N9rvt9DB4N0kQA7Uvud1j1DbCqc8ea9AZ7JjJU0cgk8i4x8GRBxTqLnU1QL7HwDfqLwspSkRP99MlMOE9v3xeJ8Cvs0cNuOdQwg6vwKB00kMx/G3DDPqzkuazzrPqi4+dC2p9zZ3llWdTd+nZjsJ5Yv2Z9hsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946912; c=relaxed/simple;
	bh=+0gVSqI5A+fW4njAyRhxUDCiw8TcwVUPcn8k9sD6RGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVaEulPDtpLAcqCnvy3GS9z9wGGTIKDenr8frqwRiw8hsa+Hsfuk7/4YUKClHyZI6mZGKZJZ4S6ba6HjGdoXy8JR0YMw/IlDL9JAJ2KKKamsorAcEWuJuRRs2fFP/0cG3y+lWRr14nlW+CqBN62lI5zlc6fjcT9QI4mdIowQ+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-00024i-RB; Mon, 22 Jan 2024 19:08:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-001eQu-8c; Mon, 22 Jan 2024 19:08:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-005Zyd-0Z;
	Mon, 22 Jan 2024 19:08:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 27/33] tpm_tis_spi: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:22 +0100
Message-ID:  <0dfb829ad4a7ad6b3bab14b53890fa051ab3519f.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+0gVSqI5A+fW4njAyRhxUDCiw8TcwVUPcn8k9sD6RGI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7i8JCQBLHYKhHUCPQnSZXDYnTBgbh9T54iw YSPwyZ7AG6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u4gAKCRCPgPtYfRL+ TlVCB/97E1DEPs+T2txiMz/35GSbwPu/Zk0MraVUmSDupgkZ4C0e/wKJJnZNirlorIwC49L/MX9 v2Pyqw2cRaRRQ/r+0+IB/TtV8TE9C8X3kFN+GbxvsCkvSep66QNwqCVqxc1+GHG8U+pvi3wp3LN B0gJDT8ybONXta7B/sxnSCUNbUPdk5Xq0Ihua3gVA0jLq+wlcB/jx6oPXCnenL8VhiHHQir+sip z097Z9WoL9Xvn7k5Vh5xR2rL2IcYgKGosorQs8LlewQchqEQkEc5TWFHevA7GonwHfkqZRssmgb 4AHiTOsElzCp5vCHEoIsVKPMMmSzTdhYaf2awBYHjUVKbmdB
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index c5c3197ee29f..c647de7b3709 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -146,7 +146,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
 
-	spi_bus_lock(phy->spi_device->master);
+	spi_bus_lock(phy->spi_device->controller);
 
 	while (len) {
 		transfer_len = min_t(u16, len, MAX_SPI_FRAMESIZE);
@@ -210,7 +210,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_data *data, u32 addr,
 		spi_sync_locked(phy->spi_device, &m);
 	}
 
-	spi_bus_unlock(phy->spi_device->master);
+	spi_bus_unlock(phy->spi_device->controller);
 	return ret;
 }
 
-- 
2.43.0


