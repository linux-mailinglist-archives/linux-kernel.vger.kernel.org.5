Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1B7C0248
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjJJRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjJJRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:10:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8D0B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmsKnOT1U73z65cDB835xfc/Z2MCQcreQ3llaqdsVkaBax5yGQDJxKJ4oMDyX84UM0IMh8dyrMUlKSOPMrTf8EpCdAxhyxVuuEi6/iNSloGj+R/tXOC9B9Mzk3iuUJCv3OhYncCdqrQ49Kfvqu0YdcrqNVxi/hA/evJ9QGOMldkUPvawT4Fu43Mpd/hVLGfZZ4495Y0bbQZsXLrzLwA2TTXPOullCAnTYKCde7gl35DDxRNaYgQ4rV1emj+os1RKfAFOs+eSyBoWHQD1CY4EEIopREiAm6oXlvSrMsaB8cGsGLY9OHyePyFMWDso8+wreBgbrHnbp5/DjpWiuzA9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P68wo6zt5TAxWt+pCXOd683FhgHEfFqkuoHeFXwxk6A=;
 b=Y+W+YEWNoRyX3fkFFhLcEUi2lXUbJQrBgFeteHs+P9dQFkum0hSLWVbfZhvTqdG2uyhoOdFVF6JwVpEdWLYeOzf/gI8qppKvBI1IiE0KtbiRWk+ItnsAreNinXFJzhi1tnLJr+5bxppAXPoJvoadCbyXXoDNoIKuCJJKugmydOfMDijBmHc9pYtzw2zXVPna5+lkjQrT5wMf/P73YeXzQMfambZvdteoS/y16VevKOr59Lv8qTSvkuQODTF3vvo1dhHmKPLKMU28bHUicZxTcORJMmEMThkFpVT53FrddrmqpeI04qpPG67mc6TwSzacHcd+HjJ/2ZLZoGk7X6vD6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P68wo6zt5TAxWt+pCXOd683FhgHEfFqkuoHeFXwxk6A=;
 b=g0Cq0kUFhfb5PjoEruMh/Tl9qu62SSCOM/+3Ryzby7K/MEamfFVjZL/NLCRY7D3xIUl0KI6d/TK1Wih8cIyDrALpfLlFBDbifEpcFE8R18/CViQ0+cA8F6zIzZzsqtiRikBSvxAocDvYeI1Mgn/wp5alFbN+anJ8YwsNNwHZQa0=
