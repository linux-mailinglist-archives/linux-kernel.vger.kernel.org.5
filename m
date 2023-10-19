Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A457D04C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjJSW2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbjJSW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:28:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085B812D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcbD2ozq4i8G+fGAfMs1vLIY252PQOclsdB30QEhhIunLIvbOKJKdCNQ+K5E7UkOTVeg/wN0fOQPUQH7sAdPG7AR+bhqBfixhQCyEFv/X6cak1yNFFP+H6kxVpSgYnTETNDx69rdTx1hZOaLSk366W3C+G1OOwyXx/bUUosdCGecXHEKJcVsq1AvgSLFIxeoXiVLVfNukk1tVJGy0wC9MvXRkubD2HJyxhKBuSFQDW86SiuUeIDRsjAqzPziFOSVW0ovvhOAprfUD04m7wMu26SELosMetv/LOk9+qCwnpXT/uuUeXam6yNvmuYh23b+3vUg/3cwz3g/jUikdvV9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uT9W7TotJARq6zP26cWXT9hzaMtE+nmkARINED70m3A=;
 b=b/63V16GXMNFxiv9Uqm0LNnA4U2X9GQ95PI1FP3qpddxqv4kkvGj27MOSPgB1g0elbSAhHMEEGgwSU6T0GKN7y9uSnmasySRz+YbOG7pIbXpUMvpnym51YtYoVO/pnPApPIbuQ+CSw1uWQsushOKloZiMSpYWDOQkNG2pGuKdnAtM04k+FYQ7DfZhdbc5od5jPO81BcWn2Mbz0kstO0LdQjQTQ/1NzoBcSh7aUOTreqVWmoGtCp9wRVzxOUnANBMTZ35Q/bZLX6OKq8B7UwBemTQXsBZ7mQwdm2WUZyKl5P4rDeoTS2qWcKF0PWxXbWYDe7RNnuU1pcU5EeY0FI6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT9W7TotJARq6zP26cWXT9hzaMtE+nmkARINED70m3A=;
 b=Bxe7DJXquFtCHIFa5O6xGiLL9FQVC9EUqOEYYh7Q1/U3UYDTbFmLrFnv3faAmDIQj/VvDWG3rQYBdN3Ne73sRi3gVY3C8qnaDhVFfEhytc8PX6wglp8EQA92K65rF+7IiKvrQj4D68rJYMzcheb0ibZ56HMTWlzui+NG5n0lUZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] i3c: master: svc: fix random hot join failure since timeout error
