Return-Path: <linux-kernel+bounces-57243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF1C84D592
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3761C258E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB70C1350E3;
	Wed,  7 Feb 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KMRNXkhn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AFA82C64;
	Wed,  7 Feb 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342912; cv=fail; b=HI5rK065B3luFveWXm1F74siQC5DbbWrnb6l4smJzd53HFg8Kl7o+EkfeSKZ/dQjyVjPl3sGCVfm3E0UrMzqSDKXjGb9hjkBI1LMVfyoFPj0gecJ4bn84CrhvtWoZ400O84EQ286y8sAJGGwIgpF/9Npj6suacnxMCLsznMJ7wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342912; c=relaxed/simple;
	bh=VU4zPRfB7b4+rvHXjmvJBy2lGsauUIlnAeJKZnv+UgY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBLW0KWvc5vVXGchN1/VlLW647c7gAnshPYA+279PisCBx1MJ9hyhZGAPg9Axd8ML43085HIKzhsXvda5aF1Aaba3afFM7V4et4e6aOekzNE4+3xewc8OeZXnt4GjWeEhrE1l9oYpgvabiIQldWYLHngUIW2aXg2OY3j9666Eiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KMRNXkhn; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRoFsRQKGZKUMHhCbz2ROBpJ8lNtGFj8YLW1+bIHv3LwpVoFi/o6KwloB3rfJKWLaki3u5K9TrWrYqVH2sa+6Ih/rEYxqEo/WkpA1a5LFpwMPK6fyEVJIkq/x/9fs9YEdOwWSGAgfUHVdSFEEMBmlQgT8JlRzzkjd2n4CKGx1VRA1elqRrVprYxNVyqemRO/5oMZqUQVoiyyMUvqQG9jRpbJumXtd7fTu1E7YzE5z/9if68SL4sWdxQe5Dr/LHAa/4OE7I4KCLD1dA30uhTftT5EziRc93CcKtkLCAzAtrdgKxUz7cm7sG9W7I6JdR3NY3DTm+iqDDR+kbBnUsYeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMxiM99AxPAWOXtJyuakmfTl+99g4pIScw6r4JFl/6Q=;
 b=H6MZkoKl1ejih6LyNBalPj6colLxjOX3MLjh5JawliV3nkgwaVnyQxxrAHqlGxJqix2vlDlnZpH6oxPtmhS/cOjtlwi/GDiTHcQCEJXDHDgyr7vD7u04JwaRGaWM0fw20sPrtQ8s/EcsHn2tQdht85X+p4NYACX2yqkAdWcZOaemJVaVAxO5BYXYDksY2VXGIvW0tGxPMzKAN/vWm9i1DZKat8fHmWY2MAwpb6htEVTwvK/3Ep4sG9iZY3hPrxcgWs6AJ2rOC/0WE5pbtaDnfNhTrzV2XG+iaIQF0sKT5hp7TMgdHsoHPmPzhPKxSrlHa2NLryKzSfjQi6NNfID2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMxiM99AxPAWOXtJyuakmfTl+99g4pIScw6r4JFl/6Q=;
 b=KMRNXkhn96vWyp9JcnsDhQjJP8PJcO7u1GGWW4oXbovdhok/numg9Z3vCZ7U7qAY/b4NZb5OyjQt4oTJJbOmZckQ5Je1kX2Jql5N8AvlDvJ2bOTWj9+/3nmo+Zq38Vh+1PFfXCp5Vg4Fmi5rWrj6AvKn/YdbsIh7PU/afRrMrl4=
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.8; Wed, 7 Feb
 2024 21:55:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::e5) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 21:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 21:55:05 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 15:55:01 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "open list:AMD
 CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
	<linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Tim Van Patten" <timvp@google.com>
Subject: [PATCH 1/2] crypto: ccp: Avoid discarding errors in psp_send_platform_access_msg()
Date: Wed, 7 Feb 2024 15:54:38 -0600
Message-ID: <20240207215439.95871-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: b793ba3a-c491-4de3-f336-08dc282771fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ANPTg5sPrphLD9JhDgzwfG3t+JkKhzioEyOiqcHfcmckWORl62VEcdiJuO5ntuG1eKKP/vOmrlcZ/kgSZZQc8jvqSvyRGgkVRzs7h9nz90i/24V1gfEngbtuPQPZ3POVCghJg6YhPQrsUXkarHO/ajfbswa3iaSVTJDefcOJI98ABmokNvAI+PkFl1dYFe5B8UyNNs5ISE2MvVXkTCUedF13Zoc7+NAytSP9ncs+Fmss6+IwSPqlBflohEg9U2j7gD7y9j9wGbGfBifzoP54O+QcG0kfXt2QOUdKVbmkB9If2+jLpE4+vBbGohxIAoAAz37ssRJYs7wbVY5D3GaMSyK6Jid82ZXoulWvACBgJPDOQE0dD5O+qWzc7ncF3aaIgImBKptlMuifZrGl6ul/SQW+Sa1XiWvn91EfG9ryvQp/wHGjL8OgCMWpPDXipmNjOeGhCcmCkHR2nc/UDfmGIRe3k6ol6d/O0FqAP2wHliVC4TjnXxuIDUadDCO05tFo/zk3GjpVJaylSjl/+7WIPSrzp3AvcTqH5jhxi7HZO+8vO9N2akfQVL+Q+0oLeQhgF0bjCncu6uqGPv3QHxaMhz6DZqvSMBAFrOoMKc7nknU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(41300700001)(54906003)(70206006)(70586007)(316002)(6916009)(5660300002)(2906002)(8936002)(8676002)(4326008)(36756003)(44832011)(83380400001)(356005)(81166007)(82740400003)(7696005)(426003)(336012)(6666004)(478600001)(16526019)(2616005)(26005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 21:55:05.9221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b793ba3a-c491-4de3-f336-08dc282771fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

When the PSP_CMDRESP_STS field has an error set, the details of the
error are in `req->header->status`, and the caller will want to look
at them. But if there is no error set then caller may want to check
`req->header->status` separately.

Stop discarding these errors.

Reported-by: Tim Van Patten <timvp@google.com>
Fixes: 7ccc4f4e2e50 ("crypto: ccp - Add support for an interface for platform features")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/platform-access.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 94367bc49e35..792ae8d5b11a 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -120,7 +120,8 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 
 	/* Store the status in request header for caller to investigate */
 	cmd_reg = ioread32(cmd);
-	req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
+	if (FIELD_GET(PSP_CMDRESP_STS, cmd_reg))
+		req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
 	if (req->header.status) {
 		ret = -EIO;
 		goto unlock;
-- 
2.34.1


