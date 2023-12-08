Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0A80ACCD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574652AbjLHTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjLHTUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:20:40 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C110D2;
        Fri,  8 Dec 2023 11:20:45 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 458223ef91cacc58; Fri, 8 Dec 2023 20:20:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2E9DA6688FC;
        Fri,  8 Dec 2023 20:20:44 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1 1/3] thermal: core: Make thermal_zone_device_unregister() return after freeing the zone
Date:   Fri, 08 Dec 2023 20:13:44 +0100
Message-ID: <13414639.uLZWGnKmhe@kreacher>
In-Reply-To: <1880915.tdWV9SEqCh@kreacher>
References: <1880915.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedguddvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgt
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

Make thermal_zone_device_unregister() wait until all of the references
to the given thermal zone object have been dropped and free it before
returning.

This guarantees that when thermal_zone_device_unregister() returns,
there is no leftover activity regarding the thermal zone in question
which is required by some of its callers (for instance, modular driver
code that wants to know when it is safe to let the module go away).

Subsequently, this will allow some confusing device_is_registered()
checks to be dropped from the thermal sysfs and core code.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    6 +++++-
 include/linux/thermal.h        |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -822,7 +822,7 @@ static void thermal_release(struct devic
 		tz = to_thermal_zone(dev);
 		thermal_zone_destroy_device_groups(tz);
 		mutex_destroy(&tz->lock);
-		kfree(tz);
+		complete(&tz->removal);
 	} else if (!strncmp(dev_name(dev), "cooling_device",
 			    sizeof("cooling_device") - 1)) {
 		cdev = to_cooling_device(dev);
@@ -1315,6 +1315,7 @@ thermal_zone_device_register_with_trips(
 	INIT_LIST_HEAD(&tz->thermal_instances);
 	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
+	init_completion(&tz->removal);
 	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
 	if (id < 0) {
 		result = id;
@@ -1494,6 +1495,9 @@ void thermal_zone_device_unregister(stru
 	put_device(&tz->device);
 
 	thermal_notify_tz_delete(tz_id);
+
+	wait_for_completion(&tz->removal);
+	kfree(tz);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -117,6 +117,7 @@ struct thermal_cooling_device {
  * @id:		unique id number for each thermal zone
  * @type:	the thermal zone device type
  * @device:	&struct device for this thermal zone
+ * @removal:	removal completion
  * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
  * @trip_type_attrs:	attributes for trip points for sysfs: trip type
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
@@ -156,6 +157,7 @@ struct thermal_zone_device {
 	int id;
 	char type[THERMAL_NAME_LENGTH];
 	struct device device;
+	struct completion removal;
 	struct attribute_group trips_attribute_group;
 	struct thermal_attr *trip_temp_attrs;
 	struct thermal_attr *trip_type_attrs;



