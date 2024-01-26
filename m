Return-Path: <linux-kernel+bounces-40454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658283E0B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4FF1F2564E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FC821116;
	Fri, 26 Jan 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VYosjYss"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E12208D4;
	Fri, 26 Jan 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290996; cv=fail; b=rJtx8qzqn7TjoExJ4s+NkCc6w+MXuqysOQd54z0Ytz3s5cgo9brOvQFNUzNyBrDrzGjwXB7+YtNPqM8CDVaNP+v3HYKw87t4jNola2FEdxUSwVUHFe7uL4djbIzf9+6Tmv3KkGe0lHP/GEK4KW5EYLB8frzlfPSTVm4oiy0M57Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290996; c=relaxed/simple;
	bh=ZItyvVlvA6t9o/lw/UYWGe6vLQzXEpEpp3YXxdELk3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqAfV6Q8QOOCa9hMiJL5sNO+49uYZ8lSvKUJPVZEr4RvFIx6sA1O9Z129izF/aI1YywjJo6V0CmDJErpLrYU2vaGlCk536crFqyfZkghkrXaitW0Sd7pf8Lyao3RxM3qQAPaHS33Re9qx/1UQ1nYptlD95NedW1M3OEomlLaYsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VYosjYss; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilkg6YoyEC5KgueA25drsjIS1kC9FVYG12Chcfj8YrJ6drUV7SCZj2tyJ3sFQ9mCZmUJst0FUu0PAAye4whKmnbnPaaALgaYuZEMYZM/x97w6CXTYcZWUqqhY6fstas2UefgXlo0LkNyFuUNPVRO5HnE8M5faWTHjL1CAPtfhyOjHkOK1xZmWFu0/04lW4lPyhT/qtDM7EXIb6O3+YHhGppOJyB/5oMc2UXwCUJ75GPkQAJDsdsr/ncC+MH7NyLe2ekM2M+9ge+F7fyOMbor9m1rXcZ3QgPFeWgz6WFNC5S/kp4R2OXNHM60vkQ4w2MtCMNkuWaIYhwTYx/UEDaJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yjdSOX9Fj9+55tcoiGVAKOjLsrEbqq9KpSCeyrHSj4=;
 b=AF9iMiJm6IyeBo6bq6YgLAlRN32s+kGcB/ceFgxIIJNG9Uz7S0S1ujLbSRciS63U7eH9PS9e8S81tDHIwq5mCLzGCjKQbXFmK7KFGXwb+hTcRYbWuwIFvm7AHh/h1xsYnAyCiVowMwtem3dxLrC3ixlBAM3kFSuCv0BLytGrJP8FLFt4/XbBqJNgExVJzbhR5lZ8RvKgz5RXLeeHBj680seM83jWm8ptuCicm7cTleUdfVVf72d1N8dXSg0tUSfUeTVg3EiEQoJL1uGWxytZEA8Axlzf2FXudJDbFKQgtgMn8Ck1d4dRyiP8eVKY5nawygCPwSpkQMz7EZ4CjbObWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yjdSOX9Fj9+55tcoiGVAKOjLsrEbqq9KpSCeyrHSj4=;
 b=VYosjYss38yagAHTu3Pi2q9SD7+ogSOLdLXqHzE/UTILbikY5n6DvTXRn2NdOp+pQhXNVkMx0TIKXJbqdE2LsWFp2gj9fieH5XBaoD98UwESVTlzeQm5Jn0kpWK2NzclHxSt410XqDfPZTx3bl3GjBjJYxvDEyh3EUCKYkxAfO8=
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 17:43:09 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13b:cafe::c1) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:09 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:08 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 02/10] pds_core: Cancel AQ work on teardown
Date: Fri, 26 Jan 2024 09:42:47 -0800
Message-ID: <20240126174255.17052-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126174255.17052-1-brett.creeley@amd.com>
References: <20240126174255.17052-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BL1PR12MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b6a3c4-fb61-42ee-d7cb-08dc1e9642c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m9l6Bp73bHscW1CHWl/beT4mC/gpaDb0wm9daklMsfr/VjCq9L3iG18tLUA4BJF8fxe8cLwjetVqbm3OE0N5UcXrqLfHjgkQhO6bk8SXqG4ThxG1bOKg32JHEygA7PT/ehQWFqahBISpm8erOloTRaniZU7sNUc1WQfn1GLwOiDk9YQ9Z1Amf+9HtIQJvdGeL/Zwph1yI/fFHVX0mnI1IcOeeJX3rJeg4MOn6cvn2pKDi2H3qAnOJWi6VxmiezfjuhvCvAcViMaatfbzPuMifyxmk0kPUxWAxJP5xzOSH2MY9EKPIkx6KGPkxGsVz67eCvp8y5DTMX+xCy2kq9aSFPdEeGhxSPhV8BlmhG5SZms7790TR1cFIILvXPDBIa0oi9bKORPaZ1nzy2wGuyUuf1a7rJSqVNKP4XYnP7zaSRVELph/5MEmiXd/u7UVz7ncuroTVTxAlzfUrVgnG4NcKvJuAtY3fFlfh+FkN6iKuiSRhTpTC4Jd1tsWNtm5g/mtbBNIo5+wg0VuiHB54MBGhtgQvwycyROz3NMk3vDsyQKPTlK+FU3+oXWZ42ADhS3B/Lpp8OzpylcHk+l8u6k1fqylV/rQI0Flue1Wj81Vr3XKSm7aBCTq99OhByS/9fgwiQdeTeERW8hAT9SRObq1uyQbrarpMe4nZ1rs0evdJc1NScp6KG27H0BpLTiaANe81rEs0tCLiXqld3qhwtNWYTfg7517qzaK0sRTS9IkBD6YiTlhQUbicv4wU9D9xhCsScVWXkz05CoqP4DPCtNxnQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(110136005)(82740400003)(70586007)(70206006)(4326008)(36756003)(8936002)(86362001)(356005)(44832011)(8676002)(316002)(54906003)(81166007)(40480700001)(40460700003)(5660300002)(36860700001)(47076005)(2906002)(83380400001)(41300700001)(426003)(336012)(16526019)(26005)(1076003)(2616005)(478600001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:09.3554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6a3c4-fb61-42ee-d7cb-08dc1e9642c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5874

There is a small window where pdsc_work_thread()
calls pdsc_process_adminq() and pdsc_process_adminq()
passes the PDSC_S_STOPPING_DRIVER check and starts
to process adminq/notifyq work and then the driver
starts a fw_down cycle. This could cause some
undefined behavior if the notifyqcq/adminqcq are
free'd while pdsc_process_adminq() is running. Use
cancel_work_sync() on the adminqcq's work struct
to make sure any pending work items are cancelled
and any in progress work items are completed.

Also, make sure to not call cancel_work_sync() if
the work item has not be initialized. Without this,
traces will happen in cases where a reset fails and
teardown is called again or if reset fails and the
driver is removed.

Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 0d2091e9eb28..b582729331eb 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -464,6 +464,8 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 
 	if (!pdsc->pdev->is_virtfn)
 		pdsc_devcmd_reset(pdsc);
+	if (pdsc->adminqcq.work.func)
+		cancel_work_sync(&pdsc->adminqcq.work);
 	pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
 	pdsc_qcq_free(pdsc, &pdsc->adminqcq);
 
-- 
2.17.1


