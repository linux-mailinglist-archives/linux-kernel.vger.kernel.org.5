Return-Path: <linux-kernel+bounces-123025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D216389012E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723241F22A88
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDD912D745;
	Thu, 28 Mar 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7bAq59Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA483CC7;
	Thu, 28 Mar 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634825; cv=none; b=vAPG5QLEg6MGZs5l8wxVTUyu+cgAKZNoMwHWkadTwk55dSehLxMREtY5JtsYZvwTT8nKyUYnJt42nl2Ef53kAM3B4FRuwwk1p5BxzvH0V8obSe3qBtW0LPaQjRT6N/9b4VoK0f0NQHC0EI6rWrSTMcHCJ+HyM8oxbi+PgLr3Ro8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634825; c=relaxed/simple;
	bh=HUhSot9xyrF+JN4xyg5gUpvdtcrLnfShBlIudVAw+0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CuIGV2NHWIQu2LUneFJy2B9oD/OlokeM3e2Xi6iUm2vOKYxvFr57ZCxP7nhlu+kwQ4MoHdc8dQa0WpW1NCaCj3syejL5dNYaweGdnw7RO1uCahn9BILxlJidIjoKQ9VjNisfJWJ4SSlUiUoVWbyr/E45Avt4FRxg5Cd3GvDEfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7bAq59Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C684BC433F1;
	Thu, 28 Mar 2024 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634824;
	bh=HUhSot9xyrF+JN4xyg5gUpvdtcrLnfShBlIudVAw+0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7bAq59ZDijbhGoewi2fyU5yAVKEd6Ep8RA8WtnD2HrGJ/8zDtz2VujzucjrXWi43
	 DieD6Vj1woddVF3DyIj9WZEB7WSEkWbkfgvwNkhFIcEry9hUBLmUIFVCy2KF2pdTEs
	 VihwIQtCAQ7X4TJ8+F8dtl7DVdVsIA3qL/8Yk44yUZrScpEPby3ubQQz6PsH6iH+KP
	 g/UZoVijAAB0Uk1jqELSCyzK0MEaBNs9yfGDP+3bv+PRPNxAgldy8b6IrGe764SVaY
	 i+CwDFJkuWexuwlXfx7KpKsPz5+0e1VOFWpVTtkbaQkLeQvlRCeR2YN0EvQe6jukrY
	 368+rWxdAZ3Pg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Erick Archer <erick.archer@gmx.com>,
	linux-staging@lists.linux.dev,
	llvm@lists.linux.dev
Subject: [PATCH 09/11] staging: rtl8723bs: convert strncpy to strscpy
Date: Thu, 28 Mar 2024 15:04:53 +0100
Message-Id: <20240328140512.4148825-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-9 complains about a possibly unterminated string in the strncpy() destination:

In function 'rtw_cfg80211_add_monitor_if',
    inlined from 'cfg80211_rtw_add_virtual_intf' at drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2209:9:
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2146:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
 2146 |  strncpy(mon_ndev->name, name, IFNAMSIZ);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This one is a false-positive because of the explicit termination in the following
line, and recent versions of clang and gcc no longer warn about this.

Interestingly, the other strncpy() in this file is missing a termination but
does not produce a warning, possibly because of the type confusion and the
cast between u8 and char.

Change both strncpy() instances to strscpy(), which avoids the warning as well
as the possibly missing termination. No additional padding is needed here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 65a450fcdce7..98bc5520e77d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -884,7 +884,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 		goto addkey_end;
 	}
 
-	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strscpy(param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
 
 	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
 		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
@@ -2143,8 +2143,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	}
 
 	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
-	strncpy(mon_ndev->name, name, IFNAMSIZ);
-	mon_ndev->name[IFNAMSIZ - 1] = 0;
+	strscpy(mon_ndev->name, name, IFNAMSIZ);
 	mon_ndev->needs_free_netdev = true;
 	mon_ndev->priv_destructor = rtw_ndev_destructor;
 
-- 
2.39.2


