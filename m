Return-Path: <linux-kernel+bounces-59782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E390484FBB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B73C1F24015
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D6980C19;
	Fri,  9 Feb 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SUBofVAJ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9676030;
	Fri,  9 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502716; cv=none; b=oX/1U8jFqT+P5QbR7L9RBlJJ+gAm0YFNKkacm+wkuW/380UG1QcRb/ygVm40bgNhJPdWtSB4VV5p/x2hrmsmlbEp4eGi/FSWGcUPRRsHklI914xMWSkYe2bvGh7F0x3UFXHvc1im8uSP5q6LgnoDrfWKO7PRE4iaPq4GublY9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502716; c=relaxed/simple;
	bh=QanVdLZGJsZiEBFc9AV6ugIOyYSeeb2yQCO75yW587Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klp7R1u6Le1LeJhwXcGqArDOs8XTKSY5QY7US8P47MQXY10KsCUM64EkkirThvMNFpHv3WzB83CleRzu3tIOR6Kj3BWK4sFu2LuONfFI73AsTVr4HxwxSY2Vdqst5f1rfR7Iqin4iM9cPsxtFCCE/Vwf/Ft176cP8KJrofUj8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SUBofVAJ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707502713;
	bh=QanVdLZGJsZiEBFc9AV6ugIOyYSeeb2yQCO75yW587Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUBofVAJYhLIPTU4SWQQMESBw2uF9Wo+TwBi7QQULgFyvr2J0/R7SsYfupbPU7YWc
	 xb+QlBUWXwy1E4xEll3JGh0z0FFe2gICJfPkPDXopEHVkAPSK/BRC2Qj4SfTgI3aNC
	 iL7MRClT6b6LLv4HOzZFXzU5utyFGKy2XS0JuJHxJn42U0Ur8c85PTGyMHLmCgialG
	 cYXPhiL6bUnKtyFhhOfnRqde1ef6wlwqv7Q2cw59ERcIgXootWZXTN0YKX2hwIXMM4
	 gGZeoxwrN6gjYrIDVOgpclvQClFy1t49DdLtyL0d+kEOnP6s4su/9qmMNsXKZSM6ip
	 1XsaEAkp4FjSA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6AA03780F7F;
	Fri,  9 Feb 2024 18:18:32 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8DD1A4800CD; Fri,  9 Feb 2024 19:18:32 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 01/10] dt-bindings: soc: rockchip: add clock to RK3588 VO grf
Date: Fri,  9 Feb 2024 19:17:17 +0100
Message-ID: <20240209181831.104687-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209181831.104687-1-sebastian.reichel@collabora.com>
References: <20240209181831.104687-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 VO GRF needs a clock. This adds the clock to the allowed
properties, makes it mandatory for the RK3588 VO grf and disallows it
for any other Rockchip grf.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/soc/rockchip/grf.yaml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 9793ea6f0fe6..20bc1f46384c 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -66,6 +66,9 @@ properties:
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
@@ -248,6 +251,22 @@ allOf:
 
           unevaluatedProperties: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-vo-grf
+
+    then:
+      required:
+        - clocks
+
+    else:
+      properties:
+        clocks: false
+
+
 examples:
   - |
     #include <dt-bindings/clock/rk3399-cru.h>
-- 
2.43.0


