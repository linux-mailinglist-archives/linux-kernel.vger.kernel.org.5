Return-Path: <linux-kernel+bounces-63993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E6C85384B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10ED61C214A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58643604CF;
	Tue, 13 Feb 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h1YdNxSa"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE502604AB;
	Tue, 13 Feb 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845698; cv=fail; b=WpluRkuuD0W1yV74ZtF9AvnVkIwKPrhlLOjyQwbKKOEX+qqdtkNFyZ/wWekWmYJpENkhUGYLAL30fQH8tBAVySB2mwmjy5TSlAOEe0HYEZ2WwV7bTWhgvJ3wt3EwPG9m3350eG+oznsRiC8LKaOiKVRRgS0wGb6kz48AHnxZBuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845698; c=relaxed/simple;
	bh=1g3yxX9ps+Kc2EwgJ/o6nEB4qaYHnnBgebJhg1tW+io=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARRE3qywaX6ddPOKTJBLu26BHRQC2QWjnt/geYwsKtMjGYL4Htyb+Sg2jSNKa/Yp25sLu1tz3uoZSVGsGqqW3NVBDFZtdhv27eRZftEcogoVOu9/13zyteSrXDsCENgExSNxuxE2bmzytIOGib4KXC/XokYMxIcFlKibscMM5DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h1YdNxSa; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWzzaz1A3ngnLJIvYkA8HDa6Zzf0bBwHTvp4qbIISeQ9ePCHcQWeZr1yBY8XMJxx7aSF+dU0WihqvXV7PxcqzSeCbUX7oCfwXF2LNEXDmhc19qN9v3iFp0qUBwDcql6OWnRkt5FYixaKgsWiZz595UcXQoHEU/kLV2G/uuSGicVwm/Ts8dWeOwZmSEp8fMNmT9sRC6X5LV6MANeMDyV4Kg+iZe8/itq3wOchOLRcEJmD5EHYauL2+bhFq0yrHrN4yD2eSbvWNVC0f2UhOuXo5I7yvCKzRL4O1M6MXeXTuHiv54hMh5l2QUvjv80V4Vr7zuQJc9ubPTgD0GuO13ss0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQWUb3HiBZR4g9/sYjsjEUNPhe8hXbvdVYnOW41dby4=;
 b=dsPeG8zF/+pnomRBdO1jV4SvcfH7Iz8cnW09uE03CG+VhOTrtlsPpph08ZFHG/57lsKsKzWdY8Bgp01D8Fxts++9U2w5JsYLsX8luu59sUTqSQcqQpVu5zTYfdXpHcDwnwEYSXvDIl+AGW7WVt+YznsS0Hl3J73XSE478v9OWa12/NRJwJUID3RvkYoHu76VnQTfpe6v1+U19pyhKSLYFtplpItLFqJcU2961346f6S0pNaYHRXhX6o9RWPVmbM99/Gv6zsvowbUZom5v9UiX7CJ920Yxlc5WqQ3I26HvkHzahSFkFexWyItfDo80f5g+9GlT3sG1tc2CNyS5f0dBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQWUb3HiBZR4g9/sYjsjEUNPhe8hXbvdVYnOW41dby4=;
 b=h1YdNxSal6OXAruNkN8GB981dqvT3ddV95GjFSbFvSVRdbCNdKRzaYNBLQxah8EgUyRTltqyIJpC/XiewAxa5cH1cT807knJS03f+zMVGHXFHTg2UUJWx/RJyPnlnV4bO8J6vSbz6ZxfF7eLHo1Bhq6ii+8bjXKW69NT7OXanAc=
Received: from MN2PR19CA0056.namprd19.prod.outlook.com (2603:10b6:208:19b::33)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 17:34:54 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::df) by MN2PR19CA0056.outlook.office365.com
 (2603:10b6:208:19b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Tue, 13 Feb 2024 17:34:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 17:34:52 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 11:34:50 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Mario Limonciello <mario.limonciello@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "open list:AMD
 CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - DB..."
	<linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] crypto: ccp: Update return values for some unit tests
Date: Tue, 13 Feb 2024 11:34:29 -0600
Message-ID: <20240213173429.43748-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213173429.43748-1-mario.limonciello@amd.com>
References: <20240213173429.43748-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b2d8b-3383-4847-d913-08dc2cba1630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9PDHNSGVlqr9EkkdxRpkRlnP5Zn4qFBWPPJTJNGPQhWfeINR5kwApjQ4/f3ITEYfgJXWo+MAWE0kdmxdDpZz1x/gCbEsYlmO0pqQdK0Rrc6tFzVcXmj73xJ5mhaizALCphScR3A4QHBMgdEju4VVOiT8KH0vsOFbBGojonYLAIfzhElYY8+CItG7p8RsuWeMly+dDtmet0INDsXRULHp+ce6ADiUfJIJfTKRrtQx4kQjckjf+vaxDFtbuKaHC82YB7lEDMzgPZKiobwCAYbho1oXZhZNnErlXthntw0vo517ulUaUn7q/f275jM0Cw+HgyetyVecW7+a3qQdekQHJ4yn148NkoP/M4MpXWrhx+0fPNcHzRJ/+24t0NsGjMBdCK0A8aMrg/EC7BCBokKN1EnlcUNHi38xNGVhJlzK7De5wJh3iX3ejsmB0kRowo3vd5/MD1LL4rvDuwsCtDjjsxgOQ75RvaHdybim9BqQ3V3pwo9x91KpovZDBMUtlwDFjZMGp3aom3eVuedhJ0hFXB0juwMXZD9DcOTyVR2f/yyctQoowZd+Drr4zWOKyTJHn7AE9AXkfKwglx/0xvEiowel2LH2/DzVBaFWuTbImyw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(8676002)(4326008)(8936002)(5660300002)(44832011)(2906002)(83380400001)(336012)(426003)(2616005)(1076003)(16526019)(26005)(36756003)(82740400003)(356005)(86362001)(81166007)(7696005)(70586007)(6916009)(54906003)(316002)(70206006)(6666004)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:34:52.7294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b2d8b-3383-4847-d913-08dc2cba1630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041

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


