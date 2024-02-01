Return-Path: <linux-kernel+bounces-47469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24665844E59
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EDE1F2795D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01F17554;
	Thu,  1 Feb 2024 01:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rhdg2tRq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A2EEBC;
	Thu,  1 Feb 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749671; cv=none; b=rJ0///kYrn/bHSVG+GSZb7tPHD+W7GXm+pWC5hKoqyg4tVFpBou1i76ZkR7E9pYlFZbn/gxqUBdcf1UCk6D59arFlufyQugKGVEKVIy7MdfxOCtmtbrZr3Fd8eDLq96VfJ1SqB5W3Bn/0maxcgQOjhV7+iSY3888C001hCjPV+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749671; c=relaxed/simple;
	bh=sgswDJ0/htVOz3WVOuv+cYmW9CPfnvSDXlyt6t537J8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QALFxgcc+tSfRwmkc+e1ASpQuO7Vcqse9t9g5F3YQ0pGejjLRvnRSSCBw6197Ow/1ml4Pv1Pk5mOetouZW5MjDs0sRc6KGprl+BLdY2ArGw2CLuMrK8C9RMDvUNdCBwDBaEkp1X2KjTUBtDSaXzqeh8HSZck3es6qB9s43PpnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rhdg2tRq; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749670; x=1738285670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sgswDJ0/htVOz3WVOuv+cYmW9CPfnvSDXlyt6t537J8=;
  b=Rhdg2tRqGrTZca52z3CbT7a8tp6Kk8n59EVIHNP2zTfwpWag707lE9hL
   LSXFldkNKf7kAPjHzVr7WgoLyDh5PanlO3lavTrhdndClyJWvlIHux6lb
   HHfcv6K2dbwTFdXXcVJZr4QEPZ8oCNe0qmxthSCMHozNyp+OJH9Whcb/8
   H3Y9++XjHGadjZr10d4BnQTQB/BeFl1AFFO3rUqC31BqAkSJJXMT3N6UV
   4UcjGwoaPmK4tPUMg3ASm3bghZeiEYyJM5tFiWDs0oG+Z0YXPTlArHjKO
   Afajsa/CaHD0ZsucYxbP9ODIZJzwGS01+qa09M3WHvRXD20KA0nXRUZB4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10533012"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10533012"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4265158"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:48 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 252B0580201;
	Wed, 31 Jan 2024 17:07:48 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/8] Intel On Demand: Add netlink interface for SPDM attestation
Date: Wed, 31 Jan 2024 17:07:39 -0800
Message-Id: <20240201010747.471141-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series primarily adds support for a new netlink ABI in the
Intel On Demand driver for performing attestation of the hardware state.

Attestation patches

Patch 1: The attestation mailbox command requires that the message size
register be set along with the package size. Adds that support.

Patch 2: The attestation command will need to write the SPDM message and
read the response. The current mailbox flow handles reads and writes
separately. Combines the two flows.

Patch 3: Patch 4 will create a separate c file for the netlink
interface. Add a separate header file now. No functional changes. This
mostly just makes it easier to see the changes in Patch 4.

Patch 4: Adds attestation support to the driver and provides a netlink
interface to perform the service.

Other changes

Patch 5: Adds support to read the in-band BIOS lock. If set, On Demand
controls are not available in the driver.

Patch 6: Adds a new attribute to allow reading the most current metering
state.

Patch 7: Fixes for the intel_sdsi tool

Patch 8: Adds support to the intel_sdsi tool to read the current meter
state.

David E. Box (7):
  platform/x86/intel/sdsi: Set message size during writes
  platform/x86/intel/sdsi: Combine read and write mailbox flows
  platform/x86/intel/sdsi: Add header file
  platform/x86/intel/sdsi: Add netlink SPDM transport
  platform/x86/intel/sdsi: Add attribute to read the current meter state
  tools: Fix errors in meter_certificate display
  tools: intel_sdsi: Add current meter support

Kuppuswamy Sathyanarayanan (1):
  platform/x86/intel/sdsi: Add in-band BIOS lock support

 Documentation/netlink/specs/intel_sdsi.yaml |  97 ++++++
 MAINTAINERS                                 |   3 +
 drivers/platform/x86/intel/Makefile         |   2 +-
 drivers/platform/x86/intel/sdsi.c           | 317 ++++++++++++++++----
 drivers/platform/x86/intel/sdsi.h           |  47 +++
 drivers/platform/x86/intel/sdsi_genl.c      | 249 +++++++++++++++
 include/uapi/linux/intel-sdsi.h             |  40 +++
 tools/arch/x86/intel_sdsi/intel_sdsi.c      |  99 +++---
 8 files changed, 754 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/netlink/specs/intel_sdsi.yaml
 create mode 100644 drivers/platform/x86/intel/sdsi.h
 create mode 100644 drivers/platform/x86/intel/sdsi_genl.c
 create mode 100644 include/uapi/linux/intel-sdsi.h


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.34.1


