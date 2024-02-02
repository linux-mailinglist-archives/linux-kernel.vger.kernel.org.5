Return-Path: <linux-kernel+bounces-49785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1C0846F62
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE91F23492
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D313DB9F;
	Fri,  2 Feb 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RGEix9zy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2C168AB;
	Fri,  2 Feb 2024 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874508; cv=none; b=fGyXJ9kH8CiI8S9pNbegYZ5sN8wxgM3BwWa4/C4zYGAe76mJgWC/49oe2VaazJL0GuQzMPKJEDc2gwyh+LLFzfXkc5SK4FGOv/K6bhMfLZG7UoQ4N3FXi3wGfAdH4aBf+f6IYy/pGsVc8pjCQS/GLauV7UTyu9lBaYYPNvLfj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874508; c=relaxed/simple;
	bh=iajR0bgdPy77vBNmr8TVPZPrZc0bjA48bs7iKNgDlvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I6ms7FzRvmujyGS4iDbvQqXI0mju+V3oQCIlJmUMNaaGAoGpmqm+Yzic/EEuzgeGQn7+xu5y/0KmbeYWOzVXmLzjfEcJ15FnUefw3hlmkgsP00Tn1x7/jqe30K2hJWaa+VAHLIrN1NuziGXlCmDXTLWb3Pu0Age/iVCuRFoDOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RGEix9zy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706874505;
	bh=iajR0bgdPy77vBNmr8TVPZPrZc0bjA48bs7iKNgDlvE=;
	h=From:To:Cc:Subject:Date:From;
	b=RGEix9zyVbP4jzGSio307EoHs7SJTEZ4BTXUcj0oIrCcemdYc7FkLqaiCybMtBxD7
	 5cUE9iRk2Ov5rA7AQpbop8VUDFOb8ss/P2Thblx0Z1jJ9GeOZ7JLvU8Xq/kVLyYavG
	 ex+9z1yLFmVXXUO/+WChqJqDudFvn0Ew5D+lVw1mufYH3ZERd1ZpklorG7BLWR5PZc
	 ZwWAxJBJepmNX7HDRTf6JQjF1Z72F5z74luo5NKodjqx2db1KdwgSgOBSSNW5pgYg8
	 wGeLa1TCaQOTCkXkF8jxyDbTr9WxDdSEHKBN9ow87FI1rGD5QbkH23IKtB0olieUwl
	 60hdt6ndX4feQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 610A437811CF;
	Fri,  2 Feb 2024 11:48:24 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	nfraprado@collabora.com,
	macpaul.lin@mediatek.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	stephen@radxa.com,
	tom@radxa.com
Subject: [PATCH v2 0/2] MediaTek: Introduce MT8395 Radxa NIO 12L devicetree
Date: Fri,  2 Feb 2024 12:48:19 +0100
Message-ID: <20240202114821.79227-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Squashed device tree bringup per-device commits into just one
 - Removed dependency on MT6360 PD_IRQB removal series

This series adds a device tree for the Radxa NIO 12L SBC, powered by
the MediaTek Genio 1200 (MT8395).
Not all features of this board are included in this first series but
it's already quite usable, as the eMMC internal storage works and can
be used to boot the system (as much as MicroSD external storage), the
connectivity via ethernet and WiFi (PCI-Express) are working as well.

The two I2C, two SPI and the two UART ports are also ok.

What is missing (and what's next...!):
 - UFS storage is not working yet (but eMMC works)
 - Type-C role switching is not yet implemented, driver is there but
   mt8195.dtsi has no MTU3 yet, needs some research to avoid breaking
   compatibility with MT8195 Chromebooks
 - HDMI Input port: no driver yet
 - HDMI Output (from SoC HDMI IP): no driver yet
 - Audio (sound card driver needs some love)
 - MIPI Camera
 - System LEDs
 - "F15" Button

Cheers,
Angelo

AngeloGioacchino Del Regno (2):
  dt-bindings: arm64: mediatek: Add MT8395 Radxa NIO 12L board
    compatible
  arm64: dts: mediatek: Introduce the MT8395 Radxa NIO 12L board

 .../devicetree/bindings/arm/mediatek.yaml     |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8395-radxa-nio-12l.dts     | 825 ++++++++++++++++++
 3 files changed, 827 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dts

-- 
2.43.0


