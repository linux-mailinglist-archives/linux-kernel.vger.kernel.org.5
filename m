Return-Path: <linux-kernel+bounces-1594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10618150A7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903AF1F26BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B13F49F82;
	Fri, 15 Dec 2023 20:02:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118845BF1;
	Fri, 15 Dec 2023 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id da677ab86f469e69; Fri, 15 Dec 2023 21:02:16 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D7D91668B59;
	Fri, 15 Dec 2023 21:02:15 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 3/6] thermal: netlink: Pass pointers to thermal_notify_tz_trip_up/down()
Date: Fri, 15 Dec 2023 20:57:50 +0100
Message-ID: <3295756.44csPzL39Z@kreacher>
In-Reply-To: <4556052.LvFx2qVVIh@kreacher>
References: <4556052.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtvddgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of requiring the callers of thermal_notify_tz_trip_up/down() to
provide specific values needed to populate struct param in them, make
them extract those values from objects passed by the callers via const
pointers.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |    8 ++------
 drivers/thermal/thermal_netlink.c |   14 ++++++++++----
 drivers/thermal/thermal_netlink.h |   12 ++++++++----
 3 files changed, 20 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -361,9 +361,7 @@ static void handle_thermal_trip(struct t
 		 * the threshold and the trip temperature will be equal.
 		 */
 		if (tz->temperature >= trip->temperature) {
-			thermal_notify_tz_trip_up(tz->id,
-						  thermal_zone_trip_id(tz, trip),
-						  tz->temperature);
+			thermal_notify_tz_trip_up(tz, trip);
 			trip->threshold = trip->temperature - trip->hysteresis;
 		} else {
 			trip->threshold = trip->temperature;
@@ -380,9 +378,7 @@ static void handle_thermal_trip(struct t
 		 * the trip.
 		 */
 		if (tz->temperature < trip->temperature - trip->hysteresis) {
-			thermal_notify_tz_trip_down(tz->id,
-						    thermal_zone_trip_id(tz, trip),
-						    tz->temperature);
+			thermal_notify_tz_trip_down(tz, trip);
 			trip->threshold = trip->temperature;
 		} else {
 			trip->threshold = trip->temperature - trip->hysteresis;
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -330,16 +330,22 @@ int thermal_notify_tz_disable(int tz_id)
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_DISABLE, &p);
 }
 
-int thermal_notify_tz_trip_down(int tz_id, int trip_id, int temp)
+int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
+				const struct thermal_trip *trip)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
+	struct param p = { .tz_id = tz->id,
+			   .trip_id = thermal_zone_trip_id(tz, trip),
+			   .temp = tz->temperature };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DOWN, &p);
 }
 
-int thermal_notify_tz_trip_up(int tz_id, int trip_id, int temp)
+int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id, .temp = temp };
+	struct param p = { .tz_id = tz->id,
+			   .trip_id = thermal_zone_trip_id(tz, trip),
+			   .temp = tz->temperature };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_UP, &p);
 }
Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -18,8 +18,10 @@ int thermal_notify_tz_create(int tz_id,
 int thermal_notify_tz_delete(int tz_id);
 int thermal_notify_tz_enable(int tz_id);
 int thermal_notify_tz_disable(int tz_id);
-int thermal_notify_tz_trip_down(int tz_id, int id, int temp);
-int thermal_notify_tz_trip_up(int tz_id, int id, int temp);
+int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
+				const struct thermal_trip *trip);
+int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip);
 int thermal_notify_tz_trip_delete(int tz_id, int id);
 int thermal_notify_tz_trip_add(int tz_id, int id, int type,
 			       int temp, int hyst);
@@ -58,12 +60,14 @@ static inline int thermal_notify_tz_disa
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_down(int tz_id, int id, int temp)
+static inline int thermal_notify_tz_trip_down(const struct thermal_zone_device *tz,
+					      const struct thermal_trip *trip)
 {
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_up(int tz_id, int id, int temp)
+static inline int thermal_notify_tz_trip_up(const struct thermal_zone_device *tz,
+					    const struct thermal_trip *trip)
 {
 	return 0;
 }




