Return-Path: <linux-kernel+bounces-32998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F9836302
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C228943D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4E3CF7F;
	Mon, 22 Jan 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0+1BfKX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF0F3CF6D;
	Mon, 22 Jan 2024 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926021; cv=none; b=nWb7LrfAbtMJLhDA5d4WcBp0aOEiAm8XQfKht5rbUwV9j6Y1SD/DvSbTCnhqGl40vfvHe97G0GJJSLG6bSdYeqSBU7NbdPE6bGUgQxnRzraU11MwS9FCeRItfYsmyzb7buacZL+jOLdvvo9VUtgYiE+SywzHpQFZfsqYnqr9CFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926021; c=relaxed/simple;
	bh=8d4o8b6w9hvJ+ehL0Gmci/4wXJY8BAIb5BXSCLU2izA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5VTJju5Ykz8qBxS4LA7nnEYHHKMsiYVEhdoO1ryGqUhHQuS25dMGsk2hOcd0ZZAD9BlaCyguQzLx0IoPVW0YyFeSoPdoihGQFY0bTBi8L0DYrdC3v2xSAyCcSPYyRK7kaG46MihSZrs++HXxYDYqLr9BhUx/BQtyg30Zn48bhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0+1BfKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AC3C433F1;
	Mon, 22 Jan 2024 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926021;
	bh=8d4o8b6w9hvJ+ehL0Gmci/4wXJY8BAIb5BXSCLU2izA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0+1BfKXT/Q3WTcV0v6zrkcMPc7AkN+h+88/RrAqg+eqV8RBIoaHAbJhpXzXjsRsz
	 GJl3f+fXohP8flUgMqa9BI4qS2FBiQ9dyCT4MvEbvcvBLz3u48iApRltaJxIKcKMrK
	 9s1FrXOCnW9axnQEJMkr75lPaYRkKQTCmI+xxYau+xQc/4XB5+WF01JEY4lrXX+IKV
	 eavw9YDFVtmp+zwwdxyUgPDl3objzuoXbGs+H2/1C0jlbk48f0OhDcG009hXW903xf
	 GVGQm0Mako7Pxixm/wjC2jBKo/FIiCqLRZum/bT05i32Dd8POLYXCJuaL980eBU67u
	 0o+hXceniIHhA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: can: mpfs: add missing required clock
Date: Mon, 22 Jan 2024 12:19:50 +0000
Message-ID: <20240122-breeder-lying-0d3668d98886@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NrajZ8DKLByCJYLOG7gevyAp2euhGy7v9GQJAOxw45A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlPKSnQ17k1J/f3WvmYO46S1vI6Zc+PX+eiHL7mtm OS1+1xcRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACay9Bwjw6rOzD+StveFa45F 3lLZYsjaYnNviefhqQbpbO5Pw4zdvRj+xxjJuMotUOz7uJhffcfz6Q+9jdZdWXft3VytDs0X8uH qLAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add it.

Cautionary tale in adding bindings without having implemented a real
user for them perhaps.

Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 45aa3de7cf01..01e4d4a54df6 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -24,7 +24,9 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 1
+    items:
+      - description: AHB peripheral clock
+      - description: CAN bus clock
 
 required:
   - compatible
@@ -39,7 +41,7 @@ examples:
     can@2010c000 {
         compatible = "microchip,mpfs-can";
         reg = <0x2010c000 0x1000>;
-        clocks = <&clkcfg 17>;
+        clocks = <&clkcfg 17>, <&clkcfg 37>;
         interrupt-parent = <&plic>;
         interrupts = <56>;
     };
-- 
2.43.0


