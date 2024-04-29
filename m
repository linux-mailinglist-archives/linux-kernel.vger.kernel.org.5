Return-Path: <linux-kernel+bounces-162139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620AD8B5690
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1963D1F23648
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3030A4501B;
	Mon, 29 Apr 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QiqdOS15"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0533FE28
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390134; cv=none; b=r8uRwnnRiceFtrQVnt35TnLhxFmJ0QWG1eS6VOIcvQrEzWfxMJdbLT/ynJxy0W/ThNoubIipbHC56XDoni0GI2K7ZPmhx10JUpqNU/LWoGpquoLjQEqMiekuFHvFQ8+oOGcxIjLWV2gw+44T10vaV7lLTeZjy8GuAtnC1nnjlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390134; c=relaxed/simple;
	bh=/+yQD/1xxpt49MoQExQ1xzYhBFcnigvlM4u45hspn/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y84ClKGzpERPDihFi9g3sIZZzGxw9rwvu15FDSLf1Z7ta/5LxK3NEzfm7YrCXrhKXoNgGaSdQW1H93dYpVtnI0T1z83IAgcIvS6LBYfjw/eD182lxaRwD3mmYbg+Xn5yofo5B6v4EtlAfanHGfEvn+GBaZCsSRcXjlL3gGG5sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QiqdOS15; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Tc5X/Zoe6TzZ7ehoGlEwf656j+yN61PTSQN5v3elxi4=; b=QiqdOS
	15/fKw2XKRiniG5gIdbcmDHbOpdjQWh7I8lyPv+YW4noWzynWoqS4K0+k/V7+Hbu
	xneolw1qFeu5yCzEFflcNHqp64h32A+twQhMzlEBDpmq8P/oO7XLq0H9ZYy124at
	iVCwNzV6cMjwXyUVLSINLpx6ay/79ouKo56lbcS4eB8DPEgIqX2EaQ+0rHdhhum1
	2/NMEhn/exNkM7LTfAEI8Cx+fIwNLZ9YKLBlPOq64Wte+1DrSTeAcy4UQ9yHr7M0
	uXiuT0dcPknJZxj0spnOiQyKs2LNOV+snuhUpEn/99ZthP+/K8OXxfsRSnaHLYe5
	ylbECwhGfAQoa4nw==
Received: (qmail 2279524 invoked from network); 29 Apr 2024 13:28:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 13:28:45 +0200
X-UD-Smtp-Session: l3s3148p1@3bxgjjoXflVtKPB4
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
Date: Mon, 29 Apr 2024 13:28:34 +0200
Message-ID: <20240429112843.67628-2-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-armada-3700.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 3c9ed412932f..02c1e625742d 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -339,7 +339,7 @@ static irqreturn_t a3700_spi_interrupt(int irq, void *dev_id)
 static bool a3700_spi_wait_completion(struct spi_device *spi)
 {
 	struct a3700_spi *a3700_spi;
-	unsigned int timeout;
+	unsigned long time_left;
 	unsigned int ctrl_reg;
 	unsigned long timeout_jiffies;
 
@@ -361,12 +361,12 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 		     a3700_spi->wait_mask);
 
 	timeout_jiffies = msecs_to_jiffies(A3700_SPI_TIMEOUT);
-	timeout = wait_for_completion_timeout(&a3700_spi->done,
-					      timeout_jiffies);
+	time_left = wait_for_completion_timeout(&a3700_spi->done,
+						timeout_jiffies);
 
 	a3700_spi->wait_mask = 0;
 
-	if (timeout)
+	if (time_left)
 		return true;
 
 	/* there might be the case that right after we checked the
-- 
2.43.0


