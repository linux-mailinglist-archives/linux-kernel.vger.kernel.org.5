Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79483778141
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjHJTR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjHJTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:48 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9DE271E;
        Thu, 10 Aug 2023 12:17:48 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 956638716e953904; Thu, 10 Aug 2023 21:17:46 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 37BD2662742;
        Thu, 10 Aug 2023 21:17:46 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 4/7] thermal: intel: intel_soc_dts_iosf: Change initialization ordering
Date:   Thu, 10 Aug 2023 21:13:25 +0200
Message-ID: <13337847.uLZWGnKmhe@kreacher>
In-Reply-To: <5713357.DvuYhMxLoT@kreacher>
References: <5713357.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The initial configuration of trip points in intel_soc_dts_iosf_init()
takes place after registering the sensor thermal zones which is
potentially problematic, because it may race with the setting of trip
point temperatures via sysfs, as there is no synchronization between it
and sys_set_trip_temp().

To address this, change the initialization ordering so that the trip
points are configured prior to the registration of thermal zones.

Accordingly, change the cleanup ordering in intel_soc_dts_iosf_exit()
to remove the thermal zones before resetting the trip points.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -398,30 +398,37 @@ struct intel_soc_dts_sensors *intel_soc_
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		sensors->soc_dts[i].sensors = sensors;
-		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
-					   read_only_trip_count);
-		if (ret)
-			goto err_free;
-	}
 
-	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		ret = configure_trip(&sensors->soc_dts[i], 0,
 				     THERMAL_TRIP_PASSIVE, 0);
 		if (ret)
-			goto err_remove_zone;
+			goto err_reset_trips;
 
 		ret = configure_trip(&sensors->soc_dts[i], 1,
 				     THERMAL_TRIP_PASSIVE, 0);
 		if (ret)
+			goto err_reset_trips;
+	}
+
+	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
+		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
+					   read_only_trip_count);
+		if (ret)
 			goto err_remove_zone;
 	}
 
 	return sensors;
+
 err_remove_zone:
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i)
 		remove_dts_thermal_zone(&sensors->soc_dts[i]);
 
-err_free:
+err_reset_trips:
+	for (i = 0; i < SOC_MAX_DTS_SENSORS; i++) {
+		configure_trip(&sensors->soc_dts[i], 0, 0, 0);
+		configure_trip(&sensors->soc_dts[i], 1, 0, 0);
+	}
+
 	kfree(sensors);
 	return ERR_PTR(ret);
 }
@@ -432,9 +439,9 @@ void intel_soc_dts_iosf_exit(struct inte
 	int i;
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
+		remove_dts_thermal_zone(&sensors->soc_dts[i]);
 		configure_trip(&sensors->soc_dts[i], 0, 0, 0);
 		configure_trip(&sensors->soc_dts[i], 1, 0, 0);
-		remove_dts_thermal_zone(&sensors->soc_dts[i]);
 	}
 	kfree(sensors);
 }



