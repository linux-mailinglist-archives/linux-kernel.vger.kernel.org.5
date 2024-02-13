Return-Path: <linux-kernel+bounces-63899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C793985362F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661FA1F2819A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16ABBA2D;
	Tue, 13 Feb 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BLSffZfU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401C182C5;
	Tue, 13 Feb 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842176; cv=none; b=O7LsrfCtQZ1kcgYbpkWSYoVXcD7SIE83ZNb3V564eVhBmFW/pW+ukmJRKE/bpgn4tHaJ6xZNIwKZt79sWI3Vh37odhrapo2kVn/31FY7mlLk9uFsg4BU6hgCqNlJz9MiDcTx5ptsgYoFQzI18GiuQkXdkJKKN5m6Laz0p724Lts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842176; c=relaxed/simple;
	bh=tTsD+mIweRSyvF3kzqeplej243uAAw1oTRST1KUyAAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njiP/R1/SwdQgtcchPLfjhwijwhLp85CrjleLuWq6eRK2y74Z51FVjc/k65BdXVs+uXKT5dAFCOXFqgPJC+Wt7roP/wgny0c1bCJykE/wiga0L69VIuGZ7PG3iG9pLkxlmHsELCAoNTEQ5twRelIhtGV2vaOZhDQRYuA+XmBojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BLSffZfU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842171;
	bh=tTsD+mIweRSyvF3kzqeplej243uAAw1oTRST1KUyAAM=;
	h=From:To:Cc:Subject:Date:From;
	b=BLSffZfUMwr5EAZR9bLqh9WTEEwDcB1Ls7ivzoKaHDerfIirHx75fG5uCvV2JPAyA
	 P4XfijvVIefyrhRXzMG0sAveluchRmBSOk03uFu6WmTP3adQg+SJLnY6t1waEgTbos
	 tQ0/QAMf8Eqx1VFGCYAuxrieWWgQUgz2rBvBqlLMyjwXsECIfo4BsTzJ6QW4xOGm3p
	 hjxga92jzqn7w4GMMmEc44qfX6H1g8wtttM1lR0S0lyc/0DqeBOag7ke4q6wqtn+Xl
	 b1f7LDSD1hpLK1dSf0dVfRwaGt7kcVLNe0eW017WgBZ/4ZLAE7oFsonN7DpduIIgiz
	 kQTZeF8z7dbew==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 55BF83781123;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EE76E4800CE; Tue, 13 Feb 2024 17:36:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 00/12] RK3588 USBDP support
Date: Tue, 13 Feb 2024 17:32:34 +0100
Message-ID: <20240213163609.44930-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds Rockchip RK3588 USBDP PHY support, which is used for two of the three
USB3 controllers in the RK3588 (the third one uses a different PHY, which is
already supported). The USBDP PHY offers USB3 dual-role and DisplayPort. The
driver and bindings being upstreamed contains the DP parts, but only USB3 has
been tested by me (upstream does not yet have a DRM DP bridge driver for this
platform).

What has been tested by me:
 - USB3 Type A ports on Rock 5A, Rock 5B, EVB1
 - USB Type C port on EVB1 in Host mode

I did not yet include a patch to enable the Type-C from the Rock 5B, since that
requires enabling proper support for the fusb302. Since the system is usually
supplied via USB-C and without any battery backup, this easily results in
system reset when the power-delivery negotiation happens. As this issue is
independent from the USBDP PHY, I skipped enabling that port on Rock 5B for
now.

You can find a branch with these patches here:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-usbdp

The binding updates introduces one DT warning, for vo1 grf, which is already
upstream and does not describe its clock. Fixing that requires this series,
which adds the necessary clock ID for vo1:

https://lore.kernel.org/linux-rockchip/20240126182919.48402-1-sebastian.reichel@collabora.com/T/#mbc27d87270f7f182fb85bf1ceaf03b902688cbb8

Changes since PATCHv1:
 * https://lore.kernel.org/all/20240209181831.104687-1-sebastian.reichel@collabora.com/
 * VO GRF DT binding: Collect Acked-by from Conor Dooley
 * USB3 syscon DT binding: Collect Acked-by from Conor Dooley
 * USBDP PHY DT binding: fix spelling
 * USBDP PHY DT binding: add maxItems: 1 to gpios
 * USBDP PHY driver: use rk_udphy_ prefix everywhere
 * USBDP PHY DT addition: fix nodenames and property order
 * USBDP PHY DT addition: fix position of the GRF nodes
 * add new patches fixing existing USB2 PHY nodenames/property order

Not changed:
 * rockchip,dp-lane-mux: Why "mux" and not "map"?
  - This is about muxing DP lanes vs USB3 lanes. I kept mux instead
    of map, since that's used downstream and there does not seem to
    be a good reason to diverge?

-- Sebastian

Sebastian Reichel (12):
  dt-bindings: soc: rockchip: add clock to RK3588 VO grf
  dt-bindings: soc: rockchip: add rk3588 USB3 syscon
  dt-bindings: phy: add rockchip usbdp combo phy document
  phy: rockchip: add usbdp combo phy driver
  arm64: defconfig: enable Rockchip Samsung USBDP PHY
  arm64: dts: rockchip: Fix usb2phy nodename for rk3588
  arm64: dts: rockchip: reorder usb2phy properties for rk3588
  arm64: dts: rockchip: add USBDP phys on rk3588
  arm64: dts: rockchip: add USB3 DRD controllers on rk3588
  arm64: dts: rockchip: add USB3 to rk3588-evb1
  arm64: dts: rockchip: add upper USB3 port to rock-5a
  arm64: dts: rockchip: add lower USB3 port to rock-5b

 .../bindings/phy/phy-rockchip-usbdp.yaml      |  169 ++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   21 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  151 ++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   21 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   81 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   22 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  114 +-
 arch/arm64/configs/defconfig                  |    1 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 drivers/phy/rockchip/phy-rockchip-usbdp.c     | 1639 +++++++++++++++++
 11 files changed, 2222 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c

-- 
2.43.0


