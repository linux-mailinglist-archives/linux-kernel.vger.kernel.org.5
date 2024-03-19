Return-Path: <linux-kernel+bounces-107086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C17787F767
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032D5281E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09DF54657;
	Tue, 19 Mar 2024 06:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IEJy0ex/"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D54F8A0;
	Tue, 19 Mar 2024 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829953; cv=none; b=o14wQU7uhiKvPVuEjLB/nBx6FeEX6bF7j7Bd0Qv856su5GnMGIu9e/Z33hyfEv34oBQHr5gyNoDz/aqG6tvB4RmeQpq50c3vu+dh3KssirwsZH4j+Z6puJzY8rdOclDMgW8zBqJZwu8INqI27pTiThyzN07B3jHJhSK2opVnGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829953; c=relaxed/simple;
	bh=tBThCQPjQE/29YQco1ef1zGiklQgfc7gHW6Rwmw4KJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t8h3ov7ffUo4gCm5XyR3JslFCMD+vPIr+SD2QfvZCMMsmlT34k2QEbunX7QvDp30bRYVcX9jwRuw3cAxQxn7a9vqlPjbA0jciY63PV7pq2au+Lt2FltdgLUbmAIPMtO3QciA4+DIG28ehaf+eb4bqnx8mKSvtPuV6qRLHD+6WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IEJy0ex/; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829952; x=1742365952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBThCQPjQE/29YQco1ef1zGiklQgfc7gHW6Rwmw4KJs=;
  b=IEJy0ex/iZzZbOMMsC4+98xBnLxI6GaHOS4hQ9q8yt06ZppupinwxQ4U
   qbJTTu02w7RnUgfOFQAPv0eslwQdqTwQh7XNORxX3x0Pt01Zwz4HrYv6K
   Mn7kE+te900tXezkXANUunfD+5dVJlweQhC55JaBuqh1+8Pimvie9aPZg
   doHc9hcEnVl0iwUWR/uQIiYIR6/xW6petXh8sxIYlaShO+FrZN6ciurvI
   ceGvtLeV/TH2pqTgj1+FDOWc9Afl1eC13ZxX/v+lUNSYCv7zmCEYacb7W
   RmJ1brcDTgJ4DmqIFX9251Imm9FRwSWkgWAA1IlmU9M+a1MPS3873R+CK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152728478"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152728478"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 28BDE2A0DFB;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 63FFAD7B7E;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id CF411227ABA;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5319E1A006B;
	Tue, 19 Mar 2024 14:32:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 13/25] scsi: hpsa: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:20 +0800
Message-Id: <20240319063132.1588443-13-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--4.559400-10.000000
X-TMASE-MatchedRID: GSiycdxM5vsbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn1/U37CXnDNb0YMIDOhn95YjK20n6F2q4vXIXgPJ4AG/7JScvOTX4jHOQc9WQFO7fUxKTG
	NKPwaynJU6aUX+3vkKsvKI2PiWDPatXt2Ka9+bg5JzEkxvZR/ihHrZE2+S86/3pfg0cr18IIta5
	3KBVoI51TUobi0Qhw+/g2JkR9Lgz4mj1E/mjepKeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8hxKpv
	EGAbTDkkshj6jzgHA7FiJ07jWNmIhk4P7jJXT8jzso9K68PwwlLQqrPi+WrvqIdgzy2DY5X5dMA
	go6+pwap9QDWZQntFsPqi2YChHZ1uMG6V02+QySir3tZId0WN+6klq53W5kJ9Gzq4huQVX
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

