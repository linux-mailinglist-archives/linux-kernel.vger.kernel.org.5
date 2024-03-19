Return-Path: <linux-kernel+bounces-107103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9987F788
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF9F1C216C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CD7FBD7;
	Tue, 19 Mar 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="piw56tmA"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479487EEE0;
	Tue, 19 Mar 2024 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829963; cv=none; b=mSNEHQB8l985lGZ2Azb6sWNEPWnpYqoXxo1P+Csr7MzSYW+nQsgbPNduMFmzK2y2r47mVultZm+rrze3pwC4KqEA6X4HrHkHgMkRr3iCg0umM6y0Q2HTYAAuDF4YqBBZUCRMaDkXIKzMz4Ge8+UXex+QK58Q/r2ebUC+9lpqVj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829963; c=relaxed/simple;
	bh=XJCQdz/gchkeN5S6zp6jU0abnRa0KvI5l1susWJLLdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPRQJxQ89dFL85qKJwhDvwhlU0v1qNgd45Pr17sI3eMAJrgb3n1ia9pzYQ0EZzcpVJPEMPFws3pCP2hh77V5o8jP0rhMyfmdpdXRM/uy3RG3C8SfUegVXfop3CtNpwutimHhBvjMxlOpCxLVd+5Af2Trc8IlDqbjls2X0R4orq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=piw56tmA; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829960; x=1742365960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJCQdz/gchkeN5S6zp6jU0abnRa0KvI5l1susWJLLdk=;
  b=piw56tmAImpH5Cvy6wuv47ohjjPuSAtj2NylfpNsrBygTdTpBkAH2Zst
   8iJT8US1TI4XzF9X3puZZmE6fI8F6XPaqoMO06OuHWb3XM9bMan0IrR/z
   iz9J89Iemw7NB/SDjsfwZRVfglChS0aIkpSQe03K0UqGaKmQ/rH2CRddy
   BwCErBmM4f9cEaVgnNyXnnpiZvKWPnaizki0rUKY1jx7qGyuRYCghUjA7
   pk2/FOUcYeIeZKBTE3jnyg2H822i+grEONn4b2PsLTArqeK8H8Jxfxjng
   KxTMLGq63eVa4KWHcrEgfxrvlWSJGihdajRYzGQdS0dE/qaF3Znp5bFD7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152971406"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152971406"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:31 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 634C010A300;
	Tue, 19 Mar 2024 15:32:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 96DF4F933;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 244AF228822;
	Tue, 19 Mar 2024 15:32:28 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CE4801A006E;
	Tue, 19 Mar 2024 14:32:27 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 24/25] scsi: scsi_transport_sas: Convert sprintf() family to sysfs_emit() family (part 2)
Date: Tue, 19 Mar 2024 14:31:31 +0800
Message-Id: <20240319063132.1588443-24-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--9.708800-10.000000
X-TMASE-MatchedRID: LFhZ4D3QpawbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/2BKRtg9pHEawLkNMQzGl5B+Kr
	WCPbERPznpYPqS6jzxXnkq6nWMKnwUt79wf2J8qWgws6g0ewz2rzl8sNiWClKbKItl61J/yZ+in
	TK0bC9eKrauXd3MZDVXk9+tZ+3vTcfWJrWr2NKtynbcaY8t5OdsgdUCQd8VplZsmxh4osEt
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This focuses on the abused cases in macros.

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
 drivers/scsi/scsi_transport_sas.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index baf2aaf361d2..21d3b13c543a 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -427,7 +427,7 @@ show_sas_phy_##name(struct device *dev, 				\
 {									\
 	struct sas_phy *phy = transport_class_to_phy(dev);		\
 									\
-	return snprintf(buf, 20, format_string, cast phy->field);	\
+	return sysfs_emit(buf, format_string, cast phy->field);		\
 }
 
 #define sas_phy_simple_attr(field, name, format_string, type)		\
@@ -442,7 +442,7 @@ show_sas_phy_##name(struct device *dev, 				\
 	struct sas_phy *phy = transport_class_to_phy(dev);		\
 									\
 	if (!phy->field)						\
-		return snprintf(buf, 20, "none\n");			\
+		return sysfs_emit(buf, "none\n");			\
 	return get_sas_protocol_names(phy->field, buf);		\
 }
 
@@ -507,7 +507,7 @@ show_sas_phy_##field(struct device *dev, 				\
 	error = i->f->get_linkerrors ? i->f->get_linkerrors(phy) : 0;	\
 	if (error)							\
 		return error;						\
-	return snprintf(buf, 20, "%u\n", phy->field);			\
+	return sysfs_emit(buf, "%u\n", phy->field);			\
 }
 
 #define sas_phy_linkerror_attr(field)					\
@@ -798,7 +798,7 @@ show_sas_port_##name(struct device *dev, 				\
 {									\
 	struct sas_port *port = transport_class_to_sas_port(dev);	\
 									\
-	return snprintf(buf, 20, format_string, cast port->field);	\
+	return sysfs_emit(buf, format_string, cast port->field);	\
 }
 
 #define sas_port_simple_attr(field, name, format_string, type)		\
@@ -1145,7 +1145,7 @@ show_sas_rphy_##name(struct device *dev, 				\
 {									\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 									\
-	return snprintf(buf, 20, format_string, cast rphy->field);	\
+	return sysfs_emit(buf, format_string, cast rphy->field);	\
 }
 
 #define sas_rphy_simple_attr(field, name, format_string, type)		\
@@ -1161,7 +1161,7 @@ show_sas_rphy_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 									\
 	if (!rphy->field)					\
-		return snprintf(buf, 20, "none\n");			\
+		return sysfs_emit(buf, "none\n");			\
 	return get_sas_protocol_names(rphy->field, buf);	\
 }
 
@@ -1280,7 +1280,7 @@ show_sas_end_dev_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 	struct sas_end_device *rdev = rphy_to_end_device(rphy);		\
 									\
-	return snprintf(buf, 20, format_string, cast rdev->field);	\
+	return sysfs_emit(buf, format_string, cast rdev->field);	\
 }
 
 #define sas_end_dev_simple_attr(field, name, format_string, type)	\
@@ -1309,7 +1309,7 @@ show_sas_expander_##name(struct device *dev, 				\
 	struct sas_rphy *rphy = transport_class_to_rphy(dev);		\
 	struct sas_expander_device *edev = rphy_to_expander_device(rphy); \
 									\
-	return snprintf(buf, 20, format_string, cast edev->field);	\
+	return sysfs_emit(buf, format_string, cast edev->field);	\
 }
 
 #define sas_expander_simple_attr(field, name, format_string, type)	\
-- 
2.29.2


