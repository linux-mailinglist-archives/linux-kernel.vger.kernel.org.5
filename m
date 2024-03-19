Return-Path: <linux-kernel+bounces-107101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA7C87F783
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC41D1F24F20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26737F7C6;
	Tue, 19 Mar 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="tXdSAeV7"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11157D3F1;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829960; cv=none; b=unsKn8k8yGAqhdJA5qI+cvSBJdtTyUTMUVWXIzSdsnI+4bfpzv4JBEiBH2I6cwZ8b+1Rn1iLAQG22vHdJQcKNVdbexHxObUZpxWiESIglHph6f2AZ1p0bi4OH+BaRRpBqEuvbPT29x9rHcDdZzXvF9vhLZq/pin9zbOy211/LEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829960; c=relaxed/simple;
	bh=3CQ3zUMY/EjhCuVlZvkqIDd++5xfBApx+Z+AS2rKVvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXbvy64EoioVgjcIZT4TtnJovRGl5lnShRwAV0Jr4QYVfKC4qDMD69LPxKo4IRR1ORGZDhUUOynEpxVJxcZiXNOo1lGnPjsGbEwBGMfL/0khelFpUhXmackQYN3ZzQdrKmNonCRwJ/LZulfTREkc2e+DVk4oNBboPBRZLQNm778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=tXdSAeV7; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829957; x=1742365957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3CQ3zUMY/EjhCuVlZvkqIDd++5xfBApx+Z+AS2rKVvA=;
  b=tXdSAeV7LaNfdy+qI/R+Fvf/ppYoumH6qKELiZFGRuiJUFmmV89Edp5A
   qY/ByoJda3MSoMJ+mALCVnFt8jDECMFV4O+AJ8P5B2C0VnYKzfWYx7Hk2
   Z/SIvlZ075PacdYBe7jBcG+i06S73vZhaY1HoIiCu7bd55A8yC649Izwx
   zlBnANRkPR1hm0/BYGZAOD/w6czXWzzRJzjp3JoEzPRmPIfogb/d3AfYI
   95G6Q62EQjt1fB24kPkyCIR2qgIwQaItyQYlqCMdqPWiWjcEjsUAdJYcr
   Axn5t1qcOc7PZkxm22uF0KhZvEmIZ6QAB5wqpVbpcXOoPeInIIGet/Ktq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152151609"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152151609"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:28 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E3099D4807;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 11174D5623;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 95A0C200A7E3A;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 12D601A006B;
	Tue, 19 Mar 2024 14:32:25 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Brian King <brking@us.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 15/25] scsi: ipr: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:22 +0800
Message-Id: <20240319063132.1588443-15-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.337400-10.000000
X-TMASE-MatchedRID: oOTqEOEfBbsbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2iWQSYYFGzuMEi2pD9yuITqTiN/on4eNSVhRyidsElYkoR62RNvkvOuH4I6QZJ07kT2Nz
	jXT2owxoa8IWqgpLBOAMuqetGVetnyef22ep6XYOwBXM346/+wtnuv6GB+jLjrKNar+xKpZLsWI
	PiJpK7WTMNV/VIEXY/xEIIte65Qd
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

CC: Brian King <brking@us.ibm.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/ipr.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 3819f7c42788..ad3003a67109 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3412,10 +3412,10 @@ static ssize_t ipr_show_fw_version(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-	len = snprintf(buf, PAGE_SIZE, "%02X%02X%02X%02X\n",
-		       ucode_vpd->major_release, ucode_vpd->card_type,
-		       ucode_vpd->minor_release[0],
-		       ucode_vpd->minor_release[1]);
+	len = sysfs_emit(buf, "%02X%02X%02X%02X\n",
+			 ucode_vpd->major_release, ucode_vpd->card_type,
+			 ucode_vpd->minor_release[0],
+			 ucode_vpd->minor_release[1]);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
 }
