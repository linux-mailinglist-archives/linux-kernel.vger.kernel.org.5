Return-Path: <linux-kernel+bounces-90704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D834587039B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5E81F27417
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A1B3F9F6;
	Mon,  4 Mar 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbQz0mt2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EC224CF;
	Mon,  4 Mar 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561217; cv=none; b=CP0skdvJApCn/jXBvK+zq9YzyscPTEO4N39sOJJQ910LNQ7XUS9f6L/7HF31e5soc3YVmQOUii89UUkA8bCRbqkf8tFEkvNhPiyDkqbAbAmgXbsTqBf8FtsoUxaoDuo7YgVl9Jv+u79O0jckZ780tNwpTr/Okhms2Letu9x9MWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561217; c=relaxed/simple;
	bh=oPgbP6Y7UWq3750QzKfWsGmdMlFfdlCl9robmFmEbdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F17nPM/OZs/SbwQbIGxSYv/hW3hGgcyY9ghQiqLdkJnRM8ogfiJ8Sa4XVwibIUpJe8oLRYOm9PYLJox3QhB39Fb5fUMsJGiuPPazEuutpUInZJta11RMasTXkKcyCyKCWccpUhfculmh92izDmuaknRttY+UvH/52PQvsVmvs70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbQz0mt2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709561215; x=1741097215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oPgbP6Y7UWq3750QzKfWsGmdMlFfdlCl9robmFmEbdI=;
  b=ZbQz0mt28Xneu4vwNwCHhZ4EsYoDTAcR+03HZlbb6zi8VNdg4z863FR9
   +q1JOvwY3i59iuGPE5VPR+zwrlwl9uZ4kkjYbmlxX4p9ecjW/t5lEKRXv
   ohv896HbtXb1Bi4rm4cwFwgng2zLloWJodj9MUprtZwUe1Q01lr0m/59e
   fWG0e5RgMzrZi4yGvZSGODWYbeqRV9W+ByRTuWsn32UQ2gyNyNwf4hc30
   xCUSxXZbLs9XmFYaVHcyDOmxbT7RrwrsuovvjRdFkMh6jW4U44G2CU9/2
   cYIwXCFO51PXK6AJBA6jxq10+WcMTlXqzPcs2xdk5PZTukqMDQ+Gd3O/D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4214178"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4214178"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:06:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="937040569"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="937040569"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 06:06:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2A19931F; Mon,  4 Mar 2024 16:06:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 0/2] iio: core: Fix and cleanup to iio_device_alloc()
Date: Mon,  4 Mar 2024 16:04:31 +0200
Message-ID: <20240304140650.977784-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an exctract of the two patches from 
https://lore.kernel.org/r/20240228204919.3680786-1-andriy.shevchenko@linux.intel.com

In v1 (extract):
- removed unneeded 'else' branch (David)
- fixed typo in allocation cleanup (David)

Andy Shevchenko (2):
  iio: core: Leave private pointer NULL when no private data supplied
  iio: core: Calculate alloc_size only once in iio_device_alloc()

 drivers/iio/industrialio-core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


