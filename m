Return-Path: <linux-kernel+bounces-165488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A68B8D22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24BD7B22D35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C64131BDB;
	Wed,  1 May 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="n9qOmSLU"
Received: from mail-108-mta123.mxroute.com (mail-108-mta123.mxroute.com [136.175.108.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C58131750
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577478; cv=none; b=VE2G4GT4b4JriEVKY3Hw1lFsHvVIDF9BIPpd2LykGlO9i7c0IN7ufypWgNT1+1PVpvWz+wo0nwjo3C0RwDqMDr/ZsPAlYTuDDK07pkbrIGfobb+8qZhJtcjmbI2ektdiqC3Q2/4fATUnlGtnVZlA20HCmvgu2R9aQ9NrXbbmZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577478; c=relaxed/simple;
	bh=DW93lC9rSeEtaobf7itjE64XnEYnqZ7qSOk+RzOJB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVEX5yLrwgYfM3uRR8u+XunWqlOZdOioKzlWCeKA45Q7C6g1iB367VVy4IdEVjO7rW/Mhvzd16RnU5An+ZvHyhHRYGhXWMpe3UcYcDlJq3Yzndpi/KoI3zjhc3OeelOu5iq/+P6tfMU2lhYIuaa1zW2Arc9AT8D5NUtngSEz0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=n9qOmSLU; arc=none smtp.client-ip=136.175.108.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta123.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c2903b0008ca2.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:17 +0000
X-Zone-Loop: 290a68761a2febeb490b3ea34b2da5c94aafe75c0ef9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bZhiRPeL9jOMw1N4B5HoYuhr3z7xt+xH2s8wek/zi98=; b=n9qOmSLU2isncEzDzGlkGQitd/
	BomYYLCpt3OiODoZPQQlCODBrj1c2QGm95XmKA9xSkUyJ2cQIMyLPPl5RZch0eoQJTx20Eg7xYOgA
	6MKS2c6mHP8mh5ZLeIHvFWp77Ya2f8uSkjFQtq5ZOwehxkW226VxEMgSb4khxI8JTLpZ8LOw4N2DI
	7htJYspuh33ocRmK1TnSjI4B3eVa0gbZxplWRWh1MtvYV/J8TeF4XV3Ln/k3K/xK4CRiH6XQ4pWOS
	uQbrNQWHVe3our0pc8ypnUpbFHQBiX/INbgLRMNecHsGDJP+do9mE69ts7dzXSejGSvj65v71qAw5
	LFdz9YIQ==;
From: git@luigi311.com
To: linux-media@vger.kernel.org
Cc: dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	sakari.ailus@linux.intel.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pavel@ucw.cz,
	phone-devel@vger.kernel.org,
	Luis Garcia <git@luigi311.com>
Subject: [PATCH v5 12/25] media: i2c: imx258: Allow configuration of clock lane behaviour
Date: Wed,  1 May 2024 09:24:29 -0600
Message-ID: <20240501152442.1072627-13-git@luigi311.com>
In-Reply-To: <20240501152442.1072627-1-git@luigi311.com>
References: <20240501152442.1072627-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The sensor supports the clock lane either remaining in HS mode
during frame blanking, or dropping to LP11.

Add configuration of the mode via V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
---
 drivers/media/i2c/imx258.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 59a78a4cfe44..2429eb7b55c6 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -72,6 +72,8 @@
 /* Test Pattern Control */
 #define IMX258_REG_TEST_PATTERN		0x0600
 
+#define IMX258_CLK_BLANK_STOP		0x4040
+
 /* Orientation */
 #define REG_MIRROR_FLIP_CONTROL		0x0101
 #define REG_CONFIG_MIRROR_FLIP		0x03
@@ -632,6 +634,7 @@ struct imx258 {
 	const struct imx258_link_freq_config *link_freq_configs;
 	const s64 *link_freq_menu_items;
 	unsigned int nlanes;
+	unsigned int csi2_flags;
 
 	/*
 	 * Mutex for serialized access:
@@ -1066,6 +1069,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
 		return ret;
 	}
 
+	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
+			       IMX258_REG_VALUE_08BIT,
+			       !!(imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK));
+	if (ret) {
+		dev_err(&client->dev, "%s failed to set clock lane mode\n", __func__);
+		return ret;
+	}
+
 	/* Apply default values of current mode */
 	reg_list = &imx258->cur_mode->reg_list;
 	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
@@ -1438,6 +1449,8 @@ static int imx258_probe(struct i2c_client *client)
 		goto error_endpoint_free;
 	}
 
+	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
+
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
 
-- 
2.44.0


