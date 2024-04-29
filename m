Return-Path: <linux-kernel+bounces-162317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BD48B594C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C51E289CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A22781AA2;
	Mon, 29 Apr 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/IztecN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2B81723
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395731; cv=none; b=H87mzzq523X+PBQNnh4ix5C9FysHYnnagzTsCcCR/HE0g0Pdv1s+wtK6EWiydKiJe+tJVNQ++Shq0xuLt5YtwWMWEiAB5DBA6/F+x70vmf/mJyxw89bJBbgGhJu+Sr5V9fOgX+N+IkVmkj+sEC7k5rtDGgeqR4xlUxM4zz6tl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395731; c=relaxed/simple;
	bh=4mjB5jRD2LZdYg+WgATpyA8orwgL1dsnFryoaxKiQOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a81230v3dnhK+4MX9e3TYJflcwhTYHyaxmp/V1jlB9qj82TzpTox/AISkEr8bAKjQATnCn4eDtnwzItkQL/GW4gPf7iXXOWLjMvj4ZNnOt6qxzLx/7cOkLvlMOTMQBRVN0u0ZldwWu5Oj0ptr7kkgnmkrcEGaJerZAOMyd8jesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/IztecN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395730; x=1745931730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4mjB5jRD2LZdYg+WgATpyA8orwgL1dsnFryoaxKiQOw=;
  b=P/IztecNcE6AYh+7xMzfcl8z0fS0qJtK7PbJKiXUQ/DmGAKEdlroO8wl
   DS5SR/Uxp1HfNsZy+UqIwbZyMeEvdm+2hkxrP2RNnu7VYf94cRPv1gdOZ
   mEQjMf6wcEY0wMP74bIpYdAw1CCnYuLkjRU9Vfi5x49891TK92qkFiFjM
   77cKtaG8+/LuWPCsWtwzVB1ukzsthgAac9i4dJMfUO2Spt4oCUTsAxtD1
   8sk59SHFEfloSVaUQdI9d9ei4e1ToVPzxrYHvQCVCTunnotjdv29CKXxw
   c9coZMOMO9pRxC4HUv2bq9F8BEyKNWzA0YXIt2Gk2xUl5QH3EmA7y+X5u
   w==;
X-CSE-ConnectionGUID: uJpZveYvRaOUg6l5sJSkxQ==
X-CSE-MsgGUID: lRU2wrx9TbO0IMHFvedgBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986981"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986981"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:10 -0700
X-CSE-ConnectionGUID: GyQSFSRLSOGOwiM5uf0GNw==
X-CSE-MsgGUID: ecBTNo0NRLWu+ggsPkN6yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507215"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:02:07 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 14/15] intel_th: pci: Add Meteor Lake-S CPU support
Date: Mon, 29 Apr 2024 16:01:18 +0300
Message-ID: <20240429130119.1518073-15-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Meteor Lake-S CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 7bb50d414027..0db8ff9b1c48 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -294,6 +294,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7f26),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
-- 
2.43.0


