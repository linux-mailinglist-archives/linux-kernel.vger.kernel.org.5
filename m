Return-Path: <linux-kernel+bounces-59784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC584FBBA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734EB28310E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630C08286E;
	Fri,  9 Feb 2024 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MKszrpYt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAA7F48A;
	Fri,  9 Feb 2024 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502716; cv=none; b=tKcY8/AF0mt5WLqmifouwxZ9hsoycij40MvxnTRdud+oHU1HKG6qWceWjHHxDqrlpqxLIBJpuKtUe1XyGLLD/N2q8TpTQSsflHR6dq4aiWlsROdcw6lUuhejbkI46EPfBUoL91hjaPc7ar7iLUS5DZa2BSUkuKTjElrZR0Z4Y4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502716; c=relaxed/simple;
	bh=M3InQbAecp+TY2BOUEnYIx3BHcZ4RcX54rgYLrXzsfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saNqL8Fea+MsT1aO3GP7UrGiRIxdZXMAqDZ/43s8Lvkbpe8TvkbLS/nxheTrzZr89W7DGJjPdMV1Nj6Gp87wq6V342DGI66bou5opFttvdhE62yhZDWGRBX5+KUzfi9T7Tvv+WabLkGvizsimPTn0AmgO33V4tThSEfPmuMMXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MKszrpYt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707502713;
	bh=M3InQbAecp+TY2BOUEnYIx3BHcZ4RcX54rgYLrXzsfM=;
	h=From:To:Cc:Subject:Date:From;
	b=MKszrpYtlVYY7v/zzvGY01LIu8VvHC2+2EXYhAo74BBptZ86N15u50WPBoWZNDTO+
	 2yBi7igqi7z9znLiTLVlql669AaYtIhIRL7C2ejItuHh6+92oWsBIxq0W6BeO7B0hA
	 HBasMi+ili1PESExAdszGIzqb+F3v/6p95WJ5EY8eCJXUhXnPwk6FwMpNEmFdudiaU
	 upIhEPGv5UM3XMMQ8VKrjSv1S/LeH9eWP/05kAzX7ebjlYY/5l1MXAMFP117np/Z3N
	 u9JHH+XJsJSBoYJYnnOhipnvSRkiqAs739WVRVMhpfaAXEtuur3Mi8gyFl5Kl5taDE
	 79Wsi93onWF1g==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ECB7F37813FD;
	Fri,  9 Feb 2024 18:18:32 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8CC2B4800CE; Fri,  9 Feb 2024 19:18:32 +0100 (CET)
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
Subject: [PATCH v1 00/10] RK3588 USBDP support
Date: Fri,  9 Feb 2024 19:17:16 +0100
Message-ID: <20240209181831.104687-1-sebastian.reichel@collabora.com>
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

-- Sebastian

Sebastian Reichel (10):
  dt-bindings: soc: rockchip: add clock to RK3588 VO grf
  dt-bindings: soc: rockchip: add rk3588 USB3 syscon
  dt-bindings: phy: add rockchip usbdp combo phy document
  phy: rockchip: add usbdp combo phy driver
  arm64: defconfig: enable Rockchip Samsung USBDP PHY
  arm64: dts: rockchip: add USBDP phys on rk3588
  arm64: dts: rockchip: add USB3 DRD controllers on rk3588
  arm64: dts: rockchip: add USB3 to rk3588-evb1
  arm64: dts: rockchip: add upper USB3 port to rock-5a
  arm64: dts: rockchip: add lower USB3 port to rock-5b

 .../bindings/phy/phy-rockchip-usbdp.yaml      |  166 ++
 .../devicetree/bindings/soc/rockchip/grf.yaml |   21 +
 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  151 ++
 .../boot/dts/rockchip/rk3588-rock-5b.dts      |   21 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi      |   82 +
 .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   22 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     |   95 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/phy/rockchip/Kconfig                  |   12 +
 drivers/phy/rockchip/Makefile                 |    1 +
 drivers/phy/rockchip/phy-rockchip-usbdp.c     | 1641 +++++++++++++++++
 11 files changed, 2213 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-usbdp.c

-- 
2.43.0


