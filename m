Return-Path: <linux-kernel+bounces-148048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7DB8A7D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C673628302F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091AC6EB62;
	Wed, 17 Apr 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sh83uqUA"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A226BFC7;
	Wed, 17 Apr 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339051; cv=fail; b=hYauhDCdbrmn3CzJq4D+4ftNJ5PbI7TrUb6fOF4zNllli7lFA/PtLjOMlRdXFRST7vL6oJzBAipuRaa5NBXCJygSwbuCoLG4yBEf84W1moyAVmktrAePsu4mIJxROst83hczqTBAu6Sxw+gjMSO6div3+2qS4w/SkKkhR0/8QaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339051; c=relaxed/simple;
	bh=DRN9+kfUKbV3984wUIA6xnWOcm5UEBNSSPcZ25LA6Bo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKTQjmq1DmbyJ/H7lz1rzWsgcVedXA+KyoTPmAU/rhX0+uRL8rNlKq0nvgPXkKQn2qMLTSul2S1/613q4obpY6jotyQPqjyul4DkZp/7AlJhurLtXHeg9j5v1uE4pMKYLpApH8lL4mWHKRM4q8/HjAFvPjaXNpjShbaPm6unyUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sh83uqUA; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXK7bbMTQ5z7HNSe4UyD1m8fr6Yxe+oaRchzcdN5Cf7IBC0lEzf6U6n9Zq1QcvAus2xCLNg0Mo17tOeXFz9IXJfb6m6IuL/EQN0dOppEmi3CJKcM7bt9sm8Us9bgaLcojOfgkLvSISx9we+rQDHOhrx9l3kDzeZTkCmCn1BlhqZ8Qsb4Vlo/bgbLsO/LjF6LwPPRIOHZkYT6fF+Xy7jZUeXdvgJnpzw1FOxOelgFvd1yVcJ5mYVnykU8H/8QY+oQaNHOPWPc2TNDa0tP4DTgSN9lYe+Qf9Wa5O5/EOxP+7t7oXwY4U7Htoy/LiYeAROUctZOEZee+lLBIkurS53WLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2EzonrVhq6oIy5zaTYX6aOlc2oQnRc2mw5TlWvysXk=;
 b=VGRLP0/9VyqcnNpycV2HKLbw0/4MUfH1qxgllXF/7P+APbuJreMbYy8Z9vexu2h6ecMxwJ7uGRghik27dI986Q+SFmjS6EJriwgH3HXDlOJi8PdgibmfvWNr7L3TPz0ogNHPL/iQNlVcyJd6/fbe+lP0jC9eNXRXkK2ps6Hwz1aQ7+Tz2R16rnNwEPkMe+LnvjNRh6MJBe8SiRbUgQ24e3TbKxNaDcS7MylbwZEUnObRqK/DyLYYbI0nTnHM4DTX7JgKK0cmg/m/8l+E0n9WCLbyIskdPeymdMIhhx4u/hfrzuNVLh2uJF0jeWDoJUHSZ1JBSbQKhX1oxAideMgpXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2EzonrVhq6oIy5zaTYX6aOlc2oQnRc2mw5TlWvysXk=;
 b=Sh83uqUAcZ2AUcWKx0WJvGsjk3MWVuVgiNR3TsqLNu0mhyYzk9qT+fPsW6W+0T0vpD7akhSriSRe4t99+7lHPMD9QQNiPZ/6pv8XD4c4mNtMZKQIb+hGVhW51jfxISjBu9ZFbKE+4AtUbymQCBhhhlyVme43HF4ySXrqSYnPLK+mk9uuEAcMqIplnWjPt0iHb48xtAq8+bncy+vLRxyE/bOc8urH0AA6nARr1E7Pd2uSiDBsX80m0Sw0EwA0C237SJ8Yqa7993sEQD8eepDPQ+YSdxfl9O659LkTOWwknh5Mcxg5kUTSPmje4Pys7u26mmZCLy7E1Vpo87fn105Dtg==
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 07:30:46 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::9c) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.34 via Frontend
 Transport; Wed, 17 Apr 2024 07:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 17 Apr 2024 07:30:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Apr
 2024 00:30:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 17 Apr 2024 00:30:32 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 17 Apr 2024 00:30:31 -0700
