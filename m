Return-Path: <linux-kernel+bounces-37879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2824383B6F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235281C225D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050526AAD;
	Thu, 25 Jan 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HRhvBguX"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98D1877;
	Thu, 25 Jan 2024 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147694; cv=none; b=DbUqilvilQXEvtZIwxVHSUtPHUlJvoEFLFMZibJODQSwKogmOOKRM938yfVKcxiKJiriqfo/tx6b79yJAFgE3cZElipVpkkXA/vSuenNl3FyaZmqmkkVPle0QawgM0RYGBAAIvTskXQpmyvmUz7LVM//jjj+inAGGodvxh3s8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147694; c=relaxed/simple;
	bh=GnHprCsoT00KvUFtyFKwQ5DA/xCH/4WZcrOcpXPEK6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bnb2cqugXlUbX7GLruBEhu5qP8QQIoHc3/fNRFxu8t05I572EwHb7xnEygt2snZMfn3G/E5fQLsaL/e/MFuOEmrglym+YVDPJQ/i3rwL+/C8aKFnggtvmMdaiiSXypxfGIi3HFVLVQnmiGOVwhRUspzWJaTiNCAwrehv3ftx5Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HRhvBguX; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706147692; x=1737683692;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GnHprCsoT00KvUFtyFKwQ5DA/xCH/4WZcrOcpXPEK6E=;
  b=HRhvBguXunFdGoMYrcQW2OnxRxcQkDIImw4Zepc1ud/uD8mc+O6xMjly
   TiA2KRax6aVVwmabAjPlnLgxoCvQcnlQr0jOYubJeKNa++JmrkeSMmpLF
   BdldIAAtY0usjumKETg8GoTKyiWArJYlWbcxE4mQ+hSYimpsgsqjaC+VI
   7aGOjNRgnmuU93ODdzsEAE6VdRW2r0ZpaXOtgGSnc4SagXHFDkujvuWVa
   HW/DpDOAzbFnqgvITQQFJfGe8zJJVvIpCUdwaiNYyAO+dotKmwgQvj6Mo
   BxF4Ac5ucGz3Q7zO+kscitH54ihE92bb4u4QtXG1ztfbdPS+SRgWJPoKD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="147187492"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="147187492"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 10:53:39 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 41867D618B;
	Thu, 25 Jan 2024 10:53:37 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 71218D1C76;
	Thu, 25 Jan 2024 10:53:36 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 057B3E4A86;
	Thu, 25 Jan 2024 10:53:36 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 641971A006A;
	Thu, 25 Jan 2024 09:53:35 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2] drivers/ptp: Convert snprintf to sysfs_emit
Date: Thu, 25 Jan 2024 09:53:29 +0800
Message-Id: <20240125015329.123023-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28140.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28140.004
X-TMASE-Result: 10--15.010700-10.000000
X-TMASE-MatchedRID: /mcjwogdDrk4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxX9knSHW8uXXVBDonH99+VgRE/BdsvMyhGHU
	g3i70NfZ3yadK9iyoPuaffHI8kAmiHY/bzRmIaZG/QNwZdfw3FT92Og3IOZltnhD4vcFcha7Ivl
	CZY6Ax8IHA6IBd3vQsOj6XE+KuI6RkQckJEC3Q2uJMNIftzCCTrzl8sNiWClKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDWOuyQQOqzyRI+AMjnyevTh7m6ny1nk82W6VLMp1rtItBIQrXCPVDUF
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Richard Cochran <richardcochran@gmail.com>
CC: netdev@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
- Address Rahul's comments:
  Convert all leftover snprintf that is not detected by coccinelle to sysfs_emit
-
  V2: extract patch from the patch set[1] so that maintainer can review/accept it separately.
  [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/ptp/ptp_sysfs.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index f7a499a1bd39..a15460aaa03b 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -24,8 +24,7 @@ static ssize_t max_phase_adjustment_show(struct device *dev,
 {
 	struct ptp_clock *ptp = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE - 1, "%d\n",
-			ptp->info->getmaxphase(ptp->info));
+	return sysfs_emit(page, "%d\n", ptp->info->getmaxphase(ptp->info));
 }
 static DEVICE_ATTR_RO(max_phase_adjustment);
 
@@ -34,7 +33,7 @@ static ssize_t var##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *page)	\
 {									\
 	struct ptp_clock *ptp = dev_get_drvdata(dev);			\
-	return snprintf(page, PAGE_SIZE-1, "%d\n", ptp->info->var);	\
+	return sysfs_emit(page, "%d\n", ptp->info->var);	\
 }									\
 static DEVICE_ATTR(name, 0444, var##_show, NULL);
 
@@ -102,8 +101,8 @@ static ssize_t extts_fifo_show(struct device *dev,
 	if (!qcnt)
 		goto out;
 
-	cnt = snprintf(page, PAGE_SIZE, "%u %lld %u\n",
-		       event.index, event.t.sec, event.t.nsec);
+	cnt = sysfs_emit(page, "%u %lld %u\n",
+			 event.index, event.t.sec, event.t.nsec);
 out:
 	return cnt;
 }
@@ -194,7 +193,7 @@ static ssize_t n_vclocks_show(struct device *dev,
 	if (mutex_lock_interruptible(&ptp->n_vclocks_mux))
 		return -ERESTARTSYS;
 
-	size = snprintf(page, PAGE_SIZE - 1, "%u\n", ptp->n_vclocks);
+	size = sysfs_emit(page, "%u\n", ptp->n_vclocks);
 
 	mutex_unlock(&ptp->n_vclocks_mux);
 
@@ -270,7 +269,7 @@ static ssize_t max_vclocks_show(struct device *dev,
 	struct ptp_clock *ptp = dev_get_drvdata(dev);
 	ssize_t size;
 
-	size = snprintf(page, PAGE_SIZE - 1, "%u\n", ptp->max_vclocks);
+	size = sysfs_emit(page, "%u\n", ptp->max_vclocks);
 
 	return size;
 }
-- 
2.29.2


