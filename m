Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C5C7CEA88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344911AbjJRV6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjJRV6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:58:48 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC5912D;
        Wed, 18 Oct 2023 14:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDBcCKwZuWm0X4vzdPqKjhubmPP503LwcK71KyfIatAjtH1GYnMmCLexBygIbt87msxd//Zi9+hq3GlxOBigmez8R1VLZUgOm7GgqF9yZU2ZJexR8aabyR9XkJiwEpqMSKV2Jga6Epg1jFtNg06Y3j0bbH9K5cvEBr3ce0pb81hixCWkpOuCgIin3QLRz17tdRAava9EhrK3FdSma6Y0Eu3P90tdr4eeRrkQHWSiqHDVZdH/lpKkqdv9nb9kPONCPo8Q+Gq/41kK4MbeHnQoNGtplIlgqxhYOXHG/2DFLYi9t8GRsyxJMsF1RpZFlA0r/oFlLpMits7fn52F/QgE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdZfnlvizsuA9+zWpwMq8T6LU1CeI/2pm0F3LHVvLm4=;
 b=aW258WYc2PYAHuK+6aAjKJRysA++t9mzY/mAIGOEcPcxPo3Ccz9fhcqJZzMKAi2CFrx6EQbhvi7W40cYMQdWf4CpbfTKCOwaTV9f2A9IV1jkMVe8R7+gmGqkRHh8A+kVuK9GVL9bl8SN0jllQLrDQq1z06WNPeUM9C+ctbZPTCxXGjDDyfP2nHanpgnSo3J/nRhDRCsznL8JwSgHRFclIaDF8FnCiilJgRNyr8WBGeI/ZO4sMtNYphSqDi6g3CSA5VQCgE/xTbJ0OBnNwYPm5ZgYxGGmnJkQx7sG+wspJSCTg6SAEoOqDz9+nEkzTl9Of9sK2Mx2g8jdIJKh0mTC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdZfnlvizsuA9+zWpwMq8T6LU1CeI/2pm0F3LHVvLm4=;
 b=d/fnirVBn02TZU9T+MIOaLPP8qOSGRQMV+tyGd9fxgCSP4ox70D5qISRaKSD9L4rEltTa+F2fXgvgQM2gWp3B2jTLzT8dhAUXwwn4/Zh59nVgfUqm232/uxK6nd0KtldLgZ8yh96AMpmEtD9aCaNa6PaIqmfpXMDm5Q+NHX9NXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9750.eurprd04.prod.outlook.com (2603:10a6:10:4c5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Wed, 18 Oct
 2023 21:58:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 21:58:37 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, joe@perches.com, Frank.Li@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: i3c: svc: add compatible string i3c: silvaco,i3c-slave
Date:   Wed, 18 Oct 2023 17:58:06 -0400
Message-Id: <20231018215809.3477437-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215809.3477437-1-Frank.Li@nxp.com>
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9750:EE_
X-MS-Office365-Filtering-Correlation-Id: 04be4e98-8c9d-476e-752e-08dbd0256175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0A0F124HK4nJNU6Sy48glFsXSX5+CTlLrhdzSMd9acdevtNdIuDl59UPeYYLfSzzQkBk0/yCR+ZoD7NP1KbNDk2acbARizZstoZIKEFp8C7OcdPebrAyZ2jqF7xPQ21oqFSGI07k0dTYkHeublIdwaoR4ExREmZyK/4bI7t1PlEHK4F+nwF+L+zs8OJR3SymxN4/OQ8ZgCzGU4II16ut9QyVwMO6DQcojusMijgco04yCc4q6WiB8J5fBrULQ8zR2SvSM++4/nEaW/R9zC6wUttizjiiKtY/fG7PoguUk1igTQntiE7Zo+6TIMTAIxtbvOitAZUE5y4N8pbLPhOglx7DMDcdwJYBcmKTEBgV+5w5U+HO52A+cYkhl3+0dC2fgZgadaCYcjU0iDBoJqbL3ywLih2t7J0UBLSev63RD2GqxEK7qs6vsdmJtSEJEpITneka3DZ7PSaDlnzH0AniIhpKwxpLyruQuVjWPpt7ZA2qiQTlV2N6ZCMlV3xhW//MacFqvTDTPT0iGcxxQoOemOZeTRFpJ6LjC547XPIYFgGZaFtE2WI06mEKTtyYP9SWKxKR9l8tIr1izBl+TNNuShEgwbQ+EuLfMSqwgNgqiuPlqZXDK2YbFTXMzUKfd/t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(316002)(6666004)(478600001)(6486002)(966005)(8936002)(8676002)(36756003)(5660300002)(41300700001)(4326008)(4744005)(2906002)(86362001)(7416002)(38100700002)(2616005)(52116002)(6512007)(1076003)(83380400001)(6506007)(26005)(921005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fk94E/FCKhHguchspHvP/s5w6Cjp4HblN6gErTQ0rYpuaPpfmplZAyXWdPOQ?=
 =?us-ascii?Q?UItEQVVcLMBLYGFKSBSrNGmFE+NzzR2ixHIml0xEgenugpfRAOfaKhD2HqUd?=
 =?us-ascii?Q?DkafdzHywTMm0IJbWPi5PAejcSLO+3z5wmNgAc/LHGquFcEEYNuwVyBcdKIg?=
 =?us-ascii?Q?5xT3JaTHAgtLkzSl/ghoZfXoJP353ixvVH/f2CX2bDF5Z4F91EzbMAEE1g5x?=
 =?us-ascii?Q?DDX63JD84JysaAt69wc0iMDD4pMxutdYfdsMXIdZJ0Q8RRIK5STSgSL4g/nk?=
 =?us-ascii?Q?YUJ75vhqh0ew8WygTCAdlcescts/N5p24a+m0IeQyk/YZXG78IdSqWs+ZbHJ?=
 =?us-ascii?Q?oTIucwXOR5VMrWnOx1X6KkJgegna4V5HmRUu/CKDIaGxGkLP3YFE52WT27pg?=
 =?us-ascii?Q?ptVtd2blW+vbTsvGEPvd1VQZK9ebLjLruua9uo/TUpgEEZ4E7anpDbCeWI/q?=
 =?us-ascii?Q?wuH69ldOGF3K30/7G21XLC8WEF0RLUEtr2LScAW4tGROU6IWOOnkPdnrvgZf?=
 =?us-ascii?Q?JK6GHhpxG5XK31UBsTlagg9mz4O39/egKKD594HiIeOeRdjlXOZRPzU8mJJP?=
 =?us-ascii?Q?Lh+MVsMwgrEK9mWYGcLuwsGzWy1H03TXSlgB7YcBtyi0WwpYLIYL5xADDvQJ?=
 =?us-ascii?Q?/LhFcQ1thl0dMTrOgawUsMToM0gxlLxY34TkFtpIw8GTz4xuVJKANReelkNz?=
 =?us-ascii?Q?Kvyu3+5YSEXPZhNbkwCOPg5gP3ISv+94FpvON4ZAFcnp5UHfvKPve7X727Rp?=
 =?us-ascii?Q?AZCib29NuMIzfKsl/cE9XlCRqxt2OiUp4gHyfbzdd0zmpqUiVs/7cws48bm4?=
 =?us-ascii?Q?w++jgr84O6G6S0A3pajE1d9CQy87tlaXKe+4RY2ppgz/AYWsS2m4VrzpwRj5?=
 =?us-ascii?Q?mVtAATy1soBhgcRYzJDu0ySORKFH+oRWS967w1G5qK5iaYoDQo/g+SG4rtVj?=
 =?us-ascii?Q?GanF1hQIWnbbj5AAkpsnc2Y5VxIdrAI5b7zxPiplLK7DPuSUwpdjF1oasq1F?=
 =?us-ascii?Q?aWghuZPQXxRbFo8kQ6MO9LBY0qoxhEsZVDDnMPFAPTmCmAHAJDwQRiG9K4mg?=
 =?us-ascii?Q?j6KkfXRfjRyDBh+Dy8myPvCYe4ROqVGYIi85dLHFH80M9vrdwRjNMatRmbP4?=
 =?us-ascii?Q?iY7Tk4TEqr2EwbrgW3egxnSy1AFG53z5m4RCX0okVeFpsawcZqATlG2eKZMT?=
 =?us-ascii?Q?dHW/P5vJw8F2vO08+rgi19XkrajopkBVEvZh2BKtEW3s06k+ioKmb/UJFC5J?=
 =?us-ascii?Q?cLNUAMEmkaSFZMZO8VJ7QToQHHbfpc+TU8RzzGAh4nFDWW9V7g9EYFJyEiBM?=
 =?us-ascii?Q?k56qm5/sEw3qSBvCR06bXAmWl0hlNrGnMkjap+441ww912a7biLW6i9KUyy6?=
 =?us-ascii?Q?zaTjsSLlbZFA9eG5eO+NRECykukZKoAgODBvCVq5eCHT8GgpSkwCDmUPq3Zt?=
 =?us-ascii?Q?N9sXHVjgvqhtvXrenLLTuh9ukuipIgzE91kz8EyFscpkXNexStDJlcLPO7Zy?=
 =?us-ascii?Q?ioydICSPBsLCsYtYFXkkR5F/jkOZNgxm/LVhMrfvRSx+lVRLljgvLnJ07s6W?=
 =?us-ascii?Q?huUCDV7a21Kf8wH3Fq9NzqbjhI378XnFZTRH71zF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04be4e98-8c9d-476e-752e-08dbd0256175
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 21:58:37.3284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnRLbmLXmcnMAGAEIKWburZUmL9Kux3bol+fU7mGOEzGW99PySvOLalaDhccLklgLwDakMcUQSpL/p8awXMnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string 'silvaco,i3c-slave' for slave mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/i3c/silvaco,i3c-master.yaml       | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f5..63db63f00a509 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i3c/silvaco,i3c-master.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Silvaco I3C master
+title: Silvaco I3C master/slave
 
 maintainers:
   - Conor Culhane <conor.culhane@silvaco.com>
@@ -14,8 +14,10 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
-
+    const:
+      enum:
+        - silvaco,i3c-master-v1
+        - silvaco,i3c-slave-v1
   reg:
     maxItems: 1
 
-- 
2.34.1

