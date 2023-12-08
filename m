Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E24809E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjLHIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:48:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0658B171C;
        Fri,  8 Dec 2023 00:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3vFq+jQDrh5swszaFnuLqaK9Dn1zPPGPui+8oFq02cPHNcfqPRs/5/Jv+6imPx0W4qBfGqfPvfRtzv1gnRGC3OrM2VuNtmU9MsygcEZEL6S3/fDUdg1el5oVv+2hq1pbwYPBsLKa3fzKzFldBA+bOk9qTG+z58LRtR3rRa41viKpVC0JVV7jRb3yMv2tZoItVmzP4GxUaibexXMUf4IXr/CrrIjt++4a2RW8CbLY1iV/FnEPjpZ/rcSoyNz50rTtlNfDRsSVZjk0DZHooQW/LahOrRHXHVEazz7pJ1V1LlYyLT41g2aaO1QWs2axZZlya6JEqLmwOKJFjS/nh4DqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs7XUZguBQIv52ghz1pccMJk90JdpAqyY4bK7CGB8AQ=;
 b=ReKrvEDMG5lYhW8c9jT03ArO9XWo63RqZTvg37iLKgKmGZUI9zV+6Dp2IonB2n1l/XX3zZPtkHcO58RYdhebjJo1QywVlqiwQaHemnPDDsTSISU74685xiJGDcdlm3VNs8mOaT9zGwJc5OErHI5UUCJSx2GxQBp7lw7h/eCWOTcPcTs5gaEADF0OCBfjwM5YxScvFPJAIAUemupINW8Gm3XIpQUxNFjSLy7qu6nNmbB4g1rM3VVQLWF9+PvA40cd3FY/VkecmJGC60dRZIthjNr4CbxggKyHuGWvwfcU1wYEA8MWz8VT85vzTUMC3GzJAveoeuQqOBw7KJeDaIpqMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs7XUZguBQIv52ghz1pccMJk90JdpAqyY4bK7CGB8AQ=;
 b=mICVftdv6XEE5Ar/oOJ6y42b8DphQb74BSGwvoVy0xEDCxUgcsWYIwVwsaoQUT9dp2k7MByy/rrNQd48WQAmSA3q0XigV+FASt5Ct+dBvWjwHP3Rlo9JBHBr7enfy7lcKZ2w+fnCOqvr8lAgYCQ8lXl1VLLGsADBt6ti1v1cBrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com (2603:10a6:10:23::16)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 08:48:20 +0000
