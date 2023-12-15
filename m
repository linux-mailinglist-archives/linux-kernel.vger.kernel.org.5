Return-Path: <linux-kernel+bounces-1588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418C815090
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4C21F25CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECDD46424;
	Fri, 15 Dec 2023 20:02:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CC45974;
	Fri, 15 Dec 2023 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 74bf26d935cc733f; Fri, 15 Dec 2023 21:02:14 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9014D668B59;
	Fri, 15 Dec 2023 21:02:13 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 6/6] thermal: netlink: Rework cdev-related notify API
Date: Fri, 15 Dec 2023 21:02:04 +0100
Message-ID: <7628882.EvYhyI6sBW@kreacher>
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

The only actually used thermal netlink notification routine related
to cooling devices is thermal_notify_cdev_state_update().  The other
two, thermal_notify_cdev_add() and thermal_notify_cdev_delete(), are
never used.

So as to get rid of dead code, drop thermal_notify_cdev_add/delete(),
which can be added back if they turn out to be ever needed, along with
the related code.

In analogy with the previous thermal netlink API changes, redefine
thermal_notify_cdev_state_update() to take a const cdev pointer as its
first argument and let it extract the requisite information from there
by itself.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_helpers.c |    2 -
 drivers/thermal/thermal_netlink.c |   43 ++------------------------------------
 drivers/thermal/thermal_netlink.h |   19 +++-------------
 3 files changed, 8 insertions(+), 56 deletions(-)

Index: linux-pm/drivers/thermal/thermal_netlink.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.h
+++ linux-pm/drivers/thermal/thermal_netlink.h
@@ -24,9 +24,8 @@ int thermal_notify_tz_trip_up(const stru
 			      const struct thermal_trip *trip);
 int thermal_notify_tz_trip_change(const struct thermal_zone_device *tz,
 				  const struct thermal_trip *trip);
-int thermal_notify_cdev_state_update(int cdev_id, int state);
-int thermal_notify_cdev_add(int cdev_id, const char *name, int max_state);
-int thermal_notify_cdev_delete(int cdev_id);
+int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
+				     int state);
 int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
 				 const char *name);
 int thermal_genl_sampling_temp(int id, int temp);
@@ -76,18 +75,8 @@ static inline int thermal_notify_tz_trip
 	return 0;
 }
 
-static inline int thermal_notify_cdev_state_update(int cdev_id, int state)
-{
-	return 0;
-}
-
-static inline int thermal_notify_cdev_add(int cdev_id, const char *name,
-					  int max_state)
-{
-	return 0;
-}
-
-static inline int thermal_notify_cdev_delete(int cdev_id)
+static inline int thermal_notify_cdev_state_update(const struct thermal_cooling_device *cdev,
+						   int state)
 {
 	return 0;
 }
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -152,7 +152,7 @@ static void thermal_cdev_set_cur_state(s
 	if (cdev->ops->set_cur_state(cdev, target))
 		return;
 
-	thermal_notify_cdev_state_update(cdev->id, target);
+	thermal_notify_cdev_state_update(cdev, target);
 	thermal_cooling_device_stats_update(cdev, target);
 }
 
Index: linux-pm/drivers/thermal/thermal_netlink.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_netlink.c
+++ linux-pm/drivers/thermal/thermal_netlink.c
@@ -147,27 +147,6 @@ static int thermal_genl_event_tz_trip_ch
 	return 0;
 }
 
-static int thermal_genl_event_cdev_add(struct param *p)
-{
-	if (nla_put_string(p->msg, THERMAL_GENL_ATTR_CDEV_NAME,
-			   p->name) ||
-	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
-			p->cdev_id) ||
-	    nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_MAX_STATE,
-			p->cdev_max_state))
-		return -EMSGSIZE;
-
-	return 0;
-}
-
-static int thermal_genl_event_cdev_delete(struct param *p)
-{
-	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID, p->cdev_id))
-		return -EMSGSIZE;
-
-	return 0;
-}
-
 static int thermal_genl_event_cdev_state_update(struct param *p)
 {
 	if (nla_put_u32(p->msg, THERMAL_GENL_ATTR_CDEV_ID,
@@ -244,8 +223,6 @@ static cb_t event_cb[] = {
 	[THERMAL_GENL_EVENT_TZ_TRIP_UP]		= thermal_genl_event_tz_trip_up,
 	[THERMAL_GENL_EVENT_TZ_TRIP_DOWN]	= thermal_genl_event_tz_trip_down,
 	[THERMAL_GENL_EVENT_TZ_TRIP_CHANGE]	= thermal_genl_event_tz_trip_change,
-	[THERMAL_GENL_EVENT_CDEV_ADD]		= thermal_genl_event_cdev_add,
-	[THERMAL_GENL_EVENT_CDEV_DELETE]	= thermal_genl_event_cdev_delete,
 	[THERMAL_GENL_EVENT_CDEV_STATE_UPDATE]	= thermal_genl_event_cdev_state_update,
 	[THERMAL_GENL_EVENT_TZ_GOV_CHANGE]	= thermal_genl_event_gov_change,
 	[THERMAL_GENL_EVENT_CPU_CAPABILITY_CHANGE] = thermal_genl_event_cpu_capability_change,
@@ -348,28 +325,14 @@ int thermal_notify_tz_trip_change(const
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
-{
-	struct param p = { .cdev_id = cdev_id, .name = name,
-			   .cdev_max_state = cdev_max_state };
-
-	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_ADD, &p);
-}
-
-int thermal_notify_cdev_delete(int cdev_id)
-{
-	struct param p = { .cdev_id = cdev_id };
-
-	return thermal_genl_send_event(THERMAL_GENL_EVENT_CDEV_DELETE, &p);
-}
-
 int thermal_notify_tz_gov_change(const struct thermal_zone_device *tz,
 				 const char *name)
 {




