Return-Path: <linux-kernel+bounces-68099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36D18575FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9602840D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221D91401C;
	Fri, 16 Feb 2024 06:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lW2hyTBP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B61798E;
	Fri, 16 Feb 2024 06:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708064703; cv=none; b=C0SQmJlboBr2ftbAgcGMUCpGynM5GaV+xZ4YrpeAh0xKXfIl2nizJ6s2BAl38BAxuF5uvnYO3SdHlzyyyP7kNq1Ilpe8Yl84DYPKlwUMMih0Ci/8KhgTJeBco32M/sglmyQHWUtqwkrBOG/z9PBzKfc+zVyCKt3oAiV9ntzU588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708064703; c=relaxed/simple;
	bh=jGydsQsULFhhzZHRvPpUBaHVpLVTzyKcgXxHDL9pxxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSDgX7gcGj3KslXO1tlW99DZhaK/Ff7nvgskxhG6ESb82UNuGRUJLm49ic4nGVgDzV+Ekeho3BAtXg64koYoKrNHk99N+XyrV+O93aiAhUtvPmhm58LEYPOr9r9+FbRQ/fT1KQE9gZs37LzIQOfUPjuGdMn+A/VvzEv1/6/Tcko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lW2hyTBP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OW4t111895;
	Fri, 16 Feb 2024 00:24:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708064672;
	bh=TOOEaNpDntJQL+lxK7SQvuAf83A+vWd37eaG8FX3ejM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lW2hyTBP9pLg4Xd8ruXXNOBUBgcsOAohuQWX8czACql4F+OazqhsKLteJ/67G/gbQ
	 bJ4T1Ppbb5824/pX/HG9s2Ek6MF9cArcM4huLt0eo/uzAb2kGRfZ2Oezo4OGAIy5Ws
	 C5rjrLZEAd31ADp1K0FmKsoAknEhLTwKGwNgR4T0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G6OWB2108791
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 00:24:32 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 00:24:31 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 00:24:32 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G6OV7l039873;
	Fri, 16 Feb 2024 00:24:31 -0600
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
Subject: [PATCH v5 3/4] arm64: dts: ti: Add common1 register space for AM62x SoC
Date: Fri, 16 Feb 2024 11:54:25 +0530
Message-ID: <20240216062426.4170528-4-devarsht@ti.com>
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

This adds common1 register space for AM62x SoC which is using TI's Keystone
display hardware and supporting it as described in
Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml

Fixes: 8ccc1073c7bb ("arm64: dts: ti: k3-am62-main: Add node for DSS")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V1->V4 :
- No change (this was part of "arm64: dts: ti: Add common1 register
  space for AM62x, AM62A & AM65x SoCs )

V5 :
- Split this as a separate patch from "arm64: dts: ti: Add common1
  register space for AM62x, AM62A & AM65x SoCs"
- Remove Reviewed-By tag as patch is split now
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index fe0cc4a9a501..8cee4d94cdd3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -779,9 +779,10 @@ dss: dss@30200000 {
 		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
 		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
 		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
-		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
+		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
+		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
 		reg-names = "common", "vidl1", "vid",
-			    "ovr1", "ovr2", "vp1", "vp2";
+			    "ovr1", "ovr2", "vp1", "vp2", "common1";
 		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 186 6>,
 			 <&dss_vp1_clk>,
-- 
2.34.1


