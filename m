Return-Path: <linux-kernel+bounces-107102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D7787F789
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46717280F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0447FBDC;
	Tue, 19 Mar 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="D2KT4OE6"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49167E566;
	Tue, 19 Mar 2024 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829962; cv=none; b=NA7MZtU5SwkTSCPVQqgBAlxwMlEQx+hXpp4+QX4n+91pocRJjij3G67K39LaNd+pIUpQROEvkWmn/1ILt0KEe7IZS7BhbqUa4/6SM6Ltnwx103PLOXl8VMaDEKFFqA3HH4fjU3bSmcsKQSDR2Jris0LvPuojuryGlaHAHJJEb5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829962; c=relaxed/simple;
	bh=Tljs7sj6NLXRsbg++DwByxlwGXW9ocCAWeklXKVpQPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOzxxXbp/o8GskTq8f87C430olwNTXGMwBvwm7ixoZVzdAYM6kp9W+CmGdFEfnQGDVi2xOTS/aVdcrJ7UlkMVy3TzUoCo7aSoJvCjVlN6isx79BTvBMDphg+vpGstICWXs2PWqYkFmGmoYlSUidpb7bbeNuDIuApkX+R5lhjZ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=D2KT4OE6; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829959; x=1742365959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tljs7sj6NLXRsbg++DwByxlwGXW9ocCAWeklXKVpQPE=;
  b=D2KT4OE6QQRgFyexxzEZucVlTt/arUPpBUWZJK8Pa6G3wBh8fnCm/tqX
   EuoK2DthXlLho8scvMu17XVYMd1qKryOxgbquSOD2qTwKS/zgnx7fn+Zw
   9uZMFxCmtGvvjLm5tchBbZx7aPYFL0PWbpRGHbUUkkUA39m4yt8Lwrbia
   AnIDSOgsAusCLEDaUR7TYNc6k0q0zyD78nzbNZamSJV17UTpxXuJHByIP
   mMQAIgtG70L6Zk21IuITaxSFRhmzIs9wBA4/XueckP5WfOc7POft9C4jo
   99E35lDT1W7mKpJTwCIh9eoqX76AHR25QyLJW0qz+H9NNA/P4irWqUm6V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152971403"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152971403"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:31 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 37311F2646;
	Tue, 19 Mar 2024 15:32:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 490F314014;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id B15851EA349;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 405F21A006D;
	Tue, 19 Mar 2024 14:32:27 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 22/25] scsi: scsi_transport_fc: Convert sprintf() family to sysfs_emit() family (part 2)
Date: Tue, 19 Mar 2024 14:31:29 +0800
Message-Id: <20240319063132.1588443-22-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--8.175600-10.000000
X-TMASE-MatchedRID: oHBCG6HyOVEbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/2BKRtg9pHEawLkNMQzGl5B+Kr
	WCPbERPyqq0O5S3DJ8TPK2izpFIcpKTrL7C/IWdIXQ/hu1OV/0+LidURF+DB02IB8TTQDNxPVss
	+T7ABwcbF6gos3VEkPxhi6d+tzuTPFT0+xU+1/830kDaWZBE1RYL/tox9XQkVKFxY7/zfGiQVhQ
	ktC6mCrCqU5ZaMeHNGYyzo3OdtPuIQJt3nwJw/DHsEljqux9nan/3nyhTdZwpjlkbDvDJ4dNI/Y
	G2D7IkscEmVYex+Nkd4AIPQ5gPYCR9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7soss8
	v7FcAi2/GxwmCnQbmmxxOV/oQSfcmYwSKX7pcBsBTJSD2iAW0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This focuses on the abused in macros.

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/scsi_transport_fc.c | 152 +++++++++++++++----------------
 1 file changed, 74 insertions(+), 78 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 3335c31772e1..340cda452b44 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -114,7 +114,6 @@ static struct {
 	{ FC_PORTTYPE_NPIV,		"NPIV VPORT" },
 };
 fc_enum_name_search(port_type, fc_port_type, fc_port_type_names)
