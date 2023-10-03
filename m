Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559097B6A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjJCN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbjJCN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:26:53 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5AAB;
        Tue,  3 Oct 2023 06:26:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id a243c055453c96a8; Tue, 3 Oct 2023 15:26:48 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F01D96659AF;
        Tue,  3 Oct 2023 15:26:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 3/6] ACPI: thermal: Combine passive and active trip update functions
Date:   Tue, 03 Oct 2023 15:21:30 +0200
Message-ID: <8288399.T7Z3S40VBb@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
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

Combine acpi_thermal_update_passive_trip() and
acpi_thermal_update_active_trip() into one common function called
acpi_thermal_update_trip(), so as to reduce code duplication and
prepare the code in question for subsequent changes.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -212,14 +212,25 @@ static long get_active_temp(struct acpi_
 	return tmp;
 }
 
-static void acpi_thermal_update_passive_trip(struct acpi_thermal *tz)
+static void acpi_thermal_update_trip(struct acpi_thermal *tz,
+				     int index)
 {
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
+	struct acpi_thermal_trip *acpi_trip;
 
-	if (!acpi_thermal_trip_valid(acpi_trip) || psv > 0)
+	acpi_trip = index == ACPI_THERMAL_TRIP_PASSIVE ?
+			&tz->trips.passive.trip : &tz->trips.active[index].trip;
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	acpi_trip->temp_dk = get_passive_temp(tz);
+	if (index == ACPI_THERMAL_TRIP_PASSIVE) {
+		if (psv > 0)
+			return;
+
+		acpi_trip->temp_dk = get_passive_temp(tz);
+	} else {
+		acpi_trip->temp_dk = get_active_temp(tz, index);
+	}
+
 	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
@@ -273,18 +284,6 @@ static void acpi_thermal_update_trip_dev
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
-static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
-{
-	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
-
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		return;
-
-	acpi_trip->temp_dk = get_active_temp(tz, index);
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
-}
-
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
@@ -308,9 +307,9 @@ static void acpi_thermal_adjust_thermal_
 	int i;
 
 	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
-		acpi_thermal_update_passive_trip(tz);
+		acpi_thermal_update_trip(tz, ACPI_THERMAL_TRIP_PASSIVE);
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_active_trip(tz, i);
+			acpi_thermal_update_trip(tz, i);
 	} else {
 		acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
 		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)




