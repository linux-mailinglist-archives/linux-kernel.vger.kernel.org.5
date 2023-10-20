Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63037D17FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjJTVXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbjJTVW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:22:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E922D68;
        Fri, 20 Oct 2023 14:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G26/BK0G+P2q5MhIk28+FgQAz2WbZmIJ0p1qRB4jfFmCheJuZnRB1D9FHAiC0oiNamddmcHQBfr6WAfRBdlusLrxbykzK4cisBxgaNFB8A3/KPRcOyQWa9E6/qShFIhLfhxKM1yyAPfM+rN/WwxY0k0MNkZawd5YMj24Foi302MJLLe/artG76xkM+kfDpShuQgSG/OWlgkybipvR/s7TfnwRhbLQ+8AERSEzgr/fTTpENNgsVd2n1QKjV6AREIuwff1k2UCPTAB8taX2Jr1hv2R1saOBt0S+36cld0RW/lJia4DiCthvncMWFCGr9y4w4yVhEx5lzMEAxFw/s5LFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyt9/mMyyVVxCTxCtvrcjcI09HWuHjvGF12s7Q2u0Uk=;
 b=TB+CjmN5NfWW0XLi5raYSj7qMzdUHd/Y6Fxug7coQvnl+NCwGwfQJeaCboCxi5F5sFkLnlBMSdJnK3qDT00ma6wlWGcdBUMgiv4/75y0JuGF2dCUl0SYmczAPKX4rPJVoqqQDw6B/bTeZjBP477Uj2U6Qj5mrq2seK4jzHH/IBYV1K8l3KVezzkatmLoAWZf5Hc0T/Syh81wuQQlXDAWu9hFWyW8jKLhxZfbo8sT29J6dfvrzpBjkT/QnHEJ6Vv6mTdGf5y7o0njBHTLEv8z5DnwSnBfNbRX01g61JPtyeom6/arGHWVqwk3IfwMAjCtFH8hi5WsQfZHvIFfaCWqFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyt9/mMyyVVxCTxCtvrcjcI09HWuHjvGF12s7Q2u0Uk=;
 b=hrl9dCtvZrFnfABRwfD7GdEYpQf+tWSomn9SvWyrM5iB2Ndb/3DZlhMzsf9DJJNA4eJMAP/+BRsjAvdKw5fOMazK+q69UzqnJUaPU3J8ah7Ionw0NnUWSLpd0CElBokO4IpQ0kOtQuxfRNx+wZIEonCfHfE61qpyTiRsEcaTtHc=
Received: from MN2PR15CA0062.namprd15.prod.outlook.com (2603:10b6:208:237::31)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 21:22:46 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::44) by MN2PR15CA0062.outlook.office365.com
 (2603:10b6:208:237::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 21:22:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 21:22:45 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 20 Oct 2023 16:22:44 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
        <dhaval.giani@amd.com>, <linux-crypto@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: update AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT
Date:   Fri, 20 Oct 2023 21:22:34 +0000
Message-ID: <20231020212234.458371-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7c83af-179c-43f4-b2fc-08dbd1b2b3f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3hWk2E+3KHv7u7URjr7pQmIyET8ClvJl5dqboMWsbkjF50yu9jv0rtaYwYFYv8n8egOfNjvrnxzJkUL70VnIhYN0/S2D9rwi3SQy1DiiwIqYnPjtRa8W2vdXtHCNtZmpXAre3lOKn5Yj+fG1S9HbKU5z8O+y1SOQnbY84BfckT9zIkIWHFH5OXaWMSFeH24fZjpZiUplxVQOFVVELkl5StjP62+AcaCxI8Z6t55TUv4H0AOJe6Fl9R/sKX5iIaTSbjrbmaqOKNsq5Lo3fE56/F4kpmHax4sDccASKPIdlMvmZ2c6Gmo7A8mfTZIHYZ/dDnigQWDBGyYS4kOxvuhiOEHOjDFF+YGnGCVRRdhhl1Jt018XLzLlobzYO/6GsXHKv3oi7rq/vWy5Nct44Nxt1i3YQrUF1yuO5JcUL1Mn09gMa9SrvYlJQ3EKk8c5ZPEnLFd7jTG3ficX1HHot9pSArIuAaXICYxcXlHaUPc1GzLbdA79x//14fhcQELHH+c5zhMvVNh8OI2REbbZcvkSP0qyOtcxHpFh1vjV/WC0gFp5Q4e3RQLsKKotS1Mx/JfqmtBGY7O1HuCxu2bTyydU3ZIZQhp8Qzoyg9NwqdTCfJwzOzI0EYzUCKpVTd93E0/9Slb4yMlZ4fiMZdq8Z5YsypXfbr5Bax1xXf0QhEV/Letc4wgpcnBQCoJwLoDwgW9Dy0o/XOcIExtuPLFTEpbwXXJtY9LSPGyOUzPFkg5tOqjL6oIuUropKVI5LFzqtFEIraQf1ghuY/AN0UbslP2vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2906002)(4326008)(40460700003)(86362001)(40480700001)(5660300002)(36756003)(70586007)(316002)(54906003)(478600001)(6916009)(6666004)(8936002)(450100002)(8676002)(41300700001)(70206006)(81166007)(47076005)(4744005)(2616005)(36860700001)(7696005)(426003)(83380400001)(1076003)(356005)(16526019)(82740400003)(336012)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:22:45.6392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7c83af-179c-43f4-b2fc-08dbd1b2b3f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Brijesh is no longer with AMD.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9..a7c64d36911e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -907,7 +907,7 @@ F:	drivers/crypto/ccp/
 F:	include/linux/ccp.h
 
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT
-M:	Brijesh Singh <brijesh.singh@amd.com>
+M:	Ashish Kalra <ashish.kalra@amd.com>
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
-- 
2.25.1

