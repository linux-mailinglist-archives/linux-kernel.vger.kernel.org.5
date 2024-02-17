Return-Path: <linux-kernel+bounces-70407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B4859758
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A231F2175C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA56BFD4;
	Sun, 18 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NAq4Y9m2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C66BFB2;
	Sun, 18 Feb 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708265488; cv=fail; b=NweOfJaJbrj5vsz+DO9HbV8Kqnj/cFwT+0LFRSYxW+lKdVGx0HcJEop1GU0veoCulScwf6oBQnapZG7octqfJ7XhCzwwIez8/QFCJhm38lcFF+5klXoK89VoGWJdiQIqya3kZED2QrLD00q7LfQsSezIAe+E5XdkVTWu5NXJ1iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708265488; c=relaxed/simple;
	bh=qXGC6IWdiAXSL7uWTWBAVuOy3niaHpwpv5xK4PeecAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iicy4EAA4tvNRpWhkSf37Ph4J3hI/35x2jwr3gvSqQoMWcmWBERu6yF/vq208Klp6al83o8oCL01NMdf+LcLMeJ8g/4PCoCe210oz8f3H4itz0rzcLQqB189zdzLVeY/83DNeZl7fFmIeeyotH22X7PHV8K8mVwjROylIafoBUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NAq4Y9m2; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmWnQKW1+5eaX+JJUzuK3kZN5rmEaAO8aehl5b6owoibSh85ZLkDnEWe2AaHKOTdNBfPZX/ILeBW73JUaEOnoh8rs7iM3Xm0TAC3kjZrg4hoSLPdRzJt4EAsvwmDEUjvVIyqHr4f5chwCBnwjj1OOn4dhN2GVcSLIoJzc+mulO3AgxBhbAS8dNZxrrlwOouEpzFSQ+IefI7TLRL0yKYktVBQKPaOEzxAkC853bmDKfZjP8t256OlCdzvTtmI7cbwfe7vxJOGgwELImSrgjZROW1dSYNXuJS0fAdtV3rIOGBDDASaTkaUWqSbQuLJRd3KPCBFEcS2tY9o9Xc8R6kyuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTfY1s46Gnn+KoyMlXiHprWrXxBzyGPAZ0w+HqQoTns=;
 b=PM+qpFS4CY7vaXzwA8NQ5HTIIQ5I/L57pcO/Onr2ju/SIMsOFJ6JfMEofymJNdOmhNFsaVL6qnL4Ld5oiFl/vFYnfnS1TptpM25X26jbTK1qGAdvEwHAGdz3gRBx4Sz/Lz6zAWlHOQ8FowFwQLoIdBHokomgZPCoXI83OFC/K7mz/nLAyB8rma6q0dXPpipWm/AoxuoTLnQt6Uj50eK+17LQ25S2oWbVDlhP/rxxAUVh4UDZn+VkExML3uEdjg2DWkqw2wnkaFZXZb63Nik4ubPe/iN/ka80sS6so+EqZxZpUyd5fGGgJP/yTSzknCmU5UcvDP94DQa3t+yLpnzd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTfY1s46Gnn+KoyMlXiHprWrXxBzyGPAZ0w+HqQoTns=;
 b=NAq4Y9m24ElKaoDVxOc8Wuy8JYylhxL6IQlQD5z0aY1YGWy0qHDXOu0Tj6tb2eBFPJA9cnDxAxN2hq4MVW+SOsw2Tf1qH7sgpHItBzb6wzNq62r8Tb+WHltJXP+LeVx4bav7giA6Fie/vfOPjWVPCSk9/LKxdwxfRCSJ+2TFI2E=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by DS0PR12MB6632.namprd12.prod.outlook.com (2603:10b6:8:d0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.16; Sun, 18 Feb 2024 14:11:23 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::d2) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 14:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Sun, 18 Feb 2024 14:11:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 08:11:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()
