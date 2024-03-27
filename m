Return-Path: <linux-kernel+bounces-122174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEB688F310
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E1D1C2ECBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCFE15625D;
	Wed, 27 Mar 2024 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="BGA5xBr7"
Received: from mail-108-mta166.mxroute.com (mail-108-mta166.mxroute.com [136.175.108.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC5A15539F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581802; cv=none; b=aJvWFhVjw092hecxgRqKFzeQEzzQscBdQ5lYH0fze8G9oS3/MqREOLJJ0m2kH5e3HWk654gdUwnlfetHMpV2Ri9fXGz20F1/fpTyuyjsnVK28/sQ7ltokX6ASe4zqmTrwBBJqX0E3qNrPIAd4iCjG0fcmxIdqQngXNfEawCcY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581802; c=relaxed/simple;
	bh=cA+a4yuqQVkS/8K8gNj/TEvJEub7ZleI9BN5eH1wpf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAXJVWeir+OM7xUKX5Fez/PCqZtar9YTKVe5CgZyb8sxqW85GKK0JcVTdcI76WwtZYAVJFSpeYB2+Hugn3PvFci+MEEK+DMukRmFkeJwkEVASNytgT7M2Tli0sGAWl/0rvXhbInbf7eSarogPZjP+kA/fymlRiEfHBn4ANsP4Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=BGA5xBr7; arc=none smtp.client-ip=136.175.108.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta166.mxroute.com (ZoneMTA) with ESMTPSA id 18e823480f30003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 27 Mar 2024 23:17:42 +0000
X-Zone-Loop: c62c6f4eca7f154990d8251e3ea88f5e9a155d942377
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8VAPtDzgGszeDreMGf3K+a0lokdNPZGj6/qmTj7fPpc=; b=BGA5xBr7spbPlohctMY2ikBX6L
	nYRFBgh7yjBoSbZiHv/G47ylGySSOIMFla4COvMGL6MJSHaJjUCx/1m/qJ+eLh540Mlgv/4qpKGMv
	6z4Cq3laUoNYklfCNQ2cbpOj0nH45RMB6baefLdk8hNbuJ+5lZX4aKiaQii8/9cH79Wr5xV/Cz6n4
	PbzyeUZJRIFxra7CSRWmCdKMWWGJYqxBkAVLZunU0Y7F25JV4MgjYs2PoWkmBNN1EguIH1cKlaR88
	5SfpUGzk9WlkzU/oeZXh+zr4xJIzglaQmvL1YUBZC08KCt+JISN+4Ml0hHKZDcEUo1Y4CnKbdzXGC
	oAT7MTKw==;
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/23] media: i2c: imx258: Correct max FRM_LENGTH_LINES value
Date: Wed, 27 Mar 2024 17:16:59 -0600
Message-ID: <20240327231710.53188-14-git@luigi311.com>
In-Reply-To: <20240327231710.53188-1-git@luigi311.com>
References: <20240327231710.53188-1-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: personal@luigi311.com

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The data sheet states that the maximum value for registers
0x0340/0x0341 FRM_LENGTH_LINES is 65525(decimal), not the
0xFFFF defined in this driver. Correct this limit.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 drivers/media/i2c/imx258.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index 85c2f1ccaea1..c2c5e819ddc0 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -28,7 +28,7 @@
 #define IMX258_VTS_30FPS		0x0c50
 #define IMX258_VTS_30FPS_2K		0x0638
 #define IMX258_VTS_30FPS_VGA		0x034c
-#define IMX258_VTS_MAX			0xffff
+#define IMX258_VTS_MAX			65525
 
 #define IMX258_REG_VTS			0x0340
 
-- 
2.42.0


