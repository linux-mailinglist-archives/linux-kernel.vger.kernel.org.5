Return-Path: <linux-kernel+bounces-163339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 664CC8B699E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F07283662
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C1134CE;
	Tue, 30 Apr 2024 04:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="uwso9r25"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2087.outbound.protection.outlook.com [40.107.13.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958B8BF0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452953; cv=fail; b=Q/CsmypgUqUYHX7S+JYHeQoO0eaSqk2L9roaa8pg0Wg8EFEHVig2CvzTnM6xgJ3fAo5GzJvle75vYhZKL1yUPWRqyZOdw66OINYmLnJk/VnlOst+sFFsXlnmKa2EUfvxpe7BuFCesFjuqdIcVBTrBUZySM6ddC3ic7tMAEXOrps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452953; c=relaxed/simple;
	bh=fIKlSgXV28AHVOGFimvHS3245PmVyRzEErj3jOFsq9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S90ZF93qbC4w5W689KwD3fLCuPfrlobOLun/q2r6ZcAOpJ1f4eq3fvh1Pr0mrc6weXZv25R4nKi8aq2rtWB3UN9oY7Xnc8gY1xu1SBsQUyKSCt6j4xV1Hq9fald7zfWDmpeoELFxc6dA+UGrGuLSjW43ZG9CQTOWz5gE56CJyaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=uwso9r25; arc=fail smtp.client-ip=40.107.13.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQrjl1rBHvTLWVVXItl2Ssdc56fDBKRqu5i4b7O8SBYNGbaNHeHpfTZnOVO5MzK4SMqPFjkSLMd0rXt7KIj+EpCvCCeOwt4QxR7nkmz8r50Sm9zb+GsfKgZyWowkL15JZwfuYNB5g4KONE5zGhPaOkQD7NMDfsfGQteyzpKWoBZUT4cvikE01fwdJfUBMZbscI/fuTsjdTl6YAkPyD/iYwYWO2QxveN9st8P76lMZLCFwXX15GrZHlqmzvX9h4rWLBekev4aNVQeubsUz3Wqtr2aXmVcoyvuzBVZG1/yKIBal0uxsftV89/gXx6dwPckWlYlepAiJq5WtzD7rU1qgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAs7rr1y8fhdtw/8P4g2zDQG3pQBXJhAbYrou2+Cb74=;
 b=QeY7kIbmvNioUlDXLYvozRcfY5XqQi5XuZDTMd9iL0/0igAyzLkTLF3KNPnpj2ruWimbNNIpmvjMsmIKTGTns88qp/8C1MOAVKrDTBYlkydsf5mwFUELxjao3DV8aaNb8T+egiG35fAuG2hxfRJYjH+it3DkB5VV+rpDGhTaXHciZvgUTriyPmPunYx+8Q5uEnyeZeN1TP76mZQxGmXNRVHGqcC2g8rkTorwr7IwAZadpfHYuDVY+wCOactoYjAQ/Sk6ocdkQEx8q6rEndoUw3c5KcTkSNfLKjPPyhUzdrVVbBUr4RvnvlKR1P5mFZKT87BG0Auh+VlabF8NJ1lx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAs7rr1y8fhdtw/8P4g2zDQG3pQBXJhAbYrou2+Cb74=;
 b=uwso9r25xmi6GVn9QAAEYUHa0dwb97icZobvAGTbLywznVKCWc5x0QdaiESbbrQVONq3Hj3t/a5ntwFldMa5Rfj/z/TyLu5QlBt2icVQWSO+97BUci6j8BBTN97ZeaEDL9ZkbXEfogcaq6i5lmCB1+NTmmDu/JwQAqvbniw0ohQU9UeHP7KnViipOnABeT6gjIu0+1IdePsXm5r3Ek/uRd3jUABPlVXfV9x7qJL/eZJhSFujbLmfYpqhzFwNpol3cV/hhuCp3f0AGZo+GnLrDS9+UcUlnP/dAHnP4g8I+qpnLcoA14sbLmyKWLoEXCWCny7BC7zM1vglRMIGDY27OQ==
Received: from DU2PR04CA0318.eurprd04.prod.outlook.com (2603:10a6:10:2b5::23)
 by DUZPR10MB8226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 04:55:46 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::24) by DU2PR04CA0318.outlook.office365.com
 (2603:10a6:10:2b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 04:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 04:55:46 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 06:55:46 +0200
Received: from HI7-C-0001H.de.bosch.com (10.139.217.196) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.37; Tue, 30 Apr 2024 06:55:45 +0200
From: Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <dirk.behme@de.bosch.com>, Rafael J Wysocki <rafael@kernel.org>,
	<syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com>, Eugeniu Rosca
	<eugeniu.rosca@bosch.com>
Subject: [PATCH] drivers: core: Make dev->driver usage safe in dev_uevent()
Date: Tue, 30 Apr 2024 06:55:31 +0200
Message-ID: <20240430045531.4062232-1-dirk.behme@de.bosch.com>
X-Mailer: git-send-email 2.28.0
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922E:EE_|DUZPR10MB8226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4c4f3d-3aa8-46e3-9071-08dc68d1cc5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUI4a5PaSbFK7S+AdN4QFMDHQ9nW76ImCbxXzVWBMna7ugpI/7gqrSxIbBg4?=
 =?us-ascii?Q?KTGCD1fiXwXtfTbtGoUzxNgr9eOKVzAuW0xYWVOlXHcALzAAhmEjxWf+V+wN?=
 =?us-ascii?Q?OWol7gti+PPqWjK5V7hdakGRldN2qaQFNm8U/plUrA9FTATl51LxEhFlZ/SD?=
 =?us-ascii?Q?Zi59ySIhye+b4PKua+W/obRlwuA5/34COFPileO5dFBwcBenTdsDoFui4dcJ?=
 =?us-ascii?Q?BiNY5QUL4EU+sD3oSeJlCRu7xuyUoo8UGTXJhNmSJUK3BKz9WlgVTkPAQ9Oe?=
 =?us-ascii?Q?s9cHjckSCrbIZ294eLwWXeA1vUPhK1shLyUevsnBkW2koGXGU1mJVWAlQVEx?=
 =?us-ascii?Q?AYFgfvBPv4Z2OGAK6pb6Ahc/x807J0jmC3wv2UuysoP2AKEmUYH6PU3IxXKc?=
 =?us-ascii?Q?n/xfLjj5qe+fcXvoFQZSb2tXvg+RnsCtWUBtWv0kDp6jfbdbhrlnSYjvYpKg?=
 =?us-ascii?Q?TtwDMgOTeeWwtR1Fb53xJwembXF+G0ETuK643wSE8+dfwHUX/lSWzz1gMJf2?=
 =?us-ascii?Q?zUtgCbsbKjLSSGmIYhdqm7Fn9h836a+YfxqK+cI2nBigeE5oSbEFtsfh0ryj?=
 =?us-ascii?Q?LW6rPlZrKly9NdRWDuk9GalYh4eWFmh14J23OCDW9lCsyJLrEgJ+EMcn1Zfa?=
 =?us-ascii?Q?DezVPZyJ/IxRBtv46LDYT4DHjXV6l4Ieh/nGaoMKMDDa6qePWH61wSyx0GqR?=
 =?us-ascii?Q?sMnZoz4i0MU/Mt+z+LglPQvB4fDgWET6KEe3DGF/4URzMfWYSINhVipQ06T+?=
 =?us-ascii?Q?f03e5imSusAV62Z/IZW6OKqXfsO1wUrsLPElwRMHtofmz0ZMVdIE8YOHaFFB?=
 =?us-ascii?Q?1SrwNoFp9/vEQRmD3ZzSaDy1PQE1qxXV4KWpoyBYkyOw/ZFdsSWDla7pQwah?=
 =?us-ascii?Q?/zKB9QyskLZvSYWPQ4ZWHjq8ILTjRy2umwoC9kDrlG6QkCnr2IP1nyrueFEL?=
 =?us-ascii?Q?N/4QZ/cOJD4a1pgSLUaT/EUDzVuuPGUdGN9++nbsfY5prlJkyOJpmv9qAn3C?=
 =?us-ascii?Q?7aCbh0Cc/hkwrAGDBI11Zj/GY8nTP19/2wHpEoSJ53xAvzn6dGtXeytkbqrm?=
 =?us-ascii?Q?9M0LKs8LJjApT2NRPl26Oqbhfg0f6NVcw+Sq1Ze4vTAtSf7NqC3jkYgrz1T/?=
 =?us-ascii?Q?QtQiwu2IgN8FCcIJczsdYdPfJ37drSaXRU9q86Y0hUUhOiBgmmfOEcP2ssP2?=
 =?us-ascii?Q?Kh1VSNj/YSXX9k+sglV4D3rwNI4DI6hTn++7TQBt8qeIfmlTzC2HchmPZwtR?=
 =?us-ascii?Q?6AaAOiRAesOxnLbEJiiElqfUQ4Am/Crz4z2mKqm9v7ssdsfscVgsbwP/Lv6L?=
 =?us-ascii?Q?VK7g53EqDXtqPamOoBep/yCJ?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 04:55:46.5098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4c4f3d-3aa8-46e3-9071-08dc68d1cc5f
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8226

Inspired by the function dev_driver_string() in the same file make sure
in case of uninitialization dev->driver is used safely in dev_uevent(),
as well.

This change is based on the observation of the following race condition:

Thread #1:
==========

really_probe() {
..
probe_failed:
..
device_unbind_cleanup(dev) {
      ...
      dev->driver = NULL;   // <= Failed probe sets dev->driver to NULL
      ...
      }
..
}

Thread #2:
==========

dev_uevent() {
..
if (dev->driver)
      // If dev->driver is NULLed from really_probe() from here on,
      // after above check, the system crashes
      add_uevent_var(env, "DRIVER=%s", dev->driver->name);

dev_driver_string() can't be used here because we want NULL and not
anything else in the non-init case.

Similar cases are reported by syzkaller in

https://syzkaller.appspot.com/bug?extid=ffa8143439596313a85a

But these are regarding the *initialization* of dev->driver

dev->driver = drv;

As this switches dev->driver to non-NULL these reports can be considered
to be false-positives (which should be "fixed" by this commit, as well,
though).

Fixes: 239378f16aa1 ("Driver core: add uevent vars for devices of a class")
Cc: syzbot+ffa8143439596313a85a@syzkaller.appspotmail.com
Reviewed-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
Tested-by: Eugeniu Rosca <eugeniu.rosca@bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/base/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5f4e03336e68..99ead727c08f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2639,6 +2639,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
 static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	const struct device *dev = kobj_to_dev(kobj);
+	struct device_driver *drv;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2667,8 +2668,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* dev->driver can change to NULL underneath us because of unbinding
+	 * or failing probe(), so be careful about accessing it.
+	 */
+	drv = READ_ONCE(dev->driver);
+	if (drv)
+		add_uevent_var(env, "DRIVER=%s", drv->name);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
-- 
2.28.0


