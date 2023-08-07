Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4FC772DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjHGSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjHGSVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:21:00 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7DFE50;
        Mon,  7 Aug 2023 11:20:58 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 150a4115505eee88; Mon, 7 Aug 2023 20:20:56 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 46A036625B2;
        Mon,  7 Aug 2023 20:20:56 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 07/11] thermal: core: Rework and rename __for_each_thermal_trip()
Date:   Mon, 07 Aug 2023 20:11:07 +0200
Message-ID: <3755730.kQq0lBPeGt@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rework the currently unused __for_each_thermal_trip() to pass original
pointers to struct thermal_trip objects to the callback, so it can be
used for updating trip data (e.g. temperatures), rename it to
for_each_thermal_trip() and make it available to modular drivers.

Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v5.

---
 drivers/thermal/thermal_core.h |    4 ----
 drivers/thermal/thermal_trip.c |   18 ++++++++----------
 include/linux/thermal.h        |    3 +++
 3 files changed, 11 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -54,10 +54,6 @@ int for_each_thermal_cooling_device(int
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
-int __for_each_thermal_trip(struct thermal_zone_device *,
-			    int (*cb)(struct thermal_trip *, void *),
-			    void *);
-
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
 struct thermal_attr {
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -9,28 +9,26 @@
  */
 #include "thermal_core.h"
 
-int __for_each_thermal_trip(struct thermal_zone_device *tz,
-			    int (*cb)(struct thermal_trip *, void *),
-			    void *data)
+int for_each_thermal_trip(struct thermal_zone_device *tz,
+			  int (*cb)(struct thermal_trip *, void *),
+			  void *data)
 {
 	int i, ret;
-	struct thermal_trip trip;
 
 	lockdep_assert_held(&tz->lock);
 
-	for (i = 0; i < tz->num_trips; i++) {
+	if (!tz->trips)
+		return -ENODATA;
 
-		ret = __thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			return ret;
-
-		ret = cb(&trip, data);
+	for (i = 0; i < tz->num_trips; i++) {
+		ret = cb(&tz->trips[i], data);
 		if (ret)
 			return ret;
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(for_each_thermal_trip);
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 {
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -290,6 +290,9 @@ int thermal_zone_get_trip(struct thermal
 int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 			  const struct thermal_trip *trip);
 
+int for_each_thermal_trip(struct thermal_zone_device *tz,
+			  int (*cb)(struct thermal_trip *, void *),
+			  void *data);
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);



