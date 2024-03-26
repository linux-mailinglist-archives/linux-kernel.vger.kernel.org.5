Return-Path: <linux-kernel+bounces-119669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7784488CBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3299A322F55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D34127B43;
	Tue, 26 Mar 2024 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kG2UkDKJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104184D0D;
	Tue, 26 Mar 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476774; cv=none; b=jvKxp+oEZ8YO2GZgRgXDPdAXd4+qknC5s7wbvJ+HLcLaz/eb/6epG9iWXFKrLNwXfMSnfbxuu41cosrYN7huRn0MDvems1xEJFuZw0Qw2U9Z+W7C1Dwg91ktKAh5/FItCo3BX2K4yauAZwDAGtCEW4RCER0CnUahuPBkSBXTPk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476774; c=relaxed/simple;
	bh=ev8rYzqaCDj4b9qlzn5q+6SJHRO94m+OOkOuEDYlsFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tStX3aRq/8QI1CfWCNsrR2/ImXLqFmdnFA7ZVJt5I7a3jpMBnAps1skX0bCnK1ghS/vRcpc0AFCaHzCsEjXneKAJqUVL7g/PndzUSHYd4jvYZ+crhPFJei0fKBG2xKgJOHFqJB8IFGamvKbys624Yd/UzYwwHzeiaHwu17lCj1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kG2UkDKJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711476773; x=1743012773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ev8rYzqaCDj4b9qlzn5q+6SJHRO94m+OOkOuEDYlsFw=;
  b=kG2UkDKJi2kWXBpqnCXD17zkro12JAZL6VJtcZk6RWnjxDHl0Zwm0U37
   wy+7NsnP9NbX61kEhnS4PEGO1Tn+LVOfvPgti33X4MVgfwOSWn4rNOdWN
   HDmVuQMdoJ6UzSdR9osrvK+w6e6eN7v9/6J6eh9XaGpd+oPGKxq+1Q/bU
   +Eylm8vZfbKBlrM2+cW+Z3M6s61Ko/LvLqFsetmX2zRlOPXClhFTJQoSD
   y5xLGKJVD86WuLfAOww1u4VfHJ6YOOQ6BJJRGDr7uuF8I/rLNnIZzIBaR
   AkKFS7frgejMqCQp6FdJLPY57D/NGJjGgYWH+jnpFJE04Gfe1sl2k7NFr
   w==;
X-CSE-ConnectionGUID: 4hSgYS+5TRG+5XzK/03yhA==
X-CSE-MsgGUID: ohGs1RozQv2SPRaXtQDB7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10325985"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10325985"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="937072946"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="937072946"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Mar 2024 11:12:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 59022284; Tue, 26 Mar 2024 20:12:49 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/2] gpiolib: in-kernel documentation updates
Date: Tue, 26 Mar 2024 20:11:19 +0200
Message-ID: <20240326181247.1419138-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking for something I have noticed that in-kernel documentation
for gpiolib implementation may be updated to reflect the current state
of affairs. Hence these two patches.

Andy Shevchenko (2):
  gpiolib: Do not mention legacy GPIOF_* in the code
  gpiolib: Up to date the kernel documentation

 drivers/gpio/gpiolib-acpi.c   |  45 ++--
 drivers/gpio/gpiolib-cdev.c   |  15 +-
 drivers/gpio/gpiolib-devres.c |  85 ++++++--
 drivers/gpio/gpiolib-legacy.c |   3 +
 drivers/gpio/gpiolib-of.c     | 102 +++++----
 drivers/gpio/gpiolib-swnode.c |   8 +-
 drivers/gpio/gpiolib-sysfs.c  |  41 ++--
 drivers/gpio/gpiolib.c        | 388 +++++++++++++++++++++-------------
 drivers/gpio/gpiolib.h        |   8 +-
 9 files changed, 438 insertions(+), 257 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


