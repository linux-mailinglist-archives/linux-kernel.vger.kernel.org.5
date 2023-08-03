Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFD376F47B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjHCVL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHCVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:11:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A6E30DB;
        Thu,  3 Aug 2023 14:11:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d1add525cb99f3b2; Thu, 3 Aug 2023 23:11:49 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B77C666241A;
        Thu,  3 Aug 2023 23:11:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Subject: [RFT][PATCH v2 2/3] cpuidle: teo: Skip tick_nohz_get_sleep_length() call in some cases
Date:   Thu, 03 Aug 2023 23:09:18 +0200
Message-ID: <2167194.irdbgypaU6@kreacher>
In-Reply-To: <5712331.DvuYhMxLoT@kreacher>
References: <5712331.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgdduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrnhhnrgdqmhgrrhhirgeslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
 uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrjhgvthgrnhdrphhutghhrghlshhkihesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make teo_select() avoid calling tick_nohz_get_sleep_length() if the
candidate idle state to return is state 0 or if state 0 is a polling
one and the target residency of the current candidate one is below
a certain threshold, in which cases it may be assumed that the CPU will
be woken up immediately by a non-timer wakeup source and the timers
are not likely to matter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/cpuidle/governors/teo.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -166,6 +166,12 @@
  */
 #define NR_RECENT	9
 
+/*
+ * Idle state target residency threshold used for deciding whether or not to
+ * check the time till the closest expected timer event.
+ */
+#define RESIDENCY_THRESHOLD_NS	(15 * NSEC_PER_USEC)
+
 /**
  * struct teo_bin - Metrics used by the TEO cpuidle governor.
  * @intercepts: The "intercepts" metric.
@@ -542,6 +548,22 @@ static int teo_select(struct cpuidle_dri
 			idx = i;
 	}
 
+	/*
+	 * Skip the timers check if state 0 is the current candidate one,
+	 * because an immediate non-timer wakeup is expected in that case.
+	 */
+	if (!idx)
+		goto out_tick;
+
+	/*
+	 * If state 0 is a polling one, check if the target residency of
+	 * the current candidate state is low enough and skip the timers
+	 * check in that case too.
+	 */
+	if ((drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
+	    drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS)
+		goto out_tick;
+
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 



