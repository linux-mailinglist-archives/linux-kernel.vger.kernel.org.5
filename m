Return-Path: <linux-kernel+bounces-165471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EEE8B8CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DE6B213FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336CB12F5B7;
	Wed,  1 May 2024 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="CnC+cnQl"
Received: from mail-108-mta29.mxroute.com (mail-108-mta29.mxroute.com [136.175.108.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F4712F59F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577221; cv=none; b=P15+IAwmX8kSu5gDo95KcgraL7neGXHXkIntYmWmXwesY5qn0BTuY+4q0Efl7dAgw5F/yx0S8J3Mad7bKdRO+hCFIJ7QNiDlz5Z0NrOv2wCOWxrJscqqhnfmkpO2Qi1pOWQl1peN4EVUxy07ITN0FVUKQQX62c9CJQuSHHTAJ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577221; c=relaxed/simple;
	bh=cy2aWmrWmWiUHsiEVhlHLdnMObXYvjQ2zBk5thr1UPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj23h7N4UGzgr6NSIQ4qk3THnOUTSYZUnEeMI9XjQnj4FX/oy1qCyRyrd2UOVIpZLdVpkczjC+/+v6oz7Tzguebc4kDyfaRSqx0m962gCI9jUSHQREYCcHakb0DSSFmDlX5KskxWEWDpsWY8jfmBj2fHeO0MGcJy32U8sAFme0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=CnC+cnQl; arc=none smtp.client-ip=136.175.108.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta29.mxroute.com (ZoneMTA) with ESMTPSA id 18f34c2fda00008ca2.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 01 May 2024 15:25:45 +0000
X-Zone-Loop: e64f0011bbbcfe84882c2f0cc8a6626d00e283648bb0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qrzk3wtzTAL6vILXNad62uNrTzT00IUmuGyKQ40D23U=; b=CnC+cnQl5j2zYk5kiv4/HYytuq
	0GKCkhCKHsLadAqx2Cso4NC+cRO6KpTmr3QsAviBgg//ghwYvIirI1elHtjDGEnJpcEqztKEYouaR
	X0kAHRfUNlRZKce2K42aWo3qCJHRlgbC210yJGH+uv2vPKALwqYL4xHJV/TAElEW02ujYMghD9FHk
	UP42HhhAGvoQLB5zREnuiFBPTteOybjPR+BaRi5BC5+YclO/abkUzcYtHeYmlgNcbgqlFscT01GC9
	fSz6Z3vkznWx8xUZ6ziqo/v/80u9/LkhQmAy55raY8/VDIqbkbe+H1ZzkxegNPq30E9sAjmHQPhIn
	v4u8+xWA==;
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
	Ondrej Jirman <megi@xff.cz>,
	Luis Garcia <git@luigi311.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 21/25] dt-bindings: media: imx258: Add binding for powerdown-gpio
Date: Wed,  1 May 2024 09:24:38 -0600
Message-ID: <20240501152442.1072627-22-git@luigi311.com>
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

From: Ondrej Jirman <megi@xff.cz>

Add powerdown-gpio binding as it is required for some boards.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Luis Garcia <git@luigi311.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
index c978abc0cdb3..33338139e6e8 100644
--- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
@@ -36,6 +36,10 @@ properties:
   reg:
     maxItems: 1
 
+  powerdown-gpios:
+    description:
+      Reference to the GPIO connected to the PWDN pin, if any.
+
   reset-gpios:
     description: |-
       Reference to the GPIO connected to the XCLR pin, if any.
-- 
2.44.0


