Return-Path: <linux-kernel+bounces-135886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5189CCA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE75281D08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B011465BC;
	Mon,  8 Apr 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWH+cejr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C187146595;
	Mon,  8 Apr 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605719; cv=none; b=gJUUgdUfADUifutrlqwMcHNagTmBhLpUIDOI84B1PV3y4NUCTzR6Bmf8MAQYHFXkHseX7olVu6TL8r+eUTgUqZtub6T6pTr5wJiX5EgHpOSL1X+DJE82hue0tUaCVWzsoR2drIefW84RJdQYeMob+vI2h6h9YkjvbjkIlfW5Iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605719; c=relaxed/simple;
	bh=CslybNzY6McotszEiRDesoqYQQUvU/zYFyq3VeTUCCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHm1yU9z313IChOR3xzplfakG5JoM6y4eR2ek7v7V4nGf9RH5uAJoLV6vs2pAgmYcrxJ6RFoQoaJdvFCJ5jJVQhuWMsU+kYfoQLLU67raOA9uN9Z/fsDheSkFUjfn9QVPFmcKr+scx41wUs5Hb6N3um2P/jdHMouHqaJHqp39Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWH+cejr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B726C433F1;
	Mon,  8 Apr 2024 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712605718;
	bh=CslybNzY6McotszEiRDesoqYQQUvU/zYFyq3VeTUCCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWH+cejr3PKPTR9GLjP5NsIiQfZQmb+hbRJcqcbielxZh0LpNgtB0ybhKjgCjb+UL
	 3saf8CT5L32i8qv6Vxyz2pJk/2qqPh0FTrDZNcVnhZBmPxf72jmo+XJh2rjcpkLYLX
	 yPztgBTGpA978M+O05O7WzW1Al9G7N01TPoY8EgBkkjBQBadXk5rhsQBs1KAILrYhI
	 D6GxqZUb3rH4Z7WLFzHgzvduNm90gFcY1WfGINlpRhFZUL0IUbP6LuZWSEezX++/Ws
	 88RYonKxwTS4GKZvpPGTIG56zWnagW+1whUG5HMaDA9J5lDW3TguXymTIR6/pbmXqw
	 v4Y6qoQCy+Rdw==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Franziska Naepelt <franziska.naepelt@googlemail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Erick Archer <erick.archer@gmx.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 2/3] [v2] staging: rtl8723bs: convert strncpy to strscpy
Date: Mon,  8 Apr 2024 21:48:10 +0200
Message-Id: <20240408194821.3183462-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240408194821.3183462-1-arnd@kernel.org>
References: <20240408194821.3183462-1-arnd@kernel.org>
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
v2:
  use the two-argument version of strscpy(), which is simpler for the constant
  size destination. Add the third instance in this driver as well.
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c       | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 65a450fcdce7..3fe27ee75b47 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -884,7 +884,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 		goto addkey_end;
 	}
 
-	strncpy((char *)param->u.crypt.alg, alg_name, IEEE_CRYPT_ALG_NAME_LEN);
+	strscpy(param->u.crypt.alg, alg_name);
 
 	if (!mac_addr || is_broadcast_ether_addr(mac_addr))
 		param->u.crypt.set_tx = 0; /* for wpa/wpa2 group key */
@@ -2143,8 +2143,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	}
 
 	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
-	strncpy(mon_ndev->name, name, IFNAMSIZ);
-	mon_ndev->name[IFNAMSIZ - 1] = 0;
+	strscpy(mon_ndev->name, name);
 	mon_ndev->needs_free_netdev = true;
 	mon_ndev->priv_destructor = rtw_ndev_destructor;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 68bba3c0e757..55d0140cd543 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -415,7 +415,7 @@ static int rtw_ndev_init(struct net_device *dev)
 	struct adapter *adapter = rtw_netdev_priv(dev);
 
 	netdev_dbg(dev, FUNC_ADPT_FMT "\n", FUNC_ADPT_ARG(adapter));
-	strncpy(adapter->old_ifname, dev->name, IFNAMSIZ);
+	strscpy(adapter->old_ifname, dev->name);
 
 	return 0;
 }
-- 
2.39.2