-#define FC_PORTTYPE_MAX_NAMELEN		50
 
 /* Reuse fc_port_type enum function for vport_type */
 #define get_fc_vport_type_name get_fc_port_type_name
@@ -166,7 +165,6 @@ static struct {
 };
 fc_enum_name_search(port_state, fc_port_state, fc_port_state_names)
 fc_enum_name_match(port_state, fc_port_state, fc_port_state_names)
-#define FC_PORTSTATE_MAX_NAMELEN	20
 
 
 /* Convert fc_vport_state values to ascii string name */
@@ -186,7 +184,6 @@ static struct {
 	{ FC_VPORT_FAILED,		"VPort Failed" },
 };
 fc_enum_name_search(vport_state, fc_vport_state, fc_vport_state_names)
-#define FC_VPORTSTATE_MAX_NAMELEN	24
 
 /* Reuse fc_vport_state enum function for vport_last_state */
 #define get_fc_vport_last_state_name get_fc_vport_state_name
@@ -983,7 +980,7 @@ static void __exit fc_transport_exit(void)
  * FC Remote Port Attribute Management
  */
 
-#define fc_rport_show_function(field, format_string, sz, cast)		\
+#define fc_rport_show_function(field, format_string, cast)		\
 static ssize_t								\
 show_fc_rport_##field (struct device *dev, 				\
 		       struct device_attribute *attr, char *buf)	\
@@ -996,7 +993,7 @@ show_fc_rport_##field (struct device *dev, 				\
 	      (rport->port_state == FC_PORTSTATE_DELETED) ||		\
 	      (rport->port_state == FC_PORTSTATE_NOTPRESENT)))		\
 		i->f->get_rport_##field(rport);				\
-	return snprintf(buf, sz, format_string, cast rport->field); 	\
+	return sysfs_emit(buf, format_string, cast rport->field); 	\
 }
 
 #define fc_rport_store_function(field)					\
@@ -1021,45 +1018,45 @@ store_fc_rport_##field(struct device *dev,				\
 	return count;							\
 }
 
