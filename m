Return-Path: <linux-kernel+bounces-161635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2FA8B4EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5EEB20EB0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6C7F;
	Mon, 29 Apr 2024 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcmgcnRl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD762CA4;
	Mon, 29 Apr 2024 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714350410; cv=none; b=NIsTBWqoKv49lD11awDSbBBMgOV4P3mcn4nEoF2Sg0WXcKPNamjdWHbma+bWqRtIUTivDFznXYnKElJFGegLD2smuavWqjZBexsQFafLFcPk2lbO8tjohsjfG8Oztz0Zpgama0u/6QoooQvOotTBFZfSVFvpuOdT0uXmBeI0epY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714350410; c=relaxed/simple;
	bh=X3AMkYS2CfMdu/dFK6C/Hj93fNJfuxImVPaXP7FNbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ4HDue8JM8IQQxhGJoX3pdxoYlEoMHfU+YHzZfjjSDoVEIiZh5Hr5FxBxdo0hPjqNV2kZ2B6jA+K9VNHG5CHSiy4TV/aq7L1L6QmU0Pfq77waYwQ5yGmiZSfLRpQen4xNe0UOtw+WK23CFSZxP3oBegtf5pjUVbXi2DZyItnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcmgcnRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B3CC4AF1A;
	Mon, 29 Apr 2024 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714350410;
	bh=X3AMkYS2CfMdu/dFK6C/Hj93fNJfuxImVPaXP7FNbJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UcmgcnRlk5rIHJlGJVFhYITXl6GACJ58+t8FxAQ/zuyIssQzkRWrISvkCTP/hpWkY
	 BdaZfPeQ+YN2ao0L9Ai5H7V72IjxyPo33TxwAJeRsIV5JOi12DzbXvxSKvuxWGRu52
	 z/I7aMzYIV2neP5wMq6NOYepXeOw9WPJfg603yTrVm/J5PEK+8qpujMdOk9nw/pNd2
	 MQvlJBIFHE/ap728D6zrRe6fiBL8F6UdCJLsFeX9D2gk+VdCvygaHWToDQeCsYRgtn
	 fRqP+O2y+mVdiHbWaRSbpDLV+0Oop3p+jpPqU/nRI37+PuzOW1aSPFWK5cNNRbRxC/
	 mP1FBxi0GML3A==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Subject: [PATCH v4 1/8] riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
Date: Mon, 29 Apr 2024 08:13:10 +0800
Message-ID: <20240429001317.432-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429001317.432-1-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 'cpus' label so that we can reference it in board dts files.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index 9a2e9583af88..7de0732b8eab 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -13,7 +13,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4a5708f7fcf7..18047195c600 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -15,7 +15,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	cpus {
+	cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.43.0


