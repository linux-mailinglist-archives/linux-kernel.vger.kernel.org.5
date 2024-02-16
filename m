Return-Path: <linux-kernel+bounces-69018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A8858374
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6A61F242CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A41131E47;
	Fri, 16 Feb 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SoC8NIqv"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE54130E4F;
	Fri, 16 Feb 2024 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103122; cv=none; b=VTFPHUugyQPBY4Vv147e0zWFwkjgP/ui0VqJUAPUMgDfITtziwWsYXGWUqpPlPAMJqCWfIXpXxUMk0fM6c12/W9Nek4LoI9CDfW8OzTPpYZyXTizuhY6eXJM1jMkWoz5faMdzVep0uk7LVw4BWQtVOvLbgcOJ+0oc2gDt75rDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103122; c=relaxed/simple;
	bh=Q0pJZKKbSrqejbsMqhljdiTJm9Rv4S7Yia7K5S2iN2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4BzZGGuGACpfi8aQXjm8Lys6uOFX1Bof1x/ogrBuydjIoa7x+4zwu94KqnTdwxTerH88wtj9HkXz0REa+wB0o/Gl24fB6Saz9xCibE+2YZhy9T4MSETw4rt43yrk8QF0ow51m+iZKxrwnxSSyut1cdwl+Al/uag+eqUNBoMvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SoC8NIqv; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708103117;
	bh=Q0pJZKKbSrqejbsMqhljdiTJm9Rv4S7Yia7K5S2iN2U=;
	h=From:To:Cc:Subject:Date:From;
	b=SoC8NIqvAqT3rzNDi7ninBlAIzCROdzElH+nzQOJ9tQzg4ydS+LuG03/X+AB63o/n
	 oH2yQRdCHU6jMHf5rGN0ZR8bUO8lfNZJN/rMfKXuNoGwBk9Im7Qcxah8M4NRgq1uZQ
	 8bTUEROFWFyhXgYYZJ9Ma0Gaiu3oN/6VqaIxjizRWwQ6aI+RmFrISxxwCzf5r6OOYs
	 yaF+HtRmEUCw6qFFa9qNex2Aj6A1QhkDtUb7XTzwGALBW0owRh7ZVWyrYpXNZK4YUQ
	 uvptypmQG87pl89fxjI/dUc79fq8/q+6YWHw66tpOv/oAR1RHYKq5u83Opz0qTq/VW
	 CWH0UIF+f4u0g==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3E8733782042;
	Fri, 16 Feb 2024 17:05:17 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id CFA674800CB; Fri, 16 Feb 2024 18:05:16 +0100 (CET)
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
Subject: [PATCH v3 00/10] RK3588 USBDP support
Date: Fri, 16 Feb 2024 18:01:15 +0100
Message-ID: <20240216170514.75200-1-sebastian.reichel@collabora.com>
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
 drivers/phy/rockchip/phy-rockchip-usbdp.c     | 1612 +++++++++++++++++
 10 files changed, 2119 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c

-- 
2.43.0


