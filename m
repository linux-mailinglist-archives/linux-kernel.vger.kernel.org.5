Return-Path: <linux-kernel+bounces-159976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78948B370D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845C2B210DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54A146599;
	Fri, 26 Apr 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0llLIsH"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40759145B14
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134012; cv=none; b=JUhQ7ywcyuZlDLqAnhtZ+NkflG3uZzRiDCH73QOOTXNYo8BMWPK1WJ7pP1IGcavRn89rzhCDoLYYYib0hxpx3ihNUpPF5ptmWwB6VdWQMyTuMTRleXEZQ7+5l/HHPNYdIZsmH+dDwgOqBgctA01/yw3GMykGty/wfNtljeWHetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134012; c=relaxed/simple;
	bh=14dadIAc5wD2QzNM/ZQDEQHha++iZmfZkrofpl6mL9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mm0oYPPxoO0JFuSRTpdBwn8RL5ePKgSZxxqAMemVqx7inJTNSDAtza7xOFJkqYEP5a2cILZNHZOJ8RoQ4KMIPukbCA0WOnZaxIT4U2cOtqkQvGjM778+TLW17BHUsOEOB3UPtcqnp/MVOi+FY4b79KWf1XAFi7ozR+9s0c2koT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D0llLIsH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-34a4772d5easo1742437f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714134009; x=1714738809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PRNqalgzRJP0wdqPI5aKVM4n2lOoPrcnW5MLhVms28=;
        b=D0llLIsHgZPOuwkpyCsMPY7InPU6PT1i305B+AeDSmnHYwqiRy5bUf0sL8yUTobxuM
         zrvuJnKBZquXzXQaFr9v66lHKRDxQBCEFRzP9hK0CofY4eU5HZWqLp78A+cAefvrUou6
         Nx4t+SUfqHfP31ToMAD5lwfDZ6V03IIUJN3KWzFkJVZahQSABhF4PD7BKx0sdjAg4M/N
         BUFe9J4tH8ZuFHv48wKl5GSj7+4y3tNvD/13eoIMTJawGNyU9IastZchNlPd7rjzKlFt
         oWleOnrMY3/mu/Zu+P80LrL+MswB7sVuxxXmpFfshCIPcYmzTXFCRYyr6qU6M4m3Sc38
         4O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714134009; x=1714738809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PRNqalgzRJP0wdqPI5aKVM4n2lOoPrcnW5MLhVms28=;
        b=ojVLi8nT1/rkr/w5dO7yon62zTD/cY09NbCd0xIbGbdUQwpMnSBw0esCeSPtUcGFbP
         t9AB0vA3+ED4UFT57MRg0SFxbYEvam7Cg1TLHG2MEAP5bghiXyKcOkj7WtdI0yoMDgUp
         CCDi2xJFDzm7WwE3YdzVHq2N3PYj+Pt5SQLCh7ALswgkKPeKAhF1Bgq1bkNg7fPR34CP
         swzu5p73fwlqgsEQiYWQRXSvUkSYrmDIVdlqbuMTcQ+gc8xtGODOwIel7ExHDg71zoCK
         CoSimu5JeNC/XWcxMBoMYcy86kIm/Msd7S4enScsBwgUCuYvvMU2kmUj9OpCOVgBEw7b
         +4ww==
X-Forwarded-Encrypted: i=1; AJvYcCVaTaXL4GWlijHTb9wCcBNq9D1QYLHN9+13nQaiYBKEvNdBXuNcn9zw0zpExAVBWjT1KqjfW/85dcg+9/jmjGCCgOMT0YhEUdPS0XTr
X-Gm-Message-State: AOJu0YyZppS4JYUfr5X3RtR4Q2YrKo9N7IRoY3iEAg9kf1DQ9wIqwgYq
	atCyo6RkBm3Quf6FSqSyic7QkNdEVX7NQYmHMUo0oXnooZzJZYJPR1dyzuON7xk=
X-Google-Smtp-Source: AGHT+IFPRQzrJNRe0ZHJxJr9q7e3kdzOr5FITfDYCVcG12MFC0Y3BF+U9bOg8Rq12hVlpBymtvyZFw==
X-Received: by 2002:adf:ed84:0:b0:34a:a836:b940 with SMTP id c4-20020adfed84000000b0034aa836b940mr1795068wro.18.1714134009627;
        Fri, 26 Apr 2024 05:20:09 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id q2-20020adff942000000b00346bda84bf9sm22478146wrr.78.2024.04.26.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:20:09 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 1/6] dt-bindings: ufs: exynos-ufs: Add gs101 compatible
Date: Fri, 26 Apr 2024 13:19:59 +0100
Message-ID: <20240426122004.2249178-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426122004.2249178-1-peter.griffin@linaro.org>
References: <20240426122004.2249178-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated google,gs101-ufs compatible for Google Tensor gs101
SoC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 .../bindings/ufs/samsung,exynos-ufs.yaml      | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
index b2b509b3944d..720879820f66 100644
--- a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -12,12 +12,10 @@ maintainers:
 description: |
   Each Samsung UFS host controller instance should have its own node.
 
-allOf:
-  - $ref: ufs-common.yaml
-
 properties:
   compatible:
     enum:
+      - google,gs101-ufs
       - samsung,exynos7-ufs
       - samsung,exynosautov9-ufs
       - samsung,exynosautov9-ufs-vh
@@ -38,14 +36,24 @@ properties:
       - const: ufsp
 
   clocks:
+    minItems: 2
     items:
       - description: ufs link core clock
       - description: unipro main clock
+      - description: fmp clock
+      - description: ufs aclk clock
+      - description: ufs pclk clock
+      - description: sysreg clock
 
   clock-names:
+    minItems: 2
     items:
       - const: core_clk
       - const: sclk_unipro_main
+      - const: fmp
+      - const: aclk
+      - const: pclk
+      - const: sysreg
 
   phys:
     maxItems: 1
@@ -72,6 +80,30 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: ufs-common.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: google,gs101-ufs
+
+    then:
+      properties:
+        clocks:
+          minItems: 6
+
+        clock-names:
+          minItems: 6
+
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+
+        clock-names:
+          maxItems: 2
+
 unevaluatedProperties: false
 
 examples:
-- 
2.44.0.769.g3c40516874-goog


