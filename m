Return-Path: <linux-kernel+bounces-150465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950548A9FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216C31F23874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295C816F905;
	Thu, 18 Apr 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IftW9PaK"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AAF4D9E8;
	Thu, 18 Apr 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456888; cv=fail; b=a424OTNbSOXNPhi+2Fng1InjOoSxlFlgrwFujBccjED7OyuuhDQEZIJX5RNmkeDJcXCPiH6XWJQkp3cRpT8ngMXknY38QMzYbbvCsoQpK3iNygzpJ0p/oay5l6woio6Rb7UnkjttB+eIGYdVpG9wvJG8+vVP/1XybcJ9S2WRpIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456888; c=relaxed/simple;
	bh=TUciyQpOYnLcDtkTgqIqYDKDduIoot83RCDJYKj06oI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qe5Onm++mg0hLQk6Td/zc/IA9DwCz0yt7GsJ4pmx3UwO6rZqLi5O/u1GKW28M5DxArfEvDmizEpueDipibqjsF92N1rb9Cd/kp5zIbmoKkNTzWZvGRboHtIIVOT4WW7c+K6lw+tbdBEwcWeMJFRKtMamLdU3PVh1lGMcEvfV1Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IftW9PaK; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDNLPJCia3tjzDcEkXYeTpjZmOi15iPMBP9Qgky438/p8TLxXpa9Ntwc3SULFgzpImsYD3Uldn2T7vchrfK3cfZVcBtTGkS3pukMPp+UypmmblJAJRTDk8dIX2aWsRSQgHp62/fy++3sA9L/fqG8eniN79Wib6JarvUrf1/I4HOqtWiXN/YHSb4hcr26gphsh/9YMNWkP71wWTAy7f6iH8KKZOG1aNVA2xI7ZDefihIp3qAKN3C+oUE3E7I7KkwflOBW6FRUSyFmWvMrFjACulHx1F99qyv6WjrqzGGOE4WzUhFf1LbwL4P+75Xy8w0sZeWZLcdgIQ+FUqDKOI5B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbKFlH63eEY8jggRoPQJSivDupPMuNudnjwnp9Uw4T0=;
 b=oen5zqBnDvJHshVR7WWpseWZJ65L69NVSercDIeqkhES/oB+GKp4dIL8elDUZ8UWl0+Dqvl4HxHbDnhtXlOslOEgzF9POCXu3H/CnoU94v9ucjjdEeWDllqq12wN3PY3meDUOjuOrJU1BEG6YZniiTnAsJmphIfJ4kXQyhd91BEZC7S6wQzdd1AXTOPYV1EfnQKMUlMatNqYixq990BUDzpInHTcSU1/11LYckQD6qzTqbgO7CbbR4C8cPZSDAwx83Z7PAecl+UC9t7qDoqQOqgZXH7XkYyZsScMr2B9dx81pi6f4EMiHH3i7K8aI2/OKo1s9np/m5tGtkHrKjuZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbKFlH63eEY8jggRoPQJSivDupPMuNudnjwnp9Uw4T0=;
 b=IftW9PaKZF3SKPCvHyC/oo9b5QpCTPKeTEraRuTRFPTm2Db0wpNWCNmHzQ1Pbi2RH1JQNHo9oKQVfH9WNiZY1jT4F6XdgHrESqHXD5GtnUE2qBgMSjeK7WiOmuaJxO3/ahGJxhmWbHE7lCzBkACHHUECyGXpXJU43GieBU3jJ4I=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 18 Apr
 2024 16:14:44 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::a6) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.23 via Frontend
 Transport; Thu, 18 Apr 2024 16:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 16:14:44 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 11:14:43 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v3 0/4] RAS: ATL: DF 4.5 NP2 Denormalization
Date: Thu, 18 Apr 2024 16:14:13 +0000
Message-ID: <20240418161417.6091-1-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b447393-b62f-496f-e364-08dc5fc2a90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	78p1+hUWG4Qp4M448m7BrBuMjhQF7z6uQMPuETj/wb5Sxe1q7pGSDWbignjG8/zGjMbo1DXHxeL4/fvIhwmgec6FjX0MTE3wACdQHHg6BF6jSfHUQ/of2MMgSPn1PH63zSKj2vHdI0NMHO8OAJ2DYiiM5zDpUfobExTEIcYaOozOjxOzquWFps3wmyfteaawSeA+XUlaYL7Gd4FAsdTnyydZuIXrUNlWOPXAMhWMgfNmn1VKftY/p3qgw/gPVd4wfmWxfp9nCpR8bV0oB1FIni1z4TFXII0s1d7s5LojRwUnTt+xS7nK1pWF8P1UMaHHTLqr5obI88cVo3IjJ2e8L8XY+Dg4PQlhCLnOlHwuOxBgFhoa+dzAuqRkfdWmudioOQxUiXxr/OxWxeRSkblGjvdHieiyaGttrul2bQQooTmoCffy8K3F9l8oAH6OcNBVoHdEDTIPm7EjLg11bJEIIwzAgFUuwlzTUZEQbLP3KGguM22u0r7wiGpCW1XtyCGP2ONethkYOId0SsMMCzQM9efu5A7+18ZpqPCAybYQFFXzAb8aXlJJ2LQlrnD8M0zxW7Y8/S402fQUcxeNhq0kYxd/eZ0609bXZPiG0xem5syD6+zv4CgwEe2Aj+kGIOZ4qIoyr5Fk0VfcapwwiY/siqaeb0NxEPFovSHfHS9GFTlB4XMW5l0vpJ3EFR+UpSsmeWMYX9Pncpe/Tf/cmuXDRl/lhnheRpZRDwJbUV4vGKbBRnaeNJc2r+y/Xvj23vTb
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:14:44.3787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b447393-b62f-496f-e364-08dc5fc2a90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

Implement non-power-of-two denormalization for Data Fabric 4.5 in the
AMD address translation library.

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Base commit: bd17b7c34fadef645becde1245b9394f69f31702
(origin/edac-amd-atl) 

v2:
  - Fix compilation error.
  - Make remove_base_and_hole the inverse of add_base_and_hole.
  - Move all map validation checks to validate_address_map at the
    beginning
    of translation
v3:
  - Fix bug where the legacy hole was not getting removed properly.
  - Minor rework of functions for matching the normalized address and
    logical cs fabric id.

John Allen (4):
  RAS/AMD/ATL: Read DRAM hole base early
  RAS/AMD/ATL: Expand helpers for adding and removing base and hole
  RAS/AMD/ATL: Validate address map when information is gathered
  RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization

 drivers/ras/amd/atl/core.c        |  48 +--
 drivers/ras/amd/atl/dehash.c      |  43 ---
 drivers/ras/amd/atl/denormalize.c | 523 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  45 +++
 drivers/ras/amd/atl/map.c         | 105 ++++++
 drivers/ras/amd/atl/system.c      |  21 ++
 6 files changed, 719 insertions(+), 66 deletions(-)

-- 
2.34.1


