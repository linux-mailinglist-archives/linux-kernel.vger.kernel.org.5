Return-Path: <linux-kernel+bounces-135984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBA789CE92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58308B221F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCB143890;
	Mon,  8 Apr 2024 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H4zl7AiH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB91D558;
	Mon,  8 Apr 2024 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712616674; cv=none; b=bYfUs43fX5CmZ41RoyRvvzxc/Ut22+jZtMZwS4xWR9zqDHgsRFrRtIqWu7+qBOLcEh/meJ3Vn7BwbE4xSvZgbE9Pqj8vbmyMq/D2XMfMO90khXgdODuOkxEQ0pHUUmRKQkLhHMbA3003qzn/miwb8Uf/EgQMgaxytiO2nFiAq2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712616674; c=relaxed/simple;
	bh=DOQyBmJqMcgpGS+w7kqQ0AoLHI+zmLPm0WGY9FVt1ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfsWCoJSDwGdHURzTn2z522+CnUTy2NG10+kjd7CAD6+ZB/0Xm6DTpQMldBumPsVgZ3sTAxbbMWuZ5AoZmcY+DSk9IL+d0XGBZSd96GBme7q9UTOKKT/Fr9r+TTvguGlSHMfbY6Q7KD6RVvGTmze9zS0xBd0cA6LT6x7zY8COU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H4zl7AiH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712616670;
	bh=DOQyBmJqMcgpGS+w7kqQ0AoLHI+zmLPm0WGY9FVt1ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H4zl7AiHRZ7NMYdl/m7szepNLfoAtnnMjNiJH13JnLSGq1LGW0rTFeURfBvJ3lXCF
	 zqmxCLpQ9iu6cV+xSiJBzN3+Od9d0RYLDdhsJTeQH5rUB1e5P/J31qWzXlxuEHQ49l
	 Ly05X/F7P6nAQglkJDSol/wjfzUEofEc362EI0Achdw0U8zDzJsZBawsiJ5IMFY/7D
	 bjCBL/k4Fyx1IzG5+HPZrgWVvDpppNghUG8qMcZVBUvgVsqTSDKnzceXLdwIZLOkVW
	 pwYbTC7MDxkBWur6euQ4oBWH9JUGtJkreYsZz8OcQguZ5UlrgEnGYP+f0uIDv3qI0t
	 JS5whFyo1Xgyw==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B6D4837820AD;
	Mon,  8 Apr 2024 22:51:10 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 3FAC14800D0; Tue,  9 Apr 2024 00:51:10 +0200 (CEST)
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
Subject: [PATCH v5 03/10] arm64: defconfig: enable Rockchip Samsung USBDP PHY
Date: Tue,  9 Apr 2024 00:50:30 +0200
Message-ID: <20240408225109.128953-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408225109.128953-1-sebastian.reichel@collabora.com>
References: <20240408225109.128953-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USBDP Phy is used by RK3588 to handle the Dual-Role USB3
controllers. The Phy also supports Displayport Alt-Mode, but
the necessary DRM driver has not yet been merged.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..364795edb94b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1517,6 +1517,7 @@ CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX=m
 CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PHY_ROCKCHIP_USBDP=m
 CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
-- 
2.43.0


