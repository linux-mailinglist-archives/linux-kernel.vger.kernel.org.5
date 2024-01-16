Return-Path: <linux-kernel+bounces-28034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0B82F95F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C731C20D62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C225F87D;
	Tue, 16 Jan 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obZvqFB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7425F868;
	Tue, 16 Jan 2024 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434952; cv=none; b=Dwx3OctUxf3xGnpVK9XZR4IDCdwufU+Kn/W+7vtqD1jk/hOiFWlur7+mlxN3BJWAxhIfTI3K3dFaHXg5oH1MFdMr0u8ZxVz3vZlsNktJr+/BetMZIxxbkCsTXO9GQ2Gn+0OIJIRNS8FeLugA9Ow65J4qu8E0wub7oVAbHU4+DZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434952; c=relaxed/simple;
	bh=6KvtWEbEwamHs5J3mro6bLcfhszM3xwzCH1QaD/thUM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tJqpul9V8oGKIGPLeeRPnzsYovsZIg5gZo85NKaFgkVrJ/rrejfPb6xXzVf4+c47w/9MBCjXv9aFnKTTU1tOaZrgo2WPbCpobOB9/5kwXSv1PRMlRPBDxtAkLQ5DNiRyH8zv4AYbHahzIwvBoLzkVOCuV0CeX54VBgcSiy3e1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obZvqFB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BDBC433C7;
	Tue, 16 Jan 2024 19:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434951;
	bh=6KvtWEbEwamHs5J3mro6bLcfhszM3xwzCH1QaD/thUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=obZvqFB/5CuNvnbe9RuNlQPqZeu1G27UJsscR2HA7U4QUTOsYOZa1w7+wTbk4r+5f
	 iRWEBLQ7KN9YAeCPD5Ay6akZbUVW2SdysSI1H6yINnxdw512+ecct3tLmx66gq5nvW
	 CrQC4SbzaufvXR+wLLs/doLFSNLHwiqYDtYrKhe3Qbvilo9lwZRCp8YXpTDPraNL/s
	 uZxtihsVnzbsQv8bg/R7YrbgIp9cuOsO2H5Fl3XRdX9bkS+FOepvTd6O2pnlC6ZGUF
	 5HATyMlsC3JoBmkTOc9Ah6q/d4wdZZUMoJh2wlxcJt2ptoj6vnS6IKZ2aAlG4yQFND
	 cFkiY6a6dZpvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 17/68] ARM: dts: imx7s: Fix nand-controller #size-cells
Date: Tue, 16 Jan 2024 14:53:16 -0500
Message-ID: <20240116195511.255854-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Alexander Stein <alexander.stein@ew.tq-group.com>

[ Upstream commit 4aadb841ed49bada1415c48c44d21f5b69e01299 ]

nand-controller.yaml bindings says #size-cells shall be set to 0.
Fixes the dtbs_check warning:
arch/arm/boot/dts/nxp/imx/imx7s-mba7.dtb: nand-controller@33002000:
 #size-cells:0:0: 0 was expected
  from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 44085ef27977..4b23630fc738 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -1283,7 +1283,7 @@ dma_apbh: dma-apbh@33000000 {
 		gpmi: nand-controller@33002000{
 			compatible = "fsl,imx7d-gpmi-nand";
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			reg = <0x33002000 0x2000>, <0x33004000 0x4000>;
 			reg-names = "gpmi-nand", "bch";
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.43.0


