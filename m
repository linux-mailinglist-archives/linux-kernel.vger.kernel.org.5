Return-Path: <linux-kernel+bounces-162318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC38B594E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941891C24173
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07145823CD;
	Mon, 29 Apr 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNu4S6J+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794F6E5EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395733; cv=none; b=XpizbJE/qvO0AReS5g0yOdnw4hekA7UUyxijCBlddZ55XSQzZkXQwupErclixj5CnFVRBvn0kfxwYZEpIi/wgBkKAMb3yTDdKsBT9putPnYoXVv3zDIg9oc8qjvduBH4va3ilf1JYZyH+kYKqLjBUN7KR7/qf8pwwQ6v6FVR2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395733; c=relaxed/simple;
	bh=XHEQAft4tZaQ2JdNqTSsJ60xy1/uNy4H7i3u5WPmZVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W88Wb+RD3d/G0KzZt5G0Y/7MFgRDe49951v+LIoXe2LziqeT0LJx9ZL2lvzye2p7dlKuoLHbM9rEDRzWQH4L1knkmiLyslsxpc3CmHwVO056McP41jaZlmprFiUy5J0js6pxpJlaZEZt/groLzgePAgyRJi5tjZeXnYb9zsjimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNu4S6J+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395732; x=1745931732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHEQAft4tZaQ2JdNqTSsJ60xy1/uNy4H7i3u5WPmZVk=;
  b=fNu4S6J+VvcIxGYPd02J7ac77ITSXHxKmQGslLj1t6BBHLvEc4jsgIFN
   gHu+ZjemRaRIAsxTC6Xty4X1bupFf/ikx5Z5Euuzg+v9lvdr6LT3x/v+I
   /zd4oBWCNMAAwFZfmffA4MLJDECWbkj68fF/sZhz5SdHgaxSrVKhi3WJJ
   beY1dTUCDR0e0wVmj+MrryPOuF1BGufyQBKtSjWfaB8c11Jd+4da5IT6i
   itDoGS4hX3kKqvNQAuZQ5i31ZL4Pd4UjJvZ5Qm5j0/YeXtXiPUOqFxd3f
   BP/jLAQSsipZ8SuXQgXwBybjTU6mIsUXR1OKMQbmyILsKkL92+k5iUHT5
   w==;
X-CSE-ConnectionGUID: UkKW/IYlRFS4AkxADYWvXA==
X-CSE-MsgGUID: THZnSlxURLa8HpkGuIzQ+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986991"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986991"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:02:12 -0700
X-CSE-ConnectionGUID: Wcmsk7B3SPyVEee2IPaVZw==
X-CSE-MsgGUID: TgdXCZUOTT2TppTd1Nyopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507223"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:02:09 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@kernel.org
Subject: [PATCH v1 15/15] intel_th: pci: Add Lunar Lake support
Date: Mon, 29 Apr 2024 16:01:19 +0300
Message-ID: <20240429130119.1518073-16-alexander.shishkin@linux.intel.com>
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

Add support for the Trace Hub in Lunar Lake.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@kernel.org
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 0db8ff9b1c48..0d7b9839e5b6 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -324,6 +324,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x3456),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Lunar Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.43.0


