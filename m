Return-Path: <linux-kernel+bounces-32339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA6E835A66
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D85280F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6583A5258;
	Mon, 22 Jan 2024 05:40:05 +0000 (UTC)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2535240
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705902005; cv=none; b=JYv+FJZ273Iow/oI/KBKKaYBV0Sm7s2A3ih6E5s9B42o22UI3pndKuXrUOoAovNrzzydcc/qWEmpsQwlRbPN2u+knfq62owvD2zux97jn+ntiCcEhpfatD2zFhfnYRESsgJvnwZV/nS6wxdWzh+nBeHcS6RqndL2LYsWCvA0UdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705902005; c=relaxed/simple;
	bh=T4ARGadbiKu7zg6G4+r1xa0bBGmmR0HB4sJW6kBmIY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2DpBG9VC2bvy4U0AAYEBSUDqa7kSEMoF/crejdfeX9zs97CAAA9AFHSQOvyyx3jzXzZG/9h/3907+g6eXbojqq+FvHjXIZ3w5prW6jLdXWwqSm2Hmbaxf+0c0iXK+jZeDeTURpIZoE7lbJ5JW1VK2kfHoJ5vED/PHb3BnJJ37U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="146838133"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="146838133"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:39:55 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8AE0ED64BA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C0B3CBF4A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 514642007C3DD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:39:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B18441A0072;
	Mon, 22 Jan 2024 13:39:50 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] firewire: Kill unnecessary buf check in device_attribute.show
Date: Mon, 22 Jan 2024 13:39:41 +0800
Message-Id: <20240122053942.80648-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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
X-TMASE-Result: 10--1.868800-10.000000
X-TMASE-MatchedRID: D7uj3L7FQ3I8c+bQ4YQ9Biy4YbFsZbM/mGrGwE7uWsvcRlVxRCnt1hsk
	AdaEfeQKasOJoXx/wo/mn3xyPJAJoh2P280ZiGmRGYJhRh6ssetgg7HO8z2tNrs3Yh2IOCYzBv9
	+XtincoPi8zVgXoAltsIJ+4gwXrEtJ0RPnyOnrZLWVzrtqV3TKmhFx1gLyk1HpHGEjQ7AvuvqhZ
	R6wV8bh935pBFGMfOOdZE5Rp4uo197PvKHUeGOL5hzxat1GtSzDM8Ug2mxrV7AYLx7rnbR8rDQ8
	m3TqgloelpCXnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per Documentation/filesystems/sysfs.rst:
> sysfs allocates a buffer of size (PAGE_SIZE) and passes it to the
> method.

So we can kill the unnecessary buf check safely.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/firewire/core-device.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 0547253d16fe..47d6cb3dc916 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -323,7 +323,7 @@ static ssize_t show_immediate(struct device *dev,
 	if (value < 0)
 		return -ENOENT;
 
-	return snprintf(buf, buf ? PAGE_SIZE : 0, "0x%06x\n", value);
+	return snprintf(buf, PAGE_SIZE, "0x%06x\n", value);
 }
 
 #define IMMEDIATE_ATTR(name, key)				\
@@ -335,8 +335,6 @@ static ssize_t show_text_leaf(struct device *dev,
 	struct config_rom_attribute *attr =
 		container_of(dattr, struct config_rom_attribute, attr);
 	const u32 *directories[] = {NULL, NULL};
-	size_t bufsize;
-	char dummy_buf[2];
 	int i, ret = -ENOENT;
 
 	down_read(&fw_device_rwsem);
@@ -358,15 +356,9 @@ static ssize_t show_text_leaf(struct device *dev,
 		}
 	}
 
-	if (buf) {
-		bufsize = PAGE_SIZE - 1;
-	} else {
-		buf = dummy_buf;
-		bufsize = 1;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
-		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
+		int result = fw_csr_string(directories[i], attr->key, buf,
+					   PAGE_SIZE - 1);
 		// Detected.
 		if (result >= 0)
 			ret = result;
-- 
2.29.2


