Return-Path: <linux-kernel+bounces-99634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35A878AFD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290ED1C21635
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEFE5822B;
	Mon, 11 Mar 2024 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci5hMYwr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFD58120;
	Mon, 11 Mar 2024 22:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197605; cv=none; b=UyFYCJHbkIzFcGaBgxV48TO50UIVtuq3aqDS98B4//tIIA6YsripmKcI9xLRPZ1gXO+Zdm5a5GquNN5tsydw7XKPVaF3WBAylpY0ZGtyZMSmtDwMiHhnbd9ioUcWGdYhIDKd5c+v5tP4DRSRBC03zy29JJj2UK2aVnVhK4n47Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197605; c=relaxed/simple;
	bh=9ZjBrIXW2ZXPOAhtNjOe5sd4fGDoHN3TKnsTAJpyokY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C8lfOBxD86gHW0Hpo8jFJJrELj7FW32lVhJgj3rl9c9TTuMpt0cWD1mUZFrYfhzxjWJGikWZv4McskIQ7gzn5wanpYGuMzKLV7hYdk0csFyJePw+ujd7PKsMdqCptFt04jIRa85/pUZsCOuoJJBi8NFTepYVKKNRfxtHxg0fkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci5hMYwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85701C433F1;
	Mon, 11 Mar 2024 22:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197604;
	bh=9ZjBrIXW2ZXPOAhtNjOe5sd4fGDoHN3TKnsTAJpyokY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Ci5hMYwrC3c++tlyxncCbAF9XvBIsuMCChkPGyMRxhZ4SVzVlaDk4PTRLcvW9qln2
	 Q3CNGYPEy3sAN2bOml3EQaZkqExSLtMG3Tx1hQoNgnM+Q3XaY1KXTXmCHM3FwaDvKc
	 fktjcZCA9zyLHSTdNNTbWIHAWp4iXmPiwc7WmxJqkFJxLnWt4R2kMP3G/qx8LQ9qp/
	 S3aeP14hc4QoLbQjhdhURv5/uSZKBQxHreoz+J7OdIPWB+uqayzlYW4C+aeeNkpDic
	 1fDjYlNvHZ+y3N1BxcONnWUxXWKMPHH2fKida2dtpJLlofLMRs9dW3/9MlNMWVJEpb
	 xEqU7kV90LuCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE8C54E58;
	Mon, 11 Mar 2024 22:53:24 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Mon, 11 Mar 2024 23:53:17 +0100
Subject: [PATCH] spi: Restore delays for non-GPIO chip select
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240311-spi-cs-delays-regression-v1-1-0075020a90b2@jannau.net>
X-B4-Tracking: v=1; b=H4sIAFyL72UC/x3MQQqDQAxG4atI1gZmtCD2KuJCZv5oQKwkIIp49
 067fIvv3eQwhdO7uslwqOtnKxHritIybTNYc2lqQvMKbYzsu3Jyzliny9kwG/yHWHLXhl5SgAg
 VvhtEz/96GJ/nC/j50RJqAAAA
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, regressions@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2363; i=j@jannau.net;
 h=from:subject:message-id; bh=wRDHwpl4qwb+1xQqHZ8GOwHiYZo9FyBukC2YvocLxcw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhtT33cnaglMK9z3v/5Ym+9av/Lh+ZOKhvpkPEnPUTv9Y3
 WD/Nsmxo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwETK9jMyPH+/Y1rw509F7TK7
 T/GczXKfLBL79yDLk0TrGUv770x8zsTwT3mqVBW36BrJytNsylktK66xHPS5pqdsN3FpxSL+WJP
 T/AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: <j@jannau.net>

From: Janne Grunau <j@jannau.net>

SPI controller with integrated chip select handling still need to adhere
to SPI device's CS setup, hold and inactive delays. For controller
without set_cs_timing spi core shall handle the delays to avoid
duplicated delay handling in each controller driver.
Fixes a regression for the out of tree SPI controller and SPI HID
transport on Apple M1/M1 Pro/Max notebooks.

Fixes: 4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core")
Signed-off-by: Janne Grunau <j@jannau.net>
---
#regzbot ^introduced 4d8ff6b0991d5e86b17b235fc46ec62e9195cb9
---
 drivers/spi/spi.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f2170f4b5077..71be2ba8402f 100644
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

---
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240311-spi-cs-delays-regression-fd7309fc0eff

Best regards,
-- 
Janne Grunau <j@jannau.net>


