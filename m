Return-Path: <linux-kernel+bounces-151380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603D8AADD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D9A1C20ED8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B7823B7;
	Fri, 19 Apr 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="ifhZew8n"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54325823A6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713526889; cv=none; b=qISb5HbnaJDy5aQxQaQyu4Br+T3/i8TM1BYvlXvU102GuaCMROom7oztjKfZRINffv0euidRfukIf4flu/Nhs/WiMW614LzTjnhVRHshT1SxONZgWkBT+umgftRVp1FliwkxExO45q7PCbloka8l01Ea5aR0wIN7tge15bpIKtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713526889; c=relaxed/simple;
	bh=0aEsdUJw3EBwmLU652aNlBFoHG20ISTg5LoRgTr4C84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4viEAhjRjq6HzjZYSvBGRCYTm+TzJpmCjYg6YHjCkLrOIdZ8ZvobEvbQ7Ei+YvsA51K54ro3q96L86Ln1VI0ocRABmand9NJ3bfFDdNu0HamNjVyJ4mRWUsKmBeIr7mRTSivgrSck9G3jCK2+E+86ytUdBzbrk+zjTTjEX4/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=ifhZew8n; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 74111100002;
	Fri, 19 Apr 2024 14:41:00 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1713526860; bh=Oz98kO5d2CRgHIhhts09UkblHczkJlM9GxaDLSU3MbM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=ifhZew8n+bJoZAJVgEmZ3QT13pxjZS/p1IixrY7L5mnBHI+yGIkW6dvgJZqnL++aw
	 UcQW+EoxYfZwyDtqDw5WZ3XqBsj2W5vq+CLuSj6S/zVV7Yhspj60GBBBFJW8ASoNCv
	 jeH9kZfWTKk0WD0Qf3TrMzv/Sungw9WP7zumMvmmpK0JVY0462OpOyDpev7/hhjlh1
	 zVrnKQ5exRrHuEfhL1de4X0uOBhq50YJDkN3rEl0njAtcHvkEM60NATMYzDaauM38k
	 P2f0i2QfDQHTEkYRepezUa7iJec0H9uKY4y6a0sQ0h0SXmy+NKWr8YBg/Wlm+9mSwR
	 eDTDeZ3/QBYsQ==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 19 Apr 2024 14:37:07 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 19 Apr
 2024 14:36:45 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Robert Foss <rfoss@kernel.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Swapnil Jakhade
	<sjakhade@cadence.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Laurent Pinchart
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
Subject: [PATCH] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path
Date: Fri, 19 Apr 2024 14:36:37 +0300
Message-ID: <20240419113637.25745-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184806 [Apr 19 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18 b9d6ada76958f07c6a68617a7ac8df800bc4166c, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/19 08:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/19 07:11:00 #24870208
X-KSMG-AntiVirus-Status: Clean, skipped

In cdns_mhdp_atomic_enable(), there is an error return on failure of
drm_mode_duplicate() which leads to the mutex remaining locked.
Add a mutex unlock call.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 935a92a1c400 ("drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
This patch is against drm-misc-next branch of drm-misc repo.

 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 8a91ef0ae065..65a4bd09d9c6 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2059,8 +2059,10 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
-	if (!mhdp_state->current_mode)
-		return;
+	if (!mhdp_state->current_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	drm_mode_set_name(mhdp_state->current_mode);
 
-- 
2.30.2


