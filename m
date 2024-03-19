Return-Path: <linux-kernel+bounces-107091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B253687F776
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37A31C21655
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B17D07F;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Lm5PxFgV"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC45102E;
	Tue, 19 Mar 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829954; cv=none; b=Q62m6FCJEWEpZnD+zYBdgbHQgzFxxdqLFfKYZOofCKk0uTm9I/1BsvdRUTRGw7eP1e5y9RMbJIi9nx/86f+AB/Qh2SHK8mxelPCpXEHUmA8BNOrXvSy6/Xu3emiOrT5+x2/N1lMh0JA1XwpEZx7SDcfCSoOLqQY4H2FUJz0kOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829954; c=relaxed/simple;
	bh=WTXpZlGLvu69orlfGdipH5GXMwQecnj3ncOT0UXMt9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZJCm/VifjuEn0IrSuuYWwEXNE4c4QEEHjPr+na/XUC9+7zzHr/SdvJDcD5tqBNBYM90C6u82jvDI3Ok0q03iWerG5vmaj1EXsB+X0IKZZ1ExkF3s/Q8XbCSIW8M6iGqCbs37QlG8N2o1iXQK+Z7gPJzJaqQ/nZkJkFRiBReQv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Lm5PxFgV; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829953; x=1742365953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTXpZlGLvu69orlfGdipH5GXMwQecnj3ncOT0UXMt9I=;
  b=Lm5PxFgV0/CcIcZJgQZmiofhVHXT7iElG/zeIc3UfH40tSBizeonuHyu
   z+R82Hkqx/I9sXWVnkyoDYDVu3Sq+P3sj0WIZS5BhORph7frVUL/KRXFz
   4Sccsix4ZcZtW5pAtN4FYyJHEH63gczH47P5dbmrJGMIjz7+FsVTpwsyV
   3ocZbT1+7/wFo+m8bMqrSzo+1oM7HE8zg55XUENgIMiHd9cGsaffvCfd6
   mkzY7lPmBcRtQSoS77oxlW5mKAWo4AuVMYJth9VHl7qv5oVwa5iRXk/Kh
   B0t8FU1lRTpmuqXxJhC09yRYzH2JzapGhPebkiUFayKf2U6gLT//6v8Mz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="152728482"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="152728482"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:30 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9AC82C6817;
	Tue, 19 Mar 2024 15:32:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DB6ED2970B;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 77CAE20093269;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0D4411A006E;
	Tue, 19 Mar 2024 14:32:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 18/25] scsi: pmcraid: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:25 +0800
Message-Id: <20240319063132.1588443-18-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--14.511600-10.000000
X-TMASE-MatchedRID: vWLMKRYJCzcbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VTZ3y
	a1EhGxQ6HpFHQK2deBojVDzk3DrCl8M8QL/JCA9N9JA2lmQRNUC//1TMV5chNShcWO/83xogYzG
	YtVtarB/srJ1bjaCKGdqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8BmVY5bgINIVKHlP
	WL/eVsBinwNZyXFb2Ko6sd/AiC8FRR4hrziDrtc=
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

CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/pmcraid.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index e8bcc3a88732..56376d335b21 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3538,7 +3538,7 @@ static ssize_t pmcraid_show_log_level(
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)shost->hostdata;
-	return snprintf(buf, PAGE_SIZE, "%d\n", pinstance->current_log_level);
+	return sysfs_emit(buf, "%d\n", pinstance->current_log_level);
 }
 
 /**
@@ -3599,8 +3599,7 @@ static ssize_t pmcraid_show_drv_version(
 	char *buf
 )
 {
-	return snprintf(buf, PAGE_SIZE, "version: %s\n",
-			PMCRAID_DRIVER_VERSION);
+	return sysfs_emit(buf, "version: %s\n", PMCRAID_DRIVER_VERSION);
 }
 
 static struct device_attribute pmcraid_driver_version_attr = {
@@ -3632,9 +3631,8 @@ static ssize_t pmcraid_show_adapter_id(
 	u32 adapter_id = pci_dev_id(pinstance->pdev);
 	u32 aen_group = pmcraid_event_family.id;
 
-	return snprintf(buf, PAGE_SIZE,
-			"adapter id: %d\nminor: %d\naen group: %d\n",
-			adapter_id, MINOR(pinstance->cdev.dev), aen_group);
+	return sysfs_emit(buf, "adapter id: %d\nminor: %d\naen group: %d\n",
+			  adapter_id, MINOR(pinstance->cdev.dev), aen_group);
 }
 
 static struct device_attribute pmcraid_adapter_id_attr = {
-- 
2.29.2


