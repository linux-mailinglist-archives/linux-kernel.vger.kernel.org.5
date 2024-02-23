Return-Path: <linux-kernel+bounces-78411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186C86131E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEB12847B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAC47F484;
	Fri, 23 Feb 2024 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C0VY++6Y"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D155DF00;
	Fri, 23 Feb 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695926; cv=none; b=iGI6LgrOTty5gjdp1PYM+6j7Su9tNocwr1Lwtes+tmRuFZ2JT5dEIDfVgA/dsg+/cVkM8SCBzf2v6C06qt0twyUEZnBl2/g+vi0KOzjGyP4EreknCH9CeJuAWo2rZsIkGjo73D9dRuuZFIcZgUobjvrz+G0sqWkEpUNLUtTSJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695926; c=relaxed/simple;
	bh=G8BObZilN9ZUfQ5ynYEVu0voEcIRfETil+vo7SkIEQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rdg7rZcJV7NId6g6GBPoKNnp821TGbhjSSwcU/N2JPsc8MM3mIkf/M9qobFH2GLuVXvF+x1rwdHj6DDk881PdkTewZ8rCo0ZPp1Ne0WDg1xbVHFFm5kDjlpsUX/pb8aBMiHA7ZnvFIpmrpHjDOlHiSHrvT75cGjWxvdT8wstbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C0VY++6Y; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 585B5240004;
	Fri, 23 Feb 2024 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708695923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho0KG0zC9AsXPslehPT0ynCoF8Wo5Q+iI+TvHcw7G+g=;
	b=C0VY++6YT9AAb94Tl+hc5gcWdRTVWqOJsHSuM2kpMxBT0FudgCcuJigYnggGUXRdEhUYAQ
	1oeYISw+5NEcx9MTNQuj8BdnxP7wplH02NxKcd/5V/URPEWSdxaugJZ+0f3yEaWe/inSSv
	hGcdETgl7GjpDp/SEbCReFMKBxgYg+MOWpFa7ATXAtsFtKftai+bVJ7h90BwUmtNa/uoWR
	gTR/NkGvEwhOFG5kb5ku4r6iNx2SjtPWsFKTqV+nuRGs++1fUtiOyEZbq15cK/hfkNuy9m
	3rrJff7lrMCm6gWQUzWn9v0GqagSRe5ZozaZ7SIws/JvvPiBhNjSpUeqMGi8fA==
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
Subject: [PATCH 1/3] dt-bindings: Add Crystal Clear Technology vendor prefix
Date: Fri, 23 Feb 2024 14:45:15 +0100
Message-Id: <20240223134517.728568-2-jeremie.dautheribes@bootlin.com>
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

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
include "cct" as a vendor prefix for "Crystal Clear Technology". CCT is
the vendor of the CMT430B19N00 TFT-LCD panel.

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


