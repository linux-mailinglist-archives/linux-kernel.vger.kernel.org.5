Return-Path: <linux-kernel+bounces-162302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FA8B593F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9701C2149A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599C54908;
	Mon, 29 Apr 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGtcCFnu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C3BC157
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395710; cv=none; b=fOsOt9JALChukjvduevCa73aPNPP8AfMAkOy4PJ0W/vh6Oa7eYhYOgy/Kcd4D9SbuwTml36P0Eh2bK1gKJbfrNLJkg2oLDrKaPJH5hIS3ZrEem24sDIH+YjkTZNuhWFw1rSDfsWMEKK8QSEaaBIUdAHa0pxa5ZBTXqE6QM21IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395710; c=relaxed/simple;
	bh=enQBe9p6lrbKYu0BWmKw7CHPbe1tqldB7qUyByzlSAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qOTS3+M4UVC6fg89cnPzZikMVAKhhxC3ptTuzXkAW51b8zk1ySCmyMdEqqV/R2YGphb8ZSGrKygsRpBOVaRCSzjldb2ypeNx6l5HVaGzo4CYzOVhwfVyHpePG+e4w6nKFEZf/N6M6p2x7Wrj5ekaaqL9RBxn0zApDFvCIJFC1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGtcCFnu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395708; x=1745931708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=enQBe9p6lrbKYu0BWmKw7CHPbe1tqldB7qUyByzlSAQ=;
  b=FGtcCFnueMZ8/khug9NXf5UlUi/pCgHWD7oIllaJBq3ogcq2EiZ8K9Bf
   FToLOMw6fQe3I/aQbO5qD1yYP6BBZK7GeZN1CR4dVTFNBISII008y6nOY
   xBJxRuhxd0khMKB/6ikgpFx2LP1KJ33T8WBgIrDQvIVxVd2xTpPBCKOfL
   qsliq76lWVOo1+o5nriDlbw27z+8MZE5PLG/8a/5cIo4+QP+vjz9eKyvC
   PzNJ2Xh1rcsCL6JrOL24LplL/gXxWDSlvNblXsvSAnD6PdZOnbs2m4zTJ
   LuplJFHfpRvrMlYF5MHijzaF+oI3bPfVX6f2lUsl11mg+1VYbAx3BzYEY
   g==;
X-CSE-ConnectionGUID: 3bZ8LsADTYODsug7UEWs8g==
X-CSE-MsgGUID: tFacR9OLQuWdfxYkQYMJ9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986805"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986805"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:43 -0700
X-CSE-ConnectionGUID: jLhATgoZTlGqJXoHg7AQjg==
X-CSE-MsgGUID: acVChkQGRAmCN0zRYwrn1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507035"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:41 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 00/15] stm class/intel_th: Updates for v6.10
Date: Mon, 29 Apr 2024 16:01:04 +0300
Message-ID: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Here are the patches I have for the next cycle. The bulk of them are new
PCI IDs. Besides that, there are cosmetic changes, one actual bugfix and
a new feature added to the SyS-T protocol driver that uses a specially
designated format for ftrace data. I re-added Uwe's patch converting
platform device's remove: dropping it was a brainfart on my part.
Please consider applying. Thanks!

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

Uwe Kleine-König (1):
  intel_th: Convert to platform remove callback returning void

 drivers/hwtracing/intel_th/acpi.c |  6 +-
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
 14 files changed, 164 insertions(+), 34 deletions(-)

-- 
2.43.0


