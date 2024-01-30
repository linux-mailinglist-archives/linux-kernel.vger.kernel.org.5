Return-Path: <linux-kernel+bounces-44468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD819842272
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AB81C26CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20195664B8;
	Tue, 30 Jan 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NCX6mMIG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B704664B9;
	Tue, 30 Jan 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613197; cv=none; b=Gtde2ltSNAIwahV2so9MxPihKMR/DnTMGy32UjrRezX63fbOP7xVn2FyxI4kcPR83gS2j1/h9nb2OFOBBlqu48xZVs9PN/fkIzUyrWaVWfMDUCLj37B7MfFM2HV1BrlpUWHyWxYyqMxaj2wjjOvsql/EF7bm/IeJX4EwKN8YPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613197; c=relaxed/simple;
	bh=FKvT+3NXE0I7fW0WyC5auryggLUH8FeVDYu/Te5amRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lcc299IdA1nIQ2YRKiDn2em4dzVRpJ9Ic4bfln+fRREZXgb9Y1c+AW/kw7047KQIb4my4w5G03u7VryZbYAdWIUCe9ETMC6SSVONP12fq+oeBPnJrHj1W2SWEkYCT+eh70xEzqS//FKl/K7CSfx0Q+snTLI2Bu6GGkC1WMVBews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NCX6mMIG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613189;
	bh=FKvT+3NXE0I7fW0WyC5auryggLUH8FeVDYu/Te5amRk=;
	h=From:To:Cc:Subject:Date:From;
	b=NCX6mMIGSPtDC/LmtlXOv7wqiyqEllBqsI4ssjeqCerI9om4r2MjKgERlBV1U80R3
	 JP7dunRIUxUyIbaxwr0pfHJnv5q9qOuRACRuudWMN4E5i2ksgSIx6bTiUjStoXBX/D
	 Hrl1/rG/qHjj0FZbYRz/d8w2dhtLxyobHDBb0UG3wzDTs2bTL2JzOLk2lTir09iWSd
	 QTVioyREs3ko1I4jbZoD4JQj8pWG28pSELXgZAP1M+IPT4/lG+Grui+I6/CAu8g7DT
	 WMhgE6Ey3AX3GUsF3YHbd8bGIb3VezTX6mMjZ27pyVDv4nlxUqQN36vp69aX1H25uj
	 SvvubPhfa7+bg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEFED3780FC7;
	Tue, 30 Jan 2024 11:13:07 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	support.opensource@diasemi.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se,
	srinivas.pandruvada@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com,
	d-gole@ti.com,
	linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com,
	heiko@sntech.de,
	hdegoede@redhat.com,
	jernej.skrabec@gmail.com,
	f.fainelli@gmail.com,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 00/18] Thermal: Part 1 - Introduce new structs and registration
Date: Tue, 30 Jan 2024 12:12:32 +0100
Message-ID: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a preparation for a bigger cleanup that will be split in
three parts in order to avoid immutable branches on multiple subsystems,
as in other parts of this series there will be changes in:
- drivers/acpi
- drivers/platform/x86
- drivers/power/supply
- drivers/net/wireless
- drivers/net/ethernet

This is the first part which adds new structures and starts reorganizing
struct members around, plus, this migrates all of the thermal drivers
found in drivers/thermal/ to the new thermal_zone_device_register()
function, and advertises that the old registration functions are
deprecated and will be removed.

The reorganization is supposed to be complete (or mostly) but...
 - struct thermal_zone_platform_params has a temporary name:
   this is done in order to avoid compile time failures for
   the drivers outside of drivers/thermal before migrating
   them to thermal_zone_device_params/thermal_zone_device_register();
 - struct thermal_zone_params temporarily has two duplicated members,
   governor_name and no_hwmon;

Part 2 of this topic will migrate all drivers that are external to
drivers/thermal to thermal_zone_device_register(); I will send that
part only after part 1 is confirmed to be acceptable, as otherwise
I'd be spamming people for no reason :-)

After all drivers will be migrated to thermal_zone_device_register(),
we won't have to care about changing anything outside of drivers/thermal
to finish this set of cleanups/changes (and no immutable branches needed)
and this means that...
Part 3 of this topic will contain the following changes:
 - thermal_zone_device_register_with_trips() will be removed
 - thermal_tripless_zone_device_register() will be removed
 - thermal_zone_params will be renamed to thermal_governor_ipa_params
   - governor_name, no_hwmon members will be removed
 - thermal_zone_platform_params will be renamed to thermal_zone_params
 - Removal of the THERMAL_NAME_LENGTH limitation for `type`

