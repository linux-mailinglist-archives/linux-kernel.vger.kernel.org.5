Return-Path: <linux-kernel+bounces-92718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F0F8724E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71FB3B26D99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF55712E74;
	Tue,  5 Mar 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWKMHhQ0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6DDDA1;
	Tue,  5 Mar 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709657595; cv=none; b=LD/TqJp1Go9XSsaXF+YzIOVjtywiXysTiohwM2mxKNk3PSvRIV7JB9W/NjIwst9DgGGk147xhx6SVu6M/bdADdG9BsHOeNyQIR7boSozZyNtHxYTRzTBI5/IJMzZNDAQDVNhc0xLe9xtZaR9RVO3+edTcaVW/7GFOdeElUZnOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709657595; c=relaxed/simple;
	bh=hLKYxNXf66Yo5bSdnZap/TeucSUeZz8DTJtzZ7PHN3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkah7hgvq9sksbArYs9Lvr7uez2ZXE1wIJgPkO2kK19V5Vf6hZGqI/pw3bjJpLW5bfOz3n0JKswN4sox0NCUDliSYZG8fNeVw/06feIY55KKzNESpXV1Hmb5K52qtyimbTlMeziRh3Ww2HkBoQE1SOPUGUaZructGLsAMjYFAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWKMHhQ0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709657594; x=1741193594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hLKYxNXf66Yo5bSdnZap/TeucSUeZz8DTJtzZ7PHN3g=;
  b=FWKMHhQ04TnV6ICcuvvKTHOtka6fzppdEmJBBG33ObeTDgwktkSml5lE
   QM8V6OQ3fd6Kr72I4o+0RdQRjpW4t9rfKxip0LY5kfgb18OV388rIY1u7
   L7o5o0QfXJhQrV2KIx6mnbiC+i3XoiFUOGKb8QFE1TvSEwS3gHQy/sDC4
   ZngatQjQ5VRRtTAJXJX67EBO91UUurGb8zff4UJWMsG5qNa9SU0AM9dwV
   +xbHcdmyLXd1QdxOa1NQaKZ5XCylK5kL4kQur6K10miSCJ+IuCS1DREne
   +GQUtERU/HUCL9swmWWKjZJ2Q+QJ6fR/DfNVhnMYfRA49IfG6RvCu112b
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7992142"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7992142"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937042727"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="937042727"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2024 08:53:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 991911A6; Tue,  5 Mar 2024 18:53:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 0/3] watchdog: intel-mid_wdt: header and code cleanups
Date: Tue,  5 Mar 2024 18:52:17 +0200
Message-ID: <20240305165306.1366823-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few cleanups against the driver, mostly making an order in the header
inclusions.

Andy Shevchenko (3):
  watchdog: intel-mid_wdt: Remove unused intel-mid.h
  watchdog: intel-mid_wdt: Don't use "proxy" headers
  watchdog: intel-mid_wdt: Get platform data via dev_get_platdata()

 drivers/watchdog/intel-mid_wdt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


