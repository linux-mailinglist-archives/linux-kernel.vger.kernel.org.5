Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB87AE288
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjIYXgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjIYXf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:35:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2128.outbound.protection.outlook.com [40.107.223.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A082A1A8;
        Mon, 25 Sep 2023 16:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMMCBW883aV+GbYlXZD5S2Oeq2tkA7sU7DzBLZlPLRbaZ1Sgo2YGXy43IcH2bbR19eZzEVVWvIFCpKPU4vA1i11lgD1jI3Prq6ILkIghoT3MIGpBjPiIy8HKeJ5a5ikdJi17BEnCvXDZDQNJZrIDvlakJPpgbV/1c9nN65JtxW+exjK+LvlCnLW2CsUa68SYn4bAZKKY28TozbTn6UjAD1a4c8EYe2LEMwBohsnH8JxbTWT3WbhqsivacvqgR2/Pxlu94Zb8qFmutV0fkR8vkbAlsR9hl99bgBS9Ne/gsMWkE4e3wTIuKMdjVANqBUXimugPqhhzGZkwIcRa+UUMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GM49wCWvCV4j15uYI9hyO2WmQ0umCmFn4/QKx8qh4dw=;
 b=eN1MGn8Z0vlZMjysgW8Hxcb5LkpJdOZEso5xoL7TkkJlsaYRut+7qU/JuN1bS3ZZnM39oy9PNDChE1H9J1fOjNjUSEGIZ0JXFA20meDKPXLmtU69W5ne3j98MjVrsM7Yj34jq84aUhkXwvN8eMzfdZjg9dDBC1/6WAGK/qcN1XlNqVOalO8+hNE4l8azPsLPjI0WtTzgg3FGk7l2F2eZ9qh1PaqPqN4gdZ6sokYo8/yewF/F815lUjlpJwWWX0Ml7JxQLU30byUuJuy4OrZlw0I69RMs+PXMicT3RjwU44gtJe+fygjD7dHDMFrs/ww24Md8tiSMBv3SklCKPCa0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GM49wCWvCV4j15uYI9hyO2WmQ0umCmFn4/QKx8qh4dw=;
 b=KA5Foe2pa9YO7SXJAcT/E/I1N8wLFVfIlg2vBXd7fA5/7ecjaNPgPSJEiVfw3XQGuJe5TbF3829ga49WIIM4R6YrdZS315NX+OQI8jLiC4w7F9NUVcgmQu9Zxmh3tiL6jjFjcUBei2q20xkUOy0+ylGnOoERniBfK+CQswheDKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8007.prod.exchangelabs.com (2603:10b6:a03:4c4::21) by
 DM8PR01MB7014.prod.exchangelabs.com (2603:10b6:8:17::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 23:35:45 +0000
Received: from SJ2PR01MB8007.prod.exchangelabs.com
 ([fe80::9dd8:9d28:4e63:28e2]) by SJ2PR01MB8007.prod.exchangelabs.com
 ([fe80::9dd8:9d28:4e63:28e2%7]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:35:45 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Date:   Thu, 21 Sep 2023 02:02:36 -0700
Message-ID: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:610:b0::13) To SJ2PR01MB8007.prod.exchangelabs.com
 (2603:10b6:a03:4c4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8007:EE_|DM8PR01MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b6c618-1217-4a1b-0419-08dbbe2023e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnHHqKhd4qKwB063KH9CcMe6A8eTWof95XTe6INLJlWsGaUcmw6zB75HWslctYtRo/ZXdurB34nHJE8dZtJ2DYQGgeyMb+4YIXNRL6KuoGw3kBj5LPVbkqlGGqdbp6e/dnUONPJ44rsTOAWNASeI3r6jwhbpftjw2emn/LDJ9vb0nYUVN96T6eG9N5/wBmO260iawPo6oqAQClJ80PPXBWrrwubcxocKENjYhi7kYpqmPCwjnUf67EGeha8S94KZQKkczishqSo6FNGKi0D5iENaEc/pF1HjRCB315+6ZYmWgAt2trFLIFXNmVMGtfq+5o5Wb7Phc9C5/pDd+ZPTXSZN64G9UFl6H19MYN3HI85Kalxn5RcORoG5oS+ctaNrfcBLk/RLSd7Hsqd9ErZwaZ/ON6jKCX5LZ8ZnsTAb9iN3uLFx32J9xg0amuMC7Irpyw4sgp3PDjz00VNRrbQzgy2Ly957JIuJOPPjfp+rMaCmpwSH6lZhgvBFvQATG9Yl3h+qJIuS2uYCEvhb8Px8MulGJB2jtY2X0qeDEnhZ4+QQkKzXbPCoCTwL8sx4+uxzZKWTLTElOaNVmNZLsBgBFNSYM1n+YAT5VNLJ+FshEo+yjpiRMhjk34Gx6UEFpY5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8007.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39850400004)(230922051799003)(1800799009)(186009)(451199024)(2906002)(5660300002)(66476007)(66946007)(66556008)(54906003)(478600001)(6666004)(6512007)(52116002)(2616005)(26005)(6506007)(6486002)(4326008)(8936002)(316002)(6916009)(8676002)(41300700001)(83380400001)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tri3YWaDEycBcduzOytd4W9osmRDp+1nrJOf3eojLES581qsSewjbhmpG73?=
 =?us-ascii?Q?0xgmOxOznqrBEfLe75etxs6N5ziCWVDzMgR0pRItQarTsbZhQnYSQhfEvEpi?=
 =?us-ascii?Q?DhJaQOL2xTyd9NJBPCXAiqm4NGl+PWmV3Xvn3xULtAHUqYT4Te6pDK7kwCo0?=
 =?us-ascii?Q?lso8w3/VzZ0mlRwUaol0HltabbjeQxQ0TZ7vmZGwCWxcMx1ZV6sqV5qVBzWr?=
 =?us-ascii?Q?Ak1AXgPxqhm1rIH/LUjTIJo53JnBGQLoUDzfcp8aMgO1Ha2OzzMEgINnIkMf?=
 =?us-ascii?Q?ROXn6QZvQcpC+UqmBwllofKMGJGM6frUHKZQ+wGYpr+zs9zmS6JuV4Udyw2Q?=
 =?us-ascii?Q?9WdAkoSJ5rZf7kUUiG81NTPOHNEPaPdtE187M5bQMf5Hk8mG4EIqeqRakiIW?=
 =?us-ascii?Q?vb51CrPuCWkfP3gBluq7VIfyq3fV0yyneB7MnHaum4w3GXWgucOx6iTVurYi?=
 =?us-ascii?Q?Ksa65D33dYQTed73lfa8muwAxu+VLHyePGP085wNJ6tBuwXtxtuCfiqrsDUY?=
 =?us-ascii?Q?4AA3IpiCe5dK4I6sBs9cinjJ5mCZGclJL0n0lnTOpB9rOs7drcCaZZgj2J6g?=
 =?us-ascii?Q?3BTxkbes7XFwGNupts4a3gXS/Ocp4BCkMAaSgZopLpg+Vjl1v1yXpxp5aNqM?=
 =?us-ascii?Q?3IY75mDdm2mcbG7rdAqmx3MBx8vNPcUe9h3OSz76tV8FHAurxkh6tseeL5xr?=
 =?us-ascii?Q?Zgsw0rf+EEXSgrDLBY4n2TQrYUmJI3N4kjKKMbR1+N71icIlMQszmhVxMBGZ?=
 =?us-ascii?Q?6MauUgJsnzAs3k2UB/71AFPhe5m/x3th7RI5CHf2NVs+hAjeL5NWYtBNJJBI?=
 =?us-ascii?Q?YdRuH5V4yPO+5iGedSGjftK1sWxJ8F2mNkvlE/lixdpF/OSeECoZgdprqCVj?=
 =?us-ascii?Q?3KIBYtySL0a2z7Wg1gJiL9+NsG1BCbK8LpDEU2pKjM80q5fUSKDFTzInRCRy?=
 =?us-ascii?Q?sab/QpEmvSohWOSP9/1qxHRM/drlIZdeYAxbvN2f6Y8DKUutCrRla0ps2HO/?=
 =?us-ascii?Q?pgh9iIgwhgtQlDDb2gCdLdVq4+TKhj8JMGSIjTtEe1wq2uF6fESONDV6c6NU?=
 =?us-ascii?Q?xji9xEffDFK99MurPxEh3UrippJVyYNlHRPE/C2PRJ+B9ygpd0jk0ohTyZGc?=
 =?us-ascii?Q?aGb2me00KAp4iCueU5fU49glpmGzupuqEFKVpgppwzIZ2DUe10nfUFLeZsIs?=
 =?us-ascii?Q?X/p7v5YjRI5bZhxgTmlQHOtuS6lO7BomrAB93O114d6PZsmBE7yXPFSfcR1E?=
 =?us-ascii?Q?n66F3aCd2xwTsyFPnWqFBdZ1wVWe7aI9lVaiezr5ndtwTO+IR4FiYmX+Mw32?=
 =?us-ascii?Q?Y3aU9r7qxyGbBPPPeoG+eHOlHJ4wNRKOcgm3DsLJ1uqOC/YgQROjYIGsc+dG?=
 =?us-ascii?Q?04vbrAtIexUVKgDPtKSbjwywcxY946MydlJjkM++pLA/LJW9vfStcW3qbqmP?=
 =?us-ascii?Q?tqEEc1IaWds3iE0LHYiSeo3z+HC4fpxsGjCKUWXoji/H6HKEMM7kMbqz2p/T?=
 =?us-ascii?Q?uQZDSHJcVuzb1Ib5EGqsFRURtuKwhaiH409EpoLYaRs3FHifuU+rRwPRtmWq?=
 =?us-ascii?Q?GFom6RMRWdqWbhpvwyBFSX/XS/PS58AjVZlPiyIocIpjBRO3uClQCSezVeQt?=
 =?us-ascii?Q?iN2kebUEmBnR4e4F5ECligc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b6c618-1217-4a1b-0419-08dbbe2023e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8007.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:35:45.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2yf062BZgnkBmk40EztI7EuGVMM8Sm1lsJSuvJcRTbu0BLqVbNnfWU3kHVCwTc/8043MLQoLz4m5bUkmK1BW04wpvwx6jZrf4IXevwi2GlBUzpBNUH7JJa3xbWGVM7j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7014
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
introduced new timer math for watchdog revision 1 with the 48 bit offset
register.

The gwdt->clk and timeout are u32, but the argument being calculated is
u64. Without a cast, the compiler performs u32 operations, truncating
intermediate steps, resulting in incorrect values.

A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
timeout of 600s writes 3647256576 to the one shot watchdog instead of
300000000000, resulting in the watchdog firing in 3.6s instead of 600s.

Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
the order of operations explicit with parenthesis.

Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: <stable@vger.kernel.org> # 5.14.x
---
 drivers/watchdog/sbsa_gwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index fd3cfdda4949..76527324b63c 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -153,14 +153,14 @@ static int sbsa_gwdt_set_timeout(struct watchdog_device *wdd,
 	timeout = clamp_t(unsigned int, timeout, 1, wdd->max_hw_heartbeat_ms / 1000);
 
 	if (action)
-		sbsa_gwdt_reg_write(gwdt->clk * timeout, gwdt);
+		sbsa_gwdt_reg_write((u64)gwdt->clk * timeout, gwdt);
 	else
 		/*
 		 * In the single stage mode, The first signal (WS0) is ignored,
 		 * the timeout is (WOR * 2), so the WOR should be configured
 		 * to half value of timeout.
 		 */
-		sbsa_gwdt_reg_write(gwdt->clk / 2 * timeout, gwdt);
+		sbsa_gwdt_reg_write(((u64)gwdt->clk / 2) * timeout, gwdt);
 
 	return 0;
 }
-- 
2.41.0

