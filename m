Return-Path: <linux-kernel+bounces-135973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16489CE68
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4894A283D82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762BF149C78;
	Mon,  8 Apr 2024 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yd3MumOC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C214884C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615372; cv=none; b=iQ4//dgorUVRz4/WB7RlkA2uRwGWXDS8e8+XjFhx9gbiId+HUwPcTxNceOrHn1z483C8B/JNvPaZvrxmkMFzVcwv7yRccG4v076jxehf1Xa6U1FnK/V6pajaWj7Ekzjy8XLdWenTIYnSjtGKiE13fvgMRk3Ar2oXbdsRzI1SFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615372; c=relaxed/simple;
	bh=3COvrdRUXf3EnV72Dbioxkcz2kZLKag4fAKpaIM7UKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2HmGqzPAYUgKlt2zSZnz83v3xg6ErOWqp2+Xy+onxsHrYQ0jJEtiBRLRejp7Ia0RfO6CfXhC+jwJ1rVKfYlk+XFlMql7MIejspWP4xcoM/aYiYJVxpHVC5qC25efzcTJoGJYPDKqk9iPK7QSgS7kMadt9W8l97LuWSuDFnTSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yd3MumOC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712615369;
	bh=3COvrdRUXf3EnV72Dbioxkcz2kZLKag4fAKpaIM7UKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=yd3MumOCP1JO+SiMH/8ecXlW63dJZTbkKearngXIKlyVbnlqqUlcQxVvi6GtpTG3m
	 +i1xSbyI/+xj185A83oZ4Ki8iNeZOWHwr1keBYCi5UynJIra4z9esdRreRhI2pA1Yq
	 UkclNPrI7afzZT3mlBcgTqdz24LZ7U7Z9dGrn3TX9MXI/n2lJ8tzVCpcCbINMXytW1
	 axw0bPOt+MbASXqnCFiTzFFb7SFN3nZcxGAOWHE0bFtN+1d8o2c9ZQ3DQfVEEvYT/a
	 qLRX8WpzviLSYclPljEHyS+BpdtGxBLOU3amBH8O5fUXMK844juIJWCHbWyKTcgfth
	 tjhOEBLTYLmjA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DCCAA37809CE;
	Mon,  8 Apr 2024 22:29:28 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Algea Cao <algea.cao@rock-chips.com>
Cc: linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: phy-rockchip-samsung-hdptx: Select CONFIG_RATIONAL
Date: Tue,  9 Apr 2024 01:29:25 +0300
Message-ID: <20240408222926.32708-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure CONFIG_RATIONAL is selected in order to fix the following link
error with some kernel configurations:

drivers/phy/rockchip/phy-rockchip-samsung-hdptx.o: in function `rk_hdptx_ropll_tmds_cmn_config':
phy-rockchip-samsung-hdptx.c:(.text+0x950): undefined reference to `rational_best_approximation'

Fixes: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404090540.2l1TEkDF-lkp@intel.com/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index a34f67bb7e61..b60a4b60451e 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -87,6 +87,7 @@ config PHY_ROCKCHIP_SAMSUNG_HDPTX
 	tristate "Rockchip Samsung HDMI/eDP Combo PHY driver"
 	depends on (ARCH_ROCKCHIP || COMPILE_TEST) && OF
 	select GENERIC_PHY
+	select RATIONAL
 	help
 	  Enable this to support the Rockchip HDMI/eDP Combo PHY
 	  with Samsung IP block.
-- 
2.44.0


