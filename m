Return-Path: <linux-kernel+bounces-135638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52F89C8F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84B9287734
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B01422CA;
	Mon,  8 Apr 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBY7bN+a"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74871448CB;
	Mon,  8 Apr 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591611; cv=none; b=J5XF+nGUJlXr9uN50u62LoJjo0IVfTmh0Utw9HZp8BzhtuR0zYPRfkpRVz6DWS8Y4Q09sXmdXKAfUUMrh30Waatrs/Ay2CGupYXoz05w8XOwnuyf602cSL9mUyHB+qliMMguMxdJ1Vy4YvdzZFmztcZJR7drrDzPu58vvJm9jUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591611; c=relaxed/simple;
	bh=AIsscuJi094OEVGSsAf9Wlesp0w/0ZWJH8OIPmC6tCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HrC6h4dkq6gr1ogsA5dHjv+PBZ9DASd+qfncy15Rv81EYjKmzFLyMh+5iD7rr/PVOQQXh48CELhVLb1F1qmVbPviCISww3Oioc2EYg6x8s7hme8nQWqhZfrOMVkO0o5ddRxdeW4rrJ2ppTCaFI7sOxbJPC1fCOTcMbkkUKFeNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBY7bN+a; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46a7208eedso682007766b.0;
        Mon, 08 Apr 2024 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712591608; x=1713196408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y7DfeV8VLm+4dkW5onFx6zdkwwBWr0ksWuO3GWgBgU=;
        b=aBY7bN+aNSCU4NkeaB8X0zE1pW5E+J4HQRxJpuX0HrNYVl5rFgdcGX3cZm/K4D4Tea
         4nyYwzQKjMA1jRkiA1xsxc/JQ9Z3PdDAxwQGnsfTBLOZCwXgL2uDmz9282jcxQTpFDPH
         cguEp3Kns0C1iR35E/GnlIXf4BUmS3EIqa6CkScF9FCijZ3ES4WM5won+ODaEOhHKllN
         bQ0eQqiQ8Bn/LH62t+g0G04yfSTfNNUSGUkfTKwPkHA/s0z60AywDKRmBK152tbxe1ST
         mX18LJ6zQZ3o8P2WUDs1am/9ngNOfVz750bgnQCc9ShYvUrYHfumhHmnVeV/DqaVYkHm
         /JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591608; x=1713196408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y7DfeV8VLm+4dkW5onFx6zdkwwBWr0ksWuO3GWgBgU=;
        b=tLgFq8TMEnqn6AxEjYxhiYcDJuiHvY8Vva7GcJX9UeUU+pzybixQgx8by9iaTecMPQ
         tm6RWl+BAvwkUiJIWyVJwgQDMRhfAZaKhG0/6jQLy91NamnHb6PaoVU1vhG3+RL9MSGa
         eQDxsddqjlUF42A0dsy0KieetPwwDIJPjIad4/5KRXhUovSAHMsrayOJa6GZ/rjaI0/7
         fwbYX8LvOYax0h37xhIPO/2npyRiWRDru7dUKhT/Aeo4PH/fV+qJIUfmz1z54KVA+gcD
         PoKSdtBizvYSB80gHB5xZs/dm4AcWDT8xnMvx893M46vDzeI5dTpzZ4/2FtPi6HePcH6
         EaBg==
X-Forwarded-Encrypted: i=1; AJvYcCUqyqLkPDgrjnCYTzbf6Q+AS4IfvAMJTtrxovzrND1a0Ukpf6dMtYGj3p3KS4gjDMoQdo4uGKiYnyBVeFL2FDIB/j1pwsb9yZ63sJiaj06DspZQ2gFQ46mZ593cMcmq7x+sv/ANkZpR7w==
X-Gm-Message-State: AOJu0Yw+9A8Y0VzMQCeGhA84/Qg3j7J/C8+oJhe0ujgUJGHxFIwHrxTe
	PzzWFAZI0N7clKaG15DI+z9KBS29mXmWMhV/LyFaDz2d7Zivg7bMDLqW7haDFtwPSA==
X-Google-Smtp-Source: AGHT+IGdfX/y51Nks6qsHsv5sXslTDtqdDAyN1/b0esXW0O17PcNWR7tUFhV60oXtdma+8MhUzqNbQ==
X-Received: by 2002:a17:907:3da8:b0:a51:dc1f:a44b with SMTP id he40-20020a1709073da800b00a51dc1fa44bmr1941414ejc.29.1712591607822;
        Mon, 08 Apr 2024 08:53:27 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906794d00b00a46a2779475sm4547849ejo.101.2024.04.08.08.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 08:53:27 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 08 Apr 2024 17:53:08 +0200
Subject: [PATCH 8/9] dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-rtc_dtschema-v1-8-c447542fc362@gmail.com>
References: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
In-Reply-To: <20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712591586; l=2964;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=AIsscuJi094OEVGSsAf9Wlesp0w/0ZWJH8OIPmC6tCw=;
 b=SjxANSNsLql56s4aBhO5sITwOL73aDDWw1tzYNIUF/EDIaC42lzFW9WBN+FJIfBZhJZSJUWG5
 L8HyqJln2diCnF1A3y5vZJJOTZpEnbK/pWIrvAK7sqt7PRQjR8fDhvQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Convert existing binding to dtschema to support validation.

The 'fsl,imx28-rtc' compatible is currently not supported, and it is
only referenced in this binding and in nxp/mxs/imx28.dtsi. Therefore,
that compatible has been dropped, which triggers a warning when testing
the DT against the new binding.

There is another reference to fsl,stmp3xxx-rtc in nxp/mxs/imx23.dtsi,
where another unsupported compatible 'fsl,imx23-rtc' is used, and the
same problem would arise when testing the file against the new binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 45 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ----------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
new file mode 100644
index 000000000000..bf70cce2701f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,stmp3xxx-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMP3xxx/i.MX28 Time Clock Controller
+
+maintainers:
+  - Javier Carrasco <javier.carrasco.cruz@gmail.com>
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    const: fsl,stmp3xxx-rtc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  stmp,crystal-freq:
+    description:
+      Override crystal frequency as determined from fuse bits.
+      Use <0> for "no crystal".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 32000, 32768]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    rtc@80056000 {
+        compatible = "fsl,stmp3xxx-rtc";
+        reg = <0x80056000 2000>;
+        interrupts = <29>;
+    };
diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
deleted file mode 100644
index fa6a94226669..000000000000
--- a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-* STMP3xxx/i.MX28 Time Clock controller
-
-Required properties:
-- compatible: should be one of the following.
-    * "fsl,stmp3xxx-rtc"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- interrupts: rtc alarm interrupt
-
-Optional properties:
-- stmp,crystal-freq: override crystal frequency as determined from fuse bits.
-  Only <32000> and <32768> are possible for the hardware.  Use <0> for
-  "no crystal".
-
-Example:
-
-rtc@80056000 {
-	compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
-	reg = <0x80056000 2000>;
-	interrupts = <29>;
-};

-- 
2.40.1


