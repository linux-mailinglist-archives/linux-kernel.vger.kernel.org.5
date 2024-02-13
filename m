Return-Path: <linux-kernel+bounces-63992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02673853849
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2716F1C21976
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406DAD55;
	Tue, 13 Feb 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zt9Isu3j"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964660273;
	Tue, 13 Feb 2024 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845697; cv=fail; b=ieNc7lJBYQ1JredJKtSPs2R7ESE3G67/cTiLQtyYi8zqD1G3ktDd5y4py6iYkhX00EnGYS4LzoOC2n3QzyOy8vFztPCRFHcv6M5i6n+PmjfFNilz08xKGBaJPN8fwyki3SmAPXirzWbTg9G73E6QofaQ3e6Elr/tJxxfmHg3RiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845697; c=relaxed/simple;
	bh=DQXS6tLUlxjGfgFOIRduZ6eoZcmROQvI73UKGex59QQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9y936BWJfXxfRYT7ncGcNznNkfHhL5g/NKlwncNhXL54jTld91WOzA6V01dxmUhs4k/59uiVYnEVkdqNlnoSZQzYMhEPhjX7c7tSG2KaMgy38qTRMW7vxLl8xmZrN7lm5B7zSQqqUHpBv38uQSzZcprvgXd8UOclV8udq62IhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zt9Isu3j; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CnhyQQUs/GThTBLQF1P05H6k24d5mkL8hTTlWoox+M9wyQklVKlq5I5Z0w7LzOs2ZPaCPzF98onE4FSnp2czEfbysI/1Nh/Bwa7dLJbSzH4Pa5oDXYCSIDQSrGTDRQtkNlC9BWhJjF/uhzz/kqwf7cNS5dzB9QGB5v0ANhJN2zJgjMNd9AA2gGniWO6YJojLFwD0iM5oDpj8UqaYEGiQrUeoCwyp4eRXaJ/mcxE7WAVXNEMIIuY19EU2AjLnGBu0vdJ9L5bEEDCm3RzJClhaLMBxB5EmM6wrLJCejqVyTV4l6RUbHHs87WcyySnFYz3pvPA+MQERgGgZ2UNMYpso5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnof79B9tpM2EMXHBlSOaE61DrpyVkqMA9YxAksA6uM=;
 b=GyFln13S1zi2JNYh04qJZcRqqGmaorO5RoO+69GNX0u1S48aEFVuoOFOR87jEV4nTGIZmiJMWpSeYvbyLzMMsCWuD2FCboS35kDD6bnCN0Auske2LHiOTSEqH17I4BpvUxEEgEX14eTtw/Sr9fy49LUG76l+VTHGbBbhD/SGl50+xFmWCqgId1FUWT+gs+x1SK8kEx+GP6tYlSzmeiCcGTIWjWCkcmXmsHeP3nyPEfQgT91iceZBJqX3scYt2vrG/dO9IhIRmxmBBhq0HIpNjJuLtpzHCu27S7R0eFvlxb2Zgl0H+ZK0dTGqP54xArjz/w8AAAFxcuk8STVCKnWsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnof79B9tpM2EMXHBlSOaE61DrpyVkqMA9YxAksA6uM=;
 b=zt9Isu3jwJWsOLw56zbE6ciryCrubqsO43+yp86jB3VcdIPfZ85vtUyktNZa/0NA3T1+RpDPjMYBeLcFneYT5LxoYvbwASkYVi+Q3qrXyV0IMR2R0MAcMYjEtWJSVQhJ0MT2xgOWP7pePsQ0opTBXf7WNm/RpTjYATGHC+Vkstw=
