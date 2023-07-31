Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42E76A0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjGaTFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGaTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:04:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986261710;
        Mon, 31 Jul 2023 12:04:55 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d3f93b39a0953369; Mon, 31 Jul 2023 21:04:54 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AAF8A6620E2;
        Mon, 31 Jul 2023 21:04:53 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH v3 1/3] cpuidle: teo: Update idle duration estimate when choosing shallower state
Date:   Mon, 31 Jul 2023 20:56:35 +0200
Message-ID: <13332551.uLZWGnKmhe@kreacher>
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

The TEO governor takes CPU utilization into account by refining idle state
selection when the utilization is above a certain threshold.  This is done by
choosing an idle state shallower than the previously selected one.

However, when doing this, the idle duration estimate needs to be
adjusted so as to prevent the scheduler tick from being stopped when the
candidate idle state is shallow, which may lead to excessive energy
usage if the CPU is not woken up quickly enough going forward.
Moreover, if the scheduler tick has been stopped already and the new
idle duration estimate is too small, the replacement candidate state
cannot be used.

Modify the relevant code to take the above observations into account.

Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
Link: https://lore.kernel.org/linux-pm/CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Make the handling of the "2 idle state and utilized CPU" case more
     straightforward.

v1 -> v2:
   * Rework the code handling the special case when the CPU is utilized and
     there are only 2 idle states (drop the loop, avoid using state 0 when
     the tick has been stopped already and it is too shallow, check if
     state 1 is not disabled when about to use it, set low idle duration
     estimate).
   * Changelog edits.

---
 drivers/cpuidle/governors/teo.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -397,13 +397,23 @@ static int teo_select(struct cpuidle_dri
 	 * the shallowest non-polling state and exit.
 	 */
 	if (drv->state_count < 3 && cpu_data->utilized) {
-		for (i = 0; i < drv->state_count; ++i) {
-			if (!dev->states_usage[i].disable &&
-			    !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
-				idx = i;
-				goto end;
-			}
-		}
+		/* The CPU is utilized, so assume a short idle duration. */
+		duration_ns = teo_middle_of_bin(0, drv);
+		/*
+		 * If state 0 is enabled and it is not a polling one, select it
+		 * right away unless the scheduler tick has been stopped, in
+		 * which case care needs to be taken to leave the CPU in a deep
+		 * enough state in case it is not woken up any time soon after
+		 * all.  If state 1 is disabled, though, state 0 must be used
+		 * anyway.
+		 */
+		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+		    teo_time_ok(duration_ns)) || dev->states_usage[1].disable)
+			idx = 0;
+		else /* Assume that state 1 is not a polling one and use it. */
+			idx = 1;
+
+		goto end;
 	}
 
 	/*
@@ -539,10 +549,20 @@ static int teo_select(struct cpuidle_dri
 
 	/*
 	 * If the CPU is being utilized over the threshold, choose a shallower
-	 * non-polling state to improve latency
+	 * non-polling state to improve latency, unless the scheduler tick has
+	 * been stopped already and the shallower state's target residency is
+	 * not sufficiently large.
 	 */
-	if (cpu_data->utilized)
-		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
+	if (cpu_data->utilized) {
+		s64 span_ns;
+
+		i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
+		span_ns = teo_middle_of_bin(i, drv);
+		if (teo_time_ok(span_ns)) {
+			idx = i;
+			duration_ns = span_ns;
+		}
+	}
 
 end:
 	/*



