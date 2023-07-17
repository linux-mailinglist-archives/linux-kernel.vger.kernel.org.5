Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC0A756C11
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGQS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGQS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:28:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E5138
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E7F6611E6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE184C433C7;
        Mon, 17 Jul 2023 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618496;
        bh=zuvEkykktJjeNi58BabdAm26lxVTmrSjYHv8G+zZ144=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6uGZlSt6oa3niWcm26Tf+FRjgeRnOcrzH4HYSGaFsuJFKV0gupUKtuBA73MLGMlb
         moQ9VD2qqSnss5FD+hpJ5c1oW5NUbxH0DBUnxwvDa62z0ulq3oLz6mPTo/4VBWbKPm
         5XyDSH3h6YK+Pfv8rSyZvDTfjoaCpKWP4qvN6lfQDfkTB+dZCXLtMuZprX/A5UEAG4
         9Ei9rj4afwYBacMQRinO75Sve3m24By2pZH+QS4VwdJT5BKs8eRwGhqns90D9REVst
         0/gqvK8DDgx5ZOzGYeAPQ2jHLtiVdJTQ3SgGIuZ/kTRIxAtyN4JFg++OMR1HKtfIzL
         /iVsLUhS2S/6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1C0ACE03F1; Mon, 17 Jul 2023 11:28:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        daniel.lezcano@linaro.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH clocksource 1/2] clocksource: Handle negative skews in "skew is too large" messages
Date:   Mon, 17 Jul 2023 11:28:13 -0700
Message-Id: <20230717182814.1099419-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db4a845e-5f87-4aee-8957-150c253f67e7@paulmck-laptop>
References: <db4a845e-5f87-4aee-8957-150c253f67e7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nanosecond-to-millisecond skew computation uses unsigned arithmetic,
which produces user-unfriendly large positive numbers for negative skews.
Therefore, use signed arithmetic for this computation in order to preserve
the negativity.

Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Reported-by: Feng Tang <feng.tang@intel.com>
Fixes: dd029269947a ("clocksource: Improve "skew is too large" messages")
Reviewed-by: Feng Tang <feng.tang@intel.com>
Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 88cbc1181b23..c108ed8a9804 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -473,8 +473,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
 		if (abs(cs_nsec - wd_nsec) > md) {
-			u64 cs_wd_msec;
-			u64 wd_msec;
+			s64 cs_wd_msec;
+			s64 wd_msec;
 			u32 wd_rem;
 
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
@@ -483,8 +483,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wd_nsec, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_nsec: %lld cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, cs_nsec, csnow, cslast, cs->mask);
-			cs_wd_msec = div_u64_rem(cs_nsec - wd_nsec, 1000U * 1000U, &wd_rem);
-			wd_msec = div_u64_rem(wd_nsec, 1000U * 1000U, &wd_rem);
+			cs_wd_msec = div_s64_rem(cs_nsec - wd_nsec, 1000 * 1000, &wd_rem);
+			wd_msec = div_s64_rem(wd_nsec, 1000 * 1000, &wd_rem);
 			pr_warn("                      Clocksource '%s' skewed %lld ns (%lld ms) over watchdog '%s' interval of %lld ns (%lld ms)\n",
 				cs->name, cs_nsec - wd_nsec, cs_wd_msec, watchdog->name, wd_nsec, wd_msec);
 			if (curr_clocksource == cs)
-- 
2.40.1

