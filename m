Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778577F441F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbjKVKm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjKVKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:42:20 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C11D45;
        Wed, 22 Nov 2023 02:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2jvSzonDyXhrRqiA+MuDdO7B38XlL+3aULOKI/kx1NqGN7FWR/l9DpxnTZ+Ouij71lfIcvfVxmbrBm0yVUMqc1sLaOUDVX3e5HMdkM4lX3doBfpCr1WMc/l/ThpOvPRxwX6UjAc3ySIDP/scWywD92TF85QipZHdNrdKFZbztp3gUfEj4Wdb9+N+/Hoc791jV4k5T+ixCt0MSHNsYiks6ICmnNVowW/PMcC+esWPlnzY+6R/5qIotgdDHr7aHwZ4/Ljp0Bmebj3cRvnsvBJql0d76F/fPoV2lITQ2j9EKwT7q8DfA3qqEj8Hn3s5zeR7egjVbty50dSOt08dRRz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLQ2D/cm34I9dF8w36I3wzb9U6Bs5fpsAZ8NcgBV4NQ=;
 b=Becb9z6Fkhx2NgTKalZvmB2YTP49guLRKsGwu/9LQBJgfOhdQ66zqkc8bLbYeLV1iSsoXCHDgYMuQBoqTgLlstV7w22kJBSbylZH53TjQvalIKs1v5UMHqcpyGR+Vl4SdRk9odsfqzR3dd/Dm+ns43eEVEkFXRt+Z11f9ILdjWJaVPsl/E0Mk/+LqX4QMA+TUk4OQe9K/XIpj/qH+PCx1247sZYw9oV8NFdVfratAYylIeqvdi0+YoAVVBxb4Ne2O9WckGu4tAW28JHCZlwSLqcPasLbH8xlp2BHrBkoopZddT3/VtZCMW315kpzUJOvQLF0qpDxzNB8zayO8M85/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQ2D/cm34I9dF8w36I3wzb9U6Bs5fpsAZ8NcgBV4NQ=;
 b=NyVmDO8jimZobOOPhtxKCQeEToxQEgnBXdkTZwVBggbprZEy460SBCSxbN1tp6S+CpjUc6YR03YTl1YG2umSuCJkisOqHFK80VFze1LPXmitbzibLz7XXWyCX99yk4oRoYHfhEQJfcuyqcRfFsD5iiH8R2QPjeDVp6K1HD43KtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 10:42:11 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:42:11 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v3 0/3] Add audio device nodes for i.MX93 platform
