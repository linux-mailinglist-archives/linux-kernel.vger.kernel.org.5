Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD51780302
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356881AbjHRBUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356884AbjHRBUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:20:30 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D53AA1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:20:28 -0700 (PDT)
Received: from 104.47.7.170_.trendmicro.com (unknown [172.21.173.48])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7FD3B10000957;
        Fri, 18 Aug 2023 01:20:27 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1692321627.180000
X-TM-MAIL-UUID: 5ac3fad6-cd9f-4767-a423-b48cbaf58391
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.170])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 2C3E510000319;
        Fri, 18 Aug 2023 01:20:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNrEq/ScwxAcNEIk7DrUspPUVMtGdh6B/Wx2H8RZhcIRqYWZLzgX3F22k/QMGnfcrq0tTMyeUjpKXdBT5L2VfmwB+xrD+wtEBd1SjRqrLKNLRp2Ux7vJRyBG3UMpzFfMPSFA2WQptYzaeVVBo1k7op67pmHtVZEBstZgTZvZLBwWOZV1KRtww9qQ5Ud/5g9Mkf5z2gyrE6WkDTWux4RJgn+QpW5KRerhGVFqDONClOY3aCeTAT6bpL/9Ky45O0vobir9NHyfhE2/DDR1fkeDv/8LJSQht4U/bm8huxJ0OFSLemM0lzdvgL6qvvs0YSHIYpVf0COH2WOUUA6ZkBgTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IyoYeEyaUNhEc7xXCo7Bh4M/WZK/8nxQR7tQt+aZ4ZE=;
 b=VA2CYK/vdzll11+AGZiQxp4HbjaxMI+YURLQdOWKb8Dgp2FTgNG//SoLPX/T9yo6x4ydYtJ8m3q5f1DqgBmEZg4gVJqnzPq4OoxFkAkAE5ZGjo/4VWQ9GKhQJEk8xOWdZRbM6++GbuwK0eVm4pazbY7EHgiQUEMwbAV95VivwWmlC6Qdqshple4lQWSX+WI6LSBW3rT4lRddDjG8RAD/gIpwNNc7c5kxdWwAqbszuVmDIP9d/9CUEkK0trkrNnnhmSBcH3RawrazhGJcIJvDmWC/QBkQxc1JbIUrrJ1WFzbW3RTEa4uKo0f7oPzbNTXpZbZVhpWfeHjcYFuW5/muZg==
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
Subject: [RFC PATCH v2 3/6] timekeeping: Fix cross-timestamp interpolation for non-x86
Date:   Fri, 18 Aug 2023 03:20:09 +0200
Message-Id: <20230818012014.212155-4-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818012014.212155-1-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT061:EE_|FR3P281MB1888:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a31d7ae5-7591-4dc8-b0e3-08db9f894d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxNN6+0fR7tMDU7G53s0C7fSkB1ywfPDkGfJP4lCfjnxzFIw6ihGp7zTA7uZL0CAj5St6tV0KiP684K50vR6ebsDgKCN+CDORvUvd/6Th9UCZIrDc2cLSVMOejsw7GZcmOGt2LX5YtEx4I9TOP2ukocdTbKYZXYoIblnx28cobtmwOoQzfRCfXR8xc0ZNk+zTPIlUknNEu6UzaD1kxCeapQATkMx3cznNsXuLFp5JiYRlMCh0omDt5t0DnBQ4H2NRlqz6TIls1NPPiCm1WeJa09p59IM0LW5vLeiguG7wPLjW+sjOf6eFKquTIqapex8ZU7b2i6cjl+BI2VVUWQKHnuJ0jhlDI3vg9p5elqYteDFqHhXrCa7GrCDVtlNfi2J+DrseburqoubgAh4mGdvvfbBReDTEvO0pn1mCmK2wjWdEIV53T0tmGn6sFqA3UIFdb4kuoJHz9gR2pOdO6+4Y0dsUPAvpGhh7nM91fBq1LmH2YgzdMBDwf+2ozk0M5m3fZHLohlYNLJpcxEVoFWw4vCLiUmfi9tmXLidu53WZuQP750H4ZS4qig7fOAUDwQyum5URPd2NvmI122nf4A2KBOi7dVIzshBV56eNCF+DDiWyQn4qgdBjvmIRoSoqbEuvVp/a8W1hcJWYmEZ17GEPAEHWtMXG1YV6OJdVuE9kO2m/0XVb4RJVNj4T5IsPuR8kY1a+NkOYiwYPM1ouv2D+88474WnOQPRn9oo19BDYWuqw1L0sG/ETGw+bIIAaUxyU2knCfk9A8Q6qs3YHzjSA53q9+/r1nLbZrfQWv1j0QeJ8cYUhI8Vyi9rYIiMNHi1
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39840400004)(396003)(376002)(346002)(186009)(82310400011)(1800799009)(451199024)(46966006)(36840700001)(83380400001)(336012)(81166007)(86362001)(36756003)(47076005)(36860700001)(1076003)(40480700001)(26005)(2616005)(8936002)(8676002)(4326008)(41300700001)(54906003)(70206006)(70586007)(42186006)(6916009)(2906002)(316002)(5660300002)(478600001)(12101799020)(44832011)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:20:25.5680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31d7ae5-7591-4dc8-b0e3-08db9f894d26
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT061.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1888
X-TM-AS-ERS: 104.47.7.170-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27820.003
X-TMASE-Result: 10--4.470100-4.000000
X-TMASE-MatchedRID: HRakA6U45i9eKR/wKUhyN50UyaWO1QCnDNB/jaV2d3ufOd3yw6VkrA9M
        5f/N3N4Qthzaop7IM7sxRT5xs1+q/LIfFXYUihhJ9uL5hOvaG1KVmuhG06IIbTji23k3pyJLKLe
        iMOXj8x0HZRiBZseHrIiu7wRb1ji7rddi2w4fb9BFg2HO5lmNEA2LmwHT7i+ne+Z7fwZVhv9PQF
        Fk0j5jBsA2iDfbpfy+AVpeDm8nJoLwnQHFZbUP3moEkqixPwVYOfEmq6feyfNuRXh7bFKB7qQ26
        IlKH7c99wtnettYUaDtgUD0+uDQG1nQn7qOr8tPNkUSDDq742k=
