Return-Path: <linux-kernel+bounces-95456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1605D874DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F151C20D96
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B6129A84;
	Thu,  7 Mar 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFFPN7/6"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D9129A60;
	Thu,  7 Mar 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811785; cv=none; b=DMCvrdYbluMRcFLbIl7JmM3AlxeVFl+SbKElmMmmkKkgC1sSEtRTjbUxtKU0+slJzRew36UGwTg450svmlW+/p+PC4ACD1DHXBeZl6FMANh4y77UHOdo5xU9TtB8tHfJVNgFplFljcnC+MY3kiCmhPGit7UjoR+e5pxIG9FbEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811785; c=relaxed/simple;
	bh=zEKWGNrUGnl1GtxuJwncA8/EcelNOisxdeUhRE7zrj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dZDVJCrtD5d/kM6IizncXNSSrlgBmlesanKzlvCY4fwrwTrtFByLEmjPPrF3Bngc/3Wvqrb3WXGz8P5d9wVaYm7djersvSVio+QCuFcfbzEh5aocbu2scV7SVWbGRWwj/Dq1SKCD0Nb1iMebDRAcd6DaykkmXav01dEqvc831uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFFPN7/6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e4c676f0aso403927f8f.3;
        Thu, 07 Mar 2024 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709811782; x=1710416582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQhcETu7ygulSJUqFjZzC5XAQTQIZg4uk/17z1SlZMY=;
        b=KFFPN7/6RN5YDVPzmIyIZcBtERZWuVRlMraqacHiNxuVY+DkUV0QXCI2hHG+CdkcfT
         WcPXh7yxn1PicGUrl3f5JEU9yaogve5wLuRsr6P0gdsv3tkhuaHU5FmZnFtSCJxoiCDU
         euJC8IKa2V1+NNjlgxysHpm/8nOlWUsOQqTxnfeBjffdwHhRODFzjZGgXTNTId1mxYdw
         n9UYdOcxSKwtkrtljwS+ol1o4PhFMN1cmWo56uxTKKDG8tPNqRI/AfUyq1ERZQbl0HJE
         txBSWCt2cooKMOa2wBlzz+ic7+bRTOW6vwIbkqSwarycoK3lkV/3SYcPAPVpEheLne85
         IvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811782; x=1710416582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQhcETu7ygulSJUqFjZzC5XAQTQIZg4uk/17z1SlZMY=;
        b=qYI5XRhS3YJgOnsT5eqNRBVMzzieIpUcSBKT/4rinXmf5G+KqruYMeh3ap6mTqRNiF
         ajjdYP74jncPCUZ23nFn08BG1r69VeNNYwZCJuhSVnFi0YozcGdwWTv9xKlvVBSrAlO1
         S3fxMpa3VTrybxLG95gUme8+C6bxqFrokVB2NvgHwbgAR9euI/uqOzMxd49ZH5Fp5YWH
         qBPuyiuYfrCw0W5cl7YYvfWpC3dFq3bF2pwkR4NFfG+VR/ukPEyVsYcHMT7w9bbZcXae
         fmEF85uJlbnMh4T5p39ioUfmMZbYPyPYK0aO3b12IbjT/bAr+c9eEZO4O9Ad9tsq7/VZ
         Xb2w==
X-Forwarded-Encrypted: i=1; AJvYcCV1ixEhgX1sRDRy7oWAOs4/8qDXX0A7U81fRVnBhSLDZu4NI+Xm8YQwB3hMnzaioJzxWwbL3HQTjNleTJSZjzBNyEei6GEr3XEp0qSbIl9RN5gSST4oNkXfVXkiuYNU/+k/daOAdueMsU8bKlNmeF2iIaX42kWbg217ZUGfavH047ljSW0upaCp4Msq
X-Gm-Message-State: AOJu0Yx9bR4s+GgznctRAGWp5iekqqbjqtzfNLhVe/A9TUZtrqH73YWz
	94BIDb9SRcv+fOzD6G5/WfmxobS6feiLl0T1xPTBvZBr6kFQFBJl
X-Google-Smtp-Source: AGHT+IFaDwS/b54Im3RafFET7hxAuTlVwLg4uLrLzlc5B1f9ABZI8ZKO1H70PDb1F5hCpq7G59KXNg==
X-Received: by 2002:a5d:608b:0:b0:33e:4390:c039 with SMTP id w11-20020a5d608b000000b0033e4390c039mr7197927wrt.33.1709811781870;
        Thu, 07 Mar 2024 03:43:01 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b0033dd9b050f9sm19858722wre.14.2024.03.07.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:43:00 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Thu,  7 Mar 2024 11:42:16 +0000
Message-Id: <20240307114217.34784-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v1->v2
* Included RB tags from Geert and Krzysztof
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
index 4610a5bd580c..af72c3420453 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SCIF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
 
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -160,18 +157,21 @@ required:
   - clock-names
   - power-domains
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
 
 unevaluatedProperties: false
 
-- 
2.34.1


