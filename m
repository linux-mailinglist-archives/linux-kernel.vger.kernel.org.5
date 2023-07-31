Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86737690EF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGaJAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGaJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:08 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781783
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mwg8dNXSfMKTLLlP7WtOfHPWr+zYwEZrFX3KyobCwC5IBywiM6OLYguPuSIuAoYtsbYgSpAqtZTvHdDVz3TAwyOA3OoMl1SFaPJv29RZQQV1a9CnqFUW/NO2yrtvWABIg5w8MX0V/MmU4d0TfIxyBVA21/qfDRs+vZrTMEFhDn8N7SHVykbHvS11ia8hamH+QGo88H5KI5YA1ysdehivVeEwlfQbQterOmJDE6j5K2uUwMwqgJRe/9GdmpClGsf/zceB4r2dNSBVUQEiqm2wugQR0+sYuWD7mp1jsNImiVYlWcuf3Tah+GjZLzHJpwGEz36IC5KZuLIsKOwR9IaAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLE4VXbM7I0vEJ5LN1CJcBM/f5qZ6lH+EEJmrct9h5Y=;
 b=C89cQ68YW2mDAd7290ht0NsAIEHyoqyQilKAl9xBxSY73l2S2lHTILvHQUws7XzWkMfwRIBrwDRZ596hl2CxJOUvZHihlZFxkdr4uTSN+wpAHXRIfNgZroBTsPmH7Jf0S2+cvL5M/eVF51ROYHUu53I0fZ2ZB9SQVB088VK5aZq46vg3/Bo3jA6aWGLsfi0tM9oSe/B/RjxUDte14QQ6eCC3it3lgUWcNtbMHCte01bdWLEgsTSXWz/WO9RxLONbGLAAVOxHT/7idxiKlz3jBh/wd/afQ7jkd8infunnNwoueTUStUy+Hjh7PUiK5+EKIlDpUZ2cUfOGBKL5WmVq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLE4VXbM7I0vEJ5LN1CJcBM/f5qZ6lH+EEJmrct9h5Y=;
 b=QwM93cr4hyrKUkrvGHIriY66MN9wqElJOETcJF6oDi/ZsclqcAtcy9JXPhPayiKfkrpe2k7TpEBd0GJ7bj5N1L72cXdeKgvaRKGn9dlPBqNAAJCc2GjxunVMH6C8TIgAIvowIMWtQbGPrP7TB35+sOqfatBZHFh/PwQzEmLT2UA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 0/9] firmware: imx: scu/scu-irq: misc update
