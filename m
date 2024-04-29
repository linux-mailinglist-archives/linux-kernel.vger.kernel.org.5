Return-Path: <linux-kernel+bounces-162312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 316518B59A9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5F2B2BC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9E77D413;
	Mon, 29 Apr 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrvcziBm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834687CF1A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395723; cv=none; b=hLaK2brcenzp3kk0AmGVyIHFbuBSTBNk/se+B8G9B/968C+97RtXhMJq/jMwLaaFRhGCDcWSub58BNBm+oaIrX1MWPE5zJqaL4g4vsGnIxso7py5Znv5QpJrvZvy3InSI8ESv/3U9dNUforBaYu1UfMdfEsramcAFvA22Z81/f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395723; c=relaxed/simple;
	bh=O/tPLmmDVxjWqjenqSekjhHbDwgCsVPjYLagOWXNRp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IwJrGdhCK9v00hOl27EMU9Nyz+DFXGe9DliDRqlwRYnoQQyW4SYTuUTQXfnLgiUNfTKAiwOfMZZFWQIK4Pgpt0JUVexOk7pkCF4aP5SLFGqh3w78F5+M/xqBvIRYcAqAi+MLvH+hcYDmU4ckYlqBZWJVBhBaQCczow2ANedm1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrvcziBm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395722; x=1745931722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/tPLmmDVxjWqjenqSekjhHbDwgCsVPjYLagOWXNRp4=;
  b=ZrvcziBmJ0VpxvOOMLtFQ1XuvWSbxuVu1FaXCgfYo0YA/f56jfIGJTf0
   mWIlclwSfRt++mzUiADiIh3NNtDwXTAbGvJN+0Vv1RMyFRky/4oEydFyC
   dhVsftMzX+slRGWoAEdqtjnAP1vNxq6R/CJUP+P6FHW+tMm8lPUTC6ppL
   8iLD97WlmwHttajcQ0sBK825NAoHGdIcBB8jDj5K8rH63UN8l9HVrwRPg
   r0D8ow+1wgCXBWoRms5MQI6s9eMXoKUKUG6Oom5o53lXqB9ZbJgz3RiLQ
   uL/8fe04+lj6swRw8leSVjVSCnjXP6BGF2P6ajZ6510iEXHhdvUdwIOpH
   Q==;
X-CSE-ConnectionGUID: iNN07Kl9TnCUQlMTSWYZEw==
X-CSE-MsgGUID: MVGL8hKkSgW5NfQ/bcSmmQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986932"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986932"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:02 -0700
X-CSE-ConnectionGUID: FJ57NaCrS1KvpHo8ExWBVQ==
X-CSE-MsgGUID: d0S+fIV/TF+0oPJ4LGwhNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507156"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:59 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 10/15] intel_th: pci: Add Granite Rapids support
Date: Mon, 29 Apr 2024 16:01:14 +0300
Message-ID: <20240429130119.1518073-11-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Trace Hub in Granite Rapids.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 147d338c191e..beb4b2766aae 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -299,6 +299,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa76f),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Granite Rapids */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0963),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


