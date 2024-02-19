Return-Path: <linux-kernel+bounces-71541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F385A6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9FB1C20EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08DF383A4;
	Mon, 19 Feb 2024 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgcuzgcY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E80937705;
	Mon, 19 Feb 2024 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355194; cv=none; b=er69p7pesKctPOWaIH7lr+kMUeUBbL1TZhpDyHUFKvVY9cGUt7zuC4mcA7CwIgzLLzAIG2Z+nB6wK7jyzgSTHkDDMz0ZyClQ3qmsFKW38JcuAjtR9SUN96kbOJl7DESAQ04ATIlfNNSt+szT66sOMphzEY12MMWmgMcYVq586hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355194; c=relaxed/simple;
	bh=+V1LR7Q185C1J/JoaoRrAfjbvg+uwTK47mds30fHknc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssYLFE0XE8oLtSVHFMkZNlC+qNBrwKOEg6Z9PPi1LIV2O3fcsbpJefPzp2dAFg4wttPk/R4pQ91k6f93WritvJ1rqoB9UKJKMOtWIbs4O/Lq/YbTZoykyZuc0mqeT/NhYel5qfhXBDFypRk89h1pZDwCRfwhns0XL+opT9q97DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgcuzgcY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708355193; x=1739891193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+V1LR7Q185C1J/JoaoRrAfjbvg+uwTK47mds30fHknc=;
  b=ZgcuzgcYK3nPJr+/qAMr5gjOKFcrZTuG/1gzgBnc0lZR+RcIoYxYd7vu
   2cVRxfpixV1hP3iQCmqz7tzafLjV5c2e+GPjoJq6HuZ7yw/KjEDNAEKYt
   H1TQC+MMsuQ/hGvb0ln24kIjYxlGBgldzxZzQWZHAxyn6+S+gFImC2m8T
   3u9SJA+11L+7B3Hd+DdzoGhN1GbmtqX41P8l89mKa3PEjlAu0erBPAV7J
   nrD0bNVsmdEKc8+QWR0hyxbctMS3XiwV3WefHf8OyYzwDwelWHkQFLbt5
   w7yWkmB0jAHwSqS7dhThw+rAYFPmUMbVvaorTDl/ZYnYeP3IJOAWN2hUB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2543768"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="2543768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 07:06:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936302988"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="936302988"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Feb 2024 07:06:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CE5F5305; Mon, 19 Feb 2024 17:06:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v2 0/7] serial: 8250_exar: A few updates to the driver
Date: Mon, 19 Feb 2024 17:04:56 +0200
Message-ID: <20240219150627.2101198-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few updates to the 8250 Exar driver as per new in-kernel APIs
appeared.

In v2:
- fixed link error, i.e. missing imported namespace (LKP, Greg)
- added a couple of new patches at the beginning of the series

Andy Shevchenko (7):
  serial: 8250_exar: Don't remove GPIO device on suspend
  serial: 8250_exar: Use dev_get_drvdata() directly in PM callbacks
  serial: 8250_exar: Clear interrupts before registering handler
  serial: 8250_exar: Use generic function to set firmware node
  serial: 8250_exar: switch to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: 8250_exar: Use 8250 PCI library to map and assign resources
  serial: 8250_exar: Don't use "proxy" headers

 drivers/tty/serial/8250/8250_exar.c | 52 +++++++++++++++--------------
 drivers/tty/serial/8250/Kconfig     |  1 +
 2 files changed, 28 insertions(+), 25 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


