Return-Path: <linux-kernel+bounces-95842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B98753E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E721C22A48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8412F5A8;
	Thu,  7 Mar 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XAZg288p"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB4212EBE0;
	Thu,  7 Mar 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827724; cv=none; b=Qeaxn5Vgg7bFjLNBjA9QCHpjSUK454nFQ2S6sOq/UMjGwy/tZcumua4mtbYt0BgpI8bpCB0II0nM5EJnJyQPqQGHP7w+JtmWJn6/nXd6I0KWOfYHtJb+sjRGnM8h2AQQYOpmc7TGH8bgrret9zWYnjLlzO0imX5eiLEqLKiR0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827724; c=relaxed/simple;
	bh=lHZpao53299T708PdhHM9KdkvSYJBb9dRvxpwMF1kC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mW47Ve1sleD1GatOd7jkoQ1+ffTF3n4ssHch6zE6KAhCW975O5IbYCvL0k3fqDxw7gjrNlxPlCxPhkh85zjhMbBdqpsSwZlvBvJcSb6RKoylIKRY5W4Q5r8mGfzdM2Icfr8D5jU+coEnLCaFqLNIFue6NkZTQXbJSAHBVdK3dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XAZg288p; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709827723; x=1741363723;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lHZpao53299T708PdhHM9KdkvSYJBb9dRvxpwMF1kC0=;
  b=XAZg288pznWECfeFw3SHMn/mK8tHFtiu1aBgEVV/ZgdKyimTPRdSYCKD
   RIlRVQyLCkCxHMdBnQoE9SRyBO+FdYIZimxGPFGwffmixG21ZXx/Gf8YC
   UnQ6S8sPG5lpDIeX6EHGwmSDqZ1PruC3qDe4DFpYJlryFPekvA7JsOgTj
   7ylckMb9DJIexE6+Z2QaimR2x6XUKTEjs/oBec6azyq6K9hQOdAq2OcNS
   tld5r6flwDGDV4vggpk0uaqr/cAWpCSiLURaVn8Z/OF7JjTZvZe7j+3mj
   BhwegnKhUWxNebupHulyWETLm9qCvILQQ3C9Dymb3XgJ+Rs8NpPGjGG4W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15227293"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15227293"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046344"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046344"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 08:08:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6123D3C0; Thu,  7 Mar 2024 18:08:24 +0200 (EET)
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
Subject: [PATCH v1 0/2] spi: pxa2xx: Clean up linux/spi/pxa2xx_spi.h
Date: Thu,  7 Mar 2024 18:07:37 +0200
Message-ID: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of cleanups against linux/spi/pxa2xx_spi.h.

Andy Shevchenko (2):
  spi: pxa2xx: Kill pxa2xx_set_spi_info()
  spi: pxa2xx: Make num_chipselect 8-bit in the struct
    pxa2xx_spi_controller

 arch/arm/mach-pxa/devices.c    | 18 ------------------
 arch/arm/mach-pxa/spitz.c      | 13 ++++++++++++-
 include/linux/spi/pxa2xx_spi.h | 10 +---------
 3 files changed, 13 insertions(+), 28 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


