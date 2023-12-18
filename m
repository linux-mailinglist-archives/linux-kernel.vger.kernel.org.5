Return-Path: <linux-kernel+bounces-4296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAB4817B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53781C229B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E172063;
	Mon, 18 Dec 2023 19:28:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4FC3A1A2;
	Mon, 18 Dec 2023 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 460afc62fea5e008; Mon, 18 Dec 2023 20:28:42 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AD04C668C31;
	Mon, 18 Dec 2023 20:28:41 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Bo Ye <bo.ye@mediatek.com>, Radu Solea <radusolea@google.com>
Subject: [PATCH v1 1/3] thermal: core: Fix thermal zone suspend-resume synchronization
Date: Mon, 18 Dec 2023 20:25:02 +0100
Message-ID: <4896849.31r3eYUQgx@kreacher>
In-Reply-To: <5751163.DvuYhMxLoT@kreacher>
References: <5751163.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhi
 rdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are 3 synchronization issues with thermal zone suspend-resume
during system-wide transitions:

 1. The resume code runs in a PM notifier which is invoked after user
    space has been thawed, so it can run concurrently with user space
    which can trigger a thermal zone device removal.  If that happens,
    the thermal zone resume code may use a stale pointer to the next
    list element and crash, because it does not hold thermal_list_lock
    while walking thermal_tz_list.

 2. The thermal zone resume code calls thermal_zone_device_init()
    outside the zone lock, so user space or an update triggered by
    the platform firmware may see an inconsistent state of a
    thermal zone leading to unexpected behavior.

 3. Clearing the in_suspend global variable in thermal_pm_notify()
    allows __thermal_zone_device_update() to continue for all thermal
    zones and it may as well run before the thermal_tz_list walk (or
    at any point during the list walk for that matter) and attempt to
    operate on a thermal zone that has not been resumed yet.  It may
    also race destructively with thermal_zone_device_init().

To address these issues, add thermal_list_lock locking to
thermal_pm_notify(), especially arount the thermal_tz_list,
make it call thermal_zone_device_init() back-to-back with
__thermal_zone_device_update() under the zone lock and replace
in_suspend with per-zone bool "suspend" indicators set and unset
under the given zone's lock.

Link: https://lore.kernel.org/linux-pm/20231218162348.69101-1-bo.ye@mediatek.com/
Reported-by: Bo Ye <bo.ye@mediatek.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   30 +++++++++++++++++++++++-------
 include/linux/thermal.h        |    2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -37,8 +37,6 @@ static LIST_HEAD(thermal_governor_list);
 static DEFINE_MUTEX(thermal_list_lock);
 static DEFINE_MUTEX(thermal_governor_lock);
 
-static atomic_t in_suspend;
-
 static struct thermal_governor *def_governor;
 
 /*
@@ -427,7 +425,7 @@ void __thermal_zone_device_update(struct
 {
 	struct thermal_trip *trip;
 
-	if (atomic_read(&in_suspend))
+	if (tz->suspended)
 		return;
 
 	if (!thermal_zone_device_is_enabled(tz))
@@ -1538,17 +1536,35 @@ static int thermal_pm_notify(struct noti
 	case PM_HIBERNATION_PREPARE:
 	case PM_RESTORE_PREPARE:
 	case PM_SUSPEND_PREPARE:
-		atomic_set(&in_suspend, 1);
+		mutex_lock(&thermal_list_lock);
+
+		list_for_each_entry(tz, &thermal_tz_list, node) {
+			mutex_lock(&tz->lock);
+
+			tz->suspended = true;
+
+			mutex_unlock(&tz->lock);
+		}
+
+		mutex_unlock(&thermal_list_lock);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_RESTORE:
 	case PM_POST_SUSPEND:
-		atomic_set(&in_suspend, 0);
+		mutex_lock(&thermal_list_lock);
+
 		list_for_each_entry(tz, &thermal_tz_list, node) {
+			mutex_lock(&tz->lock);
+
+			tz->suspended = false;
+
 			thermal_zone_device_init(tz);
-			thermal_zone_device_update(tz,
-						   THERMAL_EVENT_UNSPECIFIED);
+			__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+			mutex_unlock(&tz->lock);
 		}
+
+		mutex_unlock(&thermal_list_lock);
 		break;
 	default:
 		break;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -152,6 +152,7 @@ struct thermal_cooling_device {
  * @node:	node in thermal_tz_list (in thermal_core.c)
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
+ * @suspended: thermal zone suspend indicator
  */
 struct thermal_zone_device {
 	int id;
@@ -185,6 +186,7 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	bool suspended;
 };
 
 /**