X-TMASE-XGENCLOUD: e2ac47e1-4214-4fde-b2d0-063730e78a74-0-0-200-0
X-TM-Deliver-Signature: A7B208B6AAAB52DBD0A04F13F3AC00D0
X-TM-Addin-Auth: CXU7HUe1WK1YFSwPgWyLeJJsk3RoZcyP2ZBBlU7eRkCSvHtln92GVzdlCGq
        BkfYniX47G2+5yM0uRroQOZgyOyuXoW4AJ4T0tDBm8Eu13f/h8AQIG1kdVVtIk4SqVppmQeQpkN
        Nz1INeJ8YxxY5EBb489ry4ab//WOPuZl5m6W/lBREZq4ntik3HScDiRR8lLqF+uOgDT/z3NpBWw
        4SwWijz2tMgYpnxGAxidiEB0uMOEf85BD9DpeV99Qg9OYEbtGZgnvEFXcHEvWT91sQhh92i1fW6
        cuWIAoGusDe0d14=.QrafzPfSytMbMiZ+kwA4Gl5AookW0vjOzWqbTwaya8cMHCedNT3zgzgl3m
        wQmgzEvhCiSluZhSJ11AyKVAhJuABfGIHPblySJZFfu00z9Z/gNK9PNzfoVACYBBhJEi8pf6ib/
        YBcjmPzmZyCUXHqx9Z59tcP+ZFH4cQKtEgJSkGyfxOeUl6jSAg/Y4U43BY0hZWm+gTbVlOR3r9d
        iiuqK2k6hQadGPRenr0kLHjh1GnCiDbsPJl0cWbgeZVAr+leES8N0ihCkWDfEHJx1E/2efjfDF6
        QOOuqacxjmYaxYpiyLcLTwFul3Bevf3LBaOl0xtOksL2/GalYI7GvvuL8BA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1692321627;
        bh=Be7mQghh9edYjnOuv6vxfkJN9HfA94k/Ssk/X4OjkkI=; l=2083;
        h=From:To:Date;
        b=ZQ4SWX6JjSnpWr4cLSqK90fLLDqcw5P3Bz+b7sMNqME4bcPdvR+spcW3tfIBP8oks
         bOHHctV+EN0Co+w0B9U8+VBWXpsgbx70Ldd9pexV5KkEEaJWFwWQBw8sESt+9tn4gp
         SSm0u6MOcyh5GUrkQIL3QS8OZD9NYFjI0kI7G1G7Y7R9/C9LnZWS+pyyj1BHkYF98s
         oWV4um5UuyNkDzungFlqwIetaGZovb6DQZkzUyclA2YlQBrhzskj8A5hB7oCkfrBD2
         temt6/6FDhnB0IH2irjKk1wU6BkQg5cI+H7Ft3/m+WNwomVP2lCVQ+QmjZ4vd6Rvs2
         DFpo7TJssiPXw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, get_device_system_crosststamp() unconditionally passes
system_counterval.cycles to timekeeping_cycles_to_ns(). But when
interpolating system time (do_interp == true), system_counterval.cycles is
before tkr_mono.cycle_last, contrary to the timekeeping_cycles_to_ns()
expectations.

On x86, CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE will mitigate on
interpolating, setting delta to 0. With delta == 0, xtstamp->sys_monoraw
and xtstamp->sys_realtime are then set to the last update time, as
implicitly expected by adjust_historical_crosststamp(). On other
architectures, the resulting nonsense xtstamp->sys_monoraw and
xtstamp->sys_realtime corrupt the xtstamp (ts) adjustment in
adjust_historical_crosststamp().

Fix this by deriving xtstamp->sys_monoraw and xtstamp->sys_realtime from
the last update time when interpolating, by using the local variable
"cycles". The local variable already has the right value when
interpolating, unlike system_counterval.cycles.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---

Notes:
    v2:
    
    - simplify fix (John Stultz)

 kernel/time/timekeeping.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 70ecd44fdd9e..c145601ea062 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1261,10 +1261,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
 				      tk_core.timekeeper.offs_real);
 		base_raw = tk->tkr_raw.base;
 
-		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono,
-						     system_counterval.cycles);
-		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw,
-						    system_counterval.cycles);
+		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, cycles);
+		nsec_raw = timekeeping_cycles_to_ns(&tk->tkr_raw, cycles);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	xtstamp->sys_realtime = ktime_add_ns(base_real, nsec_real);
-- 
2.39.2

