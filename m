Return-Path: <linux-kernel+bounces-61787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BCF851685
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F96A2874BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51B3D3A0;
	Mon, 12 Feb 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g66FBhGd"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDCA3D0B4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746626; cv=none; b=Vtk/WVDyA2Fjrfr1mrKMBaPPcUKQF2YHjjRTGTxFG/srH2lHaPrp6R22td7CePznrGB7UXf3edkRDMKt6GAlwtnwGI5RoGWVA5Hba0vh3iVNoJFb/vMetN+ERHBeyOzxmh7PiVlSngjVHO8Whn/Cz2r26P1WuESI4w1t0DWN99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746626; c=relaxed/simple;
	bh=Hi+AYpj4IQjYK7Gxuv2V8sKTS8H17ViP7cxbuRFgK6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMhgkdn8k5xnX/SPbIFsTenBxIY5Qyap7YowXt3dxaxvNDt5GLN5WjMKJZxyzndEMi35Cv/v08UwT978OvFlKHnnHl7sJlWO8hrJ0ZTnDSHsx4urA5Khrj2iwZvjmG6XYb6L6NvlFi2265aKzHaCQ1Z1/eCaRru9HvlGzJAVfYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g66FBhGd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b815b182fso684984f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746622; x=1708351422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQjx1BYq38FUSUDdH+R5TkxMe5lYPMpuxbAcZUZM76E=;
        b=g66FBhGde5ZkjVnf6WsgiGuhLz14oF5pvl9gDE9OHU74RYA5qODAL7fTTOOsHUQmZr
         x8C/ZGchsPt3VO7GwC7MJxQzO65gFfeJHflq1W3tMFxb6cnf4137vT35/pO5q4ZmAsg9
         hpbfMUKQeUQ8ap/m7j53WaVcCahlJaIm8+5dsnefp0A4Fgz33TM4sdNbocxS8crNJiEe
         sb6GozXrGF4dw0FdfpnQRQhbF4KHO0bMEO/3KflJibbSAfDQaLQ756UPWU6w6xIZOC2C
         TQN8/wLORrRrpvwan88GazGefDBx1gcpXITer8NMNG+/IUf+rmGekll9mf15EHuDMx4z
         dwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746622; x=1708351422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQjx1BYq38FUSUDdH+R5TkxMe5lYPMpuxbAcZUZM76E=;
        b=u3iiBrMvTjoQwG1Fd+4NY10An/i+b3ZUDtWB2XoH2O2T1XM6e+qbL0QpBB/jA46PW8
         RQ3bwhAOpWQbqqq5U7Y2jlzEVJxPWCIc01g/Ihqq4CjpN4fhjWFBEuLMwvGqvvK4tDAS
         D6D6jgKd3DfF24plfwPbuEixy20Mc2wUQ7jdQEpy/vfoeR7qxAMCbaZVIbo6D0Xj2rRp
         +otzkDSeCxDmftUjAeYKv/6ONULFVM/EdTPGSgWMiqwj9oDW3apcbSUxYs66xbA4MYZz
         CoD3clltq7vtlAjgLHEQ1dAlTXC6UmVjkOj8mC4Ev8+/F868eDnqy/ecWGKnvYxOBhTz
         RfeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtp67KLir8g4n422qCuF869GXWkJ9/yh8nCvKX/hJYtWGhMuwNZGuRn0Fagb40Bv49yOV1RKC+ZZ1OXKAF8xdrLKNJkW7YQK6v4iYY
X-Gm-Message-State: AOJu0YyUuBTm4fkZrMEynNjZqZUQHNgmNl0yYVMAEMivohMcv/D6pB4z
	ppMIZs3s9utg/Ofbo1iBXQFGqYTyRtKB0rrBAbzWfS721TdhdjkefnbHBuvzsI4=
