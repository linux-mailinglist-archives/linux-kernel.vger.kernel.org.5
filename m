Return-Path: <linux-kernel+bounces-163860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8B88B74B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7462814C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4F1448F3;
	Tue, 30 Apr 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="cpx3jULI"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C313F43D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477318; cv=none; b=OZJ5hzFhvt47tZobjMg+fTkujM5UmVxJblhYcH/ZiKVrrSXxPuvckB2v4nC+n6omfodpGMLu0nvvuQQiqZFfzN7hgmwqys3ppfXv8xUcvczjbc//l/LLOxfII269uh4Vt4ST09qwRKziuTTRKg5YMtBhz9+QtHztRPj//P7szCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477318; c=relaxed/simple;
	bh=ZZCt1Knc3LTkd7ud87jJX+jMQvb71Ot0fnQdxWqqxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiSSidYLXbvI9/ipJvEB+urVO8zynfk/oB6IRZ8FMnw5WAFeXde742VkkzDLHmCK3OS9nl/HmcvhK9ngy/BDqdMtjqNSZHNo8T6EBnKzPOCXW68jBV1snEdUV/Iug3GmYHwADQIX/Q7zOhxw3eqtEUQgRrijBohgTVGHI9PP4L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=cpx3jULI; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=wiD2un7//igTyi+4riuvfy4dW9R7R9MwCjnV7qyUbeI=; b=cpx3jU
	LIpMOrPzwVUfdli8JjTbZdSHbvmznoBXTbbslqQ9tvVwjD00xZs67M8KhRUQK219
	hFsSTsuI8MAUU1GgdKv79Z+vieH7fmggAqv+iPNN+3CDOdLUm8mzVS7z+gOpZkch
	AXJKQ+/Xz0PcNHwCvNqL/jsH45NToBmuOWcTwl4zfB7NAeC5bZIX3W1C2b1PnmJR
	u19Z7rR6zwBS1YNK+vyL+9TnBjd/Dufj7SB00KicTs0K2pFE+Ma500u4HThxAwpv
	SW/4TheSsA0KDU5bqDZhHls0aZp+5x3PYnHB1BombSGTqVsVesD86I8KbjYQcFcE
	fnkFSiXpWcpJPaIA==
Received: (qmail 2617893 invoked from network); 30 Apr 2024 13:41:48 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:48 +0200
X-UD-Smtp-Session: l3s3148p1@16rm2k4X1uhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] spi: pic32: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:37 +0200
Message-ID: <20240430114142.28551-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
References: <20240430114142.28551-1-wsa+renesas@sang-engineering.com>
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

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-pic32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 709edb70ad7d..b8bcc220e96d 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -498,7 +498,7 @@ static int pic32_spi_one_transfer(struct spi_controller *host,
 {
 	struct pic32_spi *pic32s;
 	bool dma_issued = false;
-	unsigned long timeout;
+	unsigned long time_left;
 	int ret;
 
 	pic32s = spi_controller_get_devdata(host);
@@ -545,8 +545,8 @@ static int pic32_spi_one_transfer(struct spi_controller *host,
 	}
 
 	/* wait for completion */
-	timeout = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&pic32s->xfer_done, 2 * HZ);
+	if (time_left == 0) {
 		dev_err(&spi->dev, "wait error/timedout\n");
 		if (dma_issued) {
 			dmaengine_terminate_all(host->dma_rx);
-- 
2.43.0


