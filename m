Return-Path: <linux-kernel+bounces-107104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBF87F78B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D23281A48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B6F8005F;
	Tue, 19 Mar 2024 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="SgcPn8am"
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4877F498;
	Tue, 19 Mar 2024 06:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829967; cv=none; b=svtCMgbQC5KmQMdCkrUBVgtxbeGFZbcjCjXD066X0u4JD0BcWflNCzKL4UcWMd6xWQJgkElpLGEZRIfbXKPYXrkvaGk8oEou01IsnznJWY8ajqw/ENyeyP+WZuHlYzwIxWQ3eeOLyTiw+UcOWkj+nCnnoov20gZ1yn9ZclqXPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829967; c=relaxed/simple;
	bh=XKaJQGnrPDnTTf8+bpmOJUwGHXq0K1nBOh01/qp66RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=crjFU2pBUxsyVsCxJBc3krNG9rECNpNgft5GQIIDrdmAiT7XkGUuDtbBZKqf3uEWW5Byg38mdyD43zXQF0J1pQbpnq1WXRDIckngt3uvjvkEQPhVMATGYR00hMc36RyLA7DsljSxgdg6FC+tq4zGw+ZG4i8vjPFD1F8B2T91xVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=SgcPn8am; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829961; x=1742365961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKaJQGnrPDnTTf8+bpmOJUwGHXq0K1nBOh01/qp66RQ=;
  b=SgcPn8amx1KkNIri0CZVd5phxFVD84iIdtQKhdEK16Y89wd1YUocbrR1
   bx4CEIUVzC5FjZm4ildTcixN+HxV6wC+gUd1NpMHYCx6CuoZBBqeD0oap
   Tmds7XnS3QAnsaWDe2IlcF6WNjnDu1Uq7BoIBgRbLCn3aNmNSDQfPr9oT
   hSLBUe+pEdrckaTqiy0P8Yi5LCKFnhf2oRtr2NWYRLVNOiix0ZnHpFYzv
   pxHX332t5zfdRsuDgtQErQWgPn9oLbfZuNFjIl18MjeaKpdbkFZDHvJUh
   53ZkLqCBmjoGMYLuCDGIrYdMLp7aTQqeYjrw15PAPtQktcgfCx3U1bCq/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="141157060"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="141157060"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:31 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 53355C6814;
	Tue, 19 Mar 2024 15:32:30 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F220D5A27;
	Tue, 19 Mar 2024 15:32:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0A80A228818;
	Tue, 19 Mar 2024 15:32:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1D0D51A006F;
	Tue, 19 Mar 2024 14:32:28 +0800 (CST)
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
Subject: [PATCH v2 25/25] scsi: ibmvscsi: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:32 +0800
Message-Id: <20240319063132.1588443-25-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--8.425400-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3IbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/0swHSFcVJ6GluHEj++VqU18a
	7/fBfKbtruPzTKuxCyQhBeNJICtc+zK2lwdvrNt2qH6mIBejVf2ItZ2e1geixEd+K6O5Nt52/BR
	68O365bn9eOltIlLtrSwG3KDMI8e8exiL4/gRNNd9JA2lmQRNU0MQw+++ihy8BBwEKSykzoBhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vJH1ETRymjvVTmpy1fm7ylE0j3AxyBQR0Gu7j
	sbmvaqF8NRIiaC/nhQ==
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
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 38 +++++++++-----------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 71f3e9563520..d6f205d30dcd 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1904,11 +1904,8 @@ static ssize_t show_host_vhost_loc(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, sizeof(hostdata->caps.loc), "%s\n",
-		       hostdata->caps.loc);
-	return len;
+	return sysfs_emit(buf, "%s\n", hostdata->caps.loc);
 }
 
 static struct device_attribute ibmvscsi_host_vhost_loc = {
@@ -1924,11 +1921,8 @@ static ssize_t show_host_vhost_name(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, sizeof(hostdata->caps.name), "%s\n",
-		       hostdata->caps.name);
-	return len;
+	return sysfs_emit(buf, "%s\n", hostdata->caps.name);
 }
 
 static struct device_attribute ibmvscsi_host_vhost_name = {
@@ -1944,11 +1938,8 @@ static ssize_t show_host_srp_version(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%s\n",
-		       hostdata->madapter_info.srp_version);
-	return len;
+	return sysfs_emit(buf, "%s\n", hostdata->madapter_info.srp_version);
 }
 
 static struct device_attribute ibmvscsi_host_srp_version = {
@@ -1965,11 +1956,8 @@ static ssize_t show_host_partition_name(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%s\n",
-		       hostdata->madapter_info.partition_name);
-	return len;
+	return sysfs_emit(buf, "%s\n", hostdata->madapter_info.partition_name);
 }
 
 static struct device_attribute ibmvscsi_host_partition_name = {
@@ -1986,11 +1974,9 @@ static ssize_t show_host_partition_number(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%d\n",
-		       be32_to_cpu(hostdata->madapter_info.partition_number));
-	return len;
+	return sysfs_emit(buf, "%d\n",
+			 be32_to_cpu(hostdata->madapter_info.partition_number));
 }
 
 static struct device_attribute ibmvscsi_host_partition_number = {
@@ -2006,11 +1992,9 @@ static ssize_t show_host_mad_version(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%d\n",
-		       be32_to_cpu(hostdata->madapter_info.mad_version));
-	return len;
+	return sysfs_emit(buf, "%d\n",
+			 be32_to_cpu(hostdata->madapter_info.mad_version));
 }
 
 static struct device_attribute ibmvscsi_host_mad_version = {
@@ -2026,11 +2010,9 @@ static ssize_t show_host_os_type(struct device *dev,
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%d\n",
-		       be32_to_cpu(hostdata->madapter_info.os_type));
-	return len;
+	return sysfs_emit(buf, "%d\n",
+			 be32_to_cpu(hostdata->madapter_info.os_type));
 }
 
 static struct device_attribute ibmvscsi_host_os_type = {
-- 
2.29.2


