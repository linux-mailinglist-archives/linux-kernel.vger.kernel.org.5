Return-Path: <linux-kernel+bounces-76624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B649F85FA21
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08B58B2909F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC8C134CFE;
	Thu, 22 Feb 2024 13:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkzzH5yw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DF3F9D8;
	Thu, 22 Feb 2024 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609510; cv=none; b=tO+Ir0zOG1YH7dFetFgS9pO/XwnnbJ9m+cwQDt9t46XK0/KU0GLXCSj89s+1mz5QZiIWjuVmpewj2OSKOxxZGhGoh4/JMqNBgWx7oyzu6BRahPg/hAQAaVJ2JiZm9lA408nNMqz8wz/LGC0RcYz56DNvndz1JQTQzhzIgQrQU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609510; c=relaxed/simple;
	bh=5hmtygycM6xhOBU+7ZY8fYWHj/9o3DeQwnqDb7zUViE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+1wxJyJ3hV6sQNhmhYJEgBPs5FZLnpGhTFnGHSvC1PL0RnyavM6aVLQ+mZL9jx8gkAIrlQwmXwpx1eFzV4ml4hHz1Eyfv3XdjbMO8IsZd8uZlaMJZy0/a4fqhBoL4+Uneuo+QdkZeD1vCA74VfVueeRl4M+rdpT9i1YZ9WLcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkzzH5yw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609508; x=1740145508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5hmtygycM6xhOBU+7ZY8fYWHj/9o3DeQwnqDb7zUViE=;
  b=lkzzH5ywa4bURnUsF9sebfmz9Ku2QAl5BSSNe762SqPuFOGfvDHcq2U0
   I21Dx9uHwCbrZ0eGbC3aDmpJAy+AkH11sHL/4G61pL3y8+wR9Ux143eyA
   qpOTtudZ0bDmGCzwLKpHoCZZYBVH3PzfcsBZPX4P3TK8kiHX2eNZ2xT83
   +G0d0priJk/HnYrAwLrSoDfEVDaggTQ1ecJtBJJVT2zPBp7KR0VqenAWr
   7PBmYy+AB7qJs7Vt7DUIC5XRY4ke5YCfE+OXuEfqJ7IdbXlc3YOE24ASA
   H608uOX0KUp7/6oaOddOw0l8bpgUoHoWHnYhunz0p6s/8JUm3TWDCDbVA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13962644"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13962644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:45:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936851891"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936851891"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 05:45:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 10F7E458; Thu, 22 Feb 2024 15:45:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Date: Thu, 22 Feb 2024 15:45:01 +0200
Message-ID: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use more natural while (i--) patter to clean up allocated resources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/s390/cio/ccwgroup.c | 4 ++--
 drivers/s390/cio/chsc.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index 6eb8bcd948dc..b72f672a7720 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -240,7 +240,7 @@ static int __ccwgroup_create_symlinks(struct ccwgroup_device *gdev)
 		rc = sysfs_create_link(&gdev->cdev[i]->dev.kobj,
 				       &gdev->dev.kobj, "group_device");
 		if (rc) {
-			for (--i; i >= 0; i--)
+			while (i--)
 				sysfs_remove_link(&gdev->cdev[i]->dev.kobj,
 						  "group_device");
 			return rc;
@@ -251,7 +251,7 @@ static int __ccwgroup_create_symlinks(struct ccwgroup_device *gdev)
 		rc = sysfs_create_link(&gdev->dev.kobj,
 				       &gdev->cdev[i]->dev.kobj, str);
 		if (rc) {
-			for (--i; i >= 0; i--) {
+			while (i--) {
 				sprintf(str, "cdev%d", i);
 				sysfs_remove_link(&gdev->dev.kobj, str);
 			}
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 3d88899dff7c..8714aa312724 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -844,7 +844,7 @@ chsc_add_cmg_attr(struct channel_subsystem *css)
 	}
 	return ret;
 cleanup:
-	for (--i; i >= 0; i--) {
+	while (i--) {
 		if (!css->chps[i])
 			continue;
 		chp_remove_cmg_attr(css->chps[i]);
-- 
2.43.0.rc1.1.gbec44491f096


