Return-Path: <linux-kernel+bounces-43636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B284170F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1B1C22EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30A0157054;
	Mon, 29 Jan 2024 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fGnGhiZ1"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE0052F62;
	Mon, 29 Jan 2024 23:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571658; cv=fail; b=okI7uZK1hG6S8HNn08GfyYKk6wr12p5SEjir7gYVdydt0nPirA/vyEUb/yQRvesm3BYLKo5JKwOZx+v1xVgl6YRj7zVL0OMrjotXde9gH3M/sUkG5+GFM/mTCsHUyOA7D06I9N3PJZa20L0SMO6J0k6st0ixlecdOjwhheN+00Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571658; c=relaxed/simple;
	bh=IKMIJr/rtbBj6kW6ETiKOB3F2NMWT0nbewdroB5U/ak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkj/zGpJadS1cK4Rhxl7NY/fHfcmypji4Fr2v6Kvl7RZQ0PICGAnpeLK9fln0xaxpmyIfrp3chfm5fcyujq7mUnEiI83v43VVxCU5PVKHDo0555xUoqCzgffj6bekjNq+4PVHjrPGE+mmYIcGZyKc5mE4kLLY249mZ0mj5c2bCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fGnGhiZ1; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTodMc9OT+NoIY6k378laXCiu5QOd3YtlU6m/m8f7DqUL7PLXrXoXVvbrNH47B18mp80Sa43ScmixgbbdxIpqVJIxIIseX4P7gPtmHMJrHwibXajraJoJNoO6BQ+I3PHP4K1YW+xkOUYfDPfD16iHHI1fG+4XJaQCDyQWb79yTL91TRHeSe5kxUQDAmllK/xRHJd1VneaCrHvT4IMiuPTFbP5yAfC5I4D9d4EfP41cD1ChBRKim4ZjLDK8UcgCoJ19zZtLFei65+42FJIEfVLcEFyJfZ3rJ+vH3y0GprIMFFsKkYeg4wrme4Awg/afy/PmlR4FCzwCabFAlF9WJc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeKN09VJLIWH6W+Mtjmabh8bVOxg5ARYAtado4tyAUM=;
 b=BIoShilkKba292EEvjKYMcEvNQeBNttNFG1y6GQqlZRwqX8mKqAGs4eVtGAW6Kl5FcR5EM40WIZwFz3TWwRC1WcSCUqXltIn/EOf1X00Kg/PqsK4bxLOIcS+AtW2qRr1+lY7v8fu2TDjdArJlNRs5ZPoItaF/jmkdAmepqH2Huh5h+helaaU46poAddFhInCMTnVWszJIv98pO//l3OxUcHhlRNOFoEDhVonu6YvuxXZCh6v2/e+bpx3Y/p1j6MmQpW2rAK8oa5P2yWxWLdsneanzHz+Zx+P+7hrLG0FBkCaVhYoEJuVYiJNzjHNxTrxC6XExAJFjrFaN/aXQIKDEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeKN09VJLIWH6W+Mtjmabh8bVOxg5ARYAtado4tyAUM=;
 b=fGnGhiZ1GKCIpkOgAaU5plfjiemdofK054k/URDEDiOwj79WkJkDguDQfZvR0J0zyBnnkEYOglXW9+ra9O8L4weJ+/w+TvuwYzCMoSy2K9p9i1efq3c6RlMiyX557g/Bh89wWvJmk+X3kwVAQ0w8M2DPWAgC8EQAzopcQqMHT7A=
Received: from CH0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:610:b3::19)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 23:40:51 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::36) by CH0PR03CA0044.outlook.office365.com
 (2603:10b6:610:b3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 23:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 29 Jan 2024 23:40:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 17:40:49 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net 2/6] pds_core: Cancel AQ work on teardown
Date: Mon, 29 Jan 2024 15:40:31 -0800
Message-ID: <20240129234035.69802-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129234035.69802-1-brett.creeley@amd.com>
References: <20240129234035.69802-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 439951f4-06fb-47ce-2225-08dc2123ba20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3hgfCB1bzC9VNsWU7NeYhPbHMXtP3QXndgl6+T6o0HpMFCCea/RIFnkhKHf/PRslIeZs3vuub5Pg7bG8PQtzMS+pX/Yl+U+z02X5CLmikveIZ2z6WzzCBc8Sa8A6iPTyV/sMzoOhdAZJzwIwwaIcRMp/5/psYPhxHC/boYjC/JTQmBH2bbIGa46qem67NYqNzWZDqTU7LucyzsEd8b3ymm5fzQpZWMexlGMzYmA1+o2Rb3r6eH105G3icdiwVj6kyJXFZ2yb0zA1egOJeQpyCfUZ5i7VHYNqtG52ZzfMyLrtFxCygTyDqi/grFE7crjZiZXgHYnfaywcuYdEszTQsI0OvOS/rmhK0AJScCs1yQhDv8U6IlM4tB9aqPBmRDxhsSkX+Ll2OFWnRQ6adCPrpy3rO9mfyMuEJNfNja2RkpFMsvjCON1kpDsals1SHqxsGI0OEKwXpM7dDB4Ro724EFTAGfIr8IxC78g5fj5FMMz6LcGN1ZW8pJtBoXTfNMeKqSrdaEH81/LW5S6bA72Ov+8Tw+9v07DufGBQXCaj39nykwPtr+soH66Tzi1bJE6ChhP4V1XuYat1JDkoTlXhhM+zK+KPDYCDVoFfGvwzEP2D5c2GLTIY2yJ63t40uwsstA2z4hdcFH+drN2a8DFFpQ0eJN5Pfvv3FXlABIPBxxmLNTZFH0Sc/UJUIknCYuFwzp2AIRwD2suE4LfVjBdIuV3C8MerSFzPt3UaywYWk4aU0a1LZ5R8Fe1qV00tYkcX39W9ydA/T1/Z/j5x8fHcNQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(5660300002)(36756003)(70586007)(70206006)(1076003)(47076005)(54906003)(316002)(86362001)(110136005)(2616005)(83380400001)(26005)(426003)(16526019)(336012)(6666004)(478600001)(40480700001)(40460700003)(82740400003)(8936002)(4326008)(44832011)(8676002)(356005)(36860700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:40:50.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439951f4-06fb-47ce-2225-08dc2123ba20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

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

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
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


