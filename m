Return-Path: <linux-kernel+bounces-70220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B338594FA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EAF1F22CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8A27492;
	Sun, 18 Feb 2024 06:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="haVa4Toc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7D5672;
	Sun, 18 Feb 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237627; cv=fail; b=eC6rrJhKPasyrNTWpK5TafauC8qx7mGLba/M6b2ByJ3jVW97wXzQ0TaajW6n3U0gCQ6qwTO8I5WNg+MS33lT91ESbSiQ3CznxZyNr/3D8dGORXnCm23Q/R6quO6xkq3BclzTYDs6MTZj/EmpDolBTygYZaGZJpM1wgLMSx0rOWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237627; c=relaxed/simple;
	bh=dAEFyO1Z2irNeaycJjnGnItfnwKRWpvXNiyd1o5v1CI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/+nMUqbMaZ6lsm4mxuAIKPj42/o7IAw4AufcEIOosEiGiPKSA6bi9OKbkCjzX5DGG8PLC2ZVcSPlulg2KNRIcYE+FGxNxk5UtzM8Gr66wqR6JM8Pkbr1DI9cpDl837Sn749yePlMwnMvgiRa6PslGBfPAG8q8Br3+EXSD9fsDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=haVa4Toc; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0VEJnPpElEnKz9SG+kWNmaeVBm8UC4+PrTDL7f0X8LhFZtYk4PxeR8oM+YkDHwPnm4678RbwmPBthbfWvwDpk6R8nCypFZ9Ds0dcJXOfCTu9eTx0NawbfPG4P7NzsoCTIEfz2QDkfHp313507McI+a3CN/KwV0pVMFxV54oyq1Fu9UZMJ88qZaz2O+M1zv4OokF1RS7SILPjLbHHlJgMzbUmKi/XJ2m1Nu0pfx7slcpjaIAjjKuENxWyZYWNpV9TOEbGw7fA5R6nuKhReBG8IAQQRbOl9HO+HLENzFsZEiZ7Jk/0NuzqYkpJYLwod20meXfD16Vx5pxoju8OWxntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZyCpPt0wtLY1lwc3rGY2qBm7FTdlIypA0IcH5Qs2aU=;
 b=GhQTOLXE6DQyQnyyjrKBH9Ck/OCyOvGF+8EP8Brmk+N3KJSrs66xqQxkL8r1rCHOGa4x1MsYC//udeu+35UGF/I42qzBlkw2e7EkUZ/1xAa3fcxKHxn1eZy3tD0mJd0/DXtHdVHDTiXHoIvzP0mRkzGcobADUoo35bnAkqn0xlwuXdKrBKSypA0yXmX41EJuCyPJBNukeJSjNdK4G+bA4Fmz5Ag9hG0mFw9gzcfLSJVkOaGGKPkiaeItpjN/YuWcY/cNekafpzAVrKSQ6EkpsIZfW1GSZLu2Tw9xZvh05W+sxlGfZOMwPsWHreTpA2aICFOkqYnIfI0RYQOqMGl8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZyCpPt0wtLY1lwc3rGY2qBm7FTdlIypA0IcH5Qs2aU=;
 b=haVa4TocOs3hxJqUmGTWaWoQ7+UNZ+VHUlsV+99Ue5hAGF/H3E8w/pBaYGs42GcPKYp5eoVM4fJf3qW14fgX+grIugib8eB45MvzHCTjPo22GQ2pqzVIzZcEOFi3HeGEzzt8FanCAc7E3uwRHtY7zg7/8BSDyu/x5iavTx1zB6A=
Received: from CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::7)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.16; Sun, 18 Feb
 2024 06:27:02 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::d) by CH5P222CA0012.outlook.office365.com
 (2603:10b6:610:1ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 06:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 06:27:01 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 00:27:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hdegoede@redhat.com>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] platform/x86/amd/pmf: Add debugging message for missing policy data
Date: Fri, 16 Feb 2024 19:22:04 -0600
Message-ID: <20240217012205.113614-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217012205.113614-1-mario.limonciello@amd.com>
References: <20240217012205.113614-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 249895f5-124b-4e74-ca12-08dc304a9e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3wAR9C46jrNXjNC7E9GdyhYkE97s+iJkMmfLAnvttmOq77n2/NvV9g3A8FRG6gT6SV+321CuvxXdI1JX/G74Xuxwp9qxtJudN3yxPA52j2WGM331Bt1iDUbKloenWz1wR83pgKYoFIFJdyrAiA7u9lZXq6qocQ8JEIUx/awNsYV2u2IGBXE+tFwuFRDUQeDNN5X1TXaCYmE7de2KWUG85MkgrF43yYRQqbTOG54VYLUi92ifYu4cxSOKKTCh4jtpvolGY8W2mWj52PllXyxPtvegyA1FcJku9qFz/xvsvl94JbGSHSwRmYq5BXW2bcEC+Awzvsk6/tK4sJZ+hi9vYAJq7pEOF/1sCZq0CeRHP7JeCSc47KDUxOUSKn2BD7U860Geu8RCZq1xImWERPPQb8+szPEjUYtoUVcSyPlxloaXPJiBmkxzena3IYAwE4YzXsTJWDRTLSQUql3zgYCEdZQJP9gO/2VXgb0cbFrVMqSJKl56vciIlKCY/1FO8oB+dLVSPucZd8iNC26g5zpJyrV18uKO198pLHBL3uApb8C63leycFPb1np09zCndFX0KjJx1jm8OVN5ZZ6lbbU4NNVPnU4yX4dxgKCR9MNtoPKhZBh/Qxy28bABwS7N4vWYtxmBhFn7nIn7nRAEUVSGvthkdMyF6zdec2wS+RSqYEE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(36860700004)(46966006)(5660300002)(15650500001)(4744005)(2906002)(44832011)(7696005)(26005)(1076003)(2616005)(36756003)(478600001)(16526019)(356005)(81166007)(82740400003)(336012)(83380400001)(426003)(86362001)(70206006)(8936002)(8676002)(4326008)(70586007)(41300700001)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:27:01.9312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249895f5-124b-4e74-ca12-08dc304a9e37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291

If a machine advertises Smart PC support but is missing policy data
show a debugging message to help clarify why Smart PC wasn't enabled.

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