More scheduled changes, which should end up in part 3 (at least that's
my intention), or eventually entirely after this cleanup topic, include:
 - Introduction of Thermal Zone names
 - Disambiguation of TZ name and type
 - Addition of `thermal-zones`, `thermal-zone-names` parsing for
   devicetrees

.. Summarizing ...

Part 1:
 - Reorganize structures (some temporary names/leftovers)
 - New registration function, deprecation of old ones
 - Migration of drivers/thermal drivers to new registration

Part 2:
 - Migration of drivers in other subsystems to new thermal registration

Part 3:
 - Remove the two leftovers in thermal.h
 - Rename structures with proper, final names
 - Everything else, anyway.


Cheers,
Angelo

AngeloGioacchino Del Regno (18):
  thermal: core: Change governor name to const char pointer
  thermal: Add new structures and thermal_zone_device_register()
  thermal: Directly use thermal_zone_platform_params for
    thermal_zone_device
  thermal/drivers/da9062: Migrate to thermal_zone_device_register()
  thermal/drivers/imx: Migrate to thermal_zone_device_register()
  thermal/drivers/rcar: Migrate to thermal_zone_device_register()
  thermal/drivers/st: Migrate to thermal_zone_device_register()
  thermal: intel: pch_thermal: Migrate to thermal_zone_device_register()
  thermal: intel: quark_dts: Migrate to thermal_zone_device_register()
  thermal: intel: soc_dts_iosf: Migrate to
    thermal_zone_device_register()
  thermal: intel: int340x: Migrate to thermal_zone_device_register()
  thermal: int340x: processor: Migrate to thermal_zone_device_register()
  thermal: intel: x86_pkg_temp: Migrate to
    thermal_zone_device_register()
  thermal/drivers/armada: Migrate to thermal_zone_device_register()
  thermal/drivers/dove: Migrate to thermal_zone_device_register()
  thermal/drivers/kirkwood: Migrate to thermal_zone_device_register()
  thermal/drivers/spear: Migrate to thermal_zone_device_register()
  thermal/drivers/int340x: Migrate to thermal_zone_device_register()

 drivers/thermal/armada_thermal.c              |  12 +-
 drivers/thermal/da9062-thermal.c              |  16 +-
 drivers/thermal/dove_thermal.c                |  10 +-
 drivers/thermal/gov_power_allocator.c         |  38 ++--
 drivers/thermal/gov_user_space.c              |   2 +-
 drivers/thermal/imx_thermal.c                 |  21 +-
 .../intel/int340x_thermal/int3400_thermal.c   |  20 +-
 .../int340x_thermal/int340x_thermal_zone.c    |  28 +--
 .../processor_thermal_device_pci.c            |  26 ++-
 drivers/thermal/intel/intel_pch_thermal.c     |  12 +-
 .../thermal/intel/intel_quark_dts_thermal.c   |  23 +-
 drivers/thermal/intel/intel_soc_dts_iosf.c    |  24 ++-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  22 +-
 drivers/thermal/kirkwood_thermal.c            |  10 +-
 drivers/thermal/qcom/tsens.c                  |   4 +-
 drivers/thermal/rcar_thermal.c                |  15 +-
 drivers/thermal/spear_thermal.c               |  10 +-
 drivers/thermal/st/st_thermal.c               |  15 +-
 drivers/thermal/thermal_core.c                | 201 +++++++++++-------
 drivers/thermal/thermal_core.h                |   6 +-
 drivers/thermal/thermal_helpers.c             |  22 +-
 drivers/thermal/thermal_hwmon.c               |   8 +-
 drivers/thermal/thermal_of.c                  |  12 +-
 drivers/thermal/thermal_sysfs.c               |  64 +++---
 drivers/thermal/thermal_trace.h               |   8 +-
 drivers/thermal/thermal_trip.c                |  14 +-
 include/linux/thermal.h                       |  87 ++++++--
 27 files changed, 461 insertions(+), 269 deletions(-)

-- 
2.43.0


