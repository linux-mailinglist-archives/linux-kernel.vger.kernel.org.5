Return-Path: <linux-kernel+bounces-133337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035D389A278
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A54288416
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5549D171652;
	Fri,  5 Apr 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WAokLWLA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0A16FF5D;
	Fri,  5 Apr 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334328; cv=none; b=flGNAioBTuTg92S7cLG2LfSx37Qgu7niszwXHhDxClqBj2aXQQubPYS6Oq48+vzcjTIM+IB9EcA7U4xGx/FSdd/8oBxncxB7bHcq8Uc0fdnXtqH0b65cah+//YlM0E7CmA4+sqWK6aVWZWjdwA181heOjNanIU2UmlVeD+q+dF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334328; c=relaxed/simple;
	bh=2qVdOeYS26fMEuDEmRAlt567VkvpEzyEFqui3T/pz6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhXSdC/tl2VKxYqS0hdJ3v8zGFP0y5KOPOWb1TcJy43G24Sdw4jdyy/5gjE5xp60fF4Gy12hBon1DfdJg+LbyJLOy7XOaARTZ+bHk5kHJixcpOVAfESRfbL664X/4utDGUO5+1J68/z33TuQUBycApbb1576PMY2Fstrapo1NNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WAokLWLA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712334327; x=1743870327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2qVdOeYS26fMEuDEmRAlt567VkvpEzyEFqui3T/pz6s=;
  b=WAokLWLATmkr+IJUjApy98ABGsV6cwZpiAfTcPZbg0Zm5719ToxRT928
   iDXoYiG/aPcZ7c2/vfqayI9nWvLzdd4Seq+eNcUaO1KcrHTI10fPaItcF
   CMOEpw3DoBpSnPy9gB8TCleYFH4Eo0JP9dTB3ZwUw5to/bU5zwO5UcBxu
   7J8ZYTx3/s4P/j+vHbtCT9M+4Avba5LgPa4qQ6frUVnikxvdvPjBQfeTV
   4pAB4ujnF7qPZFiKMr/F/SAHbB0QwUnv/up9Q3tJmq3G2kj0lgbDErm1S
   lVlxGLoZOL6Z9ZjaRQAjF5paqMSFpw05iZBZd38llRZLCXkEiqFO0ZDVV
   Q==;
X-CSE-ConnectionGUID: +tFSWQa2Th2w+AJlKT6BuQ==
X-CSE-MsgGUID: b+nunGXORD67urPhJXKlew==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7535443"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7535443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:25:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088062"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088062"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 09:25:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9F6203E5; Fri,  5 Apr 2024 19:25:22 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	peng.fan@oss.nxp.com
Subject: [PATCH v1 1/1] gpio: wcove: Use -ENOTSUPP consistently
Date: Fri,  5 Apr 2024 19:25:21 +0300
Message-ID: <20240405162521.3774111-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index c18b6b47384f..94ca9d03c094 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
-- 
2.43.0.rc1.1.gbec44491f096


