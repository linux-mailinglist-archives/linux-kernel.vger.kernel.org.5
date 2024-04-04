Return-Path: <linux-kernel+bounces-132014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEE898EBB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D98C1F27C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB8134402;
	Thu,  4 Apr 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lC83qXKv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA311332A9;
	Thu,  4 Apr 2024 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258011; cv=none; b=VB6ZHIkqSMLXE6a+nm95ROzwPSPO2j46GA4lLw82TAc9Xi9i+Qge/Uba6z72RJFmBy8w2JhC96rlAXylczoGue76zRDpiCRzD/cMlbSsBSDSYeWn9I+aiiUnsq8ekbvR5tUG59Ra7bgzpP5ZK2gycxA1CburWhZ1VagEZUxLmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258011; c=relaxed/simple;
	bh=uT+3lk4TJ3CDFdhijU5DBzvIBuMXKTqhMrJ4D9ztWmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPmoa1A6dWsHlzg3WMyJkcG73ViTGegjswUrwTiFUbzWv2kIetkFvG2efZ26DX1oc/rX25dr2qRodfekOKumk2siipUA58NQBOLUCUqSKEEDCCg7D+e4fBp+diEveOFLPgFppJcwvQQaE7CjM7AUE5WKVPtePs4DyNek54MrDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lC83qXKv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258010; x=1743794010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uT+3lk4TJ3CDFdhijU5DBzvIBuMXKTqhMrJ4D9ztWmo=;
  b=lC83qXKvnOLTRyz9bO1VbnxaNoWK/W5mAjxDroKA7g0p8Lm24FFbaSVo
   gdzgMOd7HrZVL8e1aoyKHjs/mpEEtrcupPLOqcxQ3ZT3HqGd/W1uONAs/
   X4OtGb1FaG+G6iD9dRRAgWE5b+XpRtv8D3778URdm1Vm75lYFy7N3up6b
   VB+mTXrkk7vRT3nCQRl0t51TIL8CjZ+RitC0rTR6lrdRMfsEk98U6HP9e
   JeaYb6c71hhw+SS6PL8QLAdLDP1/UjJvmvh4RIPBGCIr9a2867+B70hCE
   TkXLi76K5L4sA9S1NRy/2SOK7UELLQbtnZnUKdj17xea+d9kJa9CepA1u
   w==;
X-CSE-ConnectionGUID: nup0f5CPRNyL1+0At79Clw==
X-CSE-MsgGUID: vtQaXeu5TX+i9tP/3CYfHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18709371"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18709371"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937087026"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937087026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 12:13:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6C7B7812; Thu,  4 Apr 2024 22:13:25 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>
Subject: [PATCH v2 0/2] hwmon: (pwm-fan) Make the driver OF-independent
Date: Thu,  4 Apr 2024 22:11:37 +0300
Message-ID: <20240404191323.3547465-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The idea is to use the driver on non-OF platforms, such as ACPI-based.
Hence this mini-series.

In v2:
- made it series of two (Guenter)
- added tag to the second patch (Uwe)
- dropped applied patches

Andy Shevchenko (2):
  hwmon: (pwm-fan) Convert to use of_property_read_u32_array()
  hwmon: (pwm-fan) Make use of device properties

 drivers/hwmon/Kconfig   |  2 +-
 drivers/hwmon/pwm-fan.c | 45 ++++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 20 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


