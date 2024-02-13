Return-Path: <linux-kernel+bounces-63903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E95C85363C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF8E128CF12
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE276604A8;
	Tue, 13 Feb 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vL7lWKNS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2515FDCE;
	Tue, 13 Feb 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842178; cv=none; b=XNk5TTT5lPkRpncnFpwwSPCu0kN3FyoqcZ277z6R4hgrxfwNuxOuIJm9IVxq8DA8vz6+WPexXSmNk3b1u04Jdn6tKBMAvPqTuxmes31LIJzTudDyFNZwX001STQcGfSYOswcNjCROYQbgIRbNHwtEAVgkEJZaj7Gf9M0T/iMIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842178; c=relaxed/simple;
	bh=6OwzIeJWiBUu4hW9YyYAqgUG6qN2do9w9jwQ6wXw8TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7P0W+yl7Vihcs3dpwpJRCXzdjB0bMauRWf5D0uE4YX+h0xqH5//n7o/FW7lFP5pqcfEPxyNRJXDZqXwehtvXuGc2wEWXVmZAj15zcLyzg2krVo3v9Rex/zYsnjnEsTBgf3Z9dwB8G+77B+JUFiqDNQM1/3JKYQ628CtIJQ59Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vL7lWKNS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707842171;
	bh=6OwzIeJWiBUu4hW9YyYAqgUG6qN2do9w9jwQ6wXw8TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vL7lWKNSfAdUaa2nfCGaCRY6ByRsnvXSHKfM8+vWcMEI+s6MYi8uoDJEAub6vYS+a
	 5Y+Po5svZFwjUL0trMSnAAHmTLunYZEOdeQQB2w9WYMzfZSjUVVdtbRO2fMKb+D0Gu
	 DaO9fmv5wImzX4FpABolp+40Q2L4/l0yHhsVhVaPI9OyP+SY0Vu6EKEINkIKHRCYQz
	 freGhdv8phCyajEoOVqKIya64UPRg0T495fkGRHgtOuue7Ca3E7VvUxRdtrH+DRj93
	 Na7gnqhjMpRNXaLDzImTFCSVKP6OH10/3gIQbVCy08O7SAgt2PNddCvTwUWJ/qVeF3
	 8CMO0s5/1BZ7w==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D868E3782076;
	Tue, 13 Feb 2024 16:36:11 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 037394800D3; Tue, 13 Feb 2024 17:36:11 +0100 (CET)
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
Subject: [PATCH v2 05/12] arm64: defconfig: enable Rockchip Samsung USBDP PHY
Date: Tue, 13 Feb 2024 17:32:39 +0100
Message-ID: <20240213163609.44930-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213163609.44930-1-sebastian.reichel@collabora.com>
References: <20240213163609.44930-1-sebastian.reichel@collabora.com>
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
index e6cf3e5d63c3..07890b86777e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1492,6 +1492,7 @@ CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
 CONFIG_PHY_ROCKCHIP_PCIE=m
 CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PHY_ROCKCHIP_USBDP=m
 CONFIG_PHY_SAMSUNG_UFS=y
 CONFIG_PHY_UNIPHIER_USB2=y
 CONFIG_PHY_UNIPHIER_USB3=y
-- 
2.43.0


