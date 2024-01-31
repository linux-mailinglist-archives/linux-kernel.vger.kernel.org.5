Return-Path: <linux-kernel+bounces-46511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE348440D0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96D92B30920
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5093080C0B;
	Wed, 31 Jan 2024 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQO2HbYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7480BFA;
	Wed, 31 Jan 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708335; cv=none; b=jgGx5r8LqF0CYLjn3Vto9PRSQPUUZanwH+ywsBKenuI2vV3nb4AbPaFu9TZTiJFRto13peL63NeADKZIFt2UYfWesTKXULeG+ZEc2c5QNFH+JIt8DI0GbJYcAYuiKJXAQBhibGbsszyEF6Q7BukjaZZ3EMtHGLyWtKsWY1lshGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708335; c=relaxed/simple;
	bh=cveEm9XYzqaufx9fWhL/pSd3M6JBh+uL9vWXxxLn510=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYgYKcU37ES5LewTEpUSxIUcACD8Rrxc1Hhbey4B4E/LTaWIsgBDb3eTFNlzGBizDGVjaUPcx8mZg/ILTq1tvf0Rxh1Wo68JL6N4HsNCuSNJD0OS1b0WYbQoekvpiF5DJvA8c84heXZJamy74flBveXa6cUH6bESt0m0WVIUSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQO2HbYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE6BC433F1;
	Wed, 31 Jan 2024 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708335;
	bh=cveEm9XYzqaufx9fWhL/pSd3M6JBh+uL9vWXxxLn510=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQO2HbYn8TlZaNSKK4VljVZMWR1KBBRWjUcgtw+kXim93UgjIQV2U+4gvoa/XJ+Go
	 /fwRSuVJ4QvbVjVuIWxWr4sMCzqZ1Nv+5HlYMAqF2Jwq6LIUrE7tX3cs9XofB0QFwa
	 kZBVldQZU2ZIao0vzTfcLZ6fbFleNYxKUaNg/d8z+MG5Eu4Dc7UZ3O02FPUCJtZ9ye
	 /6F/ohRadWj5PR+0LXtiibDE6INNH5LltmYu2Ww3fkYhd7M3PJL9VMIuIFpPLFSQBu
	 ixf8kRIZZksXqCwFLnbgV5lynjNRpZjJgDvtv1Ybw09Q9nX9DJJEgp/fFVEptl7VB+
	 gci2Zl31Ecrcw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] riscv: dts: starfive: add 'cpus' label to jh7110 and jh7100 soc dtsi
Date: Wed, 31 Jan 2024 21:25:55 +0800
Message-ID: <20240131132600.4067-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131132600.4067-1-jszhang@kernel.org>
References: <20240131132600.4067-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the 'cpus' label so that we can reference it in board dts files.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index c216aaecac53..b2d36685db5b 100644
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
index 45213cdf50dc..5a6ff90685e5 100644
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


