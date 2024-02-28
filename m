Return-Path: <linux-kernel+bounces-85544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3086B76E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19791C24AEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93C71EB0;
	Wed, 28 Feb 2024 18:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx7X2jbf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982871EAE;
	Wed, 28 Feb 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145860; cv=none; b=pbxbu4BmVj1oKVmKg000Clvnp27XjxtWOWaQ4HvKmOUOW6D190dDEd4m8ZktvC0YRNwhN5vJBrAJZGFkTasH3XzIn2DCa6IPVi5McFFFoF9ALO5eXFgyUMKTkR34yDCcyr8hsoYTzeoqvIhY3F/2DXy6F4lVet/9VOGlk5KNzLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145860; c=relaxed/simple;
	bh=lDadQ60W+scUEa1H+i74ZjntqFwyrcfss1QHZ2gw77Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2RftI2ia37gLxYO/Pj+CTukVHxPFLX+UELzVgxTCpmWcdbONK7COErkrPFKWDPGvuJRDOiFtE9eDpxhpb1ye8CXBz8eHRE97nZJ6mFagsBvMy8dxiDFpE6/LqkFLmsRm18hS3WQDZU0il63zS6440jebflxHYhzE7/T0sML2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx7X2jbf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709145859; x=1740681859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lDadQ60W+scUEa1H+i74ZjntqFwyrcfss1QHZ2gw77Q=;
  b=gx7X2jbfTHOOA7MHEYyd8yDpiHO2UPk/B4uyU4kJenalFkX8AOemTlKw
   CZI2kTgBref1wQ9GgwMwqu2lWRAQ1pRd5f7ObAcXT8v9Gj1qzK09UqcqK
   4B+U/7NQiuBmAGHJzd7oxtEZN6qBNp+DX75OlhNdkhWOd89igkE49Vbkv
   lwNO4dAx9jElqWuCNyGIfjpquG9H1gjvZ0Q4PDTqziHJIQveDfMHi3aYY
   qlG0Dekh78cp6Tyw0pobLPg0oH0WntIMPia26iGSVC+I/3HLENmCabCCX
   fxZSmzRl0IvmcLTGmDy/GgkrSH6JTA8A07aPHI6StYxiZ84RDx2t1mV2w
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21023733"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21023733"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:44:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034565"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034565"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 10:44:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0D5D11C5; Wed, 28 Feb 2024 20:44:13 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: [PATCH v1 0/2] gpiolib: Align prototypes of *gpio_count() APIs
Date: Wed, 28 Feb 2024 20:40:45 +0200
Message-ID: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two out of three GPIO count APIs take device pointer. OF case clearly
does not need it as it immediately switches to device node inside, and
ACPI abstracts that to struct acpi_device pointer. Unify all these by
making them to take struct fwnode_handle pointer. This, in particular,
will allow to create fwnode_gpio_count() API if needed. The need of that
was discussed here [1].

Note, no functional changes intended.

Link: https://lore.kernel.org/r/2ad735ed-963c-4e75-b83e-687ea2c0aef5@alliedtelesis.co.nz [1]

Andy Shevchenko (2):
  gpiolib-of: Make of_gpio_get_count() take firmware node as a parameter
  gpiolib-acpi: Make acpi_gpio_count() take firmware node as a parameter

 drivers/gpio/gpiolib-acpi.c | 13 ++++++-------
 drivers/gpio/gpiolib-acpi.h |  4 ++--
 drivers/gpio/gpiolib-of.c   | 13 ++++++-------
 drivers/gpio/gpiolib-of.h   |  5 +++--
 drivers/gpio/gpiolib.c      |  4 ++--
 5 files changed, 19 insertions(+), 20 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


