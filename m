Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C576A7BFE05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjJJNjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjJJNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:39:23 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF6919B;
        Tue, 10 Oct 2023 06:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPsrWkZATAf01yB1rR0LpvxtOtLDZWpyP8ispSfbUE+XRUpQntXTqqAgCArtmaR9MS0bsXKmPDJTdiSckJECo+kU6SIKHw0o81G+HYbHET9iZGjfGIedDe/cROvd/jox0a776hlqJ441ajj8IwAU5b/MOROGejNs4FezzzhFbY9dVHB5jZ1am07t2Fb6GddvFN5geo9bJQeBqAQPL+GMgRgPiAeI1HUOutdG23IZdvMdwLVZ0p1oWOc22BXi6kKdA5JBPjG1IUOowg1iEYxnSkoKrEXLmuZhFvmhVkA2wBpc3jmktq9qwsWqR7mhWeszzpZEZmDcLH/QOfqrIAYzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtYEWJixbBGxA68JFPzL2mHI5WxKhOO3pJDbwNHquSM=;
 b=UPzubsKLDrA/VXASYE4KBNqWTHyJxasALACiHSHvy7AOcsHEOY4B/f1ppjFgdYblr9a3xwSNPzOzoi80PFLH40Ixk6CSD+2gLjDhVTx0BZyoBWF6wvtLsCuzTYLkLPB7WcVFH0FCK9fIIeCVmfG+ryk/+fd4iQkeqUsv+6jCaZW5n3XjfMHfdxq6P1NbCFWxFRgkQNeiGpB4k2+PSB2pZk4Ob4bgx+PkHXBb/r0R2vP+/TMZd/9cGJWagAggnuP1NQ5Vq/mIj8/v+zJs//5n7XTvH2ScM0R4fqceESVIyoJrYr4o7dh+PHfrpFz1FHjkb56jYqA7eXVbNhweGXuzhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtYEWJixbBGxA68JFPzL2mHI5WxKhOO3pJDbwNHquSM=;
 b=nyyrj0hlR1X9K4tnWKq9w632sNTu+RkxjJ/G5DC4NEenDMYqcTYXWl58UbzWl7AFASwnTSWdHuMzh3QqyD26pnxISLMyesK27B2ROBlJ3SXnmAt3IiSYd2/GHSFixWGHHf+40W16GnymIBZCf34pKH28wWS1bUOongdXzUclrso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:39:06 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:39:06 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 0/3] Add audio device nodes for i.MX93 platform
