Return-Path: <linux-kernel+bounces-107092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE787F775
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515D51C21357
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EC7D081;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WxaJmaGm"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4851C40;
	Tue, 19 Mar 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829955; cv=none; b=IDlHDfzDk/kL3LNk3vtchrqn2lufyGpTCXtfP4b4oKuRGuDZijHGgM6GJR5Fs3yZv3ndhcidR7dVFXfAKW4uLBex7gg9metdM+nIfk+ppKDfaAvcMRQvOhm4I2Hiwq3UUYG2ph+Uksbk6W9q3MlbD0bjlQEDkGtq09WxRx76ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829955; c=relaxed/simple;
	bh=ZlA6JU7/ehef/vW2jERz/3A3wyjNfKl0XuA2hSGKzPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umPxziulaa92yNVrk8pKoo0Wcl1Bat0qYPr0LNOJJFYDODv0jPwVUB58uMhl0DAvyIcfCTpSYsQ7YGrCW4zuDTzh55dJAqR5AqVMjQ2hR5UlExRwZKtXlS9U7v5wTSiMzOj0KIZruVckllVt1LtxXXjFDd9HxBcITrGzcZRUI1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WxaJmaGm; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829953; x=1742365953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZlA6JU7/ehef/vW2jERz/3A3wyjNfKl0XuA2hSGKzPc=;
  b=WxaJmaGmUCAy0U7ObGi7kM3t7zUP5Pem70LKx8yaxgRt9kJkNb1k2fUw
   QI+6xEj1F4RMFk8cPgHHvCrO55K9VQWoWvcY1O+FlZZFHNYBST52PEBYt
   C4yvTnBsPNHWpjjdO3AgiME+y9urdZlcEnpkJ39UBWNzf/kgo3qYeRZE1
   KQMeZdEsZzdrYQjv6RL5nBMqoorPasHCt+U8hZmB6tMxS8KTFoEvYe7s2
   h70hlUaPTg+4ZsqZksCvZY2G/Dnrm2ucsjqPanR7c1pv2ZZP4txSzzW33
   +MjqQZ/whftQrYpkgNJkqbzSin6Y9lHXTxyngVarnrWS6KQw5edkhVVlr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="154551207"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="154551207"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:28 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7471A10A303;
	Tue, 19 Mar 2024 15:32:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id ADEB4D5E8B;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 39A4420099077;
	Tue, 19 Mar 2024 15:32:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id A908D1A006D;
	Tue, 19 Mar 2024 14:32:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	HighPoint Linux Team <linux@highpoint-tech.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 14/25] scsi: hptiop: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:21 +0800
Message-Id: <20240319063132.1588443-14-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--9.668400-10.000000
X-TMASE-MatchedRID: pfKaEBrCt3IbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u8SyA2F3XSGImluHEj++VqUhQ6
	YZNvnIb+Ekt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gwLkNMQzGl5B+Kr
	WCPbERPy9hGGyJxSOb+2f2+sX68s9d3YLSL0hj6d9JA2lmQRNUJScvOTX4jHO7DRAx8YqC+RhBv
	WgZlX+84vM1YF6AJbbCCfuIMF6xLSAHAopEd76vpajbLOEXhRLdRewN0C4wlusoImWqyaA+5zNp
	VcKo+DLrCT0EGhF/DQ==
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

CC: HighPoint Linux Team <linux@highpoint-tech.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/hptiop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f5334ccbf2ca..65426df93270 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1111,7 +1111,7 @@ static int hptiop_adjust_disk_queue_depth(struct scsi_device *sdev,
 static ssize_t hptiop_show_version(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", driver_ver);
+	return sysfs_emit(buf, "%s\n", driver_ver);
 }
 
 static ssize_t hptiop_show_fw_version(struct device *dev,
@@ -1120,7 +1120,7 @@ static ssize_t hptiop_show_fw_version(struct device *dev,
 	struct Scsi_Host *host = class_to_shost(dev);
 	struct hptiop_hba *hba = (struct hptiop_hba *)host->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+	return sysfs_emit(buf, "%d.%d.%d.%d\n",
 				hba->firmware_version >> 24,
 				(hba->firmware_version >> 16) & 0xff,
 				(hba->firmware_version >> 8) & 0xff,
-- 
2.29.2


