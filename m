Return-Path: <linux-kernel+bounces-96139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA687578F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55C428614D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EB713A86C;
	Thu,  7 Mar 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnX7J8sl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DB139587;
	Thu,  7 Mar 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841068; cv=none; b=im8va4Rp5v4IIYX6plS87GTV7HTInEq7Gvwm4OquhLOk4nVd41b2KVP6stHcsTNAYVodsMCIVAu+sbaRCTQ+G5sD49T9t+SMFNmNedHLXpzGtEIGsxsy938YCgbgekNc2gUZtPz1y/Ftb/bgkQjEalMFV5VkSbMixcKEqt2ZA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841068; c=relaxed/simple;
	bh=k2iqYWkJ/g6zSAYNGIBSWfD8NyYp6rFQOmMuXPYLaRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4/tk9O55Nlw/MrHXMWITo3s8L/Flk+e2g6ZoeIGBLbtu5vTiW1za+M/b+/iSpWv9S7QZAxdCwKNM78I0s/2jdRAGqCpgN6iABE62hmpqLqW6xBo4Y6sCU/VP0xpaHAbECmUEULKVKqkxBX0sGC96GHdRgLA+uB0O4VzfCNGtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnX7J8sl; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709841066; x=1741377066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2iqYWkJ/g6zSAYNGIBSWfD8NyYp6rFQOmMuXPYLaRg=;
  b=TnX7J8slgxK0ULboGSoY8V/WGxT4iKqDTq0MCwpWXSNQWqfpKj2isMIi
   Ywo6zJxkRabpvYoH7zhRf7qOnyedvqsNE/NNy3WF/f2l17jA8S1fFT+PO
   IcIY3lP8hzkHbG9j0rY4pOpykzFGRkoxwe2YZKLTVy+dEjXadNb5wrebg
   S8p+un4aUd/cSz0p40khXn2jDo2cRks/wiES63x2TG/6DTt9XQKe5Vwce
   UIZ8sGf1093qBApPdI0f7R1rT3zgRqMoIkQhcHBJua7so2BGovefnQeby
   tgsUHcdzlSZurwWY4Cy6V4ugZTV+WRVhevXzvClS6Jhla6H7V/CBYqCO4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4457058"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4457058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046514"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="937046514"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 11:50:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22889169; Thu,  7 Mar 2024 21:50:58 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
Date: Thu,  7 Mar 2024 21:47:47 +0200
Message-ID: <20240307195056.4059864-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
References: <20240307195056.4059864-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is nothing from pxa2xx_spi.h used by soc/pxa/ssp.c.
Replace it with pxa2xx_ssp.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/soc/pxa/ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
index 7af04e8b8163..854d32e04558 100644
--- a/drivers/soc/pxa/ssp.c
+++ b/drivers/soc/pxa/ssp.c
@@ -25,7 +25,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
-#include <linux/spi/pxa2xx_spi.h>
+#include <linux/pxa2xx_ssp.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-- 
2.43.0.rc1.1.gbec44491f096


