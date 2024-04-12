Return-Path: <linux-kernel+bounces-142762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2569C8A2FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA5E281A27
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856A85277;
	Fri, 12 Apr 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="oYzRUzuQ"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56C84FDE;
	Fri, 12 Apr 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929755; cv=fail; b=diI2e/xJ9fQ3LflOrd01Whz9wkQsgWHQv6Sm2xNYfYBmTCyhgLalfLFhiSFpJ5iIxpEPmme/l6FFkOKyPgBxu6fZsSZ8JRfS39VEnlyRkuKw7PvnwANuvTCHLbQaHMy6EhqtGEasWsB6suVOx0GOaPT2dzC7KY86tp9s2h5AD60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929755; c=relaxed/simple;
	bh=XUTnb5tl5pHS3ZUZHwSLBhNt1tMvOIbZOuVjHBs+i1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bLlV88NEiNcxEEZrA74wKRZAalxn3UMY3a8TzngIKxquRHVfYjUo5uOYG61D+gpiFjImbYlKPeN/+cQoJQgDdQzBR65VBBV0nS3nneg86KCZGiB/AvCnYUo3UFm+LYOe/qvrl94m+qdDO5dqoJlQuTva5mbr8VYm083xwNjyCYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=oYzRUzuQ; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZOP3rXG8gczPHR5D+b9pP4EL3KAPY0yiWdFIX5w4YDImLqkFJme1uGBYrCVTbhHagW16WejdHe2KU9t1P+dKHDaw6xdtOwQYQuJvpWgLw4aT7UBaa5FK8TZ2JeRTjfF/Q5D8ZrPwQDWrf2oIbKXkeTPCghZqPgdxdjn//i+AZhT0PgJ+bUbrUVYChDdCJf8jMqdpZVLdD2pA7jUWUUafTOodMbyqTn/womGBhgWqP1FAXJKztno+SgnIoXc4tnyfzQl0dQ1ax+SX+W2Q3W4W6yWcsFx1LqKfPDO5QtAzC2T/QE/oBdhwdnlAJq32ccbPAoYWAXVJGuwIFFnxYHKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBCPoTrP9qdEe8UyN9/5EPrXCPt+GAMV78vOWJMeAPo=;
 b=lsg+jwtqOA3mk257B4fiI7wiyjvP+4sCMSne/fMyyrJdWSIhCNdrev+N75+GcxTPTtW1VedZeXtfizgVcr5BuBlkTdStbkyoxpSHvv6uO2vn1+aSFqDhrCyqYcZE6JPTZpJ5nX+pzmwOSwX/sk7H1X2ujVjOWGCYldQpd57X2jbr8FCVtIUym0FMVGvRx0XvvQZcUSdmzsCCniL+fioG1keA+BRbG1gY5Z16fkY2KNdQsh/Rfio5rj5xiYOXL9l0Hob/5cg4qOa87EeZoEnMxSMCoKTeG9jJY0pArs0guO23fTA2YNyBZhnxCmOqqygu1F43eyNRRBKgMiPotKmCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBCPoTrP9qdEe8UyN9/5EPrXCPt+GAMV78vOWJMeAPo=;
 b=oYzRUzuQ12slcqlkEwwTojX1dxIn/+30QeUmjefuXj5cpE3izUXfeJUHF4M0XLI+F5yOghMbHKmincRBYZuFdq3GmOyUzU9Os+ZrKuzkTY8gUftF7kQwmUTV5tHThLYJql/QWaQ20xg7DyppDLHI4t2n1O/WDaYWS4blJz3YDP8=
