Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149F772DC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjHGSV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHGSVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:21:05 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A0E5B;
        Mon,  7 Aug 2023 11:21:02 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 9ce1ce9819c4cc9e; Mon, 7 Aug 2023 20:21:00 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1ADD46625B2;
        Mon,  7 Aug 2023 20:21:00 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 02/11] thermal: core: Introduce thermal_zone_device_adjust()
Date:   Mon, 07 Aug 2023 20:02:57 +0200
Message-ID: <2154540.irdbgypaU6@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
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

Introduce a new thermal zone device operation called .update() for
modifying thermal zone components such as trip point and a new helper
function, thermal_zone_device_adjust(), that can be used by drivers
providing the new thermal zone device operation to invoke it under
the zone lock.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5: No changes.

New patch in v4.

---
 drivers/thermal/thermal_core.c |   20 ++++++++++++++++++++
 include/linux/thermal.h        |    2 ++
 2 files changed, 22 insertions(+)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -74,6 +74,7 @@ struct thermal_zone_device_ops {
 			  enum thermal_trend *);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
+	void (*update)(struct thermal_zone_device *, unsigned long);
 };
 
 /**
@@ -323,6 +324,7 @@ int thermal_zone_unbind_cooling_device(s
 				       struct thermal_cooling_device *);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
+void thermal_zone_device_adjust(struct thermal_zone_device *tz, unsigned long data);
 
 struct thermal_cooling_device *thermal_cooling_device_register(const char *,
 		void *, const struct thermal_cooling_device_ops *);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -497,6 +497,26 @@ void thermal_zone_device_update(struct t
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
+/**
+ * thermal_zone_device_adjust - Adjust a thermal zone.
+ * @tz: Thermal zone.
+ * @data: Data to pass to the zone's .update() callback.
+ *
+ * Modify components of a thermal zone (for example, trip points) via
+ * its .update() callback (for example, after a platform configuration
+ * change).
+ */
+void thermal_zone_device_adjust(struct thermal_zone_device *tz, unsigned long data)
+{
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(&tz->device) && tz->ops->update)
+		tz->ops->update(tz, data);
+
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_adjust);
+
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct



