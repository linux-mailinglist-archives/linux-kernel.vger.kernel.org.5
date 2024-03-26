Return-Path: <linux-kernel+bounces-120067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B0B88D122
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BF62C60CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9513E3E3;
	Tue, 26 Mar 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o/fPq/5S"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B413DDAA;
	Tue, 26 Mar 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492663; cv=none; b=kVNySydMHaF084HoKtzfapQU4CTjp6vd/PRRZqefsPzl4kjgo8I+Ssex10Esl2GwI6ugtPbgIsCoSuB680uiFmBug0iay3Z7NEgOKTA1LuUwtcYTF/taDbO+/l+G8OUxaZsYwIDJ1btghwWejV55pPS5ZgjLuXzR+HaEoBhpqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492663; c=relaxed/simple;
	bh=vtHSBbG2DXeQb1yPN/j/c2M0hMX/XtE+AuOAzok3w6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FaXQnKHkn0lWFT6cw77XDGhn4UyMjarBUC80fF44dvQokSJwBL3zSUHSGe3/VWQCnbQ4yRA1vKu92sM/6lNE811ZFCsCfNitRTqYm0GxeYY/sXOhfTwnC03rprQnVxqb1IHBYk0C1Hue12NgI7Emgw3yxnYeY8MRkEeDFjJptSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o/fPq/5S; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbXD1092778;
	Tue, 26 Mar 2024 17:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711492653;
	bh=/m8GoNEQsRLxqh9NQPyFQwvDN6J319O/acSr4HwVOVY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o/fPq/5SSQ+VArFeDEix1gk/agcwEhg72ojykz+sOWTAgh6n/3WZh5/h4eJCn7JVJ
	 t42QOhpdioZoPZi76QLJAb1C7doWikG70nA649tXN6eKUgry4hKyPLFz51Qd87r8Yw
	 oyacQxK8IFs0d/muIS+OEFLJzW0TBZRGW1WYjQF0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QMbXvs045399
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 17:37:33 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 17:37:33 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 17:37:33 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QMbVmb109669;
	Tue, 26 Mar 2024 17:37:32 -0500
From: Andrew Davis <afd@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] dt-bindings: arm: keystone: Remove ti,system-reboot-controller property
Date: Tue, 26 Mar 2024 17:37:30 -0500
Message-ID: <20240326223730.54639-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326223730.54639-1-afd@ti.com>
References: <20240326223730.54639-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This property was only ever used in one device. It is no longer needed as
what it signaled is now default. Remove this unneeded/unused property.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index c24ad0968f3ef..7f06b10802449 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -61,10 +61,6 @@ properties:
   mboxes:
     minItems: 2
 
-  ti,system-reboot-controller:
-    description: Determines If system reboot can be triggered by SoC reboot
-    type: boolean
-
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -94,7 +90,6 @@ examples:
   - |
     pmmc: system-controller@2921800 {
       compatible = "ti,k2g-sci";
-      ti,system-reboot-controller;
       mbox-names = "rx", "tx";
       mboxes = <&msgmgr 5 2>,
                <&msgmgr 0 0>;
-- 
2.39.2


