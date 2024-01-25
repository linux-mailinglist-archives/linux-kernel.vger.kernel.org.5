Return-Path: <linux-kernel+bounces-38161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295583BBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB28EB259C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29B179B2;
	Thu, 25 Jan 2024 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3bwHqv8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0FE175A6;
	Thu, 25 Jan 2024 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171004; cv=none; b=iDD3D2kDzT034tja7tkkgHCIIzWSVIZlwpI17p3ex/PKAwLIPACdLl7STJI7Fv70/steV6sTpI11H+Quou7aVLz2fNnwm0gGrBaZfx52ZX56iCd0w+2bkyvcmH4Pmpl63vRJ9iJELzQ9fxYFhMCshMHhUtxQj4x3sUALwuZUslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171004; c=relaxed/simple;
	bh=ofAp7FKQ4FQiM93DkKntiQVWC6L/hziULomq9Z95xuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lhpn3aJIqq5Do5pMTZwBzR3v4cNE8nnnmG6rjvogHxWz5uGgz74vNZRj5SoV88KChJr8uZ9uEha+f/tySSuAgniijsUS34NpA8kjoL7ckIpGISAaTWIkFKmnd3shRWpahwGVhf/an4TjPubHV6kk70OdOrhCKVc9+JPIZqs9cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3bwHqv8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706171004; x=1737707004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ofAp7FKQ4FQiM93DkKntiQVWC6L/hziULomq9Z95xuI=;
  b=c3bwHqv8pzVYJfaDE+ED4jogoi+9SwtG37w0pj/DTUQ8S+yYonjPG9+P
   7RSQmVYEUiOplsAOeNd/5rZzTiK5kmem3UWp/xWwGqoI2r7tK+hN55xFG
   sDESxxG/BV9Cr6RByRgkZBnS/AtBR8+TINwZvA1VZ/ZD7GV/POZupd6cz
   NAEXSJnYEfMvXipttnm/T+VDdWjn/wgeRX2lSiKGaXEIec30TDvISNI6W
   zQ5fDdEZvBCVuNqLIk/2L98fhKp/D2JIp/p/OaUGlbOlkTpbr988yWbZ1
   HbG5y2L0ILUMxxEr7Ykge3h7IHskLPd7yoQAR7+IdhG4LAHL12jCE91W1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1987165"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1987165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876975919"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="876975919"
Received: from araj-ucode.jf.intel.com ([10.23.0.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:21 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	markgross@kernel.org
Cc: Jithu Joseph <jithu.joseph@intel.com>,
	rostedt@goodmis.org,
	ashok.raj@intel.com,
	tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	patches@lists.linux.dev,
	pengfei.xu@intel.com
Subject: [PATCH 0/5] Miscelleanous fixes and improvements to Infield Scan
Date: Thu, 25 Jan 2024 00:22:49 -0800
Message-Id: <20240125082254.424859-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hans,

This series has some bug fixes and improvements for Infield Scan.

Patch1 - fixes a bug in the driver that didn't release_firmware() in the
	 error path.

Patch2, 3 - Added some improved tracing.

Patch4 - Moves the rendezvous to function entry
Patch5 - Adds entry rendezvous for IFS.

Cheers,
Ashok


Ashok Raj (4):
  platform/x86/intel/ifs: Trace on all HT threads when executing a test
  platform/x86/intel/ifs: Add current batch number to trace output
  platform/x86/intel/ifs: Replace the exit rendezvous with an entry rendezvous for ARRAY_BIST
  platform/x86/intel/ifs: Add an entry rendezvous for SAF

Jithu Joseph (1):
  platform/x86/intel/ifs: Call release_firmware() when handling errors.

 include/trace/events/intel_ifs.h         |  12 +--
 drivers/platform/x86/intel/ifs/load.c    |   3 +-
 drivers/platform/x86/intel/ifs/runtest.c | 101 ++++++++++++++---------
 3 files changed, 70 insertions(+), 46 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.39.2


