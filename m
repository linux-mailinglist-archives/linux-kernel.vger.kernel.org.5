Return-Path: <linux-kernel+bounces-162145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EA8B56A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F86B21D79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A76E4594A;
	Mon, 29 Apr 2024 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cYd8t3yS"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B59751C2C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390139; cv=none; b=qV02Aioq77e5COWZ/F9uvlmHIopfD4RKORJgSo2hI0RkuruvpipI4lCd03XWLI1E+GJaNlSL7orUmpXaRel9hu+uJC/oZoBb2kZ9RbRQVvmmuzV/z4bKW2buCcBrVzOrZJlrBDgcXD2U7wHMWu2LFu6oHxovMrDlMsFzm0wqLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390139; c=relaxed/simple;
	bh=D7OPeJLbch41oDZDivUDejzOlkcUJd7HsRHODi0a1SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxT/h2BKYhBhJv1p39r+uVRKLZbRsZCKlPKIgR+2mVZhOpXQyZFrbicBiN9dMNl2GGaDlbhQ74To4OQz1OuCWZ5k22+ptlgvEqS0VuYrAvbpj+56U2J2kUGcegv4Z4NNnujKFBkVDC0JVm5TNNGBpoixDjrSbOLVL7MCn4QNv4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cYd8t3yS; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=U1aYJ6z7/ImyPl7HdsAgHQCypuNdVejMIowCb/bL9pw=; b=cYd8t3
	ySsRqddvAIvU2awFj5wQ4kr6hxnSUl7b6LwQIzVbrVQD7DxEeLiwn7fNNkSrjJhw
	sNEzTH4tMs/hUDlbXvxngx11O2LtX6Ls51Ln/Gi9Q5Q7+4IAjTPZiwPQf7hjPtr4
	4ebeituvnd/X3Lq4W9md+orAk1NCeaDowiz0N4BVBpOVATdOlExq2W9hziqJOCC5
	jrwLgtJIv+H77HZ9TSzNtlNZ8IhHicWa8KWreX2y8QeDa9xGIEJBmVX4ROMb+SS1
	ixeG9nyYxDl9ubbFsUDy7E76Ubt59rEhhHlAK2idWFOkQ8XYPeqqozwJma5Wemok
	f8yoVpM+HrgSY0RQ==
Received: (qmail 2279704 invoked from network); 29 Apr 2024 13:28:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:51 +0200
X-UD-Smtp-Session: l3s3148p1@wATEjjoX7VxtKPB4
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
Subject: [PATCH 7/8] spi: sun6i: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:40 +0200
Message-ID: <20240429112843.67628-8-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-sun6i.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index cd018ea1abf1..7bbe7ea0d66a 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -277,7 +277,8 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 				  struct spi_transfer *tfr)
 {
 	struct sun6i_spi *sspi = spi_controller_get_devdata(host);
-	unsigned int div, div_cdr1, div_cdr2, timeout;
+	unsigned int div, div_cdr1, div_cdr2;
+	unsigned long time_left;
 	unsigned int start, end, tx_time;
 	unsigned int trig_level;
 	unsigned int tx_len = 0, rx_len = 0, nbits = 0;
@@ -488,26 +489,26 @@ static int sun6i_spi_transfer_one(struct spi_controller *host,
 
 	tx_time = spi_controller_xfer_timeout(host, tfr);
 	start = jiffies;
-	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(tx_time));
+	time_left = wait_for_completion_timeout(&sspi->done,
+						msecs_to_jiffies(tx_time));
 
 	if (!use_dma) {
 		sun6i_spi_drain_fifo(sspi);
 	} else {
-		if (timeout && rx_len) {
+		if (time_left && rx_len) {
 			/*
 			 * Even though RX on the peripheral side has finished
 			 * RX DMA might still be in flight
 			 */
-			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
-							      timeout);
-			if (!timeout)
+			time_left = wait_for_completion_timeout(&sspi->dma_rx_done,
+							      time_left);
+			if (!time_left)
 				dev_warn(&host->dev, "RX DMA timeout\n");
 		}
 	}
 
 	end = jiffies;
-	if (!timeout) {
+	if (!time_left) {
 		dev_warn(&host->dev,
 			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
 			 dev_name(&spi->dev), tfr->len, tfr->speed_hz,
-- 
2.43.0


