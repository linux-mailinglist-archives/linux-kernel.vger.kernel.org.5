Return-Path: <linux-kernel+bounces-163912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793DE8B75AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA021F22732
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372C7140E46;
	Tue, 30 Apr 2024 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CNROjM8O"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793C713D8A0;
	Tue, 30 Apr 2024 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479861; cv=none; b=CY4abMeaohie0sSAvdToorMIoyL5bj8562bovlJUn6OME4TNFXmliRY3F33WCt8CcJ6Nx8Dlv4+0t6+Ogyyftb/rbeEuW80ubv10436hXhL+iFGXyjFK0+OqEUV/sW9AM3Grxkrip50KDguLnoO88l18y72F47dg0HUXio/u6tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479861; c=relaxed/simple;
	bh=KOBeT7FoVPcUC7BYDDnv3FjM6P6bvRBPEN+qjN1WCSI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uyayIf91kKtanuLv8zUYi+KmCqXFh4mER3gBu9cgsBimH6mEPgZrHkoRUKO95zYYhjyiGW3zCn42ut5AvJQ1l3yptjKEOmNZ7U9uxIyJlXva+/boAdsIVG77ErsPCm/oJgJefNufjQqzV+qcvb1D77wSVKLoOG/KMs3rymN8L48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CNROjM8O; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UCO6Xt022903;
	Tue, 30 Apr 2024 07:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714479846;
	bh=i4t/c5XrlILHAYh/3L3J0sESvCIgLKV9OPOQhJnD710=;
	h=From:To:CC:Subject:Date;
	b=CNROjM8O70oYQfs74Cby1vTcQvOP7MbXAb0QN6TSBs3DSMH8yyEbbIkPjjwolMBcC
	 IO8EILZNXfXEvvOaocaYDkqg6BkV0i/7NcZIufKz7N7G/9z0rYJ9Mmq4CZ7LulupB+
	 o1B+7LjSBmdMh/qvInBi3m0VbFil4H13Cbng/CAA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UCO6GX094617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 07:24:06 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 07:24:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 07:24:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UCO6pA069552;
	Tue, 30 Apr 2024 07:24:06 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43UCO5A3027936;
	Tue, 30 Apr 2024 07:24:06 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        <r-gunasekaran@ti.com>, Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH net-next] dt-bindings: net: ti: icssg_prueth: Add documentation for PA_STATS support
Date: Tue, 30 Apr 2024 17:54:03 +0530
Message-ID: <20240430122403.1562769-1-danishanwar@ti.com>
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

Add documentation for ti,pa-stats property which is syscon regmap for
PA_STATS register. This will be used to dump statistics maintained by
ICSSG firmware.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
index e253fa786092..abf372f7191b 100644
--- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
+++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
@@ -55,6 +55,11 @@ properties:
     description:
       phandle to MII_RT module's syscon regmap
 
+  ti,pa-stats:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to PA_STATS module's syscon regmap
+
   ti,iep:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 2
@@ -194,6 +199,7 @@ examples:
                     "tx1-0", "tx1-1", "tx1-2", "tx1-3",
                     "rx0", "rx1";
         ti,mii-g-rt = <&icssg2_mii_g_rt>;
+        ti,pa-stats = <&icssg2_pa_stats>;
         ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
         interrupt-parent = <&icssg2_intc>;
         interrupts = <24 0 2>, <25 1 3>;
-- 
2.34.1


