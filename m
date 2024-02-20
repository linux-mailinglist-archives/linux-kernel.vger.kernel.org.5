Return-Path: <linux-kernel+bounces-73580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5685C475
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5122A1F23BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDEF14A0A3;
	Tue, 20 Feb 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JwGjKNWK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF3A12838D;
	Tue, 20 Feb 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456536; cv=none; b=bidiytLESlDSaR6Eb++T/EuivkSFpu3gEWRM6v/d8reL32c1rxnBpcEBgy6N0Y+tsEpgMi1VKnmdFXgKdKtC6hqFoYZ+oyV1LwHMedmEyMiGrJtQilFQAnyTvanVwzmB7P9M7g9LyYgtmhjGbb9mmdHAg6dJfV/bEoLzN+EoWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456536; c=relaxed/simple;
	bh=4mMHggARcEC4JqnZzw2vTkGJ+iKm+3BcFF/VShA1GNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgtXfUslvlmdExTI7wOumMn8XTnI19DdLG1yUBqzs9wyWbrmldW3JIegSjoRTToZMS4KLKRfN9wyKvWymjLqr5H+qTMBKlqxKmcdeQ8Rj0RWfk/TM57kfZPqST0YUVmUYsc7O1o8YDXQ0NLNCEL8ZTSdz3rlqemv+7ev0mybOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JwGjKNWK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KJFDPh001091;
	Tue, 20 Feb 2024 13:15:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708456513;
	bh=2n7WuAm0q+DPielbyc0Rg3dgXK0lZuNUv7v3xgAAS2U=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JwGjKNWKYsBQZtAyIsGwc00P2r6g1jY3ZqWrbjQvOEl2vL3scDd7nXCOUxgEJulSa
	 qHiTP3ObIQauCgjXZfHxs/RcHaXKDzldk1HRZWS/HeD0MexRCY0BvefTlTZkJHebEu
	 oBbAPSraTKDzIgbzIiVek8pt0tKaYNTa0MQxG2J8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KJFDZg076261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 13:15:13 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 13:15:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 13:15:13 -0600
Received: from udba0500997.dhcp.ti.com (udba0500997.dhcp.ti.com [128.247.81.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KJEKoQ051513;
	Tue, 20 Feb 2024 13:15:13 -0600
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
CC: Andrew Davis <afd@ti.com>, Brandon Brnich <b-brnich@ti.com>
Subject: [PATCH v5 3/4] arm64: dts: ti: k3-am62p: Add Wave5 Video Encoder/Decoder Node
Date: Tue, 20 Feb 2024 13:14:12 -0600
Message-ID: <20240220191413.3355007-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220191413.3355007-1-b-brnich@ti.com>
References: <20240220191413.3355007-1-b-brnich@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This patch adds support for the Wave521cl on the AM62P.

Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 4c51bae06b57..fd346e01e44e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -891,4 +891,12 @@ mcasp2: audio-controller@2b20000 {
 		power-domains = <&k3_pds 192 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	vpu: video-codec@30210000 {
+		compatible = "ti,j721s2-wave521c", "cnm,wave521c";
+		reg = <0x00 0x30210000 0x00 0x10000>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 204 2>;
+		power-domains = <&k3_pds 204 TI_SCI_PD_EXCLUSIVE>;
+	};
 };
-- 
2.34.1


