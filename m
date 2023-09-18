Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E457C7A49F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241601AbjIRMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbjIRMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033409F;
        Mon, 18 Sep 2023 05:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NthgjMTIGLoyen8gYeVp45H2Ruki/34/NQhEF9fSn6PghUVIbMaXDDQAhojFA/PW6EHBjtMvk05JAxv4V9UjtCsgq822tVWLWlxonRFHO9EHtBEfNVevrdugI2XeX6dcE9Dy9cnGLNUj8p79nyL4j1eVX+olIDNIw1PMTGrBGWusCTZrMu7cB9yPjnBFZramopWo2uwlys6j7ZVja5SIVSSwiJLA64us92i/mJEQUsfLhrv95lxjpTApIdqzdVkMz0XB8G4uoPW5rA0f7A858c/l4JD8Rg38iVbHZXBepCLM2wfFpoPl3yk5XB29tf3RU+K2O7JJFhi6avTMVGwr+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtIxQtwZ0GWRrghfzRuFy9FG8/pELMu+Y+l81cjc5Bo=;
 b=LKPB8E1xJ9v7e72cT3efvHSgcsBJc4Je4v2S7/cnVb4d5wvspkTPRNws82V4IMSMNyq6st/1ry2Tng5lhO0XOUn/U8ABgm0dNF9L1JSnpk74sRq4E76CdE1YlVcvYQyvOkn5jxB3hwRZvOnMi42Hhu3BSEWJVuewWh/H1Rb/f3U0Eqxj35fNgF4OIyU6fma+6CTZDqCUYMZPLhyZRYrQJ1bR8shGZt3nHWaLf7bX2OeUfP6S/+gLQJRhBF5KB9SR7SifT4siLZMZL7z3W4h3F6uLRFpVHm+5/lNjvZBfOkxtphoq4BON7HgQgTwRlHY3/e9EhUGq4WbWyjDO2Zn8Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtIxQtwZ0GWRrghfzRuFy9FG8/pELMu+Y+l81cjc5Bo=;
 b=yJZpz08cP/uXnRAZI0LLXSgYxkW40LBfGYNzEoBzVY+C09fx+wgXn5dq9ebV+c0spiurbtcFRxdA4qf9DDuaZNdOGLXPCWo1N69wQ6g6ONr9X7V8FdVl6aUMule3wbldxruc55cQL2+l3xk1yqo404GH7J+iJpBDd5kCpvlucFw=
Received: from CY5PR15CA0089.namprd15.prod.outlook.com (2603:10b6:930:18::35)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 12:41:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:18:cafe::9d) by CY5PR15CA0089.outlook.office365.com
 (2603:10b6:930:18::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:27 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sharath Kumar Dasari <sharath.kumar.dasari@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 3/6] arm64: xilinx: Remove mt25qu512a compatible string from SOM
Date:   Mon, 18 Sep 2023 14:41:14 +0200
Message-ID: <a1e975f5785dfb6eb04e8d5905dcaa7467ccd585.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=807; i=michal.simek@amd.com; h=from:subject:message-id; bh=GwWF0b2CKB4w87ApGsV6tGfXJ1RNrq36J3AgjqxW/2g=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO14xw24j9Gk2KKUyvZ2VWXPlxXfVilpDQWrWa4vCrd 1wvzdjREcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACby9RnD/ODfsUUrvxgIbGpi Ei9Ztm55sXKpNMOCBmO9z0fmzL63ZupbDaektT6WloZXAQ==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: a3a3126e-875d-46ad-8655-08dbb8449416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsQtAtEET0jmWgFghCJgn1++P/E1A0Eu0agT1Nh9De7A+K3148mJc3shHMllCeYn8zIQRkgij+mCcAr3wOyffdhuDHIlugAnQk4Gn5P3JeNH/sRYdB7mvZ/P+Vsy2MH+GXuWp8Uug5LTxTBI+01NghF1AYbEk0kcf5d5lkeT3Q02WnjY5S9I7AAm5lPPBVuZ/4C7xCpbYad9gYv8SKF/8AeUFzYdZ2TGxIyHMy+OT1veOIbiEh4GhJwGpnFLYEVe5HUdX64UnJ/oL45yb1slfMFrAzaU5AszkRigcEThrbffe3Vk77kuJ9hFOI6VGVYPKbmffBf19WYXTtm27cGID96ct4zH2McmcZx+k1f0v6n0Tz54hRAnQYsl7scAVzZZjUKheSaojWE/9JSFxdPUeY7uTHl2uXRvgpJx4+FfzeZEqSKumLYfwnau63s2P2ETcDNegreJcV4/UPmFqld1DRqktG3Vq4v7SkGRFzPsos/6jB5i8CIbsIyrVbSLhT/QoOj/04frI+t74rf97w0UDbE9IilmrWRUIdI/FQGVwbj75kYRmx3ZW9jvg52Pp7Z/27nBHZ8nhuCZ9HEy3Z5DuMM4hecPG3CHnt2xCZZ8pq6ItqRgAlANpjdvxpWgRa8b6gElrWQ6ANhOmQHeK46Ww8TyyXgWFfmJJn5wu+HJJW2YHUPtW/FGUkA42jK03HbHLXN/svv2Z7nLK1rCPCySaaj217LR53X4V/oY4IBFzdT7dU0duwLyj1PvHERJp6sphLET9LQWmJTJykAYuML9zM10YEip58JzBPgUZ6AIVzg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(4326008)(16526019)(26005)(40480700001)(426003)(336012)(2616005)(40460700003)(8676002)(8936002)(83380400001)(82740400003)(2906002)(356005)(81166007)(36860700001)(36756003)(41300700001)(44832011)(86362001)(70586007)(70206006)(54906003)(316002)(110136005)(4744005)(6666004)(7416002)(5660300002)(47076005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:28.3754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a3126e-875d-46ad-8655-08dbb8449416
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt25qu512a is not documented in DT binding that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 157dcb4a27a8..cd5cd7f3b5ce 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -131,7 +131,7 @@ mux {
 &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
-		compatible = "mt25qu512a", "jedec,spi-nor"; /* 64MB */
+		compatible = "jedec,spi-nor"; /* 64MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0>;
-- 
2.36.1

