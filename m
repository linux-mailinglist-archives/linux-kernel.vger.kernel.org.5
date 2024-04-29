Return-Path: <linux-kernel+bounces-162199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C78B5785
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F132D28714F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9047440B;
	Mon, 29 Apr 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI2NDMoK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFB77172F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392574; cv=none; b=qSYmSPGsxxjMvutqIIyhK+moW6SspaRo01mZJTqPjOUYbS6UtFT4eAAQYlcLNA/TrN+CJytlAFqLTEG4a9slUFgL6XSfELY6HPaUA7f/P8gELotmw3t4BWcRt7G5c+uzo2I9XRUhtd9TMW3N172pwceNiZyIQ2ttgqKANSmY2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392574; c=relaxed/simple;
	bh=O/tPLmmDVxjWqjenqSekjhHbDwgCsVPjYLagOWXNRp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+8kA3Ox/ogIs4uhM48CbON6T4X8KBSB1dSEXahMcaVQqisuXtOACmOjZbi7Jo7emUpgL1McglAJXtzRILJUVvaTDRM2NUr3E/25Q66tcc9NZoQGGNA3JHUPwnPb6ieBNMySiQWHXyi+ATmMIE/W4tXex5SiL4Y0q9jblKU8bMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI2NDMoK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392574; x=1745928574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/tPLmmDVxjWqjenqSekjhHbDwgCsVPjYLagOWXNRp4=;
  b=OI2NDMoKkW2DqsVryK0e9usaAIGA810T5XY1xo0dhBkyr1kMFKNdz3YC
   5aRyxh1B7nS2rIoGY3DMhiSwDKg6kzVY+vRQF0C6D7KrPKy1/95a6Z0BQ
   d9gnTchLBMDUojcSfirTI8qnIvRAaEte8BgCOTZk0yCEFE4R5WG1uAxUf
   254xom6frJ92LBZQ9wui/wO4f/Ue1tX0GFgtSfW+S+AXl81BaZX32sdSE
   NaUbOuqf1JhlXfCsw7LwLGdcaikCpjezZWBl/hZtx2DeEJPIellEQjTvw
   yNOK3s9cJRx25dIZ/BQbV9NDfbhSvNmYpE37wv7htTUl+srxeNBZGtG1i
   g==;
X-CSE-ConnectionGUID: JS4nHBeLTM+hGkZKdZa68A==
X-CSE-MsgGUID: 7ved6F7dRDexdhUahYbv+g==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908273"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:33 -0700
X-CSE-ConnectionGUID: C047f2fIQheXzXzzLbaS3w==
X-CSE-MsgGUID: dBOOQmHvRRahGC3vX9h26w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166644"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:31 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH 09/14] intel_th: pci: Add Granite Rapids support
Date: Mon, 29 Apr 2024 15:09:03 +0300
Message-ID: <20240429120908.3723458-10-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
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


