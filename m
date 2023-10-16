Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DADA7CA6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjJPLad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjJPLaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:30:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C7E1;
        Mon, 16 Oct 2023 04:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKD2+ISKeyYEJrfHEmlqvJ81ayNLtemkJ596wRQJuqdJVrwllngsluZtICxtSsK34g/YKma/U4SL9xJeuCm3GbGx83x2NqnPg54Jhsy7DMQkdNo5EMD4HQTd7hiJGPf2ncBUCQIp5RpBFl/a/VK05QP8e3rgTU3G1WrQUdLc4gE+DoGpfdlTlahyq34N1Y7dK4naUDlTYgO7JmOU9PiWYbKbLTOPvjNgybr07+9W/sUbRDI6Xys6Dwxvh8WUYKH/LSORLWswreccxnsb3iP/wmG6+AQ7sM9SO/HS7skzA0yhYPGtw4azlt5/rxxn5RFLo5VCFpIzqs7UNta3D3UBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aX/ewiwVvxectQk+ywRB3ivU2XZjRqHGNqzA3sRY6ZM=;
 b=QhB3FogobIys5dVkhNBFAQgo7RYduBhDfJexW7a+AlOGuhkG/LL7IIhkQenrkAPc1aRUGbAXq0E7Ch5Cp7BK7+WNt+8AuNx4GDVFb3OkE19XF26OilH6EYBkpIcNCvOy8aw2I9U7gI1XIpe8OsvX1GMVKw34aISgbKNiU1eIrzDtDSnUYANnUy3EAZrt9whRBapmOK0WDKfz9iey4lOckybTRIbpWix542rwxvS7TOXXmT7Q0FEdfgWSEFiaBeqWNkSHLrSVtVwyUzpd3q8F9JMMIM03T+OWUuOYI5r7/8Jscl+QvPWVr8NEWSdzOuELaSgwWPip/F63y8LwUsF/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aX/ewiwVvxectQk+ywRB3ivU2XZjRqHGNqzA3sRY6ZM=;
 b=Nl4Asgys8QG0iZtU5smi4V5VaqraO8XwdjTiZAK4bqnCEoBK6DQukNLGy5EOKZpd0cbi6at1Mp7i8t1v9251dyCaJzfv1g0B2Qwpt4bYWsYjpoAwjNi1W2bKkqLoY/PKatPIguFAfzcKuZXO9dFfroZ0ilT5cwc8mmVT5WVVmjM=
