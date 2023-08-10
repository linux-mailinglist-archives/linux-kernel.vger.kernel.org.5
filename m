Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3B77813A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbjHJTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjHJTRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:46 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7A2702;
        Thu, 10 Aug 2023 12:17:45 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id ff766902256c742a; Thu, 10 Aug 2023 21:17:44 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0FBD1662742;
        Thu, 10 Aug 2023 21:17:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 7/7] thermal: intel: intel_soc_dts_iosf: Use struct thermal_trip
Date:   Thu, 10 Aug 2023 21:17:36 +0200
Message-ID: <2249203.iZASKD2KPV@kreacher>
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

Because the number of trip points in each thermal zone and their
types are known to intel_soc_dts_iosf_init() prior to the registration
of the thermal zones, make it create an array of struct thermal_trip
entries in each struct intel_soc_dts_sensor_entry object and make
add_dts_thermal_zone() use thermal_zone_device_register_with_trips()
for thermal zone registration and pass that array as its second
argument.

Drop the sys_get_trip_temp() and sys_get_trip_type() callback
functions along with the respective callback pointers in
tzone_ops, because they are not necessary any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c |   51 +++--------------------------
 drivers/thermal/intel/intel_soc_dts_iosf.h |    2 -
 2 files changed, 8 insertions(+), 45 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -29,7 +29,7 @@ struct intel_soc_dts_sensor_entry {
 	int id;
 	u32 store_status;
 	u32 trip_mask;
-	enum thermal_trip_type trip_types[SOC_MAX_DTS_TRIPS];
+	struct thermal_trip trips[SOC_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 	struct intel_soc_dts_sensors *sensors;
 };
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -40,32 +40,6 @@
 /* Mask for two trips in status bits */
 #define SOC_DTS_TRIP_MASK		0x03
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
-			     int *temp)
-{
-	int status;
-	u32 out;
-	struct intel_soc_dts_sensor_entry *dts;
-	struct intel_soc_dts_sensors *sensors;
-
-	dts = thermal_zone_device_priv(tzd);
-	sensors = dts->sensors;
-	mutex_lock(&sensors->dts_update_lock);
-	status = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
-			       SOC_DTS_OFFSET_PTPS, &out);
-	mutex_unlock(&sensors->dts_update_lock);
-	if (status)
-		return status;
-
-	out = (out >> (trip * 8)) & SOC_DTS_TJMAX_ENCODING;
-	if (!out)
-		*temp = 0;
-	else
-		*temp = sensors->tj_max - out * 1000;
-
-	return 0;
-}
-
 static int update_trip_temp(struct intel_soc_dts_sensors *sensors,
 			    int thres_index, int temp)
 {
@@ -165,7 +139,8 @@ static int configure_trip(struct intel_s
 	if (ret)
 		return ret;
 
-	dts->trip_types[thres_index] = trip_type;
+	dts->trips[thres_index].temperature = temp;
+	dts->trips[thres_index].type = trip_type;
 
 	return 0;
 }
@@ -187,16 +162,6 @@ static int sys_set_trip_temp(struct ther
 	return status;
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *tzd,
-			     int trip, enum thermal_trip_type *type)
-{
-	struct intel_soc_dts_sensor_entry *dts = thermal_zone_device_priv(tzd);
-
-	*type = dts->trip_types[trip];
-
-	return 0;
-}
-
 static int sys_get_curr_temp(struct thermal_zone_device *tzd,
 			     int *temp)
 {
@@ -221,8 +186,6 @@ static int sys_get_curr_temp(struct ther
 
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -293,11 +256,11 @@ static int add_dts_thermal_zone(int id,
 	}
 	dts->trip_mask = trip_mask;
 	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register(name,
-						  SOC_MAX_DTS_TRIPS,
-						  trip_mask,
-						  dts, &tzone_ops,
-						  NULL, 0, 0);
+	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
+							     SOC_MAX_DTS_TRIPS,
+							     trip_mask,
+							     dts, &tzone_ops,
+							     NULL, 0, 0);
 	if (IS_ERR(dts->tzone)) {
 		ret = PTR_ERR(dts->tzone);
 		goto err_ret;



