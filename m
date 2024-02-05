Return-Path: <linux-kernel+bounces-52793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB0849CB4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65209282CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8432D604;
	Mon,  5 Feb 2024 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu076dhi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94962DF9C;
	Mon,  5 Feb 2024 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142360; cv=none; b=QSM6yznwJSvxnwy9E2wuce3ph2AENXXtv1af+iAyZGATESRMkUmneQO00FZVoikoYJdGI76RO2gbwgAZ8donAPZJjPj9LHF+QWI4rCo3cwIh529AbI/7kZyQ342gg/+jh41ptfBrLTfR9Oc2CPZl3taGI1ziMKFGodkWteuQfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142360; c=relaxed/simple;
	bh=UaF9stSQq/i7PAh9QAvHKjDgSTByGyBL3jN4QH2nFhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eT4UcnUCH+7ziaFFpt0V6gFijSIvmat2R5EN78Zl1iuFrIR+CDhq0YCvd+9kpzkgsHSli0/DgZACVIScHoW4meOnXjoBOVz4pExqlxxIqrvunulBEMckbR6HXeXZsT9hk2Na74EhrrQurjlTzXG/SybjDFAJDZbR8zxXOdSZr/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu076dhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F84EC43390;
	Mon,  5 Feb 2024 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707142360;
	bh=UaF9stSQq/i7PAh9QAvHKjDgSTByGyBL3jN4QH2nFhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lu076dhi2j+OqgTuT2dkoP933tZGc8LJCDmZ0o0gbgiBRnLgaZJESaRRV9QPPFCQM
	 go7dEcV/hV/1YTeOK5EDZqjo5khm7bSO5rVnLAsP59sd+XLp5/JB4KRxJYvkSzT4aR
	 R8xNLFgtzLfgf7HgFotYzuBGEDCIJzDnaZRQlQaGpJmXsdRqnXDeFonnn+vfIVMT9W
	 R9Hu4OFjnNAOMpxQXLawafu5BGcMXZb6EXqVTj4XOVA6FnS2Uc49zxulmuLLgTOZba
	 pNvjf3N0a9BDqrSlGcWL2X1Xdj5OMjETxMvJPifWg3TNADkL64sy1Oc0omdBacLz/F
	 Hzb+yG9LJNZQg==
From: Roger Quadros <rogerq@kernel.org>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	afd@ti.com,
	nm@ti.com,
	srk@ti.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2 register space
Date: Mon,  5 Feb 2024 16:12:20 +0200
Message-Id: <20240205141221.56076-5-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205141221.56076-1-rogerq@kernel.org>
References: <20240205141221.56076-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PHY2 register space to DT binding documentation.

We use minItems: 1 as DT update will come later and we don't
want warnings for existing DTs.

So far this register space was not required but due to the
newly identified Errata i2409 [1] we need to poke this
register space.

[1] https://www.ti.com/lit/er/sprz487d/sprz487d.pdf

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v2: add minItems and update commit log
    
    v1: was sent as part of different series
        https://lore.kernel.org/all/20240201120332.4811-5-rogerq@kernel.org/

 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
index fec5651f5602..f6e6d084d1c5 100644
--- a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
@@ -14,7 +14,10 @@ properties:
     const: ti,am62-usb
 
   reg:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: USB CFG register space
+      - description: USB PHY2 register space
 
   ranges: true
 
@@ -82,7 +85,8 @@ examples:
 
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


