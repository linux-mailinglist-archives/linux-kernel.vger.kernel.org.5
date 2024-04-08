Return-Path: <linux-kernel+bounces-135384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5489BFF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8762808E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619D7D3E2;
	Mon,  8 Apr 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="APVDouur"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60FC481A6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581371; cv=none; b=W7CajIol7MajOgg7d6T/0bxQgWMR+Wpf0uSY8M0hmUkaUY3VxSKs+n9agrEXZHKwtUZFMUENSkDiFRak0gPUTNkn+mDwqyA/53dV2wLst8nabd2sj1I/z4Liqb/MG98+G3pTtJP2/132TmE+H9nVA2YSnbts0tgSpRG/xuva6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581371; c=relaxed/simple;
	bh=ZXfvgeDROZep0slQBXDkO+E1iJzwIlpz6tUv4s83HYk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RC0LehfKpovThoTw1m6dI0KR0RWdz4uGIclRia11LF/a9Ld08Kbv4UCaphbcdYys4TGzt5Fzl+9BiSCXzVBWin8ZR4oMwjxx+QGWcTx3knyyHRHXhoNBa09QoAZ2lmsl9Hdhy0q8K2w1HPyXjIp3epOuXPRmNJO+5fADmcVbeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=APVDouur; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 4DF53100002;
	Mon,  8 Apr 2024 16:02:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712581348; bh=1T7AEdzVVI+WLTfJLcfbhpzyh/ZfKNV6VSBHpjNe3VM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=APVDouurCYo7J2EyewYYJhe5R+ziwrvmZMsGCPS/HBPIMvflG4KEwdTbJuleyECay
	 dQMvgoig7sWdpQ7xGxhpABVqQqZ8dgkkJEc4EiWQHAgJHxClTIU5bDpM3EkrsQMbZC
	 XRt23IhrH8mc8Ta+yRT1nsCszLJzlG+3FY+k6vFX0YLzdcBdfA9bOJdlmNnIcya8er
	 PtRu3UyyxXRe0cQ2mPRMhlDMSiRklRId/02MjPeyX6lkrpzjPENF/i8kdoyjSgIf4V
	 krFOkOY9eSakkxfeVxYt9RsYXyyEc/Hk5+pWD3qm6TtAuY41f3GmH8cFd42OZIgWPp
	 NlPAlQ05jYYzg==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Mon,  8 Apr 2024 15:58:39 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Apr 2024
 15:58:18 +0300
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
Subject: [PATCH] drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference
Date: Mon, 8 Apr 2024 15:58:10 +0300
Message-ID: <20240408125810.21899-1-amishin@t-argos.ru>
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
X-KSMG-AntiSpam-Lua-Profiles: 184622 [Apr 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;t-argos.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/08 07:15:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/08 06:53:00 #24704467
X-KSMG-AntiVirus-Status: Clean, skipped

In cdns_mhdp_atomic_enable(), the return value of drm_mode_duplicate() is
assigned to mhdp_state->current_mode, and there is a dereference of it in
drm_mode_set_name(), which will lead to a NULL pointer dereference on
failure of drm_mode_duplicate().

Fix this bug add a check of mhdp_state->current_mode.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index e226acc5c15e..8a91ef0ae065 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2059,6 +2059,9 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode)
+		return;
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
-- 
2.30.2


