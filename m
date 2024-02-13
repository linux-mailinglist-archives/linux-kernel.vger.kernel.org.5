Return-Path: <linux-kernel+bounces-63898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07385362E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7928F28CF55
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB75FBB3;
	Tue, 13 Feb 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5MyP6xmq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C01E53A;
	Tue, 13 Feb 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842175; cv=none; b=IfYH7RmQfwFSL3vyqXodguGXKDDQvWWNpleZx/Nd8G+sfmk96Ks0Vnk69IdwfGuf3vc/BP1Y8YnXPB12legnNUhJt1uBLNpqnjll7oCSVM65qicoo4L439J7WNnES2dRXqQN/r3lcvuLToauDTCHEQZmOEXwWztOQPsH3QHyEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842175; c=relaxed/simple;
	bh=K950Xkvfyz4ijLJ0v9Erb08jeYAOV6dFtvqKORe/kmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv6CGFjrgYeLj/gI72WELzrfmJQxPXmSDV5pNQ546prBL4mls/AY58tOJ+Y0HSSFuisN0Uxwv96lDZrQtsO6E0O38xoTBCztI34WwrVlMYCFl3oOEiTVLdpgW8ugoucCYbFcYFAv0HMngAMVI7GtJnjz1zm3H358iejOGN5P4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=5MyP6xmq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842171;
	bh=K950Xkvfyz4ijLJ0v9Erb08jeYAOV6dFtvqKORe/kmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=5MyP6xmq4XvdwZY7E20AIkoS8RHhQ++fUPjOj/QxSlkR4SEegj/JSQKxBYaYl0pW0
	 7+66XYGurAjdtwl35nAQSnEWuGC9Jug+IFBQH0037ncbUZwHqieXPg6cw1WGJo8I9q
	 JSNNwPOcTwkdiPNR9zVgb4r3+/hes00T3wdMDTzuKMPV0f1eeffstYovvJgo9HXZew
	 qkWKfzIVmRQgejXebxBeJONyyTFlro+r3D0lOicCizNzmPZXxJSKBOSx4/ZGAHXq8b
	 BHfWAb7BVSrD4wolqa72ImXvTLVkUbrBly4XnvjtdBYLQfKzrfGSVdf3AUXObozpuT
	 7srMi0Ozz4zrA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5987A3782043;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EFA5A4800CD; Tue, 13 Feb 2024 17:36:10 +0100 (CET)
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
	kernel@collabora.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 01/12] dt-bindings: soc: rockchip: add clock to RK3588 VO grf
Date: Tue, 13 Feb 2024 17:32:35 +0100
Message-ID: <20240213163609.44930-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


