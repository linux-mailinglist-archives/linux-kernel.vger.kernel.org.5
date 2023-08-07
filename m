Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E39E772DC3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjHGSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjHGSVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:21:02 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA48CFD;
        Mon,  7 Aug 2023 11:21:00 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3af2a06c4c8e8b76; Mon, 7 Aug 2023 20:20:59 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 7DB6F6625B2;
        Mon,  7 Aug 2023 20:20:58 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 04/11] ACPI: thermal: Clean up acpi_thermal_register_thermal_zone()
Date:   Mon, 07 Aug 2023 20:06:13 +0200
Message-ID: <3251836.44csPzL39Z@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

Rename the trips variable in acpi_thermal_register_thermal_zone() to
trip_count so its name better reflects the purpose, rearrange white
space in the loop over active trips for clarity and reduce code
duplication related to calling thermal_zone_device_register() by
using an extra local variable to store the passive delay value.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5: No changes.

v3 -> v4: No changes.

v2 -> v3: No changes.

v1 -> v2: No changes.

---
 drivers/acpi/thermal.c |   36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -740,34 +740,30 @@ static void acpi_thermal_zone_sysfs_remo
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
-	int trips = 0;
+	int passive_delay = 0;
+	int trip_count = 0;
 	int result;
 	acpi_status status;
 	int i;
 
 	if (tz->trips.critical.valid)
-		trips++;
+		trip_count++;
 
 	if (tz->trips.hot.valid)
-		trips++;
-
-	if (tz->trips.passive.valid)
-		trips++;
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid;
-	     i++, trips++);
-
-	if (tz->trips.passive.valid)
-		tz->thermal_zone = thermal_zone_device_register("acpitz", trips, 0, tz,
-								&acpi_thermal_zone_ops, NULL,
-								tz->trips.passive.tsp * 100,
-								tz->polling_frequency * 100);
-	else
-		tz->thermal_zone =
-			thermal_zone_device_register("acpitz", trips, 0, tz,
-						     &acpi_thermal_zone_ops, NULL,
-						     0, tz->polling_frequency * 100);
+		trip_count++;
 
+	if (tz->trips.passive.valid) {
+		trip_count++;
+		passive_delay = tz->trips.passive.tsp * 100;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++)
+		trip_count++;
+
+	tz->thermal_zone = thermal_zone_device_register("acpitz", trip_count, 0,
+							tz, &acpi_thermal_zone_ops,
+							NULL, passive_delay,
+							tz->polling_frequency * 100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 



