Return-Path: <linux-kernel+bounces-26972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708E382E8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25F1B223CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EB1756C;
	Tue, 16 Jan 2024 04:52:31 +0000 (UTC)
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AA38495;
	Tue, 16 Jan 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134631008"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134631008"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:24 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1EDC5D9D96;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 418CED5405;
	Tue, 16 Jan 2024 13:52:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D203E6B4C6;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5B6A11A015F;
	Tue, 16 Jan 2024 12:52:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 23/42] drivers/scsi/hpsa: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:32 +0800
Message-Id: <20240116045151.3940401-21-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--10.935000-10.000000
X-TMASE-MatchedRID: APZBv0eB5fI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUgK6
	qCGa1Z9eMQJrSLBycSUc+YfLo55UjzYigC8AbwLJyF4DyeABv+yUnLzk1+IxzkHPVkBTu31MSkx
	jSj8Gsp3trTGsCzWwdiEuXwwgKclUFcDs4QDuP/mY+xOrx57jWIQTCbSdwtuIDx6oqiF8ShuK5f
	hRxt1aAaUkHgTSDEhtCNEei2kg1tJcFdomgH0lnFEUknJ/kEl7dB/CxWTRRu25FeHtsUoHuzcE9
	HLgEIHXa4kRhzyZJ025WgtyOGkiRRBN94Mo85kwchXTZ3Wukbw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/hpsa.c:528:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:538:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:549:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:561:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:645:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:724:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:746:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:775:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:799:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:898:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/hpsa.c:908:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Don Brace <don.brace@microchip.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: storagedev@microchip.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/hpsa.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..5736c0f7a1be 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -525,8 +525,8 @@ static ssize_t host_show_firmware_revision(struct device *dev,
 	if (!h->hba_inquiry_data)
 		return 0;
 	fwrev = &h->hba_inquiry_data[32];
-	return snprintf(buf, 20, "%c%c%c%c\n",
-		fwrev[0], fwrev[1], fwrev[2], fwrev[3]);
+	return sysfs_emit(buf, "%c%c%c%c\n",
+			  fwrev[0], fwrev[1], fwrev[2], fwrev[3]);
 }
 
 static ssize_t host_show_commands_outstanding(struct device *dev,
@@ -535,8 +535,8 @@ static ssize_t host_show_commands_outstanding(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ctlr_info *h = shost_to_hba(shost);
 
-	return snprintf(buf, 20, "%d\n",
-			atomic_read(&h->commands_outstanding));
+	return sysfs_emit(buf, "%d\n",
+			  atomic_read(&h->commands_outstanding));
 }
 
 static ssize_t host_show_transport_mode(struct device *dev,
@@ -546,9 +546,9 @@ static ssize_t host_show_transport_mode(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%s\n",
-		h->transMethod & CFGTBL_Trans_Performant ?
-			"performant" : "simple");
+	return sysfs_emit(buf, "%s\n",
+			  h->transMethod & CFGTBL_Trans_Performant ?
+			  "performant" : "simple");
 }
 
 static ssize_t host_show_hp_ssd_smart_path_status(struct device *dev,
@@ -558,8 +558,8 @@ static ssize_t host_show_hp_ssd_smart_path_status(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 30, "HP SSD Smart Path %s\n",
-		(h->acciopath_status == 1) ?  "enabled" : "disabled");
+	return sysfs_emit(buf, "HP SSD Smart Path %s\n",
+			  (h->acciopath_status == 1) ?  "enabled" : "disabled");
 }
 
 /* List of controllers which cannot be hard reset on kexec with reset_devices */
@@ -642,7 +642,7 @@ static ssize_t host_show_resettable(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", ctlr_is_resettable(h->board_id));
+	return sysfs_emit(buf, "%d\n", ctlr_is_resettable(h->board_id));
 }
 
 static inline int is_logical_dev_addr_mode(unsigned char scsi3addr[])
@@ -721,7 +721,7 @@ static ssize_t lunid_show(struct device *dev,
 	}
 	memcpy(lunid, hdev->scsi3addr, sizeof(lunid));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 20, "0x%8phN\n", lunid);
+	return sysfs_emit(buf, "0x%8phN\n", lunid);
 }
 
 static ssize_t unique_id_show(struct device *dev,
@@ -743,7 +743,7 @@ static ssize_t unique_id_show(struct device *dev,
 	}
 	memcpy(sn, hdev->device_id, sizeof(sn));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 16 * 2 + 2,
+	return sysfs_emit(buf,
 			"%02X%02X%02X%02X%02X%02X%02X%02X"
 			"%02X%02X%02X%02X%02X%02X%02X%02X\n",
 			sn[0], sn[1], sn[2], sn[3],
@@ -772,7 +772,7 @@ static ssize_t sas_address_show(struct device *dev,
 	sas_address = hdev->sas_address;
 	spin_unlock_irqrestore(&h->lock, flags);
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n", sas_address);
+	return sysfs_emit(buf, "0x%016llx\n", sas_address);
 }
 
 static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
@@ -796,10 +796,10 @@ static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
 	spin_unlock_irqrestore(&h->lock, flags);
 
 	if (hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC)
-		return snprintf(buf, 20, "%d\n", offload_enabled);
+		return sysfs_emit(buf, "%d\n", offload_enabled);
 	else
-		return snprintf(buf, 40, "%s\n",
-				"Not applicable for a controller");
+		return sysfs_emit(buf, "%s\n",
+				  "Not applicable for a controller");
 }
 
 #define MAX_PATHS 8
@@ -895,7 +895,7 @@ static ssize_t host_show_ctlr_num(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->ctlr);
+	return sysfs_emit(buf, "%d\n", h->ctlr);
 }
 
 static ssize_t host_show_legacy_board(struct device *dev,
@@ -905,7 +905,7 @@ static ssize_t host_show_legacy_board(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->legacy_board ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", h->legacy_board ? 1 : 0);
 }
 
 static DEVICE_ATTR_RO(raid_level);
-- 
2.29.2


