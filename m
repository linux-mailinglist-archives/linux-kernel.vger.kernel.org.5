Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011387DB398
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 07:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJ3GjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 02:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjJ3Giy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 02:38:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C825D4A;
        Sun, 29 Oct 2023 23:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EckQaWDMQ8/JA001HsWQX1kcd6J5+g0Y2yImAHk76vQXF5o7PwG6jKJpbCbqdjNrM0WWHbOHTC0rVkuk5q+YhBR1idpu8G5RIQr3wknVdO8zBigp9j40Vxo4HZO+uFJuEgv6/8qkaq5yYU9afZa6qCBP2t3/VyJYod9KFQ5joYLsmnNt+idng2HR9DPSjGZMTTGZGey0HR7I5gU8L14msF+rYydRVhXvW/NvrbBKzTjOM/GC1s1FZQRsH8cWAj6tJ1GrHQpppwVeMklI7loRTF67A1ChXenDdui53AKw4vLbFJY34BDuVc+NghCR/mA/cNsWYZnXeLPmeNMydThXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgD9DpK8J/pJKDXITmBQ3y9a5TY6d+jIq/civj9oco4=;
 b=N6HSddYUAFQalY0AnpKHshclTU1AvaD3ScMPCxHir+vd4fIAY+ijt7HQu5YfdvBkNfn4mLTF6ZS22lGyz+YjrY4SH6I94hsGvaJp8t/kxRmsQf2RhGrFYNqkT6MuzgjbtO6WgTglR3CA6+x3+E84G6rrzm+Ef/AjhdQ51iBS43ZIkdrHVZidoyCKs3C0bOr1MYwGLYW4N9/yNjamr3CD7rb+pn/BOafYWEpiqgcqZqUCzGoWDNZXyFpITDj2SMCqVY6WeUMiL8ow71RgZOO/tVap49mJTiwmMeTc7+jLZq4ibP0mX2mCDgf6EUSedBk4XfCL5CuAthjM8yGf3ehYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgD9DpK8J/pJKDXITmBQ3y9a5TY6d+jIq/civj9oco4=;
 b=Nj8YE48Du3miCw6xhJydAAFUDivnSiCvMxQnoQJkBOIBnTRqwh81wcNx+XsJU8eZNHSn7i//SKOm92o+JERFmWsoIns4hYtxHNtjkQWxnZHASCBbo/gFx3/i4JgkcGMXojLScLwFpR/P2scO/tBozSnWWcpKt/xOTNgO8PLl2KQ=
Received: from MN2PR20CA0037.namprd20.prod.outlook.com (2603:10b6:208:235::6)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 06:38:41 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::95) by MN2PR20CA0037.outlook.office365.com
 (2603:10b6:208:235::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 06:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.22 via Frontend Transport; Mon, 30 Oct 2023 06:38:40 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 30 Oct
 2023 01:38:36 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <thomas.lendacky@amd.com>,
        <x86@kernel.org>, <kvm@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <dionnaglaze@google.com>,
        <pgonda@google.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
        <nikunj@amd.com>
Subject: [PATCH v5 11/14] x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled guests
Date:   Mon, 30 Oct 2023 12:06:49 +0530
Message-ID: <20231030063652.68675-12-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030063652.68675-1-nikunj@amd.com>
References: <20231030063652.68675-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea45773-7517-4a44-fec6-08dbd912dad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNybn2yb/fdoVElC3FMVDiIWrB7LPlcrGL3jNCCB9Dm6lU0rNQBLB4zdifGImziGkMlCn90hHsq+HrkbKlLSrVUpmqh+HRhku0aUiPGLEth13urF2HE6sfoopJsT/irz/CVwe6vrF518AG9syZLDR7+Pw469M7RPVhRPFp/WeYyBH5l8fzhF6Fh4Y8dzJAG6pL/HHv0s6GTfekCc/oVGHaogmOsD9DQrSSBr0/steg5wF3UK02JdfQhbf/kzqAJGWFRUn+OPgyhT5/TowOz9QEy3fpE0PlS8S/2chigOoHCDqzUs6nyIhGvYFFa7scFJ71FD4Daj1nXkvpUhrWPQyDs2bFR/bNfRESaMNHO5SFyof36e3JmGLEGLMDzvuJES/qgNC1uvLNsRWDBod+t60ffXc9xZvetxl257M+1LKmWRh2WCF2ebZcDiOQBptJVwzF+mFnfNpgV3W3jtDzabOEsIJutv94bzqmClnzL1MZb5UrfOZwoNyjNckO6uF+6a8r/ULyN1eCjNQIAnyRbpC8V7OCp3KWECPcISsas/1R1m1KKpz5VRYt69sfIuXsmBd8SsxYVXY7YwIAePpQl+/BvGnDMcnwev5+9O1iZQzyvvz1vI5aWmUsSVLfL1+IPRS3ZJexRNaSNz3AdIZ50Pmb0xICRxSUt4BMogPqGn9m0Uoy9yVNsigkIkSIhQWVoX9cHK9NbCMPLYBGEeKFr1+5q1wTTjhars6Esr0T0d95/gYAdIMVxKX4YnvghBPTTKq03cW9Rge1N35/6qaC14ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(110136005)(54906003)(70586007)(70206006)(4326008)(8936002)(8676002)(316002)(7416002)(5660300002)(41300700001)(2906002)(426003)(336012)(356005)(81166007)(47076005)(82740400003)(26005)(16526019)(2616005)(1076003)(36860700001)(478600001)(40480700001)(6666004)(7696005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 06:38:40.6840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea45773-7517-4a44-fec6-08dbd912dad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hypervisor should not be intercepting RDTSC/RDTSCP when Secure TSC
is enabled. A #VC exception will be generated if the RDTSC/RDTSCP
instructions are being intercepted. If this should occur and Secure
TSC is enabled, terminate guest execution.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/sev-shared.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..833b0ae38f0b 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -991,6 +991,13 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
 	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
 	enum es_result ret;
 
+	/*
+	 * RDTSC and RDTSCP should not be intercepted when Secure TSC is
+	 * enabled. Terminate the SNP guest when the interception is enabled.
+	 */
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		return ES_VMM_ERROR;
+
 	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
 	if (ret != ES_OK)
 		return ret;
-- 
2.34.1

