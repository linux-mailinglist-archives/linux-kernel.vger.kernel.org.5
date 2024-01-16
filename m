Return-Path: <linux-kernel+bounces-26993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5B382E8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8D31F23A06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D141DFE6;
	Tue, 16 Jan 2024 04:52:43 +0000 (UTC)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89E1D528;
	Tue, 16 Jan 2024 04:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146236503"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146236503"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:23 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 05A73D9D92;
	Tue, 16 Jan 2024 13:52:21 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3088AD8AD7;
	Tue, 16 Jan 2024 13:52:20 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id C2E0A6B4C7;
	Tue, 16 Jan 2024 13:52:19 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5408C1A0070;
	Tue, 16 Jan 2024 12:52:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 20/42] drivers/scsi/be2iscsi: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:29 +0800
Message-Id: <20240116045151.3940401-18-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--10.024000-10.000000
X-TMASE-MatchedRID: /HyfiRbsgEU4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtpqw4mhfH/CjxItqQ/criE6dYlaOEy4HBxkGI+vgRTxMPlSepWcgdLPx8BJ7uScK23tk+
	BYDo8lj+LzNWBegCW2wgn7iDBesS0gBwKKRHe+r1wp4zMzUhxAOXrm7p4CV73rYz1qlpCwNGo/2
	6nVPTwlraIJ3ojsIQ8=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/be2iscsi/be_mgmt.c:1145:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/be2iscsi/be_mgmt.c:1164:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/be2iscsi/be_mgmt.c:1251:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/be2iscsi/be_mgmt.c:1280:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Ketan Mukadam <ketan.mukadam@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/be2iscsi/be_mgmt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 4e899ec1477d..35e12e13d580 100644
--- a/drivers/scsi/be2iscsi/be_mgmt.c
+++ b/drivers/scsi/be2iscsi/be_mgmt.c
@@ -1142,7 +1142,7 @@ ssize_t
 beiscsi_drvr_ver_disp(struct device *dev, struct device_attribute *attr,
 		       char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, BE_NAME "\n");
+	return sysfs_emit(buf, BE_NAME "\n");
 }
 
 /**
@@ -1161,7 +1161,7 @@ beiscsi_fw_ver_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", phba->fw_ver_str);
+	return sysfs_emit(buf, "%s\n", phba->fw_ver_str);
 }
 
 /**
@@ -1248,16 +1248,16 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
 	case BE_DEVICE_ID1:
 	case OC_DEVICE_ID1:
 	case OC_DEVICE_ID2:
-		return snprintf(buf, PAGE_SIZE,
-				"Obsolete/Unsupported BE2 Adapter Family\n");
+		return sysfs_emit(buf,
+				  "Obsolete/Unsupported BE2 Adapter Family\n");
 	case BE_DEVICE_ID2:
 	case OC_DEVICE_ID3:
-		return snprintf(buf, PAGE_SIZE, "BE3-R Adapter Family\n");
+		return sysfs_emit(buf, "BE3-R Adapter Family\n");
 	case OC_SKH_ID1:
-		return snprintf(buf, PAGE_SIZE, "Skyhawk-R Adapter Family\n");
+		return sysfs_emit(buf, "Skyhawk-R Adapter Family\n");
 	default:
-		return snprintf(buf, PAGE_SIZE,
-				"Unknown Adapter Family: 0x%x\n", dev_id);
+		return sysfs_emit(buf,
+				  "Unknown Adapter Family: 0x%x\n", dev_id);
 	}
 }
 
@@ -1277,8 +1277,8 @@ beiscsi_phys_port_disp(struct device *dev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct beiscsi_hba *phba = iscsi_host_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "Port Identifier : %u\n",
-			phba->fw_config.phys_port);
+	return sysfs_emit(buf, "Port Identifier : %u\n",
+			  phba->fw_config.phys_port);
 }
 
 void beiscsi_offload_cxn_v0(struct beiscsi_offload_params *params,
-- 
2.29.2


