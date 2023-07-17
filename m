Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E74756BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGQSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjGQSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383412A;
        Mon, 17 Jul 2023 11:20:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297F6611F9;
        Mon, 17 Jul 2023 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E68BC433AB;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=rjWu88ZInJ4JHuHDuFwXlfJM5irHmICbqQMPaTiPJrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEdtDlDdtsm4f4+b40C0oOQzkiSZJU0C/5DEMh5WPQ73XD56n52u3rs8cW9pvRDb7
         iF9LnrMCv9gB4K3mqVpe6uvusmeOcCZ5m2QnatwWtv1Qhw0uBguiUI1Jg36qviyygR
         05HTvrAk1jm6sjrJOmAiVQjL3+2Hb29TFhX4zT/pzsA4NpQj+mgiLfN8fQdsycfa9e
         4O2VI/fJp+8UnPcTPGE/5Y4uXiREqdvwDCTV6GmQZaz+Vqg9ys3ZHcP3XO1fJlfvgT
         lQ4GHi8fFPuwNaEjGIoHUmIhSmOgXJNPfdnKqCwJLKTlhlOgt7h0M7PxflS/mP48k2
         uMIu+Wkzlyz5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9B20ECE093C; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/9] torture: Stop right-shifting torture_random() return values
Date:   Mon, 17 Jul 2023 11:20:41 -0700
Message-Id: <20230717182042.1098651-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
References: <bca717ca-a83a-4540-80ec-732c12623d2d@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that torture_random() uses swahw32(), its callers no longer see
not-so-random low-order bits, as these are now swapped up into the upper
16 bits of the torture_random() function's return value.  This commit
therefore removes the right-shifting of torture_random() return values.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 92704f04a141..b59eb6048eab 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -95,7 +95,7 @@ int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_s
 	ktime_t hto = baset_ns;
 
 	if (trsp)
-		hto += (torture_random(trsp) >> 3) % fuzzt_ns;
+		hto += torture_random(trsp) % fuzzt_ns;
 	set_current_state(TASK_IDLE);
 	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
 }
@@ -365,7 +365,7 @@ torture_onoff(void *arg)
 			torture_hrtimeout_jiffies(HZ / 10, &rand);
 			continue;
 		}
-		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
+		cpu = torture_random(&rand) % (maxcpu + 1);
 		if (!torture_offline(cpu,
 				     &n_offline_attempts, &n_offline_successes,
 				     &sum_offline, &min_offline, &max_offline))
-- 
2.40.1

