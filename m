Return-Path: <linux-kernel+bounces-53149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D684A144
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF93F1F22413
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BA34776A;
	Mon,  5 Feb 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J9JvkDWS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D610347F65;
	Mon,  5 Feb 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155263; cv=none; b=LsT4WRs7fgQKrUtXJOonExofPeOdfkEW0sBoN2kgIJASeHwjoMaP9vcg3j7bcRMKT5chTFKeryYZP4F5in+n4Sc8GmaHAFEBGbFgRcJNijpk2ksOmz68ABiuFUwQRgacZVeAzjcFtNEbMhjWTyaZmjAfjWNiBgWy78x0Agt5yjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155263; c=relaxed/simple;
	bh=YpsJ5rrhvnwm3CEQDi1vtoMaQQzBBytIsVxNIQBRWgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G7CeYnrFhBiF1G835ZxrFsfXLatV1fO29TI/pPV1SLJ3vLqqGQye6yn/7Ux+5L4edBi4LqHxGzawGblDjtaOgd4k2XQ6LYiZNokdrBgL+crJ85G6H39nq19X9W22SjSjPT/F3hdgO2foORnjUJgWNqM7edRiB1GAL+MsgYQczXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J9JvkDWS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415HlcCp072573;
	Mon, 5 Feb 2024 11:47:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707155258;
	bh=CrLHI5IlYFh0JmFLjzA+CyGW1qaSRf/T+8TS6eYTKzA=;
	h=From:To:CC:Subject:Date;
	b=J9JvkDWSSISqHL7zLQ6J9Md7aekABzge2GBLeAqxSdNc0rNq/OoqiAeeDJl7aKhyY
	 tJtSjXl2Qks3jzGKO/fI87BgW68JTxc6sshqj9LdhW/Dcoxd4d+4RPrEWNzVrJGlsn
	 kwDXVrFIa/tjCxDtUTlVvetclfImThW0lMrKQmTI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415HlcRm075770
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 11:47:38 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 11:47:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 11:47:38 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415HlbsN128871;
	Mon, 5 Feb 2024 11:47:37 -0600
From: Andrew Davis <afd@ti.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH v2] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl compatible
Date: Mon, 5 Feb 2024 11:47:36 -0600
Message-ID: <20240205174736.27749-1-afd@ti.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes for v2:
 - Add Acked-by
 - Split out this patch as standalone for MFD tree
 - CC right maintainer for this

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


