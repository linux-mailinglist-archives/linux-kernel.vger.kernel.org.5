Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3084477C7EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbjHOGgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjHOGgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:36:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0411985;
        Mon, 14 Aug 2023 23:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0vzfAvAnsB+3hmAyY0STPXCJNDWOyv9bqMsR+DhL4a97qGryJgqulbI333lavNP2BYvWsZ1lpo5ddblOlWEkaRoFMjQTSoiFgCH7cgaTxY4qPZmxVKlQZCcHM73/eoGDh8B9A8syhdtySfn4vZa8aejAb+qH+pg2r+aLbXRGKT6fVR+IELcTgaEXNezqay5TQzZsGCjB9msgtlxlVklWEe27/Lh7SuZo6Ez6cEdS6fNF0Gek7wz3jRYVx96QE/bvZMx4axR2qCcAgT/Jd3M0bBJVj7xrfGbt5HuD6EqUWGwOO1aViR4b0pCW8ZYxzyVItMYhdIviEAmEgeeBN8eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eW9dlQjCg89VMBbjMfF2DkVyX/nPvTG2uODoCvqBSI=;
 b=gxr6WupCZGuCUh56LUBo3NNBqNkcfUsuRLd8T0oCKi7FyItoda3gAMLy0BpZoNByYx4MYaV94Wee6ecyDUsGHe3oLWVYQeXbpNDF5UnfX6EsRLN60rlI66JOnFDaYesV3NIOFXRSisiUj9DUqJVR+0cXmW3eAtbFv26H9g48umpgIMKljQ7taLnPHQD4/NJukTLnQXu3iacWjgBN9HAJo0805BfKZvO+VSq6A7Trk7fJhSCMOI3zfk1uYTuFFFvvT7/aV3AUdjHKaKZ+PQ5q/EPXXEqDQBdcR/DsXscU/yBlWYwfYz3CKJTYAdHBHxsJLFhiJFjlQ8sWyVpCRJ27MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eW9dlQjCg89VMBbjMfF2DkVyX/nPvTG2uODoCvqBSI=;
 b=Tq3XqUhFcREmN+94HC9nSyj+6j86OaOBbZ0F4+MVzklgAuW/x6l1ZD7uesVIAXxTOk+TH//GBOGHIWDrMBaNH8txY0d9Wyo2DwLOlZRj5T6GuTqFxxTzsmxfgB0/ci8Iqu7D05FcH45FU6G82asOmjam1rKiBOkeTMYsQJQ16Ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:36:05 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:36:05 +0000
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
Subject: [PATCH v6 1/4] perf: arm_cspmu: Split 64-bit write to 32-bit writes
Date:   Mon, 14 Aug 2023 23:35:23 -0700
Message-ID: <20230815063526.9022-2-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: d067b9c2-821e-4f55-e6ef-08db9d59e6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbkwjCJDLHdJZBTtfzkBmZltA351DpKUCW8zLZXWgsYaC1PpN3yR8B4gndfZSEV/AioFv4sNjNxehjxp5+ORMJUgj09x4ZxORmVJ8AW4ZauWx2J1XwqiWGenxAt/4D4hy0sgohXoMybr+hxtzE224QU48ACs76BX//uEvT+Re/3flnha3FfMKGTbR/+ET8IcxtL50TezI0BFkIcK7KQzMdJeYgcCOzB2tTlFxZ++iX3pD2rkxuv4pf5fhCVpLqDWv28ppcs5VQQ8LsA0faxASBio9MbwwdEulJuzm+bsGD1hFBDh+G10y6nj8E0weD6Ix6ACCKt5l64KyshEU3QOUtCian2AOJKqZ1UfTHH8pTqg4goONFZARFZWG1En7/SXc70jXy2oOMnUz7Ae2KS+V1cORENTUqWZbBR7o2MKyJh3MaHxJjA0YkbJeh68zOPPUBcmyrz7CPKf8eIMSSJGzxkInC17Xq8hcS9CgLFwlBKEeduP13kREf7NiHWbJyJIPqT7vjMxw/e8Oa3qoQg7EXBzD60Q5XpaHqgXQ1hGnLLXB9t18v3gB8leKVCrZtKVVpZEUD9cEhYYfHhiekjxa4QghLw7QooSurzySsb3M1vY6ahYglzDX3obGaH9k70O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(186006)(1800799006)(110136005)(86362001)(478600001)(52116002)(6486002)(6512007)(6666004)(41300700001)(5660300002)(4326008)(66556008)(38350700002)(316002)(38100700002)(66946007)(4744005)(66476007)(2906002)(8676002)(8936002)(7416002)(1076003)(26005)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BeCrSvHlu8PSmmr6q2wZnarwB4lTpMIL0rX2oecd3jHRLBAaj0qCYGxdeWL?=
 =?us-ascii?Q?0e5TcWhysm3k91nvVUXoaLI/8BWjz1zgT1fBc75oFEYU0VyLflmQRMr1/swg?=
 =?us-ascii?Q?mJeXJzXOKAlUULzkiM9ptjZtBd8b3R5DPwcaNebqvgmdLYYOMqJ34NFzBcZy?=
 =?us-ascii?Q?W0lYEiVu5x8qrE4D8BA2BsN4CqzGTl/95SJGW+AtrqyY3pQjKXAVyzp3AxyT?=
 =?us-ascii?Q?IYG+URxwClnGTKonQ9g2TPpfSt2y8Bkyi7YaBkRkw43V2cPqox4zUEE7RFOx?=
 =?us-ascii?Q?3TzgD0GqvZo7TlygmmidlsktA8AyhrTljc6/SuH1/klJvKaqvRej2n2HYS93?=
 =?us-ascii?Q?7VPAM/wEpzBS9wVqO84rWUKhLmrrjYMN+u1c1XgC7mglPRZW2zodZ3a8M5fu?=
 =?us-ascii?Q?d8o8tJTmq04MG/56ifQOUGD0uppQzrVsYSqBGF3o5zKyUfLkto4lgzC90O1m?=
 =?us-ascii?Q?CI5zyjXyoG1M+Eo57YFbl74U1v9TddeI5xiyGHT5qJnsCoK33Oo67lVMJrTs?=
 =?us-ascii?Q?ZwK1mQ6lCOHCHXRjIdqEBSt9MjegSOrmPeLdSCg27wS/rRtrh1I9zigufPxB?=
 =?us-ascii?Q?iKEYXwE23GdKUIwC+vLeD5qe4oxAzK8TiqKRAc8dUz0P5hkTuOcCxuDqyaKn?=
 =?us-ascii?Q?0bk+NgKqlhlqp1b9BAKiEuPoUYc0wK/ZuuwzoHYmd+1+v+0brdhO9vu7f7Cm?=
 =?us-ascii?Q?0gJDUggjlDk07HBfI46t2gQIepEe1ZSUloVqoI8POIXfh/02pd4+0dCBSz+S?=
 =?us-ascii?Q?ufEPq5cQWWLvJXbsZk1NeaFa1lGJjq62um05aSX//Kqp0f6n6MZgSIvRuBFu?=
 =?us-ascii?Q?lOr65GaX4WiviA131j+EbmqBKGLFgplhcS9A1iHbZqxBrGTkxATxFJC59Lf5?=
 =?us-ascii?Q?x/F78rhofkWz41DOL9TapKkaNO6Uj1nCg2LvHGpcgcm61nK8mUKh5i8I6xvI?=
 =?us-ascii?Q?OADhaz851sF5xHZdqfGYIOREZlA9LbSweJDK0808HOW4rKQucP5xuHV202/c?=
 =?us-ascii?Q?iVDZPKMVS76OsOhMtSVk3y/QoklqnzSzx5AgYUM7U4fINWbO1tvRKGPAj7+l?=
 =?us-ascii?Q?iS4nTNWeMkZAF2W6nZ6ARc4jCAHI3uVJvlySUG9OfgJGawDyHUPRYGDnC+ID?=
 =?us-ascii?Q?gjd/MgqeVPuQcmym9Y0/TqruoUTzYG9q1TPeBNJCvfWGpJS1UmV0rA3SI+M5?=
 =?us-ascii?Q?3NGQCb4lw9GMnZYuu30Yv4jIwwy72CO9NutkHksQlGqRhAZ8nsjK6zUADh0N?=
 =?us-ascii?Q?tMC9/hP5nOmPByiCQEHCfh59KbyskvaaxMiUQLRwA6uC53a/uYk2hoMcoZE9?=
 =?us-ascii?Q?FGks1gARf7c2bDmzoct3V2TviwVxHW2IlVw4/Glee1ed1nimbUXKskSGnzH/?=
 =?us-ascii?Q?kDHgrEwU0DSSOhGIXOIxPIXmccqMtsNmED0P+ynZJCqATb0nqLMjSYBoedrC?=
 =?us-ascii?Q?GMAAoX65qadWM5QFPkKrhI1RIvkux8qoWzsQ5WZQaWN3yPcVUcxRKNiDPMv5?=
 =?us-ascii?Q?vAaYJu1Q+7ADA9cziRo0hgQ10hZItdYLa3vzz4AvFkVBBHadsf02n+RK4ptr?=
 =?us-ascii?Q?vOoGJrML+s8ENjhKkfIq/QZdF8NvUIC61s90/stx/BKYWPalKJaOEkovMiwI?=
 =?us-ascii?Q?37FWOtyArj+Xjchk1V+5bio=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d067b9c2-821e-4f55-e6ef-08db9d59e6f8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:36:05.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdZhj6xOwDsB7DCPhhguDJxbezec8qj0fAVyjeIlUOJ0w+y/w0eFc387rx/a6dcchEEvvKyqPcPC2xI2xo0p7HbQrps2GJugtgy5gIfiVPqYq2F/3Er9Ms84yg8efjLP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 04be94b4aa48..6387cbad7a7d 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -715,7 +715,10 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
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
2.41.0