Received: from DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30]) by DB7PR04MB5146.eurprd04.prod.outlook.com
 ([fe80::709e:6876:7df0:fc30%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 08:48:19 +0000
From:   Xu Yang <xu.yang_2@nxp.com>
To:     Frank.li@nxp.com, will@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, john.g.garry@oracle.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com
Cc:     linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        xu.yang_2@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date:   Fri,  8 Dec 2023 16:53:59 +0800
Message-Id: <20231208085402.2106904-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To DB7PR04MB5146.eurprd04.prod.outlook.com
 (2603:10a6:10:23::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB5146:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b92b87-3d20-4e95-7f10-08dbf7ca6d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yhLfmZQ+luxaTfaqJtBFGJ4VI+NT1KH4EwPyAMpeo+4gj+ZqQ8Ooi5LFd29wfb+j6oMV6eS8kSxvDBjlBtkdgpM5CaPa8lLlZJeldYD7euZr+RpD9gRMV5U3bauGOIcCj6v5B1p0tzwwPJvruKOIS/aXi91p8Ja1hF0aULULQZ5DsTd/ddzmiqmOfNt2wbynKMDJa7kSSFNEx4YkbkAbRxzJm3oWspvcxjGs8M6vbZFH1sjw+Jnr+ENg7t46aLMnsx0VKZQUIHqHigbcDroEFXlmnwnxz4hV7sb+xVgarZG01K7uVR6lGHStQU/QK0UKHnphlf0NqpzD6BQ6GD//BKASzyc9vBaTMys3wkDC3FN3/6kQ2jPqyeesMdphVwLBEtJn+T7O6ICvAYvJ58IFt4ooMpnizLHQFdQx3LeIdqRdxiqV1xLucqVDu1fa4rd+7Kwr7eCeHjfuoqSDyHGmFuTG6iZiU/yufqTBQTYgpld5cgGXlWHoneioNraCcC09Up6HHPqiV+OetF7fkqTJ208Qp9HG7tc9qTRen9W/PY49VjPuE70rmKkz5nUHH+WARPZusuY3Oor1Dtm4N8qxSHt3uCgz5ji2Fou6iIx49hm6wWiQ8n2auMca7mYhbE7tOefBJkpmay/viXDrOgDKOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5146.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(316002)(8676002)(8936002)(4326008)(86362001)(6486002)(66946007)(66556008)(66476007)(36756003)(38350700005)(4744005)(921008)(5660300002)(2906002)(7416002)(41300700001)(38100700002)(2616005)(26005)(6512007)(1076003)(6506007)(6666004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8ZjwOAjnRFv+LddSw7PAmti6Z71vHAT9+Ut7LS6fxjtI5TBmX9EqZaDrGxH?=
 =?us-ascii?Q?rQ2jwDFAC/gRR6OD23vb+5YPRdETjfYfB9/Uma9bnwX/1vo0ZksEKT/ZRw80?=
 =?us-ascii?Q?BGyBgMUDURJhUyS8lYTA59eGmVMehIz0OMTysMai1tmoisg+lOY2CsT1ZooA?=
 =?us-ascii?Q?KF7gyX1FsLKrH393Kn5TpSnsV86MRyqWrp3jF6/OSg5k8f+WDnnAKjQmPQzt?=
 =?us-ascii?Q?Otkx44ETnth59da2y/5YD3hwnB7QJsxweg06B/5+WqO3lbNEy4JH8GkBlq9i?=
 =?us-ascii?Q?M3oygUyNb6SEoFu51EjnpzIYFOhhNzyG7Q4VCre0WNFwxg5X3LvEsexwyJ82?=
 =?us-ascii?Q?SfX9WoCOtoK2bb9MsU5BhII9v07842VpNFjcNQSMZCzAeXwyzYgLBFMu3/e2?=
 =?us-ascii?Q?SLH96swrsNDsx+u0aIcnIhU+9paaFuSHhnOB4BoGZLwORP0MWRFoygvFyUS7?=
 =?us-ascii?Q?T0d0iRp0i7zegaRRqUCheQCmsKq32N+2C4pzG6z2rtbl6FZBvk5Dv/h64RAy?=
 =?us-ascii?Q?bcpQ+vn4cMCTWB+GEZ3p4KWrBz7KTexkPlyljlK+5JTDWEe8oksalLTiHPey?=
 =?us-ascii?Q?kbvfhRauy2uCFljS1EzzhfwSZJ9Ac5w3Jtx2CwCJZTUc8k7rtKB+NqQXADn+?=
 =?us-ascii?Q?f1l5ZrOXnOwHy0GktesPU8UsTNOT/rRj5aSFrIaxZgILEHRQbFD4RITqn3wS?=
 =?us-ascii?Q?GkJz7L4f5Opn2HDOLuSMAiZy9PQEVjZWI3p8+g0dQenmhQKmnLsFIAV1ycdt?=
 =?us-ascii?Q?9EvrXOuQfdIEnZ2f7Sf9T1jfMCzS9nqSb6xmbA3QywG8a9nCdX8IaKNlQ+oJ?=
 =?us-ascii?Q?tYPT/EBR4KKGuUvpZtm1s+lCoVjrsym3m33d8UTPi7N6dBgh2f4Ro/e1KEHM?=
 =?us-ascii?Q?BTjvN4e1ya+jcS8dElFVJojucb6rClizmGqmjeyvuVUo0s8YUti/uSIG6Dt+?=
 =?us-ascii?Q?gfwWO9rMKI74+GRav3/RlDTTejp/CMqXEOvJNn7fS2NX+Fw3PtbpguqoU/Io?=
 =?us-ascii?Q?aYlxlR0byz/2iT1MPoAsBfZ4Y2umwR8bzcdmpBgszojnqaqMA+8KttTBFEXo?=
 =?us-ascii?Q?2nNGqK5dptT6B7cr0Ryya4ES5+U/Ek6yq6LpUKsgrl5CiVQcADO/H2GWy0fG?=
 =?us-ascii?Q?/Q5POZui6GLKM2mxlQ733IbCzP7h2Q1Z9nNDprn3CniztnF4B9UPPWhoMRCw?=
 =?us-ascii?Q?XQLiZrgSNnY1wa4FsK1KOp5EwbzdXp25PLZ5nmzghxamxf0RJpSAv2dnp4SY?=
 =?us-ascii?Q?/BQiYlryRdMinEokam1UO8XOcUdfvPVAk9oiurfc5KT9Mk92N5gTU5Mk2eXJ?=
 =?us-ascii?Q?6ExMV1slNLlWMajkxa29ep/9/c/Rt4TbZBtocMwuO3MhX22bsg4sSzKqDSq3?=
 =?us-ascii?Q?7pU7Y5ygYnR2mq5HiMksu863LjTlTFdCgv5QJiXqDI7WMHc9lk35+hDhj5ho?=
 =?us-ascii?Q?hYInfz2/E5GZ6ySYfZ94Y2r7PuTIRn2+ynVoBOk/vJ2KNLX/ea+YgREckNPz?=
 =?us-ascii?Q?p/LQZFIPygu39d9YniDs0IK6TOe9s6QLCqty3HQJ/KWMb0h6zRDSAx2Se+6p?=
 =?us-ascii?Q?0CuiTnKmwrwAVxQjVRTpgDX7gDCCHlRMSsAKcYyy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b92b87-3d20-4e95-7f10-08dbf7ca6d64
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5146.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 08:48:19.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fs9nePx8sHILseQw/bQpd4a7CDYmGjDJR3sPhZF9yKvIRL/PmQKPwjHnmDd+hf3DvGPPdGYUmFKZm5lidCISZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX95 has a DDR pmu. This will add a compatible for it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index e9fad4b3de68..1bc7bf1c8368 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -20,6 +20,7 @@ properties:
           - fsl,imx8mn-ddr-pmu
           - fsl,imx8mp-ddr-pmu
           - fsl,imx93-ddr-pmu
+          - fsl,imx95-ddr-pmu
       - items:
           - enum:
               - fsl,imx8mm-ddr-pmu
-- 
2.34.1

