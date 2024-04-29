Return-Path: <linux-kernel+bounces-162191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB668B577D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0984EB23DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA995380D;
	Mon, 29 Apr 2024 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/Eq66ke"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BED5338F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392560; cv=none; b=oAukk06YxWA+t7+aIVNX2uclpam2AobrmrkWDqshjwQZ2oBvpgsaOxcjvMcgw3cvU+cyYdiIB3Jk3Yl1Z0WGySIj9Amz/1rcMk+2INTb3o4K48WkVqymh4cmWY58WvM85CTcBOVHNUkO8kVKyxDjtGXLBJ0gLbaz/xmdccWvCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392560; c=relaxed/simple;
	bh=kZea8gg6v2oPK+AP92ObeW+V0830/M7URcyFuYoYhaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukrAVUGpk+I/UCrc4VfDZhVYIy622d/k4e6fainMNYO/dB7PfyBUV8kmNgLHdCrpBlsdUnQy9pjyPHObcMh2EGFPjOC4CJYJ5+IQWnQjBEZsKorZegucvciOg1eRqejesCK21VCIUDusb2ZgGesXBH2wNBG6S339cR4CscX4C9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/Eq66ke; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392560; x=1745928560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZea8gg6v2oPK+AP92ObeW+V0830/M7URcyFuYoYhaU=;
  b=G/Eq66kea7Mxr3Dqy4Fd+4RvDiS1JpGv82Ca2xwnKT2sJZBLmvVjGEY5
   mTLkWmoBVL6QHkcnqi7hTbMbszbkYuw+KE54ri+JVa3yKiTztSWhpNAjT
   WAbONNyM96xBgS7TOkccY2hWGbagyCZbuzH6mBn4najUaAKShbnFlGKPi
   M9a87zPNktGrbCVcPi+4o56msMd3jB918mdFODNEcEKMRHvRcO97MGage
   OcxqxmIglNxiqBwxSVoozegV8NbFmFcJM4VGEh54u+PAjilRO8H83CLOc
   TfstJnPE8lsAx7FvIrEda4+6hXIuuMlgyTPJTzwEw8M+PfVpe7DBWXnIb
   g==;
X-CSE-ConnectionGUID: RZG+9WxKS3qLYYjjfJQVMw==
X-CSE-MsgGUID: 0YaMFGHpTVmy2hdA/GwjgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908208"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908208"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:19 -0700
X-CSE-ConnectionGUID: qCQceCV0RxujTN5kXVSSZg==
X-CSE-MsgGUID: UaxK+OLWTWOyq6qtogwPxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166606"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:16 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 01/14] stm class: Fix a double free in stm_register_device()
Date: Mon, 29 Apr 2024 15:08:55 +0300
Message-ID: <20240429120908.3723458-2-alexander.shishkin@linux.intel.com>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

The put_device(&stm->dev) call will trigger stm_device_release() which
frees "stm" so the vfree(stm) on the next line is a double free.

Fixes: 389b6699a2aa ("stm class: Fix stm device initialization order")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..20895d391562 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -868,8 +868,11 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -ENOMEM;
 
 	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
-	if (stm->major < 0)
-		goto err_free;
+	if (stm->major < 0) {
+		err = stm->major;
+		vfree(stm);
+		return err;
+	}
 
 	device_initialize(&stm->dev);
 	stm->dev.devt = MKDEV(stm->major, 0);
@@ -913,10 +916,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 err_device:
 	unregister_chrdev(stm->major, stm_data->name);
 
-	/* matches device_initialize() above */
+	/* calls stm_device_release() */
 	put_device(&stm->dev);
-err_free:
-	vfree(stm);
 
 	return err;
 }
-- 
2.43.0


