Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB39E7C024A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjJJRKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJJRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:10:47 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989D194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g72D7d0WCfwGKUAWg3b4rQhoLLFL8qVvwygSAOvomcSIIuwzBXXhL+H1ANkHWvzX/bh6ypqW9A2fg3uA7jxgW+lJY1KAiD4hCO+mqATAgyTibxMWCPOAkeEi8Kbf8U055jCZHEkz5Ljr7AnfOod9uRYyJiqqF/y5I2yIpOtsPn71xItSH12AOs3VafmoVvZusyffzZ95su1KWvAUWtAH/upFLmSQZhOIN/UsIVKVDSfcG3tjyo/+Y1Y9IB/vieXmL5lkqjFaMx2XQJ94JoNjZGbQsauUwBo7O8n0kZZgggOHbHzY6pXnAk31N0lg9sl2TLxIjYocskf3FcFfXF4E8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShsxksQCBU+sYJtQmS5RnFGE4ATRkKsS1l9HZ71b+WI=;
 b=nuIpmIWFtpQqssdjRkJpCGYrzlrKuaEC/Os/XcfnJI6iMBL3DQpIxRl9Bx/BGmvj+bsXPKniqZg08GRXBlD6W1Hz9xOSdUlTjJnKCBkmWgIjRXTN3LBW6gzKTTpeIDNKvIteI9thJJ5ekYdyLvRfhmZiV4JOxWTCOOvaVf6h46zPudyBLggapIX2aT927qlKqBMI067p2UEIEwqhkQ6GRbfROXz4NiKaXABrKHt9jbFkTmJQB87XYv8Ix4j5UzOeuNs2W23/9UoozA1YowPLhZPwag4xldzNJZdT8fY9U4pwsrX4YjGfIviAP/EY3i1EXNBGlqNAoj91QfY9fxtvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShsxksQCBU+sYJtQmS5RnFGE4ATRkKsS1l9HZ71b+WI=;
 b=SNM4fg6l135k1zowTtRq5K+6vSPkZCpD65214wzqEsazJkrgocqUDocvLEUtpCYniWSLQSLMvJZUZeHS0yyz6PSC6l/19h4qzteRa7p72R0Ijr5l+7QGixg8x3zR1lNRCAquxObA5TkLAzv6dovnhcG0FvqPKw9dcJ36TFOZ1ag=
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:10:40 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::5d) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Tue, 10 Oct 2023 17:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Tue, 10 Oct 2023 17:10:40 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 12:10:37 -0500
From:   David Kaplan <david.kaplan@amd.com>
To:     <x86@kernel.org>, <luto@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] x86/retpoline: Ensure default return thunk isn't used at runtime
Date:   Tue, 10 Oct 2023 12:10:20 -0500
Message-ID: <20231010171020.462211-4-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2c7f24-709c-4f95-0a33-08dbc9b3d463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50r1pv1iS8iN6ApKzm7EAU74/GG84G1cpJbP3eTkRS9r3bSmKrgI++C4TCygqzjv6MPPI2+V8USSqosJ3EaK3AT/Cdf+WnyXircevwWPbKZ57gG61HsSBVfM+4AU87yhfNSJFzHXGxhyOsjnW43v0V2JssEfmO6CRW17rnzAqk2VURoS9JtzF+XqVSEsIyT37G82A3TNwtGsKs6MgMeygU/GD6CDyyFup0h3sSloIg4mV3FI/bjIxlx/DFzJ1wEqhkI2B6eCPMS2bYtMMhov0gbrJ9J2+ec02ZpbcUJxkNWbcfG2CX1NOqRmIONW6CMeHbo0kOBoL+2vZURkyPTMiMk7FxVU3sGKcrzpbzO6/6ZRex+krM82txEBkyvEAtB9omPG94Tz+t1/5Nn+V934oGH0yoWz/ysKx/uCagpMNfDdtshncScsCo1Up3yXBOMcqktMNIp12ptv+gSv+/9tb0PS1ZnXHSYlF3NuCfZl/uQS+mevi5dbME+PD32QjIqmyIDXXC8OvxpGftH+HTdTz+pgS1qzcptXqlRikw8reSF0iinfDPPCerZeitSFcmvJAFQzIslrll4PdSz431Ii6Lh9CCMmmXLWRASNGAx3HHpZ6FADKu4eym4AbE+XyC3S8LFBu+iwwzLnEjeUjuAbN5iDiNUSK+14rcmcTPG7sQZ9hvv9HDKoks3DU84ibid1ZlA+HWODSFi57W7q/4OFiLLKZ530jgkxNvoIm6dDkCk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(1076003)(7696005)(478600001)(6666004)(47076005)(426003)(336012)(26005)(16526019)(83380400001)(2906002)(5660300002)(70586007)(70206006)(110136005)(8676002)(44832011)(8936002)(4326008)(316002)(41300700001)(356005)(82740400003)(36860700001)(2616005)(81166007)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:10:40.0927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2c7f24-709c-4f95-0a33-08dbc9b3d463
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All CPU bugs that require a return thunk define a special return thunk
to use (e.g., srso_return_thunk).  The default thunk,
__x86_return_thunk, should never be used after apply_returns() completes.
Otherwise this could lead to potential speculation holes.

Enforce this by replacing this thunk with a ud2 when alternatives are
applied.  Alternative instructions are applied after apply_returns().

The default thunk is only used during kernel boot, it is not used during
module init since that occurs after apply_returns().

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/lib/retpoline.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3da768a71cf9..10212cf4a9af 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -358,15 +358,17 @@ SYM_FUNC_END(call_depth_return_thunk)
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
  *
- * This code is only used during kernel boot or module init.  All
+ * This code is only used during kernel boot.  All
  * 'JMP __x86_return_thunk' sites are changed to something else by
  * apply_returns().
+ *
+ * This thunk is turned into a ud2 to ensure it is never used at runtime.
+ * Alternative instructions are applied after apply_returns().
  */
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ANNOTATE_UNRET_SAFE
-	ret
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_RETHUNK
 	int3
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
-- 
2.25.1