Date:   Tue, 10 Oct 2023 21:38:35 +0800
Message-Id: <20231010133838.799714-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|GVXPR04MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 46907a31-9c60-43fa-228f-08dbc99645b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +IHif5FsIJ7xUkC+rjGpp6pg0lW1M2LzZktQlj7oxOEHAfygQwLgCvVfrRHcCZwnDESufwf31qtwiNVBNJSx27XYEUM2PImhWvnUuIrDJke9qqq5ViFpT4s7YFWh7DIJzMC5r0A8Gu9ViKWXQ+jKPRl6mntMEcK5IdbTAha1X05HFWrHIIUoaRc3F6uafnyqTY5aosxsxeuSpG7m819EfwZlL3i1N/SK4ztwN7J+C/uZOcO21T0RwlsT8iha4zV5DB09+WVUIUzwGOadb7a8nDnMzag7C4Fw8PnGrQ6DHkSP4cTQHsqpwSQboY3ubcsGo5AS34ozw7SkzedlblLuciJIp/G6kYuqDnIfl6mPtxA3Bfi+z+Mz1hLunwmfxkcS/pysj0VnRu324S+BvULYqQOTVnA3HaBW5phAHlvJf3jrNqX4i4EiKKtAPakuK71jSuk9BDehIO95yBhz4bwN65UocDQqJjH3dSV+eaAVqvMG98NGidKd4KcJXRCxTxcRATcOG15krUcw0Qry9DQlJAl5w/gsRyupHtFNvgsc+2NplAKoX8jBdIrfCQ0qBk/w+lHWApEPpRH2kgyOxqMLZ0hc4eAWd345HnI18PJGeIhftNswprEYkleIJlUcAStsPxhHqt7SQ+499pjeCJXHCjuNxFzG+IIaxafI+ePOxvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700002)(38100700002)(921005)(36756003)(2013699003)(2906002)(6512007)(52116002)(4744005)(478600001)(6486002)(41300700001)(4326008)(8676002)(5660300002)(44832011)(6506007)(8936002)(6666004)(2616005)(1076003)(83380400001)(316002)(66476007)(66556008)(66946007)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrwXu0SUuvlnrxrTVs6usSgWFkQQIuT5LdaSCfcM8wGcdu2UWZCxhADIu8IA?=
 =?us-ascii?Q?gy3YYmUOlq5zCJkYRDUDQpE7rOONpiCdjO7VNnn3EWcqYzEAQFnCg+vXBIy9?=
 =?us-ascii?Q?15L4YeCqFvFWmdGpbewdcY53eLXTe/HuLf/KHovCfRIznoRYptVq02DE9DUD?=
 =?us-ascii?Q?gndj5TcJDJYKGQMEKZFI47pfl7jwN0WR02XZziZgP35wzgjGgHFwQFHXnrf+?=
 =?us-ascii?Q?OEBScQCVeraAUOsaqhUHPMN+Fn02pBF5yHX+hlz2xhlu2pI6onroU7sTMdeh?=
 =?us-ascii?Q?qoSCkuiAIWVVu5jSmtQloxNsNCOswSqDK9uvunG6sihbJDyAzIqIT23/2OXk?=
 =?us-ascii?Q?n+IiXmv/Kd5Bu8bbc/7B5s5LYefCw+LAPMSnIaoqCTC/UoIHMGR9aJSbTgnS?=
 =?us-ascii?Q?gjUCiDvAaJt4ZTWf4M3g72HsECtAQm4uSe0Tq4Ote+l1Klk7d7hqKCfaek3Y?=
 =?us-ascii?Q?uoGJB3xQ0+hQnpp2qQRjtvGyh2bOCOvefCzfGjnqAnUQWOvmy0iy1v8FLt0W?=
 =?us-ascii?Q?wa9Nl+Gaqip0SKf8h9aj3OD19M/x5or28n0IvYFhFY+2C7A9IYIiO9sopOTo?=
 =?us-ascii?Q?tUAmxoBH6xbyUgNpqjbFVa11O9+auSnX8l7Tj8PjP3x0q9+rGBprWWj9tL8T?=
 =?us-ascii?Q?rQSFAKq6HLBFtyghzMeHYtbdIFWS/SYvRoJqmyfoZ3z64DRNRZtbcDBMdLoH?=
 =?us-ascii?Q?NWoxrrzOCx5VIcaKccQP7T1Sr9dWdn7TzemO1szr5uK4RXQFK8f6GUQbZ/ga?=
 =?us-ascii?Q?sVhNgSUEJ+dO1Z+3aUAren9gBmXHauFKz2FXf6fegdX5rNptkB+tUEygjJZQ?=
 =?us-ascii?Q?JPmRUJqLDUiZcBVD7VcSrv2essS/2z2TLJq57YPLxr22sZnDIWPQDCMC/unI?=
 =?us-ascii?Q?KWEAVowzfaxoZhMUcpqPW6oqWIbzIENx8fBJLJjeQVHsJaSNZijraUh90OkL?=
 =?us-ascii?Q?HCK0p+mxxX0YMgY084dW1dHrF2n1uM0H/ZOYbiCyaAbvt9yhkF2/AytBaLDd?=
 =?us-ascii?Q?WZ/v1KI1oTbYXN9sfcQFL5NoKA73suQIWxRvNrfUSY+K4vFvjY9lSeCbdRAA?=
 =?us-ascii?Q?XUL+ZYlbg3WZ/cZtAGzVjsw5IgzvfzktBBUnlQQmFuhrHhTonEsmnF6qBWwI?=
 =?us-ascii?Q?7+HIPR1qp5Cb7lzon4HwQ5ASWC5w1Y8i2jb8silbv60bfwMUdILpM02LJv5S?=
 =?us-ascii?Q?l5mtbFVeyNB1tsZW4pwCHVHSGmaR7UmJqraMR5T3kYORsejHfy75FlxJNv3V?=
 =?us-ascii?Q?Hl7bWrDuHair70+kwGGANRE5R7DWxSPPLsxLDkIrSE0MnqcAPRvPW/aEWzAl?=
 =?us-ascii?Q?Q3yWtrKvsRmtz4gHGVEUbr4NA7s9vEqEsSs6bMktJlhkXicxQYw+VDlZGQpn?=
 =?us-ascii?Q?WeSKM3VLGFEvtzZdsmQD+eRoDukDTrqRISs9dB0xZnQmxmVTY7gMYasRxd94?=
 =?us-ascii?Q?s2D5bXmou1sN3OXAN3IH/mzJS0w25CHG2uu1pZ35snTso+YOOsjhU8A523Q4?=
 =?us-ascii?Q?YEq5KLop6UyrWPz4dsUysUd2QezZVDt6YzXitwlvvyrnIwdr74iNcXpSA77v?=
 =?us-ascii?Q?cVVsX7YhzKKp8DBVC7rLTHqw1wPjoQfi+V4N0f2+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46907a31-9c60-43fa-228f-08dbc99645b6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:39:06.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhyMsaNi0+gZz4YHHT5Io12h/ZnL5mPnqk6i+NTGdtrlNgA/9knr389AOf3QfcVS7LBdsidvjxDq+lIg6uv7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v2
- Move MQS device node under "/" root node
- Convert fsl,mqs.txt to yaml

Chancel Liu (3):
  arm64: dts: imx93: Add audio device nodes
  arm64: dts: imx93: Configure clock rate for audio PLL
  ASoC: dt-bindings: fsl,mqs: Convert format to json-schema

 .../devicetree/bindings/sound/fsl,mqs.txt     |  36 ------
 .../devicetree/bindings/sound/fsl,mqs.yaml    | 113 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  89 ++++++++++++++
 3 files changed, 202 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.yaml

--
2.25.1

