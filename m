Return-Path: <linux-kernel+bounces-59383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3184F629
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A735E1F24B8E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB93F9FA;
	Fri,  9 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OYRH+1h9"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C823D3AC;
	Fri,  9 Feb 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486358; cv=none; b=WDJRN7XPk0u6FrGofOkAC6ysWfW5ZhaX5+EzFPPlaKSUiBnBNO4yP4aIhB1QOZh/bXuWNfYYiImhHQ2oPaHMcOrbjLv+nXSXesRZVf5z3onm+MPQVrZSSHZHxd17Tvb/eOpImTi4tIhoSds1I9+P5OSk4fXHERvPn7WUNdp9mqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486358; c=relaxed/simple;
	bh=RauYGwEB1YTMpsZjqNvUtZ7wglKUkFfCZNOF/rIy9m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ru1CcOP27RFiN+KMqBqFEkijpvl4PabadXjb7IvtJ8owZJkMj+EBK8Cwnw+iqFB+RBe7SgncbM94H04zbIXBTxpTvk/vQx/Igbf7OTprVzYCRGWaRAjw0T6kJvPhZX83xrJVVfeT6NYBk6FMhmXq6AFMMK5cQnf7StgbL8MmF/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OYRH+1h9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C8F1E000B;
	Fri,  9 Feb 2024 13:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PRUo6H47Gz8Zmp7Xe0Xi3761MV2avrUEkqq7NMqRIuM=;
	b=OYRH+1h9ENpOHuQSFbJek3Szzd6unm4XfTm4qZ7EfMiTv9GVWX+RmykyAIHxqijMDTBR99
	CteuS62tAnrQrLQmyCDC5qbJu41AYAg9+5p18kkH1IhkJAdvghysHeGk2L6zCcvz0j6YYd
	fbxwHehejLTbwhRiNJpZecWqlDH1M5Biafh0EwufTQw7TJIDUR+A7vQAp7WggA4f8EhXOx
	xKeNj1vs4zVVfCjrcPGIICH+KLXa/BXY5eEOxQ+O4GqANA898GXJse7x/BRjHQUVBWD7OP
	xrWApLTIIvs8JwuyWafrkbEc1qAupScCt9Ie9zVs9Q4avNQhgTo0rEONcKqXQg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:45:31 +0100
Subject: [PATCH 2/4] spi: cadence-qspi: set maximum chip-select to 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-cs-v1-2-a4f9dfed9ab4@bootlin.com>
References: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
In-Reply-To: <20240209-cdns-qspi-cs-v1-0-a4f9dfed9ab4@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dhruva Gole <d-gole@ti.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Change the maximum chip-select count in cadence-qspi to 4 instead of 16.
The value gets used as default ->num_chipselect when the num-cs DT
property isn't received from devicetree. It also determines the
cqspi->f_pdata array size.

Hardware only supports values up to 4; see cqspi_chipselect() that sets
CS using a one-bit-per-CS 4-bit register field.

Add a static_assert() call as a defensive measure to ensure we stay
under the SPI subsystem limit. It got set to 4 when introduced in
4d8ff6b0991d ("spi: Add multi-cs memories support in SPI core") and
later increased to 16 in 2f8c7c3715f2 ("spi: Raise limit on number of
chip selects").

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7ba4d5d16fd2..e9e3abd2142c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -31,7 +31,9 @@
 #include <linux/timer.h>
 
 #define CQSPI_NAME			"cadence-qspi"
-#define CQSPI_MAX_CHIPSELECT		16
+#define CQSPI_MAX_CHIPSELECT		4
+
+static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 
 /* Quirks */
 #define CQSPI_NEEDS_WR_DELAY		BIT(0)

-- 
2.43.0


