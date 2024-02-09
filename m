Return-Path: <linux-kernel+bounces-59440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D88584F726
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937951C224EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E27EEE7;
	Fri,  9 Feb 2024 14:14:54 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653B79941;
	Fri,  9 Feb 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488093; cv=none; b=tzlA8DMQEwHP6OK3JhcXlheBXT522+P8n8kmysO4m027DaUZ24u39qLLod1kLjF6hR7J4qstabZnYwhA4/m2vsE9dXNCtkUTbqht38q4FkmldqUqNeVpDMZv21ZYgLLlRd3DIYqYc7dmX9QgO+Z2XECd7Nj3lv5QVDCdc8wDV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488093; c=relaxed/simple;
	bh=7P1hI9/Ao5J67cYY+F3SHkarvsguRNc1kwQUZSw4MpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa8BDgQAVuhVnpG0D09r0kSWccrWTkyr/xqKKqdp7qxKZH4cHITFtAuN2wCCBYlAOd9GHRE1ZUxdvlwoQPFuU9MxnwlqQWTghv2r0kf6paNeN/F1Cs9B2c/Q3yY2n8L5KHUVw7j5CWWLKsouKQyobIOQOj2MN9qY9+U1XRjoBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 4bb44e534049fc2e; Fri, 9 Feb 2024 15:14:48 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DDFB6669C4D;
	Fri,  9 Feb 2024 15:14:47 +0100 (CET)
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
Subject: [PATCH v1 1/9] thermal: Get rid of CONFIG_THERMAL_WRITABLE_TRIPS
Date: Fri, 09 Feb 2024 15:05:25 +0100
Message-ID: <1809389.VLH7GnMWUR@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only difference made by CONFIG_THERMAL_WRITABLE_TRIPS is whether or
not the writable trips mask passed during thermal zone registration
will take any effect, but whoever passes a non-zero writable trips mask
to thermal_zone_device_register_with_trips() can be forgiven thinking
that it will always work.

Moreover, some thermal drivers expect user space to set trip temperature
values, so they select CONFIG_THERMAL_WRITABLE_TRIPS, possibly overriding
a manual choice to unset it and going against the design purportedly
allowing system integrators to decide on the writability of trip points
for the given kernel build.  It is also set in one platform's defconfig.

Forthermore, CONFIG_THERMAL_WRITABLE_TRIPS only affects trip temperature,
because trip hysteresis is writable as long as the thermal zone provides
a callback to update it, regardless of the CONFIG_THERMAL_WRITABLE_TRIPS
value.

The above means that the symbol in question is used inconsistently and
its purpose is at least moot, so remove it and always take the writable
trip mask passed to thermal_zone_device_register_with_trips() into
account.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 -
 drivers/thermal/Kconfig              |   11 -----------
 drivers/thermal/intel/Kconfig        |    2 --
 drivers/thermal/thermal_sysfs.c      |    8 +++-----
 4 files changed, 3 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
@@ -83,17 +83,6 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
-config THERMAL_WRITABLE_TRIPS
-	bool "Enable writable trip points"
-	help
-	  This option allows the system integrator to choose whether
-	  trip temperatures can be changed from userspace. The
-	  writable trips need to be specified when setting up the
-	  thermal zone but the choice here takes precedence.
-
-	  Say 'Y' here if you would like to allow userspace tools to
-	  change trip temperatures.
-
 choice
 	prompt "Default Thermal governor"
 	default THERMAL_DEFAULT_GOV_STEP_WISE
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -458,8 +458,7 @@ static int create_trip_attrs(struct ther
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
-		if (IS_ENABLED(CONFIG_THERMAL_WRITABLE_TRIPS) &&
-		    mask & (1 << indx)) {
+		if (mask & (1 << indx)) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
Index: linux-pm/drivers/thermal/intel/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -23,7 +23,6 @@ config X86_PKG_TEMP_THERMAL
 	tristate "X86 package temperature thermal driver"
 	depends on X86_THERMAL_VECTOR
 	select THERMAL_GOV_USER_SPACE
-	select THERMAL_WRITABLE_TRIPS
 	select INTEL_TCC
 	default m
 	help
@@ -47,7 +46,6 @@ config INTEL_SOC_DTS_THERMAL
 	tristate "Intel SoCs DTS thermal driver"
 	depends on X86 && PCI && ACPI
 	select INTEL_SOC_DTS_IOSF_CORE
-	select THERMAL_WRITABLE_TRIPS
 	help
 	  Enable this to register Intel SoCs (e.g. Bay Trail) platform digital
 	  temperature sensor (DTS). These SoCs have two additional DTSs in
Index: linux-pm/arch/arm/configs/imx_v6_v7_defconfig
===================================================================
--- linux-pm.orig/arch/arm/configs/imx_v6_v7_defconfig
+++ linux-pm/arch/arm/configs/imx_v6_v7_defconfig
@@ -228,7 +228,6 @@ CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
-CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y




