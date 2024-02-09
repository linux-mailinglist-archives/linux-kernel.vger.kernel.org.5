Return-Path: <linux-kernel+bounces-59436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293384F715
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888901F2153F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114D678B7F;
	Fri,  9 Feb 2024 14:14:50 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC9F6F074;
	Fri,  9 Feb 2024 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488089; cv=none; b=UNYANfu8Smrqz1AySm/EHZJ/fpF5rk9q6yeEjPg3u8juAj09wFFJ+BhvcniA1Cb6Zev/VT2DKlT4TgGa8psC3jjkNh/37BlREXSjB49C+PvT3HGzC8wOPF3n8HdEu+osf9TZtlM8lI85UU9rdjgKtjQMUXkMOjl//d6maA3YFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488089; c=relaxed/simple;
	bh=8HqmpFd0rysCcXybj+zUxgCCZN4PfgLB3WDz4Z60m3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyrLjhR3JS2ovBNgA1vu3dMhPBHEDsSboh/qPkFLNCkxNVchMNeSdSkeODnHUva0HBxV5N2jJ7GVYydHGLXVx+DXDTqC4yxg5T6gmpo+QLQzxR6IGSNnmCXSmbJcLFJqhAm9p3m78Dj7Fu2XRtgtzrw/z0Og6g748Ws3YVuCmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 251588209d90e162; Fri, 9 Feb 2024 15:14:44 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3472D669C4D;
	Fri,  9 Feb 2024 15:14:44 +0100 (CET)
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
 [PATCH v1 5/9] mlxsw: core_thermal: Set THERMAL_TRIP_WRITABLE_TEMP directly
Date: Fri, 09 Feb 2024 15:08:43 +0100
Message-ID: <2206820.Mh6RI2rZIc@kreacher>
In-Reply-To: <3232442.5fSG56mABF@kreacher>
References: <3232442.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is now possible to flag trip points with THERMAL_TRIP_WRITABLE_TEMP
to allow their temperature to be set from user space via sysfs instead
of using a nonzero writable trips mask during thermal zone registration,
so make the mlxsw code do that.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
 	},
 	{
 		/* In range - 40-100% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
 	},
 	{	/* Warning */
 		.type		= THERMAL_TRIP_HOT,
 		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
 	},
 };
 
@@ -62,16 +65,19 @@ static const struct thermal_trip default
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_NORM,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
 	},
 	{
 		/* In range - 40-100% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_HIGH,
 		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
 	},
 	{	/* Warning */
 		.type		= THERMAL_TRIP_HOT,
 		.temperature	= MLXSW_THERMAL_MODULE_TEMP_HOT,
+		.flags		= THERMAL_TRIP_WRITABLE_TEMP,
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




