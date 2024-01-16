Return-Path: <linux-kernel+bounces-26994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2A82E8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A41284D40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FAC1E892;
	Tue, 16 Jan 2024 04:52:46 +0000 (UTC)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598111DFDD;
	Tue, 16 Jan 2024 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146236508"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146236508"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:25 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DE32CE7598;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 159A7BF3E1;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AF2C7200A571F;
	Tue, 16 Jan 2024 13:52:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0CC131A0070;
	Tue, 16 Jan 2024 12:52:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/42] drivers/scsi/ibmvscsi: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:34 +0800
Message-Id: <20240116045151.3940401-23-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--16.426000-10.000000
X-TMASE-MatchedRID: Jy5kObkVr+g4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxLdBFrfY9r2lSuvtBzlaEqL42hLbi424DvwU
	evDt+uW5/XjpbSJS7a0NziVKCujClh44pFEtxshLfSQNpZkETVAv/9UzFeXITS4KPPiCB23AokC
	/iIVpcslHmENCJyDB7gDLqnrRlXrZ8nn9tnqel2JBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/ibmvscsi/ibmvfc.c:3483:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3493:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3503:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3513:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3522:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi/ibmvfc.c:3530:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Tyrel Datwyler <tyreld@linux.ibm.com>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Nicholas Piggin <npiggin@gmail.com>
CC: Christophe Leroy <christophe.leroy@csgroup.eu>
CC: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
CC: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 92c440f2e3a7..4be013976866 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3480,8 +3480,7 @@ static ssize_t ibmvfc_show_host_partition_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.partition_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.partition_name);
 }
 
 static ssize_t ibmvfc_show_host_device_name(struct device *dev,
@@ -3490,8 +3489,7 @@ static ssize_t ibmvfc_show_host_device_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.device_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.device_name);
 }
 
 static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
@@ -3500,8 +3498,7 @@ static ssize_t ibmvfc_show_host_loc_code(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.port_loc_code);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.port_loc_code);
 }
 
 static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
@@ -3510,8 +3507,7 @@ static ssize_t ibmvfc_show_host_drc_name(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			vhost->login_buf->resp.drc_name);
+	return sysfs_emit(buf, "%s\n", vhost->login_buf->resp.drc_name);
 }
 
 static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
@@ -3519,7 +3515,8 @@ static ssize_t ibmvfc_show_host_npiv_version(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%d\n", be32_to_cpu(vhost->login_buf->resp.version));
+	return sysfs_emit(buf, "%d\n",
+			  be32_to_cpu(vhost->login_buf->resp.version));
 }
 
 static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
@@ -3527,7 +3524,8 @@ static ssize_t ibmvfc_show_host_capabilities(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvfc_host *vhost = shost_priv(shost);
-	return snprintf(buf, PAGE_SIZE, "%llx\n", be64_to_cpu(vhost->login_buf->resp.capabilities));
+	return sysfs_emit(buf, "%llx\n",
+			  be64_to_cpu(vhost->login_buf->resp.capabilities));
 }
 
 /**
@@ -3548,7 +3546,7 @@ static ssize_t ibmvfc_show_log_level(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", vhost->log_level);
+	len = sysfs_emit(buf, "%d\n", vhost->log_level);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
@@ -3587,7 +3585,7 @@ static ssize_t ibmvfc_show_scsi_channels(struct device *dev,
 	int len;
 
 	spin_lock_irqsave(shost->host_lock, flags);
-	len = snprintf(buf, PAGE_SIZE, "%d\n", scsi->desired_queues);
+	len = sysfs_emit(buf, "%d\n", scsi->desired_queues);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	return len;
 }
-- 
2.29.2


