Return-Path: <linux-kernel+bounces-162190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B48B577C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E12B23C40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A07535C1;
	Mon, 29 Apr 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mkttzl4i"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F12453383
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392559; cv=none; b=tE23TgDaigPUxtkb0yuW1jKoEMEQMynietuXNjMArzLBTRcqYGduXPRngOBeXbUl0pKt5OFs532mP5bpZ4p2aJhF/coz2yIvFoTPeyQp8IsQOFrE8M85+yyTs31rzOGAIBsngjBb1KfkvE2d2VInV0dqejhg/KxVUR2IbEYNyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392559; c=relaxed/simple;
	bh=cmmYFumDuVIgpK5GLI1/Cu47OCHlbwTYGbFG7cJ59Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLKpJVtgx0OikxvQDbjuxOQ8Kg+/dlSbzX7Kqdb5suns/+BA5DxlZonEmgDq1lBo3XFysB7vLK1ZjzsuLF5YbHmxA5Rgl/AIh/6GHDIqCHDXpvvdSJ35cfj8DfKDk7BVHYsunYW1D6OGUS6gpUzZ3Z/hoXAKn2RZB6uhkm/eGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mkttzl4i; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392558; x=1745928558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cmmYFumDuVIgpK5GLI1/Cu47OCHlbwTYGbFG7cJ59Eg=;
  b=Mkttzl4i/tYOw+Lb5iAB5cubmo76nVtnsG/sFdjvbyWUH6oUqBy3899r
   5MYFxSBYLVtvRYyUmw6LMAXazcvEssMzjIl+m/jqFSRwDilgqS3L1B/uN
   GCIX5IgWCEcZt+6QDngRdIYEmXxGwJTDGHMI6IEAMS6ilaOmot+cjtcJ2
   OjKoax4F658Hzb+hZME0PAHubQcwQqjQMr47RJyDNc9YiEd0fSO/VmIXN
   9HJ0xZrcCT3zJiqzNlDDRsOiwmHMSpnZwvGitU8RMNSjglokkx0R0UyO4
   SwGkOxFh2AjPx596Ddqj6G0siHkSj+t/FP3PfE/hWP8ylJDFDj+MO8bOj
   A==;
X-CSE-ConnectionGUID: Lg5+8zn6Rt2une+IOIsaPA==
X-CSE-MsgGUID: 4DzliytbR5Sk/WkI6sRlJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908205"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908205"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:17 -0700
X-CSE-ConnectionGUID: mugos1zuTIW+q/IzCyE5tg==
X-CSE-MsgGUID: ftGtMMGHRjOXaZNkFzX1BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166605"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:15 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 00/14] stm class/intel_th: Updates for v6.10
Date: Mon, 29 Apr 2024 15:08:54 +0300
Message-ID: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are the patches I have for the next cycle. The bulk of them are new
PCI IDs. Besides that, there are cosmetic changes, one actual bugfix and
a new feature added to the SyS-T protocol driver that uses a specially
designated format for ftrace data. I dropped Uwe's patch as he'd resent
it himself earlier today. Please consider applying. Thanks!

Alexander Shishkin (6):
  intel_th: pci: Add Granite Rapids support
  intel_th: pci: Add Granite Rapids SOC support
  intel_th: pci: Add Sapphire Rapids SOC support
  intel_th: pci: Add Meteor Lake-S support
  intel_th: pci: Add Meteor Lake-S CPU support
  intel_th: pci: Add Lunar Lake support

Colin Ian King (1):
  intel_th: Remove redundant initialization of pointer outp

Dan Carpenter (1):
  stm class: Fix a double free in stm_register_device()

Li Zhijian (1):
  intel_th: Convert sprintf/snprintf to sysfs_emit

Mikhail Lappo (3):
  stm class: Add source type
  stm class: Propagate source type to protocols
  stm class: sys-t: Improve ftrace source handling

Randy Dunlap (1):
  intel_th: msu: Fix kernel-doc warnings

Ricardo B. Marliere (1):
  intel_th: Constify the struct device_type usage

 drivers/hwtracing/intel_th/core.c |  8 +--
 drivers/hwtracing/intel_th/gth.c  |  8 +--
 drivers/hwtracing/intel_th/msu.c  | 12 +++-
 drivers/hwtracing/intel_th/pci.c  | 30 ++++++++++
 drivers/hwtracing/intel_th/sth.c  |  2 +-
 drivers/hwtracing/stm/console.c   |  1 +
 drivers/hwtracing/stm/core.c      | 19 ++++---
 drivers/hwtracing/stm/ftrace.c    |  1 +
 drivers/hwtracing/stm/heartbeat.c |  1 +
 drivers/hwtracing/stm/p_basic.c   |  3 +-
 drivers/hwtracing/stm/p_sys-t.c   | 93 ++++++++++++++++++++++++++++---
 drivers/hwtracing/stm/stm.h       |  2 +-
 include/linux/stm.h               | 12 ++++
 13 files changed, 162 insertions(+), 30 deletions(-)

-- 
2.43.0


