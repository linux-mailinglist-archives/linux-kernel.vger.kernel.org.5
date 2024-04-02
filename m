Return-Path: <linux-kernel+bounces-128637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2445895D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F351F224BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62F15D5CA;
	Tue,  2 Apr 2024 20:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJiiWeU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604FA15D5B4;
	Tue,  2 Apr 2024 20:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088503; cv=none; b=r1MOn4XVho+0U2/qkyubcl0g/TYSwNO1IOa28TjVPNKUALpHSRiF0R78pb08+yQJSqdaOohU2U8cZ2rphgxJ+qdfA6Lpv/NSCnnoN51zKXt8qZlDYdh4234h8USC6UzJI7rzmyZu1etylJi1CSZTQucEi5WCPIZdwBM7b5+mIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088503; c=relaxed/simple;
	bh=KQ8MkFfHUtVmjHF1bf08hGxBFbhRjGYpwN3vypvDjqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDUfPRhnvtDuaH7qGDqwxuKKuyzTxDWKBcE/Cx3EDZjJqSa7kPUV4EX+EHx7rEHUC1tD7jyo6B77mV4ESh5U/ztQXf1TbCHtgnnUDIYYypc8Z825WbUgHuccOrG1v1owk6B0sVzjRFfCaAymraiyDYIP24X4SFSFDCkGcsUqYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJiiWeU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5989C433F1;
	Tue,  2 Apr 2024 20:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088503;
	bh=KQ8MkFfHUtVmjHF1bf08hGxBFbhRjGYpwN3vypvDjqM=;
	h=From:To:Cc:Subject:Date:From;
	b=vJiiWeU5mbXlpO4RuKTQ/nUisO6IOfLiKJPeBpq5HeQrAg1U0Vv6q2DQjzeTvBJAg
	 9hEa9x8P1GTJdZHqmJA4oWOEZ8zs/9gJZLcTv2hzsIx+vpPwcrYvYGHh2za1/Ret8q
	 KwERuXtBStknS04L2u7Mn5JZKFO50h66vxEgo2DYqOGVDFxfIs86nWU3L6c5AtCDhx
	 4eeY17qwKh4uz+mpxkpJ6AqNbn8GmzBEr8GuTwx9wjHxBshd911+kW78tH2PBHt4sU
	 WtaZ9f0QnHhKNqB6BjlfBIqzQzrA2BVufZEdVMrMdh3uqxgzh99pQ1se28+NvhP1JM
	 sg49b2P/JiQJw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] arm64: dts: apm: storm: move non-MMIO node out of soc
Date: Tue,  2 Apr 2024 22:08:17 +0200
Message-Id: <20240402200818.79446-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Non-MMIO devices, like fixed-clocks, should not be within simple-bus.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 988928c60f15..633d8418f7cc 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -112,6 +112,13 @@ gic: interrupt-controller@78010000 {
 		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
 	};
 
+	refclk: refclk {
+		compatible = "fixed-clock";
+		#clock-cells = <1>;
+		clock-frequency = <100000000>;
+		clock-output-names = "refclk";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <1 0 0xff08>,	/* Secure Phys IRQ */
@@ -137,12 +144,6 @@ clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
-			refclk: refclk {
-				compatible = "fixed-clock";
-				#clock-cells = <1>;
-				clock-frequency = <100000000>;
-				clock-output-names = "refclk";
-			};
 
 			pcppll: pcppll@17000100 {
 				compatible = "apm,xgene-pcppll-clock";
-- 
2.34.1


