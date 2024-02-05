Return-Path: <linux-kernel+bounces-53865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF3B84A767
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA26E1C25520
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FD180030;
	Mon,  5 Feb 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o9nUTaQn"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF327FBC9;
	Mon,  5 Feb 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162454; cv=none; b=qLfVD8eUhmmLMLm93o1YIeQk6iftjTHAys8S58NeLu5aVVQaXJlLBiZi8f8XHkUr+H8QapR0ckGpIrWSyy1Wg5du5pat2aU8Bg7pNsmlIF+YIrVU14Gpr4l6PxNVl+R6F9lumcQjL6KiSOxq7rTz/ny4H+N4veAhiQYIU/n91Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162454; c=relaxed/simple;
	bh=oJPOGf1OZMQrzYakhTdzQai8tPdhosGDY8cCN4PWgM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbvN/CgNotJ1IqD6I3ahSiTYOj9NJkbOn3LN+QXGIoevpzARUiZhj68cNiALIKGO4qUlQ9ATov/2j/3MYsjhLJSNyvSnjGZiTPElbQ9+2bRAxsznq3DIJ4f6vH+jcqUmutAUM7xa0WVrvoTv+CLdw1ttGiOvWKjOGCYseuWwqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o9nUTaQn; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415JlCC4101788;
	Mon, 5 Feb 2024 13:47:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707162432;
	bh=X0ZDhYd/CmxotUP8jOncDjthXoM0DCe9N8UoVJxBaxo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=o9nUTaQnOMNdncF1PE7JqdG2qRuiwGDMWWsP8NrWQsvl3I4RHcvAFzTDHemut4RsP
	 jeXLhLE5cwst/HpUeYbRcKX3VNdaDI/C+z5C2eis01s1wL6XEWRhih4a6Z5Fkz/mxD
	 lBlkWUOjOKhsJOECkfNWNJUQd+hKJJSgkFSNq9lI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415JlCHj093357
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 13:47:12 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 13:47:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 13:47:11 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415Jl90Z037073;
	Mon, 5 Feb 2024 13:47:11 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert
 Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?=
	<nfraprado@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Darren Etheridge <detheridge@ti.com>
CC: Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v4 2/4] arm64: dts: ti: k3-j721s2-main: Add Wave5 Video Encoder/Decoder Node
Date: Mon, 5 Feb 2024 13:47:04 -0600
Message-ID: <20240205194706.3605309-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205194706.3605309-1-b-brnich@ti.com>
References: <20240205194706.3605309-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Darren Etheridge <detheridge@ti.com>

Add the Chips and Media wave521cl video decoder/encoder node on J721S2.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ea7f2b2ab165..df4cdbf94539 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -716,6 +716,15 @@ main_i2c6: i2c@2060000 {
 		status = "disabled";
 	};
 
+	vpu: video-codec@4210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x4210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 179 2>;
+		clock-names = "vcodec";
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+	};
+
 	main_sdhci0: mmc@4f80000 {
 		compatible = "ti,j721e-sdhci-8bit";
 		reg = <0x00 0x04f80000 0x00 0x1000>,
-- 
2.34.1


