Return-Path: <linux-kernel+bounces-46514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F708440CC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96C231C25BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6638289B;
	Wed, 31 Jan 2024 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv9KVagM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE608288C;
	Wed, 31 Jan 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708343; cv=none; b=mk9dqbpaNykZK/3N9sOmO9lSD1BwCYnnwsz7Hoxj345Y7lbWBHwOoknAObaepC4XSnkqn08ZAH1Irs3E+UHmg1Tr1M/8ny1jMRHNdhiVaNpJZIhQqLzSWdrn9yQy3nyxSvyiHl0cNwjvJMl0XSX0fRib7p0zi+GU+27VljvolGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708343; c=relaxed/simple;
	bh=13OUnsu4tCIrpbyuApz07RJcqNYojrwlsLe/2mWWH+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ermbYuNqlvxAXakoY7qW6BcID1Z8Te+zPXubd3DxoPdcJhLZd7taG0ncQ+5Zj48l5/7AmZMhBk0gvI9o4o53VYTsD3/D1oPgWGByR2BkAHb57rNnWGzEWH0Nnom0oZxvJfVipc1jiHwx3OGEqBbX/N43geOaHlIdYMukrbK0Fnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv9KVagM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B7EC433C7;
	Wed, 31 Jan 2024 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708343;
	bh=13OUnsu4tCIrpbyuApz07RJcqNYojrwlsLe/2mWWH+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lv9KVagMAcmv/uJXGdauMwhW96ZNGAh9TDxF64Vg7X9/ZWcr4nxYQGANP6qXs5kZF
	 Yet1qsOQsc63Uvy6SryyZo1/2g27vrDMJE8Ue1/ZzMDkQ+idnojyEw159DNE3E+qxD
	 ItUDiI7Oh2CFoZVlML2a3mdzsrgCezX2xdp7seFpn+Jy59wcxiaBf1UniBcjS/h0Bf
	 Clr0OILfc2oECtpo2SzjLNyQl25VssVOTJTw8ALT9YrhGndsiUY2ombbb6JFIhgIuA
	 O1Q1U5qlOrsWcnn843Us5cBFPu0mHgF8648eJctJifKo5Oky7onAlHXjVHufufAJd6
	 w787kKPFD71GA==
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/6] riscv: dts: starfive: visionfive 2: use cpus label for timebase freq
Date: Wed, 31 Jan 2024 21:25:58 +0800
Message-ID: <20240131132600.4067-5-jszhang@kernel.org>
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

As pointed out by Krzysztof "Board should not bring new CPU nodes.
Override by label instead."

Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi   | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 11db93966dd6..974851a764e1 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -26,10 +26,6 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	cpus {
-		timebase-frequency = <4000000>;
-	};
-
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x1 0x0>;
@@ -69,6 +65,10 @@ codec {
 	};
 };
 
+&cpus {
+	timebase-frequency = <4000000>;
+};
+
 &dvp_clk {
 	clock-frequency = <74250000>;
 };
-- 
2.43.0