Date:   Mon, 31 Jul 2023 17:04:40 +0800
Message-Id: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 72137e5d-edb8-48ad-f926-08db91a4867a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R6gEd7nGYuHX796mua+EVTlBVkmlNO51VCESGOS9AoPYbtFEqaAYVH3TFOiVx0qrs3CiTaPc7W/9PmfCcjnSLomps/VdKfJap5FL1ilpajv/z0+WPZBoHMhzkthav14opDMOeRqjIGBBzWxb2XjcKUoPHJKI6XSPSxbfiO9LtXbtLQSsEjEfdY4uL0ovelBPWJyJJF83yWF0DkAwVZ4WtLJIjH8Ft+CnAChGsH13x1bjjM8texSxavbH08xWXy0bYFFwDB3lVShzHp+jxYm5TlAETrjA01bz/xH8hFgKgmcvYbDAuqtqQ8m5+ljfia4jEn1QC4ALMmxmtPS+dbRzdYAsopL1TKR/+s17HtMpHZ/egv1uuZPw4EZnsBAVTd2snACd7FH07DDp7g+QsJfjna8qvMlopqIpoU3d1s+WVl+Z/gQmPlxfxyNA1AB/rJXYPjdXavPvgU7RzT8u6dIi+73PjzCqcmVloYiHCs3YW9Xh+HFsOfozAxR+jSunNvz47xBnbNcy7JYepNqKRMJ1EBl7xIc04LYDG98cqrwRzwPJ4eDYoJpC3nY498P0LWutPyTuyh21ZCUv5a1pj/lbvMPWk7EMmmoK7CFfO15GEEc03zQ0URY9bPSd37ZOjQtD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDK47PabwP7N5Cv72hupCd2VBmXEpwV1QHB4ztRB7DfwF9gcnVR20IszmnX2?=
 =?us-ascii?Q?CejRdY+Uv2KoQeg80PrNO1wKYigKcrqRMv0KUuLA9WP2xg+kB1MvzyzoO5EC?=
 =?us-ascii?Q?HTPkV0SMYFm7ODxANJQVRGV1kPtyYyPlRJU6OfbPxjAKwHf4grmnfPoJif3T?=
 =?us-ascii?Q?wdSgvjKEGyRzMDG+3zEctDppsOnc9Pjh4++OT+S3uZZtcGgDAfM2QspzhUI1?=
 =?us-ascii?Q?OLJbN1ZDyHnFokEt7QGoMBmipZIXvDbPOcwxxVuHTwPYZsBKj6hW0Dxm14+f?=
 =?us-ascii?Q?d8UHpbpvIOqcerngiXY6JZ/FXEjWaRmFvbCmhPwtFKrAk2bInkI8txg31xuS?=
 =?us-ascii?Q?dn/kHnJj3uA4DgR/wcmuj/M5ORxDN7Vioy9YzlOF+Rwo75dcuNVqXhrtE8sx?=
 =?us-ascii?Q?AVk3FIBS59g3W41RVDVsO6UhmT7nutemWv0LCLuSwg6w4uvfWzv6ceK0O60W?=
 =?us-ascii?Q?JNH3t6qPtZZAhtO68chc9V1rn8yM6C9c6zhJ6ZdnzNQfVxki3/vNim2eLwIs?=
 =?us-ascii?Q?jFxWdGldg7oOsrb6l/wlUe4+w2bjuexrTl02tv/r6j7SbDTfcwYMaDZ4dUYO?=
 =?us-ascii?Q?lTGo5Vt4SAf+HAkwDWSUMd6AZKEfw2Mz+CNbHQWFXNlTitdG/vwrd5Htr8yJ?=
 =?us-ascii?Q?l8VjY41Bgxuiznz9xLY1pAPr7X1b9u0p8zhYaBseanE8tyV0oUykTidbASjB?=
 =?us-ascii?Q?R0jNT4k/Q/Ugrkaeg5B+gZPB2sGRlqaLJ/aP8bCysaQre1Jfc82GWvKWFG7M?=
 =?us-ascii?Q?5VgEW4RslV2j9ODw1QgcGS/LD0SYbII36KhUngRLTx1RCMthG8o3TJmWuwbU?=
 =?us-ascii?Q?7Nrn2+BPSLPO9CAKtbNc8ikBnu22rE8vHRmQMg6bZ5zszH4Zfxp2b47P3oZa?=
 =?us-ascii?Q?oZwS7htegtZwKmK2zyFCzFDv23zN0AWDbh9hvYzbjxd2nDEe3FwF3EwIKL1s?=
 =?us-ascii?Q?YPbXk/rQ84X28MfRdYtuI4+Oyz6t1qBQSyJSJVGqPMMXqvJKIWArbDTnKYDh?=
 =?us-ascii?Q?ZE/wF89NrIcwhn/i8u8H7l3y/sEhN9bWyc+bZMPQes0fdFGwbDa6S+2jFG/3?=
 =?us-ascii?Q?vFfcMGUsmxLjLEZYEHGaBEY8tsWyu2w4R7coWG3Jrw22uBvMvtQC4cH2qz9Z?=
 =?us-ascii?Q?r+k/+2MtiN4/psVBIJ2ITJWwcL1XyGYGhF1dtkiAfr428pDwtYgTYatgyMOo?=
 =?us-ascii?Q?v7ywOWhoPm+5eZmtUYTjqjlNachNik6le/r54ovvTk06FS7bWjO0Ae61XQvx?=
 =?us-ascii?Q?DJObFA7ASVz773ODVTNSBUoXN0uDzenCEmm6Z9ebweBdPukxwM4F0vxslher?=
 =?us-ascii?Q?j4BeEDLl3rPYE2UBYRc0jLf8YO0VHuWgEfoCsPtC44Z+de3FK3iY3Pc954cH?=
 =?us-ascii?Q?ANJgPirC781LWRrdgy+SvIAJw9F1TgHqiqDtTuEWtzglwcKUNqQtfVMOP41L?=
 =?us-ascii?Q?4F+s1XT3GmTfWA1MBGonS9+zXi6uDvKcZlBjnO1d0w+6ftk6ATUM8OegeHeL?=
 =?us-ascii?Q?M7zHegZCiLr4gqaiyPzyxchI8j/VHJgYqfAhLECHb0VNa4kbWt1GuRclXuYp?=
 =?us-ascii?Q?4ysVYRa0ugKtXktyqQtZ59qgKH2VteM0vW3Ihcyf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72137e5d-edb8-48ad-f926-08db91a4867a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:02.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QsKQccoMLyilLngFi2g2bvbsj8e2bQzI0uAEp+V0FMQvSWpdvAtzQBD8aWtANBqGIx2GJ0CmYXnlRGbvNk0lSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V5:
 Address sparse checking in patch 9
 Add a new patch 5

V4:
 Add static inline for irq get status when SCU not defined
 Drop two patches wrongly included

V3:
 Fix build error reported by kernel robot
 Add patch subject-prefix

V2:
 Fix build warning

Dong Aisheng (2):
  firmware: imx: scu: change init level to subsys_initcall_sync
  firmware: imx: scu: increase RPC timeout

Peng Fan (5):
  firmware: imx: scu: drop return value check
  firmware: imx: scu: use soc name for soc_id
  firmware: imx: scu: use EOPNOTSUPP
  firmware: imx: scu-irq: export imx_scu_irq_get_status
  firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP

Ranjani Vaidyanathan (1):
  firmware: imx: scu-irq: support identifying SCU wakeup source from
    sysfs

Robin Gong (1):
  firmware: imx: scu-irq: fix RCU complains after M4 partition reset

 drivers/firmware/imx/imx-scu-irq.c | 116 +++++++++++++++++++++++------
 drivers/firmware/imx/imx-scu-soc.c |  19 ++---
 drivers/firmware/imx/imx-scu.c     |   9 ++-
 include/linux/firmware/imx/sci.h   |  16 ++--
 4 files changed, 119 insertions(+), 41 deletions(-)

-- 
2.37.1

