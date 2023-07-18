Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6E757799
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGRJQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjGRJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:16:04 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA02E69;
        Tue, 18 Jul 2023 02:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCWfMop4TYUuwnCBVSqpBsMg+91WnN+cLwxQrVzofEwZzZGUSM5U3awBBY7/hDYCLXGbkyAzVw4/Vj0QeKdl75WbBjJ0/97h3mpkfyYRzCFitJrCYwzFWvPPcztjEYsUsXjSSlAXaO9rNi+8a/3xhsa0/VJLgRfEI3XWuxmy4frj0EDC++cEMfXIu5wEH+v69pTFr31pYb/gIluqy/nwdnQQ342ZW3HPa3yBp6mhKVBSS+zX8VhwVnH+QfJCofvGcdOd8lGZoYDwxE72KFzM81FzFueIJGOBTWPZ3yPGMe0os3NfV/L6HjVBpFBpE0DLRXr8827qSCoM2uUW9ZOBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJbX67dORhUPujL0u4b08LmacQ1LjebYntkswY0YM0w=;
 b=Xu3al1+H2EKFIHUb6cHBJCNIBI3qJfPylwJ/HIQAXNIyjpQIFA8eZgiTm2jL/uXw+MUPqLxlsTG5oYbv7/LvK9vnuEdvNZlfG1jhM07SGKsjfTbGB353DQl043lUzA05KFvq+RcYvco/aL5Jwm49TxRqHuIvk46am/nvXmx85S0LQGvYlQMRnCghoygwESqHDWWIs4fEVAQQhcWQ9ZeCQTm5xNw29FPHggsKq3UGmx7RIRLFm/r/ESgYDzV5KKLwo7ukQ2zAUS4aqwZRUeArwTNnFyQfHUkVrd7R8Tby55PUz7KkhCkE9Z0C/20Yk0BZ1yKe3S3r5af7tU8cZkNkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJbX67dORhUPujL0u4b08LmacQ1LjebYntkswY0YM0w=;
 b=TNcxkwhvTENEnu1qRgLERf8zDutyWG7qhHGHoSRv4KqsM1TMKtOUxZ/BemVi0Dwmerfx5irt/dfzpEt8xpnOciloM0X+I6U0Wo1VpR26s27lhcxAViyZsBqOun/Tzw/Z6GxQUzxxEPhocZNG2f09gIlgk58xovSGXWIySTYtcio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:16:00 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:16:00 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next 0/3] clean up the FEC driver
