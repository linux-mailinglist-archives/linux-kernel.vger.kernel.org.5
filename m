Return-Path: <linux-kernel+bounces-162308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C78B59A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A05A3B2B5FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4E7641B;
	Mon, 29 Apr 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZs8e3ZS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F3745FA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395716; cv=none; b=aeiIMe8MUk94gcu7OxwBthYx+cp4tfN++EksOLsGVbk330Ch9SlILY1GntSq6DuV2qS1Ry0AXrY5CEubHUDMd9Bxx9kSzepUpUUQL1k5ozHrhru2hNpZoM7sj8jMoiXzhmjisVDMbPpqgI/h30kGaWFPR8mLdu2wNQU9+XmmYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395716; c=relaxed/simple;
	bh=DArV7j/szx7co+lsS5KqZv3unCNqezb1USQ5LCYCZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxIwMYai4PbhHQ8w8ZecOw0AGTMby4XKVy1WtINzIaoq5Sq61v8NEc9TE0TPeOV182NxcSuapAgBskYyssYC6tMLHESBC5fDhiT9/En6gHk77bvjmbA7LFwNw7Ll2CI9V4OQdQQVG8NBbntWt6nW/TasibslwreZupJiBwzlci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZs8e3ZS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395715; x=1745931715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DArV7j/szx7co+lsS5KqZv3unCNqezb1USQ5LCYCZyI=;
  b=GZs8e3ZSnJDAN2rzJSm15LblsPHdLcLtggo7FGjCnT7Zdhf4BaiaeOwg
   OBxf+QK1XYB+Vvf7FqT8yBgU1vLnx8K8JZHnGOHVajtpTy0JRNKi6UR3c
   51kSfogjuREcib86SKD+tGOw2JYnOMs5JAIsn3xaapdJEJX1IpegbwAx2
   NYLI+xsoVpzXnu6xRKYj9RCMhIuEo9pWuc1a2vgA9yuCoRZGwyc1+1oJV
   jjEus1izPt1iaX4RLN3GnIkNbFoCgYBn2hP3uZDMCYDLLmZHnS/21Wxhx
   1+JZM9CCZnPixut/ah+5iIhwufmjzv6IuUsemoMYMwCURpjVX6MecHiwn
   Q==;
X-CSE-ConnectionGUID: HaZVQfU3TJeRwQ+6GWm2Jw==
X-CSE-MsgGUID: DXA0xUG6Qh+iIzAu1+XBwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986879"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:54 -0700
X-CSE-ConnectionGUID: 0rsYsUexRiqHGuF/23yvhA==
X-CSE-MsgGUID: RpVeWMmaSU+2si/LYMdpng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507081"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:52 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/15] intel_th: Constify the struct device_type usage
Date: Mon, 29 Apr 2024 16:01:10 +0300
Message-ID: <20240429130119.1518073-7-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
intel_th_source_device_type, intel_th_output_device_type,
intel_th_switch_device_type and intel_th_device_type variables to be
constant structures as well, placing it into read-only memory which can not
be modified at runtime.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index cc7f879bb175..3511f3618f2d 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -180,7 +180,7 @@ static void intel_th_device_release(struct device *dev)
 	intel_th_device_free(to_intel_th_device(dev));
 }
 
-static struct device_type intel_th_source_device_type = {
+static const struct device_type intel_th_source_device_type = {
 	.name		= "intel_th_source_device",
 	.release	= intel_th_device_release,
 };
@@ -333,19 +333,19 @@ static struct attribute *intel_th_output_attrs[] = {
 
 ATTRIBUTE_GROUPS(intel_th_output);
 
-static struct device_type intel_th_output_device_type = {
+static const struct device_type intel_th_output_device_type = {
 	.name		= "intel_th_output_device",
 	.groups		= intel_th_output_groups,
 	.release	= intel_th_device_release,
 	.devnode	= intel_th_output_devnode,
 };
 
-static struct device_type intel_th_switch_device_type = {
+static const struct device_type intel_th_switch_device_type = {
 	.name		= "intel_th_switch_device",
 	.release	= intel_th_device_release,
 };
 
-static struct device_type *intel_th_device_type[] = {
+static const struct device_type *intel_th_device_type[] = {
 	[INTEL_TH_SOURCE]	= &intel_th_source_device_type,
 	[INTEL_TH_OUTPUT]	= &intel_th_output_device_type,
 	[INTEL_TH_SWITCH]	= &intel_th_switch_device_type,
-- 
2.43.0


