Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364BF7D610A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 07:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJYFPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 01:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJYFPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 01:15:32 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D84131;
        Tue, 24 Oct 2023 22:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO9Hq+TeJyjm4NbSRxzKe1ABaH312UhWsUMCNyl61wIO6sc6teU0vf3oDJZit58bScqa76NoVue9Hex/ZESJ06uvvqoze9FKsdkxqumnszbYPCvNjAizNPodzgKx+K4ku8J6nvQyubYDF58KQqlgvUvPnL6SLK+N+G3X6g37vajchZGVc1T1/NC6spI5xekWv98ezC4Iq87cG07EKgn1RBIUul9JDztX1wwJEF9RRrpvlb1Plf3ScVNL/dhDGr6gZqLjGya2tKZ0VIJmLbt8h8ETzK+HEqigqzNa01dq7sOdl8+Rw+JMBpi1cCHbJI1xiATV0l/l83tMVHvyfIsBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe79dARiAtr17PvIhqKaj2KGicwBdQKFv2L8L2481Q0=;
 b=ZxSG8/jx+Je82ydy1bdAokiWceQ+Qg/6bs8ntnklRq0vynGw/xamNiU1g8EM44V//NUz/iDIp6onPY85PgN0FZl9I+uImCFFPPPVhXlUuDmwlGv1ZQGwrtblQfAet7PNLgyHPd0968EfBy1rg/bb8U8QO6utsW5hXqYvp9vCwscxE3/GHaEhhTGIjai9m6dxjpShcmo+JtC1Ad+SazA5kymR2Vqq9ID17/vHFkuEqYSItrsDVnlgHne2cAYufOkcBHE55SaunByThGibRfc61N1t1eSA55lwX74nNRawH2omz+WlaY/mndU5oWkRMLx6kGqMgmEWPZ/OJzzYj/oWXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe79dARiAtr17PvIhqKaj2KGicwBdQKFv2L8L2481Q0=;
 b=gfwXezwNET4+EWQjphxRfvi8n7qUuCGdMFFl2Gr47rhQ3F5zje/5p0ArqjRQZkAOh8q2FV4N4hONHlN0T8zOVEHJR7TknafAU4j82MYqbtTaROMYwBqadVxHU6Mb3HCFW3m04qJl2+HB3WtTZKBSeazQHq+9McH/eMhV6xZlRQo=
