Return-Path: <linux-kernel+bounces-57244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B126584D594
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D1B1F2408A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BCE1350EA;
	Wed,  7 Feb 2024 21:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CqMOx/kX"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622741350F4;
	Wed,  7 Feb 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342914; cv=fail; b=LpDE1oZUQSGTdDGzGUCAK9j96YTvy8pVaGDvimkK4kZxkvdGReLOX0AcnSm2w3HWzG6oI7o4ogTYl3jhxBhaCHgkVmpqEFHh1Qe3gz2SU/rMYLXZvPUqJpUkuW/H3eUcnXF6L0PVreNKwwwYNfSRKttsGi7kldhhljA2p8FzbfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342914; c=relaxed/simple;
	bh=1g3yxX9ps+Kc2EwgJ/o6nEB4qaYHnnBgebJhg1tW+io=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRHm6jQIVZElhHKJ2w1n70wyWCGGGu1We5LieuusvOsh1g9guhfmxXR58UPnqyPrQrM6G+Hy0eutowwNrTDgEmXJe9xneIQdGcF7+5o54eu9ef1LXzENpRQ5wqJZQKGCDHmkSqirKDG80jjkHfd6+27G5C5KcIMoMt3D1oWBAsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CqMOx/kX; arc=fail smtp.client-ip=40.107.94.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UN446AUifdBpF3Bz35AjiXxHzu1Lm3WG0S4fcA4eVt1W9NOvCS3uEFkhLRZDbuKZOoqYWs1VtDgJvtcsSRRf4ZXa+Yx6+FwhGLEPPvizLWkqdG8dUQ2G/669O4OnkrdLb1kaQuIMhlClLQq+XhT4AYNwYbgTw4vBj6OqYhIFw4Hnvad8rKcVP0vlV1fB4HUzowBNUUqA0CPeZaikTRmZR1FBJcIwKpxYjyPHWvdhPBPxlyBfsnsyKQXc6bZN3XeOHgnLcGHKO5jjoy2kKiJILfOQYuohaXigLNqoucXQwZUGm+rxA+RC2xu7Nqxl6NBk7AM0OaKLj+DW86lkVPGPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQWUb3HiBZR4g9/sYjsjEUNPhe8hXbvdVYnOW41dby4=;
 b=HGJVyqO6I1ACIczlZcEfg0nKCMNfO2k/6z1EmGrtkxNwxpPAO6k1RZshZeTtZaZK1RFss78tg8IRQvoXgXUStjwR5GpfCzzCt8xvYUniaU42fL8kw/Fw8OaUq5q/Whd4qXwcBlCjBEQTOw9AniYhgBBmbYTIKvLmuyq+FSw6oOTukQVwwcXnarw5RIBwSoVPCSdkTPFSsjUaGDtK229w03S5veaSTFamLK3C9NrLq+O5VjVBGkJT6cqX64CGs0acM1AdQcRzqJIwLU+xJ6z3EnJ2tHMl/sEVa/FonlWqulV34l0yNUccstljCvMM4Ma8DntqkmczkSuuuXWFPLULRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQWUb3HiBZR4g9/sYjsjEUNPhe8hXbvdVYnOW41dby4=;
 b=CqMOx/kXXOpV+MHMFy7byiWxVBikXRMQwV6G48Jd1i6J0g7d9gyyXJJHqmeFAXd4oivjIcE6AQgO6GhbB7bccTauFgxUD8m/JnXbq6iu0j12/yaX5qFy8UdwKN7tvZxJ+9I2ffc3CksekmQJ2yLrYUewneZUFCR9qswNtDfJrAI=
Received: from CH0PR03CA0437.namprd03.prod.outlook.com (2603:10b6:610:10e::17)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 21:55:09 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::e7) by CH0PR03CA0437.outlook.office365.com
 (2603:10b6:610:10e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 21:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 21:55:08 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 15:55:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "open list:AMD
 CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
	<linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] crypto: ccp: Update return values for some unit tests
