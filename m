Return-Path: <linux-kernel+bounces-70443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA78597E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEF1F21447
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FCA6EB55;
	Sun, 18 Feb 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVUKXxH7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D041C6A;
	Sun, 18 Feb 2024 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708275292; cv=fail; b=QUyzZ0O75A1z1EiPE3CXeuijQkaMEzOElrywpRGsVwnAhHILKS8L6mSoy+IRN3de8jrn3YDOLtZ8/UA0DBFPre0dx9zZP5H4na2/c38LO2xqseSmAA1peyEll7Rv6LIwWd0hnKcCJlYJY8ja8fl2+okD7cX3RWcU4tSyYks8L4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708275292; c=relaxed/simple;
	bh=bGN/9FVvEIcPiDkQ7svLThQ9qeb4CY8xEfPHuoNBAcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qvcGqGeJ3lY4aPjWRWCPKxOXygbI+ISzm4Ckt70M1QwOPkGwCj4YUOAQFSFFjOxLSsxzHhb4noNcvTDwKS1gOy5wY8Mh8gFb0PHPlLXrpnhAqS2HtutRb/tlLBcNV30RlcSduWwnhjw7fT1vFhxdrH4EZY6SWOxq5fOmHZSSUgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVUKXxH7; arc=fail smtp.client-ip=40.107.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS2t2nJAgmnSS17cbbHUGCdPDLh3r3b/G1764GhdSILDZOHN1KKUmxv1gel5twx0uydNzDGWwpsfzsWmw/0/A69MERnhHVyUd8obZufsS2cOGsF5+ocOxkXyqqGJ8eddp+YRcbcuK2AgXzudpGjlnPtzvvmM+CIr12P61lWEr4agtWmkdbrKaZ26apTqsOvyBFeJAUqS8RssBmti5bQX1dQeUkLBwC3GZ/QfPCQB1QzDHrYypkyre5l7KmNvlpdp0MzpWCN29pJKavAUy/l1Ic9mGJMHGUcDzqIck9BAhJt3bjFnF01O43YHz5AujGK+ngyjqWnkHzX3GL+NGnhGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CufwQ1S1YYzsvYoDuQshiEChTTu794JZnTdj5Ji+/fE=;
 b=QVRbcQhCpShG9ynrGelpWMEdl81s+yuyNERsgkTnLuw4KWjVLST4Tb/4yi8kpp8NZ8By2QVEzJx/XKHfEfQcqawAI0wYaIiz8WmLMLRNQzFyVBlgSGy3DHImExQ6KM2sis85k3qA8BN6K9WfY+Drss1AKr4HpQ/4w72IJ5UKwFL0c9K56fspgFEL03xsP+TUUUULk8g6IIuu0awh+o0beV/nGHqEf9NysRe74Sr2rpAxWforTullrSYh55PS4lPtIqpHQ/MPTpBfCVu/FVLRzsiC14BF717zcRa9l8qUEPS2gcARyhcKzwXoAkXuC80/UEFXUzfxwMH3sGJJLIr3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CufwQ1S1YYzsvYoDuQshiEChTTu794JZnTdj5Ji+/fE=;
 b=aVUKXxH7po/+Ei+JrwZ7aLZX/Bvb7m0X+WZp8GGz16dVcKBXQveUONNgPcojbZKvX3fUrnCrVezWXbwEPeLtmEF/G/iQzk7jJjWxSvzbk5Xx5LkYLg47rDnbOmcCWBkBVWvDE5NIGDXgmtV/IrnkhEoHOJr21sk/ZjgASwOo0CQ=
Received: from PA7P264CA0368.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:37c::16)
 by MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Sun, 18 Feb
 2024 16:54:48 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10a6:102:37c:cafe::3c) by PA7P264CA0368.outlook.office365.com
 (2603:10a6:102:37c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Sun, 18 Feb 2024 16:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 16:54:46 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 10:54:45 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86/amd/pmf: Fix a potential race with policy binary sideload
Date: Fri, 16 Feb 2024 19:56:42 -0600
Message-ID: <20240217015642.113806-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b594b9-760b-48f0-c983-08dc30a24fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+nuEm3IxakJotysx9AD5pL9HvVO3gpST/UF4dRMbIW/doTjmJy3o0knbZvnmEgfix1v32zea5CDkpnJvubs27ld18+ehIgWcbuqW0dppKcWO+Y96fvlns1WVdDpayKHWWcW3TEcP4Yipno+OGVroKExl2dh/E7Db7lj/11rJogcTmEquantrWkAIwaP2dow67/vHkl1fppEqvN+zFqtdl4AyspyGrXHyY4Toy1/olcpVHE0tVnhyhW75051amxSqmD447NLDZ7wTjtDatIaObOkhs2e3CpGTVDBRxumfnRLsJM0zdtBOdzNBCSShf1d3NFXZg9iKXg4fF5HTSwqMcrYnrFFzgR803BUucNKu8b67KADt31QMmYMgY9ZXzZC2cISG9R9VjO7D+ZwklHQWFR/54h5EpAbOB4HmnMIkCqeOeo7U/PpP87v4Jt0ej+fup9G6AG45bBrHv4mifS3eOwIxb2auiwXbwlcXXu1olltFgED1ADEqVN7DZaII7/xo7Q+ESzFs+44+1wBTuJge61JLRyiBn0VYtoCQhlSRjz8/7CrK/BFhLUw/BfDLXFD0X+wzIwj26tXuMcrA6SarkmLAg93XZ4xQHkumQ8T90Mj2gBztxyHS7Qc2r6lE9qkoxkuoIq/1ZYHfnZF3GCO26Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(36860700004)(82310400011)(186009)(451199024)(40470700004)(46966006)(54906003)(110136005)(316002)(41300700001)(6666004)(2906002)(70206006)(70586007)(5660300002)(4326008)(8676002)(8936002)(83380400001)(86362001)(44832011)(966005)(478600001)(26005)(7696005)(36756003)(356005)(336012)(426003)(1076003)(16526019)(2616005)(82740400003)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 16:54:46.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b594b9-760b-48f0-c983-08dc30a24fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335

The debugfs `update_policy` file is created before
amd_pmf_start_policy_engine() has completed, and thus there could be
a possible (albeit unlikely) race between sideloading a policy and the
BIOS policy getting setup.

Move the debugfs file creation after all BIOS policy is setup.

Fixes: 10817f28e533 ("platform/x86/amd/pmf: Add capability to sideload of policy binary")
Reported-by: Hans de Goede <hdegoede@redhat.com>
Closes: https://lore.kernel.org/platform-driver-x86/15df7d02-b0aa-457a-954a-9d280a592843@redhat.com/T/#m2c445f135e5ef9b53184be7fc9df84e15f89d4d9
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 4f74de680654..8527dca9cf56 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -456,8 +456,6 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
 
 	amd_pmf_hex_dump_pb(dev);
-	if (pb_side_load)
-		amd_pmf_open_pb(dev, dev->dbgfs_dir);
 
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data)
@@ -467,6 +465,9 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 	if (ret)
 		goto error;
 
+	if (pb_side_load)
+		amd_pmf_open_pb(dev, dev->dbgfs_dir);
+
 	return 0;
 
 error:
-- 
2.34.1


