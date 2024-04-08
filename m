Return-Path: <linux-kernel+bounces-135983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBDB89CE90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D6A1F23753
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCC143C4F;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Toxv8jP5"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12B171B0;
	Mon,  8 Apr 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616674; cv=none; b=sDPTHhtNaZLgZt5pnFKUQ6zPO5tRiUuVPPp9Vg1Ct9Gsf8Lo5zF7Nri9kup9WZYSnZ5NMONAximO7OqdJZ6dz/KskROoppykfD+jfcMRSoC/wTZ1FYc9k0z6zENgnDNekqfvxZA/Z5IAza7ACqmW4cBwZvwgIh3XWHyMtOCTBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616674; c=relaxed/simple;
	bh=dhsop9SQlPpsgm4YRI8kzGbaMb8E3L8hiOp2tMvdQfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=APvRQ83p5w1HU7/QHAh5VPJkXM3z8SVVEO3e4LG3oml2wBMKVopcMxhsWQzi8yvje+BN0pZJL1mL0KmkiMutRBLLuuHYVVma3jYq/0iaULpv8DjEDOHX+XxIAfqnnzhEK9VAl3kxgv/Bn8GOsZfBUhLQFdZkZOVa3vDPlggSVLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Toxv8jP5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616670;
	bh=dhsop9SQlPpsgm4YRI8kzGbaMb8E3L8hiOp2tMvdQfA=;
	h=From:To:Cc:Subject:Date:From;
	b=Toxv8jP5cpKntaUO0B6jcxi4bdmqYLovvAe7TVECbyUD6OVgPGmJ/o470IgiZ5E/S
	 VbwjEC8zO5B87pyr4RnDFt/60e6D6cgiK2AHwmk5ADuDAfimUKZyMfVPgrxWJpUEIH
	 cwBuRQMC32kCegpGd511/lve4qJ2RhM25iie0DBZlGBQ9BIjv1ZjZsociwuJDExc0A
	 PCIhpVTFnimJCXk+yIkNUUTkOifAK/pVjXo9wc3oAU49WUZ14qiQxlJICmWZsYPV4I
	 gWJvF6ycib4ypQoIPfdA1QxulVX3CcfgWKu4fo9DbBJHO5K3EsSnmKCUNvIS6lx13u
	 R2VpbtqCN9eUw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9739037809CE;
	Mon,  8 Apr 2024 22:51:10 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 3A1DE4800CD; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
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
Subject: [PATCH v5 00/10] RK3588 USBDP support
Date: Tue,  9 Apr 2024 00:50:27 +0200
Message-ID: <20240408225109.128953-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This adds Rockchip RK3588 USBDP PHY support, which is used for two of the three
USB3 controllers in the RK3588 (the third one uses a different PHY, which is
already supported). The USBDP PHY offers USB3 dual-role and DisplayPort. The
driver and bindings being upstreamed contains the DP parts, but only USB3 has
been tested by me (upstream does not yet have a DRM DP bridge driver for this
platform).

What has been tested:
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

Changes since PATCHv4:
 * https://lore.kernel.org/all/20240325141653.84910-1-sebastian.reichel@collabora.com/
 * update copyright
 * drop linux/clk-provider.h include
 * replace of.h with mod_devicetable.h
 * re-check necessity of other included headers
 * rk_udphy_setup, rk_udphy_usb3_phy_init: remove redundant init of ret variable
 * rk_udphy_parse_dt: directly return rk_udphy_reset_init()

Changes since PATCHv3:
 * https://lore.kernel.org/all/20240216170514.75200-1-sebastian.reichel@collabora.com/
 * Rebase to v6.9-rc1
 * Collect Reviewed-by and Tested-by from Heiko for patch 1 + 2

Changes since PATCHv2:
 * https://lore.kernel.org/all/20240213163609.44930-1-sebastian.reichel@collabora.com/
 * Drop patch 1+2 (GRF DT bindings got merged by Heiko Stübner)
 * USBDP PHY DT binding: more spelling fixes
 * USBDP PHY DT binding: add Reviewed-by from Conor Dooley
 * USBDP PHY DT binding: specify 3 as maximum value for rockchip,dp-lane-mux items
 * all patches: remove child nodes for usb3-port and dp-port and use PHY cell instead
 * USBDP PHY driver: drop some header includes
 * USBDP PHY driver: rework rk_udphy_grfreg_write to use FIELD_PREP_CONST
 * USBDP PHY driver: add newline after break; in switch cases
 * USBDP PHY driver: make some functions void

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

Sebastian Reichel (10):
  dt-bindings: phy: add rockchip usbdp combo phy document
  phy: rockchip: add usbdp combo phy driver
  arm64: defconfig: enable Rockchip Samsung USBDP PHY
  arm64: dts: rockchip: fix usb2phy nodename for rk3588
  arm64: dts: rockchip: reorder usb2phy properties for rk3588
  arm64: dts: rockchip: add USBDP phys on rk3588
  arm64: dts: rockchip: add USB3 DRD controllers on rk3588
  arm64: dts: rockchip: add USB3 to rk3588-evb1
  arm64: dts: rockchip: add upper USB3 port to rock-5a
  arm64: dts: rockchip: add lower USB3 port to rock-5b

 .../bindings/phy/phy-rockchip-usbdp.yaml      |  148 ++
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  143 ++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   17 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   72 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   18 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |  105 +-
 arch/arm64/configs/defconfig                  |    1 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 drivers/phy/rockchip/phy-rockchip-usbdp.c     | 1608 +++++++++++++++++
 10 files changed, 2115 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c

-- 
2.43.0


