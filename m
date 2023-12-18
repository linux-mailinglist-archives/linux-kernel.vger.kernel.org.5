Return-Path: <linux-kernel+bounces-4297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA3817B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464041F21678
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95172077;
	Mon, 18 Dec 2023 19:28:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09FB49899;
	Mon, 18 Dec 2023 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id c4a5040754e8f936; Mon, 18 Dec 2023 20:28:40 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 50EBF668C31;
	Mon, 18 Dec 2023 20:28:40 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, Bo Ye <bo.ye@mediatek.com>, Radu Solea <radusolea@google.com>
Subject: [PATCH v1 3/3] thermal: core: Resume thermal zones asynchronously
Date: Mon, 18 Dec 2023 20:28:31 +0100
Message-ID: <1886695.tdWV9SEqCh@kreacher>
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

The resume of thermal zones in thermal_pm_notify() is carried out
sequentially, which may be a problem if __thermal_zone_device_update()
takes a significant time to run for some thermal zones, because some
other thermal zones may need to wait for them to resume then and if
any other PM notifiers are going to be invoked after the thermal one,
they will need to wait for it either.

To address this, make thermal_pm_notify() switch the poll_queue delayed
work over to a one-shot thermal_zone_device_resume() work function that
will restore the original one during the thermal zone resume and queue
up poll_queue without a delay for each thermal zone.

Link: https://lore.kernel.org/linux-pm/20231120234015.3273143-1-radusolea@google.com/
Reported-by: Radu Solea <radusolea@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1528,6 +1528,22 @@ exit:
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
 
+static void thermal_zone_device_resume(struct work_struct *work)
+{
+	struct thermal_zone_device *tz;
+
+	tz = container_of(work, struct thermal_zone_device, poll_queue.work);
+
+	mutex_lock(&tz->lock);
+
+	tz->suspended = false;
+
+	thermal_zone_device_init(tz);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	mutex_unlock(&tz->lock);
+}
+
 static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
@@ -1559,10 +1575,16 @@ static int thermal_pm_notify(struct noti
 
 			cancel_delayed_work(&tz->poll_queue);
 
-			tz->suspended = false;
-
-			thermal_zone_device_init(tz);
-			__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+			/*
+			 * Replace the work function with the resume one, which
+			 * will restore the original work function and schedule
+			 * the polling work if needed.
+			 */
+			INIT_DELAYED_WORK(&tz->poll_queue,
+					  thermal_zone_device_resume);
+			/* Queue up the work without a delay. */
+			mod_delayed_work(system_freezable_power_efficient_wq,
+					 &tz->poll_queue, 0);
 
 			mutex_unlock(&tz->lock);
 		}




