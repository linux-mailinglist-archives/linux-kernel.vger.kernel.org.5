Return-Path: <linux-kernel+bounces-126708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C8893BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E2A2821A6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6E142064;
	Mon,  1 Apr 2024 14:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Joh6FUHs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119043FE5F;
	Mon,  1 Apr 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980544; cv=none; b=YIm7A8ZtY+USGyWnIQozHMmO6pKNgTj2np/oOejJt5OsgjtuQSeFpJwRXIHhx3p9+1hyYKgVb+HptSAZk6ukZlHyzGh99wm6rn8NteJTAbwBJEw0jjLTBa1qH9xv2f73ntvQbh8Rpg9TgVf8DiLcfP+WwDS+ow5lb4Pkw4CQa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980544; c=relaxed/simple;
	bh=ONagSjBbuAOK22vxfdcxGOHSR0JO6sqZwUIbRiywK60=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZVDJGttIzuYh7bBIZc3ppyo/K4QaV3UArPA3pEmW9qNw2yrlT3LrqleEv6NdSyP+R8XO/2wzmRbAnaZLjg9t6RyenyhdjdIqryvUOs9qlfwJMdAXIiVf6vE9aSH0F7KwktZ6FtvBOoFZIadOy2mo7iopVo19NmkOf9+0ARodtBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Joh6FUHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF416C433C7;
	Mon,  1 Apr 2024 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980543;
	bh=ONagSjBbuAOK22vxfdcxGOHSR0JO6sqZwUIbRiywK60=;
	h=From:To:Cc:Subject:Date:From;
	b=Joh6FUHs2IqizXp0hxaAbcEiT8AERojlhQqMv+kVbjux9wLShK/vXUpIiDFxbygvg
	 fcP4iasnpuVm7LGbNA5V4VehmtOrVX/5BrvNz+bKjrzZKN5Jp0BmYTXj/Algu7+L7N
	 qw9Mu955GQz3teRGLcAge50vx8XFMw+ayzK+UFquW0o/heMrBRH+uu8U+TCj7g6QZM
	 MvyjYhaUA0fEDlGQxS00Fja9sMGJwIoWbK/Ioz+r9RYmf8uF9bDtYQfuKqwKrHIzZi
	 2k3bD61EqxP/TdJw4MfFCZTqdRDsYa0yPKTHtKx4CgDTtqyc7/NAo8EAAvaSw51LoR
	 qCZx0i8Pw98Zg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: tegra: correct Tegra132 I2C alias
Date: Mon,  1 Apr 2024 16:08:54 +0200
Message-Id: <20240401140854.97107-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no such device as "as3722@40", because its name is "pmic".  Use
phandles for aliases to fix relying on full node path.  This corrects
aliases for RTC devices and also fixes dtc W=1 warning:

  tegra132-norrin.dts:12.3-36: Warning (alias_paths): /aliases:rtc0: aliases property is not a valid node (/i2c@7000d000/as3722@40)

Fixes: 0f279ebdf3ce ("arm64: tegra: Add NVIDIA Tegra132 Norrin support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 4 ++--
 arch/arm64/boot/dts/nvidia/tegra132.dtsi       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 14d58859bb55..683ac124523b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -9,8 +9,8 @@ / {
 	compatible = "nvidia,norrin", "nvidia,tegra132", "nvidia,tegra124";
 
 	aliases {
-		rtc0 = "/i2c@7000d000/as3722@40";
-		rtc1 = "/rtc@7000e000";
+		rtc0 = &as3722;
+		rtc1 = &tegra_rtc;
 		serial0 = &uarta;
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 7e24a212c7e4..5bcccfef3f7f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -572,7 +572,7 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x0 0x7000e000 0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


