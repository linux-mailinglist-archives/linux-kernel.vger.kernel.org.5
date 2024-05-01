Return-Path: <linux-kernel+bounces-165476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A80448B8CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67091C20342
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94E12F395;
	Wed,  1 May 2024 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="X6T9L+/5"
Received: from mail-108-mta1.mxroute.com (mail-108-mta1.mxroute.com [136.175.108.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E512F5BC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577413; cv=none; b=Q/kXWjciJdC3u+WIx+HMKraIuNOPLuD7X41zBmNVVlWFpRMFzk+2pjWvoxXRQjci/glQavXEi59k1kJuw0l2xBWOWQ+d1IXXRsgf+df9l/Yo6iuWym5/XQcSqp7INH3QA/S0ZSvYNjBSzO/J9X27hGLtYOkiCba9WuObE0vBc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577413; c=relaxed/simple;
	bh=+sFbuAZg5yu7TysrDNdaOxjpNwDMCdp+9SgLS1wKCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7Vo2DpwicGigp8+xy7ccMQXew7LdpJJQTKhMb5hXtwdiQyDWbDlAUUXCcHzORAyi+SIsVSC0MjHrX1kBDXqVwsZq/3z8uGCVDIDibQ/PHzkkebc8gIRGMf5iWlmpkFndDLVm7CkeppBlVy8ZYUxbldXdnFT0GAXYSnrJTikD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=X6T9L+/5; arc=none smtp.client-ip=136.175.108.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta1.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c22fb00008ca2.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:24:52 +0000
X-Zone-Loop: a745d079731d7a969829ae11257c9611e9265cfd2618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tNSp6sgHgm0/xBY9U4t7Qdk6wqjer/597ZfqTYMH0pE=; b=X6T9L+/5BAdJUPgj8EG1udLYLP
	ks89ddRz9KtdNRL1YpvQ5cB1tQUrrMIWgER1IW+mS/AYJEX1H1zkKausyvmz2Nh4oyPSnacpLPgIV
	aQzpphhLIid4121FCDcVAOL3D8ZFoV2zJ64AG2QfNM4DYXixPG/jWEyIA9XRpqhl/s7t+2kFb/BhV
	EjA5i0LjqJ5X7buDjDvceofaQzykTIbbG6cgUk0eyGTnRdDA5WK8Tn15Q/wJABteeS8Lss8l9savE
	qDM9z0MXwuWawmplYMK/l4AFQvwpKA6XSts1I2Ww2IVa9U9g66Dtwdrgd0ZRrtuTpkisv056ZTfnW
	P2eHKmmg==;
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
Subject: [PATCH v5 01/25] media: i2c: imx258: Remove unused defines
Date: Wed,  1 May 2024 09:24:18 -0600
Message-ID: <20240501152442.1072627-2-git@luigi311.com>
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

The IMX258_FLL_* defines are unused. Remove them.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/media/i2c/imx258.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
index a577afb530b7..2dbafd21dd70 100644
--- a/drivers/media/i2c/imx258.c
+++ b/drivers/media/i2c/imx258.c
@@ -29,12 +29,6 @@
 #define IMX258_VTS_30FPS_VGA		0x034c
 #define IMX258_VTS_MAX			0xffff
 
-/*Frame Length Line*/
-#define IMX258_FLL_MIN			0x08a6
-#define IMX258_FLL_MAX			0xffff
-#define IMX258_FLL_STEP			1
-#define IMX258_FLL_DEFAULT		0x0c98
-
 /* HBLANK control - read only */
 #define IMX258_PPL_DEFAULT		5352
 
-- 
2.44.0


