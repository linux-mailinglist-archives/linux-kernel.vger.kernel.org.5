Return-Path: <linux-kernel+bounces-119664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1888CBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785613275DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D713CC70;
	Tue, 26 Mar 2024 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8MSF9Gm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1D127B62;
	Tue, 26 Mar 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476646; cv=none; b=gjhy3Yt84QMorKyPNGKHir4IEkLuGc2vHeNmEED2wxW/rf55fmvf95LoQMYxEC7GiHDEMUd0JF1pOqjoKOJzSvc2Nlj35utQ4v8d3FlkC8b9JhTkK+beciqC1SWAz7+wuSKEk9Gf6t/ncHzsf+9/Rq/QxMQ2ttP4QqWfjcb8dfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476646; c=relaxed/simple;
	bh=jFzgo5+g95yyxQjjsoDzp1sVeyMA6hDbVV6LnWCwoqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rtDSRLfPA3Icb3obzbT23D/O4NIdVliQixzYV9T8m81Bc+lcRFQY4K8iZQjE1oEbNV2YAghyYijmPvi2XvWKkdjKIdDIRtFSC24kol2JAUU5Xymru8GCJK/qa5b/Lvblz3piVqG0pyoq9h8O6MkM7xipXakNcSidJt8+RHKm1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8MSF9Gm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476644; x=1743012644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFzgo5+g95yyxQjjsoDzp1sVeyMA6hDbVV6LnWCwoqk=;
  b=A8MSF9Gmh+O2wxKU9oIkk7xkCM6P+NHi7t+ASDX/NFRoMd5J+vhJPI7Z
   Oi1k2x93oLo9fteD4324WgTILnB9Z/vIxUlH3YUibvW7pgQVTIN4p4W1K
   aTuhpADE+Npk7kL+g4T5X9Esnpx7gErpOiOmcYtekqXM2K8sk6eYYyckr
   YYUDCwlGAAoygbxpSUNx9CnOlvD4s39ax45vtfPE1ZB767L+SK5IV2iPo
   E40ye4nzjHP4ibayE4hdEs2y6edngMBk7w67Z+iZ/3EAswt3SMYbVdxh4
   hIEWDJaFdDXidZlJXnINTw9EpWmnJfF/iRgPuD1nJLn1/dR4reDT9YM8o
   w==;
X-CSE-ConnectionGUID: SOArLPDxQUGhCQKv9q+beA==
X-CSE-MsgGUID: wGznvPy+T/GMGP1X+g/Idw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325719"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072941"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0FFB16AF; Tue, 26 Mar 2024 20:10:35 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 05/10] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
Date: Tue, 26 Mar 2024 20:07:55 +0200
Message-ID: <20240326181027.1418989-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If SSP has been enumerated elsewhere, skip its initialization
in pxa2xx_spi_init_pdata().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index e7072727c25c..b01a18c89b6b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1355,6 +1355,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device *parent = dev->parent;
 	enum pxa_ssp_type type = SSP_UNDEFINED;
+	struct ssp_device *ssp = NULL;
 	const void *match;
 	bool is_lpss_priv;
 	int status;
@@ -1372,6 +1373,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 			return ERR_PTR(status);
 
 		type = (enum pxa_ssp_type)value;
+	} else {
+		ssp = pxa_ssp_request(pdev->id, pdev->name);
+		if (ssp)
+			type = ssp->type;
 	}
 
 	/* Validate the SSP type correctness */
@@ -1394,6 +1399,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
 
+	/* If SSP has been already enumerated, use it */
+	if (ssp)
+		return pdata;
+
 	status = pxa2xx_spi_init_ssp(pdev, &pdata->ssp, type);
 	if (status)
 		return ERR_PTR(status);
-- 
2.43.0.rc1.1.gbec44491f096


