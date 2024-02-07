Return-Path: <linux-kernel+bounces-56974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7084D20D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5F8288669
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB385657;
	Wed,  7 Feb 2024 19:12:59 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A098527E;
	Wed,  7 Feb 2024 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333179; cv=none; b=dKvqtX9rSfgcABKAag3KNL77Wa+KNrfWvp5fz3aeBhkxaHsS/8WjHraziVMHFf8Qj9oywtOKQYIbWWs7AMCJnvnFxL+cWoPFkUiQ+7ZHNsei1ysOsHGpdmPeT8PO/xIP9Rn/nohsEIL+qiRE3+1HS1zMUCrGyhkKCdJR/HyqLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333179; c=relaxed/simple;
	bh=fEDNq2Er6z2Bo4ZvoiSYDuSkdI3VFvkzx+dgMfUNyCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ve/8hlHrDdVcwFTYCindN6/eSI/tGJVXqvQ+xvMt6vEyVUkXj7Xk1+zIL8mcQKmxiWAhMM4tyrSdyY6J3DmFo4NL0xR5Ap2XWl5Fa3zjxFs4z1PdOl/UZWYdy5/TRc3GAg4RKJ2pMkiRSt00xUSoEIXoWQVx+GuPgYXwLACdnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 527089a773aed57e; Wed, 7 Feb 2024 20:12:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0173A669B2E;
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
 [PATCH v1 2/3] iwlwifi: mvm: Populate trip table before registering thermal
 zone
Date: Wed, 07 Feb 2024 20:10:24 +0100
Message-ID: <8346768.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgdduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdhgrhgvvghnmhgrnhesihhnthgvlhdrtghomhdprhgtphhtthhopehmihhrihgrmhdrrhgrtghhvghlrdhkohhrvghnsghlihhtsehinhhtvghlrdgtohhmpdhrtghpthhtohepkhhvrghloheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
 jhhohhgrnhhnvghsrdgsvghrghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The trip table in iwl_mvm_thermal_zone_register() is populated after
passing it to thermal_zone_device_register_with_trips(), so it may be
accessed (for instance, via sysfs) before it is ready.

To prevent that from happening, modify the function to populate the
trip table before calling thermal_zone_device_register_with_trips().

Also make the code use THERMAL_TEMP_INVALID as the "invalid temperature"
value which is also meaningful for the core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -575,7 +575,7 @@ int iwl_mvm_send_temp_report_ths_cmd(str
 
 	/* compress trips to cmd array, remove uninitialized values*/
 	for (i = 0; i < IWL_MAX_DTS_TRIPS; i++) {
-		if (mvm->tz_device.trips[i].temperature != INT_MIN) {
+		if (mvm->tz_device.trips[i].temperature != THERMAL_TEMP_INVALID) {
 			cmd.thresholds[idx++] =
 				cpu_to_le16((s16)(mvm->tz_device.trips[i].temperature / 1000));
 		}
@@ -675,6 +675,14 @@ static void iwl_mvm_thermal_zone_registe
 	BUILD_BUG_ON(ARRAY_SIZE(name) >= THERMAL_NAME_LENGTH);
 
 	sprintf(name, "iwlwifi_%u", atomic_inc_return(&counter) & 0xFF);
+	/*
+	 * 0 is a valid temperature,
+	 * so initialize the array with S16_MIN which invalid temperature
+	 */
+	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
+		mvm->tz_device.trips[i].temperature = THERMAL_TEMP_INVALID;
+		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
+	}
 	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
 							mvm->tz_device.trips,
 							IWL_MAX_DTS_TRIPS,
@@ -693,15 +701,6 @@ static void iwl_mvm_thermal_zone_registe
 	if (ret) {
 		IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone\n");
 		thermal_zone_device_unregister(mvm->tz_device.tzone);
-		return;
-	}
-
-	/* 0 is a valid temperature,
-	 * so initialize the array with S16_MIN which invalid temperature
-	 */
-	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
-		mvm->tz_device.trips[i].temperature = INT_MIN;
-		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
 	}
 }
 




