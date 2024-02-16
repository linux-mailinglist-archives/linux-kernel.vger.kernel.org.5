Return-Path: <linux-kernel+bounces-68928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0B858206
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5FB1F2397B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81112F589;
	Fri, 16 Feb 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SQRkS0/a"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C5E433D3;
	Fri, 16 Feb 2024 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708099158; cv=fail; b=DguwAXNo64oed14RU0vSOsfCB3nKoSKTgukpey56hZE2kWrFiogpsvd1VKWM8pRVZ+wAF3EFUQBSgqfju2tsmzzsx9zysV8dlaXfA4qxGVCozd8KNcLPJhuC2s6SYhQYkL/CqVL4cyVWPGpPYUn8KVa2xuiRwMkUNpUFldlGSC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708099158; c=relaxed/simple;
	bh=BwyY5CpgsHll42uAEgD3pbh+76IMM+pnb1zKmpmJJA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJkfcEi34CuwNfCcIkTrnJbmZAqOHL1eA8Q1ySPEmavDQO6BFyo5DXsZAgQ2XNDoD5E5VMXn8wucIZ9xHaUkavY8DXSxB57aj3IGRlsupimYjc8o3LTCBFqOVK0AtL2A1Dhx3fTW4Wl0qRvlp23TICyRecI34sVha3+fpuaXgCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SQRkS0/a; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM+U8P3N/XjrNmUr2GwC4DgsZsenBzQsCANwSBsCtWQQnQJ3azFmWnsp/Za2JIxcRYhJnPTaX45QeJd3Xn/kaiDJb4Jhi/JGAzrkT4ixT+QRFhgGSJM59XBnsSfXFvhkQd0nj2vXSQNkzJpvSE1gKgwrd/73Xn881HlL2/7Z1GPO7Ntv3eUtkysGTKaaNDYkAnVOz78LtQby1XrRHSaWOF/e9tfhNZfUflKai7RymjLfaDdG2+m4E9sQ909T/qycqV+23KcEYJmCQOEF19TO3BpswzVcqiPJ0Eus6M7PYimigN5i9Xf4FCk3hFlQ2Luft7BVxrpHGIMJmeAQpPO19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Isr7T+k8kM7lUwLO0OQkG4NrSLa+LGoP/hVDJWPG5Yw=;
 b=JrAiIj4XCaLHA+9+WQtE2TY+XWexipwrvAUkNwSBCxKzZEH8x/lOd++wV61dk1sn5sSL7L5XXXqICfF6ejPU3DV8GUVxEoAlKM/+f+bq2sc9MYRGPNAnw52U+hPUgQkmnmK12126kdlorKw22k0588h6uuuXnB5mj6iAfqfUosg+UlCfJACTe6ueY50RKincxjeBCaMdXw61Rta2LeroTsWeB2dJaJqzQuUq8WteR30D6g9NMXkzkH4zB/2N4Y6wY9tnu7jfbVyiYv0pBFg37fMKQYwMjJ1QhPjO2RwCWbGD14TjmCuzjTB2dCTR0oSwldjFlfotm+9OVlRHyjx+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Isr7T+k8kM7lUwLO0OQkG4NrSLa+LGoP/hVDJWPG5Yw=;
 b=SQRkS0/aWxLLxW6sUq1aM7+y5MgY1qbZBDvXXWlJ7gDXR+Kg8yPOK9FPBSdNlnG2WCzNyAwDILVXWRHVnl5zIPO3FxFQRkZP3zpYTw8qn3rHCf9yp+8c4obL9QqvqvoaD/XLVRkx+Uuaoy/o/bQbcrfF1l/f4JNDXNQKsBXTy+E=
