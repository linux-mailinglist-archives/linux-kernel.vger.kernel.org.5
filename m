Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62C97F0EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjKTJL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjKTJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:11:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ACD6F;
        Mon, 20 Nov 2023 01:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw1lZB9MCrxCfSW64/nfIT7wRNprz/o8eRwoggh9aLU8oem4nmBbORQsKlfeF0kcJFOj/dHWRH1pAqxnc9YQd0UGRFuoHp74CDngHfDNkFTDNmGrl5OX7nYhKptuBQQgEQKTKDyUTkJ3yRkFddxl2bFnowPoIgyc0Dy+2uXqhPOJ6F9tAUqMFmz8DvfiI5+ujNy4pMSdwEaC579Ntshw4FHkTFtax3sEQ3pfOPpkZTLbWz0AjPKUBl95ewnb0Py686PIF+50s8A9gnu0jt07PedNMNyGuFOOLYgpawf/PwdECqd2XdipSkxqvi8nPb0b1uu4qmOhKcYaqXwd8xdlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5Zm9WgaTMly3B/H6hzO3V4scDXzTxTOzR0Fy0s91A8=;
 b=kXazTQQ6wBs/XDxtwKi2rUB1TYfCsoSSDbpsqgUFSjZ+w53WAQQ/4lXpaRolSxqDlZw2QJSwHMbYSINp6Un6KGCujb64eKXeuFQJ1+3x1l/mmJa4moIYWrqgArOSNEqGz8dGJT1eTStMNJDcB9M3aK40vTsioXYAWHfkVQMCS2DUho/XnSWkr5dtGp4gb6v0ulkmZ5EhUzlAV2fk8FQTMp80fnPy7d09QsvDGE2Ui0fp4MlWOm3ow+yToqhBhfKSgSDVkA9+DRtxV+XBPaRrc41u9abqy68eMFyiE+mFeSIKEWyrs/HFLdjPng95jNUMxGhg2JM/Cdq8FtkZn/Nd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5Zm9WgaTMly3B/H6hzO3V4scDXzTxTOzR0Fy0s91A8=;
 b=GjBxv+KFtFXV7h5YuC2prapKiFn6RtHs3aQMt0dkqcu+R0cNnNmb2YEfP0zxRr8vNWIIa3D+qYXzCn6xkYThxq8myHAiTtalxwvEHnyywWn1SUeAlaEy3nhKP+syv2ACvpJA04MY3CLutEzhQ4jtp4UhdTcUkHHPMCk+jCgJ81Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 09:11:45 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 09:11:45 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 0/3] Add audio device nodes for i.MX93 platform
