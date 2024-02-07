Return-Path: <linux-kernel+bounces-56976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E44684D213
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC73289F02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3186155;
	Wed,  7 Feb 2024 19:13:01 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69C4823B9;
	Wed,  7 Feb 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333180; cv=none; b=tjZ+vMJq9yDxHBH6G5lolc5qLQwNIwi+RV1E7dsj1Sg8N71JbTnte9DAEwnhZQ+chm5wszjxn0Oyk8KBu2AiSTDoYgQfn+sS3gssEXOHWBd/f4tvGIsqRUGrwPovJZCVRg6KWTZuRtMR+qDBmKinkCn2101YNgfVXRhq2pu6LQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333180; c=relaxed/simple;
	bh=AB6u5fg2dweFTMD5jMbAqYepGoUI5YM7pGFRXWYMAfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N15Hskrnu/aKA+cnsIj0avxPbECiXRzCYLjx7uXysOJ276Kuwy85OyM7MQ0rov/mjPK5UprsDMUrjTD3uB83dgJTOsfxwH8riwT/+o7bNX+aznL7D/vMyqGKkh7aXOCNu4PIxic/mI5mvgU6SDmDo7A6P3SDlZv3RKnm4C01hRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id cc3e3f799ac74844; Wed, 7 Feb 2024 20:12:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 261B2669B2E;
	Wed,  7 Feb 2024 20:12:48 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Gregory Greenman <gregory.greenman@intel.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject:
 [PATCH v1 3/3] iwlwifi: mvm: Use for_each_thermal_trip() for walking trip
 points
Date: Wed, 07 Feb 2024 20:12:38 +0100
Message-ID: <2270733.iZASKD2KPV@kreacher>
In-Reply-To: <1892445.tdWV9SEqCh@kreacher>
References: <1892445.tdWV9SEqCh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdduudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdhgrhgvvghnmhgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 jhhohhgrnhhnvghsrdgsvghrghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The code walking trip points in iwl_mvm_send_temp_report_ths_cmd()
reads the trip table passed to thermal_zone_device_register_with_trips()
in order to get the current trip temperatures, but this is not
guaranteed to work in the future, because the thermal zone will store
trip points information internally.

For this reason, make iwl_mvm_send_temp_report_ths_cmd() use
for_each_thermal_trip() as appropriate for walking trip points in a
given thermal zone.

No intentional functional impact, but it is requisite for future thermal
core improvements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |   40 +++++++++++++++++-----------
 1 file changed, 25 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -555,6 +555,22 @@ static int compare_temps(const void *a,
 	return ((s16)le16_to_cpu(*(__le16 *)a) -
 		(s16)le16_to_cpu(*(__le16 *)b));
 }
+
+struct iwl_trip_walk_data {
+	__le16 *thresholds;
+	int count;
+};
+
+static int iwl_trip_temp_cb(struct thermal_trip *trip, void *arg)
+{
+	struct iwl_trip_walk_data *twd = arg;
+
+	if (trip->temperature == THERMAL_TEMP_INVALID)
+		return 0;
+
+	twd->thresholds[twd->count++] = cpu_to_le16((s16)(trip->temperature / 1000));
+	return 0;
+}
 #endif
 
 int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
@@ -562,31 +578,25 @@ int iwl_mvm_send_temp_report_ths_cmd(str
 	struct temp_report_ths_cmd cmd = {0};
 	int ret;
 #ifdef CONFIG_THERMAL
-	int i, idx = 0;
+	struct iwl_trip_walk_data twd = { .thresholds = cmd.thresholds, .count = 0 };
 
 	lockdep_assert_held(&mvm->mutex);
 
 	if (!mvm->tz_device.tzone)
 		goto send;
 
-	/* The driver holds array of temperature trips that are unsorted
-	 * and uncompressed, the FW should get it compressed and sorted
+	/*
+	 * The thermal core holds an array of temperature trips that are
+	 * unsorted and uncompressed, the FW should get it compressed and
+	 * sorted.
 	 */
 
 	/* compress trips to cmd array, remove uninitialized values*/
-	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (mvm->tz_device.trips[i].temperature != THERMAL_TEMP_INVALID) {
-			cmd.thresholds[idx++] =
-				cpu_to_le16((s16)(mvm->tz_device.trips[i].temperature / 1000));
-		}
-	}
-	cmd.num_temps = cpu_to_le32(idx);
-
-	if (!idx)
-		goto send;
+	for_each_thermal_trip(mvm->tz_device.tzone, iwl_trip_temp_cb, &twd);
 
-	/*sort cmd array*/
-	sort(cmd.thresholds, idx, sizeof(s16), compare_temps, NULL);
+	cmd.num_temps = cpu_to_le32(twd.count);
+	if (twd.count)
+		sort(cmd.thresholds, twd.count, sizeof(s16), compare_temps, NULL);
 
 send:
 #endif




