Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2948979310B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbjIEVjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjIEVjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:39:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0133B133
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYJ+/txD3I9cS5sE7Q1mzMiiL/doeAwWhS68H3XklDZdFHjExw4VJfqWtvsBVgFUXJENWcX4Yr6iTDDDCqfApB8R4gdynLvX2+JmxuZGtn6yqPrQOFkLDcpDsPVoBpiXxAi/LmYnFUJErGR7nUoVzFrWu8FkgBf568ruIw+tkIfnol7RLL7ug9kDDqIBGWp1SXIVmphx1VdimLNCvEHoarj6xLn0opE2PGouhTijaSjuG6whLLNAmrV8M5Uht54oeKxhIGnuc4o3pcILxuxu/4e3Ye03wQoRM0pBOtRU/MnUVi86lTCFMU5YLYYdyMeuHihFmpY27SakgxE0P0esYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uN6I6Z4DJB0PJc+5Fsp2zn4gVQWodcXvlY9kHyPjw0=;
 b=ZNqEFmfs+7OUEePsPB7hmDMrjyy9IB/bEZQfBjKAGd6JxCwK3soR/z/LWkaGvik6M0Q5xlX3chkIGPm4lUkBEOWVfsuaxfKyggWYWLtPqi2nVAYCaY4KsHVxx4AS/aJOUDTPwRYUE+oFtzwCclWh02YItV8KrZWWMc1nVJsSHdKO5yiFT7HlgADC6Zq0Eq90cYasuCE6tywp/4fg80kzAlXOE5+sYpXPWryaBQcOR22V+OD/LLFz+F52HHlZYuzZyMq4hrQKNh4lv5UIyqz7y7PopZbtG2BDMAHnSRj1dN60p+3XDG7G4DCd2lCPgfL06BAClRvaFfe5Y5qPVJBEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uN6I6Z4DJB0PJc+5Fsp2zn4gVQWodcXvlY9kHyPjw0=;
 b=eL6M2RvLIMC9MnnTj/d2RdYMQpfCrxWWdlP8xfaXXnxPnzT82ho/df3UG2e5EoMy2iR2IHntSqzdICelmX2ZzHdPcLvD1tWyxUyJM/AaaABVmVnPJ5p8XII5NWy6w5lWQL6JDUItThO/QK1/XYv3qmMwzg22P6qiQcMpOY656Ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] dt-bindings: i3c: svc: add compatible string i3c: silvaco,i3c-slave-v1