Date:   Mon, 20 Nov 2023 16:49:02 +0800
Message-Id: <20231120084905.664-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0052.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::24) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 488667e5-85ac-4423-398b-08dbe9a8b783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBch4hNu7ij9+0EzCUfz5szYVxXwZPRyf0nbEDaFkAdp9/uhPeRVp7biEvtyInTsM1MENv9uHLUnk9t2M2rkTN+LcE/Vd3JB2wqDI07/AxKvZl6LJf6vw2GdZqPjuKnqZcn5/nRY+KH9mola/+mCLRvo2wkUiYZay6XxElLOmwNCGFEkmRqkDauspgBO2nLOQj8ybvwr2zPTe208ohVDFeE05G/t9JjlSh2j1gXC7se8lSpl96tS3sYwINCAOFn+6cp0i+EdeqaRBuDh1Q5ctVlV2H1Z8ugyVzL2V9l36xTvRpw8obBge3IJxOz2S5mtk5319iBGLg5ErgtvFfRDIaOwX+3L1xHTKSqEmH5v7ywv8k9R+DIl8xz1uUbsbaLZxBzqlDS4lxRpi8yA8/Rxeu2TMt6ezzKgqKTeGbxRCzVjwCpoIrj5oVDtyDE7ISkKnAhu+7or3g9YOmO0mO3j1eXL0Tj1eZyJjc+nylGrrK9pysjZD8Jr+MkM49/xVxMBN+D7ZDfsaH6psz5zhdvrk1SYc+h0sHAwt6JUx95hQRctHQZ2S1JGdRJED8zxnmikI3bnywSJFpvtWKcGliVWVpwo2891K7GU0EafWNkdjEOqf8tE/7aUlW8Z/z4SCeQ9sfYkUrRdwWvs1XrbAfJysE3iqlIkNWddwSxxK+MNrhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(36756003)(5660300002)(86362001)(7416002)(44832011)(4744005)(2013699003)(2906002)(38350700005)(921008)(6512007)(6506007)(52116002)(2616005)(1076003)(26005)(83380400001)(6486002)(478600001)(6666004)(4326008)(8676002)(8936002)(38100700002)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0F4p7b9Adpr42sqpyAU3wCvqkNL6vur2VHXVFUyOcclTXG3mahno/nn54VxW?=
 =?us-ascii?Q?lr5dBwFqFL6V0XWHJDDRRpgj5H4W/CHylC7tCPEqs4KP8JJBZ2iFvSfSrM2T?=
 =?us-ascii?Q?fJuQEEx/CA/tFtHlks3ZZaVkeZuFU9hRfZXkz4lUFCV48MXXbLw780jngPqi?=
 =?us-ascii?Q?IvvzUSfM4PuIEAe9OlUljAdwYZPePN2qA0dgo9/yu0E0TGLANx0pEp8zp/bI?=
 =?us-ascii?Q?MKaiHJraCwbUsXeS7NsJRI5abKhLFzHieKAWWOmYccb/oCEHHRpoc0Zxro0E?=
 =?us-ascii?Q?IOjst3SG/Npo90QInUmYMDFnupUvDLPLZHrKQ6UP+C3LCN55CAaHG0QEDpIT?=
 =?us-ascii?Q?SQbqydOSccIjF4PwCpEwN5uS/nNUYz6JIJOKnJU6fk+2Qpxz8IsycQC0GFQV?=
 =?us-ascii?Q?X845pYHvs2PLkp4ZvT6u4XO9jr2HJ8ZbvOqofLlUwJLAYaeCjo+xUFzPM4BY?=
 =?us-ascii?Q?JbYf4J18rn4tjWSH2t+WGpUMY2IJAj+hE/tYguztu+e+Bv4xC+r6FzAWOAcR?=
 =?us-ascii?Q?KxiesUnmQWgibxjl5tgvjQToQ1voVN5HYiKhf41MLHRukf+qBYOHtdgH3tvG?=
 =?us-ascii?Q?YKPFQp0hW9TBv1ak/Obp7/61QdUgvGi9Zsfjg/xGn1VX/4dTBX3diOLyvpdz?=
 =?us-ascii?Q?x05Uc40QzQaSEKaN9lDDDGAjC7LvyUZLcdQBnGATs3fNFcoUdxYwamdIvJnS?=
 =?us-ascii?Q?Cath0Nkzw/ICEZG5CHChURIXFCqHbs0Vj/gL28UlDyRwKyhwbAUlJosC0uwq?=
 =?us-ascii?Q?S4e+hsx8Pl3BlvDpNI9TM1xfNlL6BVYoH0t/qO2WSkG27Rih5jrG37G3V4lQ?=
 =?us-ascii?Q?vSs5qRPX0Ie6m0OpYkM/NCcmnLjAxUN50xI37Qqc4Q0gc2KInoM4HSQeH2Ao?=
 =?us-ascii?Q?dydpjV8Bo1LAYdOOe+SdOnpUhaixiEPc8z1dl9ibcEq5CI/mzVPiKNMH1yuh?=
 =?us-ascii?Q?SK8wTch/WGbs3ByiWGZE9qiS+491O40WZLXhLoIxqZc0EcG/I9kIrK7FamDS?=
 =?us-ascii?Q?neY+R2kQ3mJtlMejZVtbKvzslN0Bjz0+gfi27yDF0soJPlHlrF6E6Xg5x2B+?=
 =?us-ascii?Q?2HVKDb4F38Equ3K+m9prSpUuemVa7T+gf6dEb56QLkA4USmI8YxhFWrPSs8Z?=
 =?us-ascii?Q?sRZOa3vN5Hm8eSi4p+dLrUOFJk1qeLBO8NaAnxLwHOh81qouwNE34hjcJ1qq?=
 =?us-ascii?Q?bZBzPfMbbTRDo9iEwgx2bhnKBD0prL2xI3vYNycMPvYvqjgcwuOO+L03a0A9?=
 =?us-ascii?Q?Sfc2+RhwrkDSuf9RpE/M3vcIXKZGmYgbVhniulXkTMEB85QmBTH+ClxItlHM?=
 =?us-ascii?Q?+NzaKrVwGswCcLRa0seluUQHJCtd+L+fwBVdMC4wcuwq1QMOGSevQLrZDxu3?=
 =?us-ascii?Q?dtsId9e59KkQFofq4zs1zvp5SNc3gyJ/oMVNzPJ7LWd/Z0RdofWzPueNDU2/?=
 =?us-ascii?Q?RMgJZ9711fx4fRNiw0MCHD5y7488vCvO6vZ7a7dwZeFpExOOV2ZElplBXk54?=
 =?us-ascii?Q?UgqqD2yXrrDrAFIfleAdqwRAKniRsdMJvS9rDtyhUEll3zkm3chhrJobZzZH?=
 =?us-ascii?Q?R/20rhiZUW7pdSYNTYHHtVau9CkBWBBl2NWoMq41?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488667e5-85ac-4423-398b-08dbe9a8b783
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 09:11:45.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig9vPCLhojaMayweUX7s9iwLaNNA1D1VzJR/vYifUSfnnTZ32txX2ePsl2ASpT6fjODhuA+nodu4lgoCqRcilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v2
- Move MQS device node under "/" root node
- Convert fsl,mqs.txt to yaml

Tests pass based on broonie-sound/for-next.

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
2.42.0

