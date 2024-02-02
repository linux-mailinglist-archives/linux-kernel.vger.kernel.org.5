Return-Path: <linux-kernel+bounces-49766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEC846F26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1451F286BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4D13F00A;
	Fri,  2 Feb 2024 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QOutpt5p"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA61913D4E0;
	Fri,  2 Feb 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873958; cv=fail; b=DFGl9RvlcWb9hUkzNsTqFDDaX7db48UKrWkdfgrvGeuqVslkIf6kMdL9MkKsOb40dsizVKwa/cojUdLj0b+A08OxpbO8D/3uhENHnLYV9eto7HSIfeFDB/kNkq5ZWtYOguIIvzBm6+Qr4CQizbGnGlqDulJK30EOH0kDcOw19t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873958; c=relaxed/simple;
	bh=l0/IJsEWpWMnne1DByITXAw4wvzSk0Nc8wVwXFaeuFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7YImQYESQzjLQZKu8vwYd/1sv7DwjQ054VSAw8VJRLOX7gA0wdf9FmV59k0cdEme0r/n7XEoijfjPCzYEyi5GG8waaT3t2oSQLEKQBuAR6WqDd1cy//d8N022NWD+0noWqqfcpHS/HoNf2DpaokoklVSxSkNMw1U0NAOmIU594=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QOutpt5p; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TC7zqnUNq10nzCyEuTytapyjShhHlukMSWlpZujw2DVoxZKZClSrhkqjxBOD7lSGn2Mg+dn/kggOjMXUo2wJfUM2C0zD9PiJCtndfJ25KF8cDVzSzUby2qdfKEXRhusMf77wsX0dY3Iv/Bw9IOyMgKUJiQDg9mmlL3scds/AhkuKnbjTKyYYX/8j+ldJMQNRDnDkdaFVoD816x56XArpJTR4Tah8AtedvItwj4E5ruAC96Y3zWz5SNWci3Xt7Nm4Q/lIonzvPbKtyWPccjz0AZN5am89uKyupCT7Nz7/vy/6/zsU+n4Mz6JhEQPSMHFDBrGjZdtF20gKUgtK3I2v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SiU2R7wNta4ojKu0BQyAnM9/sKwGJT8TnQbQqeCi9A=;
 b=Tk/UaygfSYB+0h9XfBCmU6L6Tx32nk/xLY9RBGnadjGkAqU83TVOyD9in4RnFEqW1TH1y1agQjJ9fdtQf0wWCKuWiZmkuJZRQgEUGMqE+RlviXrrOcb7jaacra0pizEZKQkPQkG5LC0mYlm5vJc9CRVV3q6cIM8PMDhMALYEaf+iWrujm7D92ZmoDuwjOoNjUjE/vqAP/qNvO4PL44xL5Rzvx9Lh8waNbYoX0yiTe4VkEOccw8Tfj07xwwf8pKECjA9fJq96IkqKMQiWJbYtgNp9u17v2NrIFilsBVAioTwQR3t1JhpNIgsS+M+zjNra6zlkVDX3MmlXExfVeNkOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SiU2R7wNta4ojKu0BQyAnM9/sKwGJT8TnQbQqeCi9A=;
 b=QOutpt5pUUl5Ct8odoUPLgjKW28maBw/Ads+AYdujafY7ZAcnRW22cQu5g04b4Z03dw1LkThLrp5U9W7gO9I4K2PGihgw8L8EPLRBz5Hp8rnzRb9/Lz5XEKnkwh/YA8QcuxB5k+iyWZmTL3fnwfJFoNhg8oeNRxNF9vcvWP0HIg=
Received: from PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::9) by
 DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.11; Fri, 2 Feb 2024 11:39:12 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::84) by PH0P220CA0021.outlook.office365.com
 (2603:10b6:510:d3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Fri, 2 Feb 2024 11:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 11:39:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 05:39:11 -0600
Received: from xhdbharathm40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Fri, 2 Feb 2024 05:39:09 -0600
From: Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>
To: <srinivas.kandagatla@linaro.org>, <michal.simek@amd.com>,
	<kalyani.akula@amd.com>, <praveen.teja.kundanala@amd.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 0/4] Add ZynqMP efuse access support
