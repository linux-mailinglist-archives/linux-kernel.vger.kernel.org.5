Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2401780F50
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbjHRPf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378198AbjHRPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:35:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95A2D5A;
        Fri, 18 Aug 2023 08:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOUhGgHKDOTpQzL4Eyn16FOlCY39r6rBytEyaDg6FiOMVao9dK2ANqhUMYGfhu2Um/ajAht3E3e1zFtctqZj+ObIvxjyF51Z4E3GpAvi6zy9g+An2t3jDgPJYzMASP4pKrBvaS3L77vJgHVKS9Ye0tqEtzkPhh9BScRTBH2uvi5Yr8rsPHADWGbQGLmT1RxXhQqj09Rp/PLpnonRgp8o/UUSaKuX445bPnFk8dFY1VXcT3AH+4Hpqx1QVBgl/yYRL1t1KxjpoJfcQUBxmlfJ9v3pUOWJXKuSoyuC4rC69jZvQNAckTFyHQcHEzfqnu1FNoYuMTlJ9CtrpsyXMPvaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1NX6a2RzuIvT+jAZLoFBAlrJzvdKOnJ4t6xT0myR6g=;
 b=NXUqWtWaUdJEJ8UpkYKMM4u+Z5/11pWWTfmLQeuB9COfZvHi6VR+0fs3/nUa6G6abZkojnBVUfuR+w80k8tiWma2uT/s2c57vVW4JRTwRz84c2WYvGp47xJzpyo1R1v8LqD4F2IJ88XZVT7ww8nM4FqpGDPu7DeSYuMJS5Ch9I0e/TIwWoIKuStAKGtLq5YepxTXwqyKfbg8nZy7JX3EKUXQTkGpLKRvxEB58iMs+PWjTzI/LVijyRRkX+yEQ25ZGA0QSwbKDnAPk8SL6W8xWZmuPKzpKbCaP5Sfg0BHwZmgYKIOTSSBVJ0kqYwua2dgGWM3vyXJmwupRfejEFK/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1NX6a2RzuIvT+jAZLoFBAlrJzvdKOnJ4t6xT0myR6g=;
 b=OsXIvcl9o7d+5ydTJLvx5Q/BYBqByyXBABoK/rykwMwlwlr8LGoRyR0uYi7jlvVkO4crquz5R5OMCR/F7DmZ+RbJ9xDp4wxUVyCml9zxStJQ9yaeSf7YbBILSEUVyRriTNukgcUI6flrsFitEz9N07mgpER7drmRg5rhtfNcjAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PR3PR04MB7307.eurprd04.prod.outlook.com (2603:10a6:102:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 15:35:28 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 15:35:28 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Date:   Fri, 18 Aug 2023 10:34:45 -0500
Message-Id: <20230818153446.1076027-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PR3PR04MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6f5596-af73-44fc-4e8c-08dba000bfbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkwKLpp9T4aJDAUzVYDUC4tl2w/CJ64vjZAhtHGHVVBZ3W2FpA8JzYALC8+EZcK57xu9jz6U0bCI77YNDJ2jLKsOSCucG3DD3xo+7eJgxTwT2d+NtodJLLCrK1rXRSwTO7LZOhtHbKrIKAlTWHqWTPNZN0v+Plhq6fJ6cR4WHjpvNFvfyEk2kHmcstd9cVTF54ez39g+OTl9ovm2S3igHiuxEzQzRA1NBplI83vFo0s8SSEzuIuevNHI++bIUNmcZaruBZxU4zMki1zSvQzLo8SZjYDPyBe5jRDrmLUzx/02L2ZACr+PX1qe0xgkRHK74sJScRgU43YFJGbVvzLQeoL2qD7AiG4rS3Wnsx/vIT32dErw3U5RJ1EBvwywRxtriaj+BNaMa3DS+qdobfLfMmJ7CWF0LKJl5Vp4XMms+dSAQX1k4qjxbduuDAT+KYGGDoZtlpYYQKjsllrQFn0/7iFvWN/Bm9GkTjQbKei5eyoG2BK7j2764CfpdLhnWINz39wflrlLvX618qw50AujRFJNeZMUCD0ScTVjo3V1inYqcCBzujjFrrl+R0sSDJzNRcgK2PkukEB8Lw1mn0uUES5ABJfKS7KnpWqAMFtbriiswygNSS3ohDeHmBWeSjGx8Olu+RdUewTIaVYDflx8kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(26005)(6486002)(6506007)(55236004)(52116002)(6512007)(44832011)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(966005)(110136005)(54906003)(66476007)(66556008)(66946007)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cnNqH7jLezwLjnpLz0jjQ52ag+xZ3bv82EoGWMBbaiGmcLjXKwg8SEGZlHTO?=
 =?us-ascii?Q?0MqiAOyHhKqJsEIwyZVVJO5+gfvg327wlX67Pj6DeUwW0f7Wp4i5jxAyTtwr?=
 =?us-ascii?Q?1o18K5eTai6KowHmto4LJ0G8/tx15T52DOaXYrUHSc00e09rhS4Qyz7YsHAn?=
 =?us-ascii?Q?TLWodnFIbMxKYvspwORuh0bPREa8STjcbhAJ0B6DwlxPLejcZSeYuLQcA5vV?=
 =?us-ascii?Q?fiwZbs6KzxZj7OvTagvfupWY2NjvjjnU/1UQ99fuBUkEK+UNwHaHYlaG1bGC?=
 =?us-ascii?Q?8fw5iA1n7r1LtLGC+r2bvsINu8o61cqDXaNcUtgtcu4MKLXUHLKsnyp9SsYQ?=
 =?us-ascii?Q?pG7QTlYBzU1VRzkZFzM6rWjH2YSmiWEaE4yewjQfYNKTizp9b2/wILthOYNO?=
 =?us-ascii?Q?fxwBHCMz6j7yIVHGab6E3G1kcdWL/voPbUQHWDu/CTZ0CrsUkNgg2WS5lRbc?=
 =?us-ascii?Q?D7HaIN7xa26s52zMdhgEW+4RR0r9KgTg67u+chv+OjhGLONQaJXuuNattyyI?=
 =?us-ascii?Q?dP2Ybg+BShVELYyuOev/mT3Mo4AU2z16Lzl9D6N+GiC5cXaM8urWDQRZ7MS5?=
 =?us-ascii?Q?lmfKLu4AbAcxRT3GSu1fPJzt1kCI0GgkUY+6/nbVlcb/fzsrmlF0qaeIiVYw?=
 =?us-ascii?Q?PcHlEy1f4sjcTzdth147BFAz3v7RMqNtZ3GI9bSf6IgxRKAEUaiBYgYzmaCc?=
 =?us-ascii?Q?ZPCe+bSfdORkC4U1D9hTmZWCg/zLDurEyWdv562JxMqA3qTryCS/A62463Vr?=
 =?us-ascii?Q?vbl4AiT4gg1UXZcliLL3Q8Bhd2nGjQ3wzHszVLUUCyj+ubGPy2iHVmXi32iW?=
 =?us-ascii?Q?XyObhjTJkWz1iY1v0u8CGsnSJgfZhSq6cKErNH8RgLOi6y8xT5rvlb8788D1?=
 =?us-ascii?Q?YxBmK2R1cjadWrLnp+7FzXh6/N0g5rE3oeCRv253xnh1S+SjsJzS5E01rylu?=
 =?us-ascii?Q?yHtsg4QZoTPdr25i8/vZ8yRVBYvNefC9sTRzxbJE74SVvbI+NPp4ny9DbReA?=
 =?us-ascii?Q?A/NMFKcW8jmuEUJ/MLSAoJ35DCVsLeO8ek0ch/KmFXKmcmxicWOQky+wK+wB?=
 =?us-ascii?Q?SaKIK6uFW/8nxN1gQIUndsATko3lcoCDufTm8Z1Z44knNVYDQrTERuHSeSLV?=
 =?us-ascii?Q?xmxFLxneyvMXR1x1lnQ/O9BZ1iipt/pEnc1uKOYIugTB/PhFWaK2133JULTD?=
 =?us-ascii?Q?5ULtubiEw5Xc5W6sZs8K9BIBS7jW9YsehPr/VAe6ETv19q3vbQKpEwITe1ID?=
 =?us-ascii?Q?m4qKpkQ6moXCvpi8g6lssCDMSDQOh4meJzgZMZGLyKkVDnXVOoh/K2FOiFXh?=
 =?us-ascii?Q?ugOGF2Z+SC4JZqc/Ub6+ojyqpn0AGdbdG7UFBTHf8hDCqe5wQTq7C68lzn86?=
 =?us-ascii?Q?lCZBasYpUoPQxvhbi4mqaxalt1Sb/DETksGcgUhXbDFgzt3WQw2gKTAQfTOo?=
 =?us-ascii?Q?W1N6eV9y6TDXEhgNwwARyGzlOhBQAXtuTY643jJm4jzfqlYxo55S90hz8t+w?=
 =?us-ascii?Q?a3WphScJyUuDu1jjL7nUFrg7r+nHK2v8a4YvMQMOR4FU1yM7s88YfAtuwYsO?=
 =?us-ascii?Q?ui4/6GdmZQJ71ZVFV0QvJZlHZPQYMVc4gv81H6rh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6f5596-af73-44fc-4e8c-08dba000bfbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 15:35:28.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3Q0w7A528K8UkSlaVry7orZSXgaX5YLBCZxF7w8Dbr4CH9JTqgpNjrFF7cywGKpDa0FQd43hTECFLbxUvMK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documenting the regulator power domain properties and usage examples.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 .../bindings/power/regulator-pd.yaml          | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/regulator-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/regulator-pd.yaml b/Documentation/devicetree/bindings/power/regulator-pd.yaml
new file mode 100644
index 000000000000..181d2fa83f8a
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/regulator-pd.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/regulator-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Regulator Power Domain
+
+maintainers:
+  - Shenwei Wang <shenwei.wang@nxp.com>
+
+description: |
+  This describes a power domain which manages a group of regulators.
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: regulator-power-domain
+
+  '#power-domain-cells':
+    const: 1
+
+  regulator-number:
+    minimum: 1
+    maximum: 100
+    description: The count of regulator to be managed by this power domain
+
+patternProperties:
+  "regulator-[0-99]-supply$":
+    description: The regulator supply phandle to be managed by this power domain
+
+required:
+  - compatible
+  - '#power-domain-cells'
+  - regulator-number
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    reg1: regulator-1 {
+    	compatible = "regulator-fixed";
+    	regulator-name = "REG1";
+    	regulator-min-microvolt = <3000000>;
+    	regulator-max-microvolt = <3000000>;
+    	gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+    	enable-active-high;
+    };
+
+    reg2: regulator-2 {
+    	compatible = "regulator-fixed";
+    	regulator-name = "REG2";
+    	regulator-min-microvolt = <3000000>;
+    	regulator-max-microvolt = <3000000>;
+    	gpio = <&lsio_gpio4 20 GPIO_ACTIVE_HIGH>;
+    	enable-active-high;
+    };
+
+    power-controller {
+        compatible = "regulator-power-domain";
+        #power-domain-cells = <1>;
+
+        regulator-number = <2>;
+        regulator-0-supply = <&reg1>;
+        regulator-1-supply = <&reg2>;
+    };
-- 
2.34.1

