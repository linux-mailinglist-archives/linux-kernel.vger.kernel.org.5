Return-Path: <linux-kernel+bounces-54649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCF84B1F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A632871AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703F12EBDF;
	Tue,  6 Feb 2024 10:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hvRxKf3V"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D912E1FE;
	Tue,  6 Feb 2024 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213998; cv=none; b=qPjRym37PZsoebgMXj2YJYCcqIvhcP1pnEZn2cwNG9au2Op/uVwwsHU2Eb+0/fn0C/0LBRsnpzn69j/mCawD19srrUBJ/tJjKqX9/v+NCsQ4B6Hvrt0rZQolDdPta2dbG3R3JyUNYDBskDY3vGOSLVchGsMkSoPvNB/nO3rjKAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213998; c=relaxed/simple;
	bh=jy+CTHxTh3htkW55zq0VUBrKvIQaZUrkwYvPniW7+yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OONepeXMeGmyTj2rgt6RJFbOElddlUksTmgJSVhnDxSgS8cjaSl1dXys79EhPpMXecGaco/ssIqAtq27+8xASsXeS9dRi0bARWwjQLaOXH/T7R7t4HYCyx+rVUH41kVrTiLMVDuBBpxcVRq/OB2BNzLL5HWxjSNLbyv4TwjPVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hvRxKf3V; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416A6HI2092352;
	Tue, 6 Feb 2024 04:06:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707213977;
	bh=H7cmjPVH/f5QjQuNq4Da1Xprb+MgQGf7YJDPgHZhd0o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hvRxKf3V2wuASyQuKoVCN9QaTymZYVp+uCXI3Y/A4ByJTIxJJAu6kIGvcBTLr/HBR
	 Wn9gx42v4gSwD9YvMaLkUS6kHylGBN63I4UpjGXsuZeSjPImWrQhRua4U1S0E13KWA
	 qkF1gkW472GiPy9h24wao3X1Z4FOhfxNFXXYlVw8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416A6Hrq014073
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 04:06:17 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 04:06:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 04:06:16 -0600
Received: from uda0490681.. ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416A68qt054893;
	Tue, 6 Feb 2024 04:06:13 -0600
From: Vaishnav Achath <vaishnav.a@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <vaishnav.a@ti.com>,
        <j-choudhary@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: ti: Add bindings for J722S SoCs
Date: Tue, 6 Feb 2024 15:36:06 +0530
Message-ID: <20240206100608.127702-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add bindings for TI J722S family of devices.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index c6506bccfe88..d52672348424 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -123,6 +123,12 @@ properties:
               - ti,j721s2-evm
           - const: ti,j721s2
 
+      - description: K3 J722S SoC and Boards
+        items:
+          - enum:
+              - ti,j722s-evm
+          - const: ti,j722s
+
       - description: K3 J784s4 SoC
         items:
           - enum:
-- 
2.34.1


