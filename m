Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74E07F3DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjKVFo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:44:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A2890;
        Tue, 21 Nov 2023 21:44:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtYDkLAH6f7B5Qr+6rcNzU2QO0oESjIhTa7qLmitQgmy5emPbazJrjLHa+etf26sw7HOkvJM8xHv0c4FdVZEP22auuAjp38E32BLu0RzM3bX4MnptNfj5/PaXDR+tKacjpSNwFHZCTT4gOwJ9De3D95fQz51S/ZIaWahndTLgrInAaDSrX33aodlXmOeHGlRSKu4Xbi2NJ5ZzmIKjutpeIl+HEZuMleZlHcvvsCtdy/0a21fLTC/KU+3mGdbsN20DKd8jJk7KkePhzyGqeGSQKqBtvlla+sQLRGkH7MBM2JV8SNkDkKZfkn85efxU+XNzevvDxYQl30oXic56uZ++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bJHqFsQ7Ql6vWH0BAWPzKyvwMprZO1GxJcYFeMfkmY=;
 b=oVqnyVW1T4OTL6bCRf8FxJZgBT/Y27unvWeOnowIUorcXkAgfGDvNO0oQ3zIAyJm+6TA+wc20+2TV0mLbmilPI4OCnt2yuPwHFNcE+L/UdG/zPZeQNe+M68Bw3Z63HchW5ITZEc1XzDFZlizxM6kGHklDY37ScvjzDULIOEW4z2Q6+hSQmbXc26s3nIkLHCGf9DZa5TSFeznVGfJd3g9Flig6uDTWdWFEhWLn1FFpBrednaFFXMooRbxutOSt/fwDNYNxygDiKJKKn0GQqQdyfC5cPaiJFSP5S4ZBN5gmno/WjsOctcO1dt6DK6Hvm9QsUb5VFUdxzFOwyid3HN80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bJHqFsQ7Ql6vWH0BAWPzKyvwMprZO1GxJcYFeMfkmY=;
 b=P+s4S2FsbCnKvofgZsD1StyhwCMzlEIIiYyT8KQr1n1PIInrosRJWhEJkDNoeiSrtdHzYOZ03E82rvZihmVbndxoKcIm4H+H19cqXx3IDwV+ONMG5UEnZSviL/FnRWt5DuRqoWHEm3yfbVKE7jxQomZbiaL1TyOsLo1SXsIQC08=
Received: from MN2PR01CA0019.prod.exchangelabs.com (2603:10b6:208:10c::32) by
 CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.18; Wed, 22 Nov 2023 05:44:11 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:10c:cafe::41) by MN2PR01CA0019.outlook.office365.com
 (2603:10b6:208:10c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Wed, 22 Nov 2023 05:44:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 05:44:11 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 23:44:10 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <mathieu.poirier@linaro.org>,
        <ben.levinsky@amd.com>, <sai.krishna.potthuri@amd.com>,
        <tanmay.shah@amd.com>, <nava.kishore.manne@amd.com>,
        <dhaval.r.shah@amd.com>, <arnd@arndb.de>,
        <shubhrajyoti.datta@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key encrypted bitstream loading
Date:   Wed, 22 Nov 2023 11:14:02 +0530
Message-ID: <20231122054404.3764288-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bec07ce-8717-4782-5ce7-08dbeb1e0db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oh8yo332bctwMxeDEQd59bKPdlZrUIuV2m8/tJsZY9IH0I6CUiwwf967/58FGdwHm26bMiaVf9KndbUiZauFe7zVXF6njIRF4POLzAe/pnpR9uXR2Y5laBFmqa2dJGDSGUCRut+YvKBnR9zz9Z+1I8K8rSUfzjZW48rYeIqnt2SA0tTYtvWDHlvU2yOMOaTVw9v0hZyyJOQ20YNVXoI27NhBehnv49qXzaK8oYfWbMzK81weMkPiUOetw2QD+apWXEUnjcWmXeEATAQ9r5HmCRmkye1Rc4WbQcsmgzjWmjYQaRbDv29Cr81UFT1GkBGih/OSS0TpC7xqAz0rCuUsWdF+2yB/iCp0iBH6k9im8Y88oxuVhnc60dKBZJCbgruSa4CZsRP9XmSTk+ni15yDXnTVnD1RBKBmCqRz84RgOf5saYtWh2hiRC7Uli/vnwcwTqtnG7h2uBqeGKE18GUcFdAnu0SCGmMl+WY+UipnGcKtAJdYGqsNYqaT4470MM7IjEuXzphGKruiKd2XW360O33EwrQpjtPkdf3sFGe7eumtgU7Gm3a1DtGIXBfN/abDISd+OwCOk/ldm507h6DI3YEDhS7C7A5LS+Q0Y7fL2HeSYfX1jSHX+E3J7PxS5xbAAwLSGR/zwhyhGJxgk93ZnN1y53RW5vUufH+224NFAxvNQEZ0x+4BBYH3H2gbEnFl06HsutoA6+CgISqeoKbHbbzDF3Vio6GPCG7v0uw097QS4b74x1wl/50mhputWkJlQzBDasn3WQKpTgLBrKGzdcwk+VSFTdSJf2/klxR5PPtzKL9/gxQfQ+JqT13KeaivYuYhN29Vvu58E0DR5RF8xA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(36840700001)(40470700004)(7416002)(86362001)(5660300002)(2906002)(8676002)(8936002)(110136005)(70206006)(316002)(70586007)(40460700003)(36756003)(921008)(41300700001)(103116003)(336012)(26005)(40480700001)(16526019)(426003)(82740400003)(1076003)(2616005)(83380400001)(6666004)(81166007)(36860700001)(356005)(47076005)(478600001)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 05:44:11.3862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bec07ce-8717-4782-5ce7-08dbeb1e0db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ‘encrypted-key-name’ property to support user-key encrypted
bitstream loading use case.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../devicetree/bindings/fpga/fpga-region.txt  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index 528df8a0e6d8..309334558b3f 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -177,6 +177,9 @@ Optional properties:
 	it indicates that the FPGA has already been programmed with this image.
 	If this property is in an overlay targeting an FPGA region, it is a
 	request to program the FPGA with that image.
+- encrypted-key-name : should contain the name of an encrypted key file located
+	on the firmware search path. It will be used to decrypt the FPGA image
+	file with user-key.
 - fpga-bridges : should contain a list of phandles to FPGA Bridges that must be
 	controlled during FPGA programming along with the parent FPGA bridge.
 	This property is optional if the FPGA Manager handles the bridges.
@@ -459,6 +462,35 @@ programming is the FPGA based bridge of fpga_region1.
 	};
 };
 
+Device Tree Example: Configure/Reconfigure Encrypted Image With User Key
+========================================================================
+
+Users can encrypt FPGA configuration Images with their own key. While decrypting
+the configuration Image the user needs to provide the same key.
+"encrypted-key-name" Specifies the name of the FPGA image encrypted key file on
+the firmware search path. The search path is described in the firmware class
+documentation.
+
+/dts-v1/;
+/plugin/;
+
+&fpga_region0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	firmware-name = "soc_image2.rbf";
+	encrypted-key-name = "key.nky";
+
+	gpio@10040 {
+		compatible = "altr,pio-1.0";
+		reg = <0x10040 0x20>;
+		clocks = <0x2>;
+		altr,ngpio = <0x4>;
+		#gpio-cells = <0x2>;
+		gpio-controller;
+	};
+};
+
 Constraints
 ===========
 
-- 
2.25.1

