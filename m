Return-Path: <linux-kernel+bounces-78654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F4861693
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72207284320
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4C484A4D;
	Fri, 23 Feb 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIXyDoh+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6383CD2;
	Fri, 23 Feb 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703870; cv=none; b=YyfHCcMzNYWFGCYsJ2rJy6+VuBVAQ4nAjARXOx7HcUp9RV8QSGDYsGBoNyL2f7X3uZ3bbhLM4Hl0gvcLTqJNy/VbAtc7Jd5G6UIrM7pLUoQlQJTn4xPS4ZByJm53k/igdcVuIgriqDLZXtEmfFs8nvB6t7iRRRAJv+P67jpDpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703870; c=relaxed/simple;
	bh=+YtkShM4oId0r6yrcwRkYoBoBjAp016GnUVoy6Y019w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eaa8Ct6NdNXerpolkZCbmC9bx5AyZxcIGTehm5FGnh1XMFwxYq2AwhklTNbmryMszU9vk2aVEkEtijBPMWvAHnAGeOza0jP7EqqsVuw2bKIq8gmO+4BGiKEJ6z1bjjnC9T83XlegwDXjlYN5zx02N/FVItr4Og1O6BSGEgm+ozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIXyDoh+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703869; x=1740239869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+YtkShM4oId0r6yrcwRkYoBoBjAp016GnUVoy6Y019w=;
  b=eIXyDoh+eRtfyTIAj41njgR1bvwgKYjGaOVqIoDPtH78w4eTa+F/tIJB
   3va+s2fy11Ak6OQbUEfpiFWDLXvX2dBghQnZSANR8ey7H8GcYB/8cgzgC
   PYv1UlTXlJvtZS3C3i5+DDM+TKark2fR1Y4bSj4X5NDScSJ6oDxHFiZlb
   x/BZS1NZmEKBXPYyZ+nAjk9B0nPbG8Bff9YLIVUIJNj4r7DRl/JnMGwWq
   ADMacYd/Vblv7/+0g0Z2k1ZJ5Pt8X0Qg0xTL4Grm7hhiCQ/tDuInbHPHT
   wYRpleaNWTuLy1yc4X0N8SePzfgiXI7HDqebFezXCkYnchL1MXoGDrwWA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3187547"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3187547"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025348"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025348"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 07:57:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0A7431A5; Fri, 23 Feb 2024 17:57:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v2 1/4] driver core: Drop unneeded 'extern' keyword in fwnode.h
Date: Fri, 23 Feb 2024 17:54:36 +0200
Message-ID: <20240223155731.858412-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
References: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not use 'extern' keyword with functions. Remove the last one
mistakenly added to fwnode.h.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 2a72f55d26eb..2d23a14857c7 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -209,9 +209,9 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
 		fwnode->flags &= ~FWNODE_FLAG_INITIALIZED;
 }
 
-extern bool fw_devlink_is_strict(void);
 int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
 void fwnode_links_purge(struct fwnode_handle *fwnode);
 void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
+bool fw_devlink_is_strict(void);
 
 #endif
-- 
2.43.0.rc1.1.gbec44491f096


