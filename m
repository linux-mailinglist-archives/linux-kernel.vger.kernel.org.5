Return-Path: <linux-kernel+bounces-107100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938087F785
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992BF1F24D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C187F7D1;
	Tue, 19 Mar 2024 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kDOOWYCL"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3897BB17;
	Tue, 19 Mar 2024 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829960; cv=none; b=gfh0ThA2AiQs8xujlHbAFfe9ZoXKRQXnm90zVLLwWTcKv/ynTmbnvY240XQnzZ8ns8otEWRv6ulvkoDTeRqGqAgp7dnC+xHWkcVHLm5pVWZVSgA+Q7g5JlfQidDvjY19Npu3K6kTvGExUojMUxwuxvmeTVNawPdNDkQcEw4JhrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829960; c=relaxed/simple;
	bh=baI9UKcmqI2c5+P3piF1BFtkbLbgepZbgpJ92ne5WiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rOrGfzJHBibIgzmyaT4ZgnRU9HzTi57T+kbZIkm+1wBy4CgCF51ywYfTqzSeBRMBhrkBVz0zWgUhhZiETUEEeBk2aIjOK+rpX6A+wuygpY4/8kIxlEcNhALFx9WawSV3kf/uAJzUlQd7Zj0YhWcGMmHNhrgPTM/Qg+mTNhRb+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kDOOWYCL; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829956; x=1742365956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=baI9UKcmqI2c5+P3piF1BFtkbLbgepZbgpJ92ne5WiI=;
  b=kDOOWYCLznZi6ZIvC7vRr490dqE5mo/uf3wQ8ihwxtoEvMjyFCa0shjh
   ivN5gJVTcuRcsSrQ03unpgdNpiWs5HptgQwqFJelP1Nt5gM7a+uKAzrhv
   ZWs/ElD2o2ephGvgUgtuhjMz0pyViNPU1jH9dbS7zSDK7Nr9BzuA9ONCF
   UXWDTjAvI4gdZO4nV2HiTr9u34PL3LQdmvI/imtZvXfjdPtAGDx0WkTPd
   sJVfk0QbctdhlzgIL89ZXov0QzllbQ64AKSqrmepXY11T0sqX3+FhtXq7
   Vb/hO2akxna6TF/RbuP9cgkdmEpkEuQMuyx3ws+lqNWovykIiLvnJseyA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152681222"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152681222"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:28 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E768C6817;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 84B9ED7B7E;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 165E4227A9F;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 7F6421A006B;
	Tue, 19 Mar 2024 14:32:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Don Brace <don.brace@microchip.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	storagedev@microchip.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 11/25] scsi: smartpqi: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:18 +0800
