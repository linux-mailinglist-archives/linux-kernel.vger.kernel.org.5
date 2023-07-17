Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA37E756BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjGQSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGQSUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 14:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5141A10D9;
        Mon, 17 Jul 2023 11:20:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B210E611ED;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16608C433D9;
        Mon, 17 Jul 2023 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689618044;
        bh=sBPRM0sRIpbE6zvq9jaA1AWHNVj70yVAkkvNX0VwPQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7sDl/2TGu3C45dkI0F4XlyVjTIewa8HrGGM02f8RgU52YHwQIvUdt258iRQNEm07
         1FEHY4Sey3+dPfRnWR5l4rBPoEyH35xaoG4NtYBFi05CqQYLYejMMCZtf+WY/pYitY
         KmBso4AwVMnl3T1YpW4hK6NkH3ifnoMqdq6On8/uluQmg3Ux/jQnZU8r8yi2UbD4Uw
         Wsr5KU2WVaKk3NRUxAoZ3uYA5U5dkHXP2OiFFSUF+ARnPawDno261V91VCR3zd09Cz
         X7IiGC4Mw7WexuHXpj2NBMX2f0v0hksb2CJ5D7ZRnOyKcz7qL3qBpVK7hjTYd37MH2
         7pt0mQiFgQWUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9510DCE0902; Mon, 17 Jul 2023 11:20:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/9] torture: Move torture_onoff() timeouts to hrtimers
Date:   Mon, 17 Jul 2023 11:20:38 -0700
Message-Id: <20230717182042.1098651-5-paulmck@kernel.org>
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

In order to gain better race coverage, move the CPU-hotplug-related
timed waits in torture_onoff() to torture_hrtimeout_jiffies().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 836fefa44373..fc873116a399 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -357,12 +357,12 @@ torture_onoff(void *arg)
 
 	if (onoff_holdoff > 0) {
 		VERBOSE_TOROUT_STRING("torture_onoff begin holdoff");
-		schedule_timeout_interruptible(onoff_holdoff);
+		torture_hrtimeout_jiffies(onoff_holdoff, &rand);
 		VERBOSE_TOROUT_STRING("torture_onoff end holdoff");
 	}
 	while (!torture_must_stop()) {
 		if (disable_onoff_at_boot && !rcu_inkernel_boot_has_ended()) {
-			schedule_timeout_interruptible(HZ / 10);
+			torture_hrtimeout_jiffies(HZ / 10, &rand);
 			continue;
 		}
 		cpu = (torture_random(&rand) >> 4) % (maxcpu + 1);
@@ -372,7 +372,7 @@ torture_onoff(void *arg)
 			torture_online(cpu,
 				       &n_online_attempts, &n_online_successes,
 				       &sum_online, &min_online, &max_online);
-		schedule_timeout_interruptible(onoff_interval);
+		torture_hrtimeout_jiffies(onoff_interval, &rand);
 	}
 
 stop:
-- 
2.40.1

