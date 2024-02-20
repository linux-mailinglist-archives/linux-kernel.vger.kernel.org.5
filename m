Return-Path: <linux-kernel+bounces-73188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03085BEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7165E1C21009
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952A6A8D7;
	Tue, 20 Feb 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiUExBqX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0292F2C;
	Tue, 20 Feb 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440094; cv=none; b=hHXpgBwIvfbK5zNH8gkQJRhI6r2/SfHW5rQ8MIn1twA8Dqi7m0Q/t8+T+ejIQWJkT9+fRx2+awl6bk3dj3idzmYlADmSFUUH6SjuxJDMwupfFB5JB+3mZ6lM1fpLWSgo5PmIE/TiZ09KfM3zepT/09tYNbFk9w2zPVvJuwy7vvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440094; c=relaxed/simple;
	bh=oGGQvlblANH1zeYi/yc/BpgwhrLrkB3TPUi+d5bj4tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMvjqDlscKtkoSYYziKLkA7WLolV091rcynYn9F86xUduGMbsobZ/UhWo32+5ssmSuTVcxn2bzoLYG+8BIiKfMuH24PnEbP3SffK2B3xdorUCRrjCfOoYStaL9vlPybqXTCl72Y3GvqTzsOqeZ38V4Fa4WYfjjgWghzOMpZ/Koo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiUExBqX; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708440092; x=1739976092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oGGQvlblANH1zeYi/yc/BpgwhrLrkB3TPUi+d5bj4tQ=;
  b=kiUExBqX4Nt+cQbA21qUo/7r1ULGoUj32PvogEjf5Ugd8bKzkuBR2+3a
   rwJ0P6K8dDRFggsp4zFV8S3Am4x/wcDro/p6o1s6iNmortBgiiTGAs9j6
   w38lHCZuIghGTPpCFghzb8pE1u9KEd7OJDFlYd4ae5Wsfzw1ftekrsvg8
   QVLO4u+yug2sAkzY5ghM22TfAzXgcZuUZqLsIphXKfZiYBcxgdePci2k3
   iyODAw/aOn30clvyHxfeQ12qVWXgPBclkX0jlI1IRlAMtsTlAeHAx1TO9
   DRM4WjLCLqXLoF3hfSk6LUjJNb78vGRNan7ZRr/nQ/LWGEvhfQCBCgKRf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5501807"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5501807"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913086666"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="913086666"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2024 06:41:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 134FE305; Tue, 20 Feb 2024 16:41:05 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] device property: Move enum dev_dma_attr to fwnode.h
Date: Tue, 20 Feb 2024 16:41:05 +0200
Message-ID: <20240220144105.2316632-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The struct fwnode_operations defines one of the callback to return
enum dev_dma_attr. But this currently is defined in property.h.
Move it to the correct location.

Fixes: 8c756a0a2de1 ("device property: Convert device_{dma_supported,get_dma_attr} to fwnode")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h   | 6 ++++++
 include/linux/property.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index c1379f2d4a44..fabcd5ce084d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -15,6 +15,12 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+enum dev_dma_attr {
+	DEV_DMA_NOT_SUPPORTED,
+	DEV_DMA_NON_COHERENT,
+	DEV_DMA_COHERENT,
+};
+
 struct fwnode_operations;
 
 /*
diff --git a/include/linux/property.h b/include/linux/property.h
index e6516d0b7d52..07fbebc73243 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -27,12 +27,6 @@ enum dev_prop_type {
 	DEV_PROP_REF,
 };
 
-enum dev_dma_attr {
-	DEV_DMA_NOT_SUPPORTED,
-	DEV_DMA_NON_COHERENT,
-	DEV_DMA_COHERENT,
-};
-
 const struct fwnode_handle *__dev_fwnode_const(const struct device *dev);
 struct fwnode_handle *__dev_fwnode(struct device *dev);
 #define dev_fwnode(dev)							\
-- 
2.43.0.rc1.1.gbec44491f096


