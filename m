Return-Path: <linux-kernel+bounces-70406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC89859755
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7014281AA7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA8E6BFBF;
	Sun, 18 Feb 2024 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HUpc3Guu"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302565BAA;
	Sun, 18 Feb 2024 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708265487; cv=fail; b=AT3L/rXo2PzXIuT2xlRklx4DjH4ch2Lv1ItWoxge/mZj2p/7GfNrYrjiDfaRzU5DC9HA2MNT4lzMiqAHI0xKEl/yzSb1MzFckM6gUTQu2l8Aj0T5oLJqlIlWPFHHKynVXnJr1ImhIyRTPYSWgG18Twz1MLcGwjjflAg64KRD/hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708265487; c=relaxed/simple;
	bh=rz2u5OHT6uBSB1+HFQiee+s2yo6HxI3sQ7AeCiItP8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2tSiLX4pPNVa+c+K01OZPgc5s3SDHHE0DESrKKipMpzyDtnj5KEdYQwGsa9WXU1/EzfPhfsQ0AsSWftNHa3XtbMN0GWW9p5Xvl4LOAozeUeV0M2oi8Q45aNVCxSC+mr7Q622Tk1MyXCSFcAlBizXQN4AbIL8Nv/aVQeJBps4fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HUpc3Guu; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/JYRhVOGN9DhgsnoaVHuH61Vk4YQ3r7gt0Y++7SjWJsPpOKUFdMhVd83HG+rYwmgBs5Vl0KfY3ZdID1NdenbkOpDYLJulgyX6FgDgS0INB5E0HXNgr0j0M9aY+zVhgjxhDHlqKhUj1CERu+Gc7N4+xVxj14gqV/tqXBlt2ZqpVvD7O5f25cAuUIelDM3XH5JhDe0SIViJ9BZ9Fd/JcrN7wHW3EGZ07RBXKcifgnHf6V8ycxJFV18/rt2T5jbCiM8xNIKb5A2L66GLLhqWsrpuMIZNqldVhXQ0BUWzAprejQOYWThUTUhlfpDIoWJf6DSAW9WVXWgkWmXDHfi1znfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PK+mTiCi5IygO4feRyggpgzh4AL3bx6jjq+muCTGn1I=;
 b=Zg30Ox9dV9sQBbRvFkKgbtXUbwOni7COiSb/QpVurNKUsC6xKoZT3wjsfPkcVorNK7PwyGLH2SZlH+YhUGGBEMfEfLl9wMQO6hL2IEVAbYmXm4chRIJpxgzYEfGV53yEtVmU1A6gJG/hDPsLD7SH9MeJpqQLlvXFsDW0dcccyJtfsqTximDk041NTXJd+6LqY1ofNeJm+9ublI/g6Hts9+FF5oDZrKE506PNtTQPM9DKMQfyRoep8Mai8qM84DIPw5V5vJ201kQdYc/9cKvrr8XYSIrHZCFi01R5Dq6lmNdefgsJVKJkxKHmSVQz+GQ+rw0LbLiO15p/x2JDCGg0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PK+mTiCi5IygO4feRyggpgzh4AL3bx6jjq+muCTGn1I=;
 b=HUpc3GuuV2fy6Xm3V5uctYWQWzX8gCtelnSsvFp6zIwkunbXAZNr9lgeWmaKd1j9mXHjBqvxYHGicA+eiCPIN7JpIU23oKpPSMR6r/qJgP4p12EjwvVL+uOWXBrngmFdmUoICM7JLXovqf5DsYZDYm1qThaMTYGCLdGxVqkGO0I=
Received: from BN0PR04CA0079.namprd04.prod.outlook.com (2603:10b6:408:ea::24)
 by SA1PR12MB6871.namprd12.prod.outlook.com (2603:10b6:806:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Sun, 18 Feb
 2024 14:11:22 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::a4) by BN0PR04CA0079.outlook.office365.com
 (2603:10b6:408:ea::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 14:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7339.0 via Frontend Transport; Sun, 18 Feb 2024 14:11:21 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 08:11:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/2] AMD PMF Smart PC error handling cleanups
Date: Fri, 16 Feb 2024 19:41:05 -0600
Message-ID: <20240217014107.113749-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SA1PR12MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: cd54ae36-e6d4-404b-4336-08dc308b7be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iYP67EF0tTojuRisIsi3fnBnKaaQaDJpApw9daoSQA2fzysUj9LJZ/Mn5vDHFVShPSPGbVCYKaYjjBQV+gzez5p94oEUvh54e0yl9Mf6TqrJ4LduhX4BqiTmL6bVUw+tDgcLn04HaqeRV+oMybbveVXkFkrJzGGeqwBss7ESl+AFzOHnwEdG5H2qjcyl7EmMFRzBWPp6ZOQc/wMIMRH2o+mJGJWtnHJtcCizPcOb0Q/vrsOd3i8yYD/pu4lfe8VgGsuRdqCyFsonzc1nvewQpvkT3BFZzKwNaP8OsVU4m0SeEbXVALeSDiT2+yiLYqCO36+si0b1KmurEPMs8wZkOwe9cxN8ajQ7ApvKXvWFw2YQQvecGXQcDCTgP1JdncNzG71Ue6RIvuZl4Z2Zm38FgB7rrSJ92QwzHodmQJnYSP5L0wIBPWZTB0+orz6RrUdIiNlTYsq9eNLdQEPzGPYE66EPbHmJiw0jO/XxtDxGsEAU/5vxRsJfjdb/DB0+/EFagSedl78BHcpwBrHHzMyUBDHFtD70wljz6fPZHqnDR9gp2CCINC2GOz82hFWdWAnrcrWNA/cjKmHNIl0MQ3AGRTTuFLcJ0y12rr4j6lfHRVUWH8k+Pgg1beolVdD4dMqIBuL2jr8nyPmfl4/zS2djKIPzglFebNhM2C+ZBfls0XU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(36860700004)(82310400011)(40470700004)(46966006)(4744005)(44832011)(2906002)(5660300002)(36756003)(2616005)(41300700001)(26005)(1076003)(478600001)(16526019)(356005)(82740400003)(81166007)(83380400001)(426003)(336012)(86362001)(4326008)(8936002)(8676002)(70586007)(70206006)(7696005)(54906003)(6666004)(316002)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 14:11:21.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd54ae36-e6d4-404b-4336-08dc308b7be6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6871

While debugging the suspend issue for amd-pmf the initial bisect result
pointed at red herrings of cleanup flow problems for
amd_pmf_init_smart_pc().  The actual issue wasn't in this code, but still
a lot of memory is allocated and not immediately released if any of the
error branches are taken.

This series cleans that up so that every step is cleaned up. I believe
this actually fixes driver bugs that "could" occur if a BIOS advertisd
Smart PC as well as ITS auto or CNQF but didn't include a policy in the
BIOS.

Mario Limonciello (2):
  platform/x86/amd/pmf: Add debugging message for missing policy data
  platform/x86/amd/pmf: Fixup error handling for amd_pmf_init_smart_pc()

 drivers/platform/x86/amd/pmf/tee-if.c | 69 +++++++++++++++++----------
 1 file changed, 43 insertions(+), 26 deletions(-)

-- 
2.34.1


