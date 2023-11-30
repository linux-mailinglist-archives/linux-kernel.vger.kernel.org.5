Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85767FEBBA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjK3JTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235005AbjK3JTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:19:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC09D;
        Thu, 30 Nov 2023 01:19:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8o19HzA11J+Q7f+Itg+J2R3Of3Be161a30NfyozNtQpi7M3k6+Y68qtcWUU/1jzhJDebhDOKNd0X89w4hDOYvLreQvAyHVZ13lbuB/gJJI57i/P7QWRttVncohfGlHZfz2n3/CjX8OVtMd1wxcjYWGZji6ZaNt0TbqBowC4ja/xvrYn3B3zjgNClYZFv8Vg/TX8G3xG0xdm+n1UKIIvXj4mF9K6Be+YtDCISBhP/d+Oq8b3xLL+x2T2FBi3M+Y2mXGUc3ZSjlqEpWd1I4DZhSOlPGaLDOfR6OX/1WZm9LTfAz0qGcCT7VDDNkmhgM6GgDNwCc+e/PPUeZJ9ZwjrmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G75rfuPqwp2/8+msItH4lPmcCDQEICNWWfPSk2+0ekc=;
 b=guzSGrtVYORKO/1pP+UB49XyaNn2AlLQ+faPPnOMawyZLkWvKYoOLBHKLebP0eCRjHCqt6ddDfHNgnDJWaV50r0kBE+uBmr+dWzm6vwXVkkaD33zk4k6mAF14yNJV354xdlYDPDnqaVb2t97z5g1Lw4RUf8VGW5rVOGnckzvmW9dkBflsjM0my476VtqIeZiR47tif+wWJ0sHBy6+VWhXQoy2XRWpPOC03skqxM5wjJExKFCmuJR1d42Fhw0MZen0UTfP6EmbxiV0pxqUv3+sOTIgx/JCOs6IlOvSWI1QM55/J24s+AM5q4pVJztzSkOWK+HgnxQbDcwtYQkDVYQQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G75rfuPqwp2/8+msItH4lPmcCDQEICNWWfPSk2+0ekc=;
 b=wsDNVcf0KX9dKqhQCU0o8sWrwZ77gPfCJo/cqKdxbPaEDuRtIvGwGqhnXPYoiY5ZeUm3IiIG9DfqkEMk3E2UFWKSFYHUr4T/FWlyyIsco0H85L9QaDx5Zsc1NojeTOT29QEx2dEXl1IpSp0lqQBpZXTeOauthYTyCch1VGKv5SI=
Received: from PH0PR07CA0092.namprd07.prod.outlook.com (2603:10b6:510:4::7) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 09:19:21 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::ac) by PH0PR07CA0092.outlook.office365.com
 (2603:10b6:510:4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Thu, 30 Nov 2023 09:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 09:19:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 03:19:17 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "Varalaxmi Bingi" <varalaxmi.bingi@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Add missing destination mailbox compatible
Date:   Thu, 30 Nov 2023 10:19:15 +0100
Message-ID: <96460adbb99ea829a2a95c72a40118f81946a559.1701335951.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=michal.simek@amd.com; h=from:subject:message-id; bh=vVXSnd/m7XlAKzIy/jc4XdAR4+mKFzQIkY5LLmvJkIY=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSM4AkWznpzbB86KTocXP16u6V+w5zgJvGQtUrLlN6oN a1UsdHriGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPJ52WYX7mso3WhRNL7eYJu ry9tM1L0OVJzhmGeecAazT83hd/e3tneG/j7w56DRYmxAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b0f892-a61d-4d78-2219-08dbf1856ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2MUwylJvTYrYJEMOXiDSxYUM2DX2ireckjW2Toy3yvn6HLS5oFJs/aIzgaBlQ0zLKUok9aqei2/toZVYAotHmg8RbnH2K05BV6gbcjMkf1/AZk+euLqcpgX+HJ8iEHQPeajjuwgfnLFjQDwe+wNvvSLAfWxpP/fNIrXH5BE6rn3vRoSwmpnlHT+CHPQjfLJsTtRGOi45ab7hIcXAegFCSb12RFoxqak7vvKxG5Zm3L6nXR6jOYiamhrPtfr8oa0bpTwE3Tlxx1UWOVjiZa/8nT/UhZ6I5kqtGv1+SWpEVFCqJI94qUbRdqPSFHXjS7pbGpCIO32c6KITkXE9rM8MlG9Xi7VbiiOpyHdrscN4mxHycT7aCDrvSwbp9f98zatSMmPGvUOVvIWDOYTk/4s0xjwaVtDncFi7qj5qJf5Pto0MJoK1IvZbZU+9Odl/ih6z6hpwkX1NNsIfOyVi/4yboIYmjAywNsuc3A+XS6dJWZ1PomGLt/NoQRzK6GMtCMP0GnxaU0A91YfsLOrOu5/78KuHXiA/1gLjwsSvbJGbjQMAJcoE0qGr4B+EkAGjb6ZsYxkv9t73A+L9NCkQiZNpqW+XB4FJI0Ui36TewzCxFaTFceFBoBc5DqdoWPPq1c1e48fzMVZRDOHrJ7Jd7Zgf7xt5tm95ayAp+iQsh5OdbJ74B8deQNKezN8bMIgcyqi7vO/K37wP3EO3uOvDSxa+zk32oairbBZBh2EdNRd8UiIzifA/NvcWHw4kP4mg0pFELRXzGYQmBeSesOa7Ram7f53oHgNAkSjsWL0UH3Jp25cbnapL60NMgxTqjlFJTpXfQjBzpKbUPFXyurBzvpCyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(70206006)(70586007)(54906003)(40460700003)(336012)(426003)(316002)(478600001)(81166007)(36860700001)(82740400003)(83380400001)(202311291699003)(36756003)(86362001)(2616005)(44832011)(4326008)(8676002)(40480700001)(5660300002)(8936002)(41300700001)(47076005)(356005)(7416002)(110136005)(15650500001)(26005)(2906002)(16526019)(4744005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:19:21.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b0f892-a61d-4d78-2219-08dbf1856ff9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 81186dc16101 ("dt-bindings: zynqmp: add destination mailbox
compatible") make compatible string for child nodes mandatory that's why
add it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f5e1eb8cb3b7..eaba466804bc 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -141,6 +141,7 @@ zynqmp_ipi: zynqmp-ipi {
 
 		ipi_mailbox_pmu1: mailbox@ff9905c0 {
 			bootph-all;
+			compatible = "xlnx,zynqmp-ipi-dest-mailbox";
 			reg = <0x0 0xff9905c0 0x0 0x20>,
 			      <0x0 0xff9905e0 0x0 0x20>,
 			      <0x0 0xff990e80 0x0 0x20>,
-- 
2.36.1

