Return-Path: <linux-kernel+bounces-62191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208CA851CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456711C22305
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6047F57;
	Mon, 12 Feb 2024 18:32:35 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128FF4177B;
	Mon, 12 Feb 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762754; cv=none; b=U7jhtK+VTE2jJ4nksy6nTkfVGTigEv8OHmF6Wsuk0/sFNE3FVLUsacn2U12bbodT5qal7KpiMpglg2BiRjusstKnxBFDZdRQJpxQjdYQCEMPXYUFL3N1RO4OIHwhNE/0Zpj/u9zrxnyGUymh0L+uNOGxO4Afp8VOeOF6ir29ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762754; c=relaxed/simple;
	bh=CAquiAoDz6l8jCWNqD4aTMheP1lm5Iwrax0hj6KxiJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp0xBdYjA2X9kv+vFPh1Ht2gGOyRQZju9CdUPqNM1DSjTs9q5ceS91Sco9XnDXFCP5R+5YICMr6CzOBSR0umxUEnL5ryaGORprRcQcEHyCDAu0bStWE/4wuAkljv39kZN9uZJ4qWlZKtgiW+/ZHqGwL0bqs+/T25QqnMV/usXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id d97140acc63546e4; Mon, 12 Feb 2024 19:32:22 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 39738669CF2;
	Mon, 12 Feb 2024 19:32:22 +0100 (CET)
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
 [PATCH v2 3/9] thermal: core: Drop the .set_trip_hyst() thermal zone
 operation
Date: Mon, 12 Feb 2024 19:32:16 +0100
Message-ID: <2923201.e9J7NaK4W3@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshht
 rghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the users of the thermal core provides a .set_trip_hyst()
thermal zone operation, so drop that callback from struct
thermal_zone_device_ops and update trip_point_hyst_store()
accordingly.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c |    6 ------
 include/linux/thermal.h         |    1 -
 2 files changed, 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -184,12 +184,6 @@ trip_point_hyst_store(struct device *dev
 	}
 
 	if (hyst != trip->hysteresis) {
-		if (tz->ops->set_trip_hyst) {
-			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
-			if (ret)
-				goto unlock;
-		}
-
 		trip->hysteresis = hyst;
 
 		thermal_zone_trip_updated(tz, trip);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -91,7 +91,6 @@ struct thermal_zone_device_ops {
 	int (*change_mode) (struct thermal_zone_device *,
 		enum thermal_device_mode);
 	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
-	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
 	int (*get_trend) (struct thermal_zone_device *,