-#define fc_rport_rd_attr(field, format_string, sz)			\
-	fc_rport_show_function(field, format_string, sz, )		\
+#define fc_rport_rd_attr(field, format_string)			\
+	fc_rport_show_function(field, format_string, )		\
 static FC_DEVICE_ATTR(rport, field, S_IRUGO,			\
 			 show_fc_rport_##field, NULL)
 
-#define fc_rport_rd_attr_cast(field, format_string, sz, cast)		\
-	fc_rport_show_function(field, format_string, sz, (cast))	\
+#define fc_rport_rd_attr_cast(field, format_string, cast)		\
+	fc_rport_show_function(field, format_string, (cast))	\
 static FC_DEVICE_ATTR(rport, field, S_IRUGO,			\
 			  show_fc_rport_##field, NULL)
 
-#define fc_rport_rw_attr(field, format_string, sz)			\
-	fc_rport_show_function(field, format_string, sz, )		\
+#define fc_rport_rw_attr(field, format_string)			\
+	fc_rport_show_function(field, format_string, )		\
 	fc_rport_store_function(field)					\
 static FC_DEVICE_ATTR(rport, field, S_IRUGO | S_IWUSR,		\
 			show_fc_rport_##field,				\
 			store_fc_rport_##field)
 
 
-#define fc_private_rport_show_function(field, format_string, sz, cast)	\
+#define fc_private_rport_show_function(field, format_string, cast)	\
 static ssize_t								\
 show_fc_rport_##field (struct device *dev, 				\
 		       struct device_attribute *attr, char *buf)	\
 {									\
 	struct fc_rport *rport = transport_class_to_rport(dev);		\
-	return snprintf(buf, sz, format_string, cast rport->field); 	\
+	return sysfs_emit(buf, format_string, cast rport->field); 	\
 }
 
-#define fc_private_rport_rd_attr(field, format_string, sz)		\
-	fc_private_rport_show_function(field, format_string, sz, )	\
+#define fc_private_rport_rd_attr(field, format_string)		\
+	fc_private_rport_show_function(field, format_string, )	\
 static FC_DEVICE_ATTR(rport, field, S_IRUGO,			\
 			 show_fc_rport_##field, NULL)
 
-#define fc_private_rport_rd_attr_cast(field, format_string, sz, cast)	\
-	fc_private_rport_show_function(field, format_string, sz, (cast)) \
+#define fc_private_rport_rd_attr_cast(field, format_string, cast)	\
+	fc_private_rport_show_function(field, format_string, (cast)) \
 static FC_DEVICE_ATTR(rport, field, S_IRUGO,			\
 			  show_fc_rport_##field, NULL)
 
 
-#define fc_private_rport_rd_enum_attr(title, maxlen)			\
+#define fc_private_rport_rd_enum_attr(title)			\
 static ssize_t								\
 show_fc_rport_##title (struct device *dev,				\
 		       struct device_attribute *attr, char *buf)	\
@@ -1069,7 +1066,7 @@ show_fc_rport_##title (struct device *dev,				\
 	name = get_fc_##title##_name(rport->title);			\
 	if (!name)							\
 		return -EINVAL;						\
-	return snprintf(buf, maxlen, "%s\n", name);			\
+	return sysfs_emit(buf, "%s\n", name);			\
 }									\
 static FC_DEVICE_ATTR(rport, title, S_IRUGO,			\
 			show_fc_rport_##title, NULL)
@@ -1112,7 +1109,7 @@ static FC_DEVICE_ATTR(rport, title, S_IRUGO,			\
 
 /* Fixed Remote Port Attributes */
 
-fc_private_rport_rd_attr(maxframe_size, "%u bytes\n", 20);
+fc_private_rport_rd_attr(maxframe_size, "%u bytes\n");
 
 static ssize_t
 show_fc_rport_supported_classes (struct device *dev,
@@ -1175,7 +1172,7 @@ static int fc_rport_set_dev_loss_tmo(struct fc_rport *rport,
 	return 0;
 }
 
-fc_rport_show_function(dev_loss_tmo, "%u\n", 20, )
+fc_rport_show_function(dev_loss_tmo, "%u\n", )
 static ssize_t
 store_fc_rport_dev_loss_tmo(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
@@ -1199,9 +1196,9 @@ static FC_DEVICE_ATTR(rport, dev_loss_tmo, S_IRUGO | S_IWUSR,
 
 /* Private Remote Port Attributes */
 
-fc_private_rport_rd_attr_cast(node_name, "0x%llx\n", 20, unsigned long long);
-fc_private_rport_rd_attr_cast(port_name, "0x%llx\n", 20, unsigned long long);
-fc_private_rport_rd_attr(port_id, "0x%06x\n", 20);
+fc_private_rport_rd_attr_cast(node_name, "0x%llx\n", unsigned long long);
+fc_private_rport_rd_attr_cast(port_name, "0x%llx\n", unsigned long long);
+fc_private_rport_rd_attr(port_id, "0x%06x\n");
 
 static ssize_t
 show_fc_rport_roles (struct device *dev, struct device_attribute *attr,
@@ -1289,7 +1286,7 @@ show_fc_rport_port_state(struct device *dev,
 static FC_DEVICE_ATTR(rport, port_state, 0444 | 0200,
 			show_fc_rport_port_state, fc_rport_set_marginal_state);
 
-fc_private_rport_rd_attr(scsi_target_id, "%d\n", 20);
+fc_private_rport_rd_attr(scsi_target_id, "%d\n");
 
 /*
  * fast_io_fail_tmo attribute
@@ -1346,7 +1343,7 @@ static ssize_t fc_rport_fpinstat_##name(struct device *cd,		\
 {									\
 	struct fc_rport *rport = transport_class_to_rport(cd);		\
 									\
-	return snprintf(buf, 20, "0x%llx\n", rport->fpin_stats.name);	\
+	return sysfs_emit(buf, "0x%llx\n", rport->fpin_stats.name);	\
 }									\
 static FC_DEVICE_ATTR(rport, fpin_##name, 0444, fc_rport_fpinstat_##name, NULL)
 
@@ -1411,7 +1408,7 @@ static struct attribute_group fc_rport_statistics_group = {
  *  involved in sysfs functions. The driver only gets involved if
  *  it's the "old" style that doesn't use rports.
  */
-#define fc_starget_show_function(field, format_string, sz, cast)	\
+#define fc_starget_show_function(field, format_string, cast)	\
 static ssize_t								\
 show_fc_starget_##field (struct device *dev, 				\
 			 struct device_attribute *attr, char *buf)	\
@@ -1424,17 +1421,17 @@ show_fc_starget_##field (struct device *dev, 				\
 		fc_starget_##field(starget) = rport->field;		\
 	else if (i->f->get_starget_##field)				\
 		i->f->get_starget_##field(starget);			\
-	return snprintf(buf, sz, format_string, 			\
+	return sysfs_emit(buf, format_string, 				\
 		cast fc_starget_##field(starget)); 			\
 }
 
-#define fc_starget_rd_attr(field, format_string, sz)			\
-	fc_starget_show_function(field, format_string, sz, )		\
+#define fc_starget_rd_attr(field, format_string)			\
+	fc_starget_show_function(field, format_string, )		\
 static FC_DEVICE_ATTR(starget, field, S_IRUGO,			\
 			 show_fc_starget_##field, NULL)
 
-#define fc_starget_rd_attr_cast(field, format_string, sz, cast)		\
-	fc_starget_show_function(field, format_string, sz, (cast))	\
+#define fc_starget_rd_attr_cast(field, format_string, cast)		\
+	fc_starget_show_function(field, format_string, (cast))	\
 static FC_DEVICE_ATTR(starget, field, S_IRUGO,			\
 			  show_fc_starget_##field, NULL)
 
@@ -1457,9 +1454,9 @@ static FC_DEVICE_ATTR(starget, field, S_IRUGO,			\
 		count++
 
 /* The FC Transport SCSI Target Attributes: */
-fc_starget_rd_attr_cast(node_name, "0x%llx\n", 20, unsigned long long);
-fc_starget_rd_attr_cast(port_name, "0x%llx\n", 20, unsigned long long);
-fc_starget_rd_attr(port_id, "0x%06x\n", 20);
+fc_starget_rd_attr_cast(node_name, "0x%llx\n", unsigned long long);
+fc_starget_rd_attr_cast(port_name, "0x%llx\n", unsigned long long);
+fc_starget_rd_attr(port_id, "0x%06x\n");
 
 
 /*
@@ -1477,7 +1474,7 @@ show_fc_vport_##field (struct device *dev, 				\
 	if ((i->f->get_vport_##field) &&				\
 	    !(vport->flags & (FC_VPORT_DEL | FC_VPORT_CREATING)))	\
 		i->f->get_vport_##field(vport);				\
-	return snprintf(buf, sz, format_string, cast vport->field); 	\
+	return sysfs_emit(buf, format_string, cast vport->field); 	\
 }
 
 #define fc_vport_store_function(field)					\
@@ -1544,7 +1541,7 @@ show_fc_vport_##field (struct device *dev,				\
 		       struct device_attribute *attr, char *buf)	\
 {									\
 	struct fc_vport *vport = transport_class_to_vport(dev);		\
-	return snprintf(buf, sz, format_string, cast vport->field); 	\
+	return sysfs_emit(buf, format_string, cast vport->field); 	\
 }
 
 #define fc_private_vport_store_u32_function(field)			\
@@ -1584,7 +1581,7 @@ static FC_DEVICE_ATTR(vport, field, S_IRUGO | S_IWUSR,		\
 			store_fc_vport_##field)
 
 
-#define fc_private_vport_rd_enum_attr(title, maxlen)			\
+#define fc_private_vport_rd_enum_attr(title)			\
 static ssize_t								\
 show_fc_vport_##title (struct device *dev,				\
 		       struct device_attribute *attr,			\
@@ -1595,7 +1592,7 @@ show_fc_vport_##title (struct device *dev,				\
 	name = get_fc_##title##_name(vport->title);			\
 	if (!name)							\
 		return -EINVAL;						\
-	return snprintf(buf, maxlen, "%s\n", name);			\
+	return sysfs_emit(buf, "%s\n", name);			\
 }									\
 static FC_DEVICE_ATTR(vport, title, S_IRUGO,			\
 			show_fc_vport_##title, NULL)
@@ -1650,8 +1647,8 @@ static FC_DEVICE_ATTR(vport, title, S_IRUGO,			\
 
 /* Private Virtual Port Attributes */
 
-fc_private_vport_rd_enum_attr(vport_state, FC_VPORTSTATE_MAX_NAMELEN);
-fc_private_vport_rd_enum_attr(vport_last_state, FC_VPORTSTATE_MAX_NAMELEN);
+fc_private_vport_rd_enum_attr(vport_state);
+fc_private_vport_rd_enum_attr(vport_last_state);
 fc_private_vport_rd_attr_cast(node_name, "0x%llx\n", 20, unsigned long long);
 fc_private_vport_rd_attr_cast(port_name, "0x%llx\n", 20, unsigned long long);
 
@@ -1667,7 +1664,7 @@ show_fc_vport_roles (struct device *dev, struct device_attribute *attr,
 }
 static FC_DEVICE_ATTR(vport, roles, S_IRUGO, show_fc_vport_roles, NULL);
 
-fc_private_vport_rd_enum_attr(vport_type, FC_PORTTYPE_MAX_NAMELEN);
+fc_private_vport_rd_enum_attr(vport_type);
 
 fc_private_vport_show_function(symbolic_name, "%s\n",
 		FC_VPORT_SYMBOLIC_NAMELEN + 1, )
@@ -1735,7 +1732,7 @@ static FC_DEVICE_ATTR(vport, vport_disable, S_IWUSR,
  * Host Attribute Management
  */
 
-#define fc_host_show_function(field, format_string, sz, cast)		\
+#define fc_host_show_function(field, format_string, cast)		\
 static ssize_t								\
 show_fc_host_##field (struct device *dev,				\
 		      struct device_attribute *attr, char *buf)		\
@@ -1744,7 +1741,7 @@ show_fc_host_##field (struct device *dev,				\
 	struct fc_internal *i = to_fc_internal(shost->transportt);	\
 	if (i->f->get_host_##field)					\
 		i->f->get_host_##field(shost);				\
-	return snprintf(buf, sz, format_string, cast fc_host_##field(shost)); \
+	return sysfs_emit(buf, format_string, cast fc_host_##field(shost)); \
 }
 
 #define fc_host_store_function(field)					\
@@ -1785,13 +1782,13 @@ store_fc_host_##field(struct device *dev,				\
 	return count;							\
 }
 
-#define fc_host_rd_attr(field, format_string, sz)			\
-	fc_host_show_function(field, format_string, sz, )		\
+#define fc_host_rd_attr(field, format_string)			\
+	fc_host_show_function(field, format_string, )		\
 static FC_DEVICE_ATTR(host, field, S_IRUGO,			\
 			 show_fc_host_##field, NULL)
 
-#define fc_host_rd_attr_cast(field, format_string, sz, cast)		\
-	fc_host_show_function(field, format_string, sz, (cast))		\
+#define fc_host_rd_attr_cast(field, format_string, cast)		\
+	fc_host_show_function(field, format_string, (cast))		\
 static FC_DEVICE_ATTR(host, field, S_IRUGO,			\
 			  show_fc_host_##field, NULL)
 
@@ -1802,7 +1799,7 @@ static FC_DEVICE_ATTR(host, field, S_IRUGO | S_IWUSR,		\
 			show_fc_host_##field,				\
 			store_fc_host_##field)
 
-#define fc_host_rd_enum_attr(title, maxlen)				\
+#define fc_host_rd_enum_attr(title)				\
 static ssize_t								\
 show_fc_host_##title (struct device *dev,				\
 		      struct device_attribute *attr, char *buf)		\
@@ -1815,7 +1812,7 @@ show_fc_host_##title (struct device *dev,				\
 	name = get_fc_##title##_name(fc_host_##title(shost));		\
 	if (!name)							\
 		return -EINVAL;						\
-	return snprintf(buf, maxlen, "%s\n", name);			\
+	return sysfs_emit(buf, "%s\n", name);			\
 }									\
 static FC_DEVICE_ATTR(host, title, S_IRUGO, show_fc_host_##title, NULL)
 
@@ -1845,22 +1842,22 @@ static FC_DEVICE_ATTR(host, title, S_IRUGO, show_fc_host_##title, NULL)
 		count++
 
 
-#define fc_private_host_show_function(field, format_string, sz, cast)	\
+#define fc_private_host_show_function(field, format_string, cast)	\
 static ssize_t								\
 show_fc_host_##field (struct device *dev,				\
 		      struct device_attribute *attr, char *buf)		\
 {									\
 	struct Scsi_Host *shost = transport_class_to_shost(dev);	\
-	return snprintf(buf, sz, format_string, cast fc_host_##field(shost)); \
+	return sysfs_emit(buf, format_string, cast fc_host_##field(shost)); \
 }
 
-#define fc_private_host_rd_attr(field, format_string, sz)		\
-	fc_private_host_show_function(field, format_string, sz, )	\
+#define fc_private_host_rd_attr(field, format_string)		\
+	fc_private_host_show_function(field, format_string, )	\
 static FC_DEVICE_ATTR(host, field, S_IRUGO,			\
 			 show_fc_host_##field, NULL)
 
-#define fc_private_host_rd_attr_cast(field, format_string, sz, cast)	\
-	fc_private_host_show_function(field, format_string, sz, (cast)) \
+#define fc_private_host_rd_attr_cast(field, format_string, cast)	\
+	fc_private_host_show_function(field, format_string, (cast)) \
 static FC_DEVICE_ATTR(host, field, S_IRUGO,			\
 			  show_fc_host_##field, NULL)
 
@@ -1920,20 +1917,20 @@ static FC_DEVICE_ATTR(host, supported_speeds, S_IRUGO,
 		show_fc_host_supported_speeds, NULL);
 
 
-fc_private_host_rd_attr_cast(node_name, "0x%llx\n", 20, unsigned long long);
-fc_private_host_rd_attr_cast(port_name, "0x%llx\n", 20, unsigned long long);
-fc_private_host_rd_attr_cast(permanent_port_name, "0x%llx\n", 20,
+fc_private_host_rd_attr_cast(node_name, "0x%llx\n", unsigned long long);
+fc_private_host_rd_attr_cast(port_name, "0x%llx\n", unsigned long long);
+fc_private_host_rd_attr_cast(permanent_port_name, "0x%llx\n",
 			     unsigned long long);
-fc_private_host_rd_attr(maxframe_size, "%u bytes\n", 20);
-fc_private_host_rd_attr(max_npiv_vports, "%u\n", 20);
-fc_private_host_rd_attr(serial_number, "%s\n", (FC_SERIAL_NUMBER_SIZE +1));
-fc_private_host_rd_attr(manufacturer, "%s\n", FC_SERIAL_NUMBER_SIZE + 1);
-fc_private_host_rd_attr(model, "%s\n", FC_SYMBOLIC_NAME_SIZE + 1);
-fc_private_host_rd_attr(model_description, "%s\n", FC_SYMBOLIC_NAME_SIZE + 1);
-fc_private_host_rd_attr(hardware_version, "%s\n", FC_VERSION_STRING_SIZE + 1);
-fc_private_host_rd_attr(driver_version, "%s\n", FC_VERSION_STRING_SIZE + 1);
-fc_private_host_rd_attr(firmware_version, "%s\n", FC_VERSION_STRING_SIZE + 1);
-fc_private_host_rd_attr(optionrom_version, "%s\n", FC_VERSION_STRING_SIZE + 1);
+fc_private_host_rd_attr(maxframe_size, "%u bytes\n");
+fc_private_host_rd_attr(max_npiv_vports, "%u\n");
+fc_private_host_rd_attr(serial_number, "%s\n");
+fc_private_host_rd_attr(manufacturer, "%s\n");
+fc_private_host_rd_attr(model, "%s\n");
+fc_private_host_rd_attr(model_description, "%s\n");
+fc_private_host_rd_attr(hardware_version, "%s\n");
+fc_private_host_rd_attr(driver_version, "%s\n");
+fc_private_host_rd_attr(firmware_version, "%s\n");
+fc_private_host_rd_attr(optionrom_version, "%s\n");
 
 
 /* Dynamic Host Attributes */
@@ -1972,14 +1969,13 @@ static FC_DEVICE_ATTR(host, speed, S_IRUGO,
 		show_fc_host_speed, NULL);
 
 
-fc_host_rd_attr(port_id, "0x%06x\n", 20);
-fc_host_rd_enum_attr(port_type, FC_PORTTYPE_MAX_NAMELEN);
-fc_host_rd_enum_attr(port_state, FC_PORTSTATE_MAX_NAMELEN);
-fc_host_rd_attr_cast(fabric_name, "0x%llx\n", 20, unsigned long long);
-fc_host_rd_attr(symbolic_name, "%s\n", FC_SYMBOLIC_NAME_SIZE + 1);
+fc_host_rd_attr(port_id, "0x%06x\n");
+fc_host_rd_enum_attr(port_type);
+fc_host_rd_enum_attr(port_state);
+fc_host_rd_attr_cast(fabric_name, "0x%llx\n", unsigned long long);
+fc_host_rd_attr(symbolic_name, "%s\n");
 
-fc_private_host_show_function(system_hostname, "%s\n",
-		FC_SYMBOLIC_NAME_SIZE + 1, )
+fc_private_host_show_function(system_hostname, "%s\n", )
 fc_host_store_str_function(system_hostname, FC_SYMBOLIC_NAME_SIZE)
 static FC_DEVICE_ATTR(host, system_hostname, S_IRUGO | S_IWUSR,
 		show_fc_host_system_hostname, store_fc_host_system_hostname);
@@ -2079,12 +2075,12 @@ store_fc_private_host_dev_loss_tmo(struct device *dev,
 	return count;
 }
 
-fc_private_host_show_function(dev_loss_tmo, "%d\n", 20, );
+fc_private_host_show_function(dev_loss_tmo, "%d\n", );
 static FC_DEVICE_ATTR(host, dev_loss_tmo, S_IRUGO | S_IWUSR,
 		      show_fc_host_dev_loss_tmo,
 		      store_fc_private_host_dev_loss_tmo);
 
-fc_private_host_rd_attr(npiv_vports_inuse, "%u\n", 20);
+fc_private_host_rd_attr(npiv_vports_inuse, "%u\n");
 
 /*
  * Host Statistics Management
-- 
2.29.2


