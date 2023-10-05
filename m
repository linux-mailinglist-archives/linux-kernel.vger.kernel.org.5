Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE897B991D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbjJEAI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244182AbjJEAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:08:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7BCCE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKwHazAOyVEguAzh8+qQNV0eTZvqdKVW0H/8YMcqp73dqemQN9AOgLkE0mp+PoSI9QBhesnR9rR3a04J4Fjq0WYLTPXd/+OR42oEoHGDwywEFplduQGiQaR+TTz2kbdblMIgBcDsWlu+KrUGRh9OwHRmDhiuY0sFYbza+Jo5QYLqFlplddCaviRhUM+wyExaK6G/ZGvUtTcIJw2ySLgP6TFP1fNABx+FG0/mfJCk2gMAFT03HMlsE/d/RSVxmscXIzN81x0B0Y6QIsaYdZGINUJeU1BfRRb1EYvhfh8XcvpsM/ioI+mCWtlC+X/TKD9LMF3QaaK5BSyAhXmE8yBTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNLH4LQnL6hEH2ttgQxrTVrGsmAvDtVOtBhQa+hPYGY=;
 b=hmcbiC+j4Bu6z5w7KtDhvGMxDAusjQvxbe2ulisAOK/Rkmow+a5iEsgli8Fd6Nfp5E27RVZRsal6J2hotUrjaf3QbZVvXapJlknNn5nhZoxYnZIPODi/vbt6Ok234QH15G9DJSrhQfjhxDeaL8xd/Ql9jDeDhy+fNVRCWO2SXlz5r3GGvRhhmJ8KMAvvRKIgoLMhcyQFNZA6BtzFllnAOIk3gVBcqGwZy+6WQ/4XDop3j9qE4Oh3s4rKl5ceU86bVdLa+oeQuUjEsdgc9q4EHuyutLoV+z5o0IKA224IeCWVUosGin3RTXAG03Ioxz3YR90nnaIRX45HO06yM9Wfpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNLH4LQnL6hEH2ttgQxrTVrGsmAvDtVOtBhQa+hPYGY=;
 b=FffNa3TD/tfmxNDxxmFQC90pV7X7yHLm0QuZU4AQGPGQnGGpAxwfuLLaSOD/J2ECWCbKRWAEr0WG6wkVgMRJ96SaQ9DLZJwLk+uEDwnfT8BEgPcR0NNPABdcdpmtIVa90x7gZDmK6k24vm1K9TH+9hcobYCVJeePnidRfgSZA9PHn6BWWGVy+tKSPnlar3L3NcMmcaNgtrNuJ6BMLOpvnaOljMTkxkVpfdZb1EBBnMiEhBz5ZkHVuw/W4O7ccFQsKrWM9JO13ZQ+ZTjhyvpSOSqhp9aYPS7GlebdJu0F7TJnDYfHdqDkIODXyrddo+C4A3llYiLQSrDucdrtpMSWoA==
Received: from MN2PR05CA0051.namprd05.prod.outlook.com (2603:10b6:208:236::20)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 00:08:51 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::65) by MN2PR05CA0051.outlook.office365.com
 (2603:10b6:208:236::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 00:08:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 00:08:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 4 Oct 2023
 17:08:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 4 Oct 2023 17:08:38 -0700
Received: from treble.fun (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Wed, 4 Oct
 2023 17:08:38 -0700
From:   Aaron Plattner <aplattner@nvidia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH 2/2] objtool: use strndup() to avoid the need for a maximum symbol name length
Date:   Wed, 4 Oct 2023 17:08:19 -0700
Message-ID: <41e94cfea1d9131b758dd637fecdeacd459d4584.1696355111.git.aplattner@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696355111.git.aplattner@nvidia.com>
References: <cover.1696355111.git.aplattner@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 436d7932-eadd-4d1f-6eac-08dbc537412e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UoG4YDkeBahDnceRUmoPfOlxmUAr3z6yEdJUB5fRQBg9/pxmdwyJMkMttzU3QXisPWFwjIg9mcfhABDcSpm1aEtMY2R+GDQAB+JrcxSL7/scIYFa4N3K3GY0VoADAm5HNtPr565a6Zi7Y5ULvvOinqHq1dL6bPo47P+JiwZb0CnnfPeSqILgVgvbF+2sdrThp/y5SUBC1u4mtJVfqZhQPUZaueK3kmYQQGfwphN1r93dGCTzoaUzU7mCp/xE18S/+yHUPKw/fKv43+Pf+TsdJ8LR79PFubK/LH0OiycCKpPnByaOyD4ADc2XH7k3oG4W3VCvW840Poyo7xH+IbbsUeHLbAltmewg/LPYTiiJ2sEBgFqGIEdd+ZvYOEdsei5J6lEHNuqtmtnbg2KPmiesQLhXwY5N2D9QpUUJbGhHMZLAdJwoj+7+n2PpEPg23rbYgRUUmDB1ZQqz673cEyl4sdCiDyvchTMgllSfAiMDQkk1zwTmU6r8R1uj+E+zab5nb0377LT5jZ4sJQoKuy0XCDLEVE2LoouxX+u4S3Js/Kpu2FM7wA9KLB9rMLOcb5NM4zJbKjQYX1SG7HSkxld5IMO69Q2IKvDCBn8G2HC2LnTtM8XssicuLpDx2TDWg3QETHuRFFtKjDLSEb5Q9a3lsLZQMOB2iGHFrlzrauPx+oYgYT32CZYgfrGodk9fZ2zFV7BEZr88RLwEQx2ZdBZgE6baSwkGIlLxddpfsMXdK6M=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(107886003)(6666004)(2616005)(7636003)(356005)(83380400001)(36756003)(41300700001)(36860700001)(47076005)(478600001)(26005)(336012)(316002)(426003)(6916009)(54906003)(70206006)(70586007)(8676002)(5660300002)(8936002)(4326008)(86362001)(40480700001)(2906002)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 00:08:50.8617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 436d7932-eadd-4d1f-6eac-08dbc537412e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one of the symbols processed by read_symbols() happens to have a .cold
variant with a name longer than objtool's MAX_NAME_LEN limit, the build
fails.

Avoid this problem by just using strndup() to copy the parent function's
name, rather than strncpy()ing it onto the stack.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/elf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 081befa4674b8..3d27983dc908d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -22,8 +22,6 @@
 #include <objtool/elf.h>
 #include <objtool/warn.h>
 
-#define MAX_NAME_LEN 128
-
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
@@ -515,7 +513,7 @@ static int read_symbols(struct elf *elf)
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
 		sec_for_each_sym(sec, sym) {
-			char pname[MAX_NAME_LEN + 1];
+			char *pname;
 			size_t pnamelen;
 			if (sym->type != STT_FUNC)
 				continue;
@@ -531,15 +529,15 @@ static int read_symbols(struct elf *elf)
 				continue;
 
 			pnamelen = coldstr - sym->name;
-			if (pnamelen > MAX_NAME_LEN) {
-				WARN("%s(): parent function name exceeds maximum length of %d characters",
-				     sym->name, MAX_NAME_LEN);
+			pname = strndup(sym->name, pnamelen);
+			if (!pname) {
+				WARN("%s(): failed to allocate memory",
+				     sym->name);
 				return -1;
 			}
 
-			strncpy(pname, sym->name, pnamelen);
-			pname[pnamelen] = '\0';
 			pfunc = find_symbol_by_name(elf, pname);
+			free(pname);
 
 			if (!pfunc) {
 				WARN("%s(): can't find parent function",
-- 
2.42.0

