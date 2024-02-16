Return-Path: <linux-kernel+bounces-68100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B764D8575FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719F8284101
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8960179BD;
	Fri, 16 Feb 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QQexl18+"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDC17997;
	Fri, 16 Feb 2024 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064704; cv=none; b=jobbSxUnoiwerRlrlOgfCFNi1RsS/KwjN/y5wZYq/kUfN2BflSzuV54WjQ8DB2aZV45tVOfkN8X+IGkkk5vv6UGgSFU79ybTGRSC/hMrAPJXwUFSz/zuYlA1OnSjxh7bQLtqNQYaYrgQjYXkCG1R5hNph1heOrr8DS5icf9BXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064704; c=relaxed/simple;
	bh=zF1jlBC4MR3RbEE9G2LOcOGXmWMOf3uGqaQw5jA3iaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMM1KR0/9S6AbpeEmyppP9jA+mgvhfKCW2FuHfmGzmOuZq9EJMyToFw09HhphEna6LSN32k9lGCnfiqV2MK+TUAF7DJ1DxlaFrLCg/Uh3L6wCPzR9002846W4/BXtpc/AJd5Ot41Prvb3OCS9nrLhHOUs3Uti0s9TxrM0hYVB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QQexl18+; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OTrG123730;
	Fri, 16 Feb 2024 00:24:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708064669;
	bh=EnulwF4ZX1Es4prfrzEY8loOyxi8M3VOCRRe2MSXbfc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QQexl18+1NmbvstCgA5yqg0A11Vy8JWvBfOLN31hYJjJn6845H63P4H4qryGG3UWU
	 fxAJX6OQCiiiClfB+d6fGTlWrfZ6Mz/lNTXBE6vzqvWooWm77oHW9hpgpykz3sCK0T
	 OaFE6RYbvPW6ka6NnLWpVenOe8hKkziao1a4uFdU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6OTRg108731
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:24:29 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:24:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:24:29 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OSeI097025;
	Fri, 16 Feb 2024 00:24:28 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v5 1/4] dt-bindings: display: ti,am65x-dss: Add support for common1 region
Date: Fri, 16 Feb 2024 11:54:23 +0530
Message-ID: <20240216062426.4170528-2-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216062426.4170528-1-devarsht@ti.com>
References: <20240216062426.4170528-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI keystone display subsystem present in AM65, AM62 and AM62A SoC support
two separate register spaces namely "common" and "common1" which can be
used by two separate hosts to program the display controller as described
in respective Technical Reference Manuals [1].

The common1 register space has similar set of configuration registers as
supported in common register space except the global configuration
registers which are exclusive to common region.

This adds binding for "common1" register region too as supported by the
hardware.

[1]:
AM62x TRM:
https://www.ti.com/lit/pdf/spruiv7 (Section 14.8.9.1 DSS Registers)

AM65x TRM:
https://www.ti.com/lit/pdf/spruid7 (Section 12.6.5 DSS Registers)

AM62A TRM:
https://www.ti.com/lit/pdf/spruj16 (Section 14.9.9 Display Subsystem Registers)

Fixes: 2d8730f1021f ("dt-bindings: display: ti,am65x-dss: Add dt-schema yaml binding")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
V2: Add Acked-by tag
V3: Add Fixes tag
V4: Add Reviewed-by and AM62A TRM link
V5: No change
---
 .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index b6767ef0d24d..55e3e490d0e6 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -37,6 +37,7 @@ properties:
       - description: OVR2 overlay manager for vp2
       - description: VP1 video port 1
       - description: VP2 video port 2
+      - description: common1 DSS register area
 
   reg-names:
     items:
@@ -47,6 +48,7 @@ properties:
       - const: ovr2
       - const: vp1
       - const: vp2
+      - const: common1
 
   clocks:
     items:
@@ -147,9 +149,10 @@ examples:
                     <0x04a07000 0x1000>, /* ovr1 */
                     <0x04a08000 0x1000>, /* ovr2 */
                     <0x04a0a000 0x1000>, /* vp1 */
-                    <0x04a0b000 0x1000>; /* vp2 */
+                    <0x04a0b000 0x1000>, /* vp2 */
+                    <0x04a01000 0x1000>; /* common1 */
             reg-names = "common", "vidl1", "vid",
-                    "ovr1", "ovr2", "vp1", "vp2";
+                    "ovr1", "ovr2", "vp1", "vp2", "common1";
             ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
             power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
             clocks =        <&k3_clks 67 1>,
-- 
2.34.1


