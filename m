Return-Path: <linux-kernel+bounces-119914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E988CEED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD19C1C65C86
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237813E410;
	Tue, 26 Mar 2024 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqDmOro8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CE13E401;
	Tue, 26 Mar 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484903; cv=none; b=aybAAVMVRUbD9nHaQ/cnoxv6WAk95MeMnxt6+NQhj2PZtxDPeoz7epqJfhwuKUhoT9ztWdEE1z/HyLV88RGYwhwqyjbwX2+vbsvIiITE1ckCWdmwwliGyU8RqxpMiaywEame6LsRHG5H1zVoeOayBMxybBNDgJ3KRkiWU65wiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484903; c=relaxed/simple;
	bh=glEZ4gkYeXfiLx7b8fYkxmcX81KAh6SXVQSh3z8QiaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvjxQRw1Hla+1dFzgHMHvJv7YuDXLz+WbOiU0wsAsEHNu0sAWf003wRqoTht7GuEW7jzfitqF86THeeHypp9gnjBq8GRmHkeOjMQFBlLUsAYRMOKhmIPbCgtvNyi26nzv0w08D10wKV4KkBrnygBHCeYuGjvEunC0QUKD8P4wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqDmOro8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484901; x=1743020901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=glEZ4gkYeXfiLx7b8fYkxmcX81KAh6SXVQSh3z8QiaM=;
  b=FqDmOro8J7UTIxKzNKAGsCKS5HlidaNHtwFzhx3UZ+fmuYjLbF/Mehm8
   E281uM8+r1qufzyq884BV3hAaQgoxZxI5Gp7IuzbbxOwG6+x4TfC1cfN0
   /bzZKId3iCFYLdAkWAvMvofcV6PMHQZzwNE+hsUYVv+0Ht7p6X1u8mDKn
   nvpuEX8uCBZhcgjCD7PTAVoZLbbesH4KvmWXDBh3VDfbl+bJ5/QVYG3lo
   kuLdKfY0k1umOwuFHrDucPMnhnC7xHqGjO5NropzIBobadwzZ6dirLHxb
   CtNKDv00YK1WCWqd4xDuTKfon+9FQKo8K6F0El5Gfu6muHnnDOOnNBUvF
   Q==;
X-CSE-ConnectionGUID: fICPQgy6SEGGE6i2Ac43oQ==
X-CSE-MsgGUID: 8t4W0JyfSNOz6jE7+zxzmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6500454"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6500454"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937073004"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="937073004"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 13:28:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 14B2286; Tue, 26 Mar 2024 22:28:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] =?UTF-8?q?media:=20atomisp:=20Put=20PMIC=20device?= =?UTF-8?q?=20after=20getting=20its=20I=C2=B2C=20address?=
Date: Tue, 26 Mar 2024 22:27:02 +0200
Message-ID: <20240326202813.1425431-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We don't use the PMIC I²C client device after getting its address.
Drop the reference to it. We do not expect device to disappear
as it should be taken care by the OpRegion drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../media/atomisp/pci/atomisp_gmin_platform.c       | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 139ad7ad1dcf..80aa2211cdc3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -497,16 +497,19 @@ static u8 gmin_get_pmic_id_and_addr(struct device *dev)
 	if (pmic_id)
 		return pmic_i2c_addr;
 
-	if (gmin_i2c_dev_exists(dev, PMIC_ACPI_TI, &power))
+	if (gmin_i2c_dev_exists(dev, PMIC_ACPI_TI, &power)) {
 		pmic_id = PMIC_TI;
-	else if (gmin_i2c_dev_exists(dev, PMIC_ACPI_AXP, &power))
+	} else if (gmin_i2c_dev_exists(dev, PMIC_ACPI_AXP, &power)) {
 		pmic_id = PMIC_AXP;
-	else if (gmin_i2c_dev_exists(dev, PMIC_ACPI_CRYSTALCOVE, &power))
+	} else if (gmin_i2c_dev_exists(dev, PMIC_ACPI_CRYSTALCOVE, &power)) {
 		pmic_id = PMIC_CRYSTALCOVE;
-	else
+	} else {
 		pmic_id = PMIC_REGULATOR;
+		return 0;
+	}
 
-	pmic_i2c_addr = power ? power->addr : 0;
+	pmic_i2c_addr = power->addr;
+	put_device(&power->dev);
 	return pmic_i2c_addr;
 }
 
-- 
2.43.0.rc1.1.gbec44491f096


