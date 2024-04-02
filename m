Return-Path: <linux-kernel+bounces-128243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C14B895839
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7481C22DDD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40B13398E;
	Tue,  2 Apr 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmBBI6y8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858E13175D;
	Tue,  2 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071803; cv=none; b=LPc1L+utBfnbnUATdlWB4s1A9K1MyRxAKTJA+KLgwdSnJJT0cCN8kjVrLcgSJzIg2muCnMeh+4pXdJlMBB7YG5PSSQbg7C95+7M93NHFI+u1SxrYtP3YXe2gTvSl6IcfODeCNb5L/Vo+a0BajtT3tJhsepUc92j0wiTuPpNdEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071803; c=relaxed/simple;
	bh=rqVurMiCivJ0gWGCbPcucCSz51pxMDQmeUQYco0dJ5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgobCEpr6o1CBPPutEkqDKDwsbTj6WL6fGCv2Vqua7tP/M4a3Mzhw7h7/yzF46drO1TymFGdJuJdt55SZzhASfRmEKdPPs0XEKxxQDBJSyD1HiBWEf9DWRGS4rQ7gyL3yCjtQ2MOy/hxZNr346Y71zWNDGSUQBaHQ19WvlDWmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmBBI6y8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712071802; x=1743607802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rqVurMiCivJ0gWGCbPcucCSz51pxMDQmeUQYco0dJ5o=;
  b=WmBBI6y81cEeJ3czfSEaIhYBygTomMOetKalwfvY5Ezs8zMVF+Wbn9w+
   rpOJHqoEX7Hhxq80gQ8daTr4/nulmv8+ZLRy6tj2i9QKAzj6GoG5zy82l
   SuR8Xwb/VgKgOkFRrhTXyz6n75C2ImJx2O5PNCsCJMO4vRVRtmskFJAoe
   SaI74O8XahTLAwwzuMx+3K4frSFUZM+55gfx3FUOEwiOexuVAkYRJcQ9z
   umYOfcfVSkLJ7aS0m9B/Di407FoVEH8jbw/0oqZryhbivekCvPrl0VY3o
   ca+XWrpp+ebVsUvpalgKRdox5JX3vWQ243tY0Ao3LjGpEclSlusUIOj1k
   w==;
X-CSE-ConnectionGUID: mUYlgKelR2atBTAqUnEagw==
X-CSE-MsgGUID: 425KLKtkQN6enZzSPVnYpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17867553"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17867553"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083614"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:29:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 385DB506; Tue,  2 Apr 2024 18:29:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI: LPSS: Advertise number of chip selects via property
Date: Tue,  2 Apr 2024 18:28:53 +0300
Message-ID: <20240402152952.3578659-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
References: <20240402152952.3578659-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Advertise number of chip selects via property for Intel Braswell.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5b56f198d005..a3d2d94be5c0 100644
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


