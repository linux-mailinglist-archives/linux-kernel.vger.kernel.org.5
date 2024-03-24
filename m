Return-Path: <linux-kernel+bounces-115890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC17889883
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2371C31D97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769B384878;
	Mon, 25 Mar 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDGnA/Mo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D71474A3;
	Sun, 24 Mar 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322084; cv=none; b=qP1BEUpLeE4ahWCLaOjZZZBCuO1rHNhwSTMxsj5a/tvB4stBj+4UqZNQUcbOfuytu23sph2CrydpRbqP85VAK0T4Jbx6fQe9YK6Aa7HSjB5FFILvxp1nhJtAJXwmLDG2gsgkYqmtCxIb08PAGjdcPWHTx0+agDU4wsL1OrT7e9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322084; c=relaxed/simple;
	bh=nt4DweudXrWSOOYE0nV/wX2peusxuk3T7M9VaEFEUOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+y3ifRBn7uqP/jqt+qCWWEiZpUz0x06x2MC1Uksif8BDdkcurdMxsk5ijG+HJ3z2Cpt3OS/5KI075nLAr5hSX/9GKwe9AL1wSbgjEhdstYXv+XHdmRD7NDqdW3e4v8ECw18Hh/fDkzKdw8iBGEyBxriWYXRESU9Y7pnKXRz+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDGnA/Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5E0C433C7;
	Sun, 24 Mar 2024 23:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322082;
	bh=nt4DweudXrWSOOYE0nV/wX2peusxuk3T7M9VaEFEUOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hDGnA/Mo4LMtQPtmH6m5lPJS2USWltfPqGe+foCmnwdGP0zi5t9qGWOTevx9zUgkO
	 TGvIdoamWqhzJFGz39Mbgm8UaFruT/zCPYEjU8eCar0YgSziw304DVmz579H2eXX6J
	 3ARwp4AMAT6AhBm3DyUq0LYJH0HgZkYPYnjW/GPGV9DEvps+puZd/pr1+fonFQP9DL
	 v/AJDcx7emIaRlOaQT+XTWFeMmbeoOHPtRi7HMHK68D/7m94lpJJ2xxVG4zhk96ndO
	 1LU4c4fM7xsfvZRx5awiXKaS604jCINFmXWW8NVQiMORTabtaf+b2iqUlv69JHivoY
	 99s+qh1Tpuorw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 156/451] wifi: brcmsmac: avoid function pointer casts
Date: Sun, 24 Mar 2024 19:07:12 -0400
Message-ID: <20240324231207.1351418-157-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index ccc621b8ed9f2..4a1fe982a948e 100644
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