Date:   Tue,  5 Sep 2023 17:38:37 -0400
Message-Id: <20230905213842.3035779-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905213842.3035779-1-Frank.Li@nxp.com>
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 693c9e3b-ba16-4a4d-c1b5-08dbae5889cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/+vaD92LLXYTPvUcgB1Hcz+KnVCc9nuaeEmUhIzWSbk6P64qg21W0pyKrMckEyGjuSvL6k1fu+Lvr88GBFJA6QJEQeEv/j8jod4oPPcFMHihWui1zJQjEALWiYg2LEd8FKWJsHBGrAzy6RgD7tCCn1uZdZTKr3WjfYAmuV0OsJ5TLoocdQPkG1VpP9NuFL5po29kezz7zDFXOid62bX0fF4GrnjsWxitIOEVCb9oj7b1xq/32Zvc+n3stB1hW/hABhefNTVpNASe1Gjjd+tmgvVk07hqLrOL87qMvDwn8IE7Lhx5TA+LFcb2gBvZW5pL2caGaqCS+RoyTNxeoeclPjxCiLBu0Et1EmBac9BiIJit4SX91Oyr6WvCmYj6uGzSWSQzPdLgfhNXZrZP24T/htdS1F/X6JWdjtwPFQIb+JstAg8WEYys/wu5Oy0cT3U4olP+zn5MhzKl6h6GH6+xwi+fsehJOmOPjTvOBnCdQViYHonHWP0rVkyTjE0kNLWWI47bNqxwHF6tPaqPk1DgIr7wzpNTeZHCJMpnwxPXpHf/SQ3zJVFePtVB/hpZXIBgLzMEEOhD7ysujpTCSnPXTaexoAwhVEpd39Vd7++C5N4RetFpCEtrNK0Kp/JOPXdJ/iWeb6pFwqjHbwv4sgyYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(4744005)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(966005)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbGS+NYvscYqqfn7uE5tIxaLQXsN9hN2IoyalaJ7D03K/rJ59d0gbizaC8QY?=
 =?us-ascii?Q?Ej7A7iUDdNf+2FG7gqUn6o3KXghsLGLnaelm/MnoGILAKJ7aobuLsvtmRwCK?=
 =?us-ascii?Q?Wrsi+DEgaFox1L7HU2N401nY8ulbnB5vAO2CLhYayDAi1/QcZE5TZ5IuGE2J?=
 =?us-ascii?Q?ksGmuc9rd61azjfcliwxE6YF8eQcRfILHUKDtb8MQLusCnUQaZgdH22G2hlN?=
 =?us-ascii?Q?Zj8jy3tkEC6Vn1jd7NvLACbfqnrqWaXnO77DQjilHXNCtAp4gLF0SVGlVnpi?=
 =?us-ascii?Q?gc1bi1MOegJaFQ5VMvZc/CsmbKuPaECS5zndDHVHHGltzxc32IwLLB+SO/cT?=
 =?us-ascii?Q?gNOtTfhk86TdvLGCmvLSJ+BfxH1N6gw3G2XiQANIcCfceatGSiOZjHXM1LEt?=
 =?us-ascii?Q?hEGOcbAVWkfuEmwTmdkuZjnYjq2u1A8JoqshspHWpbXB0Ji/9swstqrXW445?=
 =?us-ascii?Q?tiUlMUta2w9QYVy1lbROAYyKYkypg6ALuMnooNIwcTb2j2/Yw545pXJqeO2T?=
 =?us-ascii?Q?qRM+5kUr317CTNVu7JpdSZcEt8sT6hrcy5zPiavEEx05dsKtjed4wcAS5K2i?=
 =?us-ascii?Q?qHInjtXXnODzYJkJ2D3UWkkFEejo8SsPmWLuCPIsxDF0kIwhNLq7oc5OCiuk?=
 =?us-ascii?Q?6Slahz97XEKLZa+tKRg2+/wT2mhGLTC4BHZ9WrvduAHQ2ODyDirW0iFyfoTE?=
 =?us-ascii?Q?9LlKygs/6OfcCMTAGQAQwPDIe+bFNmUb7gKckAMWxQrPvQm70mxYt13JcZhO?=
 =?us-ascii?Q?e0QO8xdgxOb+Gevek57W4JQ5pdaM2O4jNWXjdLRmH5WTw13nc8Ww+moMpxdb?=
 =?us-ascii?Q?YJXBEd+E4ez4ttiKHEoJ/80YRTm0h1tnCrHXjBHRYoDrMY2cN7Dfl3e7CU/W?=
 =?us-ascii?Q?zA7Qssbxe8Edlb9cOltdjLotlQXYeEXk4NlqL7OQKeSCSRbWsadKn0Rokj9p?=
 =?us-ascii?Q?5gkrjzoYWty2+FhFYD90TDt1m4qSBakgOwUOy8KHdHtxspcK+YTXWqI15ilS?=
 =?us-ascii?Q?bi72CjOfcGmaQ6BLpTPEjTOCD6cNCT6yTavK1ZCb+dSbtRIyFcIab0A/lrJ1?=
 =?us-ascii?Q?G/aKTNllJtV/vmb+mGYsGzYKgcQzcaV+CsLyDTgSWciHw3PtdqoHsU4u+l/h?=
 =?us-ascii?Q?kszNOB6El5pQlDv14UK0wteDSiiBnziam/sJMRh2BEMJ1OYrkFQApj6/dvoN?=
 =?us-ascii?Q?Irob1MBfTh4ZLIZcQu3yuehlm6qVpSIRZOZVTmU0g0l1+Mtw+HmRXkXkg/z9?=
 =?us-ascii?Q?MXEjQkB+m+AqBnmEjuDEg05HTZ6Zg2jTAnEWWeIRYakEvBdzVAvJVfGTgPHR?=
 =?us-ascii?Q?oFl3LJT5uYW8XCnn2pwpkvC6g5hisCgJVrBOsLwoqXRSPiqD3dItDur1YibB?=
 =?us-ascii?Q?Wp5cAWiryJu4KhiCBXwi1pFdH1Gj2Yk81pB8WklxpfqG5OGzvVO+EPZXXuQY?=
 =?us-ascii?Q?AfzvTF4Zm8zWZYNpU6ZKJoFqtxQ8qf1w8eIVMheFR11fj4kKqU0AKOWeItwV?=
 =?us-ascii?Q?QIwai6WX0276SxBllal2YPN2IakD9ULZacM2FLODQSmhUWwC2pjwQ3yDZ7jA?=
 =?us-ascii?Q?Go9sCHpkSV0eby6KMIwq1JcSoNhUJIqCmDusrcZF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693c9e3b-ba16-4a4d-c1b5-08dbae5889cb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:09.8125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqnfVud2duBKbaGU61mzzyk9Auoc3yrs4E3CLwBpJz7sciUZe2JFY30D2mrvc9g2YqkrIx574G9poo+9NdDxrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string 'silvaco,i3c-slave-v1' for slave mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..da8a2f358505a 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/slave
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -14,7 +14,10 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    const:
+      enum:
+        - silvaco,i3c-master-v1
+        - silvaco,i3c-slave-v1
 
   reg:
     maxItems: 1
-- 
2.34.1

