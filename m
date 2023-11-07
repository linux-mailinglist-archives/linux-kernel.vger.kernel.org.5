Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CCE7E3B1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjKGL1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:27:43 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E98DF;
        Tue,  7 Nov 2023 03:27:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiF8smrMS1/D9Kpo0YoaQpc8dc9Rq/uCtHxGCTJP2ObW87A96xrmHQxjdwHB6jIunCSZ780vdERurbr637wbMjvxjirmHow1iPtq91a+I3sDuBMrjkOFWhaRH9JifPh1qXnXp0dReLkYdJKf3zoYhpo1DEKAvYlmXgEd4hPiKbiKm55WWc/AKxcJjN3yvhdFkKU9dyVa5GdokpbojMEovzb/1FVubHsO1aA98G0Wq4wmAmPwzkvJxLri3HpklVTSSBeDAewB+iT6NuwcNYmJp/pNkPj/spbPc3SjbXDBShhRUARpPyu/vI8F5dVxX8crcoXtfwaCEiYiNtoJiNH3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sspIu6XK9f3c34wn6yaEXHQXT3giRkm2/LVKfiWRT9o=;
 b=epGQ98VtOBkyo193u/zdEP636ij81ENRdYCCY779NgKfFw2kolVTIedwb1vwp+fYk3CoDpdii4fDqg6epgRqGQuVO9v78r8ZJrb5C5c1UF6YGuegmuKwibuKzRIU5mliBNa/gco4YBHe0isfPzg3ZPrX11sQg9tmXNF+afS46xsY4GFMhfrpV+iPB23eQhm0En3ah1ETTIdct120k+6GGt9JBdBDKJn4HFu5R1+UDqG3vXqkpoCuohBB2zgeA0QXAoztWEKtAhbvT1ZzcCdAMaupIJtDFvfwe42D8ieebHXIJVzxYnM477JDwMZsAyM2lERH7Rw7sqtwwpzXLiYYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sspIu6XK9f3c34wn6yaEXHQXT3giRkm2/LVKfiWRT9o=;
 b=AvUURPkxdnLr9BH5hrl5I+leJCSFkV+gHrdDykNjMjkzQtHLGppWvwjT10Gv57CNH+fvl4D30aBRZDZUUmne32WS+0HwPTXmNrGvKbjWdr9zMrINFlgomxyGONMwwI+C7vArhTRoaz5WZ7Q/TQb9uIDM105zHdmdX7Xh6+3ipWO9Ac8+cxUs7F1BfRqv3P3AfEzvjn3DF+898ft/BF/aUb5DIi6Bpv8df4GDc4KoGQM0IS7ynExVp63gze3FmyUcSxQ3zXY34dodBhfVaVgbbLjo8Iyp2FEKim/t2PmYlcYqZOLLILEfZ7nvaUnoPUoslPHaLCqe6Pb9sE3v/nwOmQ==
Received: from MW3PR06CA0012.namprd06.prod.outlook.com (2603:10b6:303:2a::17)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 11:27:37 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::94) by MW3PR06CA0012.outlook.office365.com
 (2603:10b6:303:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27 via Frontend
 Transport; Tue, 7 Nov 2023 11:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 11:27:36 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:27:22 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 7 Nov 2023
 03:27:21 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 7 Nov 2023 03:27:19 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ashish Mhetre" <amhetre@nvidia.com>
Subject: [Patch V2 2/2] memory: tegra: Skip SID programming if SID registers aren't set
Date:   Tue, 7 Nov 2023 16:57:13 +0530
Message-ID: <20231107112713.21399-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231107112713.21399-1-amhetre@nvidia.com>
References: <20231107112713.21399-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: e97d1d28-dcd2-4511-9332-08dbdf848b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGjSDYnK+9oxoEhlmNoPdyxwxdUEasiizcGQ+P32x+kkDzEJhsi3ZoijsbZhReOGXQlcXfBwi4NUDxI5Ktyie8pN9NMo7ukAXjBG7/Zo/xqFWFFp/5AmihvcwjEpYA83zojDhmBc+jNzpcsXTZUVKPSYSq8RSCGPnhfV55pW75uFWrGZiwUhXAcZRGdpAgUMznGqSHthE+WWYmqgM7jXQLA8eFexh3HmCS5HzVzZ9RYlTq5XSC+ZgkDsHRPzr1F9EHGfJbsV0txuFl2y0l1fDZuQQ9QcYqbexqYT92OaI9vrEdYiop8e7fpvJba6Wpacm9qj/8veXYemLBLQAF7+taus5MmTAqj+B57+NqJhnCWMryYAt8us/O4YJ5Ybop7aXgWMSJUjMJiaVlwsEO77G9b0hTgIma8zDf9ueai4xk2GiIRzi2HAXWnq+9x+YsA11f4LcvyRlr2jt8mSas6hi34uwx4TeyB8bVixZSd9ItrxljRKH/hndkq9+PttE7SjRffV8gBXF9YRcTilyboyv0eig3aWWwPYVg+3kyxLYTGF3GbqGg/su7W+Fk5Dds4ILmKnZDoAfhv6GCgERBktsTJsL+tXhzW+Hz6LcSHUOlhbdE0rUQVn3k9ffKDylnS18qf/rV7LMsgbkxH6hfakmmf8qzBk1JAtF7qVdBvI61fA+HW77zMmjhtIcq6KTr5iKstOS+v56pgRbjwpiGrn78KlMcPWPmFXK7PUcY6L2qZr2TQRx05uFdYpTnQfWgls
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(82740400003)(1076003)(2616005)(107886003)(426003)(336012)(40460700003)(26005)(110136005)(70206006)(83380400001)(7696005)(478600001)(6666004)(70586007)(2906002)(4326008)(41300700001)(8676002)(40480700001)(8936002)(36756003)(36860700001)(5660300002)(4744005)(86362001)(47076005)(54906003)(316002)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 11:27:36.8599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97d1d28-dcd2-4511-9332-08dbdf848b61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few MC clients where SID security and override register
offsets are not specified like "sw_cluster0" in tegra234. Don't program
SID override for such clients because it leads to access to invalid
addresses.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index 8203f0db1350..d1f1dfb42716 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -75,6 +75,9 @@ static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
 {
 	u32 value, old;
 
+	if (client->regs.sid.security == 0 && client->regs.sid.override == 0)
+		return;
+
 	value = readl(mc->regs + client->regs.sid.security);
 	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
 		/*
-- 
2.17.1

