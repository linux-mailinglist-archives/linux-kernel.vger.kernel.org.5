Return-Path: <linux-kernel+bounces-78005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57386860DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E981B20FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141565C902;
	Fri, 23 Feb 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pcLqUYVU"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2CB5C8E8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680305; cv=fail; b=uY5KFckKCGT1Ejat+LhzwQ2kUaCd+6++OOW1jZwwdquZIpl6vwUIinji01RCnSuVkFVjnJBm2OdqSqvhyHMctSk5XTSQEj72A8Fss7QvrLCWbFwf1EAnyV/Kb/IJWDTw/e7q6XCy4naO0MeHyROz832D3ohxruQ4LoKFqc4U5ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680305; c=relaxed/simple;
	bh=R4nZ2xfClmoJe+hj0NWcxIEbpsCJAI4fjkHEDhP2XJU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T0FgJaJiF8sdGOoczkUwl9grhOLuCe8QQCQprGMY1fvj2yr5zNBOGjgXWbStBxXLvYKcmvQwhy6ozz1vkweMjtbucO6cOrPsWV+E4Bdmiv5+w6SE/Xrijyu5graL8MjpNwg5GVU8XE/W5YGzH1NsJiTXPtUz3Wzv+dgz1klw2Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pcLqUYVU; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WthcKiR6nqIXyiabteBabyFqzO1nP9ej4pO2BYDn6WDjWzHrAVRXhowTFgsyXEiq0dJw2N82kiSXfdENg459AHrAbbxkbtjSqA1XDUu+o3L8dHl695Ff8PPb4V9BFA4IvWWQfAY2CaF+pmKLxGihpOHlC5nk5olHik6IvIOcmoJz7hFzCNj9CKpG08L/w+fntRtUVDFtBcISyWMFtSqfxmwtcwGovEyNQwQZYY6mCT+wnVJxOBMoylzIi+0HQSIrqOIg4Hn1QrFW5PZa00PfGIwyB9hsMep6Cf/k8jKBxLB9Ep8HvCpmZqK4RWOGDYZQTrlQTd5PSEEfp4X5TDe9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tPEwzZRU6f2Y7A4ByoavtlkDz2r/2F88Gbwo4QlQeg=;
 b=YgaBrWUP2czCXiFNdWpuugBWkA1QR+CqbT233eTgr812yoUY6ekW9BHoCnHSogNDEfxCY8bjwDW5yWMRJiwGxLAxQMPVqQ1j8wZFukw3pwzEBXDuXbQmb7oqKt00BLyn3VYn6tHnDZWx+z6bIPjZ6Nk2C8AaRh/uYVinYX2Mr6IQ948EwrY9/I/HQ2ZxVky4gRgMkRX6Bam8oADGM/6+2UnnImmLJ/n9nlNzM9CKFCr2EoJ5Mkn46db03+r5j4iqm1NfVTkNgge09bTxtZHy39XswdG0PnXkjAU9GsTz1ELjEVe6lHhBeHzLLyV7t5yfC8etL+tIzjLeOWsfrWEZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tPEwzZRU6f2Y7A4ByoavtlkDz2r/2F88Gbwo4QlQeg=;
 b=pcLqUYVUuLTjTvhANOYscT89GrKPm5fHCsmMW+7kx/RUgz/eurNfKUHi5gDahLwadm8YHfmur4VZUmIheBbtpgdi7H2Dahkb/JnbDqKeoI3yufLu3wzNgFqhrnfMy2YlnDxZgTDU8wwQ6QnQYz64FQrmDwLEyPm2xtJuCBvzzDE=
