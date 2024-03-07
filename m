Return-Path: <linux-kernel+bounces-95748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D57875206
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835131F21F4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64212F39A;
	Thu,  7 Mar 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igEiG5iR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BF12CDBE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822212; cv=none; b=S2az7c4Hq5S1JrpWufGlkMz/XWPf6BNxmjK6QU27RpjcgeF955Nm1GfiiSbIq19Aa7dWKxDP+IdJQiKneek6/f7sXlKppKsGfVSSY2K4IKI2BjmclP/hyo+yje0soTLP2sn1lCZwi4xsIghFj2Bx7fSBd/GOOLCCyylkXw3epP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822212; c=relaxed/simple;
	bh=LARb+btmhOxVSMAgFcwVIsbom5zFwP/grUeV1u+55vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PkUlT24x/GZZIMWKyr0BjKKVQmEUdpUQIoOMDYuH4GwAU0R3qpiIUte/KRKlHBQaE+qVi+geT7h11JoI0cLgTrita8/PeqlgL2vBzXNNMLedBfSHnoNPDdm4PWzU36kvvMQ+V+6Rm+HhPHKf9K7y5YRSUmGnJCCpDRkX4B6tEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igEiG5iR; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709822211; x=1741358211;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LARb+btmhOxVSMAgFcwVIsbom5zFwP/grUeV1u+55vs=;
  b=igEiG5iRMABsbjUorAph0dZd6SlqagDOw+4s49FJS5MEYAZuSqVZCtw/
   fwIdRj8VGhFgGOm1YNk0S/e994QVyF5IuuPv6MDki/tzVKsOrflvU03E6
   gA/tI1wJvcI+X6jfYG3ok7UYlTtsCLXreAIq9aolOwlvKtsXF7ZFkRE0D
   Bp55L1jD6PnSZ4AgHT0Pcu/LxWN/TD2x6C3qWzBIifArxfrKTzoMLU8+z
   nFuKqw9BLCio+bUiIIHEIXGC2gsPS/sZCvSiJzwtxV6NibTf7FF3N/Xyr
   UutXhwyEdT+O4FK84Ga7hiCGw2I2umMlOCbFYr+z8YtM4/EwqdEKa8KLu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4348204"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4348204"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 06:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046240"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046240"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 06:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DF9D03F1; Thu,  7 Mar 2024 16:36:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] w1: gpio: A set of cleanups
Date: Thu,  7 Mar 2024 16:35:46 +0200
Message-ID: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A set of ad-hoc cleanups with making driver to be used in e.g.,
ACPI envionment.

Andy Shevchenko (5):
  w1: gpio: Make use of device properties
  w1: gpio: Switch to use dev_err_probe()
  w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
  w1: gpio: Remove duplicate NULL checks
  w1: gpio: Don't use "proxy" headers

 drivers/w1/masters/w1-gpio.c | 62 +++++++++++++++---------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


