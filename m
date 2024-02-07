Return-Path: <linux-kernel+bounces-56941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1E584D19E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37049284A96
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D31613473E;
	Wed,  7 Feb 2024 18:43:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F1129A73
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331408; cv=none; b=s6CyPukmZsmjjyXy3reRphWHug37YTOpLd53s5lOBCalIRKv76j4R4XO75hFb+kOGj3akwwUiWhiOyMZl9DglUsNTNpHZRu1sQ1jAuBBsnzVL09B9/WehUQ8sYHY3X8n0ZOSo3gP6nqtKnDbgbUVWNrnbVIgw1exYPjKaxjAVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331408; c=relaxed/simple;
	bh=uVMXV1VAwmhP57PkwJ+8EfziPZH/wl6a5rMlX05Ius0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5dpZqGjUY6jVHVE2MmVsWPD6W6lPI52a5poi8TRtjw0YfHcctXmx6LtWHAxhOve6Xr/ZEHjXmCCMwM4y6NMK1iuSFgdzetnIPMMNTGg2biDztX2Z14qhSs36dhJjrT4o/jSLjVQm1gaylt+G8eoD6dQw13FmvGsYPyv8CAkz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtC-0007yo-Kk; Wed, 07 Feb 2024 19:43:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtC-0054YS-0X; Wed, 07 Feb 2024 19:43:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtB-00HRtZ-31;
	Wed, 07 Feb 2024 19:43:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 26/32] tpm_tis_spi: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:40 +0100
Message-ID:  <29000c8fc0612974242e3c23d14dd4771b92c71e.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uVMXV1VAwmhP57PkwJ+8EfziPZH/wl6a5rMlX05Ius0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87QEEwTnOWMpiwjTY7gvENhprUqKM6u2t+pl EAyZ0X8+/qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPO0AAKCRCPgPtYfRL+ TmnQCACF4kgbIRosnrHH0p+K1BjTaEvGGIQkvRZrdbR50l6niFbRyWV27GK+tVbI4aO3oQf7oBx t+AE2CbnmWxDfPAY64PH2qopJ3KDWOjYzMyaJrfPLhEWpP/5HuBBI3mLYKZ8FVqHEg9l2OoUFJB yg/C03oNmWZa+z47BEFZzJSynYGpdHaxWxwUt4yscetouY3hcCOGtW0YnPjwk1/lOyEnGL1wEBn 8VsR+71mu0vTR93PW+EUYFrYAfjCQy0yIVQ5bz43MhtUWl/bEn9uJoL9+oHs0gz53CTwFMMbUIv xi3yB6jv/x45yoAPN7UKtu7HJTgGg2grISAQNllBGWKJTLK2
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
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


