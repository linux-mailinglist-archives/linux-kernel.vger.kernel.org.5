Return-Path: <linux-kernel+bounces-50521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0A847A2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E62828E360
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423412F388;
	Fri,  2 Feb 2024 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tvRbhxEd"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D819412C7E3;
	Fri,  2 Feb 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903976; cv=fail; b=U6I9FgF3uAbs+CU/BTVdnqb62w5lGLaRh9Pv2Z5smyJxiE2aurF8Atln+noT/WkOJCj6cWKUzToIwXs5BMzzehKCl68DDTnURSeHBSunNE8KNO2FJnKTwDWS9ZZjeJEZA8RRkjLbh5RDE1r45yDbnD9CL3C2RCI1QGiDUs0+bmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903976; c=relaxed/simple;
	bh=IWctnh+920BaO1LbGwY1uSCT2fwlAHqK/tF6oQllz9U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqqCFtpgttw2v9yxFdCeIKaMKzwIipExZLG+bCwW67rza65ORDSrVan/ekhi06pi4caNJGVb5A7f8KEnhiuPjVIkCL5xOoaGx00A/fbi/4wqZgsy4qrcXeBSM52mVRnL1eve+8okAJkXiRcgB/hxSYLq6IMSOpQepGlB8TseL8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tvRbhxEd; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqo36TxNfr3gCr7lbb0FBZQ9yQFHdN6OtkUKVAycWt8NwVrguibYxcGU7V9UEoM1a7yinCqFs4YKWyPv/VPIhX+j1mjZF4pS/Tp4KmIrz6wF98RMdMwwmwgcDtz43fQFrIhIhsKMEPCRmRy8nOYsPwAlA3Su2LfN/x39j6Jy3T3xJSmG9ui0LWskVodj0crbfr1RTBtQwiFGUlI68iI1WLglbxBjHAAU96JTQMIt6FxP69quwmMuVgxt7hvuwgo0bcKXvbBPKBIelEDlZ8g88nMjKRyld1VlCWWaovs8VxxbWLpyaHQ5RclU2NKPmgay7yDi18ZfsyLmtSg6sy/+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIzADFhpfbbIY+S0rgIxieFinh+y0xyYR/20NUIZ4EM=;
 b=E8eswuSCkm0nPW8zFEqsPkAiJX3S5W3eIL4toZlOWtm/lrXnd0SkYLLhgD1wJru7gFDm0+cxLZtcx4Qy7BOMuvFfE3Hmrzd6jyj/JETvJh3i1XqENIYiuuor1V9hxcPrUcdBrCjgnU9WGLzZipNlbjL0qVyRbuPUw2XqjRNLqIebAJdhaEk1330Ivg38GPTFzoEWErijhT1E2Cx9P/zDvG28O5kgx3BlBs06JQeK81lHo/oocYPk54bRoHfrwb1TpOxobw2uWyTSBE2Km8bmU/QUcMaL704CJzk7lDjcyU35ScOrwx7BrYNlCbiX+cxT40ss+wiUTWXZcMWYNA1chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIzADFhpfbbIY+S0rgIxieFinh+y0xyYR/20NUIZ4EM=;
 b=tvRbhxEdVQnWwHsVeM93hdIGpg48dPMgE81dNSDmKBOOtQ//ToqzL2YwyH8AnQCRby/H5hEARD2lRY366sW+qdtjTdh2B8Ufd8Y3uUuYKFNk2m+aVOQ0EBXBXeGP90lizgRVvOQn5ly9ScZ2nGvhDaN2S8xhbtfZltVCEET85kI=
Received: from BYAPR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:40::34)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 19:59:24 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::a7) by BYAPR04CA0021.outlook.office365.com
 (2603:10b6:a03:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Fri, 2 Feb 2024 19:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 2 Feb 2024 19:59:24 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 2 Feb
 2024 13:59:22 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH net-next 0/4] pds_core: Various improvements/cleanups
