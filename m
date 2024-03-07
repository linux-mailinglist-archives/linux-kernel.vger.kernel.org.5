Return-Path: <linux-kernel+bounces-95790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8F8752A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756B2B283D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A712EBDD;
	Thu,  7 Mar 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZwM0+zi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306D12DDB2;
	Thu,  7 Mar 2024 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823782; cv=none; b=Pt7yby8Ib5nrGzlaUNatNYdw7yybU3lJUUv22wV1Uco9KxYZIVC4qXtMdMP3NIwpJgBqmQ/AFiZ1T6NRejeltO+4QspYnG8HhcdRbwmxS2SfL7B5wHo8LOlSL1CzLK5kRCLz4Y+Ozv8ARTJ01BlgauI1vqFqC4yGhJy4G0ClnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823782; c=relaxed/simple;
	bh=3oUxyIGcD2IBnGDJdX8uPIJI4LcRZfXcq/rdvY8MdRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QiUUA2HhKubuvykgBub0PPuw4TapOJAoZeD7DJGJFBfji24RuvMpTRy832ZBCoPuvfsUjD3hjSBXczooBLXI28qOIgTJ+ST2iO1hdxTHN3q7g0TIZxGMHCE9kiSoWiYd6uA5PvGkIiwU5LW4SE9lB7UxQDG3o09umUiYsw2U6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZwM0+zi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709823781; x=1741359781;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3oUxyIGcD2IBnGDJdX8uPIJI4LcRZfXcq/rdvY8MdRo=;
  b=OZwM0+zi+wVLMs+zxdS7pKX6MyxW2iZxQp4PrIqVouzS67Yo8I5vx6mC
   EYRXM173lmPVM707NOUxHsxNpA3bFEbPoqHLawmtYi7OccbgqkWMxZ9x8
   qRpe+a/gLLAU8/EzPCJZ9lcDIrZGGeTHEsbm9nu2AAIU8Nnmw3fp+h3De
   B4/sfW1dkt7Iw6Iy8A2sodjX+170XtiPWWw7TkRjOVNgFKEtkzODYLLtL
   iporNjOENnWnODVoDCcQhSchOJRJG5lysmaE/u4COlRqGMAnfssopjra0
   li2HipQWPLKpg5NC7wDE0WpDHYvc3E93vqytRFPq/Nm4KckAQ9WrAmmRr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4351047"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4351047"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 07:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937046325"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937046325"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 07:02:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0A0503C0; Thu,  7 Mar 2024 17:02:57 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] spi: Add more consistency to CS handle
Date: Thu,  7 Mar 2024 17:00:58 +0200
Message-ID: <20240307150256.3789138-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are the following issues with the current code:
- inconsistent use of 0xFF and -1 for invalid chip select pin
- inconsistent plain or BIT() use with a hard-to-understand comment
- wrong types used for last_cs_* fields

Fix all of these here.

Andy Shevchenko (3):
  spi: Consistently use BIT for cs_index_mask
  spi: Fix types of the last chip select storage variables
  spi: Introduce SPI_INVALID_CS and is_valid_cs()

 drivers/spi/spi.c       | 74 +++++++++++++++++++----------------------
 include/linux/spi/spi.h | 12 +++----
 2 files changed, 40 insertions(+), 46 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


