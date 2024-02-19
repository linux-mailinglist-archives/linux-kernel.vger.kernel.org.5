Return-Path: <linux-kernel+bounces-71971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2285AD42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B65B21255
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE5524B8;
	Mon, 19 Feb 2024 20:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hkAu+vXw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BA150A78
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375050; cv=none; b=CtO7PudCHCE1sAyMZyarN47p7bhO0m0Ykil0lqQ3MM8V3u/qnsvlsY2J9UwYdZBRhx/r6ucXaXHOvVN4rObkybLHaFXpNNJpjTm2Uql3svqoFZAzhO/pZ4qgN1F7eGCjJ4UmT9EpQQNAw6O+LQKXmSdFfuJSbLB2urcIa5/kZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375050; c=relaxed/simple;
	bh=tmU1TAOSo2/1xTTWVq6GYLkUWbf4ZZznDP5eiUCLTNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuuBF/lSPA6WHI10l0WQVvOGDUcf+UcfdYcDBF3bLS60FnZ0ja2yAZpA7ChbcIBi8RjgNq6S8b57bPHeH1Ll02RRvQFzuFfHhxgwpQB5+hSGmfYTloFsZrRav1zIQ/5lkPNnRSu0tYglbtRezvb0QpiljkJqgfzzm3IndVV9Mdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hkAu+vXw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708375047;
	bh=tmU1TAOSo2/1xTTWVq6GYLkUWbf4ZZznDP5eiUCLTNE=;
	h=From:To:Cc:Subject:Date:From;
	b=hkAu+vXwKAEuAMy5kLMyDoyXdErhbrKZ9+kGwesEArRBbCHvXVjTmc0Xd4lJd8Ob2
	 X0eiapSQlw8Qt5aTTi9xwFPiLTlXPI5WB7hTcI59kIn9zSXLX3cF4iAtx3MkeBQLmm
	 SKUDG6CZjTn5+JPnbcnMYznQdTjlPLaWmUVCaq0WHFKFPm5pgNjQZ83vHERTU3gI30
	 2e3sGXoD9mNH8UrnjANc5ZQqbhneEQ3mW1nlSfcNogIjyFussHMLyIaEdaOSTNzqL4
	 x9iy0qmpuoYM+XqigIBENMlKs1TmlJzsDFP6tBcZnkbTMKpnNoyftqQqAzE2cIPFlK
	 5Ec74kFtAMHiQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33FFA3782080;
	Mon, 19 Feb 2024 20:37:27 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] arm64: defconfig: Enable Rockchip HDMI/eDP Combo PHY
Date: Mon, 19 Feb 2024 22:37:24 +0200
Message-ID: <20240219203725.283532-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for the Rockchip HDMI/eDP Combo PHY, which is based on a
Samsung IP block. This is used by the RK3588 SoC family.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 056a6cc546a4..b1f8ff32f940 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1510,6 +1510,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=m
 CONFIG_PHY_ROCKCHIP_NANENG_COMBO_PHY=m
 CONFIG_PHY_ROCKCHIP_PCIE=m
+CONFIG_PHY_ROCKCHIP_SAMSUNG_HDPTX=m
 CONFIG_PHY_ROCKCHIP_SNPS_PCIE3=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PHY_SAMSUNG_UFS=y
-- 
2.43.2


