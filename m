Return-Path: <linux-kernel+bounces-88884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3215586E7EF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6ED01F2937A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5639FD5;
	Fri,  1 Mar 2024 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/ETq48V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7D364BC;
	Fri,  1 Mar 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316131; cv=none; b=GE16oWGMFbfQeKFTXHtEcErWkeSkmPkWt/EThuZVHewK2fT4hwtK4viCNoj2m+zQfkezLxmWlH1S4NTxw0ZF6rKDDlOs1Hbba8JhnsQfROa5q8lQLaDdglmG4LH5AF0VmDRsiVE9PKOOg+oAbFy2aCzb49KN303FPq3CmrFT2bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316131; c=relaxed/simple;
	bh=UGi/J2/VhF7b5YdpT5D5KqWdO44033odkiuQlnQjuvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMmlzb8qbWtz/vCcDOSXLB8nj2kfS1BWk/PVOvviSwIdB05gj+jSzjNJlQpM9ubl4qRbbp9stBkqqHaFShrueNtnEctbuuEGcRFrZIdVfgFxpasj2ogYPS7Y73SAgxhgcTvg1KlSMcR4Wkx9ZZzFvctvifBL2P3bAB4Wbm1QPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/ETq48V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709316130; x=1740852130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UGi/J2/VhF7b5YdpT5D5KqWdO44033odkiuQlnQjuvY=;
  b=I/ETq48VHSIAXW8mq6Ke0KzWTJqn6XKoOuw0aNtJh9bd4wXi5hJ69DVZ
   TRDPS34bEyEYeoEwAhkxBsYmv2QeItoCM1Ns9hVAojZffAXMPaXG7L38i
   gbc8j4s5peGE+A52QZOLeAWslFkyHKLiUjha9Xj7TYd5KZrH74IzHVybk
   /j4dysWQAHxyoMSuMjvskeDXC5cl0UQXhPMLUvZmoiQD4/jC53Tcgyzca
   uAGgJekZbGlKujYkSt3qumo2k4npQD/8DSfNTlR+em8N5gyZaI2+4DKvP
   4ljkdMagKyVYdBj+DVUUZxG4rMOYagKN7/QuPePWZY/X1z/aYl4P/rQ5y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684816"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684816"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037846"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037846"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 10:01:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 46B68537; Fri,  1 Mar 2024 20:01:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 3/4] device property: Move enum dev_dma_attr to fwnode.h
Date: Fri,  1 Mar 2024 20:00:07 +0200
Message-ID: <20240301180138.271590-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
References: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
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


