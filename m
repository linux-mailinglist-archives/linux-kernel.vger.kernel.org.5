Return-Path: <linux-kernel+bounces-95660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573C8750E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3088328B64B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5C12D744;
	Thu,  7 Mar 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUC8HjvR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C2C12AAFD;
	Thu,  7 Mar 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819478; cv=none; b=PG5Q5EhmiOdev7Xn5q7IAxoL3sj26sgyD/5G7XYoQ4bf5TGUyO62u0yIy7b1ntAUlofTbItBfV1vAD9DgY0mKNyUSQYxEV9H2KjfH4ZLZCh8IKAxIsvh+IIwXNT3CnmUAaSnTj3Tidzy/efKgGsfV6AFgF/JXMgoTc+A0hCtGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819478; c=relaxed/simple;
	bh=bL9mDQ/xotPoSr7x3SNEZqXU0V7jH69ACGEzpPlvSM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uDD3mv3opGOAGSWYc+QwQbEPotOfh8b8aPaRYIDzR4N8A73+YOujNRFIXDsvcLZjCuenz03mojZE3oodW45gl/ez+KOxu/Qtf/Umm2tl+f+8/ESpZjFmttb4GAd+5M07zqVCnOCtTpytGb4LPriLYGPq7FlmgCz1NSsSVaowp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUC8HjvR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709819477; x=1741355477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bL9mDQ/xotPoSr7x3SNEZqXU0V7jH69ACGEzpPlvSM8=;
  b=DUC8HjvRQaRc+ApwQb34RIY0TnFc1AS4qrtoEzGtXWk15ZEADSStRdGq
   KXmBZbRWTk8LUljvyH3K/cFBPwpDrYnPumYIuduxhn+Rq+ZQC2ytnQGNl
   FWpaMqSTs6FxYCgGU2N4az8Ny+iXTj2rcRHxxBIkFRUgg7G88uYheJjGg
   XPYa0V4jFq32nh8sXe/6VFvbDkjtx5ODkQCed9LlMuecYv808xDY9n0KU
   ThWFUz839fUZSdIIz2xkDjjgrAtp8g1RDIhI/LX9q0fNIfBSWlzUduHtU
   NAO8zEPgI6bKsGI83bwitWTj5KetLSwZ4HW+c31OPEzVnWkRfTmm670a8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="26960300"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26960300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:51:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937046157"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046157"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 05:51:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EB5133F1; Thu,  7 Mar 2024 15:51:10 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v1 0/3] gpiolib: Get rid of gpio_free_array()/gpio_request_array()
Date: Thu,  7 Mar 2024 15:49:02 +0200
Message-ID: <20240307135109.3778316-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are only two users left of the gpio_free_array()/gpio_request_array().
Convert them to very basic legacy APIs (it requires much less work for
now) and drop no more used gpio_free_array()/gpio_request_array().

(Not tested)

Andy Shevchenko (3):
  ARM: pxa: spitz: Open code gpio_request_array()
  ARM: sa1100: Open code gpio_request_array()
  gpiolib: legacy: Remove unused gpio_request_array() and
    gpio_free_array()

 Documentation/driver-api/gpio/legacy.rst      | 16 -------
 .../zh_CN/driver-api/gpio/legacy.rst          | 16 -------
 Documentation/translations/zh_TW/gpio.txt     | 17 -------
 arch/arm/mach-pxa/spitz_pm.c                  | 22 +++++----
 arch/arm/mach-sa1100/h3600.c                  | 47 ++++++++++++++-----
 drivers/gpio/gpiolib-legacy.c                 | 39 ---------------
 include/linux/gpio.h                          | 15 ------
 7 files changed, 48 insertions(+), 124 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


