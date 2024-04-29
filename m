Return-Path: <linux-kernel+bounces-162144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FD68B569E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2131F237D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B4052F87;
	Mon, 29 Apr 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FS32s8bm"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9940843
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390139; cv=none; b=EsIJJvomWG0IBzY+UjTFk2EE62U1PLElRDjVO0MaQpTblOt/mnxsMkntbgHFsSJqO68A3zbfOWqymhBcKi8Vr6uSSvb0kRrVMrmz9uVyD7A12JoTyERAn8R1Aqh9b6RmEAyMTDIsrH5Gangzxzzod/pj5FPgdFMNdgKAncAIzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390139; c=relaxed/simple;
	bh=HttXKCFGHIVX81OVIeLZCnbPUyLUoWDK6FOuG7LInck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkk0zfNBQgQpV+l8vHfxcwAjYQcr56pXehlKomrpL+mHLZCb2kP/UHjFc/DKjnEjPG0nBNlfkus9ZIOldAGRaOpDmzCqldFde0HZ0Sf+y8vH4kKQJuK2VJZhKBczf7XtuBemLoAe5QdlbjxkRuhHCrgFQsoRM1Rsv4F913rTMJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FS32s8bm; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=tTCtWiINuS6VElP26/IngafNkTKRIxMsJbQoLAWEXag=; b=FS32s8
	bmah6IRXRbty3oQurlZK/iOpTiXwlVlHuTDS98+48ztRUvUDA9o9TR6zM41+WC0p
	kDLol/mdm37N6kFzFCZa3UFR+FcDbe+z8y1m+FRT51PcJwc6j71B4GQkUrb3+kza
	062OsVGXS9DCeoeLdvHrdqCqi/1eqida0U+Gs2/pBR5pHPxTFySQ+1JuduILJAnE
	8WYfcAGVKbxFg+6s57JnmCuFRHh/PBwnFkhE1T1TBc+eLR3PQj9DbkTAwPSIkNHc
	yv19OmpdKpZZu9aQh2fyzJrJ4caRG+WMtsgtuHV+Zij1mZEHJvor8P+Dxx/MzFrX
	viCh6/TlqsnS8C/w==
Received: (qmail 2279687 invoked from network); 29 Apr 2024 13:28:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:50 +0200
X-UD-Smtp-Session: l3s3148p1@3dazjjoXCnxtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] spi: sun4i: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:39 +0200
Message-ID: <20240429112843.67628-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a confusing pattern in the kernel to use a variable named 'timeout' to
store the result of wait_for_completion_timeout() causing patterns like:

	timeout = wait_for_completion_timeout(...)
	if (!timeout) return -ETIMEDOUT;

with all kinds of permutations. Use 'time_left' as a variable to make the code
self explaining.

Fix to the proper variable type 'unsigned long' while here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-sun4i.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 11d8bd27b3e9..2ee6755b43f5 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -206,7 +206,8 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi = spi_controller_get_devdata(host);
-	unsigned int mclk_rate, div, timeout;
+	unsigned int mclk_rate, div;
+	unsigned long time_left;
 	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
@@ -327,10 +328,10 @@ static int sun4i_spi_transfer_one(struct spi_controller *host,
 
 	tx_time = max(tfr->len * 8 * 2 / (tfr->speed_hz / 1000), 100U);
 	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
+	time_left = wait_for_completion_timeout(&sspi->done,
+						msecs_to_jiffies(tx_time));
 	end = jiffies;
-	if (!timeout) {
+	if (!time_left) {
 		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-- 
2.43.0


