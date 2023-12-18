Return-Path: <linux-kernel+bounces-4142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E524E817865
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB061C21D85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527955D759;
	Mon, 18 Dec 2023 17:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UHXCC05d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A5D5A86C;
	Mon, 18 Dec 2023 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4136E000D;
	Mon, 18 Dec 2023 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702919783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/JBiiPIcaGWGpiu3Rs/BTmk4ayUoRtTYGad4NAEBvg=;
	b=UHXCC05d2ZYkUClMssjTFJSDpDgrw2U5K/edBjs+nyI/GWMLGBWhNRJlq/SofwBtfePXo4
	HGd2FIdQ88iL7pbmkCrBJLLAa6FdahQfCEE6dWtXLcrGDamwQ3pLQl23pHZ6BIwcBU/6A/
	mGq9XLDxXoawJHf6RzAS2W+MZm8JhtuSq3eKv/Fu4S1vRR5hocDrJEa5TV6eg1d7MRqrfM
	MT3gJEt4ETwis2iRLRISaH7LjvsigPEdoufasMDvh+BVJi9/ikYe0Cs12UoaDL4AY4PHXw
	xNd0pRF4q4hIS8wuqYeCsQE7mwDC0qcCwT2nL9HxgxItt3SQmJ2x0QlwesaZqw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 18 Dec 2023 18:16:14 +0100
Subject: [PATCH 3/4] MIPS: mobileye: eyeq5: add OLB reset controller node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231218-mbly-reset-v1-3-b4688b916213@bootlin.com>
References: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
In-Reply-To: <20231218-mbly-reset-v1-0-b4688b916213@bootlin.com>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com

Add the devicetree node for the reset controller on the Mobileye EyeQ5
platform. It appears as a subnode to the OLB syscon as its registers
are located in this shared register region.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/mips/boot/dts/mobileye/eyeq5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/mobileye/eyeq5.dtsi b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
index d32da8fabe5a..b7da037ef324 100644
--- a/arch/mips/boot/dts/mobileye/eyeq5.dtsi
+++ b/arch/mips/boot/dts/mobileye/eyeq5.dtsi
@@ -4,6 +4,7 @@
 */
 
 #include <dt-bindings/interrupt-controller/mips-gic.h>
+#include <dt-bindings/reset/mobileye,eyeq5-reset.h>
 
 /memreserve/ 0x40000000 0xc0000000; /* DDR32 */
 
@@ -76,6 +77,11 @@ olb: olb@e00000 {
 			compatible = "mobileye,eyeq5-olb", "syscon", "simple-mfd";
 			reg = <0 0xe00000 0x0 0x400>;
 			reg-io-width = <4>;
+
+			reset: reset-controller {
+				compatible = "mobileye,eyeq5-reset";
+				#reset-cells = <2>;
+			};
 		};
 
 		gic: interrupt-controller@140000 {

-- 
2.43.0


