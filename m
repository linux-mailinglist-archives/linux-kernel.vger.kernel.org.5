Return-Path: <linux-kernel+bounces-126807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E81893CED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9776A1F21C80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92D8481AB;
	Mon,  1 Apr 2024 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5pisUfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0974F47A4C;
	Mon,  1 Apr 2024 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985875; cv=none; b=Ts3hglF6SNr+nH4wvRo0k/4LFXZzdk796w14zcuBRKc2rfAYiSHilFNj3VFiK6cDV4z4qceCO1lJ5YnQlitLsJHGaTdIS1sYRCLqwDhk2wOIrwago20BPjtZMSw9Msd8LUOw174qw7N4SbsxTehliHDzuU/sh59Q/WQE33uYGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985875; c=relaxed/simple;
	bh=AhhaYocEjIqO9rdjPoZ6SpcUsTizNmG30kjKObWFbDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXvIm+ZBlycc368wn6oLJt0RGQOrYwNmEwojEmf7JG16EpoZ2sG2a871FEy9eZ9yGdU9pdHwV5hdnDP70r4x9bnb1YDzZ83i4iD/tCmfxxk45hE6vgWCNdDoqfqnUJb9zhr0Oxi/B11DbFGkCFgzidVSiB6CghMeRTR0T1dvxHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5pisUfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91426C433A6;
	Mon,  1 Apr 2024 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985874;
	bh=AhhaYocEjIqO9rdjPoZ6SpcUsTizNmG30kjKObWFbDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5pisUfHcX8D272f5z+7o5XoAc/4pYmHWE6UeQJZvBFMfsnlVijZ8xY9y6WOjubuN
	 Zc6Hyhv46ZrZ1JkAqMxSd6sARsGT052kiWfF+XppKcwFeMpyaNFviH/KisrmFr6kNk
	 Y1jB3Yj2B4FbWLjB3XVf1xCcMdnPrTB6idGbGIn4JBBePCurbDwCzCk8Wtt3GpwEw2
	 JivZJivyda7nvS7W7k+l+e5S9JzF+F70Xe9w32KyApc4PyaoFL2/tp0zYWtJm6vOwE
	 owNFtO+kb26BrgXOeoyNuu830zFVw1bhn+/b5eTOZRE9oYYf85JCGWNSCfqkrJsuJZ
	 MjwEtMJamx+Cw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 02/10] arm64: dts: microchip: sparx5: correct serdes unit address
Date: Mon,  1 Apr 2024 17:37:32 +0200
Message-Id: <20240401153740.123978-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401153740.123978-1-krzk@kernel.org>
References: <20240401153740.123978-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unit address should match "reg" property, as reported by dtc W=1
warnings:

  sparx5.dtsi:463.27-468.5: Warning (simple_bus_reg): /axi@600000000/serdes@10808000: simple-bus unit address format error, expected "610808000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 5d820da8c69d..c3029e0abacc 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -460,7 +460,7 @@ mdio3: mdio@61101031c {
 			reg = <0x6 0x1101031c 0x24>;
 		};
 
-		serdes: serdes@10808000 {
+		serdes: serdes@610808000 {
 			compatible = "microchip,sparx5-serdes";
 			#phy-cells = <1>;
 			clocks = <&sys_clk>;
-- 
2.34.1