Received: from CH2PR11CA0006.namprd11.prod.outlook.com (2603:10b6:610:54::16)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 11:30:26 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::9c) by CH2PR11CA0006.outlook.office365.com
 (2603:10b6:610:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 11:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 11:30:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 06:30:24 -0500
Received: from xsjarunbala50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 06:30:24 -0500
From:   Jay Buddhabhatti <jay.buddhabhatti@amd.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <michal.simek@amd.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Subject: [PATCH RESEND 2/2] drivers: clk: zynqmp: update divider round rate logic
Date:   Mon, 16 Oct 2023 04:30:02 -0700
Message-ID: <20231016113002.15929-3-jay.buddhabhatti@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
References: <20231016113002.15929-1-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6183e5-b2a2-4b69-6513-08dbce3b4b16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BcVlt9Lv01vTwSLufsnqu/WibYj2NnRdDzEngbkyVxZ4waqv/x/slIdMKx6Sq+kkhBEC1pbcofmwPLw18sBKacDcO6rYTuzfgWi1cP6TcKhkYMWDz76ul8goH44TP0LkIXgfq0PUi8c1gluUQYHwb+OF4FJ5wT0pigR+Siq3FGoj8WxOHPkIF/ycJ23HnpkYTXN3s/FgiUnh8aoZPJlKjTOyU0BPf9NdT00OV6tgU2Q4GrM0FSuuo2HG0SrRR/saZCBGy3/WUAboiWrO+h+0eDPneAKMRpd+2oHTbnRNHyI7BNTbWPepzFUOmlvS3Xj4yXR0ROuQBlq45W/49KgIinlrkU/xf38zKfas7wnCzTi2ZQGMbsPzkmkh+xoptKwnRXpUpAcOihG7DtgkjE7dO+wAzvKsBJ8b0z5mREDHDlZynN+0OKFq8XavbO0yiL/x55fvRhd4ush+LaG3EznY9/8nwfd0yAdHQQne2ouZMX9/59uBPsKTRY4uYvb9xAi4RKbmBz0RR1kuMi5hfhwL9Ww2ltOWrElI6czMit8yxRHTBsinU8luyz43OxAX/hg3E3GCSCeUZCUZZlhdOPKbd/t7I73pURJTK0kY2lSu9ws5q4xrLsr55jiG3+C1pXPNNxQWvt2FXTYCHtsJekyW8gHLcvmfHL8c4BazNKi9R+F3qd9XsJAVEeGUZACCU2c+LDIz22K20xoKwbdHKXHXDrLmpVhOwBWJBa9qzA4vsylqJuwwty81V7h2dbmCbXu+KOllxQsr/Ka0WlyGDaojQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(5660300002)(44832011)(36860700001)(110136005)(316002)(6636002)(41300700001)(54906003)(70586007)(70206006)(8676002)(8936002)(4326008)(40480700001)(1076003)(2616005)(81166007)(83380400001)(26005)(356005)(82740400003)(36756003)(2906002)(336012)(426003)(86362001)(47076005)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 11:30:25.8083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6183e5-b2a2-4b69-6513-08dbce3b4b16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently zynqmp divider round rate is considering single parent and
calculating rate and parent rate accordingly. But if divider clock flag
is set to SET_RATE_PARENT then its not trying to traverse through all
parent rate and not selecting best parent rate from that. So use common
divider_round_rate() which is traversing through all clock parents and
its rate and calculating proper parent rate.

Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
---
 drivers/clk/zynqmp/divider.c | 70 ++++++------------------------------
 1 file changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 33a3b2a22659..a42c183d7e5d 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -110,52 +110,6 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP_ULL(parent_rate, value);
 }
 
-static void zynqmp_get_divider2_val(struct clk_hw *hw,
-				    unsigned long rate,
-				    struct zynqmp_clk_divider *divider,
-				    u32 *bestdiv)
-{
-	int div1;
-	int div2;
-	long error = LONG_MAX;
-	unsigned long div1_prate;
-	struct clk_hw *div1_parent_hw;
-	struct zynqmp_clk_divider *pdivider;
-	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
-
-	if (!div2_parent_hw)
-		return;
-
-	pdivider = to_zynqmp_clk_divider(div2_parent_hw);
-	if (!pdivider)
-		return;
-
-	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
-	if (!div1_parent_hw)
-		return;
-
-	div1_prate = clk_hw_get_rate(div1_parent_hw);
-	*bestdiv = 1;
-	for (div1 = 1; div1 <= pdivider->max_div;) {
-		for (div2 = 1; div2 <= divider->max_div;) {
-			long new_error = ((div1_prate / div1) / div2) - rate;
-
-			if (abs(new_error) < abs(error)) {
-				*bestdiv = div2;
-				error = new_error;
-			}
-			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
-				div2 = div2 << 1;
-			else
-				div2++;
-		}
-		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
-			div1 = div1 << 1;
-		else
-			div1++;
-	}
-}
-
 /**
  * zynqmp_clk_divider_round_rate() - Round rate of divider clock
  * @hw:			handle between common and hardware-specific interfaces
@@ -174,6 +128,8 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 	u32 div_type = divider->div_type;
 	u32 bestdiv;
 	int ret;
+	u8 width = 0;
+	u16 max;
 
 	/* if read only, just return current value */
 	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
@@ -193,23 +149,17 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
 		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
 	}
 
-	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
-
-	/*
-	 * In case of two divisors, compute best divider values and return
-	 * divider2 value based on compute value. div1 will  be automatically
-	 * set to optimum based on required total divider value.
-	 */
-	if (div_type == TYPE_DIV2 &&
-	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
-		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
+	max = divider->max_div;
+	while (max != 0) {
+		if ((max & 1) == 1)
+			width++;
+		max = max >> 1;
 	}
 
-	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
-		bestdiv = rate % *prate ? 1 : bestdiv;
+	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
 
-	bestdiv = min_t(u32, bestdiv, divider->max_div);
-	*prate = rate * bestdiv;
+	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
+		*prate = rate;
 
 	return rate;
 }
-- 
2.17.1

