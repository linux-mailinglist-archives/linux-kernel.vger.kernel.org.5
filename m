Return-Path: <linux-kernel+bounces-21181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C20828B66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD45B24819
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C263BB31;
	Tue,  9 Jan 2024 17:43:40 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9A3B781;
	Tue,  9 Jan 2024 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 2c79272305610631; Tue, 9 Jan 2024 17:43:36 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 255DF669107;
	Tue,  9 Jan 2024 17:43:36 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 1/2] thermal: netlink: Rework notify API for cooling devices
Date: Tue, 09 Jan 2024 17:42:04 +0100
Message-ID: <3293702.aeNJFYEL58@kreacher>
In-Reply-To: <2193991.irdbgypaU6@kreacher>
References: <2193991.irdbgypaU6@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehledgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghp
 thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In analogy with some previous thermal netlink API changes, redefine
thermal_notify_cdev_state_update(), thermal_notify_cdev_add() and
thermal_notify_cdev_delete() to take a const cdev pointer as their
first argument and let them extract the requisite information from
there by themselves.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c |    2 +-
 drivers/thermal/thermal_netlink.c |   15 ++++++++-------
 drivers/thermal/thermal_netlink.h |   16 +++++++++-------
 3 files changed, 18 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -12,6 +12,7 @@ struct thermal_genl_cpu_caps {
 
 struct thermal_zone_device;
 struct thermal_trip;
+struct thermal_cooling_device;
 
 /* Netlink notification function */
 #ifdef CONFIG_THERMAL_NETLINK
@@ -27,9 +28,10 @@ int thermal_notify_tz_trip_up(const stru
 			      const struct thermal_trip *trip);
 int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip);
-int thermal_notify_cdev_state_update(int cdev_id, int state);
-int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
-int thermal_notify_cdev_delete(int cdev_id);
+int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
+				     int state);
+int thermal_notify_cdev_add(const struct thermal_cooling_device *cdev);
+int thermal_notify_cdev_delete(const struct thermal_cooling_device *cdev);
 int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
 				 const char *name);
 int thermal_genl_sampling_temp(int id, int temp);
@@ -79,18 +81,18 @@ static inline int thermal_notify_tz_trip
 	return 0;
 }
 
-static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
+static inline int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
+						   int state)
 {
 	return 0;
 }
 
-static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
-					  int max_state)
+static inline int thermal_notify_cdev_add(const struct thermal_cooling_device *cdev)
 {
 	return 0;
 }
 
-static inline int thermal_notify_cdev_delete(int cdev_id)
+static inline int thermal_notify_cdev_delete(const struct thermal_cooling_device *cdev)
 {
 	return 0;
 }
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -364,24 +364,25 @@ int thermal_notify_tz_trip_change(const
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_TZ_TRIP_CHANGE, &p);
 }
 
-int thermal_notify_cdev_state_update(int cdev_id, int cdev_state)
+int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
+				     int state)
 {
-	struct param p = { .cdev_id = cdev_id, .cdev_state = cdev_state };
+	struct param p = { .cdev_id = cdev->id, .cdev_state = state };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_STATE_UPDATE, &p);
 }
 
-int thermal_notify_cdev_add(int cdev_id, const char *name, int cdev_max_state)
+int thermal_notify_cdev_add(const struct thermal_cooling_device *cdev)
 {
-	struct param p = { .cdev_id = cdev_id, .name = name,
-			   .cdev_max_state = cdev_max_state };
+	struct param p = { .cdev_id = cdev->id, .name = cdev->type,
+			   .cdev_max_state = cdev->max_state };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_ADD, &p);
 }
 
-int thermal_notify_cdev_delete(int cdev_id)
+int thermal_notify_cdev_delete(const struct thermal_cooling_device *cdev)
 {
-	struct param p = { .cdev_id = cdev_id };
+	struct param p = { .cdev_id = cdev->id };
 
 	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
 }
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -156,7 +156,7 @@ static int thermal_cdev_set_cur_state(st
 	 */
 	ret = cdev->ops->set_cur_state(cdev, state);
 	if (!ret) {
-		thermal_notify_cdev_state_update(cdev->id, state);
+		thermal_notify_cdev_state_update(cdev, state);
 		thermal_cooling_device_stats_update(cdev, state);
 		thermal_debug_cdev_state_update(cdev, state);
 	}




