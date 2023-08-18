Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD37802E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356809AbjHRBNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356794AbjHRBNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:13:20 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A323A89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:13:15 -0700 (PDT)
Received: from 104.47.7.175_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id C8B1A100004F7;
        Fri, 18 Aug 2023 01:13:13 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321193.271000
X-TM-MAIL-UUID: 7932edf5-ed4e-4436-afe1-22fed13238e8
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.175])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 425C910004D9B;
        Fri, 18 Aug 2023 01:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+Rb347wLXzpwcd+lhaX08/wUWgvMqMZy4oU045dOTWkGuH/ss7d386h2bznsdcqtKcTIFGJJcQfs5/N5k2EYnFqv/ozX0v6pAjzvcP2wCfeO1edZfbJMiMuDFP8rr+lTQufTSsNTHfpomMbDDR0/dzS7T2pPoHrF4ASIJxslPrlZYxetiveqmX2XMawQT9y7VvX5njlRT3YP+k5J6z36c5h1ohY1NRZ0T3kZ/21nWuX/H3guzUC4hJaCQbD0uBntAqvkYEmOHB04nXLcPWyuXfqoZ9VpWy1aPMEIQ8ZnZu1v8ObVs7JSnQUMRsIb3MH0l+YeifYNxI718RQEKSdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CPN/nPYjocmwvcfXZTjN/a02SqjoXA2xPnUaZmdPE0=;
 b=CZbOOYmg1SlSZQ/gHGAdK4c+Bbi7Kl0tqfNWJeU0eUyhcD9B5Vc2eWH/pg6G+HJ4du4xb7gDpFj9DuvlCW4E7yEcoQSMUxYGH8SoQiTR2Tu+vMynfeUjGvmnDdK61k5/CWK7CFD3MPBZHBQ9w7lzLZXszZeqR1f1m0qbs/Nh8xYPqM8CFjYVFYpSQdsTcKsANPvP9NLVC2/kfySsvwbfsrKST1yZbLWno0vvCzHX/AcamRT8iAgOZqvYUFiKYaisKg6Cv34OJ/nBn3s82b1CxqeMXfHJ7W/B+zL5j8eMerTX7XT++L517nHIwK2dtSmR+s1oiVyrMRo3Hs5+TcFmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=alien8.de smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 3/4] x86/tsc: Use bool, not pointer, for ART availability
Date:   Fri, 18 Aug 2023 03:12:54 +0200
Message-Id: <20230818011256.211078-4-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818011256.211078-1-peter.hilber@opensynergy.com>
References: <20230818011256.211078-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT041:EE_|FR3P281MB2252:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 52ef0dc1-d67c-4f02-2810-08db9f884abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dScNROYO8b5V3jDBCEbGjXjky6MqJgKYLHPiqO2UGon/iBzJDCSliiYRqnhEpU/4WuZJv0ThtCNJJra5Sfq5lETyP1q8+qx/6luKCxDH7wS0oCvP60qT69+wY6iT0jZn6aL96xkHnawSIloyBH6Yl2orpeCj7PY4fYmLXPg4sYGdQfhhPd6tfut5vHEBRvOxiISteswJbvQuKOprxWj6RObW6GPcBv77jPNkP6mkLmnfAUOErp710eXR9zdrtYPxPL0FhYeSzzY9eT+XNavGVlbO/qTLq/CXPfY0N+Q7yUP+8+Rv1xI3cPB9YQK4ALXz57EbiQRQz6TvE+2BVmUmLoQuF4nOFtE0E8HNdQQJun1Fn4tjA9/xVqFjm5gZQyEr2eCQe4pDlWiwfJju6iAFwdE4PsDN/rZsKNzNNP5Hn1jTqo0EdHQVGelMEIt1bZwU1bWCUofWRK3yPaAJNbojMMutvIIPXB/dTe0Pz7qEt6xzgI260iG1MuYjotjTsmzHZQVLGEGIi3ju+IQZT56HP8H61SiVuaKeihGrVoaBdCmpWEvna9Na4vDyUDANbFKJbAT3w7MINZ/pkStgOw4WgAsqpQQkd60m3+KEqB/lFlVwqN0PWc3Keu+t1eag/NJ8a6buLykgWp/rWQWglmZ4fkqo59KNuNKygPEVRmUx3c54pBZEcrlNkEgANpFvmRIGQoHFc6649nIA+kQNLykslz25tvK2Ha/FrfHEyLMUwJ6boo8mZ6P5uhNemnNXYEGJRdEVx0pvoB/ZJigJoe/dXEbZsuiUzouJApJYpFFbQXLhscvCHIk+V6XGqcJ1wq8R
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(39840400004)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(8676002)(8936002)(4326008)(70206006)(70586007)(6916009)(42186006)(54906003)(41300700001)(2616005)(40480700001)(26005)(12101799020)(44832011)(316002)(2906002)(5660300002)(478600001)(36756003)(36860700001)(47076005)(1076003)(83380400001)(81166007)(86362001)(336012)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:13:12.0333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ef0dc1-d67c-4f02-2810-08db9f884abc
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: AM6EUR05FT041.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2252
X-TM-AS-ERS: 104.47.7.175-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--8.703000-4.000000
X-TMASE-MatchedRID: DtXN+5zl0bBOcYuxoPS7YSE8raaf46xMzs/gmkWwxXBTcuWQxWoJHcOZ
        2ctl/jceysiQ9faGrCSIru8EW9Y4u63XYtsOH2/QRYNhzuZZjRDXT+yjPvIHsRyuwUNBDCDWn1Y
        nLTDBk0buim4ICo56cvwfPGKbM6oOJQ2Ybiz75wx5ax/05CgrEXJ8bM38R9gpJsfJJdVp3fqvng
        kjHjojpH2fbnp7T2HmiXG+DOC9634tUBe4IrvOVzsAVzN+Ov/sghvJFPvykvx0cGh8vag1uknyU
        4kYGziwlrodeCxdI8PhaKb9u2RPZQ==
