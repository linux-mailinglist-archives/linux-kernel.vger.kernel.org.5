Return-Path: <linux-kernel+bounces-163855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECAA8B74AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07891F22F63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91F1332A1;
	Tue, 30 Apr 2024 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="SLz7/teq"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D3131BA7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714477314; cv=none; b=NpOHpCojDUYOTAPbLhM/rZ3xBPgUFptPJy0A4VgtqdxAawEdDXWwURP7y42sf1WthxDZnpnYVuV6lGcKCChDCHAvvo5J9TPhsFcsMdddf286c0lt18DqDXm1EJpS1FqYJ/Kc8PYL8ZJ9mfqEoZEZZkYPOKt5ZafZyr2w38aZ7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714477314; c=relaxed/simple;
	bh=/+yQD/1xxpt49MoQExQ1xzYhBFcnigvlM4u45hspn/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btuHCT5E9WW3a+ylDf0Ot/uhtGZknrpz2EgG8JDFykAxOPtT+bxnPQqROwdSGT+QVGEQyiGrgssIy0IZrVm7S28YkIHSkmbxU8YyhjcRE0Q55RWOKOMKPj1UGOFNnbWHAVchtsmPSH/fOfMhWf93Q2nQ0+UXtOK7JlDmGR4nv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=SLz7/teq; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=Tc5X/Zoe6TzZ7ehoGlEwf656j+yN61PTSQN5v3elxi4=; b=SLz7/t
	eqVmXqY8JhMbX+u/25uNAtIG77C2ODWZywg0PPebVQOfpySVdMQWH+zJ9xtI1ZZ/
	5Y7PMtGvpMY0pJlWb32bpN4ofkP0I4tbxK+zmKNSJ48rzzZGaELMZgA7KxTPpWJu
	iSaa0/sH1WVPOTM1zs0+XNBEUKP6ISPjq0glHGkm6nbP+WHpdsTUckgvKBWhNMIY
	RGhojboqbusd3rp2+g5ZBIyYuwjLVSCstU5FVY9ib/AsvU+/7TwhlH8OJv5EotY6
	Tyf/hQwtfZ+1n3VqG3hUEqtya1GyfaBtnIQ5HsZw/gF8c5Z3KfQyc4HSDfT8PtfE
	KRKEVMK/KrF4pSeA==
Received: (qmail 2617773 invoked from network); 30 Apr 2024 13:41:44 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Apr 2024 13:41:44 +0200
X-UD-Smtp-Session: l3s3148p1@nw+x2k4XrOhehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-spi@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] spi: armada-3700: use 'time_left' variable with wait_for_completion_timeout()
Date: Tue, 30 Apr 2024 13:41:33 +0200
Message-ID: <20240430114142.28551-2-wsa+renesas@sang-engineering.com>
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