Date: Fri, 16 Feb 2024 19:41:07 -0600
Message-ID: <20240217014107.113749-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217014107.113749-1-mario.limonciello@amd.com>
References: <20240217014107.113749-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS0PR12MB6632:EE_
X-MS-Office365-Filtering-Correlation-Id: bdec73bd-4fd1-4c7f-9c23-08dc308b7ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	joFhiSvdYdj5b5OjZ9ArK2nnmuPssydBF/WqYpY92hRXBk6ZxaXGJg1GHVYBhAaRpEcS4m0Ro6OBCtxAILMb4Yhbr2V8/mpEasZuqfup3Jz/MGHgYprrLDM4C/uq9FcHzxbAvImU2AGW3zsoFD/rSoGRFJHxp0P90PgHvezuh7MgBBL/7nZMpcXCIyYadzSM0MqrapXAtAIf24uQ/eR8rAquDqFFeA42PsoGCnVcXNdwaRDGLigONcw3zHjhBz9u4b4aDmaqDJbpLasoIdX7zp1jzUi6M8Y3qn0XdC/a7zam09voF+eZUaVtzABDwZ9MEp355vaydVQ85tC0xNGth0MZ2l6/4kNPngDqZAgMxg3E0PBhCs8mCfrLavZEwi+AU5J6QygGhKn03FCxJfbkVTzAppnS7Ft6B6mZD+17FfgFRgjLcNpytPHkoEchhiIkN08DP50VdVRYqeK4F73j86EYzw9z4U1DDhUFgyukJKbdGc22WBmrVwhf+bTnsudG9R+KXqDO0rhsotJII/qehF98dVrLVE7uS4kANbknnqB1FDN6diz5L48cxw2Gg5RuaFp/ynXeGlwKw4kxR0+qRea1d/NTKwyFwFZ0r8u8I0BLZnxoQ74DDLl5ChdbzvZyVR5uxyS2yT+XSfkojJvCrWr2OKPiCNDd0MAebXIakTo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(36860700004)(1800799012)(186009)(451199024)(64100799003)(40470700004)(46966006)(6666004)(54906003)(110136005)(316002)(5660300002)(44832011)(2906002)(4326008)(8936002)(70586007)(70206006)(8676002)(86362001)(41300700001)(7696005)(478600001)(36756003)(2616005)(26005)(1076003)(81166007)(83380400001)(426003)(336012)(16526019)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 14:11:22.8918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdec73bd-4fd1-4c7f-9c23-08dc308b7ca2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6632

amd_pmf_init_smart_pc() calls out to amd_pmf_get_bios_buffer() but
the error handling flow doesn't clean everything up allocated
memory.

As amd_pmf_get_bios_buffer() is only called by amd_pmf_init_smart_pc(),
fold it into the function and add labels to clean up any step that
can fail along the way. Explicitly set everything allocated to NULL as
there are other features that may access some of the same variables.

Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use a single label
 * Move all into amd_pmf_deinit_smart_pc()
 * Set to NULL explicitly
---
 drivers/platform/x86/amd/pmf/tee-if.c | 65 ++++++++++++++++-----------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 1359ab340f7c..4f74de680654 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -338,25 +338,6 @@ static void amd_pmf_remove_pb(struct amd_pmf_dev *dev) {}
 static void amd_pmf_hex_dump_pb(struct amd_pmf_dev *dev) {}
 #endif
 
-static int amd_pmf_get_bios_buffer(struct amd_pmf_dev *dev)
-{
-	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
-	if (!dev->policy_buf)
-		return -ENOMEM;
-
-	dev->policy_base = devm_ioremap(dev->dev, dev->policy_addr, dev->policy_sz);
-	if (!dev->policy_base)
-		return -ENOMEM;
-
-	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
-
-	amd_pmf_hex_dump_pb(dev);
-	if (pb_side_load)
-		amd_pmf_open_pb(dev, dev->dbgfs_dir);
-
-	return amd_pmf_start_policy_engine(dev);
-}
-
 static int amd_pmf_amdtee_ta_match(struct tee_ioctl_version_data *ver, const void *data)
 {
 	return ver->impl_id == TEE_IMPL_ID_AMDTEE;
@@ -455,22 +436,56 @@ int amd_pmf_init_smart_pc(struct amd_pmf_dev *dev)
 		return ret;
 
 	INIT_DELAYED_WORK(&dev->pb_work, amd_pmf_invoke_cmd);
-	amd_pmf_set_dram_addr(dev, true);
-	amd_pmf_get_bios_buffer(dev);
+
+	ret = amd_pmf_set_dram_addr(dev, true);
+	if (ret)
+		goto error;
+
+	dev->policy_base = devm_ioremap(dev->dev, dev->policy_addr, dev->policy_sz);
+	if (!dev->policy_base) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	dev->policy_buf = kzalloc(dev->policy_sz, GFP_KERNEL);
+	if (!dev->policy_buf) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
+
+	amd_pmf_hex_dump_pb(dev);
+	if (pb_side_load)
+		amd_pmf_open_pb(dev, dev->dbgfs_dir);
+
 	dev->prev_data = kzalloc(sizeof(*dev->prev_data), GFP_KERNEL);
 	if (!dev->prev_data)
-		return -ENOMEM;
+		goto error;
 
-	return dev->smart_pc_enabled;
+	ret = amd_pmf_start_policy_engine(dev);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	amd_pmf_deinit_smart_pc(dev);
+
+	return ret;
 }
 
 void amd_pmf_deinit_smart_pc(struct amd_pmf_dev *dev)
 {
-	if (pb_side_load)
+	if (pb_side_load && dev->esbin)
 		amd_pmf_remove_pb(dev);
 
+	cancel_delayed_work_sync(&dev->pb_work);
 	kfree(dev->prev_data);
+	dev->prev_data = NULL;
 	kfree(dev->policy_buf);
-	cancel_delayed_work_sync(&dev->pb_work);
+	dev->policy_buf = NULL;
+	kfree(dev->buf);
+	dev->buf = NULL;
 	amd_pmf_tee_deinit(dev);
 }
-- 
2.34.1


