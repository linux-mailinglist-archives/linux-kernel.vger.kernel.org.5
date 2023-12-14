Return-Path: <linux-kernel+bounces-44-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA2813B20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E49284897
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131AE6A021;
	Thu, 14 Dec 2023 19:56:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F16A351;
	Thu, 14 Dec 2023 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5916c6b2e0fso1038952eaf.3;
        Thu, 14 Dec 2023 11:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583762; x=1703188562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMu3qe8RJmgyyVOaKPy6rEHFml1se+sCmssOaEi90U4=;
        b=J6neRkjSAF2s33M727L7sVSFcqFmhzm5ikzmjF5Tf24yI6NGJL+ciaygOkiPMln2Jn
         d8XHwezwMoxNytIv89WoZ4EGX4Jlu8RPqDyUjvXFiWbHXJizRY/Zn9XRvxnMKiKj1JwV
         37icwWrsbEWFE7jX5CT6IXGsQXkttrXVk0lvu57bs4eQyaphQU8e65yO6JVxmfnJvMQk
         pAfSDcWFU0WdIIpuQaLLKsscMupq4172vmlYNZmNfBpOyZC6eJD2MhO0khLkeGgHcSDj
         TiD7wLSeVuMt9XYKT+lgzUCG1f+Wpbu6h/x/6n4eMSXin5c6iV3FbSGnBRu3Wg/KYNFn
         OXfA==
X-Gm-Message-State: AOJu0YxmCbQF+eQZVSIo7c9jVD+LzA2n8CijBx9Mha7jRRewH+VSZoo1
	AdxrrFrXY+4cTVRfWX7Iqg==
X-Google-Smtp-Source: AGHT+IFGmBpwDdWphaWjGbg0/DrlAiemTYd8eL3ibXknjLg7pN3G6/8VDLCUqsRK18wPEMgvMTHWNw==
X-Received: by 2002:a4a:af02:0:b0:58d:8b93:ec8 with SMTP id w2-20020a4aaf02000000b0058d8b930ec8mr7429120oon.2.1702583762494;
        Thu, 14 Dec 2023 11:56:02 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en12-20020a056830488c00b006d9fcb44e00sm2836039otb.32.2023.12.14.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:56:01 -0800 (PST)
Received: (nullmailer pid 863088 invoked by uid 1000);
	Thu, 14 Dec 2023 19:56:00 -0000
From: Rob Herring <robh@kernel.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Aakarsh Jain <aakarsh.jain@samsung.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] media: dt-bindings: samsung,s5p-mfc: Fix iommu properties schemas
Date: Thu, 14 Dec 2023 13:55:52 -0600
Message-ID: <20231214195553.862920-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommus and iommu-names property schemas have several issues. First,
'iommus-names' in the if/then schemas is the wrong name. As all the names
are the same, they can be defined at the top level instead. Then the
if/then schemas just need to define how many entries. The iommus if/then
schemas are also redundant. Best I can tell, the desire was to require 2
entries for "samsung,exynos5433-mfc", "samsung,mfc-v5", "samsung,mfc-v6",
and "samsung,mfc-v8".

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Fix some more cases of iommus-names
---
 .../bindings/media/samsung,s5p-mfc.yaml       | 33 ++++++++-----------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
index 084b44582a43..4c3250985ac3 100644
--- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
+++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
@@ -49,7 +49,9 @@ properties:
 
   iommu-names:
     minItems: 1
-    maxItems: 2
+    items:
+      - const: left
+      - const: right
 
   power-domains:
     maxItems: 1
@@ -84,7 +86,7 @@ allOf:
             - const: sclk_mfc
         iommus:
           maxItems: 1
-        iommus-names: false
+        iommu-names: false
 
   - if:
       properties:
@@ -102,11 +104,9 @@ allOf:
             - const: aclk
             - const: aclk_xiu
         iommus:
-          maxItems: 2
-        iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
+        iommu-names:
+          minItems: 2
 
   - if:
       properties:
@@ -123,11 +123,9 @@ allOf:
             - const: mfc
             - const: sclk_mfc
         iommus:
-          maxItems: 2
-        iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
+        iommu-names:
+          minItems: 2
 
   - if:
       properties:
@@ -144,11 +142,9 @@ allOf:
           items:
             - const: mfc
         iommus:
-          maxItems: 2
-        iommus-names:
-          items:
-            - const: left
-            - const: right
+          minItems: 2
+        iommu-names:
+          minItems: 2
 
   - if:
       properties:
@@ -161,9 +157,6 @@ allOf:
         clocks:
           minItems: 1
           maxItems: 2
-        iommus:
-          minItems: 1
-          maxItems: 2
 
 examples:
   - |
-- 
2.43.0