@@ -3446,7 +3446,7 @@ static ssize_t ipr_show_log_level(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", ioa_cfg->log_level);
+	len = sysfs_emit(buf, "%d\n", ioa_cfg->log_level);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
 }
@@ -3565,9 +3565,9 @@ static ssize_t ipr_show_adapter_state(struct device *dev,
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	if (ioa_cfg->hrrq[IPR_INIT_HRRQ].ioa_is_dead)
-		len = snprintf(buf, PAGE_SIZE, "offline\n");
+		len = sysfs_emit(buf, "offline\n");
 	else
-		len = snprintf(buf, PAGE_SIZE, "online\n");
+		len = sysfs_emit(buf, "online\n");
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
 }
@@ -3684,7 +3684,7 @@ static ssize_t ipr_show_iopoll_weight(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, lock_flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", ioa_cfg->iopoll_weight);
+	len = sysfs_emit(buf, "%d\n", ioa_cfg->iopoll_weight);
 	spin_unlock_irqrestore(shost->host_lock, lock_flags);
 
 	return len;
@@ -4073,7 +4073,7 @@ static ssize_t ipr_show_fw_type(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", ioa_cfg->sis64);
+	len = sysfs_emit(buf, "%d\n", ioa_cfg->sis64);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
 }
@@ -4432,7 +4432,7 @@ static ssize_t ipr_show_adapter_handle(struct device *dev, struct device_attribu
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	res = (struct ipr_resource_entry *)sdev->hostdata;
 	if (res)
-		len = snprintf(buf, PAGE_SIZE, "%08X\n", res->res_handle);
+		len = sysfs_emit(buf, "%08X\n", res->res_handle);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
 }
@@ -4467,12 +4467,12 @@ static ssize_t ipr_show_resource_path(struct device *dev, struct device_attribut
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	res = (struct ipr_resource_entry *)sdev->hostdata;
 	if (res && ioa_cfg->sis64)
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
-			       __ipr_format_res_path(res->res_path, buffer,
-						     sizeof(buffer)));
+		len = sysfs_emit(buf, "%s\n",
+				 __ipr_format_res_path(res->res_path, buffer,
+						       sizeof(buffer)));
 	else if (res)
-		len = snprintf(buf, PAGE_SIZE, "%d:%d:%d:%d\n", ioa_cfg->host->host_no,
-			       res->bus, res->target, res->lun);
+		len = sysfs_emit(buf, "%d:%d:%d:%d\n", ioa_cfg->host->host_no,
+				 res->bus, res->target, res->lun);
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
@@ -4506,9 +4506,9 @@ static ssize_t ipr_show_device_id(struct device *dev, struct device_attribute *a
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	res = (struct ipr_resource_entry *)sdev->hostdata;
 	if (res && ioa_cfg->sis64)
-		len = snprintf(buf, PAGE_SIZE, "0x%llx\n", be64_to_cpu(res->dev_id));
+		len = sysfs_emit(buf, "0x%llx\n", be64_to_cpu(res->dev_id));
 	else if (res)
-		len = snprintf(buf, PAGE_SIZE, "0x%llx\n", res->lun_wwn);
+		len = sysfs_emit(buf, "0x%llx\n", res->lun_wwn);
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
@@ -4543,7 +4543,7 @@ static ssize_t ipr_show_resource_type(struct device *dev, struct device_attribut
 	res = (struct ipr_resource_entry *)sdev->hostdata;
 
 	if (res)
-		len = snprintf(buf, PAGE_SIZE, "%x\n", res->type);
+		len = sysfs_emit(buf, "%x\n", res->type);
 
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
 	return len;
@@ -4578,7 +4578,7 @@ static ssize_t ipr_show_raw_mode(struct device *dev,
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	res = (struct ipr_resource_entry *)sdev->hostdata;
 	if (res)
-		len = snprintf(buf, PAGE_SIZE, "%d\n", res->raw_mode);
+		len = sysfs_emit(buf, "%d\n", res->raw_mode);
 	else
 		len = -ENXIO;
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, lock_flags);
-- 
2.29.2


