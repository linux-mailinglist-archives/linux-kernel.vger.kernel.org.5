Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB4791655
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352832AbjIDLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244648AbjIDLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:42:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2128.outbound.protection.outlook.com [40.107.93.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C58CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:42:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CP3eWLZ0swM1YzZwW4iir+cWtG2/rLZA/TB0tQrqJnbSGtYkBlrXKQZ89Dc0w/ktKuNGFmPQCcMH7d7DpYrROSqUClFmIXJVxBuot7zLeQtnYT8NaTuBmEHKjMHHRsOcDKB9k1s5G0d4A4JZmIbinoelAOVYYJwavxmIhZ9LVR+c8EEdtMRU4cEsYi99V+JnhxPEY8bq5B8ON/39Gy/nr39VXpV7uIcvGw3YSfL9uztOhlfKpVd7EOQ1uZBTuVOaLZE8FXK1aWVNx1H1ud19oTIURfcISS/f9OA60HNk3LctvjJ+OhZ+p/VO/tPhvxaMaZ3iXQKF4zYzoZdvleXBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOZw2EURdLDxgbCFLA4cIfp5eTLsDkKifig5lfBXwNI=;
 b=UhUH6oIRwC+qPezgYpj2lmRnCDRMwhu0UEvFQ31ODjt28JiSJ49DsE0h78SMyFexMSoe+S0ZfOm1mI452kYYDzTgL/0iNNaB6lFon/+F6qenbLA+YKZPqn1z2oC6btSa3Nf6DU6ikEwT6PxozS4xmvZzXIuHlfeKMtV3gyRh55HD5ZMyho4Trv0CftHyS67cGoiEzsMVJt+zYv2pNZ1X7oITwnpWcxNkS4qfT1NcQL19r8NcPrY4ABJnWN7WdSvsRaIGVE24CzU8sPnqMec01Gf64kq01zuN4KAypAbJ+6kh3k5lH+cZtRUhEz5KsRwdOMoA8jwWL7Bh1FLA+nSK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOZw2EURdLDxgbCFLA4cIfp5eTLsDkKifig5lfBXwNI=;
 b=NnHbTFD0yHDfOkqEnZsFzY/ETzajCjUoe/DYEFyoapGQAdGt6ZE+kG+xJfwX/cB/MftchnsKj7tTq0W9nOZi6EixTnjUhTdmt+kSpwGbrc19jRMKlvhID6FflE2pFqrpaXN0RSddaho6/XLFnHQeLwPeJHb8zDVnT3z7ks/EizA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SJ2PR01MB8008.prod.exchangelabs.com (2603:10b6:a03:4cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 11:42:44 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::460c:bded:60ff:3254%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 11:42:44 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org
Cc:     Christoffer.Dall@arm.com, eauger@redhat.com,
        miguel.luis@oracle.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [PATCH v2 1/2] KVM: arm64: timers: Move helper has_cntpoff to a header file
Date:   Mon,  4 Sep 2023 04:42:17 -0700
Message-Id: <20230904114218.590304-2-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
References: <20230904114218.590304-1-gankulkarni@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0024.namprd16.prod.outlook.com
 (2603:10b6:610:50::34) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SJ2PR01MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: a27c115c-908c-47cc-012f-08dbad3c0d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttxdubhvqoP9NLwt4Z0t9hzhbIkdhQzGgC3OsdMujJ/S2St1MxCXt0N99ljjDC5KDS82KcdMwfRF4YJT4volmICXDqD8bauPsfBn4ZC/rjLf/8tawgm6yUv6/MfucjJlzUqBiqg3I62EFghMfGJR5zhD245WeyyY4bIDrv+GbqmNvwvqWEIECaZkaV1/QbHT0iKdlGLdKQK7YwY3GYnwJQQwEo5TTAeKTSl3OBAuJyYtNTvP1aTGMg/3padwwrfB8u9bHmi1ar1wZgQl6YCQIjIxA9Mz+NWfUW2I+qjxA+Y0yjOOpnZdhO8JMY92qq7emEe7Go3DjzQVuNpQdKpod5R360Wq02OIYhS2rBah+41+ZPrAe45Ujjzb4h49PUJFuY9y4JXZcjHtKNkJ/AMLOl+MOJhdcNX5eidhxI3/nLCk5b/GbzSWK75FuEaYjHJ3twppFLH7/lYCRZfHJRqdOGWJacEsZEXxtT/6HiKpNbnhttwtin2BL6iulSjY+mtpkTafVdE2LT22bUR9CeH0Qs9zMFGcRZbZHbBbkl/zQlG99zSkbAc71Pi2dna0gLqiTWwLs/zj+JPYVpXxYnasX0BPNyaCNAA7C6lwbGYtEnrYQCyLiPoxRBsd29uUWkGO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199024)(186009)(1800799009)(38100700002)(38350700002)(41300700001)(5660300002)(86362001)(83380400001)(66476007)(66556008)(66946007)(26005)(1076003)(107886003)(2616005)(478600001)(6666004)(8676002)(4326008)(316002)(8936002)(6512007)(52116002)(6486002)(2906002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXhN7n3wVIDFlOhlav8qxqDXuNvft7HP0eYHr5iULnhnq8/T5DTBRcWkVoBV?=
 =?us-ascii?Q?zvWSuhFl6JJ24dAu8u/BFskQjso2B6lwcqaqESOo838DBxxCCfW40WQN/AeN?=
 =?us-ascii?Q?QJOk04/3g7IXbXjHccMZGb6N5cL8Yvdk0htggsFwr/vWXtjDiO8aM8S0fcEj?=
 =?us-ascii?Q?JFHJPgWJre7VK1ClQJos2BrCD8VrmA5KF66hdH14vfbxNhm+DECbisAJuh32?=
 =?us-ascii?Q?ksepsSJOWAiFEjBxcaPNJNT60WBpg22Zptyswhc+2vuisEursm+v2p3FB6Q0?=
 =?us-ascii?Q?8YGQTG1hfmF5ndBX/4bMmq7Q28rMjb3eKwACS+mJ5iUrDNpReR2TWCsJGy87?=
 =?us-ascii?Q?zCDy9tBaOQ4/iqvmE2PN8p+3Z/MUD/J6nHE+A4alSZHvX4izuJzcfjo/QO2S?=
 =?us-ascii?Q?RrMG6RoXs7wYHkoN94rszjKsq4RNQnLARHedJjxMx+7UpY/tHV/ILak+8L+y?=
 =?us-ascii?Q?yF8dnKGfLG4peGadMRcB62RiCZ+6aPI04raZ76jxYY0ROdxZ+/4kM9I24brH?=
 =?us-ascii?Q?h2Wo0YfHFIZNtuIA0aW9SVaxUkIjt4ndcSkVk4837KQfONLXn6dj4fev6UH1?=
 =?us-ascii?Q?QxHEPF8GGe5ss2+QB4lt6V6Jtu7JIqP1KvuYheNHTC9S3QkNmXo5HXgUU9gD?=
 =?us-ascii?Q?xnOI2X/+aKTMr5hvstVJaL+r+D8sizkah8s+tal7nO2PBNm/xbrg/IWe6+J1?=
 =?us-ascii?Q?VN+FJsK2GxOkwwM0NSMU3rc0MXIjJNVQyiN7QwuBruvnrRbQNWAqKT7lkidB?=
 =?us-ascii?Q?JqxHIJg1ewbZLOYY6D3TYyMUztV8x8dRlfVZYmwfP0Ec1nL0OQTtbEzzUqu9?=
 =?us-ascii?Q?T/1UBDZ+RnSGNM9SxrIECpLTZ1/thsfZx9pQt6rALCa72gFQb8Yw7nsWwUoc?=
 =?us-ascii?Q?2YOZ0os5P9q4T3k/voOEdZ8u6JB+yPNh0RjpbwbIrl9uASl6wgtJPjnqTKES?=
 =?us-ascii?Q?JXVhRdhsxzj8A9JO3FWAk/xM2EYGkzSF70TQ4u8bNfSEBzRNGP9bYsOM74Zl?=
 =?us-ascii?Q?MWBpmAlh/6UUVOa42L32Rr0aTCzJPkLCcCvbFxBt/f0UFiIxCcUFsT2t/VVj?=
 =?us-ascii?Q?K1IvwbOqN8dXvbiA/DENmTo+xWEU7mqeXJW4tP9yOT3rM9cOGxgbhaGIMpVF?=
 =?us-ascii?Q?lFkZapJP97RhzGvEZZjoTVJuG5n7xAT0BxgqSo1jSZJ6vsSH7edxnrRH4xay?=
 =?us-ascii?Q?9llTwuwijD4rOC0xVQy2dafZ0MdWcxuVCxjzldHoA6TqCAqftxmm/O8qBfeb?=
 =?us-ascii?Q?iZakLtV8liYQtlQANsCywukzopYcHpQkdklejDuIC3T7BFdt/Uym9ytYYPT+?=
 =?us-ascii?Q?iLu7EK7LGA7FL3ibWZE5CHmM6O0XODNmMvDmInscFHMuSroAbrhGvmyb7uM9?=
 =?us-ascii?Q?4DjhYjQrD8kOFm8RPjrhNJlA1WBQP0dNyk8YQxNjf5vFTZAOCjc18C4+AJhX?=
 =?us-ascii?Q?ekhKKGLRfGbjSfFwWnWhhfE75QTB21HMfUQs8kCHubCYW2xFOC2qPW5/wRjK?=
 =?us-ascii?Q?Z1NQMHv7VxeprwQ84l5L8ZOZXMGzM7fwRSTmyU/wRdrQkQq9GcIXhlGe/JIl?=
 =?us-ascii?Q?EWn1CiGrnfnlkHzCxCMTX9Yy3Rb3I3HRKsY71jr/dzkDuQO8MTZfwop3aEkp?=
 =?us-ascii?Q?s5UC12cc2/gNUB78AJIu5U4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27c115c-908c-47cc-012f-08dbad3c0d89
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 11:42:44.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsWXhrIj6mr1oU7fUWC0cdIxMsAjuGyeYrDi3nNC3a6tg0jg2xi535/GXhEggQF6b2jKnBSrvQ5eY4HW+MoBLEFH1yCIoj2dl7MNR8S6XzN65aNkOF8v234O2HaVVvRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move helper function has_cntpoff() to header file as an inline
function to make it available to other functions as well.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 arch/arm64/include/asm/virt.h | 5 +++++
 arch/arm64/kvm/arch_timer.c   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 4eb601e7de50..f22cc733efb1 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -132,6 +132,11 @@ static __always_inline bool has_vhe(void)
 		return cpus_have_final_cap(ARM64_HAS_VIRT_HOST_EXTN);
 }
 
+static __always_inline bool has_cntpoff(void)
+{
+	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
+}
+
 static __always_inline bool is_protected_kvm_enabled(void)
 {
 	if (is_vhe_hyp_code())
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 75bddab3224f..98b0e8ac02ae 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -55,11 +55,6 @@ static struct irq_ops arch_timer_irq_ops = {
 	.get_input_level = kvm_arch_timer_get_input_level,
 };
 
-static bool has_cntpoff(void)
-{
-	return (has_vhe() && cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF));
-}
-
 static int nr_timers(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu_has_nv(vcpu))
-- 
2.41.0

