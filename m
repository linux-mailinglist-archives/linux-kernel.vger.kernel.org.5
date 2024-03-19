Return-Path: <linux-kernel+bounces-107082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980E87F75E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1686E1F2281C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9150261;
	Tue, 19 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="scOO9/Fb"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA62CAB;
	Tue, 19 Mar 2024 06:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829950; cv=none; b=ZzUvhRxEpB5hoADS8RoSEQtOSD8vnRJHxo5jtembuZe6xOolT7fsmzZUamHc3yCeblYOStzpsSIPhz+Q/blfO3R1pRhexf2pxzZa+HpSFR7ZXwyyDAVxdAfccs5/NC4V+7t9gwzyaSFbcCMLZQlUlFc5wc7F3iZRvtC3+2CsKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829950; c=relaxed/simple;
	bh=qEfLqdJeT2Gpt9qf+K4ddERyTTfpjjSSEO6EwWF7Fl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZHi4wskOOLCFIuOYNpA/TfJoDN6NcFhPQdlobRogSKc6PvDRUuijPVvM1Rf1UgUSS79T0hept73P/OaRdHNnDeJkFcYfhqPsjf3zhAxjxAcDk6sUcc0YU/wVpfExvLmoFcQtGSduQ0cr/IzOh4Y5amNJLFWXUS3DudnvAXmnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=scOO9/Fb; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829949; x=1742365949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qEfLqdJeT2Gpt9qf+K4ddERyTTfpjjSSEO6EwWF7Fl4=;
  b=scOO9/FbVC+jGdaJO0E9jtMCl5NvVobZw60pAxENZgdCjNvwsD6w9rez
   ygyVIxOYqSwtB3h9Y6xwwWenE4hEStDebwvdubvasC5BmcMC60qitrIjR
   r/m3JxjTW1oV5iVhC7yAObev5etPxCGgXoEK4XurBiMcrrAFu4R7aEydg
   3ovwvvir83GXmWXIHX7LvcdYi0z+6hH0FGPOTomRc6nIr121Sn80yxj3t
   yem7DPX5yYZTBQAXKe6J7Z3sspJaEzkVqpuo+H+5yFdzfhLGeI7+1iu/p
   yFl9rPkYSMOMhsliIVl/36FNKqsn1u6ZAepNEuh5X7H619lH+xPZ0lHQ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152728470"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152728470"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:25 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A6467C21AA;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id D457BBF4B8;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 6B970227ABA;
	Tue, 19 Mar 2024 15:32:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D73171A006B;
	Tue, 19 Mar 2024 14:32:20 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Ketan Mukadam <ketan.mukadam@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 04/25] scsi: be2iscsi: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:11 +0800
Message-Id: <20240319063132.1588443-4-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.790600-10.000000
X-TMASE-MatchedRID: IVNJzyZeXh4bO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072yMN2dG5I164tNVV5XI3AlKrxFQMz0ixcnGHnXg+7RhleGZa58oEXZMDDF
	OyfVeOuNEF4KUzfJuJtF7TiMxHpjVR40HmL/vatdo0n+JPFcJp9LQinZ4QefJOK2Na/r7MIF70J
	Bot7Y8+OhzOa6g8KrT3S35z9KvuQfgg1QRAVfi7hmLgtHa1C3yNbJDfyNQDOblWKG7Tq1kw=
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

CC: Ketan Mukadam <ketan.mukadam@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/be2iscsi/be_mgmt.c | 36 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/be2iscsi/be_mgmt.c b/drivers/scsi/be2iscsi/be_mgmt.c
index 4e899ec1477d..4174e71932a6 100644
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
@@ -1185,12 +1185,11 @@ beiscsi_active_session_disp(struct device *dev, struct device_attribute *attr,
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported)) {
 			avlbl_cids = BEISCSI_ULP_AVLBL_CID(phba, ulp_num);
 			total_cids = BEISCSI_GET_CID_COUNT(phba, ulp_num);
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num,
-					 (total_cids - avlbl_cids));
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num,
+					     (total_cids - avlbl_cids));
 		} else
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num, 0);
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num,
+					     0);
 	}
 
 	return len;
@@ -1215,12 +1214,11 @@ beiscsi_free_session_disp(struct device *dev, struct device_attribute *attr,
 
 	for (ulp_num = 0; ulp_num < BEISCSI_ULP_COUNT; ulp_num++) {
 		if (test_bit(ulp_num, (void *)&phba->fw_config.ulp_supported))
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num,
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num,
 					 BEISCSI_ULP_AVLBL_CID(phba, ulp_num));
 		else
-			len += scnprintf(buf+len, PAGE_SIZE - len,
-					 "ULP%d : %d\n", ulp_num, 0);
+			len += sysfs_emit_at(buf, len, "ULP%d : %d\n", ulp_num,
+					     0);
 	}
 
 	return len;
@@ -1248,16 +1246,16 @@ beiscsi_adap_family_disp(struct device *dev, struct device_attribute *attr,
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
+		return sysfs_emit(buf, "Unknown Adapter Family: 0x%x\n",
+				  dev_id);
 	}
 }
 
@@ -1277,8 +1275,8 @@ beiscsi_phys_port_disp(struct device *dev, struct device_attribute *attr,
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


