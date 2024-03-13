Return-Path: <linux-kernel+bounces-102254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0FB87AFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFD72866C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C2580C1B;
	Wed, 13 Mar 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SW0f0tlU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920186215F;
	Wed, 13 Mar 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350435; cv=none; b=eGZS6ESzPBU8G6X3VuiDT3Wc3oISXiZSR1F9+nAbXfJvhiuZPrHJcEX1WrjhNOfQJwbU9Ygwg2Ublb38VNSesi6IHXNLw//R9tsuh+W6kz/A5g8jXfCfgfMFzUo9qqTMK849QgpkPkoOiYYG9YPjsDsX9ckw8UR2p92hroX6xWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350435; c=relaxed/simple;
	bh=Rz+zz8C3FLdGhDB23gaUu1+rgqeKlBGZdedvkEgr6Nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYlQuLg8+ZAKFejrFCe8il45ZI2E3JLFGG4xzhaSGyXI4y+y8Cr6o1lEBraHI6siWbe3k4ACdsRZ0+9olR65BHxYkp6z8qgAah61Vqlyf55FgqlEpvoS7uZjSXR7ioBYcW+YVZNaocUYFiP8igqypPUNeb+Rp4GmHlOpSGkAGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SW0f0tlU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1685A60004;
	Wed, 13 Mar 2024 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710350424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02+yT9N9o9NKCFVvGS4oNEPEPi28XRrK0I0VU7hqIgM=;
	b=SW0f0tlUmoTxL3YcuWCoCYj7x9fNRSpY2dFPqyo+Kr9B7DIm5V/tKpYhRogx0nNVaa9MtS
	x1ls05UAqlVm1E27fMrAprcuCGUf5ah1YxwDAQwKvUb7k3tT2ywSQXxgdUbS7WzPRmavnn
	DFpujesRViUwsKr/ts+0wl35rr3O8QwWssXTwWjImAtTdNwnRQN0EiFUz11wNYr3tZgW58
	t/3mrHNOtQY5+K4TkCKeLtIlJFMbgcRZWaetB9m/DUJiOLFgN0bXlVaQtZZKInep5p3TVG
	6CdwMqvC6r2za3WsIciNoIHXP5plZ8m9oAxZKOJB3ckxV/8i1zSQ3rtNEk0oVw==
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
Subject: [PATCH v3 1/3] dt-bindings: Add Crystal Clear Technology vendor prefix
Date: Wed, 13 Mar 2024 18:20:14 +0100
Message-Id: <20240313172016.387277-2-jeremie.dautheribes@bootlin.com>
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

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
include "cct" as a vendor prefix for "Crystal Clear Technology". CCT is
the vendor of the CMT430B19N00 TFT-LCD panel.

Link: http://www.cct.com.my/
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fef2e12b504e..96e47742e250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -248,6 +248,8 @@ patternProperties:
     description: Catalyst Semiconductor, Inc.
   "^cavium,.*":
     description: Cavium, Inc.
+  "^cct,.*":
+    description: Crystal Clear Technology Sdn. Bhd.
   "^cdns,.*":
     description: Cadence Design Systems Inc.
   "^cdtech,.*":
-- 
2.34.1


