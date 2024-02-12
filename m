Return-Path: <linux-kernel+bounces-62212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D4851D18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5562816C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2834CE09;
	Mon, 12 Feb 2024 18:42:37 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804240BEE;
	Mon, 12 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763356; cv=none; b=OwOGur65AS2LCue2FUemDaxLwkegZaSVg5XgCBTItDKPuNV6Kj6gh48h+nkck6w/o6sA/WG9ZlyDBfqjQr1Km47sSszaBCMN3rYWM53zctxFxlD4TZ6P0Qd8VgpgW7czm5rWYs0pi4jzopm9iG2uzXpvapD1gn4AYeQVQ9JDLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763356; c=relaxed/simple;
	bh=hOAifuosbac6a+ahRRhg5YVd6cXd/8T1Y8QRCjzuvWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PF3P50Q5DEBljR1yTgvA7KFkIBEIY7kEhRTdp+30/V/rGRecaRmr3BrDoSNO97an7dZAQCVkIVJB0o1cHULmCt3eA2yjOu5tzMRHNwirlw5rb0zgq4Ch8s0jQELRDCDyXESXEZ+AqXPJIRpN0OWo8T6/CcNaSSbo0Ie1+eInPEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e215d587004f3844; Mon, 12 Feb 2024 19:42:31 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DB91E669CF2;
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
 [PATCH v2 5/9] mlxsw: core_thermal: Set THERMAL_TRIP_FLAG_RW_TEMP directly
Date: Mon, 12 Feb 2024 19:35:56 +0100
Message-ID: <10417137.nUPlyArG6x@kreacher>
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
so make the mlxsw code do that.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

v1 -> v2:
   * Rename trip flag (Stanislaw).
   * Add R-by from Ido.

---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
===================================================================
--- linux-pm.orig/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -44,16 +44,19 @@ static const struct thermal_trip default
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_ASIC_TEMP_NORM,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 	{
 		/* In range - 40-100% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 	{	/* Warning */
 		.type		= THERMAL_TRIP_HOT,
 		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 };
 
@@ -62,16 +65,19 @@ static const struct thermal_trip default
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_NORM,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 	{
 		/* In range - 40-100% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_HIGH,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 	{	/* Warning */
 		.type		= THERMAL_TRIP_HOT,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_HOT,
+		.flags		= THERMAL_TRIP_FLAG_RW_TEMP,
 	},
 };
 
@@ -92,9 +98,6 @@ static const struct mlxsw_cooling_states
 
 #define MLXSW_THERMAL_NUM_TRIPS	ARRAY_SIZE(default_thermal_trips)
 
-/* Make sure all trips are writable */
-#define MLXSW_THERMAL_TRIP_MASK	(BIT(MLXSW_THERMAL_NUM_TRIPS) - 1)
-
 struct mlxsw_thermal;
 
 struct mlxsw_thermal_module {
@@ -420,7 +423,7 @@ mlxsw_thermal_module_tz_init(struct mlxs
 	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
 							module_tz->trips,
 							MLXSW_THERMAL_NUM_TRIPS,
-							MLXSW_THERMAL_TRIP_MASK,
+							0,
 							module_tz,
 							&mlxsw_thermal_module_ops,
 							&mlxsw_thermal_params,
@@ -548,7 +551,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlx
 	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
 						gearbox_tz->trips,
 						MLXSW_THERMAL_NUM_TRIPS,
-						MLXSW_THERMAL_TRIP_MASK,
+						0,
 						gearbox_tz,
 						&mlxsw_thermal_gearbox_ops,
 						&mlxsw_thermal_params, 0,
@@ -773,7 +776,7 @@ int mlxsw_thermal_init(struct mlxsw_core
 	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
 						      thermal->trips,
 						      MLXSW_THERMAL_NUM_TRIPS,
-						      MLXSW_THERMAL_TRIP_MASK,
+						      0,
 						      thermal,
 						      &mlxsw_thermal_ops,
 						      &mlxsw_thermal_params, 0,




