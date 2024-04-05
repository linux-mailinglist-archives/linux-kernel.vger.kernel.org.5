Return-Path: <linux-kernel+bounces-133212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1389A098
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 088B02852A4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF554171E78;
	Fri,  5 Apr 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l0FcwKe2"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082E171640;
	Fri,  5 Apr 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329346; cv=none; b=Yd+ml94C4Z4aDcp5h415mzsBFHWmjymnMpwfiNRlE+DePjkjv/orZLF4JJt1WRKzvcNyhOGJC/Zoyva3iLWqJ7ZcSixM7nG/v4YAVsA7fhz/gMCszyxNXriUp48KXgOo+I7KkCods60LZgur7jGLbAlEczWVzkIgMzHq6rBKmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329346; c=relaxed/simple;
	bh=eyJRE0nsHnfgc4bQmba8lWsCsTaBQsKuv8mV6FP30m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKrjr50gEjTNjJLUggv4TOQ27dPxM7s96Acm5Pcueu55J3o1iC3UqaUpR9agKsL768JFcyK3amPE34dYTKn94ENNYx4dYkh6vi5vYT/Vb4dqb6ZXJj3u7VtotoS62pene7JtE2U9gfTPQorJlO0GPftAzqcBR1+hvsy/K1Mq0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l0FcwKe2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A983F1BF207;
	Fri,  5 Apr 2024 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712329342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F5PO+vwFUf8/nCeUbsDaSi0BqfsaPd3EG3ZxXLAXPXU=;
	b=l0FcwKe2Ye0H9G9ba6GIOniWdY40nd0ZUewY7xLyhmy8co9ZAgIkFyMQz/hpjvZxRhC/bq
	M+IWIl+KZRtkNxOthL6vFid9w5zsYBmlCjgxJhNZ2bvBGOv0cgMBsXl35/JAzvkut1xzmz
	UqKMwx7TAOEm88tqPB/E2u1IqbtatJ5kCQnU61+wF1j9nU4tmwuV6NiOtXdweFmTARkVyt
	05LGg3Oiq3sIvQ6KkKiJ52FnsiVp0yBHdgaJxi64UzEADK4lCup7LYxK7HKl6jEGErbUOY
	5549ia/0Bxtgckw1nsnXQwE9wCrAf3L6aGu8quYw2enu0apAQwJfjUlHJQDdtw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 05 Apr 2024 17:02:19 +0200
Subject: [PATCH v2 09/11] spi: cadence-qspi: add mobileye,eyeq5-ospi
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240405-cdns-qspi-mbly-v2-9-956679866d6d@bootlin.com>
References: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
In-Reply-To: <20240405-cdns-qspi-mbly-v2-0-956679866d6d@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Declare a new mobileye,eyeq5-ospi compatible. Exploit quirk flags:
detect FIFO depth through SRAMPARTITION register; avoid IRQs during
read operations.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 230aad490e03..11f54f507787 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2059,6 +2059,13 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+			CQSPI_DETECT_FIFO_DEPTH | CQSPI_RD_NO_IRQ |
+			CQSPI_BUSYWAIT_EARLY,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -2092,6 +2099,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "amd,pensando-elba-qspi",
 		.data = &pensando_cdns_qspi,
 	},
+	{
+		.compatible = "mobileye,eyeq5-ospi",
+		.data = &mobileye_eyeq5_ospi,
+	},
 	{ /* end of table */ }
 };
 

-- 
2.44.0


