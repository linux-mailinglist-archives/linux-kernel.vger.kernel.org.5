Return-Path: <linux-kernel+bounces-131445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269788987F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E791C20EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6E01B952;
	Thu,  4 Apr 2024 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOvp0+r0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E831EB56;
	Thu,  4 Apr 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234139; cv=none; b=Obkdn/0roO+5cvdELDHTKgzE5MI7KKw3U0fItlbYQf0wuaUrxhAh0R/iFkK+VWp2YbHAXXopNMaCq7kBnwfqc5+4D3/NyQMokf6sAGNNtrfYCOSev1CT2mugeqWxKbw3IUMbV6iSqyN6lk3JgJZmPN1Ti3BwkbpprDStCz3Ibh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234139; c=relaxed/simple;
	bh=hSaV6QTrJvwoxtEZ4ueRwfjvN/uyaN8SM5a9FexbxY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUhLPUdIYV4Mz9eS6nrcWo+LohfChzFMas68yW29/b5yn7xTderNh7a9C0JBCIsaK7eotxObiJMfYoGJWB4W1zXFDd4UWum/yfD9L/5dJIj463lcBQchEodkT3QhMOJSMDYHF9dBnLzrQq5GpIREI51Dc5lI5eu1GhEiLyl4xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOvp0+r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F28C433C7;
	Thu,  4 Apr 2024 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234139;
	bh=hSaV6QTrJvwoxtEZ4ueRwfjvN/uyaN8SM5a9FexbxY4=;
	h=From:To:Cc:Subject:Date:From;
	b=KOvp0+r0AswX3+k5YZavjaeUSyGb4RSvdqg8SEYsm6WZ0ZabdiVLUf5vn5YPY3eez
	 MtBXHzA9DvfCqFZdMfYwgqFbb3qtramLKzzKR4hncriZyhH7LkAujQhBebCTwOTxhq
	 SD9ccVvJAMrOKfqNPaIF4OP+F8DiUQpw4QTeED/rYP8Y0696Nmq9gBnF5p6B552I9M
	 WLfdapSZMH5PStdsO0Ly1ZyUJtRUrv7SLTt2krGze02h+SZw4pKGXZL0zhT9Fda9Ow
	 oLxR72t0gfsWDV+O5feVKo408GqyaSl6V6QrwfcVXNKKgjem7jBNc1gjK+SyByoTdD
	 W2DZB8tjdjkhQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ptn36502: fix CONFIG_OF dependency
Date: Thu,  4 Apr 2024 14:35:26 +0200
Message-Id: <20240404123534.2708591-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_OF is disabled, TYPEC_MUX_PTN36502 causes a Kconfig warning:

WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
  Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
  Selected by [y]:
  - TYPEC_MUX_PTN36502 [=y] && USB_SUPPORT [=y] && TYPEC [=y] && I2C [=y] && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]

It doesn't actually seem to be required here, so just avoid the warning
with a narrower select statement and use the same condition that Nathan
added for NB7VPQ904M.

Fixes: 9dc28ea21eb4 ("usb: typec: ptn36502: switch to DRM_AUX_BRIDGE")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/mux/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 4827e86fed6d..ce7db6ad3057 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -60,7 +60,7 @@ config TYPEC_MUX_PTN36502
 	tristate "NXP PTN36502 Type-C redriver driver"
 	depends on I2C
 	depends on DRM || DRM=n
-	select DRM_AUX_BRIDGE if DRM_BRIDGE
+	select DRM_AUX_BRIDGE if DRM_BRIDGE && OF
 	select REGMAP_I2C
 	help
 	  Say Y or M if your system has a NXP PTN36502 Type-C redriver chip
-- 
2.39.2


