Return-Path: <linux-kernel+bounces-107296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF287FAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5779B1F2229F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059A7CF29;
	Tue, 19 Mar 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="RjPsCsTS"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1461F7C092;
	Tue, 19 Mar 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840232; cv=none; b=uBIfYte4AqojKrcKd0foXTWEsjswluoR2AbcwU0Dv3kzTts1AS4cyrg2MoeLjLOqWKx/y/RT1Y3SCsefctzmuALaup7hiTM12+skrQRQgypG8eK1KmX1ztMu7+tKpED6ebotzryCJ7na+iWCne8JhyhsVaNo+62cctceQI2rhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840232; c=relaxed/simple;
	bh=uliAvHNLwCXnZkojCT8TwBWAkEuheEAUGuxMOUqlJQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bELMp0BwaZu9xjdNBhm7mYY9LzFOw+FvUWvGS97nhaqtyMsK0Gz2Fam6CneUxNpaclTFv8E+g5AACA5rwXjKr2wuNA+8+vrO3kQInO+tWkWMcf5LvbVKfmQJCB1LjQT0l+PxFQrZdg8rrOxLwszJy+aeu3WCGkdefi+NmLMxEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=RjPsCsTS; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710840230; x=1742376230;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uliAvHNLwCXnZkojCT8TwBWAkEuheEAUGuxMOUqlJQs=;
  b=RjPsCsTSwTS9MKAmk7uJP0yadmUjijnaeNZdd6nlDwMxy4eio8aCFfKZ
   QRFVDZO+LFNEds/7QJcrJ2CScYSFAqSb14Pj7bRZDfZGGteHqBWYso66c
   3aQMKTR2+k6V1VYFDvIcW7Wq5a28ETk75H1pIrpPWa8DeddWIJAJU0VPz
   iCGzGiquv4WaUGy53HxkBLdaVhYbkasEzRkBnUPiMusRIhWXveZcDhktk
   mXiJjC1lQisxM88Pxh4lrVrOoZmjUFXRtDTT+YIBjjy3mv1ET0FvndEPD
   jlLx2wCZF5/Iaas86t2joHIpULZ/vX4nKDoXOcoJ/HfaKybZIwlfrZHdv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132025580"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132025580"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 18:23:46 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8150CEB469;
	Tue, 19 Mar 2024 18:23:44 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E7C8BF4BA;
	Tue, 19 Mar 2024 18:23:43 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 143F72009327B;
	Tue, 19 Mar 2024 18:23:43 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 82B531A006B;
	Tue, 19 Mar 2024 17:23:42 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Helge Deller <deller@gmx.de>,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3] video: fbdev: panel-tpo-td043mtea1: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 17:23:33 +0800
Message-Id: <20240319092333.1590322-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.006
X-TMASE-Result: 10--5.404400-10.000000
X-TMASE-MatchedRID: 6n1zk+md1nUbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6L42hLbi424DjcR
	qQigdY124xAnoO+Mv0IWyDkw3lKgbePWEUnWb98FBDn6Fjq77jgYAPqHoVmYR31GU/N5W5BC/BR
	68O365bjSAa8O4E9d0Ei2pD9yuITrs7aQkqkpFynaNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR
	4+zsDTtD12T7q2dIUvMX2qxXxibj0gxzbnU/ZVszazffbEGxPolyY0b9FK6Ag==
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

CC: Helge Deller <deller@gmx.de>
CC: linux-omap@vger.kernel.org
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
   split it from a mess of drm,fbdev, becuase they are not the same subsystem.

V2:
   Fix missing '+' before '=' in drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c     | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 477789cff8e0..3624452e1dd0 100644
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
+		len += sysfs_emit_at(buf, len, "%u ", ddata->gamma[i]);
+	if (len)
+		buf[len - 1] = '\n';
 
 	return len;
 }
-- 
2.29.2