X-TMASE-XGENCLOUD: 3b45fb95-b744-43ba-9d66-4708894280de-0-0-200-0
X-TM-Deliver-Signature: F5CBF04202AC237E3BCCD3E2029B7634
X-TM-Addin-Auth: jo3AhD/Ip/L6NItNuZ6DqBIu2+0/sNnegYq1Nvek2CUXT59q9Py7Q6xhJ1t
        i1xYYwcoHSkSkOAqOEw3nHEdW7jcTpPXfg/hf4a9+kS4tRdzgZRDomktHvLyxnPSLPytcrpxV+j
        HbzVnhdhjDxqxJwLxjqlJylMFMcnYpKSUmldwzXgyM7KoRyJzmwBVvcnZnDs6SUKZosUIjSAAWS
        GOLTULg/hMxbYfmIx4ZsXzMzNgQN3/U7r8QzzbIrLbALv3TkSRi7bI78JJ1ztatB3VcWZSZLIri
        JlhlVpaWrIeuosA=.y29peK82uInHMbnR19ZOpVglonoNTYXX7xuAoIg4thaYI+23x5YPgoX+T/
        Pq27DkVQeJYLCw+qWA3UqrQWObBsJpZOBBawYkEdXR1JbPAjirKFkHCrf4sHG3E7tkATUpFYRTi
        DL75IQpXxTWfh+hA7nGIlZn67BCPf3tvPJvqrB6+iWhLAwyp82Rv4UBMCdFsIw3WZ7+wTKxOP3q
        RvoCLir09jIS8bNC18iLD3luptAtYuqSUB/FqUKyCm3LAqzrVrrG3xI/grVgfOh7+MtlDiVAsv7
        F+761MXukEQo9vUH53WfKTpxpoLGPC0RbjBPy6raxAImRass30kvqodkkhA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321193;
        bh=7mA8mEPtfxtSWGgmair+oao5pUoxYjqaGMV/lJxntYc=; l=2532;
        h=From:To:Date;
        b=esSjttWA4alzrwxIrgHl8Vfcm4ehAhrHaiy8r7E07DqjJVCD3Los0dMSBz5qE0owj
         +u/CeLR7g4eTTVyb/ygdApA8/uX+OQAvYbRkeHgafAJ8PvoJAKCSpTmvKVKtUjgiNZ
         esbtqQ9R6r+JS7F+IvibnKviDLHXTNy9hObOVtj0ETKzcvqyE0/5AsdNIyLfZXxRzD
         cbx8Q4T2jrj/gBy7DYt48L7zXj2lcaSxsuqaVRBnYMUcUY816EiKllU3Vl+sO9qIpI
         1pWFVkN80fRbW7V1zU2WtTO9WWH4nN0MrbGDHP8aUZ1aCOf7LkXxEQChSsw2C1Tre0
         mgrvpxL+p8xCA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, ART availability has been implicitly encoded in
art_related_clocksource, which is NULL if ART is not available.

Replace art_related_clocksource by bool have_art to explicitly indicate
ART availability.

This should reduce the changes during a tree-wide switch of struct
system_counterval_t.cs to enum clocksource_ids (when the clocksource
pointer will not be needed any more).

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 arch/x86/kernel/tsc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 132045be76d0..e56cc4e97d0d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -54,7 +54,7 @@ static int __read_mostly tsc_force_recalibrate;
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-static struct clocksource *art_related_clocksource;
+static bool have_art;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
@@ -1312,8 +1312,10 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 	do_div(tmp, art_to_tsc_denominator);
 	res += tmp + art_to_tsc_offset;
 
-	return (struct system_counterval_t) {.cs = art_related_clocksource,
-			.cycles = res};
+	return (struct system_counterval_t) {
+		.cs = have_art ? &clocksource_tsc : NULL,
+		.cycles = res
+	};
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
@@ -1350,8 +1352,10 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 	do_div(tmp, USEC_PER_SEC);
 	res += tmp;
 
-	return (struct system_counterval_t) { .cs = art_related_clocksource,
-					      .cycles = res};
+	return (struct system_counterval_t) {
+		.cs = have_art ? &clocksource_tsc : NULL,
+		.cycles = res
+	};
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
@@ -1458,7 +1462,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 		goto unreg;
 
 	if (boot_cpu_has(X86_FEATURE_ART))
-		art_related_clocksource = &clocksource_tsc;
+		have_art = true;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1484,7 +1488,7 @@ static int __init init_tsc_clocksource(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
 		if (boot_cpu_has(X86_FEATURE_ART))
-			art_related_clocksource = &clocksource_tsc;
+			have_art = true;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
-- 
2.39.2

