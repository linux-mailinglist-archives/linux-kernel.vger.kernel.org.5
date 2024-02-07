Return-Path: <linux-kernel+bounces-55992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191884C4A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE812893BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA71BF2A;
	Wed,  7 Feb 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4WUqoU/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9184F1CD19;
	Wed,  7 Feb 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707286145; cv=none; b=qm14XAx4gPHJY02cKvMTllEyQqUoefpAFk+mNS8I06uzwKMoty0Tl9vBZhTKrtkLKpby+MchjF27c6JJOq6XnmkCLyzZ8YWbaFgjH8EmgyKgWC7EbU5w0Pepio/mVbtLRzG46zNoYY7WOOSTzxhldc9DtQgWWlUf+LJ5I7DW3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707286145; c=relaxed/simple;
	bh=vs1FYrqvUZywrcGV2m/wp+FHWnAAr2xnvErEgB/L2sU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j7MwJFCXROv7BU7ZJvw//v5lp/SUMR7ymy1M/wp2libPe0ssxWfk5pOaEke/cGw1tgYh/odW5fuIdV7qGGLLS1CWAp/9v9IPuDU7FUjdFlXzRa/FL1wUa1h6C8VTPQpQBsfuDdcAqkid/Hru2aQ+L2M+I570aU2JGwr7YDZQmHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4WUqoU/; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707286143; x=1738822143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vs1FYrqvUZywrcGV2m/wp+FHWnAAr2xnvErEgB/L2sU=;
  b=k4WUqoU/6WvLGWqgk0+Wbrqn2rVUmdieojxf/Wm5y1P1Cm8FNhEbflox
   4Z3jYVZxavNNLqjj6jF8IieObNw/NYDM05EpI13YZbFwHAC1JQ9gK1FjW
   znYUNd9MLls/eNBjdc+KIJC8VPqIGBsE13PJG3gfCEl/cU9egrXK7GnnG
   HNcYhM7mTjOq6SbLsCAgzzZ3nntcT7ZU+qxC42wv3T6gdRusUcfsz/zVB
   BSnchGsJf0Z+BDBs/bvxMQ6nzWw52T7ewoYJIV4rRmvjHHsv2r/sM0Heo
   HO0CcdFPl9mP9bf8Jm2uJ9M69qNSoJ5RmoDNfYRtSFm3fEnq/tz/GsVei
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="436053909"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="436053909"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 22:09:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="5849712"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 22:08:55 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v4 00/11] Add support for Intel PPS Generator
Date: Wed,  7 Feb 2024 11:38:43 +0530
Message-Id: <20240207060854.6524-1-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The goal of the PPS(Pulse Per Second) hardware/software is to generate a
signal from the system on a wire so that some third-party hardware can
observe that signal and judge how close the system's time is to another
system or piece of hardware.

Existing methods (like parallel ports) require software to flip a bit at
just the right time to create a PPS signal. Many things can prevent
software from doing this precisely. This (Timed I/O) method is better
because software only "arms" the hardware in advance and then depends on
the hardware to "fire" and flip the signal at just the right time.

To generate a PPS signal with this new hardware, the kernel wakes up
twice a second, once for 1->0 edge and other for the 0->1 edge. It does
this shortly (~10ms) before the actual change in the signal needs to be
made. It computes the TSC value at which edge will happen, convert to a
value hardware understands and program this value to Timed I/O hardware.
The actual edge transition happens without any further action from the
kernel.

The result here is a signal coming out of the system that is roughly
1,000 times more accurate than the old methods. If the system is heavily
loaded, the difference in accuracy is larger in old methods.

Application Interface:
The API to use Timed I/O is very simple. It is enabled and disabled by
writing a '1' or '0' value to the sysfs enable attribute associated with
the Timed I/O PPS device. Each Timed I/O pin is represented by a PPS
device. When enabled, a pulse-per-second(PPS) synchronized with the
system clock is continuously produced on the Timed I/O pin, otherwise it
is pulled low.

The Timed I/O signal on the motherboard is enabled in the BIOS setup.

This patchset is dependent on an on-going patch series [1].

References:
https://en.wikipedia.org/wiki/Pulse-per-second_signal
https://drive.google.com/file/d/1vkBRRDuELmY8I3FlfOZaEBp-DxLW6t_V/view
https://youtu.be/JLUTT-lrDqw

Patch 1 adds base clock properties in clocksource structure
Patch 2 adds function to convert realtime to base clock
Patch 3 - 7 removes reference to convert_art_to_tsc function across
drivers
Patch 8 removes the convert art to tsc functions which are no longer
used
Patch 9 adds the pps(pulse per second) generator tio driver to the pps
subsystem. 
Patch 10 documentation and usage of the pps tio generator module.
Patch 11 includes documentation for sysfs interface.

[1] https://lore.kernel.org/all/20240201010453.2212371-3-peter.hilber@opensynergy.com/T/

Please help to review the changes.

Thanks in advance,
Sowjanya

Changes from v2:
 - Split patch 1 to remove the functions in later stages.
 - Include required headers in pps_gen_tio.

Changes from v3:
 - Corrections in Documentation.
 - Introducing non-RFC version of the patch series

Lakshmi Sowjanya D (6):
  x86/tsc: Add base clock properties in clocksource structure
  timekeeping: Add function to convert realtime to base clock
  x86/tsc: Remove art to tsc conversion functions which are obsolete
  pps: generators: Add PPS Generator TIO Driver
  Documentation: driver-api: pps: Add Intel Timed I/O PPS generator
  ABI: pps: Add ABI documentation for Intel TIO

Thomas Gleixner (5):
  e10002: remove convert_art_to_tsc()
  igc: remove convert_art_to_tsc()
  stmmac: intel: remove convert_art_to_tsc()
  ALSA: hda: remove convert_art_to_tsc()
  ice/ptp: remove convert_art_to_tsc()

 .../ABI/testing/sysfs-platform-pps-tio        |   7 +
 Documentation/driver-api/pps.rst              |  22 ++
 arch/x86/include/asm/tsc.h                    |   3 -
 arch/x86/kernel/tsc.c                         |  90 ++-----
 drivers/net/ethernet/intel/e1000e/ptp.c       |   3 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |   6 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c |   3 +-
 drivers/pps/generators/Kconfig                |  16 ++
 drivers/pps/generators/Makefile               |   1 +
 drivers/pps/generators/pps_gen_tio.c          | 245 ++++++++++++++++++
 include/linux/clocksource.h                   |  27 ++
 include/linux/clocksource_ids.h               |   1 +
 include/linux/timekeeping.h                   |   6 +
 kernel/time/timekeeping.c                     | 112 +++++++-
 sound/pci/hda/hda_controller.c                |   3 +-
 16 files changed, 466 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

-- 
2.35.3