Message-Id: <20240319063132.1588443-11-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--18.084400-10.000000
X-TMASE-MatchedRID: 5tAkVIfDYR4bO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn188kJuMyiC3lszNrLIKBvFAVnOEgI8O/XG/6CCblACLhmGrGwE7uWstHpEd1UrzmFTTYI
	mZknXwi90lebHNn76Z+TVY0aF/W6kA71xweao1RtnQidXBUtVMWUg/hm489yJXP+fN7LWAfXVJ6
	loCpH42WjpcuRD/SFYRVRrptqkWokfRhdidsajMURSScn+QSXt0H8LFZNFG7JQhrLH5KSJ0=
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
 drivers/scsi/smartpqi/smartpqi_init.c | 86 +++++++++++++--------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 385180c98be4..b4ad519f049e 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6889,13 +6889,13 @@ static ssize_t pqi_firmware_version_show(struct device *dev,
 	shost = class_to_shost(dev);
 	ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", ctrl_info->firmware_version);
+	return sysfs_emit(buffer, "%s\n", ctrl_info->firmware_version);
 }
 
 static ssize_t pqi_driver_version_show(struct device *dev,
 	struct device_attribute *attr, char *buffer)
 {
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", DRIVER_VERSION BUILD_TIMESTAMP);
+	return sysfs_emit(buffer, "%s\n", DRIVER_VERSION BUILD_TIMESTAMP);
 }
 
 static ssize_t pqi_serial_number_show(struct device *dev,
@@ -6907,7 +6907,7 @@ static ssize_t pqi_serial_number_show(struct device *dev,
 	shost = class_to_shost(dev);
 	ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", ctrl_info->serial_number);
+	return sysfs_emit(buffer, "%s\n", ctrl_info->serial_number);
 }
 
 static ssize_t pqi_model_show(struct device *dev,
@@ -6919,7 +6919,7 @@ static ssize_t pqi_model_show(struct device *dev,
 	shost = class_to_shost(dev);
 	ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", ctrl_info->model);
+	return sysfs_emit(buffer, "%s\n", ctrl_info->model);
 }
 
 static ssize_t pqi_vendor_show(struct device *dev,
@@ -6931,7 +6931,7 @@ static ssize_t pqi_vendor_show(struct device *dev,
 	shost = class_to_shost(dev);
 	ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", ctrl_info->vendor);
+	return sysfs_emit(buffer, "%s\n", ctrl_info->vendor);
 }
 
 static ssize_t pqi_host_rescan_store(struct device *dev,
@@ -6952,14 +6952,14 @@ static ssize_t pqi_lockup_action_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(pqi_lockup_actions); i++) {
 		if (pqi_lockup_actions[i].action == pqi_lockup_action)
-			count += scnprintf(buffer + count, PAGE_SIZE - count,
+			count += sysfs_emit_at(buffer, count,
 				"[%s] ", pqi_lockup_actions[i].name);
 		else
-			count += scnprintf(buffer + count, PAGE_SIZE - count,
+			count += sysfs_emit_at(buffer, count,
 				"%s ", pqi_lockup_actions[i].name);
 	}
 
-	count += scnprintf(buffer + count, PAGE_SIZE - count, "\n");
+	count += sysfs_emit_at(buffer, count, "\n");
 
 	return count;
 }
@@ -6990,8 +6990,8 @@ static ssize_t pqi_host_enable_stream_detection_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, 10, "%x\n",
-			ctrl_info->enable_stream_detection);
+	return sysfs_emit(buffer, "%x\n",
+			  ctrl_info->enable_stream_detection);
 }
 
 static ssize_t pqi_host_enable_stream_detection_store(struct device *dev,
@@ -7018,7 +7018,7 @@ static ssize_t pqi_host_enable_r5_writes_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, 10, "%x\n", ctrl_info->enable_r5_writes);
+	return sysfs_emit(buffer, "%x\n", ctrl_info->enable_r5_writes);
 }
 
 static ssize_t pqi_host_enable_r5_writes_store(struct device *dev,
@@ -7045,7 +7045,7 @@ static ssize_t pqi_host_enable_r6_writes_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return scnprintf(buffer, 10, "%x\n", ctrl_info->enable_r6_writes);
+	return sysfs_emit(buffer, "%x\n", ctrl_info->enable_r6_writes);
 }
 
 static ssize_t pqi_host_enable_r6_writes_store(struct device *dev,
@@ -7128,13 +7128,16 @@ static ssize_t pqi_unique_id_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE,
-		"%02X%02X%02X%02X%02X%02X%02X%02X"
-		"%02X%02X%02X%02X%02X%02X%02X%02X\n",
-		unique_id[0], unique_id[1], unique_id[2], unique_id[3],
-		unique_id[4], unique_id[5], unique_id[6], unique_id[7],
-		unique_id[8], unique_id[9], unique_id[10], unique_id[11],
-		unique_id[12], unique_id[13], unique_id[14], unique_id[15]);
+	return sysfs_emit(buffer, "%02X%02X%02X%02X%02X%02X%02X%02X"
+			  "%02X%02X%02X%02X%02X%02X%02X%02X\n",
+			  unique_id[0], unique_id[1], unique_id[2],
+			  unique_id[3],
+			  unique_id[4], unique_id[5], unique_id[6],
+			  unique_id[7],
+			  unique_id[8], unique_id[9], unique_id[10],
+			  unique_id[11],
+			  unique_id[12], unique_id[13], unique_id[14],
+			  unique_id[15]);
 }
 
 static ssize_t pqi_lunid_show(struct device *dev,
@@ -7164,7 +7167,7 @@ static ssize_t pqi_lunid_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE, "0x%8phN\n", lunid);
+	return sysfs_emit(buffer, "0x%8phN\n", lunid);
 }
 
 #define MAX_PATHS	8