Date: Wed, 7 Feb 2024 15:54:39 -0600
Message-ID: <20240207215439.95871-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207215439.95871-1-mario.limonciello@amd.com>
References: <20240207215439.95871-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 20cdee06-4ffd-4f0f-1f3a-08dc2827734c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RWmNIaVlwpLb+Kv7sM4e8Z7sEyR2A+vMji2G8L1GcyQU/RO5kG4Gon77VBiLURHRYKBrlp2IZV+FS06pd/0b6e0G31hTB8dZigQNuZCipQaiPTqk/e0hOwlIoAQqgL/XwE387hyI0CfJDe7mcwGwf2awlB90GuV+bPzYcEER0f4ndV8ukjQgQ7m2BCatd8EzAb7ujjvz9KlCtxVjyXQL/IopjaEYhoouu6rRg37xW9ZxYTomZKzh+35efH/ANU7GYOUVKwi6MCm+WupGJyX3ZxoIvsabKHpk+nsFv7sIMAmstJtRC5OZTUbYAQLV6XqJCnS+GOW72DvV6R3pS3RAuwvi0fnjT977bg8DqYVBE9rZVK0u9zv65tITuoigv0NUIe3V0kjtdPc8Ki9YafDpWJHn9wb9Yw2XmI9AwiPS4oPUxi+IIZwquhwuzx++7nApKrwxDwVfSPoKbOLjK6PTXWuS3WQa0WzMYkaNT+OktsemhnDgU+Pi/YYQXVip3WVGX4XmRecGHkdsyPiFQjHnYcEAFjVej5l2v/Gd6EWdTQeawsLjraQZJxT/xhV4aGkePu4Ny0txP8L9BgbseJY0Sn02ITLRExUEkANsV0dxlSU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(336012)(26005)(426003)(2616005)(16526019)(1076003)(44832011)(41300700001)(36756003)(316002)(356005)(6666004)(83380400001)(82740400003)(478600001)(7696005)(81166007)(70206006)(4326008)(2906002)(86362001)(70586007)(54906003)(6916009)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 21:55:08.1409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20cdee06-4ffd-4f0f-1f3a-08dc2827734c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

Until authenticated the platform enforces a state machine. Adjust
unit tests with this in mind.

Correct the return codes for all the states the unit tests ends up
hitting:

* Set Param / Get Param: DBC_ERROR_BAD_STATE
* Set UID: DBC_ERROR_SIGNATURE_INVALID
* Authencitated Nonce: DBC_ERROR_BAD_PARAMETERS

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 tools/crypto/ccp/test_dbc.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/crypto/ccp/test_dbc.py b/tools/crypto/ccp/test_dbc.py
index 79de3638a01a..bb0e671be96d 100755
--- a/tools/crypto/ccp/test_dbc.py
+++ b/tools/crypto/ccp/test_dbc.py
@@ -138,12 +138,14 @@ class TestInvalidSignature(DynamicBoostControlTest):
 
     def test_authenticated_nonce(self) -> None:
         """fetch authenticated nonce"""
+        get_nonce(self.d, None)
         with self.assertRaises(OSError) as error:
             get_nonce(self.d, self.signature)
-        self.assertEqual(error.exception.errno, 1)
+        self.assertEqual(error.exception.errno, 22)
 
     def test_set_uid(self) -> None:
         """set uid"""
+        get_nonce(self.d, None)
         with self.assertRaises(OSError) as error:
             set_uid(self.d, self.uid, self.signature)
         self.assertEqual(error.exception.errno, 1)
@@ -152,13 +154,13 @@ class TestInvalidSignature(DynamicBoostControlTest):
         """fetch a parameter"""
         with self.assertRaises(OSError) as error:
             process_param(self.d, PARAM_GET_SOC_PWR_CUR, self.signature)
-        self.assertEqual(error.exception.errno, 1)
+        self.assertEqual(error.exception.errno, 11)
 
     def test_set_param(self) -> None:
         """set a parameter"""
         with self.assertRaises(OSError) as error:
             process_param(self.d, PARAM_SET_PWR_CAP, self.signature, 1000)
-        self.assertEqual(error.exception.errno, 1)
+        self.assertEqual(error.exception.errno, 11)
 
 
 class TestUnFusedSystem(DynamicBoostControlTest):
-- 
2.34.1