Date:   Wed, 22 Nov 2023 18:19:56 +0800
Message-Id: <20231122101959.30264-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fe542d-5cb3-42f1-2931-08dbeb47aeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xb1v0yUDH6spTZKusVd7RTLsAsQOcP7MpHnQWSYNFEZDqV09/s46BLQH4Ned91gbsFEWR6OmIh5JJmDIlf0wP6gm9OL5GqZP+PWPKtOwrOw2aGQVSa+GVx3fUu5XeEhdTtFKLcQkFjdg7Wd/bW5NWQhQv38KNQc4ZpyFOjVZMMYvmG8iuu/X/+3YD5BRuux9sxo55wlH+Jhd+9LmSedicIuaKXtK7/Bd25wXzxLkOQNnMTK/EmtqNj5VWoxmS7zJiAr6mGAl8wVOw9e/9u4m8lbGzMeK9NhSGJQel5ByVvrsPZDWnAtKY0rFTrRI3GaWNdTe96kmqlmnkxB6H+CJdChbnlg5M+JiBceM3iMhrTqbusZmoxtdV2MTX1NPxn7/QQdx/vXFfebFTj967RZADc0nGjUPQ7eWCcPkd6zbionhkTj2HXDlUfVbAGx3TUstCk1SHDrDQHNT/ZbZMHYdjYl2mKyE15Vg218L/gHOWwzCX2Wk9FHctsFF3bsAtoJM9JlyNlOTbxa/n1TnW0I3MWulpNwFkCiQlxcc2eavBQEZP78Q9v53SQ81JVED8/9ys6zGbiChzPnlNlKHNckN4+8bp5fONaDYdZwsZq2+kICzXgc72uKwganVcfR7cyqveZ99l3BpHLVLa72S+sdtAyiJJrSZSnTv2v8+aaarkvs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(6486002)(6506007)(478600001)(6512007)(26005)(6666004)(1076003)(52116002)(2616005)(38100700002)(66946007)(66476007)(316002)(66556008)(44832011)(86362001)(5660300002)(7416002)(2906002)(4744005)(2013699003)(921008)(38350700005)(41300700001)(8936002)(4326008)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rhVEe85yeM2i9OTM/eWhNJCTdM+iaRRQmTjk5USLq4az+ovrfvhgwJIGHWRt?=
 =?us-ascii?Q?luupa4bioOTN55IPSM4YkZK6w/ueV9fCurw0gkF9qbh3Q2+sExv3ohSbSQA8?=
 =?us-ascii?Q?j6YDivRiGMWgQ+JHpljHJtCZGdrDb9uQJ8bF+uD/hlykHEFW5Gzg3AvKJtlF?=
 =?us-ascii?Q?OOjIWum27Eu/+hHDBmnpBW7e+10+1n7ZatzFUVwkYLIkyB+GVRCgFWYq8czU?=
 =?us-ascii?Q?MOnRmRSDfIwffr0lphUQp8UHdTMGzorq6GFaqecb/rG+u4WyjnQvQvaPVLD9?=
 =?us-ascii?Q?1bejM6lm/2jAMMXI33BRxI1663Kis8o/aKBpdjADMN925LVDGzowF3aezmVE?=
 =?us-ascii?Q?7/3FUpBLv/S6hqBcfj5ZJsL/rsyZHbqxpkQKGjQYnypA0WyBKnAH1BN9ixbJ?=
 =?us-ascii?Q?QmDfP4AWFZjoro/EHlCCY0J/++/EFBnYtzIbHO/QI6oOoToNMiUTxR4Q2yV8?=
 =?us-ascii?Q?2Wx35I+hkiBdq/84i+dgmZDQ/f518TDLFkE7naCWwGvpnjYTgEjOEG3MtUyL?=
 =?us-ascii?Q?vXoRdrpZgl/MfxCcpwrXSgq1ccwlINGeydqnbvLDVh1WKPZeY92jGIZOpR5t?=
 =?us-ascii?Q?0YGxrjIl/i3O+d9udIVI4VbL5YPF/FsiOO0HJscN/3TK3toOFjk470WUWjmX?=
 =?us-ascii?Q?CYL2wp81SgwnzdNv7zkAa9E9zhuh7hEntKlGzP5j0oUxJjo4m6hwsyCf/gGj?=
 =?us-ascii?Q?/40X+QnYRaZtjo2LW5g/g8A4xV5C0jGT3BtUwVm38wvlTNitZAr7Z8Oqi9Nl?=
 =?us-ascii?Q?5IqCHeMl9GyoAaWDgPQgqkgfmyGaIvLvdMVrDRkRsrNdDy/Qo2U8i6xio4/6?=
 =?us-ascii?Q?kYKV9q7obY/F0sMI3aABWZeKV16Bl7zzPjGIvsDfrDELkAWbkEEgOMY0xCgw?=
 =?us-ascii?Q?Sq1GEDke7G0JXPkliLtwx3Xy+Ic7rVnsEXIPFb4C5/rB1XkOYd4OTlcTsyw4?=
 =?us-ascii?Q?FlI0et7A5qRiZwXM23Nauj/1eGw0gO6aKxMeG+2lOMf7ZbRwR6OHLIJX7wqV?=
 =?us-ascii?Q?onAUDee1B7K2q4+MZ+FvVId4c2P728Fcck7L8nbXpiCE1/atr9N30GfqXmx0?=
 =?us-ascii?Q?jGlDfKfK9iwY+ljvE1pHSkb73I+py2ETdqNxlHvEzNMpaXBdK4OWM4oeSyeO?=
 =?us-ascii?Q?t7PHQkHzjEOgCU90KXvy9f0UnWljqWYnYK09/dvrYYS+3eInYGpz8vra2tfu?=
 =?us-ascii?Q?eJVwyrst0dhHUESepn9JKGddlNEApSiBGbhvvfozSxmTlw4HlYlMrTXwB2/p?=
 =?us-ascii?Q?Zf54Zhu5EBSN4YDT8a4lyFi74r44R40ZuXz39T3k+s+wByr6hY05hYOZuzZn?=
 =?us-ascii?Q?DwxQDRB+NWpUfGpH1qzmhq9GNHtGAf0iErV+8q7cSYZJnItOT/VnddyCvUpL?=
 =?us-ascii?Q?rnz9cqRYHucLn/Yp19rbqcM8UaGsq3G4T92J8Db+UEPTcw8ERt3VHrPv6QRI?=
 =?us-ascii?Q?IutioL6Rw6lMFLCri2NZ3pIuzk06secW0PKrtMymnW/kclIfSNDQTrFsEplW?=
 =?us-ascii?Q?j/6b/xfD6SN5vwPTBU5jBucPz5HSuUTU7VNibBIuyTLK/BunMg9P1CDY12hu?=
 =?us-ascii?Q?E/FpzyoteHh4ecaVrnTWxUTpJAtMWg0IcURBzzno?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fe542d-5cb3-42f1-2931-08dbeb47aeda
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:42:11.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCwJgeflJaLkO4AvC5YLSNfa4JaSiRlVBmqRPaBVrhkEaYPx/0w7GPbCeNfIyTJ5pOrtzKImQscatnInNXceFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v3
- drop unused compatible string in fsl,mqs.yaml

changes in v2
- Move MQS device node under "/" root node
- Convert fsl,mqs.txt to yaml

Chancel Liu (3):
  arm64: dts: imx93: Add audio device nodes
  arm64: dts: imx93: Configure clock rate for audio PLL
  ASoC: dt-bindings: fsl,mqs: Convert format to json-schema

 .../devicetree/bindings/sound/fsl,mqs.txt     |  36 ------
 .../devicetree/bindings/sound/fsl,mqs.yaml    | 105 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      |  89 +++++++++++++++
 3 files changed, 194 insertions(+), 36 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.yaml

--
2.42.0

