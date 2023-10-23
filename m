Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E97D2EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjJWJoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjJWJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:43:53 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA8610C6;
        Mon, 23 Oct 2023 02:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfuVR9HHR/ryDTGw79atrV6ojo/eVSu5wxkg2S8kDwlvBX2o9psunqW+WmDDv4eDAFuqq8UEQ136s/Y6whRuooU0qIce6tcLE25vL4PybK9bE4rj0LCNE1ry0aFtw189LCkDFP32CF5b5L9yH8enKZJvG3uwsvOddNe9nVPDQfUXmXrBgk8Al8fUwKH7juA4tA81EyFayQDFsPX3KSeL89fhXQM0ByEujwHJG30Iuyqrg4xmANRbH6yYUBVWu1InfV+3vvkrmc5c4nFWgVkJ1q0TrqrwcDOZZHL0rN+VZ+qUHPx8lQJ0D+dcDThpfbKtzK3Zsezcf48tYzgC+sASUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFD45cDyi+lBWwuZRkCDFsNSqaPmZHrof+J+MgWP3kI=;
 b=Z1Qa8eU7/UQzUL/dWOQ4eTNt4DQKGssOXNMy3o1ZMR6nmCD44mYw6rzcIA5ArSvbsslYnE13GXswnXpCtnAuWpvyMVGvJQtbNV+CQvN8thaCNIKlLAcxGcrTbagPR56Qj/RAoh5fceyCRHgtET6f6326CrrJrn1q36HPk5+Sm3fc4mrMBcb9tWw48572/mmd8HPrJS27xHHHeM5t7DyzBGGrUbWmWeptLNtPYI2UsXN+mn1KYfTkox2RF0q57hHAT7Csob2ZyVAwRGCdfcPt5a5EVezXEK5XnHhVJsHvixD5H94KmTIahcTwuXt5OCDSEQqXtbto8G2wsGDSvX43aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFD45cDyi+lBWwuZRkCDFsNSqaPmZHrof+J+MgWP3kI=;
 b=Zg4kTayIETJTin+ot/YK1ApaUzRCXkcdfuGlBSYmfUDGD2xdqR7iu99k2holIvpWmKMmfcddy1torXL/CSwvmyMN68JoWQAq93inPlPDUgW4EXZW0kL94F5AtaXTEJ7zPoZi4jC29H+mbJlf8iwRYOThEqJszQA+sYOdPx5JSNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:48 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:48 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 1/7] net: macsec: move sci_to_cpu to macsec header
