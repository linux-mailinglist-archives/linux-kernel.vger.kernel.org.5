Return-Path: <linux-kernel+bounces-73255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A193A85C01B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA2284DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B5376C81;
	Tue, 20 Feb 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTqAR25f"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E1762C1;
	Tue, 20 Feb 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708443363; cv=none; b=R0cO1Z1WUAW7RwDDxQ2OeOHuyLhD2QJNmxSyFHmtK1g2W1tu8b9sFKCYZ5VpKGYjgXD02exe4xGAvM+P9KypXWaeUDOihXxz8Xlo7pCVGMH6Qke/74/vWtBxvRN6mYgv87xuVUmSCROOxphx4HEMQhsZYygPDiFqEkBqtXGLBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708443363; c=relaxed/simple;
	bh=lL9tEj72B8RLSGVKGJnXqHrnROs1OMlmSlpmLn/ellk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBTPNhUEUpAjuBPpZT2DTU6n5QxExUr9pgkPvJX83wYuyHrzqbeQVSuGcppMceU9KomN02ePremnEBXhoRU+jF5JjIpcuabKp2jje8kX/QTkjBq3iP/mKY88PN20pTJHXowEHCRj+sOmLdh2tAGt1tY78U2LCkc1/Ds6DHkHwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTqAR25f; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso976900066b.0;
        Tue, 20 Feb 2024 07:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708443360; x=1709048160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wlAJ3HOeN+i9mwkmiHE0QT6wa1Z9g6FI4uNkE/zgM8=;
        b=kTqAR25ffcg+gyYO1uYasAd1ngFZxToWo+jE9VEm0+RP8JGl63dKbsJKexDPYKG74T
         dj33VKV0T2PhTwICCNiWm1TJUq23NA8qX2SMZ6nBCvX+oqPY5OYdSLBXLdKymPgeH0lb
         Twzshfqsgd82kc3GlfjJ5AvHaHZqD90lH+9Rv77g794bEZsEfcdrglIMLTZQAIX3G5BG
         JSkOmzDnRg7nRPkJ9heD3Bj3CIKfkPseUj0XzFMI/iYa4Z6E3Uv1v3wWrUqGsobb6oXM
         uf+dgLTzeloiD5o2CjEp/a6pwQpIUjhVL2KIjbDnggRCZ981XbOB7uO8pmW0tklSdtLa
         be/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708443360; x=1709048160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wlAJ3HOeN+i9mwkmiHE0QT6wa1Z9g6FI4uNkE/zgM8=;
        b=qfLov3+xtxWORa62ZbgVzSiVFK3hfxp9GmSPECYz65ZG0WTej4PlBPr2mYJJ033XVO
         wESAdGeMH/ytPiJvQzUqBwbibE9nIq3wwqhBsoq3FzeE8zdD/zpX7L+laWd1UHolUsMX
         9PnVPvvwNawhq4H9oL3YYsPHfwmXd8f4tbzb3G1hSsotym6dZAoWHgpEvQrFnHocwQjo
         kFZrLqtMNkG81ZIDumyfL08nSBcHIYPSzjnu95jaXGIcp/jzvRlrkmRicBoxVI2xKyH3
         58pMp6tdVaQVpWDBYDh4mZxSSsW6dO8bjzO7Br+TcjK6UpN0n1T2nIqTmUgCBZCiXH2s
         Cr7g==
X-Forwarded-Encrypted: i=1; AJvYcCU0OxMBCDnZ0PxRggrjKGnDf0TUDFFwKm/4iFAc8HWbzhz63iSbGN+BpG0tDsh4ZKmYkOPU2/sdzj7ML8fQfhoNAnXOz9/PoLCTI7lWMdnmXfSiZ1tX6bgHrzzYyrz3rlVqHhDTFOW/bJp7P3tHfxsr+CAI/o9fakQSwRF77a9sCt9KEw==
X-Gm-Message-State: AOJu0YxrvpRN+Gu71As4bb+Gb/n4rvcYm9Vfy4zp3yWt5iNaYHD+EHBa
	hrVwHiJlMuCYtQQD97eMQT8j4kqaabML98ieT1ixd94fK5S8Jm/F
X-Google-Smtp-Source: AGHT+IEaEVLVkF6Ocqna7U7WUPQHf22hyEVx9loZfFpXuZ8kcIk2TziFTViujCaF6lqxII4o1vR26A==
X-Received: by 2002:a17:906:2786:b0:a3f:1cd:69a5 with SMTP id j6-20020a170906278600b00a3f01cd69a5mr1739507ejc.5.1708443360224;
        Tue, 20 Feb 2024 07:36:00 -0800 (PST)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id r22-20020a170906281600b00a3d777aa8fesm4039024ejc.69.2024.02.20.07.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:35:59 -0800 (PST)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
To: 
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/5] dt-bindings: iio: hmc425a: add conditional GPIO array size constraints
Date: Tue, 20 Feb 2024 17:34:50 +0200
Message-ID: <20240220153553.2432-3-mitrutzceclan@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240220153553.2432-1-mitrutzceclan@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADRF5740 and HMC540S have a 4 bit parallel interface.
Update ctrl-gpios description and min/maxItems values depending on the
matched compatible to correctly reflect the hardware properties.

Fixes: 79f2ff6461e7 ("dt-bindings: iio: hmc425a: add entry for ADRF5740 Attenuator")
Fixes: 20f87a9a26be ("dt-bindings: iio: hmc425a: add entry for HMC540S")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 67de9d4e3a1d..a434cb8ddcc9 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -33,11 +33,38 @@ properties:
 
   ctrl-gpios:
     description:
-      Must contain an array of 6 GPIO specifiers, referring to the GPIO pins
-      connected to the control pins V1-V6.
-    minItems: 6
+      Must contain an array of GPIO specifiers, referring to the GPIO pins
+      connected to the control pins.
+        ADRF5740  - 4 GPIO connected to D2-D5
+        HMC540S   - 4 GPIO connected to V1-V4
+        HMC425A   - 6 GPIO connected to V1-V6
+    minItems: 1
     maxItems: 6
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,hmc425a
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 6
+          maxItems: 6
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,adrf5740
+              - const: adi,hmc540s
+    then:
+      properties:
+        ctrl-gpios:
+          minItems: 4
+          maxItems: 4
+
 required:
   - compatible
   - ctrl-gpios
-- 
2.42.0


