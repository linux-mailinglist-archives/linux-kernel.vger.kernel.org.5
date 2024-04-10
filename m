Return-Path: <linux-kernel+bounces-138256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCFD89EED9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2361C20EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51715921A;
	Wed, 10 Apr 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fSNdOaCF"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED193155A21;
	Wed, 10 Apr 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741358; cv=none; b=qrPGYeH9pxQnrnayZhPb9px4jGZIpCppuWUEvhDjo4qYS2tZHo0zl100B66SPTVx54Keno1PIJAAMioZPbOYsFHfhLKNE+hcuajmKHoj9sGxVrwW1Ns0HSjyCQawAc9ggWm1YcV/TN24+yProQ/49p+Wa1NZnJSOU/5JmyjJEUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741358; c=relaxed/simple;
	bh=UqJ88SIv9Av9k1LZPkwfMWb06OliBDPxwdXSoyYMZsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oIa/5ctaLFFH0+S8hfHkLOmcA+k/DRF1kL0CNrVjuJuzHFHUxTgdFWPfFCPmjkZ3R+fnY9vqr3AtfpGpOqa1h4n3HgMYKVWTEx/FRZtzn1cZn2e7i1j2vtUM9doWbJC5A0llvcMQdbDDqg/WLuhHhLul6NKysGqUqC6iTUATP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fSNdOaCF; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F06CC0014;
	Wed, 10 Apr 2024 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KYYUJbx9oUlZqWNgUsoI1rjk0Kzr1DDG33TmakwDi24=;
	b=fSNdOaCFH8h9WZA4uyt2JnHlOESCwKIZqzLQjLfBYXb3QPo57EAloBtzjlVZnON9OD8jgj
	jGeTdh/u2KVXXwtVvvK+HIimiXPcx2LW7D2USvYJkOvA3918axtZmwI3l9DuLcUDJoKES8
	+APhV2oIQWeHCzdqrtTFbCt9k25kLE18FysR3eZWJp+lNJLgQI6a1ZHLN0YW4m4DcXaLsn
	Kc1tJug8E7kGWTAzit3mRN42/s3Iel5GXqqbL+YJvFwOYhFlVa9bEV/O8KWEq7zdowl/sk
	dN9/bqc62QKTghAeXdqAHU8divFnnim4JjODTRW7+WdE5z1TBrWBb8BYiXjiLg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:10 +0200
Subject: [PATCH v3 7/9] spi: cadence-qspi: add mobileye,eyeq5-ospi
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-7-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
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

Declare a new mobileye,eyeq5-ospi compatible.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index fecb76cfb932..7a287b329728 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2057,6 +2057,12 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 	.quirks = CQSPI_NEEDS_APB_AHB_HAZARD_WAR | CQSPI_DISABLE_DAC_MODE,
 };
 
+static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+			CQSPI_RD_NO_IRQ,
+};
+
 static const struct of_device_id cqspi_dt_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -2090,6 +2096,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
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


