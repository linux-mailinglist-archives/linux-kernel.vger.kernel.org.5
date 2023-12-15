Return-Path: <linux-kernel+bounces-1591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A37EB81509C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50AF1C2144F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C5547F69;
	Fri, 15 Dec 2023 20:02:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDED46443;
	Fri, 15 Dec 2023 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 6f74b9fbd7fd1d90; Fri, 15 Dec 2023 21:02:17 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B5E8C668B59;
	Fri, 15 Dec 2023 21:02:16 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 2/6] thermal: netlink: Pass pointers to thermal_notify_tz_trip_change()
Date: Fri, 15 Dec 2023 20:56:02 +0100
Message-ID: <2938222.e9J7NaK4W3@kreacher>
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
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of requiring the caller of thermal_notify_tz_trip_change() to
provide specific values needed to populate struct param in it, make it
extract those values from objects passed to it by the caller via const
pointers.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_netlink.c |   12 +++++++-----
 drivers/thermal/thermal_netlink.h |    8 ++++----
 drivers/thermal/thermal_trip.c    |    8 ++------
 3 files changed, 13 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -361,12 +361,14 @@ int thermal_notify_tz_trip_delete(int tz
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_DELETE, &p);
 }
 
-int thermal_notify_tz_trip_change(int tz_id, int trip_id, int trip_type,
-				  int trip_temp, int trip_hyst)
+int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip)
 {
-	struct param p = { .tz_id = tz_id, .trip_id = trip_id,
-			   .trip_type = trip_type, .trip_temp = trip_temp,
-			   .trip_hyst = trip_hyst };
+	struct param p = { .tz_id = tz->id,
+			   .trip_id = thermal_zone_trip_id(tz, trip),
+			   .trip_type = trip->type,
+			   .trip_temp = trip->temperature,
+			   .trip_hyst = trip->hysteresis };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
 }
Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -23,8 +23,8 @@ int thermal_notify_tz_trip_up(int tz_id,
 int thermal_notify_tz_trip_delete(int tz_id, int id);
 int thermal_notify_tz_trip_add(int tz_id, int id, int type,
 			       int temp, int hyst);
-int thermal_notify_tz_trip_change(int tz_id, int id, int type,
-				  int temp, int hyst);
+int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip);
 int thermal_notify_cdev_state_update(int cdev_id, int state);
 int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
 int thermal_notify_cdev_delete(int cdev_id);
@@ -79,8 +79,8 @@ static inline int thermal_notify_tz_trip
 	return 0;
 }
 
-static inline int thermal_notify_tz_trip_change(int tz_id, int id, int type,
-						int temp, int hyst)
+static inline int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
+						const struct thermal_trip *trip)
 {
 	return 0;
 }
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -155,9 +155,7 @@ int thermal_zone_trip_id(const struct th
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
 {
-	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
-				      trip->type, trip->temperature,
-				      trip->hysteresis);
+	thermal_notify_tz_trip_change(tz, trip);
 	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 }
 
@@ -168,8 +166,6 @@ void thermal_zone_set_trip_temp(struct t
 		return;
 
 	trip->temperature = temp;
-	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
-				      trip->type, trip->temperature,
-				      trip->hysteresis);
+	thermal_notify_tz_trip_change(tz, trip);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);




