Return-Path: <linux-kernel+bounces-8367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EE081B64F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229AD1C2423A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA4773195;
	Thu, 21 Dec 2023 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EAOGMCt6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E22E6EB63;
	Thu, 21 Dec 2023 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162912;
	bh=2NCEeLfcBTGldq8y38nz7ZWXoN1JW/y1+OmDgAsYgXo=;
	h=From:To:Cc:Subject:Date:From;
	b=EAOGMCt68cmj+wdZMGdZ1VpamGZvkorPLseeE/zWVz5O7IVZwQT9dM8x8ZKUYZyn8
	 u/VgkRM6XEAj7ZPYR353W9VLptOfB6LjfnkYG7kZkqX38azs8jpgHQqotAlaZ8irPg
	 MZ/de6lcu0CBB9R1DKIeY3hW60ueKi905x06swnhEsyy3krfjBbgdR6V7kJAEkgVDF
	 MjrSh5q8yk41i96uZ7tqrIDF8w5xx2T2TiWNWHgKvc8iPFqJ/0Bw0PN0qiS30fpNWG
	 ZCO0N8f4AEotZv1cwoLkCRgDinKNRcsldOSeviOkq7zo0P+uKJr2X+h00wHKuGsbIf
	 +9hwZS4FbevIQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B75CE3781485;
	Thu, 21 Dec 2023 12:48:31 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 00/26] Add thermal zones names and new registration func
Date: Thu, 21 Dec 2023 13:47:59 +0100
Message-ID: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

** This RFC was sent only to thermal API maintainers + reviewers on purpose **

As per previous discussion with Daniel [1], I've prepared this series adding
a new struct thermal_zone_device_params, used in a new registration function
for thermal zones thermal_zone_device_register(), deprecating and, finally,
replacing functions thermal_tripless_zone_device_register() and
thermal_zone_device_register_with_trips().

The new flow to register a thermal zone becomes the following:
 - Declare a struct thermal_zone_device_params (`tzp` in this example)
 - Fill in all the params (instead of passing all of them to a function)
 - Call thermal_zone_device_register(tzp)

Moreover, I've also introduced the concept of `name` for a thermal zone,
and set, as suggested, a constraint for which:
 - Multiple thermal zones can have the same `type` (so, no change), and
 - A thermal zone's name must be *unique*.

This should then help (in a later series?) to disambiguate thermal zone
name vs type, as most of (if not all) the users seem to actually be
misusing the TZ type referring to / using it as a TZ name.

Please note that this series is currently a RFC because it's apparently
growing bigger than I wanted - and because I probably have to add some
more code on top. Before doing so, I'm trying to get feedback on what
I've done until now.

P.S.: I know, there's a fixup commit in the mix, will obviously fix
that for v1 :-)

[1]: https://lore.kernel.org/all/20231115144857.424005-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (26):
  thermal: Introduce thermal_zone_device_register() and params structure
  thermal/of: Migrate to thermal_zone_device_register()
  platform/x86: acerhdf: Migrate to thermal_zone_device_register()
  ACPI: thermal: Migrate to thermal_zone_device_register()
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
  power: supply: core: Migrate to thermal_zone_device_register()
  thermal/drivers/armada: Migrate to thermal_zone_device_register()
  thermal/drivers/dove: Migrate to thermal_zone_device_register()
  thermal/drivers/kirkwood: Migrate to thermal_zone_device_register()
  thermal/drivers/spear: Migrate to thermal_zone_device_register()
  thermal/drivers/int340x: Migrate to thermal_zone_device_register()
  wifi: iwlwifi: mvm: Migrate to thermal_zone_device_register()
  cxgb4: Migrate to thermal_zone_device_register()
  mlxsw: core_thermal: Migrate to thermal_zone_device_register()
  fixup! power: supply: core: Migrate to thermal_zone_device_register()
  thermal: Remove tripless_zone_register and register_with_trips
    functions
  thermal: Introduce thermal zones names

 drivers/acpi/thermal.c                        |  18 +--
 .../ethernet/chelsio/cxgb4/cxgb4_thermal.c    |  18 ++-
 .../ethernet/mellanox/mlxsw/core_thermal.c    |  93 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  27 ++--
 drivers/platform/x86/acerhdf.c                |  25 ++--
 drivers/power/supply/power_supply_core.c      |  14 +-
 drivers/thermal/armada_thermal.c              |  10 +-
 drivers/thermal/da9062-thermal.c              |  14 +-
 drivers/thermal/dove_thermal.c                |   8 +-
 drivers/thermal/imx_thermal.c                 |  19 ++-
 .../intel/int340x_thermal/int3400_thermal.c   |  17 +--
 .../int340x_thermal/int340x_thermal_zone.c    |  28 ++--
 .../processor_thermal_device_pci.c            |  23 ++--
 drivers/thermal/intel/intel_pch_thermal.c     |  11 +-
 .../thermal/intel/intel_quark_dts_thermal.c   |  21 +--
 drivers/thermal/intel/intel_soc_dts_iosf.c    |  22 +++-
 drivers/thermal/intel/x86_pkg_temp_thermal.c  |  20 +--
 drivers/thermal/kirkwood_thermal.c            |   8 +-
 drivers/thermal/rcar_thermal.c                |  13 +-
 drivers/thermal/spear_thermal.c               |   8 +-
 drivers/thermal/st/st_thermal.c               |  15 ++-
 drivers/thermal/thermal_core.c                | 120 +++++++++---------
 drivers/thermal/thermal_of.c                  |  38 +++---
 drivers/thermal/thermal_sysfs.c               |   9 ++
 drivers/thermal/thermal_trace.h               |  17 ++-
 include/linux/thermal.h                       |  50 ++++++--
 26 files changed, 391 insertions(+), 275 deletions(-)

-- 
2.43.0


