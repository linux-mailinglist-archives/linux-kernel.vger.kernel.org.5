Return-Path: <linux-kernel+bounces-119913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1B88CEEB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B81C64EBF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC6A13E40E;
	Tue, 26 Mar 2024 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3a2d1bF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408213D610;
	Tue, 26 Mar 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484901; cv=none; b=bTTgHTm+yD0neE2Fv8u7BC8N59Enj+6SxZX1J9ng6N59JsVEf6/Uqcxk8CimuhwPI9ZNCDIJACC8bTLqJJ/prke/WXkYbsQGxcZN0cLiVy7yLD8EI0jB20w8Ff5JDp7ZhB90SOxw/WajjJvAvximq4pAkWhDcZi3JIvG7qn9cOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484901; c=relaxed/simple;
	bh=fEezHZYrjEOkzCb8cPzaGdM5y4H+/KQdLqpJeQTIjVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmZ3efvfLPGFrUGdoSr9YxUxcI+Q33M3N+/tulaQx177Ja66TybrFhDpV1WNRs3ZC2SrhipLoCKiK6/n9M8AdrQALZQ66Jku+fYG5d1micet17LSxX6MRSxzssOm2NNUgwvCsLTgzPeNJOxCrK4hfEzX1Y5BvXAZBuY/3UpKdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3a2d1bF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484900; x=1743020900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fEezHZYrjEOkzCb8cPzaGdM5y4H+/KQdLqpJeQTIjVY=;
  b=N3a2d1bF6UIhZafRgbAgp19Ix6ciu0q/J8gsBlJTwhmfrhiiGo40T6z/
   SCUt0WGC4T8Vj08ROCnbyk/mwzICUxWgMWo3hHIyZTLF3hNOzs60yPNKa
   O4hX/f9AGhUJF+VvdAM0aUrSFJy8wj+O4U6Ls79PRWMNHY+OsznURs+wM
   YTF2ETDjvfMehYCYgYJillopJ9XSIx89UtdD6URfq94hYMSLM+t/h0trc
   P1h6YX89ClSOjZ25vEX95N6+90pgaxntmq/22yY71mE1YfUrPiKJ5bqvV
   h/BseiGZCkdJp9pFKyQf5+eZRY1HTcNyVkBc84lzLwxeY9TlKliupKGZE
   Q==;
X-CSE-ConnectionGUID: jw6u2FjLRRu/ZmzJLbKCMg==
X-CSE-MsgGUID: Xk/pkV5QS6a+TPBMyeTUdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6500447"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6500447"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937073003"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="937073003"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 13:28:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 21CB4228; Tue, 26 Mar 2024 22:28:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] media: atomisp: Replace open-coded i2c_find_device_by_fwnode()
Date: Tue, 26 Mar 2024 22:27:03 +0200
Message-ID: <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gmin_i2c_dev_exists() is using open-coded variant of
i2c_find_device_by_fwnode(). Replace it with a corresponding call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 80aa2211cdc3..b7c477280986 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -394,12 +394,10 @@ static struct i2c_client *gmin_i2c_dev_exists(struct device *dev, char *name,
 	if (!adev)
 		return NULL;
 
-	d = bus_find_device_by_acpi_dev(&i2c_bus_type, adev);
+	d = get_device(acpi_get_first_physical_node(adev));
 	acpi_dev_put(adev);
-	if (!d)
-		return NULL;
 
-	*client = i2c_verify_client(d);
+	*client = i2c_find_device_by_fwnode(dev_fwnode(d));
 	put_device(d);
 
 	dev_dbg(dev, "found '%s' at address 0x%02x, adapter %d\n",
-- 
2.43.0.rc1.1.gbec44491f096