Received: from PR3P191CA0027.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::32)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 09:25:01 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10a6:102:54:cafe::e1) by PR3P191CA0027.outlook.office365.com
 (2603:10a6:102:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 09:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 09:25:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 03:24:59 -0600
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 03:24:56 -0600
From: Nipun Gupta <nipun.gupta@amd.com>
To: <gregkh@linuxfoundation.org>, <maz@kernel.org>, <tglx@linutronix.de>,
	<jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>
CC: <git@amd.com>, <harpreet.anand@amd.com>,
	<pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
	<michal.simek@amd.com>, <abhijit.gangurde@amd.com>, <srivatsa@csail.mit.edu>,
	Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v8 2/2] add wrapper msi allocation API and export msi functions
Date: Fri, 23 Feb 2024 14:54:47 +0530
Message-ID: <20240223092447.65564-2-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223092447.65564-1-nipun.gupta@amd.com>
References: <20240223092447.65564-1-nipun.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: nipun.gupta@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb68d55-2bf7-42a6-19fd-08dc34514f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t2wQWaaZLgBivVkyQaKGprVPAz+q+SMgT5PUAS3rBd9ubAB83KWu7DleRJnr+BIqknaRSAZcAOZm7J88TYtkTRYjGmvoHEd6+Cqvppq3vIQyfay6H9HJrDiXmr8hDGLiaSwt2mYgvzSFR9XnWHr8u5ejPyOq1z3RMjklXTip8GGPczUvUEkQruk3BgNX9JqxLX5hl1IpP/i0gXXfWKSmJkleUFaYdMZs8yO9TNRrDQelZrDRs+hA4IPRd7Tgja04ybkm1mnXQLrTT+06AYLwMG6/GtvbYAn17oCgqZ5w2yT6t5Xq9ONdRsHGDa+iktkBASZGfKvCpyatvsgNHF01p7bqlj07pFvZ2aEZbKRCLa8gqzuQBLv8B+ybSmqiOTHw/wkCnqOYW6rsGRCGbHp0EzhyrgYiIMclrGm5LhaTOBdm3PM1sz8Wa17ZKtOpzRTbyRrgugINLbIuv2C3+d1UAbH/5RLOfLUQOjYP0Q5tU6WkO2CRuRHMK9v5COOMuqI+9SyrjtHIAZJF5Q0mZIskLKeuEN/dDEhh5hE+TOTf/nbzbaQTFu5I7E9XwR2a7Ps9wIB1BJK3VIFEb1g3teyZYtrccVn3+iR0wtVeu5F9xID5nHdWssQRpSwebHpwe2p8j3OFbdJMK3KWOsyHjptNPdNJpvSewWfrdJ9Ikpdn1Ak=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 09:25:00.6787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb68d55-2bf7-42a6-19fd-08dc34514f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

MSI functions can be for allocation and free can be directly
used by the device drivers without any wrapper provided by
bus drivers. So export these MSI functions.

Also, add a wrapper API to allocate MSIs providing only the
number of IRQ's rather than range for simpler driver usage.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
---
 include/linux/msi.h | 6 ++++++
 kernel/irq/msi.c    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 26d07e23052e..765a65581a66 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -676,6 +676,12 @@ int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nve
 void platform_device_msi_free_irqs_all(struct device *dev);
 
 bool msi_device_has_isolated_msi(struct device *dev);
+
+static inline int msi_domain_alloc_irqs(struct device *dev, unsigned int domid, int nirqs)
+{
+	return msi_domain_alloc_irqs_range(dev, domid, 0, nirqs - 1);
+}
+
 #else /* CONFIG_GENERIC_MSI_IRQ */
 static inline bool msi_device_has_isolated_msi(struct device *dev)
 {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index f90952ebc494..2024f89baea4 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1434,6 +1434,7 @@ int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 	msi_unlock_descs(dev);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_range);
 
 /**
  * msi_domain_alloc_irqs_all_locked - Allocate all interrupts from a MSI interrupt domain
@@ -1680,6 +1681,7 @@ void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
 	msi_unlock_descs(dev);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
 /**
  * msi_domain_free_irqs_all_locked - Free all interrupts from a MSI interrupt domain
-- 
2.34.1


