Return-Path: <linux-kernel+bounces-36964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D69A83A98E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3C9BB2941D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4746313C;
	Wed, 24 Jan 2024 12:22:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AACD6310F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098947; cv=none; b=RlWAvz3ipUFSdlG9EOe+fO3eGIVtgVYeiRyhI3ePO8420z1EV7Pb9KL9PUWIVyJLug4iFBoTH9bOnA6up7U/KM5MV1Q0DtRxS5RgJ8wqyK7ajEm2366xrZo7aJ/Y5+I1hkCDQPbfiG05TVP9T7TRVuUG0Imp1IfNQhqsFfPzL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098947; c=relaxed/simple;
	bh=HHxbDfRuHjBw0BBMrvLJdWgyYMSpJ3v1+tlxqNpDDsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJMuNV5ZVOlNShni0bhb5XVBfNcqKS7MObi8eQUe7lvTmw6upHQhhdbHJh/YETMF22ovrJtVen9QGJprRWcfVbSEyckSaUvskBa8EtA5jiN4QEi3fLK25VEATbnBbfFUaG9TmEsL8dn9kaDxXWswC+QB5ksgM7WX0iI4gzSA6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGd-0007o8-1C; Wed, 24 Jan 2024 13:22:07 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGc-0023Ze-1P; Wed, 24 Jan 2024 13:22:06 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rScGb-00341O-34;
	Wed, 24 Jan 2024 13:22:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH v2 4/8] dt-bindings: power: reset: add bindings for NVMEM hardware storing PSCR Data
Date: Wed, 24 Jan 2024 13:22:00 +0100
Message-Id: <20240124122204.730370-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124122204.730370-1-o.rempel@pengutronix.de>
References: <20240124122204.730370-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add device tree bindings that describe hardware implementations of
Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons
(PSCR).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/power/reset/pscrr-nvmem.yaml     | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
new file mode 100644
index 000000000000..779920dea283
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/pscrr-nvmem.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/pscrr-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic NVMEM Power State Change Reason Recorder
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: This binding describes the Non-Volatile Memory (NVMEM) hardware
+  that stores Power State Change Reasons (PSCR).
+
+allOf:
+  - $ref: pscrr.yaml#
+
+properties:
+  compatible:
+    const: pscrr-nvmem
+
+  nvmem-cells:
+    description: |
+      A phandle pointing to the nvmem-cells node where the power state change
+      reasons are stored.
+    maxItems: 1
+
+  nvmem-cell-names:
+    items:
+      - const: pscr
+
+  pscr-under-voltage: true
+  pscr-over-current: true
+  pscr-regulator-failure: true
+  pscr-over-temperature: true
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    power-state-change-reason {
+      compatible = "pscrr-nvmem";
+      nvmem-cells = <&pscr_cell>;
+      nvmem-cell-names = "pscr";
+      pscr-under-voltage = <1>;
+      pscr-over-temperature = <2>;
+    };
+...
-- 
2.39.2