Date: Fri, 2 Feb 2024 11:59:07 -0800
Message-ID: <20240202195911.65338-1-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: eb981190-181f-4575-3011-08dc2429744f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TQct+wwoc0J+2HffLHMSMLvbQDEWQKNAdt07w/yaCObJ8SA0iVdw5c2yyUuidGQZsabxN8RXb6KhOkL60XDid8nxJ5SLX/UdDwqibqryLi3dHw3/pWFcXhpXc6B0gLA+vdhoa1UAD/7eLr3FE56gfnjGd7NQZ3KK4B9Hs8PAkFVuXvpWleioFUXlIw0CRWNNRdWC1A6ufJ4zdjgT3w1wRZ32nNuvKyl7BbrA8QWroxPL8mPyAinxXcE6LSY+sP5YFRcFIzW7+J98nUAFJc3zEQVDzvgPEdQu7V2KniZkayE/moClnma8/+CAqsUIHUzQBbsZMMgZt3GhZMk6Uomj9XmMp/VI36UC2InsvcmZKDLn5ymkiGUu5f3Jvqjxlb9G7YfGoUBb8g3ratv7Izwl6quGC1A8RO1FMVaXn9SWzqPnG3KzfNym7R/xjTTGTo6gTQSUA7zLVGxxFelR8z0H00he9PLQ5VpkTEc9ya/txb40Z3+xRHu7ZJLg6TrRBC8y0AZpZe1PDgfDqBaAGUBnfVEFsV2LhGM8c6OZP15b1SaKvJRfV2ncDlDtlL9eH40MEtCFOG4JPADTINyntNbh1zABGLYF7dBNOCUdFP5g0SdjBvi9zfO0UaLo/kfbA36jRd1fNoYvdfPE374InFDpJHgNDL04WqV25mJbfZGFjhS04K55AJeWrxlWlMbm+7rseFqDzrGacLErZZ6nMYO3WmJPiWQpczIYxu/4ezaSoAmxtMdyUm5UAXHDHrhzF5vGcSkdZbtRTkYIEJtlffLNo4oaKsX7bOAAWOltYiSZGjk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(82740400003)(36756003)(356005)(110136005)(86362001)(36860700001)(5660300002)(41300700001)(44832011)(47076005)(81166007)(4326008)(8936002)(83380400001)(8676002)(40480700001)(40460700003)(336012)(26005)(426003)(16526019)(1076003)(316002)(2616005)(70206006)(54906003)(70586007)(478600001)(6666004)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 19:59:24.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb981190-181f-4575-3011-08dc2429744f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175

This series contains various improvements and cleanups for the
pds_core driver. These patches were originally part of the following
net-next series:

https://lore.kernel.org/netdev/20240126174255.17052-1-brett.creeley@amd.com/

However, some of the patches from the above series were actually fixes,
so they were pushed and accepted to net. That series can be found here:

https://lore.kernel.org/netdev/20240129234035.69802-1-brett.creeley@amd.com/

Also, the Reviewed-by tags were left in place from the original net-next
reviews as the patches didn't change.

Brett Creeley (4):
  pds_core: Don't assign interrupt index/bound_intr to notifyq
  pds_core: Unmask adminq interrupt in work thread
  pds_core: Fix up some minor issues
  pds_core: Clean up init/uninit flows to be more readable

 drivers/net/ethernet/amd/pds_core/adminq.c  | 10 +--
 drivers/net/ethernet/amd/pds_core/core.c    | 92 ++++++++++-----------
 drivers/net/ethernet/amd/pds_core/core.h    |  1 +
 drivers/net/ethernet/amd/pds_core/debugfs.c |  8 +-
 drivers/net/ethernet/amd/pds_core/dev.c     | 22 ++++-
 5 files changed, 71 insertions(+), 62 deletions(-)

-- 
2.17.1


