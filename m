Return-Path: <linux-kernel+bounces-103077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD2387BAC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66271284262
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045166D1B5;
	Thu, 14 Mar 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="miBVgQHp"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F596CDC0;
	Thu, 14 Mar 2024 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409949; cv=none; b=tMEfIvNYTaQTlqlFL7ZCtCZIg378ZyCGoYj82yeb9MEQYHD83xa7+6n9yU4ZWtac+D8FEmZJuWdx+6MZ4++Z7MTeUoTxYdnbeMlxCjBGrVyE5vmvmrRnbqNsNyZUHcaW3Luu2l6GYV58Nu3AdJ6hgQyJ6DyscAsS7LOaEwpDTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409949; c=relaxed/simple;
	bh=/eLQKrscW5KbKOqJxn8JwtFZ8HO6LGwOx+cyyFz4PMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJnLKGwd5qF4KyOIZmfGCQZgcDvbbNkJ7bwyyt4pPbpImWBL/JVe7aq38yZ6Kw4Sv8aAOQU9FRQAB7hy+rnoBP7apli9uQAzUNftkfZM/7/PvRwlpNxh2sPmd8h7sRiOzREYXCASErG4ZvtgDNzBC4q7sPeLzWlzyQ9zebv1SCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=miBVgQHp; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710409947; x=1741945947;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/eLQKrscW5KbKOqJxn8JwtFZ8HO6LGwOx+cyyFz4PMc=;
  b=miBVgQHpYWb75LTR0ZeAPB5nfaI8pcCyemmjPnGcqGo1lQMUSiJIBDEA
   8Ui2MlF+wgYBoNQCr2X6AWmS3wdeNjv6caSi45g4KfEsmCFgirpoYFmRj
   QNiYtuz96qxACeB5QXdtVWggzte16FJlvsCWVUODVENmPvljzaoCynz4u
   7foPpQzIv+1UN4ljEz7ZqHR5N08+Vs/2DRIKZprGTeHVNYT3+Ez0U3EDy
   c8D8yqwk6Y+C2Sq4+o1nvqg4FFm+ELThmsJs2n1M2p5nVfAiRAzbXF8Vt
   l+YLB6GgYtqJQp6IPLXxv+X9cmTm8DxE7opWK7uB8caljhYcWLOnZmJ77
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="139871825"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="139871825"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:52:23 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 262D45DE23;
	Thu, 14 Mar 2024 18:52:21 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B361E631B;
	Thu, 14 Mar 2024 18:52:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 045D720093269;
	Thu, 14 Mar 2024 18:52:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4518C1A006B;
	Thu, 14 Mar 2024 17:52:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH] s390/cio: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:52:09 +0800
Message-Id: <20240314095209.1325229-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--7.671400-10.000000
X-TMASE-MatchedRID: e6WPXQD7Ri84ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NpBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYO0ekSi+00U24ReM8i8p3vgEyQ5fRSh265uBsk5njfgGzYJp
	3mzrbmsPdcQ4/ZOO0Rnagtny7ZPcQfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPCfyuXWEgP3xnc6o
	Dizu5zS2Wc8riKqD5DjblkGDJuLaSZW8DARDgA6
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

CC: Vineeth Vijayan <vneethv@linux.ibm.com>
CC: Peter Oberparleiter <oberpar@linux.ibm.com>
CC: Heiko Carstens <hca@linux.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Alexander Gordeev <agordeev@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@linux.ibm.com>
CC: Sven Schnelle <svens@linux.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/s390/cio/css.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 094431a62ad5..4fec251ec35d 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -309,7 +309,7 @@ static ssize_t type_show(struct device *dev, struct device_attribute *attr,
 {
 	struct subchannel *sch = to_subchannel(dev);
 
-	return sprintf(buf, "%01x\n", sch->st);
+	return sysfs_emit(buf, "%01x\n", sch->st);
 }
 
 static DEVICE_ATTR_RO(type);
@@ -319,7 +319,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 {
 	struct subchannel *sch = to_subchannel(dev);
 
-	return sprintf(buf, "css:t%01X\n", sch->st);
+	return sysfs_emit(buf, "css:t%01X\n", sch->st);
 }
 
 static DEVICE_ATTR_RO(modalias);
@@ -345,7 +345,7 @@ static ssize_t driver_override_show(struct device *dev,
 	ssize_t len;
 
 	device_lock(dev);
-	len = snprintf(buf, PAGE_SIZE, "%s\n", sch->driver_override);
+	len = sysfs_emit(buf, "%s\n", sch->driver_override);
 	device_unlock(dev);
 	return len;
 }
@@ -396,7 +396,7 @@ static ssize_t pimpampom_show(struct device *dev,
 	struct subchannel *sch = to_subchannel(dev);
 	struct pmcw *pmcw = &sch->schib.pmcw;
 
-	return sprintf(buf, "%02x %02x %02x\n",
+	return sysfs_emit(buf, "%02x %02x %02x\n",
 		       pmcw->pim, pmcw->pam, pmcw->pom);
 }
 static DEVICE_ATTR_RO(pimpampom);
@@ -881,7 +881,7 @@ static ssize_t real_cssid_show(struct device *dev, struct device_attribute *a,
 	if (!css->id_valid)
 		return -EINVAL;
 
-	return sprintf(buf, "%x\n", css->cssid);
+	return sysfs_emit(buf, "%x\n", css->cssid);
 }
 static DEVICE_ATTR_RO(real_cssid);
 
@@ -904,7 +904,7 @@ static ssize_t cm_enable_show(struct device *dev, struct device_attribute *a,
 	int ret;
 
 	mutex_lock(&css->mutex);
-	ret = sprintf(buf, "%x\n", css->cm_enabled);
+	ret = sysfs_emit(buf, "%x\n", css->cm_enabled);
 	mutex_unlock(&css->mutex);
 	return ret;
 }
-- 
2.29.2


