Return-Path: <linux-kernel+bounces-150827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2008AA555
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CBB2235E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13A199EB4;
	Thu, 18 Apr 2024 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hWwqmq3c"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD0C16C685;
	Thu, 18 Apr 2024 22:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478514; cv=none; b=Sj6uRyNC5IolHyGs4Zyj6eH8DCxx40YDFoT1n4nuxf9BD/BGFbKofl/Ignbrlg3KjGtiwvZDNAau9ei9Qw2aUTgMQKfQgAHGeYVoKphED32wBanYo2dGK4YqWy359uvfJ+KJHByR/l7XebmrIkcxcnY3A/1QATCIS0HQFkCUst0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478514; c=relaxed/simple;
	bh=GA6Oab1EYtmHP4689DUWe64vOswGYaChv/nvbKxXE8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCynph1UrjlxMsDx2ISpprA1CsRlxhvF+qH2qKAztOC1ERCQ9o72k6Pt8o/wI10ZaqeLeu78DXtndm8YmsM9eAfJZLNu/AtRsQ0tmCaEjO73r50VtYIDAtNogIeT+SPfHnGfb5DDp76Ap1xYd+6JZniWmAU3xZjZ/NLIecXfQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hWwqmq3c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEIRV054622;
	Thu, 18 Apr 2024 17:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713478458;
	bh=qwNEnafCq+ZOGHuRHve1QXo0MjXThsOuB4laeGEPh/A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hWwqmq3c7VUwjTYXV7NwC4XSN5Lf9HgSHSgMsWkvfwyWvlC3TASjns9OYI9kNm2UD
	 qV8DtV5+dYDLANhwH57Jb3NS+A0cD3u3u+FBVd8nFZQQBPE8i19nqgrQrugUVQO9R8
	 tu0PKxxafRpPaXeGT45BnXDGr13R6Vze1zLgcRmA=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43IMEH6m030829
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Apr 2024 17:14:17 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Apr 2024 17:14:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Apr 2024 17:14:17 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43IMEHqt111027;
	Thu, 18 Apr 2024 17:14:17 -0500
From: Judith Mendez <jm@ti.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH 5/7] dt-bindings: counter: Update TI eQEP binding
Date: Thu, 18 Apr 2024 17:14:15 -0500
Message-ID: <20240418221417.1592787-6-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418221417.1592787-1-jm@ti.com>
References: <20240418221417.1592787-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update eQEP binding for TI K3 devices.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 Documentation/devicetree/bindings/counter/ti-eqep.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
index 85f1ff83afe72..11755074c8a91 100644
--- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
+++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
@@ -14,19 +14,23 @@ properties:
     const: ti,am3352-eqep
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     description: The eQEP event interrupt
     maxItems: 1
 
   clocks:
-    description: The clock that determines the SYSCLKOUT rate for the eQEP
+    description: The clock that determines the clock rate for the eQEP
       peripheral.
     maxItems: 1
 
   clock-names:
-    const: sysclkout
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
 
 required:
   - compatible
-- 
2.43.2


