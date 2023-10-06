Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B037BBDFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjJFRvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJFRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:51:30 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F5C2;
        Fri,  6 Oct 2023 10:51:28 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 822ee62ecd4cce57; Fri, 6 Oct 2023 19:51:27 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CD019665D08;
        Fri,  6 Oct 2023 19:51:26 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 5/6] thermal: gov_step_wise: Fold update_passive_instance() into its caller
Date:   Fri, 06 Oct 2023 19:49:39 +0200
Message-ID: <9177552.CDJkKcVGEf@kreacher>
In-Reply-To: <13365827.uLZWGnKmhe@kreacher>
References: <13365827.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeigdduudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fold update_passive_instance() into thermal_zone_trip_update() that is
its only caller so as to make the code in question easeir to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |   28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -68,17 +68,6 @@ static unsigned long get_target_state(st
 	return next_target;
 }
 
-static void update_passive_instance(struct thermal_zone_device *tz,
-				enum thermal_trip_type type, int value)
-{
-	/*
-	 * If value is +1, activate a passive instance.
-	 * If value is -1, deactivate a passive instance.
-	 */
-	if (type == THERMAL_TRIP_PASSIVE)
-		tz->passive += value;
-}
-
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
 	const struct thermal_trip *trip = &tz->trips[trip_id];
@@ -109,14 +98,17 @@ static void thermal_zone_trip_update(str
 		if (instance->initialized && old_target == instance->target)
 			continue;
 
-		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
-			instance->target != THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip->type, 1);
-		/* Deactivate a passive thermal instance */
-		else if (old_target != THERMAL_NO_TARGET &&
-			instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip->type, -1);
+		    instance->target != THERMAL_NO_TARGET) {
+			/* Activate a passive thermal instance */
+			if (trip->type == THERMAL_TRIP_PASSIVE)
+				tz->passive++;
+		} else if (old_target != THERMAL_NO_TARGET &&
+			   instance->target == THERMAL_NO_TARGET) {
+			/* Deactivate a passive thermal instance */
+			if (trip->type == THERMAL_TRIP_PASSIVE)
+				tz->passive--;
+		}
 
 		instance->initialized = true;
 		mutex_lock(&instance->cdev->lock);



