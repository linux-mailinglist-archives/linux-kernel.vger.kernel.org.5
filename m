Return-Path: <linux-kernel+bounces-157381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2E38B10E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42108B29FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FBC16D9A6;
	Wed, 24 Apr 2024 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="E1ic00PA"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFD16C86A;
	Wed, 24 Apr 2024 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979321; cv=none; b=F7WZZoFjCL4ZZq+6aW0ptlu81K5Ntd5qFrueRaUj7jsXLG+WBcKDis4+aYzRWHWsfOBUo7l6lAyk5gFy8euwQf9elzvJ3uMt+exWwadL3r6bs0Wp0yY/BJO0HQloUACIZYxlt4c6QyYiiNbLJX1areQ5wCuUODgZIyjF/6B/JPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979321; c=relaxed/simple;
	bh=HyQV/8KNJS9FxdSJ5mhUFS4z/bKSmkix3wT7y7J8jW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwYgqCdUFxvEbAxnPwOabbNf9st2/1Z9q4OPI/ruF1YELJpVVnGK9q2RU1Px083QIx5w78dOIhVxo3eo7klzQ7zDBnPzkRV8ydUdPb9KAa6+4VCu4LqQYlsfQJC1MlW0NzY9M7nJ7UQpSCDMhJnsbrhLSWt5p3EkuMP1dIrklAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=E1ic00PA; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1713979317; bh=HyQV/8KNJS9FxdSJ5mhUFS4z/bKSmkix3wT7y7J8jW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E1ic00PA3QqbzternqW3lhy8Dmz4UQpkT3E1knAKFuYS/dpCcz1b6dFoqguTt6e6T
	 9h+Ssm9ZyY0MPPfwn8rkTC7K7cC7WnVpL290L5Z0VnEnAfupYWzZmXf5CO3aA67CxZ
	 3ntLcoB4bg60FeL9gT3l+5WZeM7ohJQSqPFJ2Hxg=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Wed, 24 Apr 2024 19:21:51 +0200
Subject: [PATCH RFC 1/2] dt-bindings: soc: qcom,smsm: Allow specifying
 mboxes instead of qcom,ipc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-smsm-mbox-v1-1-555f3f442841@z3ntu.xyz>
References: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
In-Reply-To: <20240424-smsm-mbox-v1-0-555f3f442841@z3ntu.xyz>
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2509; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=HyQV/8KNJS9FxdSJ5mhUFS4z/bKSmkix3wT7y7J8jW0=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmKT+zElUUG0MAIMsw+kg0RsdOmfKAGxYcLNiAx
 XMduzAJ+7KJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZik/swAKCRBy2EO4nU3X
 VrgZD/9dYGeTTw9NlgzwvwRjHST19V5mmh6VmQNYA+T7evFkuLXb4uJaVoVTjbxsugTOY//pUIK
 STXqasldMXtGAJxcCqs1gPZKYS3M9a+mF/mBYG031Zz1THB9HS6AUFDuzqR0GVuCnWrE0Jk1wic
 biKUSyCrzwR4D6CH8Ult0K37PixIvxAl1DF3y8DkQHrSzlS8w5UhdKsIveos6A9DNuYGDn1uO9v
 jTfNPbvty6eYkiudH2FHsIGV+YWy9zvqvIY6ER9rcnlidOqHwu5P1cixA3ok2MQG4H+WUUlr6vE
 2FreXl+aqt7N2AwCEyWx2CKqJMiCaV28i+aIWjcVKh+VaOyybVrhjreN3+cJQ4PqP2+8xIlo9tQ
 WQZOPNC2ircY/4zQEQUQANKkJyna9sboLCvKlMsMI6W+fXkkMeI/CFbxYOb4dxFBQuUtkGyJ83m
 M+0xiNadJkYPlA8w5OHPQhLrseL1g5p/6FEUaz4woud4JWvT0q1Bc9Kr4Ao8zZqP4nPtql4p9pN
 GbKKqDmaCVRJWqgRml7iKKHk0M+s2d1pol+Ai/fDji5sefhjaMViwUVf9Wg1YUjmJRk3ReBGMGg
 pKcEZRlViQ0kwNWJMFIEuMIzcDCDe1CojS/erWAFxgPFgHvdgAqPHeQ8LCopSrOXRTE2uvnTP9X
 6GmS4yr8LEoS36A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The qcom,ipc-N properties are essentially providing a reference to a
mailbox, so allow using the mboxes property to do the same in a more
structured way.

Since multiple SMSM hosts are supported, we need to be able to provide
the correct mailbox for each host. The old qcom,ipc-N properties map to
the mboxes property by index, starting at 0 since that's a valid SMSM
host also.

The new example shows how an smsm node with just qcom,ipc-3 should be
specified with the mboxes property.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/soc/qcom/qcom,smsm.yaml    | 48 ++++++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
index db67cf043256..b12589171169 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smsm.yaml
@@ -33,6 +33,13 @@ properties:
       specifier of the column in the subscription matrix representing the local
       processor.
 
+  mboxes:
+    minItems: 1
+    maxItems: 5
+    description:
+      Reference to the mailbox representing the outgoing doorbell in APCS for
+      this client.
+
   '#size-cells':
     const: 0
 
@@ -98,15 +105,18 @@ required:
   - '#address-cells'
   - '#size-cells'
 
-anyOf:
+oneOf:
   - required:
-      - qcom,ipc-1
-  - required:
-      - qcom,ipc-2
-  - required:
-      - qcom,ipc-3
-  - required:
-      - qcom,ipc-4
+      - mboxes
+  - anyOf:
+      - required:
+          - qcom,ipc-1
+      - required:
+          - qcom,ipc-2
+      - required:
+          - qcom,ipc-3
+      - required:
+          - qcom,ipc-4
 
 additionalProperties: false
 
@@ -136,3 +146,25 @@ examples:
             #interrupt-cells = <2>;
         };
     };
+  # Example using mboxes property
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    shared-memory {
+        compatible = "qcom,smsm";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        mboxes = <0>, <0>, <0>, <&apcs 19>;
+
+        apps@0 {
+            reg = <0>;
+            #qcom,smem-state-cells = <1>;
+        };
+
+        wcnss@7 {
+            reg = <7>;
+            interrupts = <GIC_SPI 144 IRQ_TYPE_EDGE_RISING>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+        };
+    };

-- 
2.44.0


