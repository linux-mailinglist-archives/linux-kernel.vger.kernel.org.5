Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA776A0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjGaTFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGaTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:04:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7A01707;
        Mon, 31 Jul 2023 12:04:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id e66c7d44df33c50a; Mon, 31 Jul 2023 21:04:53 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EAC776620E2;
        Mon, 31 Jul 2023 21:04:52 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH v3 2/3] cpuidle: teo: Avoid stopping the tick unnecessarily when bailing out
Date:   Mon, 31 Jul 2023 21:03:09 +0200
Message-ID: <10328871.nUPlyArG6x@kreacher>
In-Reply-To: <4515817.LvFx2qVVIh@kreacher>
References: <4515817.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfeduudeutdeugfelffduieegiedtueefledvjeegffdttefhhffhtefhleejgfetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhht
 rhhonhhigidruggvpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghjvghtrghnrdhpuhgthhgrlhhskhhisegrrhhmrdgtohhm
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

In particular, never stop the tick if state 0 is to be returned.

Link: https://lore.kernel.org/linux-pm/CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Cover all of the special cases when 0 is returned and never stop the tick
     in those cases.
   * Do not bail out when constraint_idx becomes the candidate state (it should
     be subject to the usual checks below, because it isn't really special).
   * Be more careful about stopping the tick when the first enabled idle state
     is used.

v1 -> v2: New patch

---
 drivers/cpuidle/governors/teo.c |   56 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -382,12 +382,13 @@ static int teo_select(struct cpuidle_dri
 	/* Check if there is any choice in the first place. */
 	if (drv->state_count < 2) {
 		idx = 0;
-		goto end;
+		goto out_tick;
 	}
+
 	if (!dev->states_usage[0].disable) {
 		idx = 0;
 		if (drv->states[1].target_residency_ns > duration_ns)
-			goto end;
+			goto out_tick;
 	}
 
 	cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
@@ -408,11 +409,12 @@ static int teo_select(struct cpuidle_dri
 		 * anyway.
 		 */
 		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
-		    teo_time_ok(duration_ns)) || dev->states_usage[1].disable)
+		    teo_time_ok(duration_ns)) || dev->states_usage[1].disable) {
 			idx = 0;
-		else /* Assume that state 1 is not a polling one and use it. */
-			idx = 1;
-
+			goto out_tick;
+		}
+		/* Assume that state 1 is not a polling one and use it. */
+		idx = 1;
 		goto end;
 	}
 
@@ -459,8 +461,15 @@ static int teo_select(struct cpuidle_dri
 	/* Avoid unnecessary overhead. */
 	if (idx < 0) {
 		idx = 0; /* No states enabled, must use 0. */
-		goto end;
-	} else if (idx == idx0) {
+		goto out_tick;
+	}
+
+	if (idx == idx0) {
+		/*
+		 * This is the first enabled idle state, so use it, but do not
+		 * allow the tick to be stopped it is shallow enough.
+		 */
+		duration_ns = drv->states[idx].target_residency_ns;
 		goto end;
 	}
 
@@ -566,24 +575,25 @@ static int teo_select(struct cpuidle_dri
 
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
+	/*
+	 * The tick is not going to be stopped, so if the target residency of
+	 * the state to be returned is not within the time till the closest
+	 * timer including the tick, try to correct that.
+	 */
+	if (idx > idx0 &&
+	    drv->states[idx].target_residency_ns > delta_tick)
+		idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
 
+out_tick:
+	*stop_tick = false;
 	return idx;
 }
 



