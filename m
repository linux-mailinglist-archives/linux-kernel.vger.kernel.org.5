Return-Path: <linux-kernel+bounces-115194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E7388934F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FD8298B65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017D30B4B6;
	Mon, 25 Mar 2024 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKvs4eCw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1388184121;
	Sun, 24 Mar 2024 23:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324265; cv=none; b=W6LT+5g8EodjFXJv/ZDUUgNbK444cWWNS2D4QW+cYTRp92eEmGQVrMyFpy4qkoSNuD9WtKj69xJIP5l/ZfsH5Db/T5+GUssfS9kwA9bzajjPztL7iRFlJk7dUrKBNvkYvhQg7ZapWRXhXgukFSs/oDiZTra4G9/Ieni7rLaY8MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324265; c=relaxed/simple;
	bh=bFIW337YZEgPJGcH3SHvm6AhFeA3r3vl6XB2wyPDraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeOTCpxgAuZmbIA0UKNIlWJMAMXRULv/qIRZmuSLeufreKy7ro/nVp+a4t3b/jYLMHc/3YtvyhWyyoAbSS70xgF/FNxDytDGoI1fKSTjJbhyLnSruNYTfcnv6Qc+TqjCvbyhofPA9YO9PoFINYYpaIRgja9lCTSibJjR8il/K1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKvs4eCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD884C433C7;
	Sun, 24 Mar 2024 23:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324264;
	bh=bFIW337YZEgPJGcH3SHvm6AhFeA3r3vl6XB2wyPDraM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKvs4eCwJNycwuAK+gUJ48A3KdXbau3D7+iHualN/aOEBd7wudtdTK7S10H2Hv2VX
	 1qkkiBsLCbh7h3CNjgc2iesP/Rx9zsb+urNiPh0V2PQ3qF2RaJqxVqzJ/wmms75oO4
	 sFQHWJRy5HpPkZ4g+chEal0qyy3ssU4jLGEL0WPiNAuyswftJ4ig5FG7cUG2oZJX9z
	 GKlrpupLKsstJv0aIPSUh6LxO8UzCuAwC+l4laU9besVbp5IgGmgNfFDo8DIDTv/KY
	 txNbojdxKdV3lcl8ZbuDRPQtyMSskTKLuVzIh13Gyr++b80vRTEUbf49qeoeTZo28+
	 5A3sOeXAHn8IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/148] wifi: brcmsmac: avoid function pointer casts
Date: Sun, 24 Mar 2024 19:48:28 -0400
Message-ID: <20240324235012.1356413-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 35e3b101e5cf0..bedb1f73ef24e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_cmn.c
@@ -394,8 +394,9 @@ struct shared_phy *wlc_phy_shared_attach(struct shared_phy_params *shp)
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


