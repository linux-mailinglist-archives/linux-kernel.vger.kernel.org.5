Return-Path: <linux-kernel+bounces-48070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664B8456DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE032908AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E315DBCA;
	Thu,  1 Feb 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdIwrlDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC873161B78;
	Thu,  1 Feb 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789035; cv=none; b=ECeQ5PwNaKasskbnjDPz+lx81oBv3OvnCbE3I3m79FltD5+w0tzQEFAio/Wwvg/9y2rF3xbM6LN4ZL+q4wrd7qiy9D+B3iwUOpnMFgENnbg8lcZC3IzXOkLmkfnvDoSFZlVBf896qASSlpx2iZxUseztdCVI0suR/Blz5hNMFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789035; c=relaxed/simple;
	bh=QKijxRowyGO0xEY4A0DhY/KjCBbcM53bJ5KIE6470MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q0/XAgRBI9nAhpb/AO718Db/tgaDJ7NXfeDa+trydEn4HV/xRecuoA956c3cvarqDBhM/kIpJAS0gCrsykfG11aKUgoq9DFYOOBrUxi9xpgnjtDDpfEnfDaOeSVrn5pRbS0cJEd9Z4w5YU3mRfjCArV/XeGZjyFB5B3YFNBnpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdIwrlDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0A0C433F1;
	Thu,  1 Feb 2024 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789035;
	bh=QKijxRowyGO0xEY4A0DhY/KjCBbcM53bJ5KIE6470MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdIwrlDG2R/idRf95zUqsnK6Ec6+IwG1/0bseLHGuo57Um6qSWBLYt8uELe8vdSgY
	 r/brkqwMb5Qm8WN6U9VvlLMXQPCRSgEUOrSf1vF1UlpSGNU9bqqQ59tc8MbAjKAG2I
	 +AWjC3l/95d9z3Y3lX//OsmvXBc395rWlbZmD0kBxV7hqxWgI2wU5KEgkVimCiExmc
	 3cuk7G5j4kUV71PtWGvkLp4UCizYlLbLSYPzYB2tI7PSgvcE3jwABMZzw7e0ggl/lC
	 NUeJdrBGPKtzCZ7O3z9elcGK8h7TU2VsfrjFCTLH4kki7tkRhdBuNOYNiHxjU13a+6
	 3aS5sH3KzsntQ==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
Date: Thu,  1 Feb 2024 14:03:31 +0200
Message-Id: <20240201120332.4811-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201120332.4811-1-rogerq@kernel.org>
References: <20240201120332.4811-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far this was not required but due to the newly identified
Errata i2409 [1] we need to poke this register space.

[1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v3 - new patch

 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
index fec5651f5602..c02d9d467d9c 100644
--- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -14,7 +14,9 @@ properties:
     const: ti,am62-usb
 
   reg:
-    maxItems: 1
+    items:
+      - description: USB CFG register space
+      - description: USB PHY2 register space
 
   ranges: true
 
@@ -82,7 +84,8 @@ examples:
 
       usbss1: usb@f910000 {
         compatible = "ti,am62-usb";
-        reg = <0x00 0x0f910000 0x00 0x800>;
+        reg = <0x00 0x0f910000 0x00 0x800>,
+              <0x00 0x0f918000 0x00 0x400>;
         clocks = <&k3_clks 162 3>;
         clock-names = "ref";
         ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
-- 
2.34.1


