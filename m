Return-Path: <linux-kernel+bounces-78655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103BB861695
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DD01C24FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1184FB8;
	Fri, 23 Feb 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBu47pUz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369584A29;
	Fri, 23 Feb 2024 15:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703871; cv=none; b=heaAJHtNfsIMsWnjuJwik1M6OrfFwAp2omapsGNJoYNeuxpXk/t1him5AOyNy1WCe8TAQfRLX7emkgu1tz9oQtCNrRpkg/w8vzpHErsi5T61oFCqCUMyk/I3oplxMF8/KIzkx4VXHafKEDqN0q2k4UUTNukv1PgqUki/03an7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703871; c=relaxed/simple;
	bh=E4o0k4MiZVoO6lfp4ioi+ARzdEWQo43M1LChrrkEdsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0RAqgOaDv+OTKOHHoLjLH01Af4gYmtcWbchrJGPhDTrlg3Nic0BRCAzqYQefz3HvsfmwLYHEu1+Ppwgnv8Bxw+BJq2UU0Er3KlBelMtsUo8sjZmsz62gO1RSiIIt0G1PJf0+y9UyEhuN4N45cxFdBCWPJ6tfpepqrnPmpWOKno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBu47pUz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703870; x=1740239870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E4o0k4MiZVoO6lfp4ioi+ARzdEWQo43M1LChrrkEdsI=;
  b=IBu47pUzTDvsNqThtr5BzLBxD+oWz3fWIcXu2UQMV9ns8xgaXoxgdAPO
   OwWmxZZJAbR6QOXOCeQY44PyDjSz+mf9faDXLPCPYmBxz+Y7iDVmEV+cc
   KyDLvmWBfMgZOgTaqmNbto/wLOqRiSNkQ9jXHUBoZ2rZTCLgghWMOjWub
   b3xORlsymuUM7eYEx/HybeMGbusUNCYp4kG8F4JK7LIpJzYEX6PCoiX6O
   Bn7f8Dbnoe3/eAefpo78DmtzDn+cv2oJEXOjLLs32aJOSLg0GKNnp5AEQ
   Wbihql8FR59kD5+p8lsJBahvzHQfOIkRgF4pruMeUz0tdzRe49/1J4ZFr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3187528"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3187528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025347"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025347"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 07:57:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 252FD4A5; Fri, 23 Feb 2024 17:57:40 +0200 (EET)
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
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/4] device property: Move enum dev_dma_attr to fwnode.h
Date: Fri, 23 Feb 2024 17:54:38 +0200
Message-ID: <20240223155731.858412-4-andriy.shevchenko@linux.intel.com>
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

The struct fwnode_operations defines one of the callback to return
enum dev_dma_attr. But this currently is defined in property.h.
Move it to the correct location.

Fixes: 8c756a0a2de1 ("device property: Convert device_{dma_supported,get_dma_attr} to fwnode")
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/fwnode.h   | 6 ++++++
 include/linux/property.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 416cbe72f0c7..4228c45d5ccc 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -14,6 +14,12 @@
 #include <linux/bits.h>
 #include <linux/err.h>
 
+enum dev_dma_attr {
+	DEV_DMA_NOT_SUPPORTED,
+	DEV_DMA_NON_COHERENT,
+	DEV_DMA_COHERENT,
+};
+
 struct fwnode_operations;
 struct device;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 284ff79ebf03..1f0135e24d00 100644
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


