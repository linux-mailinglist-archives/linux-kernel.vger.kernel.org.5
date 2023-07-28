Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE1E7669B4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbjG1KDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbjG1KC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:02:29 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F91423B;
        Fri, 28 Jul 2023 03:01:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 5ad84d9e2afdf0c6; Fri, 28 Jul 2023 12:01:58 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C2326661E37;
        Fri, 28 Jul 2023 12:01:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [PATCH v2 1/3] cpuidle: teo: Update idle duration estimate when choosing shallower state
Date:   Fri, 28 Jul 2023 11:58:45 +0200
Message-ID: <13326870.uLZWGnKmhe@kreacher>
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
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rework the code handling the special case when the CPU is utilized and
     there are only 2 idle states (drop the loop, avoid using state 0 when
     the tick has been stopped already and it is too shallow, check if
     state 1 is not disabled when about to use it, set low idle duration
     estimate).
   * Changelog edits.

---
 drivers/cpuidle/governors/teo.c |   43 ++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -397,13 +397,26 @@ static int teo_select(struct cpuidle_dri
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
+		 * which case care needs to be taken to leave the CPU in a
+		 * deep enough state in case it is not woken up any time soon
+		 * after all.
+		 */
+		if (!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+		    teo_time_ok(duration_ns))
+			goto end;
+
+		/*
+		 * Assume that state 1 is not a polling one and select it
+		 * unless it is disabled, in which case state 0 must be used
+		 * no matter what.
+		 */
+		idx = dev->states_usage[1].disable ? 0 : 1;
+		goto end;
 	}
 
 	/*
@@ -539,10 +552,20 @@ static int teo_select(struct cpuidle_dri
 
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



