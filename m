Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2A7CE751
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjJRTGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjJRTGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:06:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432D5114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJgMPvzsRR2nhRoQQ2Dij9m3M+ZMKOVW3256Xlb9rM6djBppm4/BZ7GcAwJ7vhWWOU/60xSB+ZnnN3bTyrQ0O1BH+7K3tm/Vu3reJ7CDOPiidujOBJuW402Kg2gw+CKMiUOoZkBq0QvJeHa5GmTAwn94dZ4VUnBR3MmDf29LkLJ4G/OL9fkNHbvQUSbccD78SfdnhydMDfqC6DBG0b3dVzw2cnB9sUQx0GKl9jPlWnsuSDEOcWrQ2BnYckvTkWsG5Yqy5I01xiniHyDkYkwPpSd3JtrhUj8HqCqL2UCMgRPIRW1kcgtsUeXgJRJkhSWM+fEEJx8J4Mm44OZU9XR7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Im8atycsycHleXZLr/YBd0vHUCysNar2hrIPOQWqkE=;
 b=DStr/WJgVr4z09G9gvqZb/mLi4zm0jPnhpzDcuVJHlQJ2hKI/9uz4zDkw4QfMBm2FH+3UEzEb4Uv6cIcKAJph0MH5uA1W3qXR0QLL/srII60uh5+sapTTfhmJXv641CPH9tntnG2Sh1XzSsbEFw5o9ARKYW4Lri+lptVAQrpHPqNrVcjq1tj6OTJgQ24IU7+ylVVhhCLAzHcEyKiw1NKUOCp8lc3ucPY2zPwDflcvbkrIYC5JNam0yhVC3Ms38bnsuf7Di8Emvt3Wl6loy1rNKKKU6wVqiu/OWMYFENbPFA5EOTfjNjK/KHbHe9ogNr4//mFSXKGKg4r6s9meYvPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Im8atycsycHleXZLr/YBd0vHUCysNar2hrIPOQWqkE=;
 b=lAqXuT2j9PCDE91TSRjoGTzMXbpXuak/HOO7mX7FsMiw+4aFzK7alydBeLyzfLepOBuIOxkfHWECz8T0mCdobZ4AVBnL7HOl5BBNVKLY0Bu2gQ5HTpsxdDsfOD6wRni2MVXeNqzKZIkDCnXRhB7P/BNS6qY4tPV22/aGIPhKco0=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by DM8PR12MB5493.namprd12.prod.outlook.com (2603:10b6:8:3d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 19:06:41 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::dd) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.37 via Frontend
 Transport; Wed, 18 Oct 2023 19:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Wed, 18 Oct 2023 19:06:40 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 18 Oct 2023 14:06:39 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH v2] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Date:   Wed, 18 Oct 2023 19:06:26 +0000
Message-ID: <20231018190626.445926-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DM8PR12MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d84e3d3-8fc2-4d12-1f77-08dbd00d5c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8s7rYSrNtsY0fwTVBiYwbC9TbOKV5O+SNprBuKQPr02P/eOZxa1a/ONv8SkjUlMSx+wbZ4C276MNyN4KTQ/lRi1DEU3XGc2tGnL9V4nK7N0b7Dus2u8UAZ/TONyxC6N/PcsL2ns2oB68y3QlQFd4V9OUHfMPdCmxYmaORTyiDHqL1/3+8boxt/sE2urQ0QyItSctRk0DQlnASfvDnrCWnIJO5PK2Vr41HayURMVIgPcZhhKQHx5Pvwzs0PJh2cEaAheblKMjosivJWsBxuu+ePs2kvuonITIcneIDEuJuP2d3eXkL6xvp6IkPNXA7GIiDd9k/HyDFnDBa8TV9+pQqVQvsmsN7rkwEUOoUnXiZsSRTTnHuUrbvEiyxIfKBw2wHcHgD3TRRCv7wW0CloRiwSFlvazsSy57MxfUNydRNXtOGMaSuvdmcx+HStbwA4m1LY5qUbx82V7fOl71VLf437J2VNJl1FjcVDdmsVwWBPA8C+9PTpBiDH6eC7ZktVZTck1rAl11RnF0oOzl3WRB8h4NiXzWKnntYlWEU0ArxyTdCpKdiGET2/zd1EFvqtIm+XO34E8tjTX4hpsO54yWah+lRaw+2UDdc5Hu7HshBl1jDh9dTA7XK4mKPdzPlYtSnUZXDAVnol7V2VSc1LbEDG9RcqwF+u1We92noDwYV7N4bvX5Bx7Vjbhhbku/YhqLDRE+ODud/Oz0t4W0vE3aNe7mjEhSc3SZdrmSkcNwnKEb/VWRvUyeZn8ESf52ln6DRwWMcJ2V7itbHDbOLPxc6zaJf7v19Unt3xuPcklQAs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(356005)(6666004)(36860700001)(40480700001)(426003)(336012)(2906002)(41300700001)(316002)(5660300002)(86362001)(4744005)(36756003)(70206006)(8936002)(110136005)(70586007)(1076003)(81166007)(26005)(47076005)(8676002)(7696005)(16526019)(478600001)(2616005)(921005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 19:06:40.5428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d84e3d3-8fc2-4d12-1f77-08dbd00d5c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Add support for 5-level paging in pg_level_to_pfn().

This issue was found during working on SNP guest kexec support,
this helper function is used during early boot stage for setting
of C-bit on the PTEs and additionally need this same helper for
switching shared pages to private during guest kexec.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/mem_encrypt_amd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6faea41e99b6..45914568596a 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -267,6 +267,10 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 		pfn = pud_pfn(*(pud_t *)kpte);
 		prot = pud_pgprot(*(pud_t *)kpte);
 		break;
+	case PG_LEVEL_512G:
+		pfn = p4d_pfn(*(p4d_t *)kpte);
+		prot = p4d_pgprot(*(p4d_t *)kpte);
+		break;
 	default:
 		WARN_ONCE(1, "Invalid level for kpte\n");
 		return 0;
-- 
2.25.1

