Return-Path: <linux-kernel+bounces-148336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350A8A811A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E81EC1F21D40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7213C81D;
	Wed, 17 Apr 2024 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eL7KmI7k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5C13C675;
	Wed, 17 Apr 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350316; cv=none; b=WBxGNSSIGIpmf966M1VuC775jghX7+ppuiMyAU1olFieMQaVtEeWHUMXeGQIaz4O7hfx9OfjEH2Ysw/G8HO5LM5sETuk2dombJSHTKRYatVaGnDu0dcuDqgJqPc+ti9Y00OdMvPorS8iFiyvfo+ooQKn5kbpbd9217jCJSTGRuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350316; c=relaxed/simple;
	bh=F9UqnodzBIeYgsNxxhT57u+9cZfmEUsgk8l6hGT4o+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkpdqZIyasUy/LMiqsjpceG3yz1sWwP6R8YxuXz3UwkoeogTStnpmWZd1cnhqrXGWfUdBDUptbyLrUzh6f9a2duCPX6eEnSZjUovU9Td4P6+YjQYfCz9zH74P7MZWbxkXgxpvleYcTPhfc3D2YlQWPGUefcClj3yEraffST4Ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eL7KmI7k; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713350315; x=1744886315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F9UqnodzBIeYgsNxxhT57u+9cZfmEUsgk8l6hGT4o+8=;
  b=eL7KmI7kEAWtw9icdmgz2Un7Qev39+BY/+rsECViqjWSDYjorNosmnIh
   ctAoqrZO2+u41ZGCCU2dMTweZvHnq/AT3mHSZZLOxVxUceFfyufL1ucCz
   u+wThyYmplWd9Md/uB9B0+MZ2HBO0+h/ENFGcMjw/V2dgRVfTTbk+iccA
   SVthCzoisA5jvTZi8q9e9BBhpvu9DifpHv1e7iBpnsDvhmaN2Unm7NmaI
   1K5UkXM9FIA+NwIhcQGWf+H5RjzxFg+HZxiOe0QPQyLKGgzZ4s2PciPn6
   38sxrNXFgozEyqUpCfO1AVnd34QTt+Ws1fJIOBPHLyVSGckiZVCWKKC0i
   g==;
X-CSE-ConnectionGUID: HNuikW6wQdKj6MIDxS1YDg==
X-CSE-MsgGUID: jwdlDio7QhKJOFHwe0fGGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9384038"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9384038"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:38:34 -0700
X-CSE-ConnectionGUID: wbu1214bSzKZ7VaRKKORSQ==
X-CSE-MsgGUID: W7sFZuTHRKani18F0+sWJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27257833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 17 Apr 2024 03:38:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 8C935491; Wed, 17 Apr 2024 13:38:30 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 0/2] gpiolib: acpi: Improve IRQ labeling
Date: Wed, 17 Apr 2024 13:37:26 +0300
Message-ID: <20240417103829.2324960-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IRQ labeling now is quite ambiguous, improve it here.

Andy Shevchenko (2):
  gpiolib: acpi: Add fwnode name to the GPIO interrupt label
  gpiolib: acpi: Set label for IRQ only lines

 drivers/gpio/gpiolib-acpi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


