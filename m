Return-Path: <linux-kernel+bounces-131367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6148986CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8B2B22AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6A86251;
	Thu,  4 Apr 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OywZdv+/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0252F83CDE;
	Thu,  4 Apr 2024 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232544; cv=none; b=Teq8G5Zj77pYfW1ISvqp0lsPD6gT5AGsSy1e0z5DAo6Vbp1mPLSUZSRuYaEdLRonzbJrncfrZsYJNN7wKgSbuZ1jhx5aMIMGICDhTqv9tHWrSM+7rNRyUQmrnd/Y8mrPvMMvNbdP8DnDtYJH2sYdbk8dZKmwaHdh6pV7gX9BXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232544; c=relaxed/simple;
	bh=WI1uWSpbH+taq5nN5u8OiULfON++sqzT2/PBEwaYVzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AumLWX8/OSGzRvL09e4iCJD0gH33zxDn+YU7PluG1eSY4fzi1s/QCPs/M3FvuLjFB7U2H2NjdePhT5shtgTnvVPqnnyDfDthUgC/uslk9GsvPC43lNoUto4U7W7neHxGhxAkvi1nT5KpMmmrXisJbSX1m1FHlk9+DcPG2Eaplkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OywZdv+/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712232543; x=1743768543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WI1uWSpbH+taq5nN5u8OiULfON++sqzT2/PBEwaYVzk=;
  b=OywZdv+/BReZBCaZQ34EJFSg1V261u1xXm0nUEZnF0nTp8nDaWHtg7Ta
   saRP68CamRA02vkO17UkYRLvrugOCiJN00TNW54eXUQtWBKz6YPfQg6Ad
   NNRlRlWcZYxtRru+NaXJ+uFiIfXMNxLawms9Bfrmu2FEXimNJcaCiyQWF
   fd9Hlj+Vnw3gEUETkgh7YHx8MFN5BfoioTxI4i4nXSDoDntAtpMcfKdZ4
   JkaYhRxmKaDfHh2TLVrlLCk+ye50ntbrnqkgZGSwywsS7MWzOYZuS8Lbd
   oSwyx2M1scWuotYazrvEUNLMx1WLEVDHQKk8eHax+71DEzVc1la7fhE4x
   w==;
X-CSE-ConnectionGUID: m9rnv1vCQZCnaOAlgugD7g==
X-CSE-MsgGUID: lyuR2Sl7R3GTetVBSvwlXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18240564"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18240564"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 05:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="937086416"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086416"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 05:08:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7D46C13B; Thu,  4 Apr 2024 15:08:57 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ACPI: LPSS: Advertise number of chip selects via property
Date: Thu,  4 Apr 2024 15:06:58 +0300
Message-ID: <20240404120856.4109303-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
References: <20240404120856.4109303-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise number of chip selects via property for Intel Braswell.

Fixes: 620c803f42de ("ACPI: LPSS: Provide an SSP type to the driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 04e273167e92..8e01792228d1 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -325,6 +325,7 @@ static const struct lpss_device_desc bsw_i2c_dev_desc = {
 
 static const struct property_entry bsw_spi_properties[] = {
 	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BSW_SSP),
+	PROPERTY_ENTRY_U32("num-cs", 2),
 	{ }
 };
 
-- 
2.43.0.rc1.1.gbec44491f096


