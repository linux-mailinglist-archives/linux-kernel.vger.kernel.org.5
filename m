Return-Path: <linux-kernel+bounces-13026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4419281FE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93FAB2226B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B864711183;
	Fri, 29 Dec 2023 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="WwWQReAp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B410A07;
	Fri, 29 Dec 2023 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C256C28B538;
	Fri, 29 Dec 2023 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703841906;
	bh=2cwVTTHJN5btrCaPMvGl74zHSsIr8blS1pdlyCma1r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwWQReApL2OH68s5zu3HYymzkdnynrIRPRUnjGn7+F7Ad/yNrWEas7yq9KULPST0w
	 /ezr7AAQTNQgPfQ+805TEn5P7s1fQY074qIg09h9wb0SRl+zepGDpzVWo3hnUcsCSa
	 tYY4kiylYB+V7RPqpdoETY3uQumKAAKeW5ywZvrY=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH v3 01/10] dt-bindings: iio: pressure: honeywell,mprls0025pa.yaml improvements
Date: Fri, 29 Dec 2023 11:24:29 +0200
Message-ID: <20231229092445.30180-2-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231229092445.30180-1-petre.rodan@subdimension.ro>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define enum inside the honeywell,transfer-function property block.

Set the correct irq edge in the example block.
Based on the datasheet, in table 13 on page 11:
"End-of-conversion indicator: This pin is set high when a measurement
and calculation have been completed and the data is ready to be
clocked out"

Add description on End-of-conversion interrupt.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Co-developed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v2 -> v3 no changes

 .../bindings/iio/pressure/honeywell,mprls0025pa.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
index d9e903fbfd99..84ced4e5a7da 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml
@@ -42,6 +42,10 @@ properties:
     maxItems: 1

   interrupts:
+    description:
+      Optional interrupt for indicating End-of-conversion.
+      If not present, the driver loops for a while until the received status
+      byte indicates correct measurement.
     maxItems: 1

   reset-gpios:
@@ -65,6 +69,7 @@ properties:
       1 - A, 10% to 90% of 2^24 (1677722 .. 15099494)
       2 - B, 2.5% to 22.5% of 2^24 (419430 .. 3774874)
       3 - C, 20% to 80% of 2^24 (3355443 .. 13421773)
+    enum: [1, 2, 3]
     $ref: /schemas/types.yaml#/definitions/uint32

   vdd-supply:
@@ -93,7 +98,7 @@ examples:
             reg = <0x18>;
             reset-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
             interrupt-parent = <&gpio3>;
-            interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <21 IRQ_TYPE_EDGE_RISING>;
             honeywell,pmin-pascal = <0>;
             honeywell,pmax-pascal = <172369>;
             honeywell,transfer-function = <1>;
--
2.41.0