From: Shravan Kumar Ramani <shravankr@nvidia.com>
To: Hans de Goede <hdegoede@redhat.com>, Ilpo Jarvinen
	<ilpo.jarvinen@linux.intel.com>, Vadim Pasternak <vadimp@nvidia.com>, "David
 Thompson" <davthompson@nvidia.com>
CC: Shravan Kumar Ramani <shravankr@nvidia.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/3] Documentation/ABI: Add document for Mellanox PMC driver
Date: Wed, 17 Apr 2024 03:30:16 -0400
Message-ID: <b2a3ca5502008dbe4d07a5d07493022c04c135d6.1713334019.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1713334019.git.shravankr@nvidia.com>
References: <cover.1713334019.git.shravankr@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f133db-73d8-4d09-0467-08dc5eb04c52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/xw1ONsnoNxcb5GBU2GUD4bfHCju+g/MKWZQ4anm9CzPNshc9eKWjHp/So6l4kvAxznXD1llnpejW7UEmcFAvK4zXoDZW8Qk6RSz4o7djmwJoguj75jyIpno5J6I4p7rMQT6nXI2m8G5Q/OSmN+6ovUbZIXFCwd5XxM4CmeUDcU1FVFumkENJSSdbVu0FRaHu9Ti3H1VmJUDmV5CMs7QX4EzTzOTrJuo1D8XSQpdTrpXmY4xB0Kp7+yijLPxcXwjHs0mHmQto+jA859reaL2/pJtUnOLhJ+TAVe/fIRenQF3CdsxXr3PpOsIM8caeJaMj30XJPySnVFOJ78ku5uQv7SgFB3JtvKgDWaZ7WSgBd2r+zPvLlnovetaKwZtcNVwGTKdhOhufsn83gvYmLsWLY3R2+HYJl4VdnI7IA1gJDlOCsJizdp3WPwBqmK7HRGy8PYVOz+YhoCt52f+JZt0VeUBJyIhnZz2FiCv7wmVqr6I5IU7ezP30trWY12oyxs7Tbn5+PYba6O1sOTTzCP6RbKSh02ZFLe3a7oyYY5iKumTzlT0BMue+KER7lRE1tCI1aLA18Nmv1MEAuuAubHCueD0XuG1CxmuEMvj0thbWTI5WAUqiNVdrEKiuDAW5h4ShLuv7Tg25mgtCHsV7VO+JNx8jfZ0P3mPCZycxCIZi+ozUBUi3gG+gWTdkvdpbueXlwxttLHtBmHzeAFqL5TP5mR2866Z1FdOlKhyPxbDZp7xoill5HGQUdVX1BEXAj5k
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:30:46.6060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f133db-73d8-4d09-0467-08dc5eb04c52
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322

The sysfs interface is created for programming and monitoring the
performance counters in various HW blocks of Mellanox BlueField-1,
BlueField-2 and BlueField-3.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 .../ABI/testing/sysfs-platform-mellanox-pmc   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-mellanox-pmc

diff --git a/Documentation/ABI/testing/sysfs-platform-mellanox-pmc b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
new file mode 100644
index 000000000000..47094024dbeb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-mellanox-pmc
@@ -0,0 +1,49 @@
+HID           Driver         Description
+MLNXBFD0      mlxbf-pmc      Performance counters (BlueField-1)
+MLNXBFD1      mlxbf-pmc      Performance counters (BlueField-2)
+MLNXBFD2      mlxbf-pmc      Performance counters (BlueField-3)
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event_list
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		List of events supported by the counters in the specific block.
+		It is used to extract the event number or ID associated with
+		each event.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/event<N>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Event monitored by corresponding counter. This is used to
+		program or read back the event that should be or is currently
+		being monitored by counter<N>.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/counter<N>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Counter value of the event being monitored. This is used to
+		read the counter value of the event which was programmed using
+		event<N>. This is also used to clear or reset the counter value.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/enable
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Start or stop counters. This is used to start the counters
+		for monitoring the programmed events and also to stop the
+		counters after the desired duration.
+
+What:		/sys/bus/platform/devices/<HID>/hwmon/hwmonX/<block>/<reg>
+Date:		Dec 2020
+KernelVersion:	5.10
+Contact:	"Shravan Kumar Ramani <shravankr@nvidia.com>"
+Description:
+		Value of register. This is used to read or reset the registers
+		where various performance statistics are counted for each block.
+
-- 
2.30.1


