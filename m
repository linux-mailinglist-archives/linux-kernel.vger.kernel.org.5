Return-Path: <linux-kernel+bounces-78412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77C861321
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D628284AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132A80629;
	Fri, 23 Feb 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KsgUixcB"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F8E7EEEF;
	Fri, 23 Feb 2024 13:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695927; cv=none; b=enzthKosLfKwXC/KMFRTv15OI1eULJTpUSgtl+0a1DQESKwxsuUDY5NIchtknZEqVgYQuUtCrtqFXI4GHr62Od4/NIZie3PIJlk2sxcw6hwhveR5ooiSZkObfJ5pNFJW9PKLOe3mEPAugCaNeC8zp2q3vn6bMiiXx5X+3JzKniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695927; c=relaxed/simple;
	bh=IQZJrynjmNkRwbD/swl17Nu6ar2/DgqZrKdijF57wmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XuPuupy5NGcFoDq4n7FbMsriNHgnzDJnM6ZOVdVlT50LIQ6E1X4QAhOaEjWzc9ip3D+/8Su0Hy4jWWEVKE37400abkvcmVmLNgG2YuFFLwOMVxpgczfFwi6JoqNUoLXz25B+NQq8goas6RroNnBeTXCSQGn6Do+9HoR+4pis6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KsgUixcB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24967240009;
	Fri, 23 Feb 2024 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708695923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LWQ0te0Hyhk01MW2THXCDBvNYf7CwmLuR3EI8Wv6l6Q=;
	b=KsgUixcBBA8LtzK/rKWj5KS+6947RzRGAp4+cxtTtVY4gY5YZWX7KYfHY4ewB6YYtDWj0n
	qIXdAuxDOBSNqmJhAJCj6mxhkbsvYzlxdau07LVVdnsMRf1XdQbIF7nTb645OqcwXB/vBD
	+QmKIPJSundYyg9dyGSdnuXh0asS7SYG4ivSDbgEJqgIVuXjf8296lT1wN+XSj6HD+ZLqy
	4rUAIVn99o3pyGXCKzVu63pVVQsY2eDdT6fYYEBwVVtCdXfek7du7v2RTT8pUpy0nM3LB5
	xOqY5hmjheLTLOwwr2dNDkBPLwu90adG9k0I82FkPHN4K7aAmgN6wdUMSVEubQ==
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
Subject: [PATCH 2/3] dt-bindings: display: simple: add support for Crystal Clear CMT430B19N00
Date: Fri, 23 Feb 2024 14:45:16 +0100
Message-Id: <20240223134517.728568-3-jeremie.dautheribes@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
References: <20240223134517.728568-1-jeremie.dautheribes@bootlin.com>
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


