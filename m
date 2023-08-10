Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC42778147
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjHJTSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjHJTRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:50 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966712717;
        Thu, 10 Aug 2023 12:17:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 00465989895b177a; Thu, 10 Aug 2023 21:17:48 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A98FB662742;
        Thu, 10 Aug 2023 21:17:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/7] thermal: intel: intel_soc_dts_iosf: Untangle update_trip_temp()
Date:   Thu, 10 Aug 2023 21:11:26 +0200
Message-ID: <2306583.ElGaqSPkdT@kreacher>
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

Function update_trip_temp() is currently used for the initialization
of trip points as well as for changing trip point temperatures in
sys_set_trip_temp().

This is quite confusing and passing the value of dts->trip_types[trip]
to it so that it can store that value in the same memory location is
not particularly useful, because it only is necessary to set the
trip point type once, at the initialization time.

For this reason, drop the last argument from update_trip_temp() and
introduce configure_trip() calling the former internally for the
initial configuration of trip points.

Modify the majority of update_trip_temp() callers to use
configure_trip() instead of it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c |   37 ++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -67,8 +67,7 @@ static int sys_get_trip_temp(struct ther
 }
 
 static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
-			    int thres_index, int temp,
-			    enum thermal_trip_type trip_type)
+			    int thres_index, int temp)
 {
 	int status;
 	u32 temp_out;
@@ -142,8 +141,6 @@ static int update_trip_temp(struct intel
 	if (status)
 		goto err_restore_te_out;
 
-	dts->trip_types[thres_index] = trip_type;
-
 	return 0;
 err_restore_te_out:
 	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
@@ -159,6 +156,21 @@ err_restore_ptps:
 	return status;
 }
 
+static int configure_trip(struct intel_soc_dts_sensor_entry *dts,
+			  int thres_index, enum thermal_trip_type trip_type,
+			  int temp)
+{
+	int ret;
+
+	ret = update_trip_temp(dts, thres_index, temp);
+	if (ret)
+		return ret;
+
+	dts->trip_types[thres_index] = trip_type;
+
+	return 0;
+}
+
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 			     int temp)
 {
@@ -170,8 +182,7 @@ static int sys_set_trip_temp(struct ther
 		return -EINVAL;
 
 	mutex_lock(&sensors->dts_update_lock);
-	status = update_trip_temp(dts, trip, temp,
-				  dts->trip_types[trip]);
+	status = update_trip_temp(dts, trip, temp);
 	mutex_unlock(&sensors->dts_update_lock);
 
 	return status;
@@ -317,7 +328,7 @@ int intel_soc_dts_iosf_add_read_only_cri
 
 		j = find_first_zero_bit(&mask, SOC_MAX_DTS_TRIPS);
 		if (j < SOC_MAX_DTS_TRIPS)
-			return update_trip_temp(entry, j, temp, THERMAL_TRIP_CRITICAL);
+			return configure_trip(entry, j, THERMAL_TRIP_CRITICAL, temp);
 	}
 
 	return -EINVAL;
@@ -395,13 +406,13 @@ struct intel_soc_dts_sensors *intel_soc_
 	}
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		ret = update_trip_temp(&sensors->soc_dts[i], 0, 0,
-				       THERMAL_TRIP_PASSIVE);
+		ret = configure_trip(&sensors->soc_dts[i], 0,
+				     THERMAL_TRIP_PASSIVE, 0);
 		if (ret)
 			goto err_remove_zone;
 
-		ret = update_trip_temp(&sensors->soc_dts[i], 1, 0,
-				       THERMAL_TRIP_PASSIVE);
+		ret = configure_trip(&sensors->soc_dts[i], 1,
+				     THERMAL_TRIP_PASSIVE, 0);
 		if (ret)
 			goto err_remove_zone;
 	}
@@ -422,8 +433,8 @@ void intel_soc_dts_iosf_exit(struct inte
 	int i;
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		update_trip_temp(&sensors->soc_dts[i], 0, 0, 0);
-		update_trip_temp(&sensors->soc_dts[i], 1, 0, 0);
+		configure_trip(&sensors->soc_dts[i], 0, 0, 0);
+		configure_trip(&sensors->soc_dts[i], 1, 0, 0);
 		remove_dts_thermal_zone(&sensors->soc_dts[i]);
 	}
 	kfree(sensors);



