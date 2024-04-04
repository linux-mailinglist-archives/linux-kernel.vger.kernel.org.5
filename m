Return-Path: <linux-kernel+bounces-131685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A764898ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47A5B2C624
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0656446;
	Thu,  4 Apr 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Z9ugekc"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DCD272;
	Thu,  4 Apr 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243664; cv=fail; b=pOZwndj9VW/O9aFq9tpHM14MaWALxXUaZh3zeSNUOY1VonHju5xXOlJ7PW4+/TPLcZ2PEmvZV2dRcVNn9248OstGN+H8DSwetkdXa+XGb1F75dSi6EJ/zqzmgV5vmGKILsOlpXG1ts70sLGh0tOTmpRuncx/mTChYNyOC2lTTSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243664; c=relaxed/simple;
	bh=/EP3L9ZQrfR5BoZ0mW0RH3gjI1qNUqU0EpAPVcx4mVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TF9N7ks7naeRZYmUjOdpe8n6pTzy5F63F4LsmDzTI4PV09Z0yiifijZatcnLiwNV4Oc4/4tDztD0WlCghsy7SKVTLVxhcBEZlx/jyVpNPWgahkZNjVYUKypboZrUcc0W0uWGoApHK6SAGZIcUCpn8re0HwPDaym7cUjo84wu+dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Z9ugekc; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFXOun8tYCN8ycsS7+u/xuU/ajzPwftA7lPptMLOePI8Rr7jRPlpCl3ZL1yngUhc/pny/vtYsUM6732KvRbdsnh3T+UPgNYSakx3rt5Wnf8iBPszjx3cbWQJhFAUe6GrhMJJ3HrXcRQvJoAaGY1Hm21lGIHemvtAposv1Azy2XpNVAz5m6q/Y1JaJpJpUphJYlk7Tnnll6jnDU2Jn1AbkUJ7ZonEtul4ua0qWM58w7OOVkuZCspSm/Wuw2NRetB40WonDgtCv2p/DUNRUnzOyXPxq4uPTILApzjS/58c2E0t0iNmkK4RZlmCJabASYHNS1s7Sx5iNninYrYL0CLNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N/xqU2y2DJDHQAvVglIHzswbKspoX7K7lVTH8OjvBE=;
 b=R4og77B2M/ZtVTWosJj2YmbgGDpxJQSpWMsvYzALhjq00vL2AUKGE7luL/PLuHmAyCiwv7Ad732fSydzZEfnCScwv54cGm6h31KThy4iq3xci1wwC2TIRsJ6sFYfi6jatE9tau5X5+0kuXVUqn1dGfGYidnBJNlQR0jEak3HDOqHF22jbRk06j6TPr3v3+5Ha+6a1xDELuQ08V5mnxYOGTVOevdrfxknj5Z8+ltn3oS1sFkqp5HyuUBepAioXBbEV+KZj5N7uGHIMpM9bgeZ2J7Sk4uI8jazJ3jMJJnnlBGwwKfDx6um/PyjSLXXT1jYLg8bYegXmXoPCaXXCYBGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N/xqU2y2DJDHQAvVglIHzswbKspoX7K7lVTH8OjvBE=;
 b=0Z9ugekczQywcVvjFwTFQr9lZt9stXKYD8sEWwMpAPxHJcWV7MVZyu+ESmeS1HEBXzm3U+phIw3lmmgImyIWpKC8PLkeKEHhydTf9ZkruA+EsDbbTX4i1QehRXp/kmr0ECElEatWgi5BCx8Cp0QZHOzPOmzFpoSkYK23qeTKVJw=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by SA1PR12MB8163.namprd12.prod.outlook.com (2603:10b6:806:332::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:19 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::e8) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:19 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 00/16] MCA Updates
