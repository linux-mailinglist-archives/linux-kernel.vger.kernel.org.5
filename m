Return-Path: <linux-kernel+bounces-87079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825586CF62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8CC7B28EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679B160650;
	Thu, 29 Feb 2024 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FiGW+x2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB1160640;
	Thu, 29 Feb 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224073; cv=none; b=C5PCKnILoDWSnFAVHYXY4Eb5Q2C+Er/DmIdAQCAmxVrUgJrIl2EVKqvC0E4x1bxGrTgIEqlLKLdh9k2mDKNr+S2pp6DUacZPE1dtfp1XfXN6FWNLh923Qmso5UKe3TF19mVxNzR5niE1FoHdruCiY4aYFdTb9NVDilbBkL7+vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224073; c=relaxed/simple;
	bh=oWNkaLsVsQ3UsF0BA0iw8F4jI5iyxmqhy991ZBrnwKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpRyH2CEBDZ8tyNYzaF+9f4/8M/5L/6rgKrj0zcvfLj8E2+8Af4U1j1lilE5KFlNCO3F5+ssyiAs1vTv6eldiJr5Hqpuzt7/WbWpFFccZGBxqMVk4GXmZC6IuTR/dDvwL84SVGFWOWRW1ptui45aLeTm35RURPWk8plZe7UR63c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FiGW+x2s; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224071; x=1740760071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oWNkaLsVsQ3UsF0BA0iw8F4jI5iyxmqhy991ZBrnwKQ=;
  b=FiGW+x2sPE24FPxuCMP+1dywEgqGOF8MQzUdxYwe2o0AbadXqErVjjQO
   0i+qKRpRNwg65F1mwI0dbkF2k8OGi7+NE5NsrIJHqNRihC2k6QsZ8RAI3
   Zu7Vw+/Cdgxzn+bRR2ixoxmn5QiJI/LjRWEcE3fK/mmEc1TkOVXGFHDBy
   1zGnD6LoCJXI6gKSIjjh52z7qI1OCzWpEHG7nUsyCKEYl+DC9COFPefBp
   EE1wHPmzbUQeyJP7/WyNFJF89qaLD7wy/hc8+MC0Qcd1ts7+C3F4VYRwF
   EJpB01UliTX9one1pa92/3gw9RMGuDpdZQUNO5d+zcu8k60oG8JoTukJE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660689"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660689"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036138"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036138"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A67883BC; Thu, 29 Feb 2024 18:27:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/4] device property: Move enum dev_dma_attr to fwnode.h
Date: Thu, 29 Feb 2024 18:23:45 +0200
Message-ID: <20240229162741.3854912-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
References: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
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
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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
index 420420a1d8ad..5761878d42c7 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -28,12 +28,6 @@ enum dev_prop_type {
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


