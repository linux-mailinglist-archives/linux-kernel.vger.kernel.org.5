Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52041752E67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjGNBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjGNBCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:02:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1902D73;
        Thu, 13 Jul 2023 18:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgN0HferY5jf21gGY+3Cq4XL0myk3K4p82RORmPmwHRMz9nosUSTbRigq5xMFsuvs50fKmRY3WjLJO3vNYvJLH4LLpMezX99dQVa0mqB2rbOlb1luRl/Ai6M2tTduW2D0jiCIfP9MXomaRw0UTjdxywF5YvF+VhLVdipH94Ha9eT0zVLGZZQLSSO5JaGDv2ujMNGQaS4ZmqFo75uMwBQJtVB4ZMUdWsRkLLXhTVFj0mgiHvQDfNz5iCmzTiJSf8F6COTC7/KDyXwQPm+0pTNEZdxwmN7oYMw0OiKln5jUEWtwlcj+eOQX2C865II/lRGaTaHFYbH0gSv9CXfpA7/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyYUQQp9yBc4hP0w+WM6rga4/CQa0V5X5PZ+PPakvrs=;
 b=OgDDkzNGpUTtLBijQWfFIB7xQX9oX1Tj58YUMKHeDHTB+A+QI9MTiD+wDv1LlWvpB7llpms66iPInjVtEksJd2FLUuj6tqNi2CsrPeksNsY2Es357TJEukpMmPpPOFEJIjpXBQi+KOpzT7FHrWg7Z6q4NDiFebG3NY2gDxpY2G8kMcpS4cHluhPLOCtwRA1W9njm+MpCA8EeW/qoRhalmwiJ/tc5XOtskXeKrzn79o6qacPi6d0p73I1tDVkma7KTd6PPG969pqsK5N2FOEfkEiPGV8kuk0sG63vCIj6GeJSbIXkqVi3gpdSYyimfKqeraoy6HI16VyKVbwFyKYOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyYUQQp9yBc4hP0w+WM6rga4/CQa0V5X5PZ+PPakvrs=;
 b=g/d+4zTXQh4OoDbHKvnOS6uGKb2OF5TnOHGU4D+bjVkryi1uplC/q+DFOgqMv4c7R84isfs67MiSq6BMAa4sq/NINGvJts/z3F3elZSdIm1N4tVSrpu/ylu7CLupAZD81lyGvMChiZkY8rUg9ANHNcmOVVM0cWzI9uuUSAbof4M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:02:25 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963%7]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 01:02:25 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Date:   Thu, 13 Jul 2023 18:01:38 -0700
