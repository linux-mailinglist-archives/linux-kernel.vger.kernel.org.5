Return-Path: <linux-kernel+bounces-32340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4AB835A67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1B2FB2135B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FF610D;
	Mon, 22 Jan 2024 05:40:06 +0000 (UTC)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC595257
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902006; cv=none; b=Krhg39ySJyTeeZ0hjVOBg+kdpNcvyJrLLbW41qzVnakjgTEwjVnhuAgja5UxQx79E58qc23TzMkqSZkNQd6HGN9ywVSGQPfFftTcEAz/qo6rsx/fw1wiTL9QlScwHv5tPyi8yvOHdxszVT6Ian7aBdVeXfKfXhQSYqLSVwjo/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902006; c=relaxed/simple;
	bh=lTX1evaHJ1G0tx6EjYrGOkxuSTOLB8QxlzQi0EflBwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cXpt0rNIdbMDmQzWJqQCGlPUL4I4aCf6YSWJXsQZiSOYhdGVfIQFEkKyYBM4mlsrhDasbMRDnTtyryfbZWBGvAMkhSy8akVhgsUDjfwAPOSXmoP27mnKUHVrfdrH4cH8/Rzs+adT6DEgvieMoNdhiSac5ngIExpO9X4Aw/pQ1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="146695168"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="146695168"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:39:55 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B5FB3E8D37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E07EED55EE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 820692007CA85
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1B5891A015F;
	Mon, 22 Jan 2024 13:39:51 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 2/2] firewire: Convert snprintf/sprintf to sysfs_emit
Date: Mon, 22 Jan 2024 13:39:42 +0800
Message-Id: <20240122053942.80648-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240122053942.80648-1-lizhijian@fujitsu.com>
References: <20240122053942.80648-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28134.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28134.004
X-TMASE-Result: 10--6.206800-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkp3Z/y3zTL99M0AWQBBcXdpRSkbxKeJc44t2mucDkRBHVBDonH99+Vnhh5KUdlgWiAnI
	8hUzVxc+OViXjUjyNU1DR2CTIs3lu38rWKQkiws5O5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BDIvl
	CZY6Ax8FAKfW83qxbFEiwddwkMLeSR9GF2J2xqMxRFJJyf5BJeZVXUb4KTaXv6C0ePs7A07cjHc
	hynrO5bndtBv10U/kn3TLIRH2dzULFYD423IN35d6a9bfD2v5k=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> drivers/firewire/core-device.c:326:8-16: WARNING: please use sysfs_emit or sysfs_emit_at

No functional change intended

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
"[PATCH 00/42] Fix coccicheck warnings"[1] is trying to fix all warnings
reported by coccicheck. firewire introduce newly abused snprintf case.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/firewire/core-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 47d6cb3dc916..790985479ff3 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -323,7 +323,7 @@ static ssize_t show_immediate(struct device *dev,
 	if (value < 0)
 		return -ENOENT;
 
-	return snprintf(buf, PAGE_SIZE, "0x%06x\n", value);
+	return sysfs_emit(buf, "0x%06x\n", value);
 }
 
 #define IMMEDIATE_ATTR(name, key)				\
@@ -474,7 +474,7 @@ static ssize_t is_local_show(struct device *dev,
 {
 	struct fw_device *device = fw_device(dev);
 
-	return sprintf(buf, "%u\n", device->is_local);
+	return sysfs_emit(buf, "%u\n", device->is_local);
 }
 
 static int units_sprintf(char *buf, const u32 *directory)
-- 
2.29.2


