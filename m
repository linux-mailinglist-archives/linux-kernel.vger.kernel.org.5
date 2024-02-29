Return-Path: <linux-kernel+bounces-87083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399F286CF30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8241C231DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3424AEEA;
	Thu, 29 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SutE6Hel"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B4A4AEE5;
	Thu, 29 Feb 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224079; cv=none; b=KX8pY2H9xYod3fqQV1HOdID8mPczH9aj5e/tDbh/n0M72f+kUdI477XAwM1nYTfXgE2+a1onRrLQy26H4df+bHvPA2M4IHLq7or8dAAg0mqIQuO8WkctYTVt11K3wqueW0h8Asr3zJkQmwRoOfF+sKPLx85b3AlcBvU79JkHVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224079; c=relaxed/simple;
	bh=BW1c/RkhUJtoUJ2pTjmMw2HsXxDX+1fRKgzP9b4AcP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/9NaJqhPWk3anO8UuFUM2VRv1m2LAyoJDeB7YOn0myyugfe9XFd9Z4YtiPr+24sBbmgdLOpRHSRohOyBks8yL92QsR5kE1PM4G5qDDs9B6lGhPyfMnFboNHkvikIV41D+crhtZAo/kS6dmsUon4kvQsYcbs9kKcnNPKHnukY8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SutE6Hel; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224078; x=1740760078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW1c/RkhUJtoUJ2pTjmMw2HsXxDX+1fRKgzP9b4AcP8=;
  b=SutE6HelF80K0FRn3UqyDOn5VqCnICsSi/Bon+85irDR61pPQhhRRmic
   Xj7a4gxx5F25U5TJaUEraxdXjI8DuZBHbcU10V2XF9r+/ji/Z2pRCL7aa
   Y52EDgRKHvp9yJgmgpv4Ux9oTIrIIMwZ+jmOUeQPO+M1/Vh9iq2Ppqip2
   Lisf0VBVZoHiSWP/gCn+GueBSlhMvqUUgzTFxyeldSKBZZDqMGiKDtGNa
   tbb1ptbjzWwElR9hbARoLpFAxTe7khH8e4VdiCmm7na/FlWaeaTVOzM8s
   2G1IN0qOUGYdM0sHvPsWwwQBY/m5gqVIQUkIkaAowuwO36ICJgHD//LPo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660713"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036136"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036136"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9055619F; Thu, 29 Feb 2024 18:27:44 +0200 (EET)
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
	Lars-Peter Clausen <lars@metafoo.de>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v3 1/4] driver core: Drop unneeded 'extern' keyword in fwnode.h
Date: Thu, 29 Feb 2024 18:23:43 +0200
Message-ID: <20240229162741.3854912-2-andriy.shevchenko@linux.intel.com>
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

We do not use 'extern' keyword with functions. Remove the last one
mistakenly added to fwnode.h.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Saravana Kannan <saravanak@google.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
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


