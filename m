Return-Path: <linux-kernel+bounces-16056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B7B82378B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A635E282DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB031EB37;
	Wed,  3 Jan 2024 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YczjQzQh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C971DDE2;
	Wed,  3 Jan 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csxk1TsGY1S/zerReXS1goHXwSAvaQwP3tr8KlVlpH8Q5r6s9YkoSzv0S5bJ3G+ZozCft6xYG2ARTU1roWMIE8MHuaMZ/u2NtzSUXRQAWHIBJtXtznxBehnEY0OJZOt81HEfxoAMr0KVhggYAnZYDsmRjLEYudYzilYJ4mRKPMlx8oxFqDgGkzf45/k+3Kb+v3xldqfK5UJKH/dxzRXYxs1CkdGRarAgn+8kx2v7rIAsMpWZLQnSG+y6lQUtb+gofHJyoM1toM8ljm2HvWSHw36zl2jR84G0qn/MmVFDczFHRik5ktWHizhO0Ov9CS/BQuP1hHIfZXFLqbJt4Hj7RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wKfNZqTs6xaT4BpSnhYNxtHxjHm8kPb8MoW/KDKyuA=;
 b=BvMJ7cWW65tUmM0u/h6YsCnaBATa4KgWNKaOqwx/4pbin957YbV6xBeFr1IQq2lZ72xXv096+UgGKFQbEHABarLNL61YW/+PV0PGXvzChRut5UYDP2s7vooBudjaNGIxpsyFnXmL/msuRggKSEU3F0kXOXfspwumKOy6/3qGSZESs6or3OWE159ie5WT36TtBRcBkV6rxcIMU/x2B469oNv7dvlhr5yqFVA52hJAMYjKkGjitxwIfxkW9evVQ2d3vEwOhLvzv3OlxuZg/qeibhPemWFsa4kYb7dTsv2DSWlZzfWUuHp1/4q3hEXW+pbtar93+GQGXRHbe1sHZt4QtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wKfNZqTs6xaT4BpSnhYNxtHxjHm8kPb8MoW/KDKyuA=;
 b=YczjQzQh7GJNTgQwb+Llbc/jxBwQzgpbSP+ikRwBPS1RLq2f6grAlAL2OdG8poMUAdr6p1kKINE9ArDZsk3HVeOwk3Nv9Cium64rh/wrmElVClyC3SnQQbbrJsm0iidsHXBMhhrU8ZBj052plN51USL2miMX/Xau4SaR1JvfoSo=
Received: from BY5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:1e0::16)
 by BL3PR12MB6545.namprd12.prod.outlook.com (2603:10b6:208:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 22:12:07 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::19) by BY5PR03CA0006.outlook.office365.com
 (2603:10b6:a03:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Wed, 3 Jan 2024 22:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 22:12:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 16:12:01 -0600
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 3 Jan 2024 16:12:01 -0600
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Tanmay Shah" <tanmay.shah@amd.com>, Tarak Reddy <tarak.reddy@amd.com>
Subject: [PATCH v4 2/2] remoteproc: enhance rproc_put() for clusters
Date: Wed, 3 Jan 2024 14:11:25 -0800
Message-ID: <20240103221124.3063683-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240103221124.3063683-1-tanmay.shah@amd.com>
References: <20240103221124.3063683-1-tanmay.shah@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|BL3PR12MB6545:EE_
X-MS-Office365-Filtering-Correlation-Id: e8436b88-ccbb-4837-914d-08dc0ca905f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S9dBPXlGcq/TNvii/Zpq3gNQq5HHsB2dAxtBa8GJ1iT41ZQqoay5JTKfKyw5JwWz/1zILt8TwCw0OT/agb2GglxkBnGTtby1DKwN9P69ImZizBfUhOcQ2nxe9TlXxgEEkTImDWAMDHoorKgSWJBGv9+Y92CNKMNkcdK8C8vEmPTKrN3U2FwkYGdQITa0S84I2Ravz+I6SSpNB1aaqavCt2f8GqXvVP0J4gye3SLUhKcr49hcMCg4jpMnTTNMlCVvakXiBdkcmbFWVCLexOt8EnGL0SVHcJwWlJXv2ZpfFAj1mF9aq1JdQZxobIUwn4M9ObRmreBx853/dh/b72NDtINvt2/rRA7ZOOkcGXIMU5/32OHGhwsHgjVEy0b+6dBkeZ4Gnr328bZGrwvokfM/f/r2ztluoziGaTcUZotO7an+tNnc7LIWL/1i47QhZ0emvKXP1fivdoMUNc1+fzVQxOJJ61kS7cNXAE3BqmCulDPFNIsfjqFCTCiUYmbZazzIszkf5ADi7RM9uRfFcXMSbpMCmB65EuGKCWhezsdobHxvs3QpwS0rD0lY4uTAQ95jWNlkhhbsV1ZxnAdxELP3lLRmWo94VgN8RRvHqJfxYhBFn9OA4X29ckhIhtSsrdtdGPYcT/CKhALMU3myWeB606Kr6tyP8NGAybyJkwVsl1+gLVkAqFWgodoTj63f1kurV4kGSSlNDdqAM9e8HQEVPN/hN3qlhsl4KYfesbPyY+awAiroggZKt74XGJxv3bHeARDpBm5wiiVEL93jyK7mWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36840700001)(40470700004)(46966006)(86362001)(36756003)(356005)(81166007)(478600001)(6666004)(70206006)(70586007)(110136005)(54906003)(336012)(26005)(1076003)(2616005)(426003)(44832011)(4744005)(2906002)(5660300002)(8676002)(8936002)(316002)(4326008)(36860700001)(82740400003)(40480700001)(83380400001)(40460700003)(47076005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:12:06.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8436b88-ccbb-4837-914d-08dc0ca905f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6545

This patch enhances rproc_put() to support remoteproc clusters
with multiple child nodes as in rproc_get_by_phandle().

Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0b3b34085e2f..f276956f2c5c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2554,7 +2554,11 @@ EXPORT_SYMBOL(rproc_free);
  */
 void rproc_put(struct rproc *rproc)
 {
-	module_put(rproc->dev.parent->driver->owner);
+	if (rproc->dev.parent->driver)
+		module_put(rproc->dev.parent->driver->owner);
+	else
+		module_put(rproc->dev.parent->parent->driver->owner);
+
 	put_device(&rproc->dev);
 }
 EXPORT_SYMBOL(rproc_put);
-- 
2.25.1


