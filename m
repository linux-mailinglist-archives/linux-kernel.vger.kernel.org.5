Return-Path: <linux-kernel+bounces-26973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1582E8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AFB1C224BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913B1B7EE;
	Tue, 16 Jan 2024 04:52:31 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68ADF11184;
	Tue, 16 Jan 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125018769"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125018769"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:21 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6865BD6186;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E067E399D;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3CAFC6B4C9;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C83DE1A0160;
	Tue, 16 Jan 2024 12:52:17 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:24 +0800
Message-Id: <20240116045151.3940401-13-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--8.370000-10.000000
X-TMASE-MatchedRID: 6SYb29c3rTQ4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxTuctSpiuWyUUi4Ehat05499RlPzeVuQQrI7
	SkweN/esJ//Y+eUvH+c4WYLmQfXYmpoPHQXywp1dv+ggm5QAi4X0tCKdnhB58I/9UW5M5dRM+8F
	JNGdxYq46HM5rqDwqtcqB4bMvgKHUVNZz2PtKgH4DCmzb1E89ZCX01fDM/ueYwzO0EhsSbLA==
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
 drivers/ptp/ptp_sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index f7a499a1bd39..49737ed6ef5f 100644
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
 
-- 
2.29.2


