Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07D681110B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbjLMMWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378867AbjLMMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:21:52 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E7120;
        Wed, 13 Dec 2023 04:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrFoCbuQnbYFhb/syTc+7iGfOn6RfqrtWbUwigtiqHT+V2jUoosmJtQ5maO4xgRfPolaHYCjsBQCMDV/YexLv3MMqijJ13zeBdwEzzifjjUE4qZkCLY1NLNc3rpRitom2Ub+dqB5pu2GlRvMFZAZlHnydkv5uzjnH7yItR7ArcVf+xPcVSMXy6WY/xAPVfAYSEmSWLsNadH9KLXTVx9Pf+nrO7gfB+WsxfoMDgAmL7BvJI9cfbhg7uBpEuZQrdS1JUS6fXuFQXTKoUyhMGxTLBkO0Yk+1OXCOccxNmJRljsANoOkZgsa4P4wmeoVgr4ZeY8NDU3fZBlczw+CLZhuOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eMMog2MnMnqsmecZf7t0U1qGTG82j1sYnMIXXptBr0=;
 b=PTd6Nd3b9IXkVOnMgRPNTlAKnCDxK+8lerlKwx+/z97bPwykYKxWA55IRfnNlWY7siFZUNebSbqHv3yg2n/dlpP8jSsmeAKIW/0ypd66v65TNxLbPHP7UGPDCKVXrzIzU2lNSRVnSMLoKViNTTPQr/9ZtFdEKqPmIWDA0yuFcqTc6tu4xeM874AxXPIA3V086FnkMqSLgOtCKmVKZ9KpmJ4CP1iH/ScsnWRzPrNw492Mbd44rLZePTQqwl+lhne4y6Et6aYw2gOgR02y36s340HwZLvGqD4jICCQli9bG0oE27u0i2MdWbFkvG88kmZ7MzDCVrAlQR9n7cxOVuaryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eMMog2MnMnqsmecZf7t0U1qGTG82j1sYnMIXXptBr0=;
 b=me0OkCP+jLVQWGK7dG1gBtXoy5KY12Mv3v7YeFzqm6saNpbInEffglBWLdOetuyeiJxALgaUOaqlzF7o0vIYldQZUYi5S7CVMiqRtnSadp3CeqxFTdQVeiLYYci4R9I1h3KkRHkqQ8ksDOu/j/WEFdrY40AWbkIbyPNpy7pO0shDkFde0CFr8nd5IZMSS4mEUOiQO5KNmfMzqtAuAeuM/oBCKTMhBycxI//fWhb679EYefvigY41KbyUZLfqUybBzU4VtW6f1i6m6NKh0cvwrJdyG9Eq2w6J1zI1RxwHIwCZbjztah01fd46/exLyqYno++iAj943BlTksyTmJhsKw==
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:21:55 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::64) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 12:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 12:21:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 04:21:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Dec 2023 04:21:46 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 04:21:44 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH 5/5] arm64: tegra: Add Tegra Security Engine DT nodes
Date:   Wed, 13 Dec 2023 17:50:30 +0530
Message-ID: <20231213122030.11734-6-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213122030.11734-1-akhilrajeev@nvidia.com>
References: <20231213122030.11734-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: f835d51b-cdd9-4419-af83-08dbfbd61702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nU/Se23nAcqTnLy+rKGob8BY05jVLxvsYrDyJ/15ChJRdHz/TkgBdByJ3iqSSPEbEMsU1uHJQMWficTWAOr7IfbzWJAFs0AwdVPv/fqUiobvmlQRFWnrbVKfGj3nk3U8i0M9HwPTOxZEZzfIbyyQVTvemqy7HlcahMZfugEVr2Lj704D+iPvqogcOneUN/aSSrxWNVWjbCxJysdAwGzsBJrNEDMsOIzcgU5scbzedVcEqzenBnM+HUcCU1dhl7Az0Ul6KtEj7EGbUAy9ocyzed2MhV6cis6ddKzEe7FeoI7PPECMf74uOqr2wgsaWDegRj1+XdUd+POwQsvvCX0k+BRiHgZnVT84y2W3Q7GwA56oXqH4X4Q3uuATNEjbKT7lC97ba3rhvNMukDACjRheUPOR42wVKxkCL0QohysohRUYkEC8MIHXj5XxzHya/JEWQPxOhyDtgR6v7VXQAMIIOV6C0iYF6OmOBS70ELZa3avXuNUslH8DR+nVWVtKbJ7ILJ5urKOlVI+tX0K2VIawZ2vxTBg/8pNDhtEok99LEyOl8HL6lM2A/bQLl1cpjy7JWmpq52GnF8+KtbjB204OFO1EI0Nf0orUzQfZBz5Gcs6pRzVR4wC/K80BJ7TitXYXZFSIF6igqWKrwqWUj0L7cUML3vpTVDrVB30P32pNfrR40fONRZWzkGF519j20HiyLLTfyexd/5rtrVsCHTZESrJCI2Pb3ITMxqSEqn6eog0=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(2616005)(1076003)(40460700003)(426003)(26005)(336012)(107886003)(6666004)(7696005)(36860700001)(83380400001)(47076005)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(4744005)(478600001)(316002)(70206006)(110136005)(70586007)(82740400003)(86362001)(7636003)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:21:52.9275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f835d51b-cdd9-4419-af83-08dbfbd61702
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree nodes for Tegra AES and HASH engines.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 3f16595d099c..05da74d1c2f4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -2304,6 +2304,22 @@
 				 */
 				status = "disabled";
 			};
+
+			crypto@15820000 {
+				compatible = "nvidia,tegra234-se2-aes";
+				reg = <0x00 0x15820000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
+
+			crypto@15840000 {
+				compatible = "nvidia,tegra234-se4-hash";
+				reg = <0x00 0x15840000 0x00 0x10000>;
+				clocks = <&bpmp TEGRA234_CLK_SE>;
+				iommus = <&smmu_niso1 TEGRA234_SID_SES_SE1>;
+				dma-coherent;
+			};
 		};
 
 		pcie@140a0000 {
-- 
2.17.1