@@ -7208,13 +7211,12 @@ static ssize_t pqi_path_info_show(struct device *dev,
 		else
 			continue;
 
-		output_len += scnprintf(buf + output_len,
-					PAGE_SIZE - output_len,
-					"[%d:%d:%d:%d] %20.20s ",
-					ctrl_info->scsi_host->host_no,
-					device->bus, device->target,
-					device->lun,
-					scsi_device_type(device->devtype));
+		output_len += sysfs_emit_at(buf, output_len,
+					    "[%d:%d:%d:%d] %20.20s ",
+					    ctrl_info->scsi_host->host_no,
+					    device->bus, device->target,
+					    device->lun,
+					    scsi_device_type(device->devtype));
 
 		if (device->devtype == TYPE_RAID ||
 			pqi_is_logical_device(device))
@@ -7227,27 +7229,22 @@ static ssize_t pqi_path_info_show(struct device *dev,
 		if (phys_connector[1] < '0')
 			phys_connector[1] = '0';
 
-		output_len += scnprintf(buf + output_len,
-					PAGE_SIZE - output_len,
-					"PORT: %.2s ", phys_connector);
+		output_len += sysfs_emit_at(buf, output_len,
+					    "PORT: %.2s ", phys_connector);
 
 		box = device->box[i];
 		if (box != 0 && box != 0xFF)
-			output_len += scnprintf(buf + output_len,
-						PAGE_SIZE - output_len,
-						"BOX: %hhu ", box);
+			output_len += sysfs_emit_at(buf, output_len,
+						    "BOX: %hhu ", box);
 
 		if ((device->devtype == TYPE_DISK ||
 			device->devtype == TYPE_ZBC) &&
 			pqi_expose_device(device))
-			output_len += scnprintf(buf + output_len,
-						PAGE_SIZE - output_len,
-						"BAY: %hhu ", bay);
+			output_len += sysfs_emit_at(buf, output_len,
+						    "BAY: %hhu ", bay);
 
 end_buffer:
-		output_len += scnprintf(buf + output_len,
-					PAGE_SIZE - output_len,
-					"%s\n", active);
+		output_len += sysfs_emit_at(buf, output_len, "%s\n", active);
 	}
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
@@ -7282,7 +7279,7 @@ static ssize_t pqi_sas_address_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE, "0x%016llx\n", sas_address);
+	return sysfs_emit(buffer, "0x%016llx\n", sas_address);
 }
 
 static ssize_t pqi_ssd_smart_path_enabled_show(struct device *dev,
@@ -7346,7 +7343,7 @@ static ssize_t pqi_raid_level_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", raid_level);
+	return sysfs_emit(buffer, "%s\n", raid_level);
 }
 
 static ssize_t pqi_raid_bypass_cnt_show(struct device *dev,
@@ -7376,7 +7373,7 @@ static ssize_t pqi_raid_bypass_cnt_show(struct device *dev,
 
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
-	return scnprintf(buffer, PAGE_SIZE, "0x%x\n", raid_bypass_cnt);
+	return sysfs_emit(buffer, "0x%x\n", raid_bypass_cnt);
 }
 
 static ssize_t pqi_sas_ncq_prio_enable_show(struct device *dev,
@@ -7402,8 +7399,7 @@ static ssize_t pqi_sas_ncq_prio_enable_show(struct device *dev,
 		return -ENODEV;
 	}
 
-	output_len = snprintf(buf, PAGE_SIZE, "%d\n",
-				device->ncq_prio_enable);
+	output_len = sysfs_emit(buf, "%d\n", device->ncq_prio_enable);
 	spin_unlock_irqrestore(&ctrl_info->scsi_device_list_lock, flags);
 
 	return output_len;
@@ -7455,7 +7451,7 @@ static ssize_t pqi_numa_node_show(struct device *dev,
 	sdev = to_scsi_device(dev);
 	ctrl_info = shost_to_hba(sdev->host);
 
-	return scnprintf(buffer, PAGE_SIZE, "%d\n", ctrl_info->numa_node);
+	return sysfs_emit(buffer, "%d\n", ctrl_info->numa_node);
 }
 
 static DEVICE_ATTR(lunid, 0444, pqi_lunid_show, NULL);
-- 
2.29.2


