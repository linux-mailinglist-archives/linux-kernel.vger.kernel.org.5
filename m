Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5475DBE0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGVLWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGVLWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:22:15 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045C3C39
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPihWtMzmXCIzUJHL4h8bhSaSZyW1kh6B0Ba7luAl0WzsTChXJ2NdNvSh9+Xha7ackbym6K/IgzaP65GPBw3Py5PffOt+rPJQEDmM2KRZ+OY9gI6N+56q6zd8CnUTx1AqZUtYocNVuy3fKGIEOXIzxQk5HSOCLsS0o2U2gNLlYLbEN7OyacaiDuPl74VRG3AyiLZ9NVm7rVQ/O1V9Y/w+xJkjW2mMHlbyB0fpi4VSMEXKNgl/Ux9mTIxHazprwdjKMyxHiWud16x6lHeYZgo2Fmu0ZUUhIQ1zvmvdAVWk9vpoz/JaQ3kpQiMy1Xp075i6sShStLX770cv0yDrhahOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pP5EnYMWy6h0McrrcwvHxMH9bmi4Ie9BZNOR+xAO3B8=;
 b=ds+DGYVXi1TP4/g8yhXktZmcPnd0wdvAbFb4rzeyC8PKJk94ljyxEUzqyVdqLaMrey36EHXoyPd0LHX7NN52GwHdX9zfQJJEMwkjvzoTxKRcxg1g+z8faNAeBz0N14tyaX/sfUxZtXOj7f89S8UD0LzV9uvpcLr1g3mBeQ4hDmmm4iaGvsjVF8blAww7/xEIWitfzuDvgMJ12LIVGTpVKLnx2IF84b075VQqpDr2cU3+XmcczA5gyrnSeZGahc9GRMSJ1TtvS6oRPCqP/2ZTXf3swZ2VC6scuwe9wxVhzhPonbfre/r5hcIxrxdM4Gpc+9R0NXUL/am43mLs7rTIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pP5EnYMWy6h0McrrcwvHxMH9bmi4Ie9BZNOR+xAO3B8=;
 b=gXwkSp7RP0CMh56VO7eFTOSRuu1bTFl5fQOx3DmPoOqHLGx3LZv+egzj3v8JNizYbYj/IjyRRfDHIu7C5sQXIb2wW2Zih94qgHa+iXYj/Hd+K69ti/X/MRxSQZh2WNGogrjMUh2pDssMYxDe/a/1rBoTkocHwVKDLIs4zIQFsoo=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by CY8PR12MB7243.namprd12.prod.outlook.com (2603:10b6:930:58::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 11:20:52 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::3f) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Sat, 22 Jul 2023 11:20:51 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:47 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 11/14] x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled guests
Date:   Sat, 22 Jul 2023 16:49:06 +0530
Message-ID: <20230722111909.15166-12-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|CY8PR12MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: 7beb562b-4885-46ed-b9c0-08db8aa5b4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOeUlzCm249OE9LenRiFmpFmg0+ySm8etvTBiSoj1pIXtzU1p/Lg2Jgze6bu+3kvJwYqOdiaV1YwQByBBjaR6FaIYZwLga91f7UtZM2wnqmHZ8+/DaVdzKmE71txHpXiqozsF6fwWFEWP+rtUupK5wwA/l+LsPkCEK4jeEbGjcG1NCLKiEWHl8e/cUpv7Ft0KhZrks/EKcroMHuUy3A9Tcu7dwyLxioIgr7J65JgwdRiC/FvaQoA32t8BJ4QQb6FQKex6MkaPklYitOPKoSnwkaMuHx5L4v5g7HiD/pBGgLD2sk8iSC9NjNi/E1CVRSMDF6dHwluI6tq0Ecg/pfTW4S+AuFiuSJ8TLZQGZfXj5XJne5833a5wyTJTseyMIdBMIwajvULsBu7GqZ22K9qAkVcFL62jyHqkJzK1Kma3+1D4BXPXNkOihCuEhFBjUz3Xf4Ngg7wRpLp/YT8pZucQ4x/o1VSDHNuOwcu249QPDd+ewWUzhEI8iHy7wpKns6XzG7nzNXkDEDeZeHn4c5BnvDCyQe58pIKsNf3fDK1UY5Qc1NVxfAw9g9AZr/rs05gmRYjamQDWCULep7qYNEt+TkqyEqw6oO7JBiaVoyK3kdUBiFABdVoTD8TNlmSilLgMx01oE0oBSdqfguJvpyyIfwSZmDLW2m5SZospRRuQJ2034KXF/S/1/ufCaqFw2VqRxRtykSakgh4AzrT6bUFafVSWlNxqYiIYQ53TgtJCGYV+5KcQzDV9VO47EgH9gX2lDnp5g+F4Xcr7RfJY9N7LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(6666004)(7696005)(478600001)(110136005)(54906003)(16526019)(186003)(336012)(2616005)(1076003)(26005)(2906002)(316002)(41300700001)(70586007)(70206006)(4326008)(5660300002)(8676002)(8936002)(356005)(82740400003)(81166007)(36756003)(40460700003)(36860700001)(426003)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:51.1073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7beb562b-4885-46ed-b9c0-08db8aa5b4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index 3a5b0c9c4fcc..1c22025b298f 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -912,6 +912,13 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
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

