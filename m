Return-Path: <linux-kernel+bounces-101244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EC387A48E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645A2283474
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11621C68E;
	Wed, 13 Mar 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuTc8L7D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E2B1B7E8;
	Wed, 13 Mar 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320678; cv=none; b=STvY8VWyW24toXmQ7MKLnPq1fiByYW1Y5V7DeOXyU5d7XgezDg1+Lru06fRTcwYL01HK6KlikMI7CQNAXOSDLpI7vfy/Cwy9/AZLnL0fq/8PF3uz/OfnKQpxynnIwzvC/GFfM+hffM+dcFSuqT9D5lnOF90f9U6VMFiSeJGcqwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320678; c=relaxed/simple;
	bh=ZlgZeKFBc/YXjSJVt7esv2L+eHZOte5Gll/749YGkk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WW1287/5PmVx70jIbWTqlVVmy/2qt6doAxiZbzVKGgguNUTl8uaoSfXGIShBMpkO1lF98wQotFddq+QQZEtMk3SNpEfKVDJ1k7+8+gnEMgun0zAIasaDDDE5cb5w3pFPYplYzsvGvvJerealK+L+CpCnMsl7JQS8V/PMW9/Yk2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuTc8L7D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710320676; x=1741856676;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZlgZeKFBc/YXjSJVt7esv2L+eHZOte5Gll/749YGkk0=;
  b=AuTc8L7DiP1YMM8Zyp6mchRT4htjwaT+jGK4tpx8B3KpZmdZA+PE9Jp0
   y+GLKTIHa7kVs+DtbHytdzdQfElQ6cdasqpHWWc2fQUwfBKCRNNYG4h1j
   RIzsc1ZY/nWBp/WS+bxL3qosVU0ZHK7pZM+bxEFrHZxCcPCRT36NmFIFG
   jDXlHsjA5a+xkR0wpXobsKdg6Drm/6IIBR0sUNVwwntOaejMTfFZ9uiWq
   MtP9pqqoLMeKX4eGSbmaIkepotnP3Tt7urM1k4mkxjOC7DnbmMBnVNsvh
   6b5IAb6hmuBVa3KQ4duXc8TzyxiYxb6+yGneQslwo9oSuj4cE3ZgLr42l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22586874"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22586874"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265599"
Received: from s2600wttr.bj.intel.com ([10.240.192.113])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 02:04:33 -0700
From: Li Ming <ming4.li@intel.com>
To: dan.j.williams@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming4.li@intel.com>
Subject: [RFC PATCH 0/6] Add support for root port RAS error handling
Date: Wed, 13 Mar 2024 08:35:56 +0000
Message-Id: <20240313083602.239201-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protocol errors signaled to a CXL root port may be captured by a Root
Complex Event Collector(RCEC). If those errors are not cleared and
reported the system owner loses forensic information for system failure
analysis.

Per CXL r3.1 section 9.18.1.5, the recommendation for this case from CXL
specification is the 'Else' statement in 'IMPLEMENTATION NODE' under
'Table 9-24 RDPAS Structure':

	"Probe all CXL Downstream Ports and determine whether they have logged an
	error in the CXL.io or CXL.cachemem status registers."

The CXL subsystem already supports RCH RAS Error handling that has a
dependency on the RCEC. Reuse and extend that RCH topoogy support to
handle reported errors in the VH topology case. The implementation is
composed of:
* Provide a new interface from RCEC side to support walk all devices
  under RCEC and RCEC associated bus range. PCIe AER core uses this
  interface to walk all CXL endpoints and all CXL root ports under the
  bus ranges.

* Update the PCIe AER core to enable Uncorrectable Internal Errors and
  Correctable Internal Errors report for root ports.

* Invoke the cxl_pci error handler for RCEC reported errors.

* Handle root-port errors in the cxl_pci handler when the device is
  direct attached.

The implementation is only for above case without CXL switch, still
remain two opens to be discussed.
1. Is it compatible for CXL switch port error handling?
CXL switch port error handling proposal has not yet been finalized.
Should confirm that this implementation will be compatible with that.

2. How to handle the case which CXL root port reported CXL.CM protocol
erros by itself?
Not support for this case in the patchset at present, my opinion is that
invoking the cxl_pci handle to deal with such case as well.

base-commit: 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5 branch: next

Li Ming (6):
  PCI/RCEC: Introduce pcie_walk_rcec_all()
  PCI/CXL: A new attribute to indicate if a host bridge is CXL capable
  PCI/AER: Enable RCEC to report internal error for CXL root port
  PCI/AER: Support to handle errors detected by CXL root port
  cxl: Use __free() for cxl_pci/mem_find_port() to drop put_device()
  cxl/pci: Add support for the RAS handling of RCEC captured errors on
    RP

 drivers/acpi/pci_root.c |  1 +
 drivers/cxl/core/pci.c  | 89 +++++++++++++++++++++++++++--------------
 drivers/cxl/core/port.c |  9 +++++
 drivers/cxl/cxl.h       |  2 +
 drivers/cxl/mem.c       |  5 +--
 drivers/cxl/pci.c       | 12 +++---
 drivers/pci/pci.h       |  6 +++
 drivers/pci/pcie/aer.c  | 44 +++++++++++++-------
 drivers/pci/pcie/rcec.c | 44 +++++++++++++++++++-
 include/linux/pci.h     |  1 +
 10 files changed, 155 insertions(+), 58 deletions(-)

-- 
2.40.1


