Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1D377C7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbjHOGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjHOGgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:36:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2C1986;
        Mon, 14 Aug 2023 23:36:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hak3tJT4Sz3PrztwbyJbfClJw7/2xFv9jm4vJPIErOypHZ9mi2V6PwlRk/KPXAiDpLP75liARkwRc1OkGggjo8jlhta0wH8cbKPAKDGHIgWC9+4yqNwdes/qR6NR5ig0ltqv49mWLQFavKVqOa/XjPmuTok/uh4DXg7WWBrlnMocg/qJQ3DR4bhkQBVsL7YBrPRX14TRmj2d+uBgP+ME+cjMf2gkEh59NMMFFCxs5SbeyPmysa+FfN9BLemltSGqske+ZuFHQNszWijuGPgM1dcAG1PgZUG2cPhZw3RIU4vjgdQpmY35C6ypfdyUJd3i7XWNEg0sFlwZqWdz0Rw/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpitZsUNtX2UesRGXbg+V5CjVloGzVOZifQLuUSuTZQ=;
 b=mliNHYur0NHfc3i1SfrajPzQ1hyYctSYcbiysBkrbVnZOgrf+cBPS9FFs0dRtAlLCv5f3huSN5WR8EInBUlt2N/E3f5tFQ/Mg1lgvknEgURo+SyHc2M17GjHKkJ1X3Q/Wy8bcWWi0jnK7gcetGZOuox8pag2yC8JniVsUryBlM+RHJUqTlq4QBJmgpwo3y1ZLVuQZIRkcb3Vejg/3ujIOhDZB5zegG3mAA6UjM/g6LFQEgtVDNfWtZs2gOhobbpcQ8C8AaK+4CsAw3R4xme5ea8yufAyQ/P502VgrX6RJUFss0Vp9w7h7EGIkBaDev7tLun3RcrJmsqyI8v+fd2t/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpitZsUNtX2UesRGXbg+V5CjVloGzVOZifQLuUSuTZQ=;
 b=XT9CbkXt9c4jnC0aBVmd2OD80Kb1S+D5j7XiEJt6SY9PYVW7LIs0i/7AC80MIBzpWi4vsDTW31GjpqfH+Kgzev3ss6/V5Fjn3inDXjjxEVmZMG+Wkc69xQA+Init0FRuEcKLvAAFtsguW/P29JwN0DK+Fq9Eu2ybhfY/UAYXYes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:36:13 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:36:13 +0000
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
Subject: [PATCH v6 3/4] perf: arm_cspmu: Support implementation specific validation
Date:   Mon, 14 Aug 2023 23:35:25 -0700
Message-ID: <20230815063526.9022-4-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 71cffce6-7ffe-4862-b1e5-08db9d59eba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDyxrMdBQWEYJqV/PUDS+0SJYpIepC9ArFdQ+seFjB2CuAVIIh+TjS9cn6viIx3Khfbo+EiA0duXp50n5GFLGqM5be4Z7H3I1lyRrzDJFMd/PlpJl6T0URjoL8/D8i0p33tBT4yzx400KNolXrTZuw5V/uFij/o6wpW5HH6Qeg1/POWq0HbkLmB94Z6r9p6f8LugqPfPftVu4MrM9kpC0uZRK4POgsofwOPkYnHOBTATGd+y+rs1XT1slNK8EnRPFWWJJMo6S+9O6Lywn4VECDwjDo/SDKA9oFqz8EsTR3WfBCXdX2UI6qOxO7YR+0tmYFPmWOIFNeqdENvHpg1fcX29igWSpBt3cDCKQQWlVC02XO9F7vDmJVvlzDWJ97e10kw7e2jJURXi0agus3kzusEo0kCXhGc23smX+aJpP5MRt/GuvGTEwbpNkofMlaMY8iam8dzUxVM0xeGC5PmV0rhmJQKytxKDK5YnvBe0t9w3CTCNaH8Dg7AsPa0yH28guPKIAA0j1c/wQ3xKKGIz+sXQQRjZoX5tSJemvnvfoVZZMKSmbn3ruSOikKdvxz9ALDjiAPwAQch/0nDejqWzOthrLPxGNwKW9Au/D8sRTua766las7Jvr9RZx5cjpC2N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(186006)(1800799006)(110136005)(86362001)(478600001)(52116002)(6486002)(6512007)(6666004)(41300700001)(5660300002)(4326008)(66556008)(38350700002)(316002)(38100700002)(66946007)(66476007)(2906002)(8676002)(8936002)(7416002)(1076003)(26005)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w+wh9ekDNTJuE2HclFwtwwRsFOGQy6m1h7tl8oBhMNgqYbuvaeqMibtqps9a?=
 =?us-ascii?Q?GZLhSX3MsXSd7DlVKpOgTQHfOTb36Nqf42ML+QtDWQ+Cxyp3jIPDOq3hbRGQ?=
 =?us-ascii?Q?shteDdFRB7tviECBAxf2Q8YYXZcVSbvFzvjpuVnMkBpJi1ipQopM0fR7C4MZ?=
 =?us-ascii?Q?0ajgnCWhqwbBDQ+vcUIVOotU56OelIS4S9Jz/oU1zXyKkWt9MW6STDEP3P77?=
 =?us-ascii?Q?MNmkZ8pD4jj5PlHneTVMkz2kKI7QqTadxhNFMarcHAcMDFG45xhMDQaOnuQ6?=
 =?us-ascii?Q?83ArjwaQhm4706g5DQMasql4/o3Qsq9fij4NRj3R6kDdlD8rhXnx7Hg4iD1u?=
 =?us-ascii?Q?kOU/dx81xJrFWVDud59rrU+AOLWp5Ir4aH+QgGWvRemc8985/gTdIuK4UUR7?=
 =?us-ascii?Q?TZOpz2U976clO5Rsi0ZEnEeNGoruQk0KYF/9h4aBsi7aXU/9XXUZWeivJjgA?=
 =?us-ascii?Q?ytebKNowU2YIuUpdFyeN6zvFoh8E0H905uKn5LHMPaLx/Bm2h06w8EOHMKzl?=
 =?us-ascii?Q?Nca9Wy570th2tkKUQ5dTahoK51RHJYoTT4nRatGK5tTg5ktFVYC6wunifjGc?=
 =?us-ascii?Q?s9NhjNaRcwqlFEeMTscwQVKlYgl1h/OcJBgrUNcDflJezFyinAjnjbVDgVDb?=
 =?us-ascii?Q?QAmpV0K1s7Gdsg51Gagil0FsqdiSYimRfEADjjsL72rOuIm0IWo24Rlxqma6?=
 =?us-ascii?Q?WVfIL7HXho0551DX0xtw1PbVj7MQZW0aOBSaMMY7rHW//fpoIhTN0gpJjo8f?=
 =?us-ascii?Q?JbFtC+eAE+ZQzOgalmnxbNjBJwTbTVN1AB0LM7zrwMtUFaWMzz+t9z4A4Z66?=
 =?us-ascii?Q?KSlY59Z0DWgv11kgxTxZg5Kthk7Ysqnx36804U5sx8rb6+5krdlTfKbmx/qm?=
 =?us-ascii?Q?FQwLVGw2T9W3H+QFXw91mK4MdGI6Pp8K+Ly1MzOxYHAyVCrd/dQ1MycHja/R?=
 =?us-ascii?Q?rVlTitfvytvNokxB9T95vH2nBKB7at3k5xTcpRQEk2mNsu++TXa4f+YmuPhv?=
 =?us-ascii?Q?8DBUeuFooWZXAzj1YtFuMfqepsY9bpBwPPkzh0ycMWBE7Z2G669V7J4ZWpqu?=
 =?us-ascii?Q?W0xb+Hskr9EVRWkeHGDt6uifmn+J1vUwfgm4dGwswd30/y8UtVFVKFgpy9cw?=
 =?us-ascii?Q?fdcqrwN+Y9YWf3XFLgCTmQRqQhT/g07eyn8RzVfKpCjvsg8lZWKqGfiB/5y1?=
 =?us-ascii?Q?A8PvW0G5ZH1q/TLB/RNLIOten8uD/vHFdJrr1THbkPRGw1s/4RImocv2j+3g?=
 =?us-ascii?Q?YYh5ri1G32ikxiAyRgU9zIZ2DBhYn3NDZSj+qfZS+mHp+t4cvHdEJI/L93nz?=
 =?us-ascii?Q?DW7lcQk13bohHoa/oRNt6r+8WjvyCY8r6XCuS3mnaiel8Z88GO/E6F00Ww2w?=
 =?us-ascii?Q?MtdNrbyMVQUYu3umeDgFNXAKGb17gV0+LJPVS4hdmEkycxQ1olF7plWgcSK9?=
 =?us-ascii?Q?qj6PrIxKdYy3gRNny4fUn/CfOmdm8DUayjV2CLF4C1u9XhRKrn6BAAgh/owo?=
 =?us-ascii?Q?p6c/fSVs5dcGSGsDP1zEP+upzRvWMDcLwjiY3XnFGuWVWCCB1V309pxMqMbd?=
 =?us-ascii?Q?cO4YUyEZ54o7m5xtfZucOJW/oMC0Oa4OagnF1P+6s1bfhGsicFWAWQ+iuf0D?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71cffce6-7ffe-4862-b1e5-08db9d59eba5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:36:13.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbe6gYjHYxPWtGtgEXOp9fGyUzjsp6cmLOAyXMAJ6GO95w9B8+b5ncdoTwHErS8Cx7/LMTmdYL/KKT3RT+aLWGDiVaiOwVjhUy/XElxbesBWhT5YvYA0/+WHOPSnp3+G
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

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events and group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 94f6856ec786..585ce96ac03f 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -572,7 +572,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
 static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 				struct perf_event *event)
 {
-	int idx;
+	int idx, ret;
 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 
 	if (supports_cycle_counter(cspmu)) {
@@ -606,6 +606,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 	if (idx >= cspmu->num_logical_ctrs)
 		return -EAGAIN;
 
+	if (cspmu->impl.ops.validate_event) {
+		ret = cspmu->impl.ops.validate_event(cspmu, event);
+		if (ret)
+			return ret;
+	}
+
 	set_bit(idx, hw_events->used_ctrs);
 
 	return idx;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 274ca3d10578..05577f74b8a0 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -107,6 +107,9 @@ struct arm_cspmu_impl_ops {
 	/* Set event filter */
 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
 			      struct hw_perf_event *hwc, u32 filter);
+	/* Implementation specific event validation */
+	int (*validate_event)(struct arm_cspmu *cspmu,
+			      struct perf_event *event);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.41.0

