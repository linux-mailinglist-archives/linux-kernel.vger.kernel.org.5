Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D87C024B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJJRLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjJJRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:10:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE346B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6f8VyBADUX+AP+s47y2TaXdu1E5kNFUWrysmT4Mn1bgERG+dab3qeH5rcL21hpx2HDizP/cOBXzGTXwKi37Rs9icpUEW1/npHbK4+Xx4h26eaMKLqV9zMWgJ0c9kf1RzKpUXvoSPreLNMv3ubhVTPhu5d/AEi07II8zzBqyznjfQZkkmgoCNyBmqDVnPTdYffEsxh31Vd4Vsi/CzfGNwwItQiMrgbCamiKNIkYBa829dmb6o2tFRjn6b2pYC7YQfHZG+HiBFCDLcdi6uy+kDWG5K5jPInqgKvbfzPMrBPgk6JUD+ZO6wF+iRnDWG6nUm0idoQPiky4y33UInbIJ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwXHSX8fNNQRMALFfp6axk5XS4yv+drNsW2plHNwodE=;
 b=kXCMhIKcbgnPBKNyloeAucRBVZCNyKdJ3hVE2iOyxznznzAPhyH1sHDzqhJTLSLp5dU/VvNItaGXj1GXcjHqSB4rlcErxR+WF8WCkN1z7ClioSHNB62X4v49E32V2BEsh/tX998P72VPj0PLkcCGleqeJJfg9ebHU1N08zjZ/cWi18ey/uzJdIlePvHRxTUMBam+QBJlXuH6rEzZFFE6b2orpJP9Xto8yfu0Xaiota3gxZ+MayDalIFMjjc0+w+79BThhLYHMKmPOQuJoD5IaoI2BAu0QFNmByiUOWc3baA+egAtWTktsgAKL2NwfYTBEpf2TeiQrYb57fsTkT3jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwXHSX8fNNQRMALFfp6axk5XS4yv+drNsW2plHNwodE=;
 b=sUar7/IpXEAWe5zD00jlQPLii5dVtEF94xRem8DBsTn55OONmgQd2Pelk8KEle10UDkM3x4V7GvyJVw0Xhm5atd27WrUUTowfk66aRPdJMfZ2IOw6e7K46mZSnVOsbezHDR6HUXGLe/h4ndtFV5Ymnazhzvr5fjf4K5+mS26LjQ=
Received: from MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::16)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:10:39 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::87) by MW4P220CA0011.outlook.office365.com
 (2603:10b6:303:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Tue, 10 Oct 2023 17:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.6 via Frontend Transport; Tue, 10 Oct 2023 17:10:39 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 12:10:37 -0500
From:   David Kaplan <david.kaplan@amd.com>
To:     <x86@kernel.org>, <luto@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] x86/vdso: Run objtool on vdso32-setup
Date:   Tue, 10 Oct 2023 12:10:19 -0500
Message-ID: <20231010171020.462211-3-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: e203a7c5-3acf-4f40-70dd-08dbc9b3d408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etnfVVsBKWKMY+XNq7chQmFEBk6haDqP/aYei5LzBGCj+wfm07YS/fEmoOcWfp1x3dci1GtRUKEOb5gTMENAEzF9cWJpGqL/8OK6fojSHvMb48XeTI97kEoF70bYayApsI+z1erOa3DBuklQuLJlgeW2hS00UvJrDiPbWkq1OpZn6mFF27ivxFYJAyTgKhDPOPTg0AsZWrLQUMp11+sf9L67cJU6IHgQeLLzRS0CWkUIFGaoJ9cDiqAnGCHUOzy7CES7bPc4dPpru8vKvBlJVF0eOy5eLPf7ansEuhMbXdRvt3cPgZ28dwHdvQwppGmwtfjtFaYK4VPBOnICv93d5coXCtXkp+ThRTOK+v4nsxlzdBvmxXpDbHniWOARNWi3uWp+8wP1SvbZ6b9uxDT4hco9KPDSARrbwm4e25WezXDkhQGdu9EaJt62Nx8xQ+3ZS5EStuPYMd7fLMh5aPpGfjgnfQM5gZis/YrKqWzTkPGaeN/sXi2bhcP3Fct1flHX18MUoK2G3C6k7J8PoHxdAmxMx848tCysVgjnMfq+LQYrHd4rjEfVIOzYV8u92RfAHcl0zFLzdUDh3f/fGoUx1K5iES2zRxhxjE/6PWhliexeLPIpEG050XyvjEJNwExIR5o0ztyYBMXh90EFBQLlbw9T+6/kdTWv1PRH0w8Ld4DKDveespG0XTXV90eSQYgiog25zJeMkNBrF+yDSHwRULZly+v8J2VCqkVTG1X7+Ak=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(1076003)(7696005)(40460700003)(356005)(36756003)(40480700001)(86362001)(82740400003)(81166007)(36860700001)(336012)(16526019)(26005)(47076005)(426003)(44832011)(4744005)(2906002)(83380400001)(2616005)(6666004)(478600001)(8676002)(4326008)(8936002)(41300700001)(5660300002)(70586007)(70206006)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:10:39.4365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e203a7c5-3acf-4f40-70dd-08dbc9b3d408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso32-setup.c is part of the main kernel image and should not be
excluded from objtool.  Objtool is necessary in part for ensuring that
returns in this file are correctly patched to the appropriate return
thunk at runtime.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 6a1821bd7d5e..83c0afb7c741 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -42,7 +42,8 @@ vdso_img-$(VDSO64-y)		+= 64
 vdso_img-$(VDSOX32-y)		+= x32
 vdso_img-$(VDSO32-y)		+= 32
 
-obj-$(VDSO32-y)			+= vdso32-setup.o
+obj-$(VDSO32-y)				 += vdso32-setup.o
+OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
-- 
2.25.1