CC: Don Brace <don.brace@microchip.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: storagedev@microchip.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/hpsa.c | 83 +++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index af18d20f3079..8d2c1f84c739 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -445,7 +445,7 @@ static ssize_t host_show_lockup_detected(struct device *dev,
 	h = shost_to_hba(shost);
 	ld = lockup_detected(h);
 
-	return sprintf(buf, "ld=%d\n", ld);
+	return sysfs_emit(buf, "ld=%d\n", ld);
 }
 
 static ssize_t host_store_hp_ssd_smart_path_status(struct device *dev,
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
@@ -535,8 +535,7 @@ static ssize_t host_show_commands_outstanding(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ctlr_info *h = shost_to_hba(shost);
 
-	return snprintf(buf, 20, "%d\n",
-			atomic_read(&h->commands_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&h->commands_outstanding));
 }
 
 static ssize_t host_show_transport_mode(struct device *dev,
@@ -546,9 +545,9 @@ static ssize_t host_show_transport_mode(struct device *dev,
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
@@ -558,8 +557,8 @@ static ssize_t host_show_hp_ssd_smart_path_status(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 30, "HP SSD Smart Path %s\n",
-		(h->acciopath_status == 1) ?  "enabled" : "disabled");
+	return sysfs_emit(buf, "HP SSD Smart Path %s\n",
+			  (h->acciopath_status == 1) ?  "enabled" : "disabled");
 }
 
 /* List of controllers which cannot be hard reset on kexec with reset_devices */
@@ -642,7 +641,7 @@ static ssize_t host_show_resettable(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", ctlr_is_resettable(h->board_id));
+	return sysfs_emit(buf, "%d\n", ctlr_is_resettable(h->board_id));
 }
 
 static inline int is_logical_dev_addr_mode(unsigned char scsi3addr[])
@@ -690,7 +689,7 @@ static ssize_t raid_level_show(struct device *dev,
 	/* Is this even a logical drive? */
 	if (!is_logical_device(hdev)) {
 		spin_unlock_irqrestore(&h->lock, flags);
-		l = snprintf(buf, PAGE_SIZE, "N/A\n");
+		l = sysfs_emit(buf, "N/A\n");
 		return l;
 	}
 
@@ -698,7 +697,7 @@ static ssize_t raid_level_show(struct device *dev,
 	spin_unlock_irqrestore(&h->lock, flags);
 	if (rlevel > RAID_UNKNOWN)
 		rlevel = RAID_UNKNOWN;
-	l = snprintf(buf, PAGE_SIZE, "RAID %s\n", raid_label[rlevel]);
+	l = sysfs_emit(buf, "RAID %s\n", raid_label[rlevel]);
 	return l;
 }
 
@@ -721,7 +720,7 @@ static ssize_t lunid_show(struct device *dev,
 	}
 	memcpy(lunid, hdev->scsi3addr, sizeof(lunid));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 20, "0x%8phN\n", lunid);
+	return sysfs_emit(buf, "0x%8phN\n", lunid);
 }
 
 static ssize_t unique_id_show(struct device *dev,
@@ -743,13 +742,12 @@ static ssize_t unique_id_show(struct device *dev,
 	}
 	memcpy(sn, hdev->device_id, sizeof(sn));
 	spin_unlock_irqrestore(&h->lock, flags);
-	return snprintf(buf, 16 * 2 + 2,
-			"%02X%02X%02X%02X%02X%02X%02X%02X"
-			"%02X%02X%02X%02X%02X%02X%02X%02X\n",
-			sn[0], sn[1], sn[2], sn[3],
-			sn[4], sn[5], sn[6], sn[7],
-			sn[8], sn[9], sn[10], sn[11],
-			sn[12], sn[13], sn[14], sn[15]);
+	return sysfs_emit(buf, "%02X%02X%02X%02X%02X%02X%02X%02X"
+			  "%02X%02X%02X%02X%02X%02X%02X%02X\n",
+			  sn[0], sn[1], sn[2], sn[3],
+			  sn[4], sn[5], sn[6], sn[7],
+			  sn[8], sn[9], sn[10], sn[11],
+			  sn[12], sn[13], sn[14], sn[15]);
 }
 
 static ssize_t sas_address_show(struct device *dev,
@@ -772,7 +770,7 @@ static ssize_t sas_address_show(struct device *dev,
 	sas_address = hdev->sas_address;
 	spin_unlock_irqrestore(&h->lock, flags);
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n", sas_address);
+	return sysfs_emit(buf, "0x%016llx\n", sas_address);
 }
 
 static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
@@ -796,10 +794,10 @@ static ssize_t host_show_hp_ssd_smart_path_enabled(struct device *dev,
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
@@ -837,17 +835,15 @@ static ssize_t path_info_show(struct device *dev,
 		else
 			continue;
 
-		output_len += scnprintf(buf + output_len,
-				PAGE_SIZE - output_len,
+		output_len += sysfs_emit_at(buf, output_len,
 				"[%d:%d:%d:%d] %20.20s ",
 				h->scsi_host->host_no,
 				hdev->bus, hdev->target, hdev->lun,
 				scsi_device_type(hdev->devtype));
 
 		if (hdev->devtype == TYPE_RAID || is_logical_device(hdev)) {
-			output_len += scnprintf(buf + output_len,
-						PAGE_SIZE - output_len,
-						"%s\n", active);
+			output_len += sysfs_emit_at(buf, output_len,
+						    "%s\n", active);
 			continue;
 		}
 
@@ -858,30 +854,27 @@ static ssize_t path_info_show(struct device *dev,
 			phys_connector[0] = '0';
 		if (phys_connector[1] < '0')
 			phys_connector[1] = '0';
-		output_len += scnprintf(buf + output_len,
-				PAGE_SIZE - output_len,
+		output_len += sysfs_emit_at(buf, output_len,
 				"PORT: %.2s ",
 				phys_connector);
 		if ((hdev->devtype == TYPE_DISK || hdev->devtype == TYPE_ZBC) &&
 			hdev->expose_device) {
 			if (box == 0 || box == 0xFF) {
-				output_len += scnprintf(buf + output_len,
-					PAGE_SIZE - output_len,
-					"BAY: %hhu %s\n",
-					bay, active);
+				output_len += sysfs_emit_at(buf, output_len,
+							    "BAY: %hhu %s\n",
+							     bay, active);
 			} else {
-				output_len += scnprintf(buf + output_len,
-					PAGE_SIZE - output_len,
+				output_len += sysfs_emit_at(buf, output_len,
 					"BOX: %hhu BAY: %hhu %s\n",
 					box, bay, active);
 			}
 		} else if (box != 0 && box != 0xFF) {
-			output_len += scnprintf(buf + output_len,
-				PAGE_SIZE - output_len, "BOX: %hhu %s\n",
-				box, active);
+			output_len += sysfs_emit_at(buf, output_len,
+						    "BOX: %hhu %s\n",
+						    box, active);
 		} else
-			output_len += scnprintf(buf + output_len,
-				PAGE_SIZE - output_len, "%s\n", active);
+			output_len += sysfs_emit_at(buf, output_len,
+						    "%s\n", active);
 	}
 
 	spin_unlock_irqrestore(&h->devlock, flags);
@@ -895,7 +888,7 @@ static ssize_t host_show_ctlr_num(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->ctlr);
+	return sysfs_emit(buf, "%d\n", h->ctlr);
 }
 
 static ssize_t host_show_legacy_board(struct device *dev,
@@ -905,7 +898,7 @@ static ssize_t host_show_legacy_board(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 
 	h = shost_to_hba(shost);
-	return snprintf(buf, 20, "%d\n", h->legacy_board ? 1 : 0);
+	return sysfs_emit(buf, "%d\n", h->legacy_board ? 1 : 0);
 }
 
 static DEVICE_ATTR_RO(raid_level);
-- 
2.29.2


