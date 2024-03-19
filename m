Return-Path: <linux-kernel+bounces-107295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC487FA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EDE1F22133
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7547CF07;
	Tue, 19 Mar 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="j5ov0qTG"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA7964CF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840204; cv=none; b=EVu20pX6ES31qisPO8YHy+LoB3hhZHMb4jWOTa2xmu3OMzdQkMqxo0h5f4VQoLKJPkgF30ARfs64L6v70UMdd3bvqxzm+yn4cdsE3uk6qvUcEKDIdydD3Nvjpt/Jiwh+kaupHt/3TVk/j+oDa9qhKVese2+wDyguodVAczxlQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840204; c=relaxed/simple;
	bh=+G+/hjvdQsQIOwGVBqPAWDHYVXzep1SS6d6R6Wc6HgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4sg8SJc3sBs54+Bu9ipx1YHLY4Ny593jSOLQ8hdAMRhO0cpw8NbUgZhM91VhA3aPpt5i9GVBpeCHz/GdDFN3oMDubkTMu0qQzERqD8lhdekfMyaBB7HgxDtWk6IGv96DFd8fgoCwTE5oDbBMdJBVambmbsCeg1XJpueWvrinR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=j5ov0qTG; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710840202; x=1742376202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+G+/hjvdQsQIOwGVBqPAWDHYVXzep1SS6d6R6Wc6HgA=;
  b=j5ov0qTGu+53mS3l1EQAO3C5bADe0dEtOb8dvuQbGatJPNBRHz6v/5aY
   iGGJ+iLua9KTnCUmxj1nb5jJWfFfcuevQ8ZpjhE3dMHlb0SdeAE4okERS
   Va1vRGYhrJ+KGCSD/VD4AueiA537sRYSuLd3O61w1GkLfzuSmZz6nvfci
   VIPNRokFL1/EDx30MyI+rAw0jMjvUbcD8JZuwG7gky2b0hrrZzdwxSKQz
   JqiL4dzisordk/O7dqkVK+sK+hX8HlGd5CfE+ZNkjmOZG3mFoRiYbtbAq
   pCwmaU8aP/+s933dXVZWGH1tNPQgdskGk8B0Dh3nl7NjpieC8iCC98Cw3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152171486"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152171486"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 18:23:18 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E083FBD83
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:23:16 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 98FC341663
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:23:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 26EAA2021E983
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:23:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BF2271A006B;
	Tue, 19 Mar 2024 17:23:13 +0800 (CST)
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
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/panel: tpo-td043mtea1: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 17:23:10 +0800
Message-Id: <20240319092310.1590270-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--8.066400-10.000000
X-TMASE-MatchedRID: RKkR8WK0E1obO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u9hCyUKzFE4pMOmbgJn0O1cd5G
	gTXcmX3z/gi5MRR1gmuKPZyvBQlTFs+DazrJbzs47I8qKHhHKyIY+g3uPA6ifU5+divxV/ok6SI
	YaJ07sjyL637QCIVpi8vc3EUpCmrV8M8QL/JCA9N9JA2lmQRNUsWTnXVTJRGcGWfDd0b0zMaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrWfLZ4Cl6GGUpWdQGnu54z1xFDWqWkyrkRYZm7Em44odC3Ze
	sb9BtDs=
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
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
   split it from a mess of drm,fbdev because they are not the same subsystem.

This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

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
-- 
2.29.2


