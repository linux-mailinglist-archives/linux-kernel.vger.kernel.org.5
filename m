Return-Path: <linux-kernel+bounces-45221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B79842D52
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BD8B2213B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9469E00;
	Tue, 30 Jan 2024 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O9volrRe"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CF26AFC;
	Tue, 30 Jan 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644299; cv=none; b=UfgBsVQ9nPLl4J6Gg/cslN8LNrytxb6T0UjlmbdaAt82xvnWRGWp1LhrK124a/zzuIIOrS9+UwFAyohJtKqrcjkOZnudW9Y6/fvyzCDJ09giu9T9kP3+s4krKP1TIWCXGXb+lYqAsqsHs38QzgD19UfSWEodPAkpnTF44zs/6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644299; c=relaxed/simple;
	bh=KZIHoZ/ortkxqz09K9+Duj8ORo99US63DDmMRbGfa2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IUGwjrNa1IwTpyEDXi1ZRJdXteu2/S8ZKKghkjc2DJwFUxIf45nCfsw8FfgLP9i6d6wKIQve5jXh8AWd4V0Ao34wJq1aixk24KkvnsjLXvXxn8Zvv5BxyTA5QUGPyWayr6mgwMsi5Dt1c3jy6xG5Py3KglmIP73P4tUMduayooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O9volrRe; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UJpUH0085126;
	Tue, 30 Jan 2024 13:51:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706644290;
	bh=F5nHbJuhtD4RPNSh+N/zXRzstU5qpZ9dXeVDcW9SlxI=;
	h=From:To:CC:Subject:Date;
	b=O9volrReXX7Jeg9uLz1wRu94R1rCvBVx4SR4Q3G3TNj/PmGG6DeuBV7cyA6EswH3S
	 1fjdZkABu598y1x+C4VCyl2y+y+tlQVwMnbpHg/qorZJZwVmt3Taayz09jC8gAUZy0
	 Ymbh0mU/Q/oM6yXUWI1OHFM0+thntXmG3Zr8TMVM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UJpUCO022002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 13:51:30 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 13:51:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 13:51:29 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UJpTKv005747;
	Tue, 30 Jan 2024 13:51:29 -0600
From: Andrew Davis <afd@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl compatible
Date: Tue, 30 Jan 2024 13:51:27 -0600
Message-ID: <20240130195128.58748-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add TI SERDES control registers compatible. This is a region found in the
TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
SERDES clock and lane select mux.

[0] https://www.ti.com/lit/pdf/spruid7

Signed-off-by: Andrew Davis <afd@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c2..d8679a2ad4b10 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -73,6 +73,7 @@ properties:
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
               - ti,am654-dss-oldi-io-ctrl
+              - ti,am654-serdes-ctrl
 
           - const: syscon
 
-- 
2.39.2


