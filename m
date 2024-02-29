Return-Path: <linux-kernel+bounces-86877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299E886CC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7331C21F69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119A13A274;
	Thu, 29 Feb 2024 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gEpfA6qV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED613775A;
	Thu, 29 Feb 2024 14:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218392; cv=none; b=bsvBThLncYjxyreOq+g5AHnlmsnp9IX7DUJ8cD0RroWp/YG3hi8GJVwbauU+sJ6WklmzKRDqFHc+hNyTKswFJ1BauZSFZIHHMlhYD+Hvp/B1VB+0NqJz40E318OhqvPwo3fnP9uqSdVr26RUV3KzPS4NZ9Ttukr/Xni0BFh2r8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218392; c=relaxed/simple;
	bh=Ib6eTByt4PRivyNulwEfDuCdZsACS0AUVpPOMm+fhJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKFunRbSpuwc2/3zXDH3VwJOzh9yh8F4DUK2h/QLLQntBJ1A0Q7UfGPyW2hvhZNmBCFJMqYXkgUI1mG0NhDnAR0lR/+1gx9rMN+X46tKScU33hjowGTlfz6JvmQnuV7oA/bhIH8HdVf+0aUXoSM4ULPIRu48phu8po3nDiM8B0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gEpfA6qV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709218391; x=1740754391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ib6eTByt4PRivyNulwEfDuCdZsACS0AUVpPOMm+fhJY=;
  b=gEpfA6qVfMffPkeE4FdzBAo4z0HybIgIiGsKlO2ja4zuUR8Z4X6TO49u
   xgb5Gi1iSMXYeuiNh/dYTTTKjLv2yaS6V4h4Eb3Hj9fy+vEuljdv4o6Zj
   c6VYoLpb5LRpl97ZA7Vmh4oyDsQ6uPmn0ddvjLkHqgaDNtTnvnrf44Wu2
   uJG2vQfUGzXOjHTSbS4BMYIgd71iwrZkXWpzMc+q9v88wmNVSYmyv9sMi
   jc58inNn2xTPZEcOgAi6qcQC1cIes4HRImqAJa03gSC0BE7tv3Sa/Heb0
   MMO0Kv70zRvuPDAkIKxqnfLslvjzrK5pRBVYqODPd1onprEO9M0YeKK4U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14326503"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14326503"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937036061"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036061"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 06:53:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D3F3923A; Thu, 29 Feb 2024 16:53:04 +0200 (EET)
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
Subject: [PATCH v2 0/2] gpiolib: Align prototypes of *gpio_count() APIs
Date: Thu, 29 Feb 2024 16:51:37 +0200
Message-ID: <20240229145303.3801332-1-andriy.shevchenko@linux.intel.com>
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

In v2:
- fixed typo (Chris)
- added tag (Linus)

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


