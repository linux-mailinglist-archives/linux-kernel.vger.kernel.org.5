Return-Path: <linux-kernel+bounces-116975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7588A5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90531F35EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27E3DABF6;
	Mon, 25 Mar 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVhE60hR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FFC3DAC0E;
	Mon, 25 Mar 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711368600; cv=none; b=uWcetZfmQ3JC0VsjYWZ7K16kHuQaUl3MiPtqvw1flw4zMCyVMa90C5mCKdrxedBwbaF8mzDcKH42kEUMyqHAgK5KNmjpdIdEbE2NvZ/i/YSQ+yDrcV4NjWu21plXWdBalAiXuVcK08XRFeH6qzLV8v8zC99yQvix+bCCvOyJMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711368600; c=relaxed/simple;
	bh=m4luCakIlGOE+90+jDyLVbQsKwHZcbfCkbZgAkn5gDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XV25QghOMwgaJvbzVWykvvbFTfd+Gy2nPes1t8rQz2n7UeArUPa1UAXYHqVF7sO24kARV0BR0eYUP6OAV85iFWuAjTuUJcmz2FumL23R242Cc2eXPNjp06bY22n+3LPH7arQhLPyPBVUWpEeycanH5+N1qrKcRLI91XjuBzTJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVhE60hR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711368599; x=1742904599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m4luCakIlGOE+90+jDyLVbQsKwHZcbfCkbZgAkn5gDk=;
  b=UVhE60hRi4ZjZUrzi/zORNZGuwgn5l/0Ar9ojnH8cXGJUbXuLfRq18cQ
   W0ElCQc7uG992MFTYnIQW4skX4A5IXxtQ6OtTBLW7o/R7WvOzCbCE5PKz
   ykC1gKYE/YYtiTz3z7GQFvHyXFlBNaiZ5mm+LWonPrX0KPF9+KoekMY0J
   DmliXE2M+NXgcfPKuA5ENNdJc/TnbfEOmU3QmgLa1O4lX4u13diT4KRt1
   HC0aZ4EfeYLke558Rgp+aTiXYnF0Q+O3ec1eK437uv0Fts9CRQDqnxYBj
   y0yZ/xf5ynaHWx4Zrflpx198LZikw7fZ6hw5qYacQQZTxc1nSZYvu/miS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17757427"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17757427"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070312"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070312"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EBDB4228; Mon, 25 Mar 2024 14:09:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] hwmon: (pmbus/mp2975) Refactor the driver
Date: Mon, 25 Mar 2024 14:07:41 +0200
Message-ID: <20240325120952.3019767-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanups and refactoring to make it OF-independent (by compilation).
of_device.h is target to remove for the cases where it's not needed,
hende the last patch, which also makes code cleaner.

Andy Shevchenko (3):
  hwmon: (pmbus/mp2975) Replace home made version of __assign_bit()
  hwmon: (pmbus/mp2975) Constify local pointers to pmbus_driver_info
  hwmon: (pmbus/mp2975) Use i2c_get_match_data()

 drivers/hwmon/pmbus/mp2975.c | 89 ++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


