Return-Path: <linux-kernel+bounces-113532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41669888514
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722241C244D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95C13E050;
	Sun, 24 Mar 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a04H6X40"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0113E031;
	Sun, 24 Mar 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320333; cv=none; b=pVz26RjRPeOU1Av1LCogBNJ6M31UfLR/YOlcIkvumUmpy0mjO62St7VXa4dfDmTFUEw2ycj53r9JvbL75oEZ4+iS6M4QRwO0W+3okaKgySSTGTPfidAdiVqcGiCAdvkDDWxu7WQAGbXAyW0j2a/mTkBGtfsGZVykJXlexStmD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320333; c=relaxed/simple;
	bh=UnyUkvruAeVP9RuMr9izOfqY5IWqIDv54od7+h6EmOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUPztOzj84jxCd2ADNXGKrpRB57R7afJA/79Nb+Ai5fIuxa773wtS/43c0418QFPJBI38pfHhJumIeRYPOhG5bI+o5+ofDVMTyVoiqliAW1s2/bYRy0CwSSMQ9vFu1kHqmCAq4YjBXhWmD9u51K0iRP/BLkAlrqnGgrusVdsAdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a04H6X40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0389DC43601;
	Sun, 24 Mar 2024 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320333;
	bh=UnyUkvruAeVP9RuMr9izOfqY5IWqIDv54od7+h6EmOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a04H6X40CnUxhZk/Hid+vICbYvEhhdJejLSMbXSb/vUishCoWrifdRRdK6zqO9b/F
	 QublDkQ+lLYtSuLu+pMG0kxUuxTVaoHr5F+FxI6lEi/eu4XiDc+uZwuhtbJEg5+BO7
	 diWCTV0FyXV7AKvp6TeoCL/z1KwLLsCRD9CP0X5XZsjAzsB64ySb+SRtBgtVeDmcVf
	 jFSw/sdrXfEwG6hn3jtxFmxqM908/21HoIEyK30rZ6Ufovaifhle5QgO23KIQ9K2Ro
	 xfxincL7D/GMVEpqxhbnGObGfo+UWJrqYMu3zm8g/P9z1yxIpIhSrGSNRF1fXp5lsT
	 kQzN7mx4zClWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 641/715] spi: Restore delays for non-GPIO chip select
Date: Sun, 24 Mar 2024 18:33:40 -0400
Message-ID: <20240324223455.1342824-642-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Janne Grunau <j@jannau.net>

[ Upstream commit aa0162dc0dd95c3bf248e3c78068760094e8f64b ]

SPI controller with integrated chip select handling still need to adhere
to SPI device's CS setup, hold and inactive delays. For controller
without set_cs_timing spi core shall handle the delays to avoid
duplicated delay handling in each controller driver.
Fixes a regression for the out of tree SPI controller and SPI HID
transport on Apple M1/M1 Pro/Max notebooks.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Janne Grunau <j@jannau.net>
Link: https://msgid.link/r/20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d1b297f438f14..46f1535487608 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1042,10 +1042,14 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (spi_is_csgpiod(spi)) {
-		if (!spi->controller->set_cs_timing && !activate)
-			spi_delay_exec(&spi->cs_hold, NULL);
+	/*
+	 * Handle chip select delays for GPIO based CS or controllers without
+	 * programmable chip select timing.
+	 */
+	if ((spi_is_csgpiod(spi) || !spi->controller->set_cs_timing) && !activate)
+		spi_delay_exec(&spi->cs_hold, NULL);
 
+	if (spi_is_csgpiod(spi)) {
 		if (!(spi->mode & SPI_NO_CS)) {
 			/*
 			 * Historically ACPI has no means of the GPIO polarity and
@@ -1079,16 +1083,16 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 		if ((spi->controller->flags & SPI_CONTROLLER_GPIO_SS) &&
 		    spi->controller->set_cs)
 			spi->controller->set_cs(spi, !enable);
-
-		if (!spi->controller->set_cs_timing) {
-			if (activate)
-				spi_delay_exec(&spi->cs_setup, NULL);
-			else
-				spi_delay_exec(&spi->cs_inactive, NULL);
-		}
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
+
+	if (spi_is_csgpiod(spi) || !spi->controller->set_cs_timing) {
+		if (activate)
+			spi_delay_exec(&spi->cs_setup, NULL);
+		else
+			spi_delay_exec(&spi->cs_inactive, NULL);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
-- 
2.43.0


