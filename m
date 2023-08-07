Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA4772372
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbjHGMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjHGMKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C79126
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MU3nwebCjwpi6lLoq5CEEku1mQ12fqIyvw+gwCuBYM3G+9+/DG4nyj4Xz1CXFnFF+yIaGPdaN+AGxzfybtMVFfUgTLvDElMD+tvw2JnyjmwEbR4n4jTKzMMcNbSpQOdFs/z7c06tmnllDSQ0YyrGFwjbNONiN4PiAsoJNcHWunMits7FoNd6ScBUt1kFxbVo8Z8fanMAr1N+edi5kDxwq0bE8aLq3gPq35wtRm+QCmif2u397I2ZxRdCVolTf+ssTyatMPkMwyuA5kHsF9TshtmDQMRyJYYp8Bu6mOysTM6pF0Prhb6IeuJIrARNhjMsDX51eVgCJ8zL6PUOTjz/Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=R90WIjUBUPWovAr0ckXmaB+FmPhazYPmxk+kXwb+sANm/9cLi+T/5wgaowXWLXppkbj9tEAwOpExRAhJcOoEnpEHec49N7sN248cZb21O0hdLT4dOb6xyrRPLjDrY+Pau3dEJmqX7eqTNnK67Mw0ztDcRa0bSk3dNt7qdHAKPbZq/ALXjQzO2kRXFIXoIit6bZkf8LL/GdEZu7wC/RF3GgZryEKjqfXEByZrrKGwQkoXsyF/6D+8YTf2UHzG8j1Xd5sQaRjMHORPBq6k0PRERUchshrR9Hc3s0KesKE93PFOZtFnQp0kRLyVhXyw8RbkGYS6DRF/996guOBNwCLgqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=JP5qR5oDjOxtvevcarQteMHiKiOdhbAfwDzpI99Jh3QvQMZo+01ryFoCVkA8mOB/WHD2JEVpcrQngUNEw+sS8IT9mfvIfATBFGYMaHvy4s3gTg5MA22hyDulrPGZK/CSF6xcp53gGykCFw5MghlYed2fsnNC6m4GRSQ8AetSfM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:09:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:09:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 1/8] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Mon,  7 Aug 2023 20:14:25 +0800
Message-Id: <20230807121432.3970610-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 02788ca4-2418-459c-51d0-08db973f3758
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYAsJR2UFQnDus3ieR5vesVjdZ2bbmoyyo1TvXH7XnxbHyXVGfqJmmmBavzzSaBXi2XJHN90pxgLIWn2fnr1MUceJ5GQNIILoL8FZP351lflN42dbnDaX48gTs/fe2gvHd6uVOUfSrb0IuUMwhyYfAQs7aVniH/D1X8638esIYrZx0A2hC7rwghsC2Z6HzwQtuJyRjiY/e1B0E/UZaYci4jXDm2UlxU/cZyu0K23rq0CTUR6V6eRd2z7kZy1HLycYFhdY4d5LifqMKE9xNSvFOBal1co8/Z76Lc8R2ZTqGaIT1bhtkgGAglAPk9zElysut/kxrQQ+dH6I8f6RDk1OnrYtlH2SUL4KirwahucUlIYO7tc5oux4eBzEWSSFD2xhZBNlcFsG8egGJ0c+NIGGLCkegdHsySJAf/aas01Bvx0afMEpjrDVj4FwqQv60bMbDuhPm+6CeYfta2zNt2cFnBQ+uquHq66WHSF5hsmt9C52xMYe/+OJnbDDSQaY/PE1OVDS2xtqWxaXg6xmoJg58fcofTiXbGcRXfN3ZVaxeddM7nh0IbCgw2+nFzbBFswqH0DkSFKzAsW/5Tx5HMrEjcSS0zHSJeWKX7c3ESF0VkfiQ+2YnSt+f1XUokW6bFu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(86362001)(4744005)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdwGSruz71sX+zS8dV+hf2/Ri0rAAHfsXJ10r0tIOm3vOFmAb+hSnM4sCxbO?=
 =?us-ascii?Q?PdLJMr3BKzhdpWsrLV3iTWLq4mLxRv3Epr+7QOK/0NiOyl4WUKoBdqEzA1li?=
 =?us-ascii?Q?QcmXBIV62z9ZuItoGnCxEK/yU792IJoGBlmmRJqMA7PoQtgs/Pc0pX+J/fUf?=
 =?us-ascii?Q?ap9GdPaZQZ3Ccny9rQh2X1cEQDN+Rejj4YazPVB8ZZ7L6mRaXyhdArYN1vuP?=
 =?us-ascii?Q?eA9lbMkN9/6aDns8B2CMqTDNnqHRs8OneNZIuvYQnj4FVumENwhvfI7F+f+I?=
 =?us-ascii?Q?4myNxrALB9pnb57AC7Ai4KvXT+szIoZfiQb2Cc8yXK2CeTVQrcaKIaRgKbAt?=
 =?us-ascii?Q?00BdeVmj7ibJaD83okXgBfr08B31+qYwA4qqfAlWAvkCOV98sR0rSJD8+l0s?=
 =?us-ascii?Q?1W/ZVrya5eRmFhMINwssM/sWNOphu32tJZE9VfC3gxiMh5tI69pAYaimLFzS?=
 =?us-ascii?Q?WYArAyskj0Lr43KhdQK7WHR+Zb0CxuJ0H9B+8kO4XYihDoOuxBS33FQD2TN7?=
 =?us-ascii?Q?7cZzbwI3JBCmwni648er+KCmNW6HvjEXOojqCKyR9EaFcNMLxAmiPPdBIzSg?=
 =?us-ascii?Q?BF7Tu2VTRLvnYU0rYnjtLaMNwEMgdL1hVTEgOIIYrV2Cf8r9+3bu9rNbMG7e?=
 =?us-ascii?Q?jBdKjoj+zJx7LV7RekkhY7gg48AxA8vhE36KenLymsG7LJE2pPGU+v7bjVru?=
 =?us-ascii?Q?e8LHbBJ5H4hS9UWEwn6+naVr0jBf5xEjWcmzz0b/s6vemJg9U7zq0p0FeP+V?=
 =?us-ascii?Q?E1I1Wi6YhFdbK4UzJn8fxVR4ubV0dT3CKP/5RrD8XEUH7Z/Hffp44ENIGEA0?=
 =?us-ascii?Q?5clTH5nz15DuQhUfqCFnHFjGkbh/a3GDni4c5X9epnsUkuCqYnjidtQoCcQe?=
 =?us-ascii?Q?chsjjyrZLI6MBhddG28q00q6uDOmWeOPjI8UWMi0/Pk+VUE6SFrYgQYlA95+?=
 =?us-ascii?Q?Znoa0eqQdJwh988psrKXdUiiLY2SjvZWRkcnlMPXTqBdmdOuYcY9Xa3WZlMG?=
 =?us-ascii?Q?lD/ciOdipo5VjTe0Sl4xvLpCHm4crjXCr34ASNGcw9ePxQDz+NyeSZ/VlUM6?=
 =?us-ascii?Q?GDY7Odvi/fWxH/zx8vYbcqfYAj2pBum6zS5JM7Q86ZtVqZBn6qPb9LUeplRR?=
 =?us-ascii?Q?zQgVf7K3xa7X/taijDQtZMsuggvWkKIsCDihxRmztj8GBsiYwHW85LEqsrQN?=
 =?us-ascii?Q?NZDDCoU5+IIz/s1U+Et7mGyHGLYGVq8XXmny8vQaPq7XmJVb8BB+69ahjp0D?=
 =?us-ascii?Q?KwhOi1j7mLQOCmCqNcyDosaFDQ/wu7BSM2ytuH3KZdkeLbB/KoKDCe1485v+?=
 =?us-ascii?Q?nPVSI/MSzdBTya/zxZnbfkRSAG37jdSWDUAGE3CdryTqqibizn1KWUNBWc75?=
 =?us-ascii?Q?P8vl2YQPUdIM3RDC0xbEL6VQ8ECnXVGISo+E1tygQiPLdp14ulERQV2MPDau?=
 =?us-ascii?Q?Elm6KwEWo5DVwIVqUh/sEisAD9YSNyGIjFM1SH3zV2eEM/BtiyU1bJcSols+?=
 =?us-ascii?Q?jm+lrOH/eWhQDOh6n6J0htw2E8BSDIKFRZiZGg9AnUnAlqz4OXIzYolZFs9e?=
 =?us-ascii?Q?+T3/xmOJHUe2WWMb8NWDUPw7e2LGKz+vRPTKJpPw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02788ca4-2418-459c-51d0-08db973f3758
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:09:57.4061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rd7LwUkCgU/Ou5cLUOHipw0kl6wNQutIjdEFuyXDyr+DaDSuYV6FOKmmGF6gjCg4UU3TqMF1L3rWugLnG/5UXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Change firmware init level to subsys_initcall_sync to ensure it's
probed before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2d24359420d8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -353,7 +353,12 @@ static struct platform_driver imx_scu_driver = {
 	},
 	.probe = imx_scu_probe,
 };
-builtin_platform_driver(imx_scu_driver);
+
+static int __init imx_scu_driver_init(void)
+{
+	return platform_driver_register(&imx_scu_driver);
+}
+subsys_initcall_sync(imx_scu_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-- 
2.37.1

