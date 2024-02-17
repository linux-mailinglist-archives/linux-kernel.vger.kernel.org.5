Return-Path: <linux-kernel+bounces-70408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888D859759
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4706B20E51
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCB6BFDF;
	Sun, 18 Feb 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DBx7vApC"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661226BFB3;
	Sun, 18 Feb 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708265489; cv=fail; b=G/MfTTlzX2lnheaJXEZSY5K2DMOyVQCHJMop7EIM21440xZzDHTaQeuBKw9+KQqWi8vZbtmTaoI1tXI32UYDHYNFHX9FMYkhDZ+btXcHg5xsCwgal859opYWh8P5PWd4kgc73GwDUD7w6kOOdeI4pU9prShKc0Y00C5p6HSyCHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708265489; c=relaxed/simple;
	bh=UPucnQzRSezoUa8wbcD4r/onTXpcVMGq6u9TPaDo9Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdzxiQlRl+K1Z/joSdbNJTUyJWGsKfhdhWE1fUbmLIRNSPIe88imLq1N2lK1+cLSfWVOMCfK44Oq55xWQ9U9wmbDERPsp3bwFdy0nheD49Ggzm1tUgvw3lzJzaTeRkOLS72YzFmqD5WRYq2q2a+cksiCsgvv5pq4legREIqG7MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DBx7vApC; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beD+4aaCgdZhFuLzPS+Sa5AQPZpCK58kFuUXksTFbW/GU0M+47L9gQ+K6nUV82BDbdexGM8pCWG3WxgdwtiFd/fS/6hoEO5UopOgtxq5AVp0HL8LMHZ1AVgqF/0Xc0U4ICjsUycYQX6IeYd0JG1NrEunhtvsr4wSaZAFu1ykYKM5zMbRPTS1vxPP3beYmKP7aTHSs4MzOU/QiftFZifl1ThYCNDoIY7jIP2W4PJfU9X1bQOneXWDIGHMvsNEfJmIDDKA1u4Nz+qjZwhsUacyt6RRfDT7iTPJoPnvZAGQRpRmoZ/yU/CYhib4iOL6baLvAsCBIdJKhTDVIzY6zSBSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxWU2pc/R3JnBAriPb0jazMoal1VSV1qkHl8Q57gkXI=;
 b=JRa3uqBycpODNEWrmUSKpAD3zr7d1qm+GtPvj7JDuvNMAY8VUgcGknMdareG5nyQ8ATFSe4DeSYD7uFsCNu9MZ/aCbv8Oyu9wgyTj0dPJ6jXW/gd9bHTcBY2+3CyAsY6vv42Km/9gmicKGGSk6qoLfnFsQkSEkXrCxUc738Ms9vMwMZROyndcXpnky3Xxl0dz0AoWCUQIPzAZqTjXxrpl5aAYyPn5+WUKDdmHZowoPXZT0tB5tYLqbF6d+UwGhFq7tyFEpV2qA5qGRx5zQNRmTw5f+ggvnWmxcS0zITEy95C3TfRLIWiiO5M+kGNoIp9qbCrgSHLga3+uX9yprs0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxWU2pc/R3JnBAriPb0jazMoal1VSV1qkHl8Q57gkXI=;
 b=DBx7vApCbsUtwgh/3Dot2bQgLpOhBYXSrEm7xb0HKp33qP00QYddlRUzuwYHnw8IsFhZ2eAR/P7oS8/BNHniTLaWkXfjQxS1z1OPXb4RCcEfzrTRZkqIewZf3sKESJ5kiTKCJj4J49zy7d/ui0vyVwqhNT8FQXuP9hwe4ja4lNU=
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by SN7PR12MB8004.namprd12.prod.outlook.com (2603:10b6:806:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Sun, 18 Feb
 2024 14:11:22 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::c3) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37 via Frontend
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
Subject: [PATCH v2 1/2] platform/x86/amd/pmf: Add debugging message for missing policy data
Date: Fri, 16 Feb 2024 19:41:06 -0600
Message-ID: <20240217014107.113749-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SN7PR12MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b3bae5-c9cc-431a-177a-08dc308b7c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rI5Owo4xGiSOYnTEbHw0huct/TURhOSY6mBHmMWYbGkekHM7gmKtmJ9SEExf+4R0TxNtz/1kw9wUtW7i3RJFaeg6oh65nx8B6WERcUA1waHkzQjSer7L3o/yXnhWdTMDy02chwaKA+T0+JPwvdM2UF9mGHf7LxF8v5jhoyN+WhXTZjCD7nmtRDwtXYDJO19LFb8Tdd++d5uUTlQUifFw5Ad0aEFKAoKfTLgN9h/DfVRv3uNmFPMkZuXtTQZfyrie50j73gw2s8KwOL9hnRrmcgLSjGLZu3fpb0XfkNrtVqfFGCNdGxi8TKuhC75qDbgLg2NvpPDOZTBsd/+gWJelb4JS968m8UlU+jphfIBlNl2HL2YnWkBZ5FZfLxwY6gNF82DL+Wp40JpjOIdhC/YHsg1G65Q1pKdBygTtsi/IJdHkA63MhyKRU8MvtAM/gkm1EzVhDyzRIvOXZEB9/uC/BtBY2wCiR/o4CoGAeafr5HG+2E+Rrf50eHP35uBaf9o1A8/toS1fPAAdiTGGnO8SQCzmx5bRQ7bTnd7ZMgH/24AGbUqXo6/Nj84VGij+jlWX3NU7VVGG8/60QU0DvwuD5HqI1P1Ajj8rt8dCkUhsCEGwQ0cpe7ZXttUQV74p04IMhzXYqImR78ozRww9CdsA5hFkvDoNtMPliB/V/wPhQdU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(36860700004)(40470700004)(46966006)(4744005)(44832011)(2906002)(15650500001)(5660300002)(41300700001)(26005)(1076003)(36756003)(2616005)(478600001)(16526019)(356005)(81166007)(83380400001)(426003)(336012)(82740400003)(86362001)(4326008)(8676002)(8936002)(70586007)(70206006)(7696005)(54906003)(110136005)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 14:11:22.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b3bae5-c9cc-431a-177a-08dc308b7c3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8004

If a machine advertises Smart PC support but is missing policy data
show a debugging message to help clarify why Smart PC wasn't enabled.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index 8b7e3f87702e..1359ab340f7c 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -252,8 +252,10 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 	cookie = readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
 	length = readl(dev->policy_buf + POLICY_COOKIE_LEN);
 
-	if (cookie != POLICY_SIGN_COOKIE || !length)
+	if (cookie != POLICY_SIGN_COOKIE || !length) {
+		dev_dbg(dev->dev, "cookie doesn't match\n");
 		return -EINVAL;
+	}
 
 	/* Update the actual length */
 	dev->policy_sz = length + 512;
-- 
2.34.1


