Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4896B7669B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjG1KCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjG1KC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:02:29 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE0149CA;
        Fri, 28 Jul 2023 03:01:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id da2d6a680178221d; Fri, 28 Jul 2023 12:01:57 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0B801661E3D;
        Fri, 28 Jul 2023 12:01:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH v2 2/3] cpuidle: teo: Avoid stopping the tick unnecessarily when bailing out
Date:   Fri, 28 Jul 2023 12:00:46 +0200
Message-ID: <3254124.aeNJFYEL58@kreacher>
In-Reply-To: <5707588.DvuYhMxLoT@kreacher>
References: <5707588.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrieeigddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepfhhrvggu
 vghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghjvghtrghnrdhpuhgthhgrlhhskhhisegrrhhmrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

When teo_select() is going to return early in some special cases, make
it avoid stopping the tick if the idle state to be returned is shallow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   50 +++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -462,9 +462,9 @@ static int teo_select(struct cpuidle_dri
 	/* Avoid unnecessary overhead. */
 	if (idx < 0) {
 		idx = 0; /* No states enabled, must use 0. */
-		goto end;
+		goto bail_out;
 	} else if (idx == idx0) {
-		goto end;
+		goto bail_out;
 	}
 
 	/*
@@ -547,8 +547,10 @@ static int teo_select(struct cpuidle_dri
 	 * If there is a latency constraint, it may be necessary to select an
 	 * idle state shallower than the current candidate one.
 	 */
-	if (idx > constraint_idx)
+	if (idx > constraint_idx) {
 		idx = constraint_idx;
+		goto bail_out;
+	}
 
 	/*
 	 * If the CPU is being utilized over the threshold, choose a shallower
@@ -569,23 +571,35 @@ static int teo_select(struct cpuidle_dri
 
 end:
 	/*
-	 * Don't stop the tick if the selected state is a polling one or if the
-	 * expected idle duration is shorter than the tick period length.
+	 * Allow the tick to be stopped unless the selected state is a polling
+	 * one or the expected idle duration is shorter than the tick period
+	 * length.
 	 */
-	if (((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) ||
-	    duration_ns < TICK_NSEC) && !tick_nohz_tick_stopped()) {
-		*stop_tick = false;
+	if ((!(drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
+	    duration_ns >= TICK_NSEC) || tick_nohz_tick_stopped())
+		return idx;
 
-		/*
-		 * The tick is not going to be stopped, so if the target
-		 * residency of the state to be returned is not within the time
-		 * till the closest timer including the tick, try to correct
-		 * that.
-		 */
-		if (idx > idx0 &&
-		    drv->states[idx].target_residency_ns > delta_tick)
-			idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
-	}
+retain_tick:
+	*stop_tick = false;
+
+	/*
+	 * The tick is not going to be stopped, so if the target residency of
+	 * the state to be returned is not within the time till the closest
+	 * timer including the tick, try to correct that.
+	 */
+	if (idx > idx0 &&
+	    drv->states[idx].target_residency_ns > delta_tick)
+		idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
+
+	return idx;
+
+bail_out:
+	/*
+	 * Do not allow the tick to be stopped if the selected state is shallow
+	 * enough.
+	 */
+	if (drv->states[idx].target_residency_ns < TICK_NSEC)
+		goto retain_tick;
 
 	return idx;
 }



