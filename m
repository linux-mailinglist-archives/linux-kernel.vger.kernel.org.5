Return-Path: <linux-kernel+bounces-128563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C9B895C7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3892281C55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0727715DBA9;
	Tue,  2 Apr 2024 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjZ98rGd"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52CA15CD62;
	Tue,  2 Apr 2024 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085970; cv=none; b=nSp5LkSYIxrOVOJmP0kS9LEfLb82XWoUUjVritnDK+IFpZNM8ThHEZYH4TUjLegZXJfQYpwo5YzrDVVHK0xESAL+dKm9KKveGHR5zKUdRxzgSdFo0nW5A+fQ2hsKvenfUY4tJmDm2leiZPhOKPKhtf6ntCCBoW7nyrR8piCFY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085970; c=relaxed/simple;
	bh=5ucQylLBmNZMdQ2th8/CwEafp/XtJqR0xlhv3q0n810=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q25ebGv/b9iSb6EWil0Y5oR4tM7bt24cth6LWAWo1jsC5ZiEFaozbEhpf4Zdm5WvqtM9rLjGpzMqSFYv9eLVlYPqUgry4ge8y53NuZ5yx2bLGiRFHrj23q4HzBZ4rcoyya10YwJpKUulj+PC2WnwLsDNX7oUVuF9DE+U68T1wbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjZ98rGd; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-221a9e5484aso3768425fac.0;
        Tue, 02 Apr 2024 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085966; x=1712690766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksI6IPEsjFKiejyXpxCVyS77n8b3/e3zALrEpFbnmzw=;
        b=AjZ98rGd7MzFtmbI+Fwx0fBcGmR50eshJMdyXr6MYU1qTCwq792PJ70MNoFgTeeezU
         Lr9Xg7k2HJotLLj7Av9aHzing/OL2p+0mKjAiylmgrCrdr66PMksrG8Vb5klAEGji0v9
         vb1aqYVO6sRDYvg8S/RkFR4ZFen7W5eMJ3D/eZgiQLt9eWlZ2IsAavisTkeuMAGJh5Uv
         DXQsOx/St607l1JDbGnV2taiB8FQzvRLF31Nd2G+R7ePhmT2yyBiTCFnNnGrs1B4pdtl
         /zipr+vThXSvIuoKMKBIJvvhK/5o3SiUktVLjXQ6OHb3kfOVSlWUzPViwjGQX8ULydLM
         8GvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085966; x=1712690766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksI6IPEsjFKiejyXpxCVyS77n8b3/e3zALrEpFbnmzw=;
        b=nv8KH7qZlaN8MKIMitilaUXtdhVLWmiKQ08vFyoqbZpSxpgEHXhifPVLSD9WbfLRA3
         a4myJJgxJMHfqV9ylxqXYC+aGXjnuKjGFDdVlCcEMTzc0eZZfic0xE8VKRvtTQPdm5us
         RGIiDHbhmZ63QFpiZ5pmu+fXUHNUxNHV4t+7yXRSTpxX9fKR98Hnj8HkUBMRuU5hHFXf
         fJ0j4Ds82US46OHFW3Ryy5m4p8hVdSmialUgT6gWzWRcMN1wxYy8Ug/o82DiUoguIRkU
         kvweP+2ZOWCrWbuPeXDwOnfpunSEatIi+4qJNCsb3u4PzsCJvRXa6cIgOtW+sNDAvGI8
         O+Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU9CKOLbOTsZTllusS3H6L6+RQEIZxbJwNGHch+YinsC5XtJroAdvsTJaAvxnvmshp9LDWoLKuZ0bNKG982FgAIKhNYCPwLCdtlh/OVR0n/Hb+93k4Kmtx356KQD40UE3auR6T41lc5Qz6JVKiE9jQrbNntn6MMJgbJNt+krsCt2YmX1xN+rkc=
X-Gm-Message-State: AOJu0Yw9gOZonSpD3UkPKUYC6EaOybh2EHut4W0FX/bUu/Qa3AHyzof+
	/2PvgbxLoz1Z2ly7AGF1juSEEPz3vGmDaXSYL+C8gHmWyQsC8j0H
X-Google-Smtp-Source: AGHT+IHrnf/GQi55EqJXprDYr6y2oDDZ5H+PyWbIk86tp5RFeDkWom5A/9nkQ0o1HZf4XwVgi/HBcg==
X-Received: by 2002:a05:6871:5813:b0:22e:15fd:e247 with SMTP id oj19-20020a056871581300b0022e15fde247mr840978oac.5.1712085965864;
        Tue, 02 Apr 2024 12:26:05 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:26:05 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add ipq9574 gen3x2 PHY
Date: Tue,  2 Apr 2024 14:25:53 -0500
Message-Id: <20240402192555.1955204-5-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPQ9574 gen3x2 PHY is very similar to IPQ6018. It requires two
extra clocks named "anoc" and "snoc". Document this, and add a
new compatible string for this PHY.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../phy/qcom,ipq8074-qmp-pcie-phy.yaml        | 47 +++++++++++++++++--
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
index 634cec5d57ea..b0dbd2726acd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,ipq8074-qmp-pcie-phy.yaml
@@ -19,19 +19,19 @@ properties:
       - qcom,ipq6018-qmp-pcie-phy
       - qcom,ipq8074-qmp-gen3-pcie-phy
       - qcom,ipq8074-qmp-pcie-phy
+      - qcom,ipq9574-qmp-gen3x2-pcie-phy
 
   reg:
     items:
       - description: serdes
 
   clocks:
-    maxItems: 3
+    minItems: 3
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: aux
-      - const: cfg_ahb
-      - const: pipe
+    minItems: 3
+    maxItems: 5
 
   resets:
     maxItems: 2
@@ -61,6 +61,43 @@ required:
   - clock-output-names
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq6018-qmp-pcie-phy
+              - qcom,ipq8074-qmp-gen3-pcie-phy
+              - qcom,ipq8074-qmp-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,ipq9574-qmp-gen3x2-pcie-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: aux
+            - const: cfg_ahb
+            - const: pipe
+            - const: anoc
+            - const: snoc
+
 additionalProperties: false
 
 examples:
-- 
2.40.1


