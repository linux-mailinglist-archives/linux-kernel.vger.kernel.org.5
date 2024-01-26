Return-Path: <linux-kernel+bounces-40450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298B83E0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19634288490
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C820335;
	Fri, 26 Jan 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MEB/eeZo"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E21F5FD;
	Fri, 26 Jan 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290992; cv=fail; b=Mtis1RDpACMwUgO8hKWajlRGGkPRPEggYcfhm5SxB89kT8AvHX9cThEvI5aTNHfTlItjHfvol0raXiAEH/mX9iXrokux0loK5iqZqo25O5Qq1PvJoSl6wQxXklR5X+pHbm1mG1k/ST/n2C/4sqt0t7+f4/WQLi9UlgXcLk5FsFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290992; c=relaxed/simple;
	bh=7a/bjHFKIMKZuZb50Jjkszi7rafgUrF/PqtpcSKFo20=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U4+Leq+pcp96KYe/F5qdFOhxPJgMbNLVrFQKlu6ltTFECan1NtTXp1B/BRrwcKBIQX9Iq9Ik2/K1VEZEFKykWNiZ6S2NQEk1Qv/FDCaDtBvV/iZ7KWxWieWV23xjpFsKkpy0dj8Ky2+TBy9WV9DFFUfpDe270WdfeikN0Jt6AdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MEB/eeZo; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fm7EzJ+btEgacHT/l+zf4R2UmReSnP3/LvNxCr4kwdqPG5bz5RoYSAahbR1uHLMafs6xS+yM+6RcLj2CWsjwJ9KkBLM+Sz3i6VfJeM4Wf7uZCCORZW1cRaX/ixfmE9uhjPARZPvvwEAnkXQxzJLcG2kRa71bdYp/obdhUvsTpvAlHa+KpBifDIFoZJVbdZYt1s255HbmHvMO690tGYV7DQFlKWheilUXmMV0kH0RUS94WK9DMxrytsVpCa7e8TKTl7xO2GD1LcZalCx9Iv8zVdYNnAH4XrO0ZpBZXFpXsau7mtW0Ou/emZkYgPaLmvUq97VH9D16knV0yOt4xazyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkODIiH/QVHzqnogTUQyo6p1ENciUHyhu2B07fUnv4w=;
 b=LN4NV58XMpePB/01tF1Ojl5X8/RerwMbJ2+8hm7oeKUc8+whc74LqafsPjwUdyUpxcIzwIhki4CG0Cp8nXDHRMwULf9UFkatdyL0uAYkYPVGMogUlBhOZsQldXQb3yDoEQ/Kw+Z1LzPffRS2tvMFj5klv9owg4YN7WdsTEwzC+oV7nyBW35iN/hgQ/mK7u8EcmeQUM8r6/bIwbETxyahM22EykJOwDRjwQpu59jH8qR0rM8fdcBS9RxcCgjjGHpQ9Lu0dDifs3XIotBlG7/yCfaqG/eO7qXQlGAlAxYWZoObCk+dHv4LYyhfWL+rw/aH7dlw0iFkKi1e3pU7OkFulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkODIiH/QVHzqnogTUQyo6p1ENciUHyhu2B07fUnv4w=;
 b=MEB/eeZoaJ4xAimO9ODXtLr2czhS+LJr0Lrfgh3fHJxp6YkRA91I1tJZZwOrQiRXhdUnHL6MH6e5EfJK+oiCGdhTfxKrRK2zkaU7F4hWWKSxxKm17ThqlCkhDKPwlQlw+h4mxnAXDCgzpaI9VkCFPf8JdOrPb2FYmvTsxe8YE4E=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 17:43:08 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:13e:cafe::ae) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 17:43:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Fri, 26 Jan 2024 17:43:07 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 26 Jan
 2024 11:43:06 -0600