Received: from MW4P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::35)
 by IA0PR12MB8352.namprd12.prod.outlook.com (2603:10b6:208:3dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 10 Oct
 2023 17:10:38 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::75) by MW4P220CA0030.outlook.office365.com
 (2603:10b6:303:115::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 17:10:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Tue, 10 Oct 2023 17:10:38 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 12:10:37 -0500
From:   David Kaplan <david.kaplan@amd.com>
To:     <x86@kernel.org>, <luto@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 1/3] Revert "x86/retpoline: Remove .text..__x86.return_thunk section"
Date:   Tue, 10 Oct 2023 12:10:18 -0500
Message-ID: <20231010171020.462211-2-david.kaplan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010171020.462211-1-david.kaplan@amd.com>
References: <20231010171020.462211-1-david.kaplan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA0PR12MB8352:EE_
X-MS-Office365-Filtering-Correlation-Id: 15836d23-8365-4fc4-8e0c-08dbc9b3d342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKRQk3PdZv16PM4zdk3dPbXz+FbBoLEDjWH0rI1t7SyiXLn/jOPtwxzgcmvvZUwITpCAwsqWi3Eevo+3ajjR3lwnPRr7OYH3TVQh/Kfw8iAUmzzEhnsXSEBTZy3q57xgMDlxQ6geLdLXbAWqdWHUeSJYllrbhp6zpZSscQKFPk+Q9MaeAgtXeLGdlRgiFDwxCB2SsUNUY8v84aobufANg5rIZAFMwEBb7yeAJm9DdqoLZweRgKtxKZ3rVaSTH2pFZVh/3eK/IO2zGpW/Ujn+lgi1WWViH2Izlvmp+jjX6IxzVFux8eo/M2Auu7aWkwg0ilj/wzQfL7UO5mwcXgUBd1998Loek7BwQTHDtWRx23zjuJ6L7foPpCypPxyzP3kAtgNIgkA+leKV+Ge3RTLA9QSJWTxj74yD2bmI+a2aE1t3t3F6d66zpWIvo3JR2rfjnEbe8pH2rnLLoauOKF9Mx8DRLebFTEjTxI6kTOMm6A5Kxgj17FBj0GMDGtXnr4Jcytcvc6YOrltuhnnnEoslL4FqBLiU/1CbmqYv93Y/KdBcYeEGiNIARfw52vUdS8dz84dJ+uPx5SG1lB+Rnlpc3BAUDAv6V9EIgNUAYtMS1Xb0KKDMo+XrJIsNq6itxqLS1a/efv9HXVgcMdPFN1czgF+PQn6tQO2krWpNwCcS2uMoVXKNNQ00kkxAdNaH0cnxNPXINN0bIbk9f1XxNChIKS9xuqyleKmq0oaJ81flv3Lwh58tyNeLXqQEBhaj6z8ReKc6aY5ImOBW5u/7ML6dxCgaMEdCYOWXp1VWpISKT0Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(8936002)(82740400003)(40480700001)(478600001)(4326008)(8676002)(44832011)(7696005)(47076005)(40460700003)(36756003)(36860700001)(316002)(5660300002)(54906003)(110136005)(70206006)(41300700001)(70586007)(356005)(6666004)(1076003)(2616005)(336012)(426003)(2906002)(26005)(83380400001)(81166007)(86362001)(16526019)(142923001)(101420200003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:10:38.1396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15836d23-8365-4fc4-8e0c-08dbc9b3d342
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit e92626af3234708fe30f53b269d210d202b95206.

This commit broke patching of the return thunk jmp in the retpoline
sequence.

Before (broken sequence):

objdump -d -r arch/x86/lib/retpoline.o:
0000000000000000 <__x86_indirect_thunk_array>:
   ...
   a:   e9 d1 02 00 00          jmpq   2e0 <__x86_return_thunk>

live disassembly at runtime:
0xffffffff81d12a8a <+10>:    jmpq   0xffffffff81d12d60
<__x86_return_thunk>

This jmp to the default return thunk should not happen after alternatives
patching.

After reverting this:

objdump -d -r arch/x86/lib/retpoline.o:
0000000000000000 <__x86_indirect_thunk_array>:
   ...
   a:   e9 00 00 00 00          jmpq   f <__x86_indirect_thunk_array+0xf>
                        b: R_X86_64_PLT32       __x86_return_thunk-0x4

live disassembly at runtime:
 0xffffffff81d12a8a <+10>:    jmpq   0xffffffff81f0410b
<srso_alias_return_thunk>

This is correct as the jmp is written to the correct return sequence.

objtool (add_jump_destinations()) only recognizes return thunk jmps that have
relocation entries, which will not occur if the return thunk is in the
same section as the indirect thunks.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 3 +++
 arch/x86/lib/retpoline.S      | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9cdb1a7332c4..54a5596adaa6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,7 +132,10 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
+#ifdef CONFIG_RETPOLINE
 		*(.text..__x86.indirect_thunk)
+		*(.text..__x86.return_thunk)
+#endif
 		STATIC_CALL_TEXT
 
 		ALIGN_ENTRY_TEXT_BEGIN
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index db813113e637..3da768a71cf9 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,6 +129,8 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
+	.section .text..__x86.return_thunk
+
 #ifdef CONFIG_CPU_SRSO
 
 /*
-- 
2.25.1

