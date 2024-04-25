Return-Path: <linux-kernel+bounces-158942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA78B272F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DDD286A45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B8014EC51;
	Thu, 25 Apr 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSxMwlMp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E214D714;
	Thu, 25 Apr 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064799; cv=none; b=Fm6jPfkFJaXqTelfuG3Rmf4AIOwsd2wfM77XwZeL3g0yGDxEiiXz0vsNQPvM5STY91A2cS3P5ZV10qcuZcha9ImAN+XSLVgG0NSWu4Sm58lWuvkIMzDlVUt6wtddOU9mQXP2Th94RusAvi6VnZ7+iWdzbpm3v/Us1rNar9I7gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064799; c=relaxed/simple;
	bh=viLFxt1UKi1dyqI1aIAAm7qzEwjgBkF02Wj6Ul74LOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RoNa5mlnC/5ke5OV8cfeohHFSuz+nxR79A+8JLEI2IeDqG0kIwluF0jNfYHsydeeyz/0Nmntjiw6wBxbFtBwkUd0gqtKENZCoNd8twZcWwgx0KYV8cIgIcS+o7Ps4oTsheHtJY7OCvp/7DXJUTVlv+y7L394xRy5NAc7m7eJVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSxMwlMp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714064798; x=1745600798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=viLFxt1UKi1dyqI1aIAAm7qzEwjgBkF02Wj6Ul74LOg=;
  b=LSxMwlMp3HYil4vH0cQSHLnh32fDysNd+SvG0rc25/7r5mzxMFgjKw0L
   A1vof1YfE4g11mjW1Se/K8itHmCJ0wmDtuk51k7JDvF/+n0M7FJN0Auug
   1J7BeMsS1p9D+/hX8+/V0bOkMVqgZut42XCPZvqgLFvEsjDZjImp89OQo
   0zXvurikM0/+5TVPmh1ESrVfXfQ15scWPP8DyHtgRQete0PFwIFHS9Ts2
   8ru1kDWEB6A1aj9Ld9Ai68JljDlrbzxGTgU5WNSSQKyC6NI5aIUqS8Xgs
   RyNyFGPSiHvj+A6gHMhXIwuQ17L16kTbeVFy/M075AWx0Mqu1BgV3oriH
   A==;
X-CSE-ConnectionGUID: aDu/UwrgRriZbG3ggQqQVA==
X-CSE-MsgGUID: 2G9wZ0OJQVi9aCapuu/70A==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="27225313"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="27225313"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 10:06:36 -0700
X-CSE-ConnectionGUID: IsLwwQsIR5OEGidYcPIygw==
X-CSE-MsgGUID: xGxh8KMGSv+CauYiu7SldA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25548563"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP; 25 Apr 2024 10:06:35 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v2 3/3] hwmon: (coretemp) Extend the bitmask to read temperature to 0xff
Date: Thu, 25 Apr 2024 10:13:11 -0700
Message-Id: <20240425171311.19519-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
References: <20240425171311.19519-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Intel Software Development manual defines the temperature digital
readout as the bits [22:16] of the IA32_[PACKAGE]_THERM_STATUS registers.
Bit 23 is specified as reserved.

In recent processors, however, the temperature digital readout uses bits
[23:16]. In those processors, using the bitmask 0x7f would lead to
incorrect readings if the temperature deviates from TjMax by more than
127 degrees Celsius.

Although not guaranteed, bit 23 is likely to be 0 in processors from a few
generations ago. The temperature reading would still be correct in those
processors when using a 0xff bitmask.

Model-specific provisions can be made for older processors in which bit 23
is not 0 should the need arise.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v6.7+
---
Changes since v1:
 * Corrected wrong sentence in commit message. (Rui)
 * Removed dependency on INTEL_TCC. (Guenter)
---
 drivers/hwmon/coretemp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 616bd1a5b864..1b9203b20d70 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -411,7 +411,7 @@ static ssize_t show_temp(struct device *dev,
 		 * Return it instead of reporting an error which doesn't
 		 * really help at all.
 		 */
-		tdata->temp = tjmax - ((eax >> 16) & 0x7f) * 1000;
+		tdata->temp = tjmax - ((eax >> 16) & 0xff) * 1000;
 		tdata->last_updated = jiffies;
 	}
 
-- 
2.34.1


