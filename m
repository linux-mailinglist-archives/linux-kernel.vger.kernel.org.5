Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42827CD6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjJRIj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjJRIj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:39:56 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD0B6;
        Wed, 18 Oct 2023 01:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFMG0w46WvX9U49/z9J6enVvO2BZCi5Q+GRdMNmiDch05os96scxE/19tnIQCX34bspx/16OWHycnZAXzJGayysbfRNdP0GiC7Vfw2BN6qY2tF04y80HE93BDWIWQzXBr0z3p1zy/W2bx6E9NtvW4OyXAawSJBQMA1yHvNYjmIq9HU5I1/jzg/MbcHpMSiHWsY5mFhtq2WQGuXd21ZWvX2JE9NZFP4eqq/S1io6vPME2B8qf/xHIA8mAxR1hsDgp6zry6TE5itXhTYbGYriamjLIFD2TzOlbqj3W3+WySvUeBUzV5fRsASgc3EAIoX1Mz4mZ5p0pndwREreyiSWYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2ar563ttWC/YLikQ1nCjoV5EN+Su0CSE3n+QWnrEyY=;
 b=dKvQ8ZnyR1yBNZA3QSbv4z+NCi8f0Xz7QMZBinga5edBtLY3tGRPKr71fcIyp9k44Nt5nVsiJqruql8dVpXmB0oVBfkmYgHcuhhrIyibUGfKNvxYUKl3/9LuG9a4dp/IGDlehNibsIGDu4tiqgnQT448ftWhKzJo5tBsdA2BbJ961F9IlQDX0BXPZvDyADn8RU7X6dwZpH+Ke7iijSezkpwf5oLi6QDASWg+sZFvrjTFjxdott0Od0SlOFjm+V1hr2Wo8Yj01Sk7Ah6NJDVsuP4nXw4uN0GwAZk3pQ0uIHXSBlZ82KShilBge787AOCvvgN2C9PSoxCdshzM2XFKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2ar563ttWC/YLikQ1nCjoV5EN+Su0CSE3n+QWnrEyY=;
 b=V4qkSybKDhjkMnQivRsBm2ZgyrHA1dXO7Ptt4Vb07c1n2Dq8VUXFWeykT4C5kZafkr4NOPp4TQMI712UkVVajfGbV+EE4YXyv6QU7opDFq/bBGWDQISFVXibQvK9TFP9qsW7TqF9aUvc8IzJMM9jUitRoc1RS/RqrhqMAkD9DoE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:39:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 08:39:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, estevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        inux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: clock: support i.MX93 Anatop
