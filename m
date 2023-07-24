Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB675EC46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGXHMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGXHMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:12:06 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F47138;
        Mon, 24 Jul 2023 00:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVo8Eh8vMJCWX/2yeg1rgLCaV9awA6aZYThGdFuT3LmGV5qISmMkPsNvPILW1RFCTn9ENFOVMaG/ER+mC6LiX3b2NwH7fYCr0pTN56byF5lJYA5pzMM4UmYL4qFRQLnpAWUzH0LtG70v1pACJtZ7Cn78x+k+e7Tc+kTH6/LdyjbeyZl++pQxRpUvJlGMPzLQnXt/n807B860ConqxYy/TEUZB3CVKYUju0JQpmEcVUVqYbsWoEdZsiQlCRqZjEjkwY+7bbTC2y+FYOEzp4jpHAKH+U0TPP896djsJZ8IvCY7HstKw4fGoYnZtWTPE9uFR2snk+7VyU4z0QuPopU73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpgM/QxqMBSlhwHeR6LD7JO8gSW3NgNiREx3H273v+Y=;
 b=OMay18Cwe/m3q/FV4GZvf5E9m2mUWTrYHd/1gqEfIORJWr7dro/pSf2xQGH0Gw6weL9jFFKh9VLiWbTGQIhKxnnBcfefwq3B3vDDD5gXDLHrIDhYfKgTdGoq/WTC9hqrFubGc1qXvJAVhaW0DGDK2hZinfd9f53N4H9ajyWQrTAOrygpI/iJrAR+vvBypZWu1Uv/UFTbyg2j4+wxF6/bQIPeB8pHrA7rhPY6b3qp0ZFOmw0OXMDZVwL8FsAU+1dCpnOToC4CnBA/KT0sEPT58bVv8I1sMTZjpvfN1lAcXy93DPA7lC2jeWuZxlJDOO8cntoWcgdp6g+LeJruRmBVUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpgM/QxqMBSlhwHeR6LD7JO8gSW3NgNiREx3H273v+Y=;
 b=dFrduIGJYtHQfIV73btWvTOq8wtnH8GYSVb9Zt7N7PmfW9+2/BmxJ05g6u3rlR53GucWhT6KyV/I5HI6YWLxlOub2ngOsVsKKJ+CRextccJlxHA3VL7BzT42+ERcgqglmacanQWFBfh5zhyBqnAX0pUIU3/57E9dWzNWiqGmHCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 07:12:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:12:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/2] thermal/core: fix potential memory leak
