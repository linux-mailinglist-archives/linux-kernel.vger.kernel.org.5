Return-Path: <linux-kernel+bounces-102987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25DD87B97C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA55B239D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703986BFC9;
	Thu, 14 Mar 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="bFV17zQu"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6E62177;
	Thu, 14 Mar 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405950; cv=none; b=p/Bo0XQFgCQapgr4SBqUSerlo+oobsgI0NGR5j+5LFjVCffa/wOsKC9RZVGQn6MqHIvLV/F9yHWBbyEj0Pc8KbsP7IVy4UPtwW8llujxWYmdhh6+BaGRv7eRVq4j8FclwGdwtbO8golpEbvzJrknZB34voIlP31qmOz5EcHRt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405950; c=relaxed/simple;
	bh=2DdOfJQurkOikWWUqjVqkjARYQqV+0TU1E6g35KIw2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a112sL/iiSpL2LUHwpT5bcwkjxt89w3hVZRpBqa5KIu74BXNUQC/rGufAKtJ4Q01Qq+lN0YkFFEGQiV2ImLGrYQNJ3Y/PNyQZaGiV4am9cGT8wmY9EGktO5Pj/BcFt0xV1S8r7RK1HSEJtz0z+FmvAwDRPLhuqwzXiLk3OOIS9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=bFV17zQu; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710405949; x=1741941949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2DdOfJQurkOikWWUqjVqkjARYQqV+0TU1E6g35KIw2o=;
  b=bFV17zQulEsSuLPvdLTUFMFjmlHK86rYOzdBNpU7HBbTqBMHj9WeOs+a
   TCuBiFmA0RpZaTEAxmWeTn7XSza720oGXWjwJcgQrCGvduXZUa2yBIF3W
   jmLIVGnpl+VuW10aJUKzWs6MzoHvMlPN5q2Bn6uO43AxlVYqs6WP9VA+e
   NwQJLpmFcgmdoMWh57HXEa7Kx1zOrnGL3OGMt8cji9aQO4AsQ3Mhj9uIB
   Ipx+I3vmZCMaat5EGoIr/d0JflVfDQ+Wl3xMAG9lt+P83tzuDeKBnChFd
   XM3i9F0F8G8RwBKfsT2DBjpeC31TH6pzXn4z6A4+VFI6ZXtwxrfb9NyGt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152283218"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="152283218"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:44:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 549AFD4802;
	Thu, 14 Mar 2024 17:44:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 81B8328730;
	Thu, 14 Mar 2024 17:44:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1AF1A6895D;
	Thu, 14 Mar 2024 17:44:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 807971A006B;
	Thu, 14 Mar 2024 16:44:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org
Subject: [PATCH] atm: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:44:17 +0800
Message-Id: <20240314084417.1321811-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--11.549400-10.000000
X-TMASE-MatchedRID: HBunSHImBEI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS7pujb8urdzZlRzZAkKRGDWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn1/qN7hjwl16poxeSyQcN+o9sfDeGISzthJ13aYUE0ivytu2nWc6kUj8GWfDd0b0zMaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8Krf6vvEcuJykJRYjh96p4fnG5zx7u4S7Fr/QTAXOtV/tSLghn
	a2wH2XI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Chas Williams <3chas3@gmail.com>
CC: linux-atm-general@lists.sourceforge.net
CC: netdev@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/atm/solos-pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index d3c30a28c410..369a7f414f05 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -198,8 +198,8 @@ static ssize_t solos_param_show(struct device *dev, struct device_attribute *att
 
 	header = skb_put(skb, sizeof(*header));
 
-	buflen = snprintf((void *)&header[1], buflen - 1,
-			  "L%05d\n%s\n", current->pid, attr->attr.name);
+	buflen = sysfs_emit((void *)&header[1], "L%05d\n%s\n", current->pid,
+			    attr->attr.name);
 	skb_put(skb, buflen);
 
 	header->size = cpu_to_le16(buflen);
@@ -453,7 +453,7 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
 	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
-		return sprintf(buf, "No data.\n");
+		return sysfs_emit(buf, "No data.\n");
 
 	len = skb->len;
 	memcpy(buf, skb->data, len);
@@ -548,7 +548,7 @@ static ssize_t geos_gpio_show(struct device *dev, struct device_attribute *attr,
 	data32 = ioread32(card->config_regs + GPIO_STATUS);
 	data32 = (data32 >> gattr->offset) & 1;
 
-	return sprintf(buf, "%d\n", data32);
+	return sysfs_emit(buf, "%d\n", data32);
 }
 
 static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
@@ -569,7 +569,7 @@ static ssize_t hardware_show(struct device *dev, struct device_attribute *attr,
 		data32 = (data32 >> 5) & 0x0F;
 		break;
 	}
-	return sprintf(buf, "%d\n", data32);
+	return sysfs_emit(buf, "%d\n", data32);
 }
 
 static DEVICE_ATTR_RW(console);
-- 
2.29.2


