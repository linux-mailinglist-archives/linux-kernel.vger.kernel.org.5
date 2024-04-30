Return-Path: <linux-kernel+bounces-163907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 440668B7597
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B37B2218C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272913DB92;
	Tue, 30 Apr 2024 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="llbbxqJg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9213D630;
	Tue, 30 Apr 2024 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479566; cv=none; b=JM5oMP0LIh0LVuzO+igtfJQ0+g2+06ARo+BymCtnkrDGUttwiwO5Cq+Wds1xN5sKm3y3YGQ3DMPZzDss/XVjEWS9WTqou2IdJ+b7rfbCcbcXPF6gcNFH8mOLkiSqwsgFlwux6FAnIip0VzXEO3OKroKKkzVEmGBWmJU03V3TZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479566; c=relaxed/simple;
	bh=KUaBLzRtGctU3gOdlkAjDnE5k1Fx2z6dZypZywZpN4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ijPgjGQdSrQ9ORUJpBHy5jOm92pV4xwH6ln/oyrK4bDx1OPjdM5VqcIEqiKL+oByqjrd2XHghPw/oMYgkpyCJ4Lkk0hj+UVFws5EWo6m4vp10phm4ae+MyqQzUZSXaSUPq4cc3HTQ//yOy7dN7HaK1+YS6ix+6kWXMlioi+EJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=llbbxqJg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UCJKpd076067;
	Tue, 30 Apr 2024 07:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714479560;
	bh=OrvwTmrpNSLUEs5TeB2YKI1LF6K5dtqW8kqR+XW8jRQ=;
	h=From:To:CC:Subject:Date;
	b=llbbxqJgRJEmN5wJej9Y5pra1Q0xeeaBUojhKBcqYNXmHX7c6xusA3hacIZW490Sn
	 yqYmmgBCR3UEtS6xFaG9ZfQiztieCK9/oZojF5EUSqeUTdW7OpRN4FlKis5904jDbG
	 LLLBOsq1KQulOIx8YI5tdWfU72G/hx7UYt4U8y38=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UCJKbg006223
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 07:19:20 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 07:19:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 07:19:20 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UCJKPb062555;
	Tue, 30 Apr 2024 07:19:20 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43UCJJih012640;
	Tue, 30 Apr 2024 07:19:19 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Suman Anna <s-anna@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob
 Herring <robh@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] dt-bindings: soc: ti: pruss: Add documentation for PA_STATS support
Date: Tue, 30 Apr 2024 17:49:15 +0530
Message-ID: <20240430121915.1561359-1-danishanwar@ti.com>
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

Add documentation for pa-stats node which is syscon regmap for
PA_STATS register. This will be used to dump statistics maintained by
ICSSG firmware.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/soc/ti/ti,pruss.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index c402cb2928e8..cb6f41660847 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -278,6 +278,23 @@ patternProperties:
 
     additionalProperties: false
 
+  pa-stats@[a-f0-9]+$:
+    description: |
+      PA-STATS sub-module represented as a SysCon.
+
+    type: object
+
+    properties:
+      compatible:
+        items:
+          - const: ti,pruss-pa-st
+          - const: syscon
+
+      reg:
+        maxItems: 1
+
+    additionalProperties: false
+
   interrupt-controller@[a-f0-9]+$:
     description: |
       PRUSS INTC Node. Each PRUSS has a single interrupt controller instance
-- 
2.34.1


