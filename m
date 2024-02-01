Return-Path: <linux-kernel+bounces-48716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C819C84602A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8349028970D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71BF7429F;
	Thu,  1 Feb 2024 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sTWw38OL"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AFA12FB08;
	Thu,  1 Feb 2024 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812972; cv=none; b=IvoB8RP3R5yyKXp3sN7hixpqh+LBZ0vKOVq2LXnQKPwoUWxUCCRx3pNB6D+zEkBdDTohRPxAIG7CcOMPFG2soyqCLOt+I2kcaVKgmKGYCPKmkiZqkwaNPqabXzPQWK2nwKv37eUKwL2rz+VWl4y9uN1GnVz8pELg6ukprBObyvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812972; c=relaxed/simple;
	bh=VIvy4lTH+SG5Ye0Xk/ugj+PgutpBZ54WPeCaP7NfPJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0FIgEMx7hoSXYOYMd9RdQ2JEEoRuUywdnL1b+NR6zdKNh6LRrf1HG9rlsRVzPHxCsiwz8LCKOB58C/KDTuYLGEqMKNEDs0FrmGggncFz+YODFqe9j413xtrD9LRL+wZVqWKF03vAV9Ff7fA1qBRsgVc8T0efZUIAfK8ljJSq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sTWw38OL; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411IgfX5006990;
	Thu, 1 Feb 2024 12:42:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706812961;
	bh=Ew1MvrMW2/yaRtaTroFMXsF9Ix1hzxk1BU3jjawkr2k=;
	h=From:To:CC:Subject:Date;
	b=sTWw38OL1IluL6GvAACoKlFW9X7dmgmrVfjQ6iXvAx7qAmOkhgfJpJgRhc2sLmVx7
	 usO1ypP0yaNcBblMI6fb4F+3IO9Sbj7AXTz5toapXM4Ob9lqAv0m5DsDLTOjWJob6t
	 oEEMP9hisLqEBssr/O1GcH7ZwzYH/5yQ6fyElgog=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411Igf1r023903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:42:41 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:42:40 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:42:40 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411IgeuD042789;
	Thu, 1 Feb 2024 12:42:40 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee
	<jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>
CC: Darren Etheridge <detheridge@ti.com>, Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Date: Thu, 1 Feb 2024 12:42:38 -0600
Message-ID: <20240201184238.2542695-1-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Wave521c has capability to use SRAM carveout to store reference data with
purpose of reducing memory bandwidth. To properly use this pool, the driver
expects to have an sram and sram-size node. Without sram-size node, driver
will default value to zero, making sram node irrelevant.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
index 6a11c1d11fb5..ea5469eb38f9 100644
--- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
+++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
@@ -43,6 +43,12 @@ properties:
       storing it on DMA memory. It is mainly used for the purpose of reducing
       bandwidth.
 
+  sram-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      SRAM size reserved for VPU operations. If not specified, size will default
+      to zero.
+
 required:
   - compatible
   - reg
@@ -58,4 +64,5 @@ examples:
         clocks = <&clks 42>;
         interrupts = <42>;
         sram = <&sram>;
+        sram-size = <0x1234>;
     };
-- 
2.34.1