Received: from DUZPR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::12) by AS1PR02MB7871.eurprd02.prod.outlook.com
 (2603:10a6:20b:4a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 13:49:09 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::85) by DUZPR01CA0089.outlook.office365.com
 (2603:10a6:10:46a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26 via Frontend
 Transport; Fri, 12 Apr 2024 13:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 13:49:09 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 Apr
 2024 15:49:08 +0200
Received: from se-mail02w.axis.com (10.20.40.8) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 12 Apr
 2024 15:49:08 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 12 Apr 2024 15:49:08 +0200
Received: from pc49789-2223.se.axis.com (pc49789-2223.se.axis.com [10.92.128.236])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 751F2315E;
	Fri, 12 Apr 2024 15:49:08 +0200 (CEST)
Received: by pc49789-2223.se.axis.com (Postfix, from userid 14410)
	id 6BC1C3286A24; Fri, 12 Apr 2024 15:49:08 +0200 (CEST)
From: Gustav Ekelund <gustav.ekelund@axis.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <hare@suse.de>,
	<martin.petersen@oracle.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, <gustav.ekelund@axis.com>
Subject: [PATCH] ata: Add sdev attribute to lower link speed in runtime
Date: Fri, 12 Apr 2024 15:48:38 +0200
Message-ID: <20240412134838.788502-1-gustav.ekelund@axis.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|AS1PR02MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e18abd-726c-4563-180f-08dc5af75408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VLwcxE9DkXhjTofCBJz+ScEQUmoNxPUrAjaXlSBKUv2bPIpc8un8YVoOUt8MuB4KjTANDYTo0HndqtZ8R+vuneCfsqsk97nEk+9sN4I0WmKIaNARy+hv8IQnxOsiRoFDvVnacdBWV1dVKJSjxFK17WaOdOsOa2EnEFG6ru33jF5GtwfI3tF03+Iug2Y6Ybd7+4jNGxDk6/5NoQO5KgDWe+kRr+4D9W22ROWMkfnz3Hy1V67gkC1a2KiO7EbAoSMRg0YwUf8H5zlSeef679IMX7f5uMCoYADtE6RMHmLfSTtGyBoed+B3H9sh6jxYJylbeW0yE+CDDqpzU7peXiZBAazZmyVnhOioGgQpLM54xc49uQTrHPIaXFkT0hT2AyNhx2j4yiw66U7jorkdNluVKPsw2S6BZ1qtCO9jEE/P+qOWehgPFz0mLgygltz8ZORdIyY/ZS/IdKAo+5wNs/tYleRz1E+5rGw6FFciQh5n2dctfX5hw5A30ENNZ5vZqU8Ttoe+WmcdPY7I+M0IBjKHAgZtZBKkZVdVuAkexcI7TIBVtzi2c8cJ6rXdfH43SqGCYvvXGUkhsfjz9o6FuLs/ppsa2tDn7e1XrKzkhwTD3pf98Yi1Pwrtt/zjSTKG2RqkywJ4RZaR/E/SR+edjJQYXphXqO5ShkcUbdzIswAZsrR95mWOrHjHf3B6E25cTGxYaySkZy49aLzDlligh8BYRID00QZ7Bp62cqourbzOMJOEbKwhXlDGr0DDF4AowAnU
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:49:09.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e18abd-726c-4563-180f-08dc5af75408
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB7871

Expose a new sysfs attribute to userspace that gives root the ability to
lower the link speed in a scsi_device at runtime. The handle enables
programs to, based on external circumstances that may be unbeknownst to
the kernel, determine if a link should slow down to perhaps achieve a
stabler signal. External circumstances could include the mission time
of the connected hardware or observations to temperature trends.

Writing 1 to /sys/block/*/device/down_link_spd signals the kernel to
first lower the link speed one step with sata_down_spd_limit and then
finish off with sata_link_hardreset.

Signed-off-by: Gustav Ekelund <gustav.ekelund@axis.com>
---
 Documentation/ABI/testing/sysfs-block-device | 13 +++++++++
 drivers/ata/libahci.c                        |  1 +
 drivers/ata/libata-sata.c                    | 29 ++++++++++++++++++++
 include/linux/libata.h                       |  1 +
 4 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-device b/Documentation/ABI/testing/sysfs-block-device
index 2d543cfa4079..dba537fdf787 100644
--- a/Documentation/ABI/testing/sysfs-block-device
+++ b/Documentation/ABI/testing/sysfs-block-device
@@ -117,3 +117,16 @@ Description:
 		Writing "1" to this file enables the use of command duration
 		limits for read and write commands in the kernel and turns on
 		the feature on the device. Writing "0" disables the feature.
+
+
+What:		/sys/block/*/device/down_link_spd
+Date:		Mar, 2024
+KernelVersion:	v6.10
+Contact:	linux-ide@vger.kernel.org
+Description:
+		(WO) Write 1 to the file to lower the SATA link speed one step
+		and then hard reset. Other values are rejected with -EINVAL.
+
+		Consider using libata.force for setting the link speed at boot.
+		Resort to down_link_spd in systems that deem it useful to lower
+		the link speed at runtime for particular links.
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 1a63200ea437..2622e965d98c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -138,6 +138,7 @@ static struct attribute *ahci_sdev_attrs[] = {
 	&dev_attr_unload_heads.attr,
 	&dev_attr_ncq_prio_supported.attr,
 	&dev_attr_ncq_prio_enable.attr,
+	&dev_attr_down_link_spd.attr,
 	NULL
 };
 
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 0fb1934875f2..5e1257b15f95 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1538,3 +1538,32 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	ehc->i.err_mask &= ~AC_ERR_DEV;
 }
 EXPORT_SYMBOL_GPL(ata_eh_analyze_ncq_error);
+
+static ssize_t down_link_spd_store(struct device *device,
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
+{
+	struct scsi_device *sdev;
+	struct ata_port *ap;
+	long input;
+	int rc;
+
+	rc = kstrtol(buf, 10, &input);
+	if (rc)
+		return rc;
+	if ((input < 0) || (input > 1))
+		return -EINVAL;
+
+	sdev = to_scsi_device(device);
+	ap = ata_shost_to_port(sdev->host);
+
+	rc = sata_down_spd_limit(&ap->link, 0);
+	if (rc)
+		return rc;
+	rc = sata_link_hardreset(&ap->link, sata_deb_timing_normal,
+		ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK), NULL, NULL);
+
+	return rc ? rc : len;
+}
+DEVICE_ATTR_WO(down_link_spd);
+EXPORT_SYMBOL_GPL(dev_attr_down_link_spd);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 26d68115afb8..51d23a60355b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -510,6 +510,7 @@ extern struct device_attribute dev_attr_ncq_prio_enable;
 extern struct device_attribute dev_attr_em_message_type;
 extern struct device_attribute dev_attr_em_message;
 extern struct device_attribute dev_attr_sw_activity;
+extern struct device_attribute dev_attr_down_link_spd;
 #endif
 
 enum sw_activity {
-- 
2.39.2


