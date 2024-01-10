Return-Path: <linux-kernel+bounces-22526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D0829F04
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAAB1C22944
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101344D596;
	Wed, 10 Jan 2024 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Q+R50F5j"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF24D105;
	Wed, 10 Jan 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 27AF6295116;
	Wed, 10 Jan 2024 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907393;
	bh=JR2K1BGHxcrEH+xlbeKvVMsrrRoi4/Miv25LV1xkXWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+R50F5jAAkGNV5MXSZqLkl4o0OpmvSKhAdLA4tRMfd/7asJONo/36bTmpWvHYbBE
	 IouYktqbeh9Knwqp26O6aVbhSdp1mEexnlVj5CLq/BDwIpIFiSH1YRw2A7kujBWfp6
	 mKb2fmRzPhfw55g0Sxqk4BEEHL/WkwW8Y/z/3vMQ=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 2/6] dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add sleep-mode
Date: Wed, 10 Jan 2024 19:22:37 +0200
Message-ID: <20240110172306.31273-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240110172306.31273-1-petre.rodan@subdimension.ro>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sleep-mode property present in some custom chips.

This flag activates a special wakeup sequence prior to conversion.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 .../bindings/iio/pressure/honeywell,hsc030pa.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
index 89977b9f01cf..350da1d6991b 100644
--- a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
@@ -86,6 +86,15 @@ properties:
       Maximum pressure value the sensor can measure in pascal.
       To be specified only if honeywell,pressure-triplet is set to "NA".

+  honeywell,sleep-mode:
+    description: |
+      'Sleep Mode' is a special factory set mode of the chip that allows the
+      sensor to power down between measurements. It is implemented only on
+      special request, and it is an attribute not present in the HSC/SSC series
+      nomenclature.
+      Set in order to enable the special wakeup sequence prior to conversion.
+    $ref: /schemas/types.yaml#/definitions/flag
+
   vdd-supply:
     description:
       Provide VDD power to the sensor (either 3.3V or 5V depending on the chip)
@@ -140,6 +149,7 @@ examples:
             honeywell,pressure-triplet = "NA";
             honeywell,pmin-pascal = <0>;
             honeywell,pmax-pascal = <200000>;
+            //honeywell,sleep-mode;
         };
     };
 ...
--
2.41.0