Date:   Tue, 18 Jul 2023 17:09:25 +0800
Message-Id: <20230718090928.2654347-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3040f4-9ef0-4add-4a9d-08db876f9a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2ncb8i9gN7NUl0OsYUyBNnKMaJGqxNfRLeaCSM3P54PfqE6DtUYYD/SjYCKHuWFInsSUMqGR/GwlC9xJG/1RyWGfry2HML93LpTo0qmFDe5zG6YmH/q07DpS51KHokszxUhLwtkcUqP7rycWMXPnOoNYTAEMw2AgYqJPYRJjx4lXKWWEPmDzjcu+mNdmTQF6C935x09CfPsWDR0fNHaXxInlbi4WQUtt079H6LtgnDwPT7gURGyPO4oDoJcIpYqGxk7BrBlvr2As2YhMO4AYXw0lizbNij18WQY4OhqHEtvN/k+jst8Z15KTngm/gvE5qcgBMBr1VeGCLuJWPVGTetbKK4T+io0zXgPUTrwp6cRaeOwPEg8DGpht+3o/Tp1TDQD5KoDQ1eHGW/5P8zZna+kez6EL0BmGfjFTJCn+eyoUceV20c8B9V7Obn5NFTXj/XgVK01j2wsBZdGNJ94ZnHmJ+SSXD9rPzdosdrvQLdUUTIMtTaKxw8XgIHmDC43pDvJrAaAhqN9RsW8C65v+uOohaOH6f1dVzC09MuR6YDrmPNddkoi3tM3D5X2sfYKOlfmx394KRHtvaR/vt2aVsp2eR3mM3T17FFs7B/Urhb2VfmhyC2360iIyaL6xZG0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(66556008)(83380400001)(2616005)(41300700001)(5660300002)(36756003)(86362001)(44832011)(8676002)(8936002)(38350700002)(38100700002)(6666004)(6512007)(316002)(52116002)(6486002)(66476007)(66946007)(4326008)(478600001)(2906002)(4744005)(186003)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yz+GbVlKtzn4ePwlgd7SQLgvHEMrBdLbhGboAPCwFHl8uEWFEQ+fVJuMlegQ?=
 =?us-ascii?Q?R4F3zpwaJG2RgTigyJgXcDJyS6Q2YhuKN10qyRh0jZaDMElh40HSAQGcMkeM?=
 =?us-ascii?Q?CBdcJrcBs+ORUUkobJg5sVyZbAvD6C6J+rMttgzUFOgkIwhEAbMauMpVLpC5?=
 =?us-ascii?Q?iOzx0ICeJkhefAP38TKyxIpqrf5VXgltcxb5duS8Zehs2QROhUztOZ2UIX+k?=
 =?us-ascii?Q?bu0ik07lPg5A7k1cdYE3Nh/q4yyox36ByrmjdDpky5KAcs28y+NS1b4YySpL?=
 =?us-ascii?Q?L+UGy5aK23V7ltOzYQa1LeygPzbWPfy46aoga1Z0DczocL1pePOEIOADNlws?=
 =?us-ascii?Q?fD9KIqUe5vr1Wdn/I8p39XlDrYqPZah+35VF9hq6vr0A1UFyFZEBZQs2t7jg?=
 =?us-ascii?Q?RtAz2MEIKh2Zj+rplvbr+B8sgjFGrKgqgZiJi6MWGiKOxh4RkFMYiTmGuiBa?=
 =?us-ascii?Q?kftXM4BmjR20s7/26pTsTxyE/mJo2gW5RoNvuJX+L7iFzpJoa4RwfsIJmvyh?=
 =?us-ascii?Q?tOmmdHEQmflEKSg+wh3N8WXSIVk23SQkO025rfyGn8yMlvrsLsT8Zflrr1fQ?=
 =?us-ascii?Q?yN7fb/LeQZU7OpwhFDMy2dmMat6P5zbtibXPJIXDGSo6wYtn2YrH6NKmp7+N?=
 =?us-ascii?Q?Q9TVtQsEucBc6p0UiSgtN6UWBPwTOHT1b/6MVjZnehQPoPMr0Yerrvow1saV?=
 =?us-ascii?Q?sSE2HNATWKjQwB+luAs9qtGw1KzmHAi3npee3Lz2WMcHtU5G7SANzLB+K1ez?=
 =?us-ascii?Q?MQPMO5iZ3fb7Crkz2SodVUtOWchPAEwTsHOnezIWf6vnnvush6ayMPNq6wIE?=
 =?us-ascii?Q?5fLjGz0HhFwWuU7HngwVxmC1qtRw10e4PwSYSHUg857lTnb6DbGk58r25y8C?=
 =?us-ascii?Q?/T0pIjNyjZEH+sQfqywrtna1GtjzPWPJDq+XtLxW3AHy8tR67GXIgZp1RSXO?=
 =?us-ascii?Q?mhw7VOa1g9tQL6LKeVjLFE3Agfymoj9TaKHh76JE7EjtXeDZIoixQlAH+IbF?=
 =?us-ascii?Q?CGLMt+NpR6p7t3zhuLZM+4e96IAzB043QYlUB2OhLZP/YCHbZIx8oDWXXNnm?=
 =?us-ascii?Q?xzR3PA2ZXgYjgqFvgL+bN+HEUQnkRP5p4Qb7JCl5AD21T6iHtywhUScde9RN?=
 =?us-ascii?Q?f4axak1Rm3p5hkp/lWKD3zTKVqPivRiTiIvNOK8dcG/u221wMVAULUSFqeGF?=
 =?us-ascii?Q?itKWW8b4eH11E/bMSeoh5Vbydav8IblvRmhPo70Ox5X1DHUSHHGtUK2oNn1e?=
 =?us-ascii?Q?Cip+6RvYTxigPNyo629f7M/IwHFuXo1NuqRvxYgIWYiCmefoifg3BzT9LpDs?=
 =?us-ascii?Q?Nn6/F7ZwJgdU6zqLgdWKS9WO6Hdfg7Py99nMub67AahL5kCPpIfGTNuD49m/?=
 =?us-ascii?Q?aHeivvFAuYcv18kEkMlVyV3Q/YLS3l+7b34t+tnr3+8lcymczhxEstsGAdc2?=
 =?us-ascii?Q?DdW6Av6TiUn6BnaOvxC5G/+stVz3DF9CcvGvHjjDJzL6uihSPBa/L4ObuYRG?=
 =?us-ascii?Q?9lcjBZdb/me0we6UPTxos2Q8NRFDoIxl4yRaeO2L9v3k+CBf8taHGqMpQGr3?=
 =?us-ascii?Q?Fem1ex5I3B4cYpfnFaD98GRdAgKPk53VTNgtdMFk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3040f4-9ef0-4add-4a9d-08db876f9a25
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:16:00.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcig1+/zSZTFwrMeqGxOatrA0CSl/hcPenapp5vhcP6un76vI9BLDfDLzUu4sx1dX4LVR9fL36p/z07OdQbpQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading the codes of the FEC driver recently, I found there are
some redundant or invalid codes, these codes make the FEC driver a
bit messy and not concise, so this patch set has cleaned up the FEC
driver. At present, I only found these, but I believe these are not
all, I will continue to clean up the FEC driver in the future.

Wei Fang (3):
  net: fec: remove the remaining code of rx copybreak
  net: fec: remove fec_set_mac_address() from fec_enet_init()
  net: fec: remove unused members from struct fec_enet_private

 drivers/net/ethernet/freescale/fec.h      |  5 ---
 drivers/net/ethernet/freescale/fec_main.c | 46 -----------------------
 2 files changed, 51 deletions(-)

-- 
2.25.1

