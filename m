Return-Path: <linux-kernel+bounces-162303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3E48B5940
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF621C21AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC7E6A00B;
	Mon, 29 Apr 2024 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IyiM95L4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1185338A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395711; cv=none; b=UoJNzPup2dtAtoaVqK36X1cWqfIinqeR2isJ5hOEiDpqbictsmn2HsRjzix7glC7qzyGOiXgciK+KyZS7QUEy5aReT3ol+tLW41IEhAVXDJ3a24dQ8L6SmayXRSy5et1BqstAxKjGNk70kWZP2zxZVK52p0GB31pnYc/iflnvkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395711; c=relaxed/simple;
	bh=kZea8gg6v2oPK+AP92ObeW+V0830/M7URcyFuYoYhaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN/g2YPDrh15HZCtqENgT0JlUA6bRIy3K3+qenngEb/xRC0RrzBzDgy29Bj1m2ibYyaAuQQ8BPjd4WsDaOsCR2GYupYBOghz/a8a66hlXYK7rMDQqhRKp/Bn00NTE/ZVR9OdAewH4DgEttQ/4RDWE/GdBuIqUNLkj4liccljBy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IyiM95L4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395710; x=1745931710;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZea8gg6v2oPK+AP92ObeW+V0830/M7URcyFuYoYhaU=;
  b=IyiM95L417pBwaVDEfcPFGZu0srsngPiQCuX4vO6MCB5Gf4twaZ+Jo5X
   bwe8EIDNzyEspO3ZMMVBg3pS596cfeLOcGLkBQvtzLiP3ki2fibx2Twss
   AD9IWzsb2l2Wj7UlULvtgYuevt9Y7ezSpDxKrjow3A64r/bob+7SUiVUu
   t/8F0hXyWUQ1dvEc2+A6ky9mHfkMK0pOTGXuuenGovfVEJ74cOjYwj7Cx
   S3Jg10fOmIPyD0UKKeUa+xTa1hDwr9JMUk1IKDf9mfJ4tTKFoveGT3wW2
   +Ot89/p62GFUvDDZriwWmoMlubw/46G/7tjc4x3CXYtJz6wd1uxvnl9+1
   A==;
X-CSE-ConnectionGUID: cCWRkA4mRGe/3M+ba0+sWQ==
X-CSE-MsgGUID: /p4Df2F9QTi8KbLtkIUoVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986813"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986813"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:45 -0700
X-CSE-ConnectionGUID: wwstNud9TFKdbhvToRJzjw==
X-CSE-MsgGUID: MGY5mLirQrWP03Yest6uLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507044"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:42 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 01/15] stm class: Fix a double free in stm_register_device()
Date: Mon, 29 Apr 2024 16:01:05 +0300
Message-ID: <20240429130119.1518073-2-alexander.shishkin@linux.intel.com>
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