Date:   Wed, 18 Oct 2023 16:44:13 +0800
Message-Id: <20231018084414.1950241-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b019d0-86ca-43e1-032d-08dbcfb5c9c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLunI3fLEe6mooOUsxSFU0W5inYQDJqO4wjptIjKMkMowj9KimYU64gvES9mPBE1t6vOZ+ZK2Zi0YanLb484C2VnPGyvWat53Hpl2IZKbSjQcv+S6EzHSpr1wjJaFXX6rnAw39fhfpXjDUrKimJ4AQUUg1jyGwbCEul7NmJFqRmQxU7NrUDHgPjaJSR/2cPaQNpnIHHZhS9phmFmfo4O2ehns1hU7crxMsBxN60F7rXZLStW1ZMHsx7+7Asbf0D2JCgTw4H8EBq17P2gLb+9H+2gC9LlmdDA5RF6uSute6j2B39z5SICznyrM7Ewl1XalK0eJXvUpVdphQiueqX0umNlPGQivc+mw0EyDMGGnxr8eB1ZLauy375/Dg4vsrufjU9eSQNwt+GLLTA3qpdhhF6W8jYNKkFrOofbnM7HiNsmFPIVUrRg72F+Ui23Vk8oRpYqKZCsdNiGc0uWu1+FdlIldNIxXQYnvCZacqFSIZs5cISe987/TDrPhfCZ4LS9IomntdqRm5T4mZoQI6NbOB+u8WxJBDJrJNtVODjp/y9s/Wt5anW9Ifs1NBuiupaqova+0z/F0wQow79AutZA0vFwfQKpeeghy+7Tz8Bxz2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(2906002)(86362001)(4326008)(66946007)(8676002)(41300700001)(8936002)(316002)(66476007)(5660300002)(66556008)(1076003)(2616005)(26005)(83380400001)(52116002)(6512007)(38100700002)(6506007)(6666004)(38350700005)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YUz2rAlIisKkh+v8ceQEiwRQHDKmXPP4pqDRih7Du0PdTBAIgYDi42fKYwL?=
 =?us-ascii?Q?kcUWf52F9FZCVoamcBw2ASX5Uznoe4QFL+IpXGIw3SEUppcf9FqlGDJ23IEY?=
 =?us-ascii?Q?HZ+Q7N8KDGYg1+KIHrTU48lmhJKKj6QnfheLKwJE3/Vs4WxAq9FPgYuugnh9?=
 =?us-ascii?Q?KlAHE4VTF5SS1lhuGWpQ32vWjeVaEDMu/oyZJCy41DrQurc9SGPxwZMynRFf?=
 =?us-ascii?Q?GCRcCFxbXWf8qn6G/szuCDcwXHTvRGR8nxJPJmVzsSsEJjYh3CJxWUYTFT/q?=
 =?us-ascii?Q?eOvtX6+xxdo3mvLXuTuuD8wdIrSTq4D5kzXvj+9Akk1PzfVTlvHBocsaZCTk?=
 =?us-ascii?Q?B2cv75FHXNfROgLCz2Gk70S7EoZBdIyvzKKsBjz3km5JDgN8co/5vknH85Nb?=
 =?us-ascii?Q?xkxVOoby91SVwjaJUuyRWGhHUmA38scl7EfHqcacc4Zi5+mwmR4kHTTV3Ib0?=
 =?us-ascii?Q?DeUWt6uU8tNF1WYSQlr8ILKa+PPXzbD+HehLA1yaGoYcUATGtJ+r44+fJHaJ?=
 =?us-ascii?Q?pdY4I1vz2snjqiYFtayhbu7bcOvLWPfbLFrxwOZQzLvK5Fx/lsyxR0szWpII?=
 =?us-ascii?Q?u5wrCc77GEEgXBsF1XGyTCFGu73WRZ/XeVm3ko80Zey04MvXk6ulQKkKclIu?=
 =?us-ascii?Q?jxdAw6LaTnWZl9c6Ok3+/S0KiW5MxXFRCXbmxdFKYpC8h8hjfH5t9CDqj6aK?=
 =?us-ascii?Q?PkD82MX6qHfafRVmJ65TsHFyhdHndQbt1g4JK9EmCpRGgNSrs5DP4ApZoH8L?=
 =?us-ascii?Q?h3EFP2juoMBPMR9QTEKKsllDhjKPf54MYn7nh+9WhysqWhu4NrzIbFme96T7?=
 =?us-ascii?Q?gaJxmm4gRaPApHDy8BP3RJ8mRgofHQdnZkg1BRhT+2xW+OjCSV8MzT8AV1ak?=
 =?us-ascii?Q?qRgacLxxXMNBEpn3t932s1QMWKIBKZ47JQKwAnpRAuzMhCm3KjpDxXt80z5p?=
 =?us-ascii?Q?/s8ZD5GehVyUNSuDP1RukgHCJdKLCYAo4BiOUh4dChfzSZp1npkUiXO5Wxmb?=
 =?us-ascii?Q?kzHlvfim4eUl6CniqCp0ynpWI3pEN7mIx9/OELCtPnRAcbqCUgYIuzI0BWvO?=
 =?us-ascii?Q?HV5Jme1R5RpGnwx+lYVoCGjR8yt7E9A6EaGQT+ZNzFAWY4LqcWwbRrn3GrwD?=
 =?us-ascii?Q?QxIEpNYF6rEkpw+el24EeV2YSDYfx1abVrsmcsko9MVCOxUG3kkIKczh6jE4?=
 =?us-ascii?Q?l9uGgWwcCQss3Cu0GmD73WRf067Ja6KxICOAe00NejQ4a2z4SRvI7ft2Yiwo?=
 =?us-ascii?Q?X2NpdKNAL28pdcUEG1ti7aHyi13mZasAuxMkVSm0NegqSHb7ZandOyYhBt2h?=
 =?us-ascii?Q?spFhR8IOrnyqjGmHw1uAA8Mxao1rjFg0Y0gCtvN5EyeU7f6SFMszMNjPMI+c?=
 =?us-ascii?Q?QkG65bUxyhG3K7dKcIRazsRlM5M9ngQNVeIb2+wj7dmGMgBzy18N36s8WE0U?=
 =?us-ascii?Q?6dUL1VzbgBXR7Zm1jyfacsH6UHnsDR8QRtXqoA+XtkNEneLFzrKLdXgZeRhG?=
 =?us-ascii?Q?jPP8dr73cqYkq0K0Nchd/NKKNEq4H7wJJ1THhClQXrXs3XZoiktMVmdC4z1j?=
 =?us-ascii?Q?JxwTXMEgiBZgUMaNzVWn3qHeG/3EtlehsK6HBP2V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b019d0-86ca-43e1-032d-08dbcfb5c9c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:39:49.7540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDXbP9EYf23omaeXNA9rbme9tFTo83a9HbYaPRV2OmHvkoMFZtkWOogVFazGWUe9Ph3Quo5iOsRTc4lvxlCMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support i.MX93 Anatop which generates PLL and feeds into CCM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../bindings/clock/fsl,imx93-anatop.yaml      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml b/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
new file mode 100644
index 000000000000..9585c9e4ee40
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx93-anatop.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx93-anatop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX93 Anatop Module
+
+maintainers:
+  - Peng Fan <peng.fan@nxp.com>
+
+description: |
+  NXP i.MX93 anatop PLL module which generates PLL to CCM root.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx93-anatop
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    anatop: clock-controller@44480000 {
+        compatible = "fsl,imx93-anatop";
+        reg = <0x44480000 0x2000>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.37.1

