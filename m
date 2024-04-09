Return-Path: <linux-kernel+bounces-137399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B366B89E181
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D72A2844E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E888155A45;
	Tue,  9 Apr 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A23n1mtR"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5C15539C;
	Tue,  9 Apr 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683555; cv=none; b=f/cd6gHXWpBKnNPH1/6mEOTBTdIHf2P6Galh+HQUw7o/ca/kntWkib3TafcKHQP5zeC+qLCZicXA+J5i7ZS3D77EiDCzuQ+Sha1XPV9+2BbOpzUQVQFqwa+gG8dUXE1bfz0oho9F8GCocvHU/dxZVui6p0r6KCm5ejxQ/IbC1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683555; c=relaxed/simple;
	bh=swPXTNFMleNRLwc2lI7NazIDtpCFdxALL6JsEwXB/nI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n0Z85M3RFhNIntzMSFUDEAoM3MRN/FCM2EPmfjAmksPyXppDii0sKwK9HYqZagBYetbgwJb9HTse+A9Nuj2UPqJyfY2Q5lkTERQcunWB8yhLrLCUaQpJi6fZxvFhAoqWwZDkywvqtVxk4N788dsgN5MHuVCHiUUD6DQHz4E8ins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A23n1mtR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A0981BF207;
	Tue,  9 Apr 2024 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712683551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WISM4SZ11/bakGJjQ1nxpVqGMl6TzT7gttp099sMHpM=;
	b=A23n1mtRt2NqdiKwG/WTebq7AV9WP14rbLv03cFVlCVSPlYIaeG3u8uBNq/rJy7yLQfpI+
	OHfgbuUa9V7MdWNenepSfqYYoQrn0QrM8ZPdjpeaXx9mJwdmFeEKWtPM2zYyqpKM/Rt6YY
	bwqj05vCBeK7G4aON47bYSQrA5yA84sN3AHShIXvxOi72/6G37Q4B1lpsWQtmXUZ3x1dPw
	WSZSZi1Y9id7V9YL9DrP2g8+ku9huadfhGJcYT9w67c7EbEDfwOr7K4aC4scbhJZHSUBI+
	mWaYdCoJmRnSRPpO6sYkqKPudHzPSB75WGQ6HrMbi7DzoAobOZKOWN0BqwB2pQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Tue, 09 Apr 2024 19:25:33 +0200
Subject: [PATCH] spi: omap2-mcspi: Ensure that CS is correctly asserted
 when switching from MULTI mode to SINGLE mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-fix-omap2-mcspi-v1-1-f2b881ae196d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAx6FWYC/y2MQQqEMAxFryJZT6AtRdSriIuoUbNQazuKIN7d4
 Mzyff57FySOwgmq7ILIhyRZFwX7yaCbaBkZpVcGZ5w33hQ4yInrTMHh3KUgSHnrrfWO+pJArRB
 ZL2+xbn4ceds1/P2P9/0AX4w783YAAAA=
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
 yen-mei.goh@keysight.com, jeremie.dautheribes@bootlin.com, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=swPXTNFMleNRLwc2lI7NazIDtpCFdxALL6JsEwXB/nI=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmFXoepxRFUwhEMxCHyBDkcvdZB4eO8mCwgvuHR
 krRnUY3zO+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZhV6HgAKCRAgrS7GWxAs
 4tyXEACrFn0qHvl2K7LYOp4wxc8ZUhEzov48y9wjgI6EB4BLJmXKwjf/4QC/N0E6j8FRWcs9HCG
 1I2r9z81SdrX5iZYzYDtTn3xV52lrVD5rHHmu3W8dpu19DtpDXzfTgC1zqHgI3c7IkCUAUoZwxQ
 0QQwEdLe1ch2xd4K5KNpxfpgN91cMpl/dlLfnwqbBh8Hp34EsvHKooEltp840EsOtI6EbSOn5HA
 KJKl1CVbd1/Riz45tufyZE0bKf9cg90wdsN3Jf4C8FP+xYuTC++sdbJ6dqheeGw70DRHBqiTta2
 8rvYBq1aqw7CaVd86QAnlDrtQqpDpvlFWn3+jXe86xmDkr/SyPJIgLC7+mZ8fJ8EoXvxparmy/6
 qQpXuXbO8KHl5I+50o86eFEDgZqhwTtJY5VU2XhFw54vcnrdFcIVZ9PYYliLKiTvpLusQAZWZat
 131dX5cFFfY+Lxd7Rxxk63hMww2T5f/Lx+N4sg3EMhUTP/brF3Nqa1QVzm64a8z1zgi+S6AX0JK
 QSqB9gDaHw2YBghqRk9ku6C75Ngrm6WfXhX7/GnvA29fDduvO4afdoVdN4XlXWgEcbUADOKIoFd
 rK2UnQluDUXfirlIEwZzVOneLGzN+3BzJtVeMFk9ggiUDHTZTWnLlP+28QhTW5p8dd18fwAN19R
 xpC5yKXk+KNez8w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The OMAP2 support features a "multi" mode, where the controller
automatically sets the Chip Select (CS) when necessary. This mode allows
for shorter delays between CS selection and word content, but the CS is
always deasserted at the end.

The default transfer_one_message function expects the last transfer of a
message to keep the CS enabled. However, when two consecutive messages
use "multi" mode followed by "single" mode, the chipselect is not enabled
during the second message. This discrepancy causes the driver to time
out.

To address this issue, the CS is now reasserted for each new message that
follows a "multi"-mode message. This change ensures proper CS handling
and prevents driver timeouts.

Fixes: d153ff4056cb ("spi: omap2-mcspi: Add support for MULTI-mode")

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/spi/spi-omap2-mcspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e3083b83534..571e4499f71c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1264,6 +1264,15 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 	struct spi_transfer	*tr;
 	u8 bits_per_word;
 
+	/*
+	 * When the last transfer used multi-mode, the CS is not keep down by the controller.
+	 * The default transfer_one_message expect that the last transfer of a message keep the CS
+	 * active.
+	 * Ensure that the next call to spi_set_cs will work as expected if single-mode is used.
+	 */
+	if (mcspi->use_multi_mode)
+		master->last_cs = -1;
+
 	/*
 	 * The conditions are strict, it is mandatory to check each transfer of the list to see if
 	 * multi-mode is applicable.

---
base-commit: 51244b7df2f236cea87a10729d5cbc777d199e19
change-id: 20240408-fix-omap2-mcspi-a6b41142ad9a

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


