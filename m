Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938E3778148
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjHJTSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbjHJTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FA2271E;
        Thu, 10 Aug 2023 12:17:50 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id e9d51f748be1c126; Thu, 10 Aug 2023 21:17:48 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5BB11662742;
        Thu, 10 Aug 2023 21:17:48 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/7] thermal: intel: intel_soc_dts_iosf: Always assume notification support
Date:   Thu, 10 Aug 2023 21:09:54 +0200
Message-ID: <4864678.31r3eYUQgx@kreacher>
In-Reply-To: <5713357.DvuYhMxLoT@kreacher>
References: <5713357.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdp
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

None of the existing callers of intel_soc_dts_iosf_init() passes
INTEL_SOC_DTS_INTERRUPT_NONE as the first argument to it, so the
notification local variable in it is always true and the
notification_support argument of add_dts_thermal_zone() is always
true either.

For this reason, drop the notification local variable from
intel_soc_dts_iosf_init() and the notification_support argument from
add_dts_thermal_zone() and rearrange the latter to always set
writable_trip_cnt and trip_mask.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/intel_soc_dts_iosf.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -247,12 +247,12 @@ static void remove_dts_thermal_zone(stru
 }
 
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
-				bool notification_support, int read_only_trip_cnt)
+				int read_only_trip_cnt)
 {
 	char name[10];
 	unsigned long trip;
-	int trip_mask = 0;
-	int writable_trip_cnt = 0;
+	int writable_trip_cnt;
+	int trip_mask;
 	unsigned long ptps;
 	u32 store_ptps;
 	unsigned long i;
@@ -265,10 +265,9 @@ static int add_dts_thermal_zone(int id,
 		goto err_ret;
 
 	dts->id = id;
-	if (notification_support) {
-		writable_trip_cnt = SOC_MAX_DTS_TRIPS - read_only_trip_cnt;
-		trip_mask = GENMASK(writable_trip_cnt - 1, 0);
-	}
+
+	writable_trip_cnt = SOC_MAX_DTS_TRIPS - read_only_trip_cnt;
+	trip_mask = GENMASK(writable_trip_cnt - 1, 0);
 
 	/* Check if the writable trip we provide is not used by BIOS */
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
@@ -364,7 +363,6 @@ struct intel_soc_dts_sensors *intel_soc_
 	enum intel_soc_dts_interrupt_type intr_type, int read_only_trip_count)
 {
 	struct intel_soc_dts_sensors *sensors;
-	bool notification;
 	int tj_max;
 	int ret;
 	int i;
@@ -387,14 +385,11 @@ struct intel_soc_dts_sensors *intel_soc_
 	mutex_init(&sensors->dts_update_lock);
 	sensors->intr_type = intr_type;
 	sensors->tj_max = tj_max * 1000;
-	if (intr_type == INTEL_SOC_DTS_INTERRUPT_NONE)
-		notification = false;
-	else
-		notification = true;
+
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		sensors->soc_dts[i].sensors = sensors;
 		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
-					   notification, read_only_trip_count);
+					   read_only_trip_count);
 		if (ret)
 			goto err_free;
 	}