X-Google-Smtp-Source: AGHT+IGs6G2Dbixj4ct++RiAZaNlcAeFF+x9n4s/dYsr3NslItE/eDQWdXtV2mgcSiooqR1ukZaFbg==
X-Received: by 2002:adf:fb48:0:b0:33b:1823:284a with SMTP id c8-20020adffb48000000b0033b1823284amr5807851wrs.14.1707746622602;
        Mon, 12 Feb 2024 06:03:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0s1LuCBYrQfPi8TpB7Zi643w8nhk9MWn8/7690ls8R429+G8WviCV2mw8rEEOPiRXLeb6KBSVYdmxtEk0ZM5JR75szSXHuOfyOalc2rXUjEJGAjoKeRSu73I+xkiL7utx1bXJT1lpYp5pPZbhRltaLKksxN3uBwcmOCuoPEobd8b78gFVdXFh274nBi49hMoKa+rxCCyBl5a417sv4lTCBwRqpc8QyODjEYExQqE2NN3c/lmVAfXORcAEKUgs9JoGbN36vFGqY1Zxd7W3ukTFp6GR9mislxOyXZ0hDZZfz+i7eGuMVKt8owbrT9jyFUvMsuXJSYrh862UNEMJs8GtNaZsMY1qsJB73VdSOnL9qI31TTxN9kBARrr2/7gWaVVbG5WdfdIG8ax5h6qRlFK36XOwWh9Q5UapDCB3T4iu3Zr41DBaIT16H4UBjwmwaTKa8ulXn622/1aCGE8Sm2/MmhDqGhk/3tfpYbiUuKs0NDozV44B32u+rcKNvzjldLiYiNIQD/vskN4nX+ZGIY+jLUqXqJw9gxokfkgbRRo9JuVV5onr2uyAdjrBreLuAkAFKLT9cToxyJRvZ/bQ5dKiZ6VbLbLKqGfLD5F/0Hoo42w9yyc=
Received: from ta2.c.googlers.com.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d4b09000000b0033b843786e1sm2135356wrq.51.2024.02.12.06.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 06:03:37 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	robh@kernel.org,
	andi.shyti@kernel.org,
	krzysztof.kozlowski@linaro.org,
	semen.protsenko@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	devicetree@vger.kernel.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 01/12] spi: dt-bindings: introduce FIFO depth properties
Date: Mon, 12 Feb 2024 14:03:20 +0000
Message-ID: <20240212140331.915498-2-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240212140331.915498-1-tudor.ambarus@linaro.org>
References: <20240212140331.915498-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are SPI IPs that can be configured by the integrator with a
specific FIFO depth depending on the system's capabilities. For example,
the samsung USI SPI IP can be configured by the integrator with a TX/RX
FIFO from 8 byte to 256 bytes.

Introduce the ``fifo-depth`` property for such instances of IPs where the
same FIFO depth is used for both RX and TX. Introduce ``rx-fifo-depth``
and ``tx-fifo-depth`` properties for cases where the RX FIFO depth is
different from the TX FIFO depth.

Make the dedicated RX/TX properties dependent on each other and mutual
exclusive with the other.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 524f6fe8c27b..add39884d226 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -69,6 +69,21 @@ properties:
          Should be generally avoided and be replaced by
          spi-cs-high + ACTIVE_HIGH.
 
+  fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the RX and TX data FIFOs in bytes.
+
+  rx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the RX data FIFO in bytes.
+
+  tx-fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Size of the TX data FIFO in bytes.
+
   num-cs:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -116,6 +131,10 @@ patternProperties:
       - compatible
       - reg
 
+dependencies:
+  rx-fifo-depth: [ tx-fifo-depth ]
+  tx-fifo-depth: [ rx-fifo-depth ]
+
 allOf:
   - if:
       not:
@@ -129,6 +148,14 @@ allOf:
       properties:
         "#address-cells":
           const: 0
+  - not:
+        required:
+          - fifo-depth
+          - rx-fifo-depth
+  - not:
+        required:
+          - fifo-depth
+          - tx-fifo-depth
 
 additionalProperties: true
 
-- 
2.43.0.687.g38aa6559b0-goog


