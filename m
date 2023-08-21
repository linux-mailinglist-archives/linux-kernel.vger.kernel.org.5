Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3D3782B41
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjHUON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234739AbjHUON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:13:27 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1A3E3;
        Mon, 21 Aug 2023 07:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIhmIbJzjfze9DnNYCmP+rBw/CiXCOFc6QZlRyiQLGX3CH2btaklrdUJeRGEwKtfn7BS34Zi5G8m7ZT8ItORmSrSA69fmsL7+J+yamMqe23iNM90aV6A+Rp8ljR1+HBunuhcO+PKxmTYMnukVRlg4OEQL6sbNqfd1ahbB54F4WRjrrRUHebX6b7Z37IXL9CuAbxs/C+ZCeYRliRbjL3t9kShnUc+fzCWLgSeZmqD0BToPyJ2bzNQeT9BfO4iOH+OhHkYcguEfcwhKvMBNX3xAO9bddV6z/4CWh5S8pe6rzpvOtAYcLfUFPmhas6aoSUaQzZ8BYNkI1HBu9imk9dvtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9KM5mWg/BJ6/mpuJTOb2FpMy4a6qK7VzYdliLDFXWQ=;
 b=ApEFB9BDX7qdiMDaoSIvWRFJwcrvmCRMhqiiwWkKJvoQy/D5We8KbnVjegu2venWWc76QMgqrvgAuPtLoWNRIi9ZFmGcpaQf0USS99xMI89QaOv+YiHPq3aOubwjZoQHzEULyg+ychHvMcUvcbVKjOPtzNZ9bzkmCYep3yxa5tARGUyuTSS4ZlBW3AYDE9DpOho782sDkaDcBSw0y4qp39Kb9Jl0Ae82Naa2/stdB4l4JL9Nmq5L6m/GJ7hRBFJ4KYuqqMUYn8T07hbNJl/y6Avyz4GO5qCyEd10tbrTZMqyCZONVqMf/ecr3phuQ3sSN4EhzZy2LzVT2p+MLpEV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9KM5mWg/BJ6/mpuJTOb2FpMy4a6qK7VzYdliLDFXWQ=;
 b=2VLSS4PMOFRkKY9EJtTb3di1//a5Yv9BuXqsA3qGHIGI+ip3pKmjY1SeAHkMGyE3+ZnnsKJg8Vlzt4X9VeNj8b7M+yzAyv+qU9oW9+XEK2oqhoQ3hmXFLPAT+EipSG52Uplvuu/f4U4mm3NVEXG1iUdAzgh/DXFWMnz4ffBpZoY=
Received: from SA9PR13CA0134.namprd13.prod.outlook.com (2603:10b6:806:27::19)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 14:13:24 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::8) by SA9PR13CA0134.outlook.office365.com
 (2603:10b6:806:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14 via Frontend
 Transport; Mon, 21 Aug 2023 14:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 14:13:23 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 09:13:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        <stable@vger.kernel.org>, "Todd Brandt" <todd.e.brandt@intel.com>,
        Patrick Steinhardt <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
Subject: [PATCH v2] tpm: Don't make vendor check required for probe
Date:   Mon, 21 Aug 2023 09:02:30 -0500
Message-ID: <20230821140230.1168-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 522f7da1-5d78-448f-f536-08dba250c7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYvO8o+vrJtlYYzaEUZev/WGsImeLpk+oiwR9hXkDE6zOxstNxLiqoqwgSXFzfKL3qFqHQ85ma1/lZZ9aB5WaOB7zobiQXJglnd+GHisg/6z52XMk+vG7hfC6mOo7hSzZbkF7YBEPrhRBPutPWRS0G3VhJK2Gx8jAABu2ZtWQYaUb4DTSc+JGWI/hq66wbFtW6bDndE2HEYPNUUCvSIipFiCECA2BnhEoZFCxgREMXUPA1kf5n8blTSXY/qrRrbDTpp8Qkd4wZQOoUOnqb2nE/3sISfOx4c4VNn1jX0hp78uWKVxxTBG1yMkoyUCQQHC7vEZTvYs30Lx/V4/d25ZF7TfZfkZDN4QCDs2zuDL5RTC7kgWuajSZiM6ZIPTpQgsElLA5YbG95z1tCTi0Lds3W15WMOUNHqM8f8B9lCOt7Xe5BgtLflqWR6Mg4BpeUztaYX+0nc67QqbP4kNb73FP6uWSVIFAL+gj3dWQc79GqVYZmKqFBJNl67YWPpEyCyqLWZ1nkceZ/WZAqQKH1ntzz20xAHMy76Pl/QgSDQDejzzloRFyuXVBtDXhpNC21Nh76Xi9NGs9vb1PecBC51buTm/8p4qNv5ChJoKJolQ16gzPzC8lGf+5P/R2XXP6T/q9ALOTbdeif14lBd+dDJjJP9WHCACDsx+XUY+5Hp96IvI0hyfhhXulOplSJ1s+nOvciSjZeAu70IFshntCWaMiN9EQEIBLj3rN57th8M8V6IB5qHV/5EsPv9ndvppfxZZieLrDtzAVZ0a/iOdh3xYoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(83380400001)(2906002)(7696005)(40480700001)(5660300002)(336012)(44832011)(426003)(16526019)(26005)(86362001)(47076005)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(6916009)(54906003)(70586007)(966005)(478600001)(82740400003)(356005)(81166007)(6666004)(41300700001)(40460700003)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 14:13:23.5679
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522f7da1-5d78-448f-f536-08dba250c7cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
reported systems the TPM doesn't reply at bootup and returns back the
command code. This makes the TPM fail probe.

As this isn't crucial for anything but AMD fTPM and AMD fTPM works, check
the chip vendor and if it's not AMD don't run the checks.

Cc: stable@vger.kernel.org
Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
Reported-by: Todd Brandt <todd.e.brandt@intel.com>
Reported-by: Patrick Steinhardt <ps@pks.im>
Reported-by: Ronan Pigott <ronan@rjp.ie>
Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Check x86 vendor for AMD
---
 drivers/char/tpm/tpm_crb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 9eb1a18590123..7faf670201ccc 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -465,8 +465,12 @@ static bool crb_req_canceled(struct tpm_chip *chip, u8 status)
 
 static int crb_check_flags(struct tpm_chip *chip)
 {
+	int ret = 0;
+#ifdef CONFIG_X86
 	u32 val;
-	int ret;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return ret;
 
 	ret = crb_request_locality(chip, 0);
 	if (ret)
@@ -481,6 +485,7 @@ static int crb_check_flags(struct tpm_chip *chip)
 
 release:
 	crb_relinquish_locality(chip, 0);
+#endif
 
 	return ret;
 }
-- 
2.34.1

