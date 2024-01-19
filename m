Return-Path: <linux-kernel+bounces-31191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6D832A52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FDAB22D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE052F7D;
	Fri, 19 Jan 2024 13:25:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90760524A8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670739; cv=none; b=DThGHMWFi9SWB59cdbaVgrjGtgHC9cLm5lAjgz1mttTa22kSpI5JsES/UHj27qMpKsUFK3gp5NTC5E2OAFtEZMKDUTD1eZFvAn3H9gzACHo7co7TAyunnggKMgm8gjKsL4pK24hNG1SJSWizqxa0QqcfrXnxXFIrw+h5hhCdoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670739; c=relaxed/simple;
	bh=y/hGCVajOvX8o6Efi9UdqxsGrdX7qFeQ/WFMS56UPW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKSlxai51oZojz9oewuurJd4iMd1NXMdS5lAwpfzEc82LHoFKI06L1UfYztl0MrLONluEicQruiUcxZDKWV446L1fHEdjMhMDKK/GJfvHNt2Y6/dFgq3h1/BTfzl+etSDT7bROTbtvBN3QDIpEnG8PLlkRuF1BfHHfPh62596Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos7-00074H-C1; Fri, 19 Jan 2024 14:25:23 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-000viI-6t; Fri, 19 Jan 2024 14:25:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rQos6-00F981-0Q;
	Fri, 19 Jan 2024 14:25:22 +0100
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
Subject: [RFC PATCH v1 3/7] dt-bindings: power: reset: add bindings for NVMEM hardware storing PSCR Data
Date: Fri, 19 Jan 2024 14:25:17 +0100
Message-Id: <20240119132521.3609945-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119132521.3609945-1-o.rempel@pengutronix.de>
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
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
Non-Volatile Memory (NVMEM) used for storing Power State Change Reasons (PSCR).

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/power/reset/pscr-nvmem.yaml      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml

diff --git a/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml b/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml
new file mode 100644
index 000000000000..0642b470af41
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/pscr-nvmem.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/state-change/pscr-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic NVMEM Power State Change Reason storage
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: This binding describes the Non-Volatile Memory (NVMEM) hardware
+  that stores Power State Change Reasons (PSCR).
+
+allOf:
+  - $ref: pse-controller.yaml#
+
+properties:
+  compatible:
+    const: pscr-nvmem
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
+  pscr-unknown:
+  pscr-under-voltage:
+  pscr-over-current:
+  pscr-over-temperature:
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
+      compatible = "pscr-nvmem";
+      nvmem-cells = <&pscr_cell>;
+      nvmem-cell-names = "pscr";
+      pscr-unknown = <1>;
+      pscr-under-voltage = <2>;
+      pscr-over-temperature = <3>;
+    };
+...
-- 
2.39.2


