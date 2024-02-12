Return-Path: <linux-kernel+bounces-62211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB03A851D13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178911C21E93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C5481C6;
	Mon, 12 Feb 2024 18:42:35 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21B3FE44;
	Mon, 12 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763355; cv=none; b=kZj2N1GMp61RygJFLN6KheHfv5jwLd5Gu8LoouABzpFn9CsAg5pZ8cPaWL42zkIGzj9PxT1YFaXGfMw7Yg8Xg7OK0fKWWy4Jmu9zHy41UDZ/oJ79cTSqVR6ufya9FIAbNgeRQRdvsZzu3HX0wpNBU8q46XrdIfV0+HR0MIFO0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763355; c=relaxed/simple;
	bh=0fjHyFCgQiCJ7Xf9wqWXnNvGeNJWsCVj3Z7wFx692qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogUnMkS7nCblb10QkqU3rySOZBGpWtZ4Rm9oiJlxmMwaIEvbTmac0py1hw4x0MiPz00D8dB/LAu+CGhV+OIdGu4oGLEFmL7qfD8M27e9eI5Q0XcTIEMdGq2xuIOGBmLKcEAnzO3tVhnLrPIT93owoBoKFozxmzPQxl3JTcKiFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e1f8ca868e59d311; Mon, 12 Feb 2024 19:42:30 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2107C669CF2;
	Mon, 12 Feb 2024 19:42:30 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject:
 [PATCH v2 6/9] wifi: iwlwifi: mvm: Set THERMAL_TRIP_FLAG_RW_TEMP directly
Date: Mon, 12 Feb 2024 19:38:07 +0100
Message-ID: <22182690.EfDdHjke4D@kreacher>
In-Reply-To: <6017196.lOV4Wx5bFT@kreacher>
References: <6017196.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshht
 rghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
to allow their temperature to be set from user space via sysfs instead
of using a nonzero writable trips mask during thermal zone registration,
so make the iwlwifi code do that.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rename trip flag (Stanislaw).
   * Fix coding mistake in iwl_mvm_thermal_zone_register().
   * Add "wifi:" prefix to the subject (Kalle).

---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -667,9 +667,6 @@ static  struct thermal_zone_device_ops t
 	.set_trip_temp = iwl_mvm_tzone_set_trip_temp,
 };
 
-/* make all trips writable */
-#define IWL_WRITABLE_TRIPS_MSK (BIT(IWL_MAX_DTS_TRIPS) - 1)
-
 static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 {
 	int i, ret;
@@ -692,11 +689,12 @@ static void iwl_mvm_thermal_zone_registe
 	for (i = 0 ; i < IWL_MAX_DTS_TRIPS; i++) {
 		mvm->tz_device.trips[i].temperature = THERMAL_TEMP_INVALID;
 		mvm->tz_device.trips[i].type = THERMAL_TRIP_PASSIVE;
+		mvm->tz_device.trips[i].flags = THERMAL_TRIP_FLAG_RW_TEMP;
 	}
 	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
 							mvm->tz_device.trips,
 							IWL_MAX_DTS_TRIPS,
-							IWL_WRITABLE_TRIPS_MSK,
+							0,
 							mvm, &tzone_ops,
 							NULL, 0, 0);
 	if (IS_ERR(mvm->tz_device.tzone)) {




