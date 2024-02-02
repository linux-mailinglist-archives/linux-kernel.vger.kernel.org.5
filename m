Return-Path: <linux-kernel+bounces-49553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91D3846BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC18A1C22D3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804A77F37;
	Fri,  2 Feb 2024 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqJa0AsQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24D77F18;
	Fri,  2 Feb 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865718; cv=none; b=j0tMhJFd5UfrTtuUdMLCj14t/TbvZw+Ovk8HH5FkN1/YAdyEiZCeuY+Zl/LVNG2CPYBBwpeDfXIRucFlRsCzbpLDTJ7laaUVowllICPsr2HuZ3OTdEQAwhndifWm5GFxa4g2Ro41RrP8c4b/bHoWcN/gteG4Ry9GI8mIJBcwoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865718; c=relaxed/simple;
	bh=9DYCxZ3oWfIeIDTmXDX6SsX1e7f5/U1YN+kxoouu4G4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVqjDtcCN38HeMa+lczzEtrDB/vlvYQ0uDg8S/oBYgsLBarJf/SnLAu07dLsRH9wDAfuxvLuOIogxtage/Kqy4RYYhztlEkZGkSU1zWK+pXlgOjVPYW84TH85Ltge5GMuHOUx3A56gP55FPEAtC+TjpLsQnxb3fU9DvefUolbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqJa0AsQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865717; x=1738401717;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9DYCxZ3oWfIeIDTmXDX6SsX1e7f5/U1YN+kxoouu4G4=;
  b=fqJa0AsQFj88iiXCsfjCGh4PGKZi87EKBK9FVtsrvgW7i91C1WpJZKry
   PXo0tdA1BH1R1y/+G7mHjXmYFwsrDPluyebWKK4RmAQzm/gdrxPxR4iAy
   l8wx3Pq7wTUTVoQof/7pQplUQhBhZcDebG6p5wVlTkFQUWvpLdyu5+bwS
   8BKJtD3rfjXMKQyO5W1+gPp+EtJpdS6+MpD394v0NKSQdkCYgx0Oatjbx
   QDwpHYX2h1nHltIGRa5rLEOZ8MjniwlE5RDoOxm7INqv09APTu4XSBLuw
   ynb+KTo0iKjLJ0A5HsKUFPeyBpcYu+1O9KEDSgxmffLIsvfSGMfdceWww
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483036"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483036"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:21:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639672"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:21:53 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/11] hwmon: (coretemp) Fixes, improvements and support for large core count
Date: Fri,  2 Feb 2024 17:21:33 +0800
Message-Id: <20240202092144.71180-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1/11 is a bug fix that should be considered as stable material.
Patch 2/11 fixes a user visible sysfs attribute name change.
Patch 3/11 is a quick fix to allow coretemp driver to probe more than
           128 cores.
Patch 4/11 - 10/11 are a series of improvements aim to simplify the
           code logic and remove unnecessary macros, variables and
           structure fields, and make it easier for patch 11/11.
Patch 11/11 converts coretemp driver to use dynamic memory allocation
           for core temp_data, so that it is easy to remove the
           hardcoded core count limitation when _num_cores_per_package
           become available and reliable, which is WIP in
           https://lore.kernel.org/all/20240118123127.055361964@linutronix.de/

I can split the first three patches into a separate patch set if needed.

Patch seris V1 has been posted at
https://lore.kernel.org/all/20231127131651.476795-1-rui.zhang@intel.com/

thanks,
rui

----------------------------------------------------------------
Zhang Rui (11):
      hwmon: (coretemp) Fix out-of-bounds memory access in create_core_data()
      hwmon: (coretemp) Fix bogus core to attr mapping
      hwmon: (coretemp) Enlarge per package core count limit
      hwmon: (coretemp) Introduce enum for attr index
      hwmon: (coretemp) Remove unnecessary dependency of array index
      hwmon: (coretemp) Replace sensor_device_attribute with device_attribute
      hwmon: (coretemp) Remove redundant pdata->cpu_map[]
      hwmon: (coretemp) Abstract core_temp helpers
      hwmon: (coretemp) Split package temp_data and core temp_data
      hwmon: (coretemp) Remove redundant temp_data->is_pkg_data
      hwmon: (coretemp) Use dynamic allocated memory for core temp_data

 drivers/hwmon/coretemp.c | 219 ++++++++++++++++++++++++++---------------------
 1 file changed, 120 insertions(+), 99 deletions(-)


