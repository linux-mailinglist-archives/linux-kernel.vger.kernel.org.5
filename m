Return-Path: <linux-kernel+bounces-116263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE86889DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC229B826
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA82B294490;
	Mon, 25 Mar 2024 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcG3bf71"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4063180A8D;
	Sun, 24 Mar 2024 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324056; cv=none; b=lxcqNonQxDBxLL7atjeIAu1VJeJh1a9bBd1LAfNYPRWBvfh547t+8L16sjuUuw0gY9qFxkc2KkGXwnYuh+/WWzhGkU6dswJouaptrSvDCVJy/s9IrnMlscKGe6TgR0C8hJ1hLlKmbCfpxG+hs25dA13k9tRyX5Ff3B6RdHtUGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324056; c=relaxed/simple;
	bh=g9oUjtbgVyPfa42NId5r5PY1QsKy5NCIqsClJIdX5IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J2gOozFcXDs3q9Ig3eZaxZeEvBx1l86dMPBnI/Mzg/F1G8HSdNLUprep0TgM+QX8auFJ3NoB4MH0UQwWuNw6t6F8TpDXYBYxOZQTdGoJcEB18bd+vfxrzKpgJuqSApgiqbygAokca/h3JzQV+GChHpZkTqSPR625nj4pMhWvXNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcG3bf71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278F7C433C7;
	Sun, 24 Mar 2024 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324055;
	bh=g9oUjtbgVyPfa42NId5r5PY1QsKy5NCIqsClJIdX5IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcG3bf714F6LYp+OHYFf8DYgrPycvjOufa9XljgNsjaOsMo3eaFtZ7/Ll5KDGrxX5
	 ec6v9LZGJvAVCw8IcrlHClNs+ObQyFEaDOamj+OaXPDwKhGuer+0LcE4Ag+5m3FJsc
	 5pyzLEPghCYkkdl/4jfXbHYLvz97wXfQuaFCQAaJfP1wmMPNwgzxG4nmJLNGE8qy0k
	 AFPtDmnJ39jKRGBPAqCqxnZhAB3lObWbrnW1N94qo5823q71CSSqw5mq7Y/I3q7qGu
	 dYwas8Rp4nAXvEVP7DGfIxGgHQ6B3OHWFQe15zImq4K5+6TjJ64pSKTUE9QUIgd3NY
	 lJxXSvNZ3jxeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/183] wifi: brcmsmac: avoid function pointer casts
Date: Sun, 24 Mar 2024 19:44:29 -0400
Message-ID: <20240324234638.1355609-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit e1ea6db35fc3ba5ff063f097385e9f7a88c25356 ]

An old cleanup went a little too far and causes a warning with clang-16
and higher as it breaks control flow integrity (KCFI) rules:

drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c:64:34: error: cast from 'void (*)(struct brcms_phy *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
   64 |                         brcms_init_timer(physhim->wl, (void (*)(void *))fn,
      |                                                       ^~~~~~~~~~~~~~~~~~~~

Change this one instance back to passing a void pointer so it can be
used with the timer callback interface.

Fixes: d89a4c80601d ("staging: brcm80211: removed void * from softmac phy")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240213100548.457854-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c   | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c  | 5 ++---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
index 2441714169de1..849c8109b3982 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -383,8 +383,9 @@ struct shared_phy *wlc_phy_shared_attach(struct shared_phy_params *shp)
 	return sh;
 }
 
-static void wlc_phy_timercb_phycal(struct brcms_phy *pi)
+static void wlc_phy_timercb_phycal(void *ptr)
 {
+	struct brcms_phy *pi = ptr;
 	uint delay = 5;
 
 	if (PHY_PERICAL_MPHASE_PENDING(pi)) {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
index a0de5db0cd646..b723817915365 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.c
@@ -57,12 +57,11 @@ void wlc_phy_shim_detach(struct phy_shim_info *physhim)
 }
 
 struct wlapi_timer *wlapi_init_timer(struct phy_shim_info *physhim,
-				     void (*fn)(struct brcms_phy *pi),
+				     void (*fn)(void *pi),
 				     void *arg, const char *name)
 {
 	return (struct wlapi_timer *)
-			brcms_init_timer(physhim->wl, (void (*)(void *))fn,
-					 arg, name);
+			brcms_init_timer(physhim->wl, fn, arg, name);
 }
 
 void wlapi_free_timer(struct wlapi_timer *t)
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
index dd8774717adee..27d0934e600ed 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy_shim.h
@@ -131,7 +131,7 @@ void wlc_phy_shim_detach(struct phy_shim_info *physhim);
 
 /* PHY to WL utility functions */
 struct wlapi_timer *wlapi_init_timer(struct phy_shim_info *physhim,
-				     void (*fn)(struct brcms_phy *pi),
+				     void (*fn)(void *pi),
 				     void *arg, const char *name);
 void wlapi_free_timer(struct wlapi_timer *t);
 void wlapi_add_timer(struct wlapi_timer *t, uint ms, int periodic);
-- 
2.43.0


