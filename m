Return-Path: <linux-kernel+bounces-101606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C887A949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6861C21A0D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3146447;
	Wed, 13 Mar 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3joBS4A7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD2224CF;
	Wed, 13 Mar 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339346; cv=none; b=BN/jCiTfaepURd/+praNwWPcVTN0djY6b/T2JZqC5PF5ub/1j1TjmX0p2YWQsNmuFWIS3xpowiKARFPOAJWavRIN5H9o//JR515xaoDgszzwBD3oJoOhDgrpWiOkjMcM2wnXQveSiMkeJqtb1B13cfcN+3EiGJ8nT3vbckaAgHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339346; c=relaxed/simple;
	bh=b7NxdHsxuVEj+LuKsJSyD0dVHK9bDYyB/Dk/KEcQ7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CQzzO1ubcC7QhHIuolFtNEmqvfx/KGIy6EyOgloJf3RJDoctsCUJkeMnFYuPa/wRwx9cVx/SYPrNZTd38AgNeY2kTDn7Tsf5hNZrC1rVHllhYgmnPVixY0/pQbFykpyGUEYPDhTqPhGGvPtXEDgPiMM0K3CohgHy2MN1NhLqm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3joBS4A7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710339343;
	bh=b7NxdHsxuVEj+LuKsJSyD0dVHK9bDYyB/Dk/KEcQ7o0=;
	h=From:To:Cc:Subject:Date:From;
	b=3joBS4A7AQI2OPNd+35Mda5N2QOE10PxTpYtbQ6DLanGEss/zKMFB9rByJ5TV9BJl
	 7+qp8MP5BcpK1TCQvlx0KSLvp5+2beN4XvpjYH3Yp3Tv8opsAafoPINvDRLM1nW8H0
	 T82KvJ+QknmnxuvKw+Q8sCtvh4IVLGqDX55xdyaw6emhUEE1ybgYesGkb4QBEWyZ+S
	 t+BvfkCbAdpASVVuzi6D1AIhsSgcHpY4tEBQurrFKtjGrVTtJmD1vQe0hxTHJ33DY3
	 C/VrxBuVa/gIxQa5LcUMseObFyjkpiFlBTica4x0A4uM8FHV/PbTf/r+MdgcbJdw+M
	 kQkDhuKLUTbOw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 482E037820D4;
	Wed, 13 Mar 2024 14:15:42 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 0/2] Add missing chassis-type to MTK Chromebooks DTs
Date: Wed, 13 Mar 2024 15:15:36 +0100
Message-ID: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though the chassis-type property is optional, it is useful to
identify a convertible vs a laptop (etc).

Some of the MediaTek Chromebook devicetrees were lacking their chassis
type declaration: this series adds it where missing.

AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: Complete chassis-type for MT8183 Chromebooks
  arm64: dts: mediatek: Add missing chassis-type to MT8192 Chromebooks

 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-cozmo.dts      | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku7.dts | 1 +
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14-sku2.dts     | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dts   | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dts      | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dts | 1 +
 .../arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dts | 1 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dts       | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts        | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts   | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts      | 1 +
 15 files changed, 15 insertions(+)

-- 
2.44.0


