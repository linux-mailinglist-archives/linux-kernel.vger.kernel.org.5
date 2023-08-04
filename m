Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FD6770ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjHDV0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjHDV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:26:12 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED66E46;
        Fri,  4 Aug 2023 14:26:10 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id cae361074099a2a1; Fri, 4 Aug 2023 23:26:09 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7A7AB661680;
        Fri,  4 Aug 2023 23:26:08 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 04/10] thermal: core: Add thermal_zone_update_trip_temp() helper routine
Date:   Fri, 04 Aug 2023 23:05:40 +0200
Message-ID: <1967710.PYKUYFuaPT@kreacher>
In-Reply-To: <4878513.31r3eYUQgx@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

Introduce a helper routine called thermal_zone_update_trip_temp() that
can be used to update a trip point's temperature with the help of a
pointer to local data associated with that trip point provided by
the thermal driver that created it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v4.

---
 drivers/thermal/thermal_trip.c |   37 +++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |    4 ++++
 2 files changed, 41 insertions(+)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -180,3 +180,40 @@ int thermal_zone_set_trip(struct thermal
 
 	return 0;
 }
+
+/**
+ * thermal_zone_update_trip_temp - Update the trip point temperature.
+ * @tz: Thermal zone.
+ * @trip_priv: Trip tag.
+ * @temp: New trip temperature.
+ *
+ * This only works for thermal zones using trip tables and its caller must
+ * ensure that the zone lock is held before using it.
+ *
+ * @trip_priv is expected to be the value that has been stored by the driver
+ * in the struct thermal_trip representing the trip point in question, so it
+ * can be matched against the value of the priv field in that structure.
+ *
+ * If @trip_priv does not match any trip point in the trip table of @tz,
+ * nothing happens.
+ */
+void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
+				   void *trip_priv, int temperature)
+{
+	int i;
+
+	lockdep_assert_held(&tz->lock);
+
+	if (!tz->trips || !trip_priv)
+		return;
+
+	for (i = 0; i < tz->num_trips; i++) {
+		struct thermal_trip *trip = &tz->trips[i];
+
+		if (trip->priv == trip_priv) {
+			trip->temperature = temperature;
+			return;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(thermal_zone_update_trip_temp);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -286,9 +286,13 @@ int __thermal_zone_get_trip(struct therm
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
+void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
+				   void *trip_priv, int temperature);
 
 int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 			  const struct thermal_trip *trip);
+void thermal_zone_update_trip_temp(struct thermal_zone_device *tz,
+				   void *trip_priv, int temperature);
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 



