Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E04780ACCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574667AbjLHTUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHTUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:20:39 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70C10E7;
        Fri,  8 Dec 2023 11:20:45 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 150833a18591e4b8; Fri, 8 Dec 2023 20:20:43 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9A3BF6688FC;
        Fri,  8 Dec 2023 20:20:42 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 3/3] thermal: core: Rework thermal zone availability check
Date:   Fri, 08 Dec 2023 20:20:00 +0100
Message-ID: <2258035.iZASKD2KPV@kreacher>
In-Reply-To: <1880915.tdWV9SEqCh@kreacher>
References: <1880915.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
 phhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to avoid running __thermal_zone_device_update() for thermal
zones going away, the thermal zone lock is held around device_del()
in thermal_zone_device_unregister() and thermal_zone_device_update()
passes the given thermal zone device to device_is_registered().
This allows thermal_zone_device_update() to skip the
__thermal_zone_device_update() if device_del() has already run for
the thermal zone at hand.

However, instead of looking at driver core internals, the thermal
subsystem may as well rely on its own data structures for this
purpose.  Namely, if the thermal zone is not present in
thermal_tz_list, it can be regarded as unavailable, which in fact is
already the case in thermal_zone_device_unregister().  Accordingly,
the device_is_registered() check in thermal_zone_device_update() can
be replaced with checking whether or not the node list_head in struct
thermal_zone_device is empty, in which case it is not there in
thermal_tz_list.

To make this work, though, it is necessary to initialize tz->node
in thermal_zone_device_register_with_trips() before registering the
thermal zone device and it needs to be added to thermal_tz_list and
deleted from it under its zone lock.

After the above modifications, the zone lock does not need to be
held around device_del() in thermal_zone_device_unregister() any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -505,11 +505,16 @@ int thermal_zone_device_is_enabled(struc
 	return tz->mode == THERMAL_DEVICE_ENABLED;
 }
 
+static bool thermal_zone_is_present(struct thermal_zone_device *tz)
+{
+	return !list_empty(&tz->node);
+}
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
 	mutex_lock(&tz->lock);
-	if (device_is_registered(&tz->device))
+	if (thermal_zone_is_present(tz))
 		__thermal_zone_device_update(tz, event);
 	mutex_unlock(&tz->lock);
 }
@@ -1304,6 +1309,7 @@ thermal_zone_device_register_with_trips(
 	}
 
 	INIT_LIST_HEAD(&tz->thermal_instances);
+	INIT_LIST_HEAD(&tz->node);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
 	init_completion(&tz->removal);
@@ -1369,7 +1375,9 @@ thermal_zone_device_register_with_trips(
 	}
 
 	mutex_lock(&thermal_list_lock);
+	mutex_lock(&tz->lock);
 	list_add_tail(&tz->node, &thermal_tz_list);
+	mutex_unlock(&tz->lock);
 	mutex_unlock(&thermal_list_lock);
 
 	/* Bind cooling devices for this zone */
@@ -1460,7 +1468,10 @@ void thermal_zone_device_unregister(stru
 		mutex_unlock(&thermal_list_lock);
 		return;
 	}
+
+	mutex_lock(&tz->lock);
 	list_del(&tz->node);
+	mutex_unlock(&tz->lock);
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
@@ -1477,9 +1488,7 @@ void thermal_zone_device_unregister(stru
 	ida_free(&thermal_tz_ida, tz->id);
 	ida_destroy(&tz->ida);
 
-	mutex_lock(&tz->lock);
 	device_del(&tz->device);
-	mutex_unlock(&tz->lock);
 
 	kfree(tz->tzp);
 



