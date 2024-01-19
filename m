Return-Path: <linux-kernel+bounces-31520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F1832F71
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DE22871F0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3648456B6D;
	Fri, 19 Jan 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Rxgl3i8Z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06E61E480;
	Fri, 19 Jan 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693094; cv=none; b=iYlj4gCV8tsFqvthbScyJcirrcqAZhnma6NX3TpmcXbXYdpJIdhzD+GWgdYPWnmPm8tn7jqTFkR4SOtEXBYyJJeeMDB54s4fu9y7OGu7a9FAXZAcJuDklb6HKazP7PFLZcJ+mAzBZSlWQm8TVXwf4RkErAFQEUlGhEGA2xK4DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693094; c=relaxed/simple;
	bh=MSkJacugMshatNwZ3mm7fqSw/GZZCUd/n7oLLvxCAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/14jxrzlX9J/grTz933y0HY4nyQ0dI1bRfTT4B1aJx4pOgPfwLy8t+zWemi86DZthK04BzCwdd9dmMG/vkeNu+UW/Z2XIzJtR6KjLqaYqw5xskao9cjBBLykksP2HFpPUIwXeilIUV0AwkaVBEkVk956VtnuvHo3NK42udVG3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Rxgl3i8Z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705693089;
	bh=MSkJacugMshatNwZ3mm7fqSw/GZZCUd/n7oLLvxCAvs=;
	h=From:To:Cc:Subject:Date:From;
	b=Rxgl3i8ZC+YWiCP+rPTZ2QDTXukFQrh1bPTN/H/BfTmKLhgU6mtTkKt8M9ewAtG2D
	 v9bHvVKanfq7euV1l5e5F7hgbHIsoyYmUYgr6O9zyVcmalzptdw+irJ1OZ8LDYPe4w
	 +LsczR86kyGUquu21EjkMK0/NvSzblrPC8Z9/Y+gML0e4thm0IsqRv9BSqgRUqJPAB
	 PJZ1BP4kmAcvYp801UIHTQr5vSjW4XLzeyvCxGv/+ju/iiZga4KLPFdqi7pYDHs+kq
	 G6ugB+C1lFT2wWgprRXLvfKh0SwUUFTbyjJ9hdSX9d81zGN4Z9yHrkAfMPTvkxN21j
	 dOVpZAOHWO9Vg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DB8A03781FF2;
	Fri, 19 Jan 2024 19:38:08 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Johan Jonker <jbx6244@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/3] Add support for RK3588 HDMI/DP Combo PHY
Date: Fri, 19 Jan 2024 21:38:00 +0200
Message-ID: <20240119193806.1030214-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver and bindings to support the Rockchip HDMI/eDP TX Combo PHY 
found on RK3588 SoC.

The PHY is based on a Samsung IP block and supports HDMI 2.1 TMDS, FRL
and eDP links.

The HDMI link has been tested on Rock 5B and EVB1 boards.

Cristian Ciocaltea (3):
  dt-bindings: soc: rockchip: Add rk3588 hdptxphy syscon
  dt-bindings: phy: Add Rockchip HDMI/DP Combo PHY schema
  phy: rockchip: Add Samsung HDMI/DP Combo PHY driver

 .../phy/rockchip,rk3588-hdptx-phy.yaml        |   96 +
 .../devicetree/bindings/soc/rockchip/grf.yaml |    1 +
 drivers/phy/rockchip/Kconfig                  |    8 +
 drivers/phy/rockchip/Makefile                 |    1 +
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 2045 +++++++++++++++++
 5 files changed, 2151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3588-hdptx-phy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c

-- 
2.43.0


