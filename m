Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EC780303
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356898AbjHRBUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356883AbjHRBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:30 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4CE3A9F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:28 -0700 (PDT)
Received: from 104.47.7.171_.trendmicro.com (unknown [172.21.184.89])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 16952100004FC;
        Fri, 18 Aug 2023 01:20:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321626.821000
X-TM-MAIL-UUID: 0198130c-4a3d-4cdf-bd3c-d3e3f48fa5bb
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.171])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C8B4A1000030B;
        Fri, 18 Aug 2023 01:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVjHigM//dR+PPHcF/wCaBtWGX1wcpvzUDpby4/QBBhx5AgehxjJ1VsECxxc4vk6LIxOMuLK6gfWGe9VRTWgY81dQvQzTzZ6KLjvCOpIn0TRwzGtykh9Aq1E058BV/12CjiKcFh+iEwX0xA7vOCRhMKQMSz4tz0BD6m3xscfqqpIkHbsgXU1TxxDK6TWtA3HxYNo2E9Y0oeGfpEsPweaJ3TiXxCUOgyjhEMF6/cJcVYmLUNeP7vFzCUTIdN1LjO+roiYBKxkLvxeWShDO/CfNyMsU3alif5w5s6u5NwGOLo6osEhjN4AuR/Y47IUMOfGXZZu9Xtm3+7LgAQB5PG9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6eWItVq2HvctmVHpWJpp6CPXsfXR9umUF6UCun7E1o=;
 b=cy59ilSArkeL/sEzcHEiKBlAEjyKaOrYsdEVPesA/QF7sPbsmnhn4e/66jyQflnx/oPXDSwsNoKwk6qV+qvjDGTdfg7Wpacry9wbmd0T3+mYaxW68+jvikCELf00Xf1uWKCpSEUPa9yJpJDGfdqw6qerB1/DLmG9XneTWMTtz9F+wLazT7Zlrk+RVxhzJbnamAM/0HiTguiNglEveWNwpbh9o/450Dg1HdoTJEpUltiD4G7n58BnZ9S9nmwxl4L3NyHCenSXADseV9RxX5pm9ociaIXoLQTQnUXz9CQwrs+AZoiJ4Lf6Z8JN/9GBWQVLYwQDXDc3b4i0H9bRYQptMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=google.com smtp.mailfrom=opensynergy.com;
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
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: [RFC PATCH v2 2/6] timekeeping: Fix cross-timestamp interpolation corner case decision
Date:   Fri, 18 Aug 2023 03:20:08 +0200
Message-Id: <20230818012014.212155-3-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT012:EE_|BEZP281MB2659:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08e07181-ed47-405c-597d-08db9f894cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fntg2dHADLFh0ewBoVl0KSmtMEZ/6KuhbpDLzYDRPJbNN7oEIHhkaOOdAD5iX4WJad20iYQnaLJAL/qJs+/9o8Oe55lqGIaXacoWcpSeaoTL+WFnv06Zt+3Vybyj3KUS9cihgYtjIJPluGsKyMdReG9Jrpl24HjvRybST2+w3C2/EwotcgSZbKkFWrDMTd6fzTFV3AFGclj198rdUNIfSVv+CpARz2oPXNu91DT4GoN9Iq7kOKcETJ3AG4YLbua9QRWocRUtpy1UxZCMS/tJXSU7wH1BR/wFbhef84taW/16oVBb3m+mNU53JHGpDLGxWvxZHtWhTM7wZuOjO2gqC/p38FADCmBmFbChJXq/JyDxWn9yra+qglTGiA0BfMSgrejAkRh0YhDutnV9iclNsJXdJlN554554ceWbiNUnsaRR1VNo1xX5y1Zl2Tprdv2LtFZ/uHrcZvqnVocfVXgXmWhBi9dgfxYu51tyhzcu6Z2qS7rWg/fWkHd0dtKROtuhBEdPzLEBstgq5Si7lRdRqpoQWNsMZDuxqtbAuZjMztQC+ne16B4tQ1JTEA2aW8ta/JWBOYORb13Aa3V83WvfNCV9FN8h24bAzuWnQPDeH85tsINtrg30J2RAvBhVfMAbK+qHMALW6ey9EvEvv68gyWiJv36ENiLqbSTHCipIsNkx1w4cd4CnycwlEOYif5PWXWcRRcpHU/CurQ81w39cnBMT4V5tdN//UwSSQL1KfqBSwR5xtvgCtih43tutXrdSSFXAyBRzfNaeJebJA21P4BEY1aWf8U19WWy4HLHYEhW+Qf/lDwLbty4MR0JKCnQ
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(376002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(83380400001)(2906002)(86362001)(336012)(478600001)(40480700001)(1076003)(36756003)(2616005)(26005)(36860700001)(5660300002)(41300700001)(44832011)(42186006)(70206006)(70586007)(6916009)(54906003)(316002)(81166007)(12101799020)(8936002)(8676002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:24.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e07181-ed47-405c-597d-08db9f894cc7
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT012.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2659
X-TM-AS-ERS: 104.47.7.171-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--6.058700-4.000000
X-TMASE-MatchedRID: LE26z0m6wxyHXEtxeZW06KF4nhfuztKa59KGlOljPvtYf8LrTKM9HLMr
        1BCU9VEa9MR66Vl9gxh3ctDbGLJrCd7BQ4zNEspZnRTJpY7VAKebyUSNdkyqzsKcbytqP33n5/2
        vLspc7WPSwYxu9Jr2alV9J15hwj6kM8VWyP3FqfNGDXkz8A7dj16UsWSgw8xYayFQNyBnwgugxA
        0GvroilH8aPsMAwRmakGbxVBbOQr/HXSTxCrKgDBEuOqgkm3/1h7z+gmKKj0oDf6I8jFx+tgxKJ
        hlMXnCqcYO7LzLWqS4HJk9mfVhpP+eUQOGpG0S0gh5KjTbSHR4iRoMHgyRZyQjyWUk0Cg3s
X-TMASE-XGENCLOUD: 87e3e62d-a886-4ebf-b870-dedd68afcc28-0-0-200-0
X-TM-Deliver-Signature: 6DB098AD9FBA7D23F2B12E17C4C15517
X-TM-Addin-Auth: 9O9gNTs+UpLZp3vuAHb914v3n5J6IGjVdK423LGXh/KgDQ6+vUO/7pi60Ai
        7rDtL0tgV7Uc5CNy6jTVtio7XxbVgRiZoHioxMlnZpvRAKy3iB1rMqziHP38fYB01Hln6HpAhLS
        M2XmtMDZ+6Zhmf73LubbyR2ow0eUoSj44dY0i5636ATk1I41mHusPKXV11MCBUNI/UyxplAMBp/
        YPVJ4/8bDxeHR32zd90lGxMitvr72X9ybj2cWPsPeQ4uCagtG5194ap2J1lhQ+dboQOmhtWWq06
        e6ItL+K72QnE4zk=.Ot8HYSOhRhAVllFVdO+Jvx7VDZ+Xiv7NImBFJs71X8utw5t6bq6LCISUcg
        gMd8Bvt9LQC5uhrt6AqrUQq3rQ8ReDNDGbBuqSWrRY3yRG1XshHRGdXRpKOLtEWHnejwXjarX2J
        X3y/f2DgaJ3DlwiugtS+DJ5cbP+vj+QPGnve7CYhxk/Wm9cQXspdgK7c/3XklSSbSFNdWkGjWaT
        o3/SXjtLjwSfqrt/+eCwIcyUODPudP9rGZpDUf3uN8ZCOL4JJa517fh6G7X5vQYhUp3LNfPl4dh
        O1iBwdn93Mc6CGc+BggM4hlgiX78Ga4x5sy7vRYWgcdzkeZaImnEk947a+g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321627;
        bh=hskQ4dmA2LHnRA6J95hHwMfy7AZjXt9U+gBNX32hFM0=; l=2568;
        h=From:To:Date;
        b=XXhBMz7qvRirodo0PgLpAzinTNQ5LJAldMB7Gvr+lLZ1P7bETDeSuL4kMgv+tVDsz
         tyqg4K5CBnCqlcg15jvvxe7NG1uM23tzQmuD9khG+sPtHK/TaYUrivXcOvQtGze2hc
         kZq5EiRRLxbvuqV475qofXL15AgaJ2ugP1YND89G2jbwV9CJ2Fj2GH9bf/+AQU0uUt
         Xwl4jU0d7eZcmUc9c0nIl8sASgJm9j83kzdqNx/Mi2v6l84tbVKfxJQt8fE9UXBroQ
         1XkzTsVxTVlhjDw2nHg4sRWRp1BAQSSc7cDLlCHBRoNNqdzPl7yrCcIEjLkvwwAmiY
         IqBj7vTDSZSDA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cycle_between() helper checks if parameter test is in the open interval
(before, after). Colloquially speaking, this also applies to the counter
wrap-around special case before > after. get_device_system_crosststamp()
currently uses cycle_between() at the first call site to decide whether to
interpolate for older counter readings.

get_device_system_crosststamp() has the following problem with
cycle_between() testing against an open interval: Assume that, by chance,
cycles == tk->tkr_mono.cycle_last (in the following, "cycle_last" for
brevity). Then, cycle_between() at the first call site, with effective
argument values cycle_between(cycle_last, cycles, now), returns false,
enabling interpolation. During interpolation,
get_device_system_crosststamp() will then call cycle_between() at the
second call site (if a history_begin was supplied). The effective argument
values are cycle_between(history_begin->cycles, cycles, cycles), since
system_counterval.cycles == interval_start == cycles, per the assumption.
Due to the test against the open interval, cycle_between() returns false
again. This causes get_device_system_crosststamp() to return -EINVAL.

This failure should be avoided, since get_device_system_crosststamp() works
both when cycles follows cycle_last (no interpolation), and when cycles
precedes cycle_last (interpolation). For the case cycles == cycle_last,
interpolation is actually unneeded.

Fix this by disabling interpolation if cycles == cycle_last. Thereby, avoid
the above described corner case interpolation failure.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v2:
    
    - try to clarify problem description (John Stultz)
    - simplify fix

 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd5c83473bab..70ecd44fdd9e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1247,7 +1247,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!cycle_between(interval_start, cycles, now) &&
+		    cycles != interval_start) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
-- 
2.39.2

