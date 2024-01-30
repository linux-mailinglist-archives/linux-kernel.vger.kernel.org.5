Return-Path: <linux-kernel+bounces-44590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B518424B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F4FB23B00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906667E82;
	Tue, 30 Jan 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FoN8UqId"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821F67749
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617162; cv=none; b=u2SgggNyqenSc+gCZ4NEvJZXK3TN6W3+aBpuKHWwsiz0Za/KraCuVrkFn/MOd8xOCyoBU1SRjIe6b2PxNXIOU6tAT5EJ5GUXgcRGk0YMBQAnTd7wYACDrYvV2XxPaUS/e5pJ16oRPf2OLEg6C/wSdPdL+1ssKQ0PGqCvAnaVY1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617162; c=relaxed/simple;
	bh=Hd1RHTBtH/cnzQe4G9j54UYePvNcRisBiWelTnaOKz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPya9pE7X+n0AjH1luVRW8SW2Q/JqFm42AjqziatuSqF2Yomuzm5bmnE9Hs38p76wk7Y24KLPjnnwMFgRXt6ZVHKnVycjIayYRjg5Gim53h+SAnUgQ5fRoojRwuZX7RSRMdh6y5YpDGpj+aaWacjVOmeaaBCwxVSmTeFPNhpWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FoN8UqId; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5110fae7af5so2397542e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706617157; x=1707221957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6xinykc8GRQgs0/mcWgeatG2se7xZDFQ9kexfXSaok=;
        b=FoN8UqId3Ym2kjWJZqqv4dEG3yWxfkWXbMtEkBxrunAmzrVfCIu4ZsZGdd5on/IiuW
         DAMyv/WUnzs3nWa+bV99D7wEiq/dYbgcMoKwrG81kV0gltEVVGGjQ/sJUlleMTE8b7M0
         T9T4nX6DVKiQ4+4hyBGqz7VSejXVnQsHtDy9pRvT+SWD4iDaCJxCMv0IuBWgSyqJRoDf
         gEio4g10qlObBox5K59Zf22qCL5OyuubIt996KCztl4z8AdzY+tYlz/PEwWtYcPysliA
         EkOium8yYUBsbCLremhthoamavTGnxo3Zj7eKeTmT1F0W4Il1I440aLJMZZ4Eu+iifjO
         quiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706617157; x=1707221957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6xinykc8GRQgs0/mcWgeatG2se7xZDFQ9kexfXSaok=;
        b=q1nvPG9pOTsvuhuCiEtcOlqcySuhAMl4ZcPxk+41WIx4zJJAXVV2ex4ZOrh94v7EBt
         nBWeSsMM+tKRFBBYIVYQxZi8Q5j8JZEjJUScKSv4i32G//nKrBOuJH364FUAZLaTHPwG
         k3fowDDC5BcZHXMJHDkcoq6ng+O/44MCTBh4RYuLw+74xIHBppisrezGiH+nlIztgiPY
         mk+O1GDTR7Bkpqw6EI//JOvNrJxJKrnlu/OqpqSVr6wmg2AlfBsxmHL67tzof/UiXdOJ
         clir4Z6SWJQFIPXu5t4KolkDCg/M49BjsMvoPIsOWXkPzGZ8w9MqbcBlk3UdGCATkxtK
         7PpA==
X-Gm-Message-State: AOJu0YxtD0XXvL7cFdY7eLCk9ekpUnYBTC+kLGlaj8LNEL0uOkqRa3Ra
	UBXtSyCN6hfxFV0nOTgV7oQO1FMhal6XnFMqCYV4ygCIPA2i/AtAA9eGwuJ2ag4=
X-Google-Smtp-Source: AGHT+IFweCjsqiHYLJWwsAue42vx1B5R3jvo3j6Du0bPHaMEXysoP4buOT9c7/E9TkhblIoRX38pvg==
X-Received: by 2002:a19:f716:0:b0:510:da7:bdbb with SMTP id z22-20020a19f716000000b005100da7bdbbmr5375617lfe.45.1706617157505;
        Tue, 30 Jan 2024 04:19:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/tRUi6qNWTLscmYMoZE5cbSgq9p2WLkDFHlb1N+udx6tl3o0crFc+zRK/vtr1Qke1dqZQ7qfmMQtVhcTuOrbiFPrzJs7f6jv6onROzvzdsZmKdqvmfU/a3DxIFD1SdIBle0T9EjWMDF7d7KehwhO3mvvsNYM3C2o9T9bMg7bm1/KaLv050AGt1MA7vhi70G93NOWAqWQbDtjAi3zUYMmx70xGatkoufI6Pai+q2prRCl2H8cpvGSYQHIfB+Hq4QzIteoMpEUBehMMbncNGUzUfZwij4Dn0vC4gVvR7Zzj/CaMUga6Zjkq9caBgIGnfn95WlVljued1bdc6QvYvElotiZDk0n4IHgKatumc/dPFjJ6lvi6sCPeVBmok9Two7gqkNmcQW4E2P85wksAgTdl04ex1z25ZQ+CqcXDtoe07ow5z7YntiKznoeHPspwYFkiKuv4vG+j
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b0040efb503d58sm4049446wmq.28.2024.01.30.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:19:17 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Peter Rosin <peda@axentia.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Rob Herring <robh@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v5 1/2] dt-bindings: i2c: pca954x: Add custom properties for MAX7357
Date: Tue, 30 Jan 2024 17:49:00 +0530
Message-ID: <20240130121902.462619-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Maxim Max7357 has a configuration register to enable additional
features. These features aren't enabled by default & its up to
board designer to enable the same as it may have unexpected side effects.

These should be validated for proper functioning & detection of devices
in secondary bus as sometimes it can cause secondary bus being disabled.

Add booleans for:
 - maxim,isolate-stuck-channel
 - maxim,send-flush-out-sequence
 - maxim,preconnection-wiggle-test-enable

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in V5:
- Append Reviewer-by
Changes in V4:
- Drop max7358.
Changes in V3:
- Update commit message
Changes in V2:
- Update properties.
---
 .../bindings/i2c/i2c-mux-pca954x.yaml         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index 2d7bb998b0e9..9aa0585200c9 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -71,6 +71,23 @@ properties:
     description: A voltage regulator supplying power to the chip. On PCA9846
       the regulator supplies power to VDD2 (core logic) and optionally to VDD1.
 
+  maxim,isolate-stuck-channel:
+    type: boolean
+    description: Allows to use non faulty channels while a stuck channel is
+      isolated from the upstream bus. If not set all channels are isolated from
+      the upstream bus until the fault is cleared.
+
+  maxim,send-flush-out-sequence:
+    type: boolean
+    description: Send a flush-out sequence to stuck auxiliary buses
+      automatically after a stuck channel is being detected.
+
+  maxim,preconnection-wiggle-test-enable:
+    type: boolean
+    description: Send a STOP condition to the auxiliary buses when the switch
+      register activates a channel to detect a stuck high fault. On fault the
+      channel is isolated from the upstream bus.
+
 required:
   - compatible
   - reg
@@ -95,6 +112,19 @@ allOf:
         "#interrupt-cells": false
         interrupt-controller: false
 
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - maxim,max7357
+    then:
+      properties:
+        maxim,isolate-stuck-channel: false
+        maxim,send-flush-out-sequence: false
+        maxim,preconnection-wiggle-test-enable: false
+
 unevaluatedProperties: false
 
 examples:

base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
-- 
2.42.0