Date:   Mon, 24 Jul 2023 15:16:45 +0800
Message-Id: <20230724071646.2744900-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
References: <20230724071646.2744900-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f1a46e-3a7f-4f48-a9d9-08db8c154759
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyJIb9HlGPG2bVSrjWlmfVcwr7HcyrOmECyfHBRZX/tK3cnLLH/FO5o3269Agvq+zT8gERuOgMFGc022ampEou0EAWO9kj/5QqoVQ6jrcm9PPjd1wB/fcN52I1I25wyNfJ7XVrhYoQdri3mq0DcbGxPTmTljPfneafreezkH8MU1lcvEKS3xKuNsXCtkR3z9yIuZOcAgraXbUaNBPwd/UmlK9jDc3MxyJc/QfasmD0EH+jMBsuNB/VF+7Z0WIXnaxyBQlvEpYRixs651yA0po2xQ1fQZAbyUK3ruQndz1ysAPmFoLSegXX51vmueNKD3t7ROXnpofBd0mUaYgNPCaKNyRY7HqZBMC4/nfXniRCfaJMaIM9S/JKytajZht5N4lCGdA60P9ZPPSMvaiSiIKsuYvaDhlhkHxWtzRVnqf9gx0FPmPDgeYFxMVL37lU+Vg/YIEqBY06csKK/QHaIbD9jGgrEtC5OcF7O2r9ej/SAPm/8Zn/B4UmQKJdV55FRFUmLFp8bpz0Gmb6DzU2FaVBdGgB2l5PT+SAgfgK2O0QNMD3vtEZoDLI2lh2/TAKJLCKBbGX/okaf0pX0f5AEju+cvD3vJa0+19do3RfmupYCi6vBQXgEl6/aHr0+3KrNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(6666004)(6486002)(52116002)(38100700002)(38350700002)(26005)(4326008)(66476007)(66556008)(66946007)(6512007)(478600001)(316002)(86362001)(2906002)(83380400001)(2616005)(4744005)(8676002)(8936002)(41300700001)(6506007)(1076003)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ex6S+lKxyoOjzC97gMDgTq60RtgOyxHFRh87Wr9aIA6ua8V46pxdnuERlOep?=
 =?us-ascii?Q?NFCZDuNj5fFuKnYzV0rbW1rIuBWY06CF3qivZqi7+15RoCnUHN9j6iyb6kOZ?=
 =?us-ascii?Q?trIcNAE1ISTftNrUXSP0++Mc7TF/LrxRTNJarhjdrpcHWezJQl9vAnlLdUPQ?=
 =?us-ascii?Q?B3N482KbW8T0hQ+7QGRU/qlXDZVFl0IzrtXolXThjIvz275dF6a3H86V6U8h?=
 =?us-ascii?Q?Lcj8xFcCYQgW2aqgD8N3q1oCcrsBlw3C8n5e7mcAOpq2YfMT8Dd2J17NfVtv?=
 =?us-ascii?Q?Lp9Rqr9uUnbcfrpR5Q6JAqnpELPbcn/hRX8asl/BG0xEzEjy3sbiWQPWjpME?=
 =?us-ascii?Q?CbMlmXGIykOdBj3PO0CKiikDgduKHbWV5vzTN0NnYFR/hcoTa6llqJ/Ebzoa?=
 =?us-ascii?Q?VGB0TOJ052+uRMVOee0QyR0RbxID4uHml/0YYOSwzMxTwjY5CnEVYGckQBM1?=
 =?us-ascii?Q?1V0twN5KncJlnJj02GL3PMh4yb99rzVfUsWfTZHHGfMu0RrzvcC/QHKL6cf+?=
 =?us-ascii?Q?Vsel0NS54ZP5mASeJ/GoN5/5znykamI291Tr1CohO1EVe2HbjIgXoUocnQ57?=
 =?us-ascii?Q?z3zl7jrLUNtSmcK3eQS7IcZNNPGKZ4JTLjQ+LAvmhu9vhYM/qdoSSZfsqtEm?=
 =?us-ascii?Q?nRcbiM+J2WXxvX7S5T2AKqGsL9IOT2uzPT1CqC6jFi4Fc+1LeO4z413Akm3B?=
 =?us-ascii?Q?0kxKTJZJIEQOagXnDWmRlIJV+NA3ZtE3K6fdHtaDDBHqRTUctUm2cPAmtl8+?=
 =?us-ascii?Q?FIZ2iUmq04M8Z3A51Vgwa6ZELuDgKE3vuyox9jzZO1E80vvk2PxNJ43xhxki?=
 =?us-ascii?Q?FEm+CxtgiI4vtSF7CqSnrK/2SW5ZavjaqWDzAO6wiFVrb4dQB5fLD3by0icw?=
 =?us-ascii?Q?M60l8JZzB+b8SixUxxto1BdAC4dUIID65H14vigHtSWT8BzVxYwgUWzrQD3h?=
 =?us-ascii?Q?nUUE04PuZU6fqCuDXVITlORZsT6oYVDt1XmGRI64FzF1Oi1rJFHmO8jilAc6?=
 =?us-ascii?Q?KS1+UevhyNBOTg5N/h+i4YPftfwIbHFcKeIw4dQid1i3BJ2H/C9VzAMcHqQH?=
 =?us-ascii?Q?mFV1tW6jqHPfGbjpgYwYAvb0w/h+82gTsz/Yh0kBbL6vghxjdpGy1bz8qyBs?=
 =?us-ascii?Q?i3U4NWe0tCk/2FLvj1kgo+lpCiVSYkp9/tYaL1qtBfsTuF+ofhHXur1nPt2g?=
 =?us-ascii?Q?5EZ+F5paG0MFttlnqprf8RZ2j4l7MqJ48yQ4tpXTkvRiukApKEXyJ7RWHBok?=
 =?us-ascii?Q?agaQ9qyI+zq5wG59XzFxLFr/yfq6ov6trPbxr39DpY4odEz5EMc9NAWIt+8O?=
 =?us-ascii?Q?ZrCck9+sKOY0M0QnLX5GQK6ND1SQpgMkUYM3vfGkKD3jfmvqQF+mtaumIMDc?=
 =?us-ascii?Q?F6mtxvfA542RINlA6zxQF6d2EAJveCqNw1sKGrfoDJ8A6SaL/W/Pzek7thNE?=
 =?us-ascii?Q?Ho2qEWfPUs0wl8dSKSsGTomGZ02SpwUzWW8QVvilLsSSxg0stmqJPR9Vl6q+?=
 =?us-ascii?Q?KkVrHHlN7td+l3veo6pc2YEU/Wym20xFFZogYCUTrgl4PD1DJYvY6FAmYcJ6?=
 =?us-ascii?Q?rOU4qUR/BOBZd4eDBL4Vw8I8SJMSTOrJTclmjro6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f1a46e-3a7f-4f48-a9d9-08db8c154759
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:12:02.5550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y72k1n/EETqFFCIZAOwVZQV8t2t0zULj9eyYiHY6+W63iBvzam3mYJ5wnatDiH3DK3XfqH3s+oybOKOorwXCXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8567
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

thermal_set_governor will allocate memory for tz->governor_data by
calling power_allocator_bind, so need free it in failure handling path.

Addresses-Coverity: 25777220 ("Memory leak")
Fixes: e33df1d2f3a0 ("thermal: let governors have private data for each thermal zone")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index cc2b5e81c620..fe5eef149695 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1355,6 +1355,9 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	return tz;
 
 unregister:
+	if (tz->governor && tz->governor->unbind_from_tz)
+		tz->governor->unbind_from_tz(tz);
+
 	device_del(&tz->device);
 release_device:
 	put_device(&tz->device);
-- 
2.37.1

