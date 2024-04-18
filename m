Return-Path: <linux-kernel+bounces-149777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A38A95BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3611C20FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FA15ADAF;
	Thu, 18 Apr 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2CN5d18"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2D15A4BB;
	Thu, 18 Apr 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431558; cv=none; b=Mujo0KoMcRDIhhaP4RoN2/gwbTBK9/gbh3WKtGCdc41XLMFh7olueTHHVZF4nSzJ5z/O3iuzNFY03iDXkKqY9pTuETJTHDBrU/l7wBvrhUPFhfJm4aACwm86TFkDNUWrEPLa69/Te00VKdzPyOVFEoR9Di86pQ+Ce0tGFaSUWRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431558; c=relaxed/simple;
	bh=4t2cLoLBXffGWFuuzf20vblalSwZwoEoyJ/BXtoEVhc=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=bje//TsXdMi7pBfVbduLmb7BcS0GSPWIkVLIxmMX25zAV9SkeeRIE/vO1toZoXc2EwU38L3/DOwFZBXmykOER1sExqi8zf8T4+ANZpXZYZz5hdc6gBDP1/07Uz0BaS8k1ibrOKFAMjiR9AVcjroDgZQGSQVl8fezbmbN7ZBCQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2CN5d18; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713431556; x=1744967556;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4t2cLoLBXffGWFuuzf20vblalSwZwoEoyJ/BXtoEVhc=;
  b=n2CN5d18i5LHASZMsaBYG87Rr/8pUAetZojaSn5qJPeJ4VdyZPKh1V/t
   2U343n/mvh5WGKgY0ucpBn6+jYDnMXCUYSHVpXCGxaiPrKg63Oy1GX0Un
   rKghgJ0LWhpAaTp33rSGZCz9z/iiyRCFkKhBmCqbDJ7P6cm+qgjrhB3gq
   GUBsKfBbN7oEvIO8Gt+YZ8oXJaMMjf4ZWQh2ftfQOEJmnJexh0GKQuE3E
   kAvud1FAoXs/nxAC5QYDj4MLrBecPRridtaW/e+HYIEya/ZC1pTu4XfZe
   P2Jof9aBApU9BpmMEpWFIz4hDtAk8OA1ukpBW4Swjfd6YABQK9AL5wCv7
   w==;
X-CSE-ConnectionGUID: VhbnCsBiSAC6CNClbW3fKw==
X-CSE-MsgGUID: U/xzei4XRk6rTgXre82UYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12803418"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="12803418"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:12:34 -0700
X-CSE-ConnectionGUID: opN75KlGSvCABr06Ru7qHA==
X-CSE-MsgGUID: PN5c//8OTkS3wx6mFqLPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="60343594"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:12:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 18 Apr 2024 12:03:32 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.9-3
Message-ID: <pdx86-pr-20240418120332-847319520@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.9. Except for adding the
quirks support code into amd/pmf, this one has simple and well-contained
changes.

Changes:
 - amd/pmf: Add SPS notifications quirk (+ quirk support)
 - amd/pmf: Lower Smart PC check message severity
 - x86/ISST: New HW support
 - x86/intel-uncore-freq: Bump minor version to avoid "unsupported" message
 - amd/pmc: New BIOS version still needs Spurious IRQ1 quirk

Regards, i.


The following changes since commit e71c8481692582c70cdfd0996c20cdcc71e425d3:

  platform/x86: lg-laptop: fix %s null argument warning (2024-04-08 18:32:14 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.9-3

for you to fetch changes up to f609e7b1b49e4d15cf107d2069673ee63860c398:

  platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes (2024-04-17 17:05:30 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.9-3

Changes:
 - amd/pmf: Add SPS notifications quirk (+ quirk support)
 - amd/pmf: Lower Smart PC check message severity
 - x86/ISST: New HW support
 - x86/intel-uncore-freq: Bump minor version to avoid "unsupported" message
 - amd/pmc: New BIOS version still needs Spurious IRQ1 quirk

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Extend Framework 13 quirk to more BIOSes

amd: pmf:
 -  Add infrastructure for quirking supported funcs
 -  Add quirk for ROG Zephyrus G14
 -  Decrease error message to debug

intel-uncore-freq:
 -  Increase minor number support

ISST:
 -  Add Granite Rapids-D to HPM CPU list

----------------------------------------------------------------
Mario Limonciello (4):
      platform/x86/amd: pmf: Decrease error message to debug
      platform/x86/amd: pmf: Add infrastructure for quirking supported funcs
      platform/x86/amd: pmf: Add quirk for ROG Zephyrus G14
      platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Srinivas Pandruvada (2):
      platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
      platform/x86/intel-uncore-freq: Increase minor number support

 drivers/platform/x86/amd/pmc/pmc-quirks.c          |  9 ++++
 drivers/platform/x86/amd/pmf/Makefile              |  2 +-
 drivers/platform/x86/amd/pmf/acpi.c                |  7 ++-
 drivers/platform/x86/amd/pmf/core.c                |  1 +
 drivers/platform/x86/amd/pmf/pmf-quirks.c          | 51 ++++++++++++++++++++++
 drivers/platform/x86/amd/pmf/pmf.h                 |  3 ++
 .../x86/intel/speed_select_if/isst_if_common.c     |  1 +
 .../intel/uncore-frequency/uncore-frequency-tpmi.c |  4 +-
 8 files changed, 73 insertions(+), 5 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

