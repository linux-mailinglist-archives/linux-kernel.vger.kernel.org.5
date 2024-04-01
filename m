Return-Path: <linux-kernel+bounces-126723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8612893BFB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F2828250A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53B45974;
	Mon,  1 Apr 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRNzJcMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE44841C93;
	Mon,  1 Apr 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980658; cv=none; b=c7tLgSN7zZGv6wDUcTgwTSVnDsWuNaWO10Q4qRxcsYFRuQWVlgDimt3Q3iAxUIWIScP/y8+LN4LTMjZ/5H6kQdLMpHvKSl4v/9dF42XlYuFW0hUyafQ/GP59dc5sw66HMoqHmCHyqU47f6vIjaKzYzmET0Ce/w82fLDdbwdOMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980658; c=relaxed/simple;
	bh=IVtRriUMksXPADgIC2AApdpqnh3NPUbU9NQ7oc055Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyxkNMquXp+bD6NcGZUL82031ib8cuMwfdnMNM3eJmgAEQ+kNYjor7Be30nc71H6l+WBJsfPxO3ef4WiovVdjts1g1z+n4UB/CWqKjFsSq6Zsb2gt5TgX9QzBROO/1d5tS+WcoIylHU2ChBBvcQJarDKadB41lqp2a67E/Q2KI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRNzJcMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEC6C433C7;
	Mon,  1 Apr 2024 14:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980658;
	bh=IVtRriUMksXPADgIC2AApdpqnh3NPUbU9NQ7oc055Wo=;
	h=From:To:Cc:Subject:Date:From;
	b=gRNzJcMkdaOU6pzmIVay8PGTyMNztGo2kKcE6ZPoSu83YzaBeVSO6IL1UAePbzaL/
	 bZaK1oMhEzPHYrRfQZLjs3WL86+G3IfTimHUsyr6XiBDAb2o3hmoq/GKl2QZ7NbUkI
	 0KJPUSIij/+KW7tYB1cjv25fEt3Sz4Ra73+7+z8rTtymGY3piPNn9OnmrgZPnQwdS5
	 bMcv/6C9Umu953JI3FoRANACO+x/yDqqYHKmwuk0qS/FDA5lLUGkfgx2npzJ4d2Mtv
	 lEU7isoAukQVs9bQ/m4rLw3DmB8j862A9LXAsmGJXpDKAe2P+v8OsIguViw3Sm8Tem
	 swYnYktdiIZLw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/6] arm64: dts: marvell: ap80x: fix IOMMU unit address
Date: Mon,  1 Apr 2024 16:10:46 +0200
Message-Id: <20240401141051.98233-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the IOMMU device node unit address to match "reg" and fix dtc
W=1 warnings:

  armada-ap80x.dtsi:64.24-80.6: Warning (simple_bus_reg): /ap807/config-space@f0000000/iommu@5000000: simple-bus unit address format error, expected "100000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 7ec7c789d87e..fdf88cd0eb02 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -61,7 +61,7 @@ config-space@f0000000 {
 			compatible = "simple-bus";
 			ranges = <0x0 0x0 0xf0000000 0x1000000>;
 
-			smmu: iommu@5000000 {
+			smmu: iommu@100000 {
 				compatible = "marvell,ap806-smmu-500", "arm,mmu-500";
 				reg = <0x100000 0x100000>;
 				dma-coherent;
-- 
2.34.1


