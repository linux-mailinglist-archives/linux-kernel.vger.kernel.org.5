Return-Path: <linux-kernel+bounces-107084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1329787F762
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E576A1C213DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD47D51C34;
	Tue, 19 Mar 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nzU/xCkt"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9C208DA;
	Tue, 19 Mar 2024 06:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829951; cv=none; b=FGX12lelE3+3DiRMRgcZUomROG5H76r520H+5diz4Fe26c7TpJvvyRlTOFxU2Igp59jKNFuqVLr6h+zh8v4FuJosnAEZj55RPHm44jTnr6HYhM3fu4AINxPf1j0uF/lzfwVSV9XdpnOobtWyWxHg+2OWDBPsgVnM4RgOIdYoADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829951; c=relaxed/simple;
	bh=V4maAJaq34YaWmfmxUxtcXRMFcNFk9d5IOBVN/enRVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgPQ9nyB80TQfvxA9X1BO6rXXIhXOVFE5ocrqptJXFJ7gjxN/w15Ys8lualUS2sjA/TnVojJ6TvR8ulIMFf+b4uzRKlGjZiylLjov3pqaEITYxHI12K7aQuTZAoxFncsfpTTx2+8RnY+ozV9hhgGJ+CgtDAEae9K4aZSdFVtEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nzU/xCkt; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829949; x=1742365949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V4maAJaq34YaWmfmxUxtcXRMFcNFk9d5IOBVN/enRVk=;
  b=nzU/xCktZfGXGhoOgKjlcpxMhaIS12gfZd5wH5wQivTbOqLOZJL17JT5
   etOsceP+3ZOqEGDBDgvCfYFSvzT0m5xCStkFFau6hoWbwpJrPO/AzZHRM
   M2KNbm0wZlPEj2aOQh17sHvoWsXRpbtYs8nK7uYa9v3zmjkCTgOCQNvSP
   c+evthb1uD2CZUKzieBlz+9yPJk1/6+Ue6mGu+gGjuTw5akhRcslKA+oE
   mq4iKivPMvHj6IG8VLK189j1iAmTXG3p7ZuJYKlr8GFznXdyo/mQT++4H
   Y2M7tJc+ZBZVXMoIvq8GRDwMg+oLS62Dx7t3znhjyNFdgiHpqHd26IGVS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="132064677"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="132064677"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:26 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C64A6141203;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E6EB9C5205;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EF1020099077;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id E32C31A006B;
	Tue, 19 Mar 2024 14:32:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 07/25] scsi: megaraid: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:14 +0800
Message-Id: <20240319063132.1588443-7-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--11.401400-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3IbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/wK0ZgbTOeKUwLkNMQzGl5B+Kr
	WCPbERP80Age9hS2jaorLpu20+QH7QVDF+NEc7OLNE9DxPih7lWQ3R4k5PTnCm04TWLzKiuBhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vlJCE5xaQ34yOfAg8k/613mIZPVAHECUgnLiz
	jkg33w6g3hSkeF22Zw==
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

CC: Kashyap Desai <kashyap.desai@broadcom.com>
CC: Sumit Saxena <sumit.saxena@broadcom.com>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: Chandrakanth patil <chandrakanth.patil@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: megaraidlinux.pdl@broadcom.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..07df615f43af 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3333,8 +3333,8 @@ fw_crash_buffer_size_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
-		((instance->fw_crash_buffer_size) * 1024 * 1024)/PAGE_SIZE);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)
+		((instance->fw_crash_buffer_size) * 1024 * 1024) / PAGE_SIZE);
 }
 
 static ssize_t
@@ -3379,14 +3379,14 @@ fw_crash_state_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
+	return sysfs_emit(buf, "%d\n", instance->fw_crash_state);
 }
 
 static ssize_t
 page_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)PAGE_SIZE - 1);
 }
 
 static ssize_t
@@ -3396,7 +3396,8 @@ ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->ldio_outstanding));
+	return sysfs_emit(buf, "%d\n",
+			  atomic_read(&instance->ldio_outstanding));
 }
 
 static ssize_t
@@ -3406,7 +3407,7 @@ fw_cmds_outstanding_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
 static ssize_t
@@ -3416,7 +3417,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", instance->enable_sdev_max_qd);
 }
 
 static ssize_t
@@ -3470,8 +3471,7 @@ raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 	struct megasas_instance *instance =
 			(struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n",
-			(unsigned long)instance->map_id);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)instance->map_id);
 }
 
 static DEVICE_ATTR_RW(fw_crash_buffer);
-- 
2.29.2


