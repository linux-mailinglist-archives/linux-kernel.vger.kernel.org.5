Return-Path: <linux-kernel+bounces-163856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B918B74AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F568B20C37
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1FF13D26E;
	Tue, 30 Apr 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="a1Cz8AEY"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED0133291
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477314; cv=none; b=OjgrRlx6amp7qYhUHHrTs44yi32I+p0Gb9deH3spwQocmSpVgXO7qLXYTJ6kW7DzFt0pJj6cvDiVOpHGuMEG6rp7gAuLA5eg49A1B8ZuhejozsIB5K3gt1JTdCKfHykX19bssiAO0gtL6fMTveZJBDqsrchI4jp25+Sf77bSzTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477314; c=relaxed/simple;
	bh=6lX6Ow8+WDkXB8QGR8oS5cwaB8Odx+W5VMP6TmmTnWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlkiP29EucpTSj4sHWuSLI372uN/qmfc6T/8JZfcFXMG83CejDMHW0fsi7KY643pl/EN06xMnH7STGD7i9mbuldw7BOi8r8mNf2BWCbn+y3/1kmAD1ALlvAbWXeoP5WfAW2u9+6VNkYYMzoLhzI5mekkDVhqpABW+WtiuB0iFw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=a1Cz8AEY; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=yUtX8ec+dY41NIYbceVd82J6yRSNmS1VfJIrMLj50Sk=; b=a1Cz8A
	EYPrgkxSROqZth1JA3IC3tcoMIeq28Ja9BQbRljoG5aotPKjPXq9BTsMrWz08sYP
	fAsN7Hq0o29DXBYRshFlDIxyBxkv5m84TJv8zQbzhx1YdniH8gS/M5JIAH1UFLeF
	G7RM638uFcXPF8o3SRCMPYOiaGmjgCsKtoR7J6YXhZvXiJn/fqc/bgM2bzAXOAG9
	f0p7QGqDsOSSPFF0KcVoB5NEX7uQwdnBwUfVT4DstrcAQ1jb85/sCuz4BnZwu3gD
	RDqdCSjMHBksc4qM4V/cXqumlh1ECO4W3AlRw9+mPa/wxg9x4uuOh2L0XWwz9SYo
	X7NcZAap1VTASr+w==
Received: (qmail 2617870 invoked from network); 30 Apr 2024 13:41:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:47 +0200
X-UD-Smtp-Session: l3s3148p1@Tbzb2k4Xxuhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] spi: pic32-sqi: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:36 +0200
Message-ID: <20240430114142.28551-5-wsa+renesas@sang-engineering.com>
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
 drivers/spi/spi-pic32-sqi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 3f1e5b27776b..0031063a7e25 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -344,7 +344,7 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 	struct spi_transfer *xfer;
 	struct pic32_sqi *sqi;
 	int ret = 0, mode;
-	unsigned long timeout;
+	unsigned long time_left;
 	u32 val;
 
 	sqi = spi_controller_get_devdata(host);
@@ -410,8 +410,8 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 	writel(val, sqi->regs + PESQI_BD_CTRL_REG);
 
 	/* wait for xfer completion */
-	timeout = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
-	if (timeout == 0) {
+	time_left = wait_for_completion_timeout(&sqi->xfer_done, 5 * HZ);
+	if (time_left == 0) {
 		dev_err(&sqi->host->dev, "wait timedout/interrupted\n");
 		ret = -ETIMEDOUT;
 		msg->status = ret;
-- 
2.43.0