Date:   Thu, 19 Oct 2023 18:27:25 -0400
Message-Id: <20231019222725.3598022-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019222725.3598022-1-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c9f151-8689-4abb-da63-08dbd0f2a3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j54wbIYDBBUwajZxBlc7TZPNR/NkabsA6+yGcUvJh8WgWIapp9hEuRsj8WyQveStHEO64jNHFjlq0LqEX1tvbHi5mYFzPeZ4YgC0pQ4EE5EV3a7t8lD/tj/8/dRCi4GqeZy6yYhy3jVTHofiYXfCKP3NsuFTnM9gyPwnrHtuy6nqPZeAX3UtQiKQWLIDinFKaQkmRetvq/SlDnSn975Rm2GkDtjCyF/FNN/46/OsM0/MJPkpEocsClkpkiQWMzQ29E0b4J+L1JaooZTetHYE+xhHhvxk2H1aJerGj/3EsTpq4yiMUMEp4y35oLCDj/Ay7WLlzZQuAkUxWpBMwSNWmnUtQqtv/iDrVYxcyDBXJzXVi6q/NzPXMuv9zXCvHo4M3lZlrp8rqyym7lXnnvApyRmZWe9plPNdOvWhdBHXTAq8WkU2yi35uuqnlR0Obherz0pffWub4caFNtqkGQ6wOVPT/0M9ZOLwol3/+z3hMQBjdBHFl7cJ+5Qdmyll1Ef9QaecwJZXfqFE2WpapirFECk3ZMkqrfNZ77DoephhoKvb+POuSru5+402BJFMUK8rIcIPGeN5myXxxUFE124o3Y+m31gusgVoXgb/MFH1tlBfW4NMWJC9XqJ+avdaYiPnatCf5cQOlP+Fr5F9OrIJ1uQsVvo87iHF9kJSSM6UU7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZwd3hmNHMreWhqNGYwMm94dlJWUmtzdklHVlk0YnkzWGcraFFYTzdLY1Zy?=
 =?utf-8?B?aGltKy9MQ3NiTTlkVUwybENrZXM0L3NIa3RzUWVsT0l1VjgzNEtXMnV5czU3?=
 =?utf-8?B?QmZ0REVkMGtHR0IxL3dpV2xNc0FqZGxjdWZuYWI2UVB0cHI4Z3VSZU9pYmlN?=
 =?utf-8?B?RFlqWGNDOXRETmNWZHNMdUxNckhXSVNXMFlTY21qOVBlZldUNEl3S3VwL3JL?=
 =?utf-8?B?bTliOW8zUmVHZkRNQ3d0aUYzK1g4U3dJdnJDY2VYbStWaVBYcFVJdkF0SWVS?=
 =?utf-8?B?dDdxTUNxMXJ4aGlORy9OMFY1aWxXSE16OEhjQ25oWU9Nbk4zd1JXUUFaNWFv?=
 =?utf-8?B?Uml5Rno2UXdHTk0vYnNTeW9WRjlLd1lQN3AzaWUzUjJMQnM4WjV3RXhBVUJC?=
 =?utf-8?B?enV4KzdLM3B5TGlNc0dqMWVhWWQxYUpObzlyVm9DaEpZamUzMXVrV0I1RXRT?=
 =?utf-8?B?b2dndm1TejA1N21EeVNjSTZyK3oyUkl6N0pncDJwSkNMRVEzQ0p3MkpwVk5v?=
 =?utf-8?B?RkwwQlY1MzY4MGZWUytwUHFpSDdVS3ZFeDUvL3I3UzgwRnJoUmtZK0dXUzc0?=
 =?utf-8?B?bXBja0NIZUI4WEEyandUcUI4M3FrSU5yWFViYlJnbVNoNDk2V1lrMlM1cHpE?=
 =?utf-8?B?bjROV3YxVC9lNmd2VExWTytPY2VIU2ZEanFHMmlEamFuVVRPMzRGQ05sYWhp?=
 =?utf-8?B?aXMyOWpwSGo2TkYrOXI1UWJCcnZNdmlySGoxVFJJODFyd0E2UE8wemRvWVc1?=
 =?utf-8?B?WUFTQUNiem5tQ3dqR05GRng0ZDBVMGJrOS9NTkwwTlJnVHcyTk91UHNrZkFz?=
 =?utf-8?B?Y2lNZUhGVFc1ZGt6TXR0elRVdmt3OUtjMFVIWVVLSnluS0NKaWVrVVVGSWVw?=
 =?utf-8?B?S082VlM4eUpWR1V3a3FLQlhNRTZOVFRVdzN5MVkycXdScVptTWxncTJDb3Vp?=
 =?utf-8?B?NGpqNjUwWGp2MjlreEg5bHh6dGZtRU0yN3pVMExrYklEV1h6YTFLMWFUclBq?=
 =?utf-8?B?bFhlQ0FGK014OXhwS0twVVdZKzFJSnVDNjRLN0lrb3NZODlzYWJFOVRyRDVo?=
 =?utf-8?B?RDdOVWI2TnZabURvSWJjem92SUJoNUN6QllNNUV4U1JSWjd4bDlJN3FuSTEr?=
 =?utf-8?B?N0MvOVBRV0hBb1IzL1BJZkZiTHhqQ0NNdSs5dUpXbTgycEJEWjZCWElaNDF0?=
 =?utf-8?B?clEzdFdNUlFQNDhCRnBvSE1KOElqQmppTVc5LzlaTUExQWZvV3FyRU1sOVhD?=
 =?utf-8?B?TFIwV0xidGF6VjVidE9iL1hBVzhlWUJRcldsMFNUa0hhSlZLYUdZV0VqTHVK?=
 =?utf-8?B?RllOTHdGWTJJNXo2Q3R3eGg0NnNPTDJtSnRRTkRmOEJEV3J3SVJ5dGZTVkRa?=
 =?utf-8?B?NkJiUll6ZERmTnpmUURzYWxrOWsvYnRrZWN5L3M5ZkpaOXFrVjNlcU1BUWRm?=
 =?utf-8?B?bHdZQlNRbFAxUGczTlh2QndWQ3pHQlRyUHRrVDY2R3JnVnNPakhtb0JEWnc1?=
 =?utf-8?B?V0lYdHo3cm1iRjN1VGpNVEdvVklGV0hrRDNWUmJXdHBhRm50dUpKM05DRVht?=
 =?utf-8?B?TU04QWdSNDZnczFGVHZRUm54amxCb1ptUXV3M21VYS9TVXRDOExzNEtLUVZT?=
 =?utf-8?B?cnpDNE1JS25VNVd0U0o3ZHlINThNNlNJUkZ0aUJYM3FzV2kxY05hRWtndkdr?=
 =?utf-8?B?a2tNU1RJQUZpbFV2cGhPQTJlT2t6eFpzRHNLbGdhK2JvL1k0a2xlN3FKbEpF?=
 =?utf-8?B?MTVkemErU25nTmNEY3JNQ1JhRElsUnpZeFJ0eWxQQUgwT0RpcStTeFl4dUxz?=
 =?utf-8?B?WlZTZFZZYjZJY1Q5U0xGTzVZZm4zOGg4NVM3UkdBT25iRmlUWWFVQlJzanlG?=
 =?utf-8?B?OE44VE04cU9oakVxcnhtVVkxbmZJWlNlbnp2WVpTZitPOWoyYU1tUVJDZmtH?=
 =?utf-8?B?VisycW9JdFdPRVVTTERob3hBV2UwQVRSNmhObXNGekoxN3luc3FMU1lTR2kx?=
 =?utf-8?B?WjZzODlWbTZRTlBockkrUmMzamQxS3JUbXJtQjZuNlVzblBFSXhQbm5qOGow?=
 =?utf-8?B?R2I5TUJFUFRZT2JzN0k4VTRSZ1pSWE0zZlU4L09VbjV0TDI1THJRRjgrVFQ5?=
 =?utf-8?Q?P/cg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c9f151-8689-4abb-da63-08dbd0f2a3e3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:55.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLGqUoBvhIWqRM8s0+wE1zLPocOa4pJGZs/YivxpM6xXt4QlKjV9KvRhPbUS8y8Xp46ObiGKqdrg4gOw/zRbQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

master side report:
  silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000

BIT 20: TIMEOUT error
  The module has stalled too long in a frame. This happens when:
  - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
middle of a message,
  - No STOP was issued and between messages,
  - IBI manual is used and no decision was made.
  The maximum stall period is 100 μs.

This is a just warning. System irq thread schedule latency is possible
bigger than 100us. Just omit this waring.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v2 to v3
    - remove 10k at commit message
    
    Change from v1 to v2
    -none
    
    Change from v1 to v2
    -none

 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 1a57fdebaa26d..fedb31e0076c4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -93,6 +93,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
 #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
@@ -226,6 +227,11 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
 	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
 		merrwarn = readl(master->regs + SVC_I3C_MERRWARN);
 		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
+
+		/* ignore timeout error */
+		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
+			return false;
+
 		dev_err(master->dev,
 			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
 			mstatus, merrwarn);
-- 
2.34.1