Received: from CYZPR20CA0014.namprd20.prod.outlook.com (2603:10b6:930:a2::8)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 05:15:26 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:a2:cafe::69) by CYZPR20CA0014.outlook.office365.com
 (2603:10b6:930:a2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 05:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 05:15:26 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 25 Oct
 2023 00:15:22 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code descriptions
Date:   Wed, 25 Oct 2023 05:14:52 +0000
Message-ID: <20231025051455.101424-2-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025051455.101424-1-muralimk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 650b0b02-5628-4f84-6bc7-08dbd51965bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9XKWzEH0VIYVCW+bWzFnbf7rEptJTowSR+NPkzQJJ1eakuCB2D1r8EJPSTLf3ULNR0YYGwr6tKSWTU04tGZUAIVK4x7BAIarnyRU9NAi2PNzmm8JjlNy8RDU5gghZigOR1XMYnAiqN32nYDNX4V2r3K+h0TlnnQssCeaIm0mdee/kl1rgVWbU1oymmLZh6832tJvy+YNI0dUg8g5N72z35MsOwnU3mdALs8EolgfnSuXrMGQNTivrvPmrR1P+/CGeJ1YEAtZ5DO0dixe6ilVFNfgkUoaHUmjcqknux+7exws0XMlY5Uh2coxdEH7JZ838nsRQ9oiDLZIBghzrLtfoaebZ8rfB93jEUlmmAoCBZgt4t5GJWAKXpUWMziQSzMTAwDdpR0THHUbXiTaAW8VEE3uzuljP7goks+2vRpFa5FxVgCo5wmu0XJ1UApXQtyLiptfo0vjhLecinSCO6CZHFluKXuXm5eZAx3zB/EiOcgRn5cj1pwR8vGc4WBz4Umg+KW62rfEHZX5dVqJEkfj+gEMvvF0iXUQdFOUpd4MwVF0lXoFsofryaSKaL9vVUUJ19CICP0YGtqnSPP6Wb5c1tYM9nLvOISLuz65s13Yj9wnYaeRX51DA3tz15NXb6MJ9YBbNOCbxkgNJ/+Y/we7BDgnUn4/c2E3y8h+p+1180hNTbj8r5qiKWG6aDVNvT7P73p77S6lcfgmdY91QMOAeoJAP2elb62FNB1K/9BR39l5oJwoKAI+pRImaBbACLlWaHOm03lOEiupmt3iPf+TdDtjcJ7XEj6Vwv5DCnVVn4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(46966006)(36840700001)(40470700004)(26005)(478600001)(83380400001)(966005)(316002)(6916009)(4326008)(70206006)(54906003)(70586007)(8676002)(8936002)(5660300002)(7696005)(40480700001)(356005)(36860700001)(81166007)(47076005)(82740400003)(36756003)(336012)(40460700003)(426003)(16526019)(1076003)(41300700001)(6666004)(2616005)(30864003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 05:15:26.0062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650b0b02-5628-4f84-6bc7-08dbd51965bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD systems with Scalable MCA, each machine check error of a SMCA bank
type has an associated bit position in the bank's control (CTL) register.

An error's bit position in the CTL register is used during error decoding
for offsetting into the corresponding bank's error description structure.
As new errors are being added in newer AMD systems for existing SMCA bank
types, the underlying SMCA architecture guarantees that the bit positions
of existing errors are not altered.

However, on some AMD systems some of the existing bit definitions in the
CTL register of SMCA bank type are reassigned without defining new HWID
and McaType. Consequently, the errors whose bit definitions have been
reassigned in the CTL register are being erroneously decoded.

Remove SMCA Extended Error Code descriptions. This avoids decoding issues
for incorrectly reassigned bits, and avoids the related maintenance burden
in the kernel. This decoding can be done in external tools or by referring
to AMD documentation. The bank type and Extended Error Code value for an
error will continue to be printed as a convenience.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
The SMCA error decoding already exists in rasdaemon and future bank decoding
is supported from below patches merged in rasdaemon.
https://github.com/mchehab/rasdaemon/commit/1f74a59ee33b7448b00d7ba13d5ecd4918b9853c rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types
https://github.com/mchehab/rasdaemon/commit/2d15882a0cbfce0b905039bebc811ac8311cd739 rasdaemon: Handle reassigned bit definitions for UMC bank

 drivers/edac/mce_amd.c | 480 -----------------------------------------
 1 file changed, 480 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 9215c06783df..3a67f02a34ad 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -143,482 +143,6 @@ static const char * const mc6_mce_desc[] = {
 	"Status Register File",
 };
 
-/* Scalable MCA error strings */
-static const char * const smca_ls_mce_desc[] = {
-	"Load queue parity error",
-	"Store queue parity error",
-	"Miss address buffer payload parity error",
-	"Level 1 TLB parity error",
-	"DC Tag error type 5",
-	"DC Tag error type 6",
-	"DC Tag error type 1",
-	"Internal error type 1",
-	"Internal error type 2",
-	"System Read Data Error Thread 0",
-	"System Read Data Error Thread 1",
-	"DC Tag error type 2",
-	"DC Data error type 1 and poison consumption",
-	"DC Data error type 2",
-	"DC Data error type 3",
-	"DC Tag error type 4",
-	"Level 2 TLB parity error",
-	"PDC parity error",
-	"DC Tag error type 3",
-	"DC Tag error type 5",
-	"L2 Fill Data error",
-};
-
-static const char * const smca_ls2_mce_desc[] = {
-	"An ECC error was detected on a data cache read by a probe or victimization",
-	"An ECC error or L2 poison was detected on a data cache read by a load",
-	"An ECC error was detected on a data cache read-modify-write by a store",
-	"An ECC error or poison bit mismatch was detected on a tag read by a probe or victimization",
-	"An ECC error or poison bit mismatch was detected on a tag read by a load",
-	"An ECC error or poison bit mismatch was detected on a tag read by a store",
-	"An ECC error was detected on an EMEM read by a load",
-	"An ECC error was detected on an EMEM read-modify-write by a store",
-	"A parity error was detected in an L1 TLB entry by any access",
-	"A parity error was detected in an L2 TLB entry by any access",
-	"A parity error was detected in a PWC entry by any access",
-	"A parity error was detected in an STQ entry by any access",
-	"A parity error was detected in an LDQ entry by any access",
-	"A parity error was detected in a MAB entry by any access",
-	"A parity error was detected in an SCB entry state field by any access",
-	"A parity error was detected in an SCB entry address field by any access",
-	"A parity error was detected in an SCB entry data field by any access",
-	"A parity error was detected in a WCB entry by any access",
-	"A poisoned line was detected in an SCB entry by any access",
-	"A SystemReadDataError error was reported on read data returned from L2 for a load",
-	"A SystemReadDataError error was reported on read data returned from L2 for an SCB store",
-	"A SystemReadDataError error was reported on read data returned from L2 for a WCB store",
-	"A hardware assertion error was reported",
-	"A parity error was detected in an STLF, SCB EMEM entry or SRB store data by any access",
-};
-
-static const char * const smca_if_mce_desc[] = {
-	"Op Cache Microtag Probe Port Parity Error",
-	"IC Microtag or Full Tag Multi-hit Error",
-	"IC Full Tag Parity Error",
-	"IC Data Array Parity Error",
-	"Decoupling Queue PhysAddr Parity Error",
-	"L0 ITLB Parity Error",
-	"L1 ITLB Parity Error",
-	"L2 ITLB Parity Error",
-	"BPQ Thread 0 Snoop Parity Error",
-	"BPQ Thread 1 Snoop Parity Error",
-	"L1 BTB Multi-Match Error",
-	"L2 BTB Multi-Match Error",
-	"L2 Cache Response Poison Error",
-	"System Read Data Error",
-	"Hardware Assertion Error",
-	"L1-TLB Multi-Hit",
-	"L2-TLB Multi-Hit",
-	"BSR Parity Error",
-	"CT MCE",
-};
-
-static const char * const smca_l2_mce_desc[] = {
-	"L2M Tag Multiple-Way-Hit error",
-	"L2M Tag or State Array ECC Error",
-	"L2M Data Array ECC Error",
-	"Hardware Assert Error",
-};
-
-static const char * const smca_de_mce_desc[] = {
-	"Micro-op cache tag parity error",
-	"Micro-op cache data parity error",
-	"Instruction buffer parity error",
-	"Micro-op queue parity error",
-	"Instruction dispatch queue parity error",
-	"Fetch address FIFO parity error",
-	"Patch RAM data parity error",
-	"Patch RAM sequencer parity error",
-	"Micro-op buffer parity error",
-	"Hardware Assertion MCA Error",
-};
-
-static const char * const smca_ex_mce_desc[] = {
-	"Watchdog Timeout error",
-	"Physical register file parity error",
-	"Flag register file parity error",
-	"Immediate displacement register file parity error",
-	"Address generator payload parity error",
-	"EX payload parity error",
-	"Checkpoint queue parity error",
-	"Retire dispatch queue parity error",
-	"Retire status queue parity error",
-	"Scheduling queue parity error",
-	"Branch buffer queue parity error",
-	"Hardware Assertion error",
-	"Spec Map parity error",
-	"Retire Map parity error",
-};
-
-static const char * const smca_fp_mce_desc[] = {
-	"Physical register file (PRF) parity error",
-	"Freelist (FL) parity error",
-	"Schedule queue parity error",
-	"NSQ parity error",
-	"Retire queue (RQ) parity error",
-	"Status register file (SRF) parity error",
-	"Hardware assertion",
-};
-
-static const char * const smca_l3_mce_desc[] = {
-	"Shadow Tag Macro ECC Error",
-	"Shadow Tag Macro Multi-way-hit Error",
-	"L3M Tag ECC Error",
-	"L3M Tag Multi-way-hit Error",
-	"L3M Data ECC Error",
-	"SDP Parity Error or SystemReadDataError from XI",
-	"L3 Victim Queue Parity Error",
-	"L3 Hardware Assertion",
-};
-
-static const char * const smca_cs_mce_desc[] = {
-	"Illegal Request",
-	"Address Violation",
-	"Security Violation",
-	"Illegal Response",
-	"Unexpected Response",
-	"Request or Probe Parity Error",
-	"Read Response Parity Error",
-	"Atomic Request Parity Error",
-	"Probe Filter ECC Error",
-};
-
-static const char * const smca_cs2_mce_desc[] = {
-	"Illegal Request",
-	"Address Violation",
-	"Security Violation",
-	"Illegal Response",
-	"Unexpected Response",
-	"Request or Probe Parity Error",
-	"Read Response Parity Error",
-	"Atomic Request Parity Error",
-	"SDP read response had no match in the CS queue",
-	"Probe Filter Protocol Error",
-	"Probe Filter ECC Error",
-	"SDP read response had an unexpected RETRY error",
-	"Counter overflow error",
-	"Counter underflow error",
-};
-
-static const char * const smca_pie_mce_desc[] = {
-	"Hardware Assert",
-	"Register security violation",
-	"Link Error",
-	"Poison data consumption",
-	"A deferred error was detected in the DF"
-};
-
-static const char * const smca_umc_mce_desc[] = {
-	"DRAM ECC error",
-	"Data poison error",
-	"SDP parity error",
-	"Advanced peripheral bus error",
-	"Address/Command parity error",
-	"Write data CRC error",
-	"DCQ SRAM ECC error",
-	"AES SRAM ECC error",
-};
-
-static const char * const smca_umc2_mce_desc[] = {
-	"DRAM ECC error",
-	"Data poison error",
-	"SDP parity error",
-	"Reserved",
-	"Address/Command parity error",
-	"Write data parity error",
-	"DCQ SRAM ECC error",
-	"Reserved",
-	"Read data parity error",
-	"Rdb SRAM ECC error",
-	"RdRsp SRAM ECC error",
-	"LM32 MP errors",
-};
-
-static const char * const smca_pb_mce_desc[] = {
-	"An ECC error in the Parameter Block RAM array",
-};
-
-static const char * const smca_psp_mce_desc[] = {
-	"An ECC or parity error in a PSP RAM instance",
-};
-
-static const char * const smca_psp2_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Instruction Cache Bank 0 ECC or parity error",
-	"Instruction Cache Bank 1 ECC or parity error",
-	"Instruction Tag Ram 0 parity error",
-	"Instruction Tag Ram 1 parity error",
-	"Data Cache Bank 0 ECC or parity error",
-	"Data Cache Bank 1 ECC or parity error",
-	"Data Cache Bank 2 ECC or parity error",
-	"Data Cache Bank 3 ECC or parity error",
-	"Data Tag Bank 0 parity error",
-	"Data Tag Bank 1 parity error",
-	"Data Tag Bank 2 parity error",
-	"Data Tag Bank 3 parity error",
-	"Dirty Data Ram parity error",
-	"TLB Bank 0 parity error",
-	"TLB Bank 1 parity error",
-	"System Hub Read Buffer ECC or parity error",
-};
-
-static const char * const smca_smu_mce_desc[] = {
-	"An ECC or parity error in an SMU RAM instance",
-};
-
-static const char * const smca_smu2_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"System Hub Read Buffer ECC or parity error",
-	"PHY RAM ECC error",
-};
-
-static const char * const smca_mp5_mce_desc[] = {
-	"High SRAM ECC or parity error",
-	"Low SRAM ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-};
-
-static const char * const smca_mpdma_mce_desc[] = {
-	"Main SRAM [31:0] bank ECC or parity error",
-	"Main SRAM [63:32] bank ECC or parity error",
-	"Main SRAM [95:64] bank ECC or parity error",
-	"Main SRAM [127:96] bank ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"Data Cache Bank A ECC or parity error",
-	"Data Cache Bank B ECC or parity error",
-	"Data Tag Cache Bank A ECC or parity error",
-	"Data Tag Cache Bank B ECC or parity error",
-	"Instruction Cache Bank A ECC or parity error",
-	"Instruction Cache Bank B ECC or parity error",
-	"Instruction Tag Cache Bank A ECC or parity error",
-	"Instruction Tag Cache Bank B ECC or parity error",
-	"System Hub Read Buffer ECC or parity error",
-	"MPDMA TVF DVSEC Memory ECC or parity error",
-	"MPDMA TVF MMIO Mailbox0 ECC or parity error",
-	"MPDMA TVF MMIO Mailbox1 ECC or parity error",
-	"MPDMA TVF Doorbell Memory ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 0 ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 1 ECC or parity error",
-	"MPDMA TVF SDP Slave Memory 2 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 0 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 1 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 2 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 3 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 4 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 5 ECC or parity error",
-	"MPDMA TVF SDP Master Memory 6 ECC or parity error",
-	"MPDMA PTE Command FIFO ECC or parity error",
-	"MPDMA PTE Hub Data FIFO ECC or parity error",
-	"MPDMA PTE Internal Data FIFO ECC or parity error",
-	"MPDMA PTE Command Memory DMA ECC or parity error",
-	"MPDMA PTE Command Memory Internal ECC or parity error",
-	"MPDMA PTE DMA Completion FIFO ECC or parity error",
-	"MPDMA PTE Tablewalk Completion FIFO ECC or parity error",
-	"MPDMA PTE Descriptor Completion FIFO ECC or parity error",
-	"MPDMA PTE ReadOnly Completion FIFO ECC or parity error",
-	"MPDMA PTE DirectWrite Completion FIFO ECC or parity error",
-	"SDP Watchdog Timer expired",
-};
-
-static const char * const smca_nbio_mce_desc[] = {
-	"ECC or Parity error",
-	"PCIE error",
-	"SDP ErrEvent error",
-	"SDP Egress Poison Error",
-	"IOHC Internal Poison Error",
-};
-
-static const char * const smca_pcie_mce_desc[] = {
-	"CCIX PER Message logging",
-	"CCIX Read Response with Status: Non-Data Error",
-	"CCIX Write Response with Status: Non-Data Error",
-	"CCIX Read Response with Status: Data Error",
-	"CCIX Non-okay write response with data error",
-};
-
-static const char * const smca_pcie2_mce_desc[] = {
-	"SDP Parity Error logging",
-};
-
-static const char * const smca_xgmipcs_mce_desc[] = {
-	"Data Loss Error",
-	"Training Error",
-	"Flow Control Acknowledge Error",
-	"Rx Fifo Underflow Error",
-	"Rx Fifo Overflow Error",
-	"CRC Error",
-	"BER Exceeded Error",
-	"Tx Vcid Data Error",
-	"Replay Buffer Parity Error",
-	"Data Parity Error",
-	"Replay Fifo Overflow Error",
-	"Replay Fifo Underflow Error",
-	"Elastic Fifo Overflow Error",
-	"Deskew Error",
-	"Flow Control CRC Error",
-	"Data Startup Limit Error",
-	"FC Init Timeout Error",
-	"Recovery Timeout Error",
-	"Ready Serial Timeout Error",
-	"Ready Serial Attempt Error",
-	"Recovery Attempt Error",
-	"Recovery Relock Attempt Error",
-	"Replay Attempt Error",
-	"Sync Header Error",
-	"Tx Replay Timeout Error",
-	"Rx Replay Timeout Error",
-	"LinkSub Tx Timeout Error",
-	"LinkSub Rx Timeout Error",
-	"Rx CMD Packet Error",
-};
-
-static const char * const smca_xgmiphy_mce_desc[] = {
-	"RAM ECC Error",
-	"ARC instruction buffer parity error",
-	"ARC data buffer parity error",
-	"PHY APB error",
-};
-
-static const char * const smca_nbif_mce_desc[] = {
-	"Timeout error from GMI",
-	"SRAM ECC error",
-	"NTB Error Event",
-	"SDP Parity error",
-};
-
-static const char * const smca_sata_mce_desc[] = {
-	"Parity error for port 0",
-	"Parity error for port 1",
-	"Parity error for port 2",
-	"Parity error for port 3",
-	"Parity error for port 4",
-	"Parity error for port 5",
-	"Parity error for port 6",
-	"Parity error for port 7",
-};
-
-static const char * const smca_usb_mce_desc[] = {
-	"Parity error or ECC error for S0 RAM0",
-	"Parity error or ECC error for S0 RAM1",
-	"Parity error or ECC error for S0 RAM2",
-	"Parity error for PHY RAM0",
-	"Parity error for PHY RAM1",
-	"AXI Slave Response error",
-};
-
-static const char * const smca_gmipcs_mce_desc[] = {
-	"Data Loss Error",
-	"Training Error",
-	"Replay Parity Error",
-	"Rx Fifo Underflow Error",
-	"Rx Fifo Overflow Error",
-	"CRC Error",
-	"BER Exceeded Error",
-	"Tx Fifo Underflow Error",
-	"Replay Buffer Parity Error",
-	"Tx Overflow Error",
-	"Replay Fifo Overflow Error",
-	"Replay Fifo Underflow Error",
-	"Elastic Fifo Overflow Error",
-	"Deskew Error",
-	"Offline Error",
-	"Data Startup Limit Error",
-	"FC Init Timeout Error",
-	"Recovery Timeout Error",
-	"Ready Serial Timeout Error",
-	"Ready Serial Attempt Error",
-	"Recovery Attempt Error",
-	"Recovery Relock Attempt Error",
-	"Deskew Abort Error",
-	"Rx Buffer Error",
-	"Rx LFDS Fifo Overflow Error",
-	"Rx LFDS Fifo Underflow Error",
-	"LinkSub Tx Timeout Error",
-	"LinkSub Rx Timeout Error",
-	"Rx CMD Packet Error",
-	"LFDS Training Timeout Error",
-	"LFDS FC Init Timeout Error",
-	"Data Loss Error",
-};
-
-struct smca_mce_desc {
-	const char * const *descs;
-	unsigned int num_descs;
-};
-
-static struct smca_mce_desc smca_mce_descs[] = {
-	[SMCA_LS]	= { smca_ls_mce_desc,	ARRAY_SIZE(smca_ls_mce_desc)	},
-	[SMCA_LS_V2]	= { smca_ls2_mce_desc,	ARRAY_SIZE(smca_ls2_mce_desc)	},
-	[SMCA_IF]	= { smca_if_mce_desc,	ARRAY_SIZE(smca_if_mce_desc)	},
-	[SMCA_L2_CACHE]	= { smca_l2_mce_desc,	ARRAY_SIZE(smca_l2_mce_desc)	},
-	[SMCA_DE]	= { smca_de_mce_desc,	ARRAY_SIZE(smca_de_mce_desc)	},
-	[SMCA_EX]	= { smca_ex_mce_desc,	ARRAY_SIZE(smca_ex_mce_desc)	},
-	[SMCA_FP]	= { smca_fp_mce_desc,	ARRAY_SIZE(smca_fp_mce_desc)	},
-	[SMCA_L3_CACHE]	= { smca_l3_mce_desc,	ARRAY_SIZE(smca_l3_mce_desc)	},
-	[SMCA_CS]	= { smca_cs_mce_desc,	ARRAY_SIZE(smca_cs_mce_desc)	},
-	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
-	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
-	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
-	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
-	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
-	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
-	[SMCA_PSP_V2]	= { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
-	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
-	[SMCA_SMU_V2]	= { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
-	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
-	[SMCA_MPDMA]	= { smca_mpdma_mce_desc,	ARRAY_SIZE(smca_mpdma_mce_desc)	},
-	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
-	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
-	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
-	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
-	/* NBIF and SHUB have the same error descriptions, for now. */
-	[SMCA_NBIF]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
-	[SMCA_SHUB]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
-	[SMCA_SATA]	= { smca_sata_mce_desc, ARRAY_SIZE(smca_sata_mce_desc)	},
-	[SMCA_USB]	= { smca_usb_mce_desc,	ARRAY_SIZE(smca_usb_mce_desc)	},
-	[SMCA_GMI_PCS]	= { smca_gmipcs_mce_desc,  ARRAY_SIZE(smca_gmipcs_mce_desc)	},
-	/* All the PHY bank types have the same error descriptions, for now. */
-	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_WAFL_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_GMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-};
-
 static bool f12h_mc0_mce(u16 ec, u8 xec)
 {
 	bool ret = false;
@@ -1182,10 +706,6 @@ static void decode_smca_error(struct mce *m)
 
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
 
-	/* Only print the decode of valid error codes */
-	if (xec < smca_mce_descs[bank_type].num_descs)
-		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
-
 	if ((bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) &&
 	    xec == 0 && decode_dram_ecc)
 		decode_dram_ecc(topology_die_id(m->extcpu), m);
-- 
2.25.1

