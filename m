Return-Path: <linux-kernel+bounces-59384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA884F62B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5951F2514B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A3B45943;
	Fri,  9 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PzCGfNxf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AD3CF69;
	Fri,  9 Feb 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486359; cv=none; b=rOemVSM/AaaMPjJBwrVkbIxYcjwjzqI5gCOi98I1IU01ztCfmxnYUIKfzoYOOMRxECtXPGYEwJDNsr5g5QfHog0lN/demUdd/EMQqsqLvuJWzLzBhmIJoLlfBC/gsr2BYIlahzxmEEpAZhXBJSTe+p/WUkpbq9w64AUAdEP1yu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486359; c=relaxed/simple;
	bh=8g0h2Rpw/9qFXCPzfQOZOoSloJvsAQxCz0t/+7F6CHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MeGDB8Y2/4BYsAsSwaXHRgEutOb3SUc+0AI98Db3Q/l1vkx8yIDWTCjYTVPYldBVcNDoJKpnBG6UQq+jIQnncS4CkuTkVCv4LGI7AWMnIvzAe2ofsr016rjx4O+VpBIjftINnd1vOgAxyWygWDfLdVBlXUMhECJt/n2/wuFYglQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PzCGfNxf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A77EE0009;
	Fri,  9 Feb 2024 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEFUds+rZrQHnppzDuzVbdDoYn+ud5dF52AFwoFYbLI=;
	b=PzCGfNxfVkN8VxxqWWz5mDuH2H7UiDyNGJVIPmYXu9G58ZFf/GdY3rAmTUbIzAim9Qkca8
	eHkA94i6LKT+YYX+cCHL0OKo6gxGqmvfjblnT3kGCotarsE3aJ+X7IG35KI70Wo7AQRZgv
	d24ppidtfc7jXS/z29/NYgXW3WpYqihXmRPKo7utVwyzrvdo8RIwypV0/br5CWRL7nNn7u
	/0mjSJfoY0pZDsHKgsIXNvlJMZFLwkYKPELIXCpOIrI/g5CW0/GPvDSmiNIT6uX9hj5khV
	6cVjbRLNLYr99GNeBb6MkG7FKTrfE+nZ/dwubR60nGLnv0IfriXlEVnz+VD5Mg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:45:32 +0100
Subject: [PATCH 3/4] spi: cadence-qspi: report correct number of
 chip-select
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-cs-v1-3-a4f9dfed9ab4@bootlin.com>
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

Set the ->num_chipselect field in struct cqspi_st and struct
spi_controller to the current number of chip-select. The value is
dependent on declared flashes in devicetree.

Previously, the num-cs property from devicetree or the maximum value was
being reported.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e9e3abd2142c..895c950e7fd6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1621,6 +1621,7 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
+	unsigned int max_cs = cqspi->num_chipselect - 1;
 	struct platform_device *pdev = cqspi->pdev;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -1641,6 +1642,8 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 			dev_err(dev, "Chip select %d out of range.\n", cs);
 			of_node_put(np);
 			return -EINVAL;
+		} else if (cs < max_cs) {
+			max_cs = cs;
 		}
 
 		f_pdata = &cqspi->f_pdata[cs];
@@ -1654,6 +1657,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 		}
 	}
 
+	cqspi->num_chipselect = max_cs + 1;
 	return 0;
 }
 
@@ -1865,14 +1869,14 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->current_cs = -1;
 	cqspi->sclk = 0;
 
-	host->num_chipselect = cqspi->num_chipselect;
-
 	ret = cqspi_setup_flash(cqspi);
 	if (ret) {
 		dev_err(dev, "failed to setup flash parameters %d\n", ret);
 		goto probe_setup_failed;
 	}
 
+	host->num_chipselect = cqspi->num_chipselect;
+
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)

-- 
2.43.0


