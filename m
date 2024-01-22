Return-Path: <linux-kernel+bounces-33939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F768370CF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E99B3471E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C764A80;
	Mon, 22 Jan 2024 18:08:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DC629E6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946918; cv=none; b=SPzjdYkEk3UupraDYX658ESXo+8chyz2jZIx/yyMwa4QoRM3ukCSlCP1ukqyUBoLKHu7ceb/Rq6iJmiioWfhIz46zfjeW59Ui3ZacVog8Uq1BgUTh0VrRj4cG5Rrf67/pM9pQWl4v9zFamc97roSW7/jQvSXd7JLBZFhwhIF1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946918; c=relaxed/simple;
	bh=XKtQhRqSb5nNqOnG6IfCydGW2PBCJJiRQ5sD9D7wQtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRcwu0bnA2HMHn9o+mOomAAWQIIH9mXFqNFK9futuPDov5om1lZS53FtybACinzmjHWGXqJ6SJUeB4PvQwH09ED5ErYCEdiHQRCBW0gSX4LYnNwbNW0gDTlYodqsm4dqqw1NO0XsDhnwOYbWsKzdgSIJo/lL5+kI74jkl6H+y0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiZ-00027k-L7; Mon, 22 Jan 2024 19:08:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-001eR6-S1; Mon, 22 Jan 2024 19:08:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-005Zyp-2X;
	Mon, 22 Jan 2024 19:08:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2 30/33] wifi: libertas: Follow renaming of SPI "master" to "controller"
Date: Mon, 22 Jan 2024 19:07:25 +0100
Message-ID:  <bc73a4e33fe347298a0a338dd7b720509a6b0081.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XKtQhRqSb5nNqOnG6IfCydGW2PBCJJiRQ5sD9D7wQtw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7mROqMmksVXtZKlK5ePULByhi3a7e8uai26 yJC0UxzavSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u5gAKCRCPgPtYfRL+ TsZpCACIuvX+HHZCs05CT9E3DYKuX7QOYeKsJmVpLGYd1eJU5u9AahYwFkMRkOo8iNokGhL3Eto Mwfjrnk4qbG2gurEV5Yva9HGfCAkewtRlLUmS7rJqasWw5wCBELkyx1C8j3F70j73oi6ALONobR ngQrCZgs7PkA0gb4RFyZF8sXYxI9pWEB+NjljAIVmil8K2mpH1P7MTSzDHbSYXzbrYhXEkmrMAI pz235ikKBD5fn6LWYq3ODbMZRt5WlN7eodgmp0eCNDMrR0Zb/eI1OTbCdnns7IKmeH7oN1Pz4ro CDfjOo0XVPJFZRd1rV4h+EKtA9EqqBMjnXpgetO8PPkpgUk6
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


