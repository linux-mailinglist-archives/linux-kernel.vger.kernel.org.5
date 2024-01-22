Return-Path: <linux-kernel+bounces-33914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615658371B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55A5B2E72E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB660263;
	Mon, 22 Jan 2024 18:08:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C975674C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946904; cv=none; b=Kp8mzUP/ToJV7lSqX1HAxE4KSNB4JiIKcb1oDlRvWGx8sbp1smv7w3PWrXx7bM0IUoqEQp0WrUpyH0HDpdlJShnxYjZ7ly4LuZ/YVR4sa/+NZZr9G1ZEKvZzzw9kjKUhxGcKmmGuzDClymjDvqUotFjD5QeDqsamAkzp8e5h0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946904; c=relaxed/simple;
	bh=JvB30PH3Ov9f9numXa9egPytmZOqbhfvF+Hn9LRiENY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNVZwOu57GMa/9CJqrrMXwn6A2Gvz/jQy6tuSXvQxs+FtX5B82gk1qyfa3mlp1Tz18ATtmx+c7i4C73U6lkMhPRVGRadrk84A7PsFAP/SdQknC/7IgASCVwhPGWAJvkuyKQW9Bo+ut+eB5uIjuHrIr4KTIyxOwfK+sxGvUbqrHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiX-0001u4-6v; Mon, 22 Jan 2024 19:08:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-001eQJ-Ec; Mon, 22 Jan 2024 19:08:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiW-005Zxt-1C;
	Mon, 22 Jan 2024 19:08:16 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/33] spi: cadence-quadspi: Don't emit error message on allocation error
Date: Mon, 22 Jan 2024 19:07:13 +0100
Message-ID:  <0c3ef7c5c032f5712215050c99c51b73445c55e7.1705944943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JvB30PH3Ov9f9numXa9egPytmZOqbhfvF+Hn9LRiENY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7YydiS932ilzm7KX2ftMxYH+fovpddGo/vc RqP8Sds5eKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6u2AAKCRCPgPtYfRL+ TjZhCACJ+RIM955vfWlSRpaPoPt7HnyBgqNRZpI8OjLyoKSULtmK15uNR5Bz7gnP8mfdYqUB5SE tOTmHmzcPQnaq90GvNpgM1Br2jLFBX47u42Y63xZ/r1qO0d8xSDp9U7iGuQbPeoK6TRoHcH7pox HMrJ63bXVcq229SIFQKIjAtHpLuLQBbBRdlRRdhENIGUW0oeVQyslLWpyxt2mRgu/FO3Z0LwVwk zTp3v3mBZsXXmqGnoxMzPWGJVxG+WeWTof6O595WuqYTOVpMb8VeWeaLwJOVOAMcLpsZ65hd340 0jzun/z2AtQmzW7v8DxYLg6OoqRQyLBs1n5k8MmoSFm/wDE/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Drivers are not supposed to emit an error message when a memory
allocation fails, as the kernel is very loud in this case already
anyhow.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spi/spi-cadence-quadspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f94e0d370d46..eb6cc861b00b 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1712,10 +1712,9 @@ static int cqspi_probe(struct platform_device *pdev)
 	int irq;
 
 	host = devm_spi_alloc_host(&pdev->dev, sizeof(*cqspi));
-	if (!host) {
-		dev_err(&pdev->dev, "devm_spi_alloc_host failed\n");
+	if (!host)
 		return -ENOMEM;
-	}
+
 	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	host->mem_ops = &cqspi_mem_ops;
 	host->mem_caps = &cqspi_mem_caps;
-- 
2.43.0