Received: from SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::10)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 15:59:14 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2d0:cafe::2d) by SA1P222CA0035.outlook.office365.com
 (2603:10b6:806:2d0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 15:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:59:14 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:59:11 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Robert Richter
	<rrichter@amd.com>
Subject: [PATCH v4 0/3] CDAT updates and fixes
Date: Fri, 16 Feb 2024 16:58:41 +0100
Message-ID: <20240216155844.406996-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: f85a94df-1125-4789-6af9-08dc2f0838e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+gBRJse/uPC6nvZBc23brqRpuGker4BqwH5e2clm13Wi7JA6IYZVrDpUIZWdnmLXuBLXAhCH6N3IS3ftFiVuHHPrE7Kc4zeJWGTQihwLZuDsYXsfnQ5ve9/sZzkF9x64K0y8FRSo4kDsPOExcxBmcHghPtZ3Vhw0Qi3a5uyrRoAp9ZEvkWTIdehIHURGZ6ErBGHhh8rsUzQH/n9B/vtEOuOEJOrmYHM8tiy8ILMKixzL6D8xKFnIm8v0HLp199XVZp7cNXjzVi5LycdoMGvEbgBv/xyp0Uc6L7/tBT4CO1U79m5/Q2smXAqTMwDBpRMC1pD1LAo9xRAUs6pNQTUNt8u1kktRqdvILQ+Oy/7n+YcpHQqq/n01E3obUZtM7FpT8awnqZAhw/ib9zUSR5C/q0sjVmNfxPgBifAa0lsO4wz1TjGR0MgQqSuNg37VTIjnct7zyXwoc4h3ak0Jok00nnHr5p5anpRIWdPSyE0BU2HlS6xbGVzQmVbD91d01agGxazTXwTvqdzjLqR8g2u8rIQmqjkK7drZOntTXih0xrP4jR0FUtlSDpKbJjCoHk/uF44Twe/Mlml9uQ4ZWlmeh3dJ9k/yW3zuFFTjac42QLBi3p5wGBsYTSDKU24vV8ZwJlIRIJC5c0ymj30fHq6CdZ+f0dMiZo1rJOrMFxr+QSI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(36860700004)(64100799003)(186009)(40470700004)(46966006)(8936002)(7416002)(4326008)(8676002)(5660300002)(70586007)(70206006)(2906002)(15650500001)(83380400001)(26005)(336012)(16526019)(426003)(81166007)(356005)(82740400003)(36756003)(316002)(54906003)(6666004)(110136005)(1076003)(2616005)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:59:14.0076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f85a94df-1125-4789-6af9-08dc2f0838e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217

Some CDAT related updates and fixes. Patch #3 does not depend on the
previous patches and could be applied separately.

Changelog:

v4 (Jonathan's review comments):
 * updated the description of cdat_doe_rsp and DOE CDAT entries
 * changed cast in cxl_cdat_read_table() to (union cdat_data *)
 * modified checks around CDAT entry length
 * added a check to warn about a malformed CDAT table length

v3 (Jonathan's review comments):
 * added Reviewed-by tags
 * made entry_handle unsigned
 * updated patch decriptions for #2 and #3
 * removed zero-sized arrays, use variable size arrays as data buffer,
   introduced union cdat_data for parsing CDAT structs

v2:
 * rebased onto cxl/next (e16bf7e015d7)
 * renamed struct cdat_doe to struct cdat_doe_rsp and also local pointers
   accordingly to buf/rsp.
 * added comment that the CDAT table has space for a DOE header at the
   beginning
 * use DECLARE_FLEX_ARRAY() macro in struct cdat_doe_rsp
 * moved the rename to doe_mb variable into separate patch
 * added Reviewed-by tag
 * added patch: lib/firmware_table: Provide buffer length argument to cdat_table_parse()

Robert Richter (3):
  cxl/pci: Rename DOE mailbox handle to doe_mb
  cxl/pci: Get rid of pointer arithmetic reading CDAT table
  lib/firmware_table: Provide buffer length argument to
    cdat_table_parse()

 drivers/acpi/tables.c    |  2 +-
 drivers/cxl/core/cdat.c  |  6 +--
 drivers/cxl/core/pci.c   | 99 ++++++++++++++++++++++------------------
 drivers/cxl/cxlpci.h     | 24 ++++++++++
 include/linux/fw_table.h |  4 +-
 lib/fw_table.c           | 15 ++++--
 6 files changed, 96 insertions(+), 54 deletions(-)


base-commit: 6be99530c92c6b8ff7a01903edc42393575ad63b
-- 
2.39.2


