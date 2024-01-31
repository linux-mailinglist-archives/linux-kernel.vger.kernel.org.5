Return-Path: <linux-kernel+bounces-47388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D58844D30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2111F22401
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE143FE36;
	Wed, 31 Jan 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EMMl91zu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6253B797;
	Wed, 31 Jan 2024 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744424; cv=none; b=JzRU4yzZIhT6oxUsYL8EpZM0GjiOvVH+Yk9dueu054aRnxFfTMqCZlHskpO6XDzkv3+0H0kDZsUzb/4Bw3D6dzu29XqvpU3RZrARAE00MLnT4Psj1pWuwRjfZCYqUjD4GWUdEbhAmHbBXvkJyKnkpjWNx+tSvkwR+DMNU0gD6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744424; c=relaxed/simple;
	bh=1wkE4dZHPNz295biY27Ha/+pIJUNGMuxn6lTJ9kK+Uo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2cmfQ5u9P3VLSnVe8wwNr9xP+cHgMybCJ54B8MbvYIAZPfi0G9RnSVkJu53enpU/6mSjKNL91hcjS0yDz+XznPxQ/KNyatHsFSiPOKiigNYscOwIGMnw0H06vQRh/rzHvIQdcFDcjK1zskjxMofIFI5Z2MqNx9bC8H56jjwI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EMMl91zu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VNeB3x027955;
	Wed, 31 Jan 2024 17:40:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706744411;
	bh=Pmj1+/duzlVC1f4TD5uVGpfHUXq5usmVkrlOFKhwmeg=;
	h=From:To:CC:Subject:Date;
	b=EMMl91zuFjMJfnwYXTaxBQdBF/5D2cawSgqYC+MEZ4KLzeldhT25p+wQhVcEOgCpk
	 lWmac+pdUFa4+jkaRFZI3OyPkKXL0STzuHoqUMT4YkVc0nQU+m/3yEeazbvro6B4BM
	 UV6XZjCK9uIRJ4DohanlPTB8xsJtZkI9DCi+AQlA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VNeB8i123460
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 17:40:11 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 17:40:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 17:40:11 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VNeBd5027809;
	Wed, 31 Jan 2024 17:40:11 -0600
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
Subject: [PATCH] dt-bindings: media: Add sram-size Property for Wave5
Date: Wed, 31 Jan 2024 17:40:08 -0600
Message-ID: <20240131234008.2108672-1-b-brnich@ti.com>
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
 Documentation/devicetree/bindings/media/cnm,wave521c.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
index 6a11c1d11fb5..b1916e68443b 100644
--- a/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
+++ b/Documentation/devicetree/bindings/media/cnm,wave521c.yaml
@@ -43,6 +43,11 @@ properties:
       storing it on DMA memory. It is mainly used for the purpose of reducing
       bandwidth.
 
+  sram-size:
+    description:
+      SRAM size reserved for VPU operations. If not specified, size will default
+      to zero.
+
 required:
   - compatible
   - reg
@@ -58,4 +63,5 @@ examples:
         clocks = <&clks 42>;
         interrupts = <42>;
         sram = <&sram>;
+        sram-size = <0x1234>;
     };
-- 
2.34.1


