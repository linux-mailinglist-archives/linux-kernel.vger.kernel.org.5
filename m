Return-Path: <linux-kernel+bounces-90895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E7870681
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B09C2823DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563CA4C637;
	Mon,  4 Mar 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mxcd7MhD"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A495482CA;
	Mon,  4 Mar 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568304; cv=none; b=cNL3yJO2IokeyPD1vMhLVwtNUHmu9oTzmfmd8LB3q+j7mzb01KFjFPG8kTgh42s836qoFKTkgBZr/z0Va/AyNh6O04xCCbpdhWSwvKcDDcU2OkqCDk8WVnW787KX7C+GI9HpYK+NcjOobifAk3HepGBx6W7C99+cL45OwN3KFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568304; c=relaxed/simple;
	bh=IQZJrynjmNkRwbD/swl17Nu6ar2/DgqZrKdijF57wmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jpr1ZNsf4m1F3vIntVW8STTiLJvlSgRJCSm2tEJK5l9Y+Mr38AryyELGedEiLpsRux3oJdjsPTmQ5n9Gp4TEHv/t+L6zJepwm0oVWi8N+Xaf3+LSNlR4Tm2+iaxTObFfodRfJMv77oKqRLPYveEyLBiY7jIjuJCRC1Ymx75kATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mxcd7MhD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9436B20003;
	Mon,  4 Mar 2024 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709568300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWQ0te0Hyhk01MW2THXCDBvNYf7CwmLuR3EI8Wv6l6Q=;
	b=mxcd7MhDgscxROkA6tVuMcPScoYCH/fwAuUbAKBhuU6E80Ptv9G79yo3iGho7+FmQd0T+V
	2SvQDzslyoOdlMzvaS6+1CX8+eSVamjYivtlCb6NP3UNsCNbtTRpvTkMA2KvowyOMgleAx
	jXuzXhWPEXD3CAUxeBss/zzawKYX4Q8ku2GfrrNVxKmUC91dli1qXIGHX43Qj272GQEoJL
	xMGV8VBsa+kDoySLqZDEbGe80tQhYR6zCJtJX2fk8jFnLQ+IGrbjQKWaPwuc4Y3ZDBojO8
	sp05lYzHdwt+gkscLhipll3lXvQJ4/1351U0jeQipNEDXNl/mbeWZ+zgXlcnwQ==
From: =?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Yen-Mei Goh <yen-mei.goh@keysight.com>,
	=?UTF-8?q?J=C3=A9r=C3=A9mie=20Dautheribes?= <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 2/3] dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00
Date: Mon,  4 Mar 2024 17:04:53 +0100
Message-Id: <20240304160454.96977-3-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
References: <20240304160454.96977-1-jeremie.dautheribes@bootlin.com>
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


