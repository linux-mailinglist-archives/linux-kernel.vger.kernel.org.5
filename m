Return-Path: <linux-kernel+bounces-59382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A5E84F627
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A14B23FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F03F9D5;
	Fri,  9 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R9n/DPM0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8AF3D0DD;
	Fri,  9 Feb 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486357; cv=none; b=iF1L1YOOZFYc/AFsGUwlqZoVooOrQtryezkc8rui6UUUKgSotitYbMGjF0Iz1uDPEP+MS9zOWNuIxCK/BvkGlGHjWq8AztZLIOZ/lTm11idq0t9h2H+AxJbG67jo1sc/w3d7CHMOebfTmUl3GQd5S+uIJjCL2agJIv1VOlOM95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486357; c=relaxed/simple;
	bh=Mlu7vr7ccML9k5U1wNxC85TsfulmH0bH6bck85b5lTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuZUQI5wLrcBq04ZDZW4aWBuWWyxc0QnOlSgdFyw+owgVEHKWHs5EB1/Wvbl/QlYgmzhY3YMHDKvziixW1eIuRZalpe2H/o1fOIDaRFxLeD08o5JP6agolVjc4YwU1JFxkVz/gSApnDx9AhJ793qTY0/sDVjp+mNfawnbbbeG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R9n/DPM0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8AFDBE0008;
	Fri,  9 Feb 2024 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707486353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SqxWl/i5uX0bLJjW8/zyRNlnWT7m4GMIsHrHc5Dq4Y=;
	b=R9n/DPM0/Sm2ibKK7ibZ4iCOBEn6TEswhd8v12CdgNiE+4W32JnCSNQMHhOxT4+fNAMvbA
	+KrWM5HbcwKiqNkRwO4RUoYr0UUS0DbTtWN8Y16qlSSikUPIiCpUh6ma2nyaNFrCSFBbOm
	/gaaWy3qgXga3CVMvFBoSWNlm+l/toSP3wExrhLvl0OfyR95Vsj2Qh38pO2WFJ+5UXY4/6
	p2q+NnLSM63MgbvWIXTmBYvUMVSeYUxWfJR/5MfoFyDhQoyjxj3QvXhHtQfMOnEYywUa0r
	7rYLNJfDJ2FLRgMHkl6CBrsEcvr+a4seClejYSX+XYuDwNFBIrM/CxGwv3YAIw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 09 Feb 2024 14:45:30 +0100
Subject: [PATCH 1/4] spi: cadence-qspi: assert each subnode flash CS is
 valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-cdns-qspi-cs-v1-1-a4f9dfed9ab4@bootlin.com>
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

Check each flash CS against the num-cs property from devicetree.
Fallback to the driver max supported value (CQSPI_MAX_CHIPSELECT) if
num-cs isn't present.

cqspi->num_chipselect is set in cqspi_of_get_pdata() to the num-cs
devicetree property, or to CQSPI_MAX_CHIPSELECT if num-cs is not set.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d44a0c501879..7ba4d5d16fd2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1635,7 +1635,7 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi)
 			return ret;
 		}
 
-		if (cs >= CQSPI_MAX_CHIPSELECT) {
+		if (cs >= cqspi->num_chipselect) {
 			dev_err(dev, "Chip select %d out of range.\n", cs);
 			of_node_put(np);
 			return -EINVAL;

-- 
2.43.0