Date: Fri, 2 Feb 2024 17:08:39 +0530
Message-ID: <20240202113843.17999-1-praveen.teja.kundanala@amd.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DM4PR12MB5342:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b73cb3-8422-4788-72a5-08dc23e3936e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sOONRhhtVRya5xOLWrywIopcA6XXcb2Bt59EGdoe46KYOsI8q7sOniL56hejvYuPG5jBC6GkAHg0KdsJRT3o0E4Bz8Mln7uval/j3oMORqkai7eUeqHaVP/QBuv1u+/CTbep+dTccSRsP3enQQnDgMTw95EffsPKwr5YZ1G9i1odIdfRLbbG1sihV1oC0DIxBz6RCbG4LU47nunlnlqQsAre2OS1omYcQ54Y4iyYo7GzWWAHzp9c52izL5DKHta7EwrZNXyhnhVE9jOZMdg/D+e+rDY7jkPe/js7pZk1oC3lnZ7tAhEsoqWP17dd3U0w3/ZHjdn0men2++e0NLYk7tGglLxR26DOVRdHC3CMEp5fKhXAyWguNairY2A3nyE/xIe7oD0PBRG+1QH8Y17KWbBHwwcppUmoKFshlym1Xb92dNn64FGLTOdr8p7V9v+o4su0Dwmv/s/uVB5qeBO3ENpFeqVw/6xteiQS28MFP7YvqObSZZlKN8a3nB3tmnlLoCwxBDK0kfW65RV7JMdJCtATUUvKl7TqXTg+TzI2NVkZJRrXYMbmCWpnQLwMD0YQniInkEKUDOb/YL5eC6TAxtz9W5ZtmTg+2CioYUqJM7usK/bxdKHJjfkamD4b/+GyxZ7ZYXVEWqYk0rABb1dKdAnGvXHNmc2FUovKfe4rmNlDVoHpxAqO67TjrzCq4Xl2XUZLTHLShYAIxYund6TEQCMy4j/GDSosa2wE2uzuxyKuOvrYL4ofMWpRqH10M2Py5rNYjJ52fRSyzJ6PVbv1wDAhFJkHB9hxXzGiw/xkbm8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(83380400001)(103116003)(356005)(86362001)(36756003)(41300700001)(36860700001)(426003)(1076003)(26005)(47076005)(81166007)(336012)(2616005)(82740400003)(6666004)(2906002)(478600001)(70206006)(316002)(110136005)(70586007)(8676002)(5660300002)(4326008)(8936002)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 11:39:11.7180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b73cb3-8422-4788-72a5-08dc23e3936e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342

 - Add ZynqMP efuse firmware API for efuse access
 - zynqmp_nvmem_probe cleanup
 - Add support to read/write ZynqMP efuse memory

The first patch depends on
https://lore.kernel.org/linux-arm-kernel/20231004094116.27128-2-jay.buddhabhatti@amd.com/

---
V3 patch link:
	https://lore.kernel.org/all/20240108052617.32510-1-praveen.teja.kundanala@amd.com/
V4 Changes:
      - Removed [2/3] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml
        as it got applied https://lore.kernel.org/all/170635581622.41421.8980881999042944764.b4-ty@linaro.org/#r
      - Split patches as per comments
---

Praveen Teja Kundanala (4):
  firmware: xilinx: Add ZynqMP efuse access API
  nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup
  nvmem: zynqmp_nvmem: Add support to access efuse
  MAINTAINERS: Add maintainers for ZynqMP NVMEM driver

 MAINTAINERS                          |   8 +
 drivers/firmware/xilinx/zynqmp.c     |  25 ++++
 drivers/nvmem/zynqmp_nvmem.c         | 215 +++++++++++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h |   8 +
 4 files changed, 225 insertions(+), 31 deletions(-)

-- 
2.37.6


