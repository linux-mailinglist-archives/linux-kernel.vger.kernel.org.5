Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698567B59DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbjJBSER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbjJBSEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:04:09 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D637C4;
        Mon,  2 Oct 2023 11:04:06 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 0e4c9e098fc70d13; Mon, 2 Oct 2023 20:04:04 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5035D6658DF;
        Mon,  2 Oct 2023 20:04:04 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/4] thermal: core: Add function to walk trips under zone lock
Date:   Mon, 02 Oct 2023 19:59:35 +0200
Message-ID: <2306658.ElGaqSPkdT@kreacher>
In-Reply-To: <4871671.31r3eYUQgx@kreacher>
References: <4871671.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghp
 thhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a wrapper around for_each_thermal_trip(), called
thermal_zone_for_each_trip(), that will invoke the former under the
thermal zone lock and pass its return value to the caller.

Two drivers will be modified subsequently to use this new function.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_trip.c |   14 ++++++++++++++
 include/linux/thermal.h        |    3 +++
 2 files changed, 17 insertions(+)

Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -27,6 +27,20 @@ int for_each_thermal_trip(struct thermal
 }
 EXPORT_SYMBOL_GPL(for_each_thermal_trip);
 
+int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
+			       int (*cb)(struct thermal_trip *, void *),
+			       void *data)
+{
+	int ret;
+
+	mutex_lock(&tz->lock);
+	ret = for_each_thermal_trip(tz, cb, data);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 {
 	return tz->num_trips;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -287,6 +287,9 @@ int thermal_zone_set_trip(struct thermal
 int for_each_thermal_trip(struct thermal_zone_device *tz,
 			  int (*cb)(struct thermal_trip *, void *),
 			  void *data);
+int thermal_zone_for_each_trip(struct thermal_zone_device *tz,
+			       int (*cb)(struct thermal_trip *, void *),
+			       void *data);
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);



