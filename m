Return-Path: <linux-kernel+bounces-165489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FEF8B8D26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F741F24899
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1512FF7E;
	Wed,  1 May 2024 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="wNCVnChf"
Received: from mail-108-mta141.mxroute.com (mail-108-mta141.mxroute.com [136.175.108.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7D12FF6C
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577488; cv=none; b=h5pQIZLzyXBAxYJtEHmHe/a8dUq6h8TeojedlWZNrAn700JzYDeaD98TMzESSd4huWU1tOt7Wy89iDwnQU2fkAbc17B0qecahYq8BOwpvaAsdRZylHZmpBPs/4QWirG2iUxa3LA3bFWOtFYmIYmyKceL7GssFZ0h+oPfKAaaTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577488; c=relaxed/simple;
	bh=t0DpAm14I63PD+zKjpelnQ5UomdKi3PfstUiSulsvmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLNQO2usz83CVplw8MFGcCWwTtC8ABgV97g2L+jXJddXLEBfiHwwX8JAfOgkEK4d+8kHhLHNBukXtWuUbOHLJ4hRqwFoBMqWh8JwRkcXtFYP4lxF+/oImhPT1MRpW0zUZMgMt0r5TD/w1YXXKeRpmtmxXfQ2a4w3M3Y1aDj3wH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=wNCVnChf; arc=none smtp.client-ip=136.175.108.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta141.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c29fd90008ca2.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:21 +0000
X-Zone-Loop: 6dc3b1119c42f1d9e714e812946456bdcf7454accc1b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mc+RbIL+DgqYcfe/mLvPif24eMzEBPY7cltm4NspsTE=; b=wNCVnChfe2otmVaHseoYGqbzL7
	Q/hmaFEupoRZyANBI9aimeAex5qUTZfN+NCfgLQziYk4q19oJOdzLiWOalsk/MKlEYU79tWBzUGhB
	zCRIQULz/fCikhXOwBlR0hOPV1tvNmAuxiQ3IPo42t5nRA2SSj8r/FoCT9m+QjU0SNW7HK0MRGpTV
	/BR33OmcfnpC403MdSEpaoYibSAFoQb17q+O2jxk72vDEHIdQxTnerubzJn9CRX6J8QtIRnPYLAQ8
	/Lr5y8I3O6wI2PdM31SeZWfXdovhyXOpiu268JHrPlngOAlnDn3NVs8ZiTcXbPDCcy3Bhv4CKQeA4
	YtWTJkvQ==;
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
Subject: [PATCH v5 14/25] media: i2c: imx258: Issue reset before starting streaming
Date: Wed,  1 May 2024 09:24:31 -0600
Message-ID: <20240501152442.1072627-15-git@luigi311.com>
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

Whilst not documented, register 0x0103 bit 0 is the soft
reset for the sensor, so send it before trying to configure
the sensor.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index c1a2c2406aaa..9c83ba1232fa 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -20,6 +20,8 @@
 #define IMX258_MODE_STANDBY		0x00
 #define IMX258_MODE_STREAMING		0x01
 
+#define IMX258_REG_RESET		0x0103
+
 /* Chip ID */
 #define IMX258_REG_CHIP_ID		0x0016
 #define IMX258_CHIP_ID			0x0258
@@ -1052,6 +1054,16 @@ static int imx258_start_streaming(struct imx258 *imx258)
 	const struct imx258_link_freq_config *link_freq_cfg;
 	int ret, link_freq_index;
 
+	ret = imx258_write_reg(imx258, IMX258_REG_RESET, IMX258_REG_VALUE_08BIT,
+			       0x01);
+	if (ret) {
+		dev_err(&client->dev, "%s failed to reset sensor\n", __func__);
+		return ret;
+	}
+
+	/* 12ms is required from poweron to standby */
+	fsleep(12000);
+
 	/* Setup PLL */
 	link_freq_index = imx258->cur_mode->link_freq_index;
 	link_freq_cfg = &imx258->link_freq_configs[link_freq_index];
-- 
2.44.0


