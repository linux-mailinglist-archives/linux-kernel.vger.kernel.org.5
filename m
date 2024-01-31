Return-Path: <linux-kernel+bounces-47242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B490844AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC981C2624A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097F3A8F1;
	Wed, 31 Jan 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qw6nWHDW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566239FCF;
	Wed, 31 Jan 2024 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706739609; cv=none; b=t9sJ/jXj4HT0CFSUjR9MKqCQjRP+ckTc3y0o/qxCCeujxbQc7BIIPhS50bBX+WlZBeIugVbaD3FyA1+VZPxqIkjNSlkNifCKrgqgk+8+MjEySmoSwE+ZU/VJ4xl/n/12Ck5Kfb8K1UBkebAIDZztLKkm/sl4sQyOrlOxwarOlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706739609; c=relaxed/simple;
	bh=8p20tpkDY0SV/epOAIXWXwmyehskxCoLyEVFGjzVQrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etNm149MffJhYAMY2EGEB0PzE55QLULwqxuz1xbD0mQ0bptkdLgCXDyykJUyPnnoYBHbUQODRx5ph/zKSIm5sCSeaCUBPIVjBCjsHLy/XN7hmYjhAK2ZfxdQ7GnSnS6PZBCzSd5AO1vhR52BJ5D1+eNVDZpXJVd6RNyP731xGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qw6nWHDW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VMK0Or010378;
	Wed, 31 Jan 2024 16:20:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706739600;
	bh=MsGtrKLONpa1skHO9OSysJpEjYSFARrrS4U8i/PdCBY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qw6nWHDWhShTd2W8O6rh42snINVun7uMDPOUugl2afvc6XJCueT8P8m5AR9Dvj+1E
	 qf5FPvHwwyCSBa0qR4rF3UtFauCCfCR2kHgInxSU6N0C5iN/vN435j4pMUtmRq0HOl
	 1ke6zcr8zNxLMdbztVr6dt/hl3jJ+rXo5IwaANCQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VMK0qT021510
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 16:20:00 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 16:20:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 16:20:00 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VMJwx4102504;
	Wed, 31 Jan 2024 16:19:59 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 02/12] dt-bindings: arm: keystone: ti-sci: Add reboot-controller child node
Date: Wed, 31 Jan 2024 16:19:47 -0600
Message-ID: <20240131221957.213717-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131221957.213717-1-afd@ti.com>
References: <20240131221957.213717-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The TI-SCI firmware supports rebooting the system in addition to the
functions already listed here, document child node for the same.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/bindings/arm/keystone/ti,sci.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index c24ad0968f3ef..e392175b33c74 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -83,6 +83,10 @@ properties:
     type: object
     $ref: /schemas/reset/ti,sci-reset.yaml#
 
+  reboot-controller:
+    type: object
+    $ref: /schemas/power/reset/ti,sci-reboot.yaml#
+
 required:
   - compatible
   - mbox-names
@@ -126,4 +130,8 @@ examples:
         compatible = "ti,sci-reset";
         #reset-cells = <2>;
       };
+
+      k3_reboot: reboot-controller {
+        compatible = "ti,sci-reboot";
+      };
     };
-- 
2.39.2


