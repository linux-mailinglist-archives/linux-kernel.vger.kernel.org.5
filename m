Return-Path: <linux-kernel+bounces-56953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E683B84D1AF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799CD2830D4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3635A1386BE;
	Wed,  7 Feb 2024 18:43:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74F712FB09
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331414; cv=none; b=CHLXdz347RLmCntva72l7m+u4aluP6Uj9LbvY5YpSgpwg+mveaCSXn7AotP1g6Nl0i5iij/RGJTy4nyuVes/8NlWz+zI9Bn/QZ6vsOzVYoRy1axhToeqYV8van8paMsVSQ2fCxOWyVHVuwDnycHKBOqAwaHTpXBDCQHzSSWUt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331414; c=relaxed/simple;
	bh=VHrosqJBw/jD2fXLXTk6B7k9ErsOSKDugMqkiDkHpEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGMOvo86a2xEAyqxXWoFwbhv/uzO7hejd/Qz3eo7u+dZkOovpf9VULNlQ9jBlWhq4s9wdpEKQ/kWiuTwy6Weet+ytkWx7NCfVjbHZrsNHM7e+TS0CVOqZI3KE9mSV/D+M7pt9kjXcqfQFEkgaRo7GgzK1KUR+U5xsgim7WLa51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtE-00086R-84; Wed, 07 Feb 2024 19:43:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtD-0054Yf-Av; Wed, 07 Feb 2024 19:43:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rXmtD-00HRtl-0o;
	Wed, 07 Feb 2024 19:43:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 29/32] wifi: libertas: Follow renaming of SPI "master" to "controller"
Date: Wed,  7 Feb 2024 19:40:43 +0100
Message-ID:  <971429eacddbad4c2f49b783ddd68746c1929ab3.1707324794.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VHrosqJBw/jD2fXLXTk6B7k9ErsOSKDugMqkiDkHpEU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlw87kvHJm3k99v3JLvxkbz6eOQnEymFaod/Qtw nSZ+2lPOu+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcPO5AAKCRCPgPtYfRL+ TkJkB/9MqJcVzo/oH3CtG2kkoGwi4IpSxpVsGFpp+yF3RdDaCtDk2KBdfK+lY8wVJLX/BuAh6Wz 7O7Fa3ZDbhzeyfXQQZUnkIwkUUI52U0ARmrXI2Dnl9JulBCfTlHHQkTXIJ2n/t+oPDY2l4Jwas3 KahFY0rdhvXSpVFe04dC7GMisI8nrlysgeAJ/IVZ4QOib6usVwtOFnbej+ebk1KFo56S/n4bpCm Rk1mJO+McINm/vyOOfSp3XZtBC/xBE9NvCd9BzUVdZTzk5huwSHBKvYcpaQOVl0qA6+ksnYNrXf jITbEf7XGJBSOcVzIlKKS16S229rmir2iZDuUZYLIZZBq4RS
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

Acked-by: Kalle Valo <kvalo@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wireless/marvell/libertas/if_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_spi.c b/drivers/net/wireless/marvell/libertas/if_spi.c
index 8690b0114e23..b722a6587fd3 100644
--- a/drivers/net/wireless/marvell/libertas/if_spi.c
+++ b/drivers/net/wireless/marvell/libertas/if_spi.c
@@ -1052,7 +1052,7 @@ static int if_spi_init_card(struct if_spi_card *card)
 				"attached to SPI bus_num %d, chip_select %d. "
 				"spi->max_speed_hz=%d\n",
 				card->card_id, card->card_rev,
-				card->spi->master->bus_num,
+				card->spi->controller->bus_num,
 				spi_get_chipselect(card->spi, 0),
 				card->spi->max_speed_hz);
 		err = if_spi_prog_helper_firmware(card, helper);
-- 
2.43.0


