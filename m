Return-Path: <linux-kernel+bounces-95907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2A48754CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5EC286C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B0130E27;
	Thu,  7 Mar 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RT1jHz2C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABD12FF96;
	Thu,  7 Mar 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831090; cv=none; b=BkiiS+aOX4q8AZ4ImfNDYJpbBamd2IYsMcKIc9jNX8dEDHYLtRnUDRKlfD42RNP1vLZQyv1f4GyN0emqHf609FCxPkS9vUYjUVwl0IU+i3ivOrzG5gEChA84bWGAbG1oD26hoAkaZ9emEGdvvHwLteNGgw7X+MTbqwI6bvFUK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831090; c=relaxed/simple;
	bh=k2iqYWkJ/g6zSAYNGIBSWfD8NyYp6rFQOmMuXPYLaRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvflmwsHyNYR1rIcN2VcRuq39S8ttesWQG+1J1s4zqFGPhRdIw5D1KhPxLOhbCfABo/79cffM3h7F+jrnVK1VhXYKV+UvaJQksV8QSHYd8yNTSQUf41Nd5aO5zKtrgWyAMMFYbLpdCBpj6uf3iCZ/B03n/wE8jdbzb88Y8D/Cmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RT1jHz2C; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709831089; x=1741367089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k2iqYWkJ/g6zSAYNGIBSWfD8NyYp6rFQOmMuXPYLaRg=;
  b=RT1jHz2C/fWgCKjq+LgNurMnRIpG2/G3dWyiOWWCRN/AxJSHHKShK3r+
   pzxhc8sQZXJgot3B2+kIfnjRA2xSc6MuYQKsvXhltA1MrmGzg18ysBMnS
   9znvl1lBrh2wBe19+ln/BihLUXeXdWopD0kBKNsgtI6dyg4WXHoyAx1G7
   mJNqvDME3Y09mx8+VOLw/E6XIJBlj7T5SVhwFK4i5FHScjt8Pl9usVltB
   caFYONCGTS4GZ6xcAJVts+hhlWfmv1DMiGzAvXeUWxId2/Lxqp7hjtH86
   ecKbDkLiX063A4pkM1lJuBuH50zj1NaXaIJ8ZU7mwT+l4l8rcseWrmQoA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4392421"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="4392421"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 09:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046412"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="937046412"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 09:04:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7BCFE13F; Thu,  7 Mar 2024 19:04:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/3] spi: pxa2xx: Use proper SSP header in soc/pxa/ssp.c
Date: Thu,  7 Mar 2024 19:03:17 +0200
Message-ID: <20240307170441.3884452-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
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