Date:   Mon, 23 Oct 2023 12:43:21 +0300
Message-Id: <20231023094327.565297-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f174cad-4be1-4c81-3664-08dbd3ac8e8f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAsl8vsudygDdyJvRpg1wfB2OlChvC1mHO/DLs6pxR4G0VBvLCe9JTbRTQnX92+NuoVhoDw1YergiJNRMulyY4FsQX+wesQQvPbqwszbPTT6d7Tg4mPfisaSPksVsmUJaCoKGqIkTXbgQH1yslqtKEB9vQPz3Zk0VjuyLiGp4+Lol5c4vGx4R3tiJ7cFQmNS/o7Gl+aL1vn+0U75Cxlu/lK/SXfgSyn61B3F5vss9qf71NKTwQqxitF5wZwvrbAP5fzCOlzoPGaZ/KzLfMt6DDpwNGmCMl1RAJOno4puH6cR1tuNTyA2MBHex+HOhNs8abyer70VVljOCMT1L8DM7cmnHCZVOKABjFdp44mQGx5flvD4rySxakGgz48M2is3dHP3tTDOE0gwaeg/43mpduoXliZYU9sPpiDN6t8Ax1R6Ddmlop098Kc84w+zewEO1Udmo+jHdoVxhuzJVksTuV4D3gdgRFd/S/UfZC2lfDmXiTrf8tJmtHRVmowlG5BEMbDhbDrHSMLsiR8ShJiAk6pygM8mlNhKUJb34b4e8heOMy+xuFda+2451HMxSgEWtkBOnhPu3SuJxNH5h6TQ/OgZw5JaRLizPqQK9X8AF95zRUBFYE0EZ8OWlbTadpKD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(83380400001)(6506007)(8936002)(6666004)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJ9vjEln5M1BCPILu7J08ickjXlG+EEBTKQPxWykC0FeyjbGVnmDXHNWCsAA?=
 =?us-ascii?Q?kTqE61fCegIYeH6TlcrdyjBTpw2/T4A+VqUKHywwQ+VZUGmRz8wOU0QRZkvD?=
 =?us-ascii?Q?k5qtLQ1D2t2uIIPG9U6SiYFcvxLVe6v6igvHsfQlPrhp+ELi78vAFSYCv9Cy?=
 =?us-ascii?Q?eUbjpfXcYH3rrLZte3Y/aytkvK+cQ6QsmDk7Fu5gsQtJJhK3hF1fiFHTdT0V?=
 =?us-ascii?Q?BrMfD7r98tiAPx/Q+4113wKJuTBQ91chdGBvZIjo6UfZbS+oDS3PKOTnMGkA?=
 =?us-ascii?Q?7+JNh44Vkk1Kl/VZA16p7gznpii3Fgd3pOfJ8TwQpobIOXcADShqoL4yzwDT?=
 =?us-ascii?Q?1WM/hb+wxHdEaCvS08hiw4ApdqEdObVvZwPO1TsBxCKCwIF03DXRMohOx2r5?=
 =?us-ascii?Q?YQh10X4gOSCXIVS6F4YLx7euVPqR94wRTwYe44zQMfipVjW0vkUp2mMqUM5c?=
 =?us-ascii?Q?yt+81xTKMpfItgA4bD/VH7J1arbKjB4l3/O6z/QQGXqkTUhDZpuzjw+8l53o?=
 =?us-ascii?Q?qMGBZwwI3kf58WclLPlHGpgzSYcMUO1k8xhebpjRUyFOKLx2/ccYLvmpWKTV?=
 =?us-ascii?Q?437oPnsIoQ8D1fvPqf0hJ+0a4yiiUx47eDb4tWYZjdg3EqA7+xBLVRwlj95H?=
 =?us-ascii?Q?yFxP/dHjpXyEpWnhD9+fugqK3k5hNm7sUYpUQe82hY6XspkXQ/MDwn4haFpw?=
 =?us-ascii?Q?5z9K80iKhnyyrWd8JUUKQ6gOAMwvUBEUll2C37B6+NmMP45oXqp468Zu1ODD?=
 =?us-ascii?Q?rPwJf5GfzJg7qnd5QT6RLQySOs44EbV5hNXGXf2E7727gGmKKjbCpNfFVdQR?=
 =?us-ascii?Q?KtZhfx/qbWJh9rWBrmzbkeGaSztuyifqxLZLIQWrd4+hHXTdi0vVlo9e8FVZ?=
 =?us-ascii?Q?3dInbSPRq0dFShmNZeUy7FlAq40N9gg2HWREG3hrW7IgwSvPq4q6fAQmBPxF?=
 =?us-ascii?Q?2nJM0bLlyFY7AnJ6v5i1PiS3Oesz/jXzRFO2Tq9dZ08jOJvwxk3x/7Ix4o1S?=
 =?us-ascii?Q?5DV1jb4Dt3bzacEmD//ya+3adgFZJ5Wa4LN+BzYmFK0IjsqFJ6ppPEqPCsQy?=
 =?us-ascii?Q?VhRUFvop/yc4KoPOWHsQMGZkhhmcG0NzEPCnhldCkCrYCEdSa6RofFleclaN?=
 =?us-ascii?Q?T+u6AotOd/gsYH4Xf3+29kBtLrRkmFI+wiHyZz3sBUQCCj/mWN1ATw1rfeTA?=
 =?us-ascii?Q?7i7PBTWsB9aqLn5hGObcBitODAkZJcR0e/kZ83L5tEP8szKV9cvICCHFmyik?=
 =?us-ascii?Q?SEw0xCfVImkXW/41qXxzWO7WRCeH86O5A4EanKT11f0Tt3xFnB+bwe3IkqOR?=
 =?us-ascii?Q?7A8DKkAMfNwKVrO+XhzJ/nnnRPQebH7prQPvxG/94WbCT9u5dZaKE8rhlIIv?=
 =?us-ascii?Q?NlL2H5cPTf04elIEVlHCU2SrFzf3V/uIGHipv5ToUAJSdqM2cLKb1S71IiHa?=
 =?us-ascii?Q?8O9t0rd52F3aRNUcX29jXky4kCm8/5PyWj1gPr8t5VWZufestqrWVyGPB26B?=
 =?us-ascii?Q?hYs8bgM9PLJ8RM873fbQmyqCOFdWKAQBDtINrLOoB2Q2WfAI5DU1yAfJeN1l?=
 =?us-ascii?Q?DoS845q2NFl6BQ5q1YkFVdqVcm5Kt3NkQRVRfG77XFJ8P5Q+yKMkKyohwkmB?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f174cad-4be1-4c81-3664-08dbd3ac8e8f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:48.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAJzqyV2GzYn/GgrkdKCNATMijB+pzqgY4w+U2HdE6O7wfDVAKMb4wux5P3dj1jrsFC8KaJRnZiRXiBYw9/EhjqQcrigA4dALXBlRCgyczk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4-v8:
- none

Changes in v3:
- patch added in v3

 drivers/net/netdevsim/macsec.c | 5 -----
 include/net/macsec.h           | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index 0d5f50430dd3..aa007b1e4b78 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -3,11 +3,6 @@
 #include <net/macsec.h>
 #include "netdevsim.h"
 
-static inline u64 sci_to_cpu(sci_t sci)
-{
-	return be64_to_cpu((__force __be64)sci);
-}
-
 static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
 {
 	int i;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index ebf9bc54036a..a5665e9623f2 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -325,4 +325,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.34.1