Message-Id: <20230714010141.824226-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e29187d-a754-43b8-178c-08db8405fc93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kd5LZAYiQ6Lgo7MVla34/8WlwTAEnrsf/WbGyOaXmwUkhnq2iXVb4lMn5v2GTgOE+5799l5sCoWZNXl9DIDgzxGD4adq3nt7po66+2U+h1am6rO9l0uYFysVBywf1lUWCH8LHUoWEUdny8XWdJSdGXWRd0i7r1H5fsA4txHn/b7XGpwEkG66Rw/U4pcAAt2yNAFGSoaU+59kuUwh+t8pYzWb/vhaVtTq/UUYg5hPQ/kgcOO87lwSiNV3yJXnTJVvf6IcmCRV8tbEMifkg/jW7dggak4FQpnre60MfVZcKZOQkGBvRuEAF+HBmuFgNgpirWJXJo8tDRTwfQLaD8t9yVhOPu5iGY7SrXk2/q/jUQSOgyO3dxziJQnv1z/xbaro+7QIW5Wvi3/yzokrRYG4e8SRxziyR4Cz12z7uVwfbmkBVr1BQTdyPfxx8zxNA/jnQJb5Vxbz4pkirlzJy8CMXftoiH92YC6z+C6rh1karT+aPZCrEvYJUvOnxEJjpYhlNcaCwuyEeUN0bkCvbEktltCIHpBzofA2iUt4Zgb7rNY/cGDW9ydJaYrMaUJPNR6c+xW8VV0oaJTFGnxTdaXXDoOFqUvurDhk7bqhglthNsKmHcHFl05jZnNxv1DRM3sY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(2906002)(38100700002)(38350700002)(6512007)(83380400001)(186003)(2616005)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(8936002)(4744005)(7416002)(110136005)(478600001)(6486002)(52116002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BGzk/j4u/X1AVOBZPe682S2I8XmnbqEWAGbkcIEkENyMU9qx81XvM2i1q8NQ?=
 =?us-ascii?Q?b5MIuVl3iXG0stII0B+U+KRfrkvb8ZVo6i17NWesZdbJN8YGGYPxhZT+jnJi?=
 =?us-ascii?Q?0jOZYP8+2pb6Z6hY4477jVIQ43M7oEk2Uy7e369BHb1A4mRtT3yfFuJKUOky?=
 =?us-ascii?Q?gikAKg3DkmQtfZB8oyLWZpPFQg5mp912cFe4xbNp/Y6JiiWGegoU8vR6wTTL?=
 =?us-ascii?Q?5G1FABWPnQDWKJiSkHqt+71Xd5XW18+gZzS8M4LBiQ+99/ou9jOvVDA+lEb+?=
 =?us-ascii?Q?68U0Xgvr56uGnbMt5gYzFhpo+69tWaS6A8+nyZVVGgvqoY2QxQx4W6/8/8S8?=
 =?us-ascii?Q?vlvWYBXYUu5kYVApaj1MBf9a/hh65Q2qLBRUtjrKNbIw9Q0WC967q9EvkP7P?=
 =?us-ascii?Q?ywifZkTrZywgkxcBroRdrUja+NYNtUvMEfACO5kiaxC+pVmOwJAAcJzpLQn9?=
 =?us-ascii?Q?x1SKk6MHvXToWEtyhM+J/QpYhVwxyCb4S3S6jpkofoG1gHtgfjSiNaiU5Uz6?=
 =?us-ascii?Q?MhD3gJsKLqL5mVbPtlSgFulu24uLElgyBbRG9x7dk4f9Nq8bWc4yX598qdJp?=
 =?us-ascii?Q?skfa4Il3KUxW4WTRN/R3ZQ8prWfUtbExGDAZ2oOF4kWXFY3nlLyKG+bgryOI?=
 =?us-ascii?Q?0zNht2+mJDz0bvV90qZsg+Mc9mJMLqaSWSJ0n5OUmg/Jgaqz470z3TRirU3q?=
 =?us-ascii?Q?0bcrPmTO3/Uuzlg2z/e5I5vU+bL60b/3X9Uir/ZTUZtOhPIPCqgLiVTqpheb?=
 =?us-ascii?Q?KRlo4pC2vl0YnjHHgN+81C3mRuPSX3/cAhctnK8zSKkxItq2IkpJv2c18dqC?=
 =?us-ascii?Q?kLqkwiMGaFtGd3s3nkVeCe1s1mM2b6GyGX1pUtfGuzH8ujq/ifeZfR0OL+V4?=
 =?us-ascii?Q?PxB6tMN4EM6o2wJ+ZitM56ZPOdlJOzTB3C0zbTBVUREo/r0ohiSXqZIDwu9+?=
 =?us-ascii?Q?cPOK/ZsfA15pbkmp8VW9BIyvEn4s/KdRq7Dsk9vTKifkzXM+pXIbkUXJBRia?=
 =?us-ascii?Q?aBvjZIrWl0eUNsPzFhYuxh5unTTM40lLs7l9p2z++SndsuWkrwEE3agyeKIB?=
 =?us-ascii?Q?mbdUgG1FE5ALLBe9SbF+Ps1/VMVMaSdAM86wMPKTFJbVInAKppCqWvc5f8PT?=
 =?us-ascii?Q?Zg7R3wCjIuA88tAC8Bf8dnqUq4YwRjqnA2LbAtaYUUH3HrBkBUJ/CepHKaV2?=
 =?us-ascii?Q?0c9Hni66bhq5EeNspgE2dbfXrPtZ4cuEcZN1wsHEBHGgJevo/fL1MWpsM9L3?=
 =?us-ascii?Q?kgjX5y4xXHO0wsXRcgX9NBE23SAO0DWbXBVNsVxgsiH8DZ1BIp8GucSxDB8d?=
 =?us-ascii?Q?+6QN5KC6XU5h2McNfFN0DL5ff+KhdaXvRtdY55qeMg8imFLLBEINadnB+uX6?=
 =?us-ascii?Q?mHCZB9i1RmvJFScgjYuVYX0z+fD0QFI+BDL4l8KvvxGtmtwSNU/kw80hcGW2?=
 =?us-ascii?Q?k6sXA9qn2dEcCMFQmZUWSY7IDZ8oMYkhnjRgbEILbKWr9fUtZOJaK1S4Mk29?=
 =?us-ascii?Q?EBnIqtlZI0F7vLOn5CCQjsrol+ZsY+AbukLpP2lJvlY0XK9VgcUvpqJ5C9FK?=
 =?us-ascii?Q?UixQrurHwtEKoEcJTd6VdluwGZjNBa9ORrOQtQjPdrjVTIij/jvFYkSZENAP?=
 =?us-ascii?Q?a9q6TC2mTzM0wHleLNxhG04=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e29187d-a754-43b8-178c-08db8405fc93
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:02:25.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+wi/Wgs2LAVthooEQ1PuD0IBFpKqx6zJsutQXPFymyxLjccluSphvHHrvnTIfeF7CB6DVia/1xeFCh8YGzFxMX+XvEFeyYs2lfLhAgEzv01ILAaJRY4NC2VKY5H3aoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 64-bit register accesses if 64-bit access is not supported
by the PMU.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e2b7827c4563..0f517152cb4e 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -696,7 +696,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
 	if (use_64b_counter_reg(cspmu)) {
 		offset = counter_offset(sizeof(u64), event->hw.idx);
 
-		writeq(val, cspmu->base1 + offset);
+		if (cspmu->has_atomic_dword)
+			writeq(val, cspmu->base1 + offset);
+		else
+			lo_hi_writeq(val, cspmu->base1 + offset);
 	} else {
 		offset = counter_offset(sizeof(u32), event->hw.idx);
 
-- 
2.40.1

