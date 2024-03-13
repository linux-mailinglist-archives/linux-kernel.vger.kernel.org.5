Return-Path: <linux-kernel+bounces-102255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42087AFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C226287031
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70128121A;
	Wed, 13 Mar 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iDIsBv1G"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0D6216A;
	Wed, 13 Mar 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350435; cv=none; b=TACbb68Xg8fZgbuPE0ezBg6ffLu1FUYVnhRFCQY4JLeQ/j1L6yoZU8cwNU8VAxpJIu2wg2Sd+CcBcUCFUdKrHufnqiF2L5NbqITzDGn0aKPzDf1O/sNUWbgGYA37b/Ku99Htf0bz0YmJ+rJkmSQgeMV1om2GXT1Y8LZMMPO1kho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350435; c=relaxed/simple;
	bh=fph/Js/9gtqeOzAtAipq81Jq5My4q6xwEoNRFuEXgms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQFOXwsn5rd4eo7I+JXQrPkOrt0Dr8g0BelEnlMkDSbKx9gSbp0ur5Wqy5FT3opRgNFt/prxmwEJAl1fbaaIIcBZh04CAwcJD0CRcPSla5HNY8uo/RWH5vT6dhxXlIlF9tttDg1ywHE57w7rtflnJ/9pYmK+LNLL2D3jdBYTdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iDIsBv1G; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0F3936000C;
	Wed, 13 Mar 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710350425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7GiX8uMeHKsAZ6m4Gc5pTZj0slQf5QBqcXc0IPAs4E=;
	b=iDIsBv1GsnU8Bp2AAy1YKPp+QEt+YS32Ambyu5/RMpBNuDTLA17I9bJMpHTAbenDpFpHot
	InGrmi3tolZauVHE6vWPRZyOrmpDrlQUUXkWyMXnMtbnNEM+nsA4if2idfA1O30ZFe2W3R
	HB5cXkJ19MSTNvF/0ggk88Fekw/+QRpXrVJOrIPdjKEEsqC7AYL2Z3Wltu96BwbFgrOnG1
	YilvujDcbIPeJibDzaONhx3kA6c1hE5Jw01JoNXIWoSEYgkxw4gxWxrSnQXmhs2jLDUqUW
	XgM/HCvHsbep2UpmvrGX6r3cN+0gjz1ctVj6DmoYR2o6Patt0BMFZpgMvZiAIw==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00
Date: Wed, 13 Mar 2024 18:20:15 +0100
Message-Id: <20240313172016.387277-3-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
References: <20240313172016.387277-1-jeremie.dautheribes@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jeremie.dautheribes@bootlin.com

Add Crystal Clear Technology CMT430B19N00 4.3" 480x272 TFT-LCD panel
compatible string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index a95445f40870..c575f7c4b745 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -91,6 +91,8 @@ properties:
       - boe,nv133fhm-n62
         # BOE NV140FHM-N49 14.0" FHD a-Si FT panel
       - boe,nv140fhmn49
+        # Crystal Clear Technology CMT430B19N00 4.3" 480x272 TFT-LCD panel
+      - cct,cmt430b19n00
         # CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
       - cdtech,s043wq26h-ct7
         # CDTech(H.K.) Electronics Limited 7" WSVGA (1024x600) TFT LCD Panel
-- 
2.34.1