From: Brett Creeley <brett.creeley@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 0/10] pds_core: Various improvements and AQ race condition cleanup
Date: Fri, 26 Jan 2024 09:42:45 -0800
Message-ID: <20240126174255.17052-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: a9757455-7eba-4dbd-291a-08dc1e9641be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s+9+SE0/7z4aiiSgDSftQ4wL3OzDVK3z8TxTrvGyP87qT6KNgYgqtpN55k7Ps1OD7S+sj5MY2gMxeze69UYxYHDt469TInfKNHBeV+TwLB++GCvW2up0g8w06oLR5/NbVLz1wAR/d1XyY/FiFosvfSMmI4bzWWnkS8C5vg3egjmC8dvtWcicGT5DLVoZbfD4AMP1WtYMS/I9lZ/3BWy+GNwntKjVCevT/lDxs+NFkuWXbrqdUKWrLFzAOrgpIrDopmiQbaGS7J2a4W87eUhT4JiAHgpyjkzgI8KWo9xgDftsdWkBXN4MxCKIvAbkHnzk9PpRPBsKvlSrxq473EYG2UOmojob4qZsJ1O4h6JFgJT4cnVKdaAiWXkZw1kOIlbArOpu6r1hAMTfPkNsBNPvE6ErZypSoSjFpr09OZQgraMvVdIU6k6U1cQamQlhVoPAPJLnR/EkzBAwwCN1vvNM+aXAF0zxbOPM3WceJkRmCkDDV+BSPAw4FAeUX6ehfc/YWlTtmvavRM6JCoNf1r3+Wogz2ot256vz3z4zNwHztVKiYcsnTmnHj9qbCOw8/rp+s5R5shYyFa2PXWmUpM0imh1K8/2svz2qvBJL4Gv6pgdnhnkw6vT69S6S/m0hucsvnxTjYFMDo7uwZu2Wys5KxTkYf7IuCJa/MoNdzRSbBj2cJT4LC4UWV04L1nMdnWm4tzHal0CAdCZBgKCtom9N63tVV1IIdyjeR2P5PVdO1z0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(82310400011)(451199024)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(44832011)(316002)(4326008)(8676002)(86362001)(966005)(70206006)(5660300002)(70586007)(2906002)(8936002)(110136005)(54906003)(47076005)(36756003)(6666004)(81166007)(36860700001)(356005)(82740400003)(83380400001)(16526019)(478600001)(2616005)(426003)(336012)(41300700001)(26005)(40460700003)(40480700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 17:43:07.6364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9757455-7eba-4dbd-291a-08dc1e9641be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

This series includes the following changes:

There can be many users of the pds_core's adminq. This includes
pds_core's uses and any clients that depend on it. When the pds_core
device goes through a reset for any reason the adminq is freed
and reconfigured. There are some gaps in the current implementation
that will cause crashes during reset if any of the previously mentioned
users of the adminq attempt to use it after it's been freed.

Issues around how resets are handled, specifically regarding the driver's
error handlers.

Some general cleanups.

v1:
https://lore.kernel.org/netdev/20240104171221.31399-1-brett.creeley@amd.com/

v2:
- Combined the RCT clean-ups with an incorrect goto label fix
- Added a couple more patches related to reset flows
- Slightly updated the cover letter to mention the extra patches that
  were added
- Changed a function used only once to be static

Brett Creeley (10):
  pds_core: Prevent health thread from running during reset/remove
  pds_core: Cancel AQ work on teardown
  pds_core: Use struct pdsc for the pdsc_adminq_isr private data
  pds_core: Prevent race issues involving the adminq
  pds_core: Clear BARs on reset
  pds_core: Don't assign interrupt index/bound_intr to notifyq
  pds_core: Unmask adminq interrupt in work thread
  pds_core: Fix up some minor issues
  pds_core: Rework teardown/setup flow to be more common
  pds_core: Clean up init/uninit flows to be more readable

 drivers/net/ethernet/amd/pds_core/adminq.c  |  74 +++++++----
 drivers/net/ethernet/amd/pds_core/core.c    | 130 ++++++++++++--------
 drivers/net/ethernet/amd/pds_core/core.h    |   3 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c |  12 +-
 drivers/net/ethernet/amd/pds_core/dev.c     |  30 +++--
 drivers/net/ethernet/amd/pds_core/devlink.c |   3 +-
 drivers/net/ethernet/amd/pds_core/fw.c      |   3 +
 drivers/net/ethernet/amd/pds_core/main.c    |  26 +++-
 8 files changed, 187 insertions(+), 94 deletions(-)

-- 
2.17.1


