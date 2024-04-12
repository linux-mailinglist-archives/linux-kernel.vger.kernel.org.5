Return-Path: <linux-kernel+bounces-142248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06308A297A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD66B21D43
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C326F38FA3;
	Fri, 12 Apr 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="iXeFh1Eq"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AE1B5A0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911227; cv=none; b=n/WBAnVl2IxPNzrbLSmfVdgsJaaAl3CU9ECMr3OuWj6yPNxUz1OfO9Yml21wWddueFCVrcVx4752aBRKGlIAXADGSfCSSUMeyeXqOee9mrBn+W9bHttGRwfyhuWFGOitExA/6mIRzpjRuOtFmKw0Rcu0WTspmfGTAqZKspYB/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911227; c=relaxed/simple;
	bh=g4SUOMjnekZdMZJIzHGPEmDASGGoTHCs0m6rSPekkLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SY6xY5iH0NstZD136JMvocEF7MJekws1vpAGlGNgtH5uuWUjAraGeyGyGxi5EZxp/KxuvrK5ct9vTOCiXsL4yWXthxLpDhTNhpqoaeHXVD4Kc0l3F57zHCsqBD5Kjwx81ABt/yAJY1lFaHfpsbb0vyCeiZaClxjO4vMDTK7Z6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=iXeFh1Eq; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 69B3D100002;
	Fri, 12 Apr 2024 11:39:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712911197; bh=rjbo4UmWfdwF8R6/DF5Fmz37zbZJApM7uAaHW6mJOAY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=iXeFh1EqZq8ZPAePYUl6mbxwrMGpyXIC1+9DRMFGc73/E573jzoGpC5Lx0+DONq3m
	 ArhmsPc0O4i5twLUmUhy1AKQC5bDVXI0QMZU3yRj11y4Yj8H0QQc+mFZ2ub4ahGoVJ
	 JGqbeZpZyEft8TOVtFfGqHQrktvOM7zHlMZIoHkJHy3VEgtyI8lEmgSJqAOTyi7MjG
	 xI1l0tI/QclaAU5QSGcZUxQiN2L9uUc4IyRaX4pAoqsRmqWW9hqdFebFLktRr8XObx
	 ib8mK9p1Jpmxhjrit1lHgY0iQAbkQTNGWkssh+K4XUF28RVnD+vlhqqrHcYx58SwdP
	 sRGkDj7l1ZRLw==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 12 Apr 2024 11:36:10 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 11:35:50 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Swapnil Jakhade <sjakhade@cadence.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Andrzej Hajda
	<andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert
 Foss <rfoss@kernel.org>, Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nikhil
 Devshatwar <nikhil.nd@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Jani Nikula
	<jani.nikula@intel.com>, Rob Herring <robh@kernel.org>, Zhu Wang
	<wangzhu9@huawei.com>, Yuti Amonkar <yamonkar@cadence.com>, Jyri Sarha
	<jsarha@ti.com>, Quentin Schulz <quentin.schulz@free-electrons.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
Date: Fri, 12 Apr 2024 11:35:32 +0300
Message-ID: <20240412083532.11540-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184683 [Apr 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/12 08:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/12 05:40:00 #24753079
X-KSMG-AntiVirus-Status: Clean, skipped

In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate() is
assigned to mhdp_state->current_mode, and there is a dereference of it in
drm_mode_set_name(), which will lead to a NULL pointer dereference on
failure of drm_mode_duplicate().

Fix this bug by adding a check of mhdp_state->current_mode.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v2: Fix a mistake where the mutex remained locked

 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index e226acc5c15e..5b831d6d7764 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2059,6 +2059,11 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
+	
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
-- 
2.30.2