Date: Thu, 4 Apr 2024 10:13:43 -0500
Message-ID: <20240404151359.47970-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|SA1PR12MB8163:EE_
X-MS-Office365-Filtering-Correlation-Id: f995a50d-50d2-44d5-c6d1-08dc54b9e6aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S9yXU+JYDk1pnfdOwncni5k1AVCfQ2O+dp2gJ95kwd/+Wg7hsqW0pQH8r3BKzerykqWzkwHdSsN7rtC0IHInkt6jqM5bHf3FKdl3cs1SoA8Agl4vl3PaXzmH3OltoFeH+WcbZQ9NWEkg5a+UcC9rB/AAV5HDOEUN9pcmNpVOclDvS+ILl6mR5tUWRprWOyzTyQBwRQRJvso05OFhFa1p/AEMEXYlm3P9TmXpQk3GwFdVqS0I3eGdfTx7/6nlaLzoISHoqq6QAOuYmNIu+0pPfzKxETaul9ndlKk6xiSNXa3DU/3kd7bCMzT+2pL37GqqDs/OhmV61J1GZ82DhipupK5oB2Zw2tzykjdDwSX1bjWutUto447QzOeRMLUH8e95MWmjvjfpCYczTmW0tmTCAUv4z8v1HxA1B+WtRtyPhZ83b6yc713PDS12JHzI7gLfdkxGHjBUXX9BZx/VbxkvpZGTJo96S1jrVv2xgKKw00fQUwT65SyQY76t27lxUxWz7ZWFSmdklZ77jdkScclWB8gylLlV8K7RhTqJjnindSHNQbQ/zarEx6fxLhb4kXCIqfQV9FiiqeqQg9BgX8OTVewsiJArckWCIk4jFIEWVk12XwS3vfFHzNiuCo5XY8Xx38skV8E6jiikTlqGIC6Dy/s3wHPb26zd2jSX8nbKFydgM6CSzozEdyCmMl34OIMnK4FFdOPt7BgNs2sju7l0Cg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:19.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f995a50d-50d2-44d5-c6d1-08dc54b9e6aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8163

Hi all,

This set is a collection of logically independent updates that make
changes to common code. I've collected them to resolve conflicts and
ordering. Furthermore, this is the first half of a larger set. The
second half is focused on refactoring the AMD MCA Thresholding feature
support. So I decided to leave out the second half for now. The second
part will include AMD interrupt storm handling support on top of the
refactored code. Please see the link below for a work-in-progress branch
with the remaining changes.

Patches 1-2 deal with BERT MCA decode and preemption.

Patches 3-8 are general refactoring in preparation for later patches in
this set and the second planned set. The overall theme is to simplify
the AMD MCA init flow and to remove unnecessary data caching in per-CPU
variables. The init flow refactor will be completed in the second patch
set, since much of the cached data is used to set up MCA Thresholding.

Patches 9-10 unify the AMD THR and DFR interrupt handlers with MCA
polling.

Patch 11 is a small cleanup for the MCA Thresholding init path.

Patch 12 adds support for a new Corrected Error Interrupt on Scalable
MCA systems.

Patches 13-16 add support for new Scalable MCA registers and FRU Text
decoding feature.

Thanks,
Yazen

Branch for this set:
https://github.com/AMDESE/linux/tree/mca-updates-v2

Branch for remaining changes (work-in-progrss):
https://github.com/AMDESE/linux/tree/wip-mca

Link:
https://lkml.kernel.org/r/20231118193248.1296798-1-yazen.ghannam@amd.com

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (14):
  x86/mce: Define mce_setup() helpers for common and per-CPU fields
  x86/mce: Use mce_setup() helpers for apei_smca_report_x86_error()
  x86/mce/amd: Use fixed bank number for quirks
  x86/mce/amd: Look up bank type by IPID
  x86/mce/amd: Clean up SMCA configuration
  x86/mce/amd: Prep DFR handler before enabling banks
  x86/mce/amd: Simplify DFR handler setup
  x86/mce/amd: Clean up enable_deferred_error_interrupt()
  x86/mce: Unify AMD THR handler with MCA Polling
  x86/mce: Unify AMD DFR handler with MCA Polling
  x86/mce: Skip AMD threshold init if no threshold banks found
  x86/mce/amd: Support SMCA Corrected Error Interrupt
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  24 +-
 arch/x86/kernel/cpu/mce/amd.c           | 461 ++++++++++++++----------
 arch/x86/kernel/cpu/mce/apei.c          | 124 +++++--
 arch/x86/kernel/cpu/mce/core.c          | 253 ++++++++-----
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +-
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |  13 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   3 +-
 drivers/edac/amd64_edac.c               |   2 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |  29 +-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   4 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   3 +-
 include/trace/events/mce.h              |  51 +--
 21 files changed, 620 insertions(+), 387 deletions(-)


base-commit: f382ab1037497f49d290ce6ceb9cdb10b186682e
-- 
2.34.1