Received: from MN2PR19CA0038.namprd19.prod.outlook.com (2603:10b6:208:19b::15)
 by DM4PR12MB5246.namprd12.prod.outlook.com (2603:10b6:5:399::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:34:52 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::a9) by MN2PR19CA0038.outlook.office365.com
 (2603:10b6:208:19b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 13 Feb 2024 17:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:34:51 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:34:49 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "open list:AMD
 CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
	<linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"Tim Van Patten" <timvp@google.com>
Subject: [PATCH v2 1/2] crypto: ccp: Avoid discarding errors in psp_send_platform_access_msg()
Date: Tue, 13 Feb 2024 11:34:28 -0600
Message-ID: <20240213173429.43748-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB5246:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae68164-66a0-4595-08bd-08dc2cba155f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Cx+9gjyw4L//yvPGp2uXntCRVs9Dm6UUJtZct1z7CBePrMvfZkfn2uZYDg4dEX4cXlGNrYotZEgWRd5scZoK/N5RUEQjk7+0Oug/lR26mETLkZG2qxvvicLwUsKmbbxnHm400NH/nBe9LwE/wpNAM6vgW9BtjPN2OhATOp7v3ShvG9N+HI/Wpn1slq1Tlzg5ta242Z6yUHtSXU9cHCkOKX17NKSZ6hOemCN9XVDDhjzssXUFg05+qrXkheXMIEw82ZJLJ1gMvZA0iX6JqtwKj21fL8YIGV0qmT27TBmUi9GSEy3zuwDcOBE1+0GxKQUPCND55cqgkEDFePYgdooLb6vb6P2ubnZxXvfLPliC1SrIeoI2udP4XLe+kzXQrCtOoF3HGwJM6POAPS8fN2b9/Nv54e3FhxOKW6V8iDfT3Fo9N0rqqeJrNuTjkLx05PFiRNfk/rl+A/Jnoo0UuSfxrj3V9mkChlA+YihC3sszUDmI1oYEXXF+wlu3wMZRyIMhkGjiNZjBP47hOUt3PKuxmdWYAXNRYFqmsnai5AsZjkboxbqXfTfpqpPvqweimReyhtPHg90X+XiuLb6MdFnLS0iO53pnO710061rCcy3/A=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(54906003)(6666004)(316002)(2906002)(44832011)(5660300002)(70586007)(70206006)(86362001)(8676002)(6916009)(8936002)(4326008)(478600001)(41300700001)(2616005)(1076003)(26005)(36756003)(356005)(426003)(81166007)(336012)(83380400001)(16526019)(82740400003)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:34:51.3544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae68164-66a0-4595-08bd-08dc2cba155f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5246

Errors can potentially occur in the "processing" of PSP commands or
commands can be processed successfully but still return an error code in
the header.

This second case was being discarded because PSP communication worked but
the command returned an error code in the payload header.

Capture both cases and return them to the caller as -EIO for the caller
to investigate. The caller can detect the latter by looking at
`req->header->status`.

Reported-and-tested-by: Tim Van Patten <timvp@google.com>
Fixes: 7ccc4f4e2e50 ("crypto: ccp - Add support for an interface for platform features")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update tag for Tim
 * Reword commit message
---
 drivers/crypto/ccp/platform-access.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/platform-access.c b/drivers/crypto/ccp/platform-access.c
index 94367bc49e35..1b8ed3389733 100644
--- a/drivers/crypto/ccp/platform-access.c
+++ b/drivers/crypto/ccp/platform-access.c
@@ -118,9 +118,16 @@ int psp_send_platform_access_msg(enum psp_platform_access_msg msg,
 		goto unlock;
 	}
 
-	/* Store the status in request header for caller to investigate */
+	/*
+	 * Read status from PSP. If status is non-zero, it indicates an error
+	 * occurred during "processing" of the command.
+	 * If status is zero, it indicates the command was "processed"
+	 * successfully, but the result of the command is in the payload.
+	 * Return both cases to the caller as -EIO to investigate.
+	 */
 	cmd_reg = ioread32(cmd);
-	req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
+	if (FIELD_GET(PSP_CMDRESP_STS, cmd_reg))
+		req->header.status = FIELD_GET(PSP_CMDRESP_STS, cmd_reg);
 	if (req->header.status) {
 		ret = -EIO;
 		goto unlock;
-- 
2.34.1


