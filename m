Return-Path: <linux-kernel+bounces-53973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1784A89F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CE1F29152
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EE524DD;
	Mon,  5 Feb 2024 21:21:21 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66BB50246;
	Mon,  5 Feb 2024 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168080; cv=none; b=U5hGBVAG6qeqoNHzUziILs7JKd4REm79Z4h3b5D0D5bQabbQhf4oKncOIdBs4+PkmRwzip8MgZz0bM5J0EUFu2wz82SPbvHJFTR6n3NJwD9FMJKXQ6Cd0ai7BOwCS0bLYD5/Rb82VmdEMnxkW5LLNs2PsCBKAWkbJUwLd7J/UX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168080; c=relaxed/simple;
	bh=av3tnbxbDoQCPJZmNhCPyBdCwso6X1qrV0D//DxT7HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKrkRN/2GS29ozipooyeS53MeBpFPiV0kY6DooUh9ciKwaoXf8yafCsu5Rt5a7htlUxq5LWCnKpEvZrTeBOtDCpy3MIK+l2ZPcrSax5+Z9gHT/cCMiEzqYK7ChIJXnXezTbHyiFkbPcko8fOba0v2HMOVNeQ2wWrtoby76NU0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e244b6757259a813; Mon, 5 Feb 2024 22:21:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A7E0E669A1B;
	Mon,  5 Feb 2024 22:21:09 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v1 1/6] thermal: core: Store zone trips table in struct
 thermal_zone_device
Date: Mon, 05 Feb 2024 22:14:31 +0100
Message-ID: <5762433.DvuYhMxLoT@kreacher>
In-Reply-To: <2728491.mvXUDI8C0e@kreacher>
References: <2728491.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code requires thermal zone creators to pass a pointer to a
writable trips table to thermal_zone_device_register_with_trips() and
that trips table is then used by the thermal core going forward.

Consequently, the callers of thermal_zone_device_register_with_trips()
are required to hold on to the trips table passed to it until the given
thermal zone is unregistered, at which point the trips table can be
freed, but at the same time they are not allowed to access the cells in
that table directly.  This is both error prone and confusing.

To address it, turn the trips table pointer in struct thermal_zone_device
into a flex array (counted by its num_trips field), allocate it during
thermal zone device allocation and copy the contents of the trips table
supplied by the zone creator (which can be const now) into it.

This allows the callers of thermal_zone_device_register_with_trips() to
drop their trip tables right after the zone registration.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   16 +++++++++-------
 include/linux/thermal.h        |   10 +++++-----
 2 files changed, 14 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -130,7 +130,6 @@ struct thermal_cooling_device {
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
- * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
@@ -160,6 +159,7 @@ struct thermal_cooling_device {
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
  * @suspended: thermal zone suspend indicator
+ * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {
 	int id;
@@ -172,7 +172,6 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
-	struct thermal_trip *trips;
 	int num_trips;
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
@@ -193,10 +192,11 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	bool suspended;
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-	bool suspended;
+	struct thermal_trip trips[] __counted_by(num_trips);
 };
 
 /**
@@ -315,7 +315,7 @@ int thermal_zone_get_crit_temp(struct th
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
-					struct thermal_trip *trips,
+					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
 					struct thermal_zone_device_ops *ops,
@@ -375,7 +375,7 @@ void thermal_zone_device_critical(struct
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
-					struct thermal_trip *trips,
+					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
 					struct thermal_zone_device_ops *ops,
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1272,10 +1272,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
-					void *devdata, struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp, int passive_delay,
-					int polling_delay)
+thermal_zone_device_register_with_trips(const char *type,
+					const struct thermal_trip *trips,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	int id;
@@ -1322,7 +1325,7 @@ thermal_zone_device_register_with_trips(
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
-	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
+	tz = kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
@@ -1344,7 +1347,6 @@ thermal_zone_device_register_with_trips(
 		result = id;
 		goto free_tzp;
 	}
-
 	tz->id = id;
 	strscpy(tz->type, type, sizeof(tz->type));
 
@@ -1354,7 +1356,7 @@ thermal_zone_device_register_with_trips(
 	tz->ops = ops;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
-	tz->trips = trips;
+	memcpy(tz->trips, trips, num_trips * sizeof(trips[0]));
 	tz->num_trips = num_trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);




