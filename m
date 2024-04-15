Return-Path: <linux-kernel+bounces-145674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D318A595E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B19B21904
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A20129A6B;
	Mon, 15 Apr 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joHMUDe3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A5682487
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713202973; cv=none; b=X+4Z4D28L5MLeYwyE7TRw1YmnYs4H0r0uGp3lJVd8nEffkpSdLJ39HF/e9QeEjsOGsbNQXaT1O2XT8qR3opZhNTtEAaqHK23p848GznjE6MO/+GsnENei2irxyrcUqZyRmV+SdT7SGLY+77LDTXFwCSbsxXI0fnb/m3YYiWhmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713202973; c=relaxed/simple;
	bh=b5rLA/xVoC+OnWb0hZtV4A0foD6WE7RauuxZaOV01Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JEjWSbgBoADLc88rKfIEYw7xg3ljxwixB9GfHWLC1yxK9TgSX/1u//S4REjXg/nOb7tVBJVU1ZqxIR9AcLBPhLTHn+lvxpa5JwukP9Xxmpr7Cs4eXWCxFmXuHmqorbUdxLHRb1WVJlZTKfcv9V5dztAWntkztb1PFmyFfK9QdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joHMUDe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF3DC113CC;
	Mon, 15 Apr 2024 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713202972;
	bh=b5rLA/xVoC+OnWb0hZtV4A0foD6WE7RauuxZaOV01Mg=;
	h=From:To:Cc:Subject:Date:From;
	b=joHMUDe3XpppSRRtQPD1MK47Dqe0DuaSAuEkdvdS+QkgldwdLCa7GWZDYld4zOc/Y
	 C2f+RzkS/7WbglclkVG8xy+L7ipbFF9aMiA5h7WFmvr4DGgd6Z4B+jQ32DdZyikgne
	 Vs6x6Vv1rmX/e+kuXHXsbzubN7QbEGyiFshsw+itXPA3YlTpgV1eWUjEZ8e6RHzebY
	 8FRyTXPj59ZpchT5O80bda4/9uuW48nKKb8JWauEYZ563mYJdrhlXRoM78OCTxh+gD
	 BAGbhjrJBcLe9ggXi9ci+h81/p35HDlrP91bBncIFPxWWpfsVvVSbvLY/kIsCp34KJ
	 /rdxZyjpKbD+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Zhang Yubing <yubing.zhang@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip: fix CONFIG_TYPEC dependency
Date: Mon, 15 Apr 2024 19:42:25 +0200
Message-Id: <20240415174241.77982-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added driver causes a warning about missing dependencies
by selecting CONFIG_TYPEC unconditionally:

WARNING: unmet direct dependencies detected for TYPEC
  Depends on [n]: USB_SUPPORT [=n]
  Selected by [y]:
  - PHY_ROCKCHIP_USBDP [=y] && ARCH_ROCKCHIP [=y] && OF [=y]

WARNING: unmet direct dependencies detected for USB_COMMON
  Depends on [n]: USB_SUPPORT [=n]
  Selected by [y]:
  - EXTCON_RTK_TYPE_C [=y] && EXTCON [=y] && (ARCH_REALTEK [=y] || COMPILE_TEST [=y]) && TYPEC [=y]

Since that is a user-visible option, it should not really be selected
in the first place. Replace the 'select' with a 'depends on' as
we have for similar drivers.

Fixes: 2f70bbddeb45 ("phy: rockchip: add usbdp combo phy driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index a752ccdddb86..08b0f4345760 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -120,8 +120,8 @@ config PHY_ROCKCHIP_USB
 config PHY_ROCKCHIP_USBDP
 	tristate "Rockchip USBDP COMBO PHY Driver"
 	depends on ARCH_ROCKCHIP && OF
+	depends on TYPEC
 	select GENERIC_PHY
-	select TYPEC
 	help
 	  Enable this to support the Rockchip USB3.0/DP combo PHY with
 	  Samsung IP block. This is required for USB3 support on RK3588.
-- 
2.39.2


