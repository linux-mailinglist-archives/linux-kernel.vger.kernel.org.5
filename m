Return-Path: <linux-kernel+bounces-162194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA578B5780
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C301C21EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC34854BD6;
	Mon, 29 Apr 2024 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIv29yvj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FE54905
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392567; cv=none; b=R/xb44JwIUe6n10P6NZ91veCPnv2tVgeQJHuWO1y8I9Kp4hMnEmp3pgjZJNaKcupoxar228veQrwO/Lly4jX9UTPMxGI15vGV9Uk1vhmTy+16Jir0rWbPNorKQ8giwlqpn81y2a30tr1sPKyiGd92msA0Sv3107yWFiDr8p2A48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392567; c=relaxed/simple;
	bh=DArV7j/szx7co+lsS5KqZv3unCNqezb1USQ5LCYCZyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dytpuyvjZcFJ3iglPVm4OC9XAjAXAi6o8xafxVfNToJ7/pR0zwpdmP86IT5zebKrVclj7m5CwyO+8N1ThX3jdUK+8l/Q4WTXyq33nE93LRIfdPvW5uzpmJYR2Qrt6hhI2U6t9E0pOmwrvcg440byvi+2uxlqu1x4cADLy+E0Yc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIv29yvj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392566; x=1745928566;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DArV7j/szx7co+lsS5KqZv3unCNqezb1USQ5LCYCZyI=;
  b=dIv29yvj8urmtKFWeBEp1wl8DEH6/a9D+OW97ggMJeHneXh7Y5ogAYh0
   MDT4YZ9TZqoaK1djpJDhZSYLxOCkVzPdwPAgHMGHw1DhO87QfqipIIWgd
   s9ydPGGDeGh4d0RYGlRorfcfd9zNB1b8aLjoCEZqoRbyLahs/JXcRlj16
   jjgUAPIogxjT+ypNmo6j5P0GJPJ1SbGPfd+yAvKsy9R52TRZSIIrtZEzX
   rkYaT/9yG/Pz+Gj56iS22LrfQBTw9HhLDJxChox7QcTbciUz57eWc4Tl2
   q/WAqNgSXIJO1Iokwe2FchC1hU4L3FYdpI+LMhdtWlYziGA6Yx6b6hPP6
   g==;
X-CSE-ConnectionGUID: oPVOdxbwSKiw4uHqGTqbBg==
X-CSE-MsgGUID: +znorXDMSrGGEvzJXMELXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908242"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908242"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:26 -0700
X-CSE-ConnectionGUID: OG/5I1r0S0Ctk5Pj/kTiDA==
X-CSE-MsgGUID: 5hJ2fJwbQYaXTD1yI50OGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166623"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:23 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 05/14] intel_th: Constify the struct device_type usage
Date: Mon, 29 Apr 2024 15:08:59 +0300
Message-ID: <20240429120908.3723458-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
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


