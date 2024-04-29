Return-Path: <linux-kernel+bounces-162146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACFA8B56A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4728428542A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FAA535DC;
	Mon, 29 Apr 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="hooLQnfJ"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392B152F65
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390140; cv=none; b=Ldp4+nK3UquQPGQ4g6zvzhapPLxxUJhiiBXYMwxL3+DocEiBtmw2uNa0BHv4Qru3w1Y83iGETB+Tu0YHRcbmRjmdqW0he9kUQxnWe9xwiV8dwfam3ZxnWpjeXD0J3sghyqZknOG1Sae0x48GF8AvFxfFRF2pf4CgIPUe2xDONwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390140; c=relaxed/simple;
	bh=MqlEzg2jbLKX7b5U4n7ik5lIo7ox8YuJe3H75yyVnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkW3FZ/tjbIBrMysSqiflRXXAu8qVHMhuSUTzfRM90dlz1VsTHf9GgKvE/y2j0x1uvdqvLyTMFV6FP8KHY0OsshkCcd1bThWncYXveimY19V8PujfMDjkismIP7DDk2u4wl64fazW/6amIxq9OmxSe4fwBXh6LBVsVyYPQ/ruZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=hooLQnfJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=QSKeK0isKUrZRHFQeVEM2xYZKBtP1xN7MAYYmt11wmo=; b=hooLQn
	fJRnSCS6U+iqEyjxwB3be9yC4tnNF5mRSWuMgiqV/vUVpBvYmrwQZR071nWGpxQp
	8L6X1uZyKlGSWVl+9qGR3oOhigzvL7CLF6z2raLAoXXDq0hcFL4vmAFxcnH4AEAG
	OP7z4p/lXUx0fGprfTc0d38JRtjwl7ZbORQuNFQ8qLi8yqwOVe+m5yv6QtVd0Mk3
	W00dCbNaY2KoHYwGyJygvCOohqD1SluNO/IjT6dnALrstpYwaa4ynitJLj292/Vn
	vliaVYWjm6DCRqjfzk6nX0j5icMloOU2b2FtcFK9IKZBZP39+rPzykCaR2oshOrr
	dTlSx+ryrvra7qRg==
Received: (qmail 2279720 invoked from network); 29 Apr 2024 13:28:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:52 +0200
X-UD-Smtp-Session: l3s3148p1@6oHUjjoXnE9tKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] spi: xlp: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:41 +0200
Message-ID: <20240429112843.67628-9-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-xlp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 49302364b7bd..2fec18b68449 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -270,7 +270,7 @@ static int xlp_spi_xfer_block(struct  xlp_spi_priv *xs,
 		const unsigned char *tx_buf,
 		unsigned char *rx_buf, int xfer_len, int cmd_cont)
 {
-	int timeout;
+	unsigned long time_left;
 	u32 intr_mask = 0;
 
 	xs->tx_buf = tx_buf;
@@ -299,11 +299,11 @@ static int xlp_spi_xfer_block(struct  xlp_spi_priv *xs,
 	intr_mask |= XLP_SPI_INTR_DONE;
 	xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN, intr_mask);
 
-	timeout = wait_for_completion_timeout(&xs->done,
-				msecs_to_jiffies(1000));
+	time_left = wait_for_completion_timeout(&xs->done,
+						msecs_to_jiffies(1000));
 	/* Disable interrupts */
 	xlp_spi_reg_write(xs, xs->cs, XLP_SPI_INTR_EN, 0x0);
-	if (!timeout) {
+	if (!time_left) {
 		dev_err(&xs->dev, "xfer timedout!\n");
 		goto out;
 	}
-- 
2.43.0


