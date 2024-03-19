Return-Path: <linux-kernel+bounces-106968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1CF87F624
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CB7B220D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482B7BB15;
	Tue, 19 Mar 2024 03:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eepE6FvZ"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016207BAF0;
	Tue, 19 Mar 2024 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710819813; cv=none; b=tE9To8zQ09REN3dik5L3c1mduj9jHO8ei3knfrIyGphtHtGUHp05idZY2NKVWZMeib7b5xh1+gCgkMnlFrcqZxIaQLIaPgT9857wXbnFAqlcRc4taI0UCeXqMhvPLkz7FNlisoNECVuBtRV+d5uIzrAyzuXtFy8SNldzxRQewQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710819813; c=relaxed/simple;
	bh=kpIQQ4UHhSRaPRBqYrLlxC1aJHMqE9Os3Z55I7joDmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DMWQBs6oA9AjtGcsUns+19RV1X9mPVYjvH7E+q6RUETAy0q5OoP+EE4Qc89SJvLK2qoqFoBrzElwR3jd5CFNlgssvt+aHX4l39hwCcil88+3sVF6FcNEZ0s3lz04LzKxAEeSqu4QdvED8U1jb/J/3cK2r9LmJM61hl/0vrDXb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eepE6FvZ; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710819810; x=1742355810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kpIQQ4UHhSRaPRBqYrLlxC1aJHMqE9Os3Z55I7joDmI=;
  b=eepE6FvZN/CHPrX9S9SP94HYskLsurYEDaOmfcPvfRi1ytwv5oYblRo2
   8R7EF3tVM1+AAAPSz5GcjdFj3nPJPzorLRA6Rhqw1sucKGx1O+5lQk2P7
   WKgZF9lD4vkpNsyer2LgZMYqc/xLUHHMplXc/6c4S7Ks2dzbIGiQAHjhw
   mHkoCE1iMDJKRyyChBwHt4sNoJTDmyhC1LNfZz5UCqk034Gku0pldsmXP
   SW6Ng8DPjG6NqSXSfvAAVA1+7JAq8rROU1FYtc/D/MNon5sMnlffgnMNo
   UUOi69CCpzcO9VhVP9sQeKoKGJk6mG4+HOKzumpHmlI+mLHMKQrmS1Wa2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140288667"
X-IronPort-AV: E=Sophos;i="6.07,135,1708354800"; 
   d="scan'208";a="140288667"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 12:43:20 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 06072D4800;
	Tue, 19 Mar 2024 12:43:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 27E56D561B;
	Tue, 19 Mar 2024 12:43:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A4CF120099077;
	Tue, 19 Mar 2024 12:43:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1BBD41A006B;
	Tue, 19 Mar 2024 11:43:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm,fbdev: td043mtea1: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 11:43:10 +0800
Message-Id: <20240319034310.1574349-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.004
X-TMASE-Result: 10--6.993400-10.000000
X-TMASE-MatchedRID: vWLMKRYJCzcbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u9hCyUKzFE4pMOmbgJn0O1cd5G
	gTXcmX3z/gi5MRR1gmuKPZyvBQlTFs+DazrJbzs47I8qKHhHKyIY+g3uPA6ifU5+divxV/olaTW
	107FjPHDnpYPqS6jzx8tvnLY6Q4L+1UOlz1sLXchF4zyLyne+AUrr7Qc5WhKhzvn1t6wuaa+zst
	h4cn4jroa8IWqgpLBOAMuqetGVetksDkkP3zIjq3QfwsVk0UbtuRXh7bFKB7sO0UlcJEGWrCrSW
	yB8sgMMkRgrwE4e1Kc/TqvYMYi+tH8FerAT0dJY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Neil Armstrong <neil.armstrong@linaro.org>
CC: Jessica Zhang <quic_jesszhan@quicinc.com>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
CC: Maxime Ripard <mripard@kernel.org>
CC: Thomas Zimmermann <tzimmermann@suse.de>
CC: David Airlie <airlied@gmail.com>
CC: Daniel Vetter <daniel@ffwll.ch>
CC: Helge Deller <deller@gmx.de>
CC: linux-omap@vger.kernel.org
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c        | 13 ++++---------
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c    | 12 ++++--------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index cf4609bb9b1d..0983fe47eb5a 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -242,16 +242,11 @@ static ssize_t gamma_show(struct device *dev, struct device_attribute *attr,
 	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
 	ssize_t len = 0;
 	unsigned int i;
-	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
-			       lcd->gamma[i]);
-		if (ret < 0)
-			return ret;
-		len += ret;
-	}
-	buf[len - 1] = '\n';
+	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++)
+		len += sysfs_emit_at(buf, len, "%u ", lcd->gamma[i]);
+	if (len)
+		buf[len - 1] = '\n';
 
 	return len;
 }
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 477789cff8e0..040a17a05baa 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -228,14 +228,10 @@ static ssize_t tpo_td043_gamma_show(struct device *dev,
 	int ret;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++) {
-		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
-				ddata->gamma[i]);
-		if (ret < 0)
-			return ret;
-		len += ret;
-	}
-	buf[len - 1] = '\n';
+	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++)
+		len = sysfs_emit_at(buf, len, "%u ", ddata->gamma[i]);
+	if (len)
+		buf[len - 1] = '\n';
 
 	return len;
 }
-- 
2.29.2


