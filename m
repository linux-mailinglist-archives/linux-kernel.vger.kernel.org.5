Return-Path: <linux-kernel+bounces-27001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B629B82E8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400C5284E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D38D1D528;
	Tue, 16 Jan 2024 04:53:37 +0000 (UTC)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C38125B8;
	Tue, 16 Jan 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="133883823"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="133883823"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:26 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id ADC21D9D96;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D9229BF498;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 65968200A571F;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id DF70F1A0070;
	Tue, 16 Jan 2024 12:52:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 27/42] drivers/scsi/isci: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:36 +0800
Message-Id: <20240116045151.3940401-25-lizhijian@fujitsu.com>
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
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--8.691000-10.000000
X-TMASE-MatchedRID: 6SYb29c3rTQ4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4YuJ+QzKcxqTLdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8vYRhsicUjm84WYLmQfXYmpoPHQXywp1dKzjuZtPtIBH0tCKdnhB58I/9UW5M5dRNp7q
	EhmmPgy46HM5rqDwqtIoT1kA8A17I5ZLFwfHbExp8OJA/0wv/axoNjqIW+oL/stU4J8kSlZQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/isci/init.c:140:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/isci/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index 6277162a028b..c582a3932cea 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -137,7 +137,7 @@ static ssize_t isci_show_id(struct device *dev, struct device_attribute *attr, c
 	struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 	struct isci_host *ihost = container_of(sas_ha, typeof(*ihost), sas_ha);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ihost->id);
+	return sysfs_emit(buf, "%d\n", ihost->id);
 }
 
 static DEVICE_ATTR(isci_id, S_IRUGO, isci_show_id, NULL);
-- 
2.29.2


