Return-Path: <linux-kernel+bounces-130552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB278979DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29D81F288E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5805156648;
	Wed,  3 Apr 2024 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZbmmTJZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C9156228;
	Wed,  3 Apr 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176597; cv=none; b=H2gCL+JbCD3UcAN090TwqP1sknrJfBB7xrOTpP7JiaN68newS3N+wh1elvBFWULfZBoPY1dJ4vObOstSKEYlrwhZZbdPGQ0aYquPumSSL3H0EUy9iyzAWNEsayJjFqips3/j7DYYbm3YKjl6ivxicf++oA+HvXcj+v+KJKJFCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176597; c=relaxed/simple;
	bh=D3zZQSdy/uIrKwujVFSPQFERPXpObvA/I+ilYLzrLac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qCaudxu8OooDgqocfRffm0Y01+Y/U3zUfGkOlrtIgV9uDed2VLnemOPIo9upqZxYeeu4hLpzgQn1D54MoGL6iESj1UmXfdJJgJ2JMiVbcLPUr0sbD49M/PvZHZvCMhFQTgRtug2W8PbBga2sX22DcBeXynMe49et3N8EaUvakzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZbmmTJZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41628f4c67fso824375e9.1;
        Wed, 03 Apr 2024 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712176594; x=1712781394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUH7OqsY6sf88nvHWT1W52xeXKt/+dN6doaNx9JrqxY=;
        b=JZbmmTJZmby3khFbpUWauygXiiXl93CH6iODdsEe/DSvSFL5wEzXCH3MDSlPel4BC4
         iXVHaC/BPOnXLc2ZfqGuTs5KVYD8MCw6x/wsus6+QhCYhAiknj4Q98i7hw21aqe3251w
         FNd8JBTFZkyyz7cHPBx+upJGjmUBq5mcbQPR6V3HWgu2USteaQ6xfjD1Re9lgkeQsqQs
         Mwsx+tf/lLWtS+oUfY3GY6zK//LdPQNL4JvOJbhqz2nKa4CRIXc14ppglN1Lyz21p0qq
         cbLJw/BK2Wt/RG4LRLeTRfnzAZQ9XVE2juCUkfhq2vBiEbhxAcIflPIK+iOeKvrKgZ7L
         ajyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712176594; x=1712781394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUH7OqsY6sf88nvHWT1W52xeXKt/+dN6doaNx9JrqxY=;
        b=sxHfPgWjHXRJ+zOUYxPskcEhcAd0u38oZXMb6tvm7yNeDVND6PybydRHH5EjFFqQdM
         gxNHu7IkyzjJkl0Zr/p8jFkJvMBJyLr/gorfqQCVXJB74EOwMDCQUcBNId0VsQZyYQNM
         pEYsnRN3NsooF2s2VZxh3hrSWe9YKUbXvkkcDLFoe9SmnK7V2pC5Koi6uYmSHLoSSE2O
         QM8qK6yePokzY3HbM0ZKczg6DeDfrITXybX+K9yf9qLJdmzKILmuXHcSpYbLWg7DnYuk
         JAXtzrFyj1FKuQZ3agR0NeLpGG57ZPQtl+47Mwp0El2Jx4u45beA8VYAoKuJWa1BRDPT
         oZOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTua0UdDt9gGAhdEtqUJoAgxlkCJm2BEBjgf1uMmBkKeypgrKahJty6sGQz/W/3UP4COGBIwGPERUj+r+kGCnyvxvo7ZumlCRCqiryKXZPtCMq1uP3Yk+AKcI3e+yzt0PHhU8C5vzLd8hhih/4
X-Gm-Message-State: AOJu0Yz7uOQAEiTCjIJw4KKydYc70UlTg8eLxA/ygUErtXbVd5hAPke/
	OKSKYWCv3XBnW7DgCtkNFHE3s+vMKXgbScp2Y67v8cGyRNcBQaYh
X-Google-Smtp-Source: AGHT+IGNTM0sZ87+Wmh+Qg37VGEcAylBAuD8K4vBkdPoDwX5QwmGHCcZNo2VTkh442bBlxrZTK+PUQ==
X-Received: by 2002:a5d:5451:0:b0:343:7d3c:ddcd with SMTP id w17-20020a5d5451000000b003437d3cddcdmr425201wrv.1.1712176594421;
        Wed, 03 Apr 2024 13:36:34 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:5eb:3d93:f2b6:25e8])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c468400b00415f496b9b7sm244910wmo.39.2024.04.03.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:36:33 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Five SoC
Date: Wed,  3 Apr 2024 21:34:59 +0100
Message-Id: <20240403203503.634465-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240403203503.634465-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on the RZ/Five
SoC is almost identical to the one found on the RZ/G2L SoC, with the only
difference being that it has additional mask control registers for
NMI/IRQ/TINT.

Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
- Dropped the checks for interrupts as its already handled
- Added SoC specific compat string
---
 .../renesas,rzg2l-irqc.yaml                     | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
index daef4ee06f4e..2a871cbf6f87 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-irqc.yaml
@@ -21,13 +21,16 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g043u-irqc   # RZ/G2UL
-          - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
-          - renesas,r9a07g054-irqc    # RZ/V2L
-          - renesas,r9a08g045-irqc    # RZ/G3S
-      - const: renesas,rzg2l-irqc
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g043u-irqc        # RZ/G2UL
+              - renesas,r9a07g044-irqc         # RZ/G2{L,LC}
+              - renesas,r9a07g054-irqc         # RZ/V2L
+              - renesas,r9a08g045-irqc         # RZ/G3S
+          - const: renesas,rzg2l-irqc
+      - items:
+          - const: renesas,r9a07g043f-irqc     # RZ/Five
 
   '#interrupt-cells':
     description: The first cell should contain a macro RZG2L_{NMI,IRQX} included in the
-- 
2.34.1


