Return-Path: <linux-kernel+bounces-58546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE0884E7E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9161F2C080
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94425779;
	Thu,  8 Feb 2024 18:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAGcJ1T2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932820325;
	Thu,  8 Feb 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417804; cv=none; b=kZ39u6F18b/B9nzM4MrwLUbdjfhTvffck2MjX0rosw9zY7MZhKaYf5WP8L1FwWTDteug5NbD3FWz9coyR4gEwXnaq3Cw21DiU5BWyWTekDBiZNjzhfFxC1CJ+oxSOEG7vHkiVxDEbXj+JhlgUY0HAT2GZoqKaotWumjSXwAow2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417804; c=relaxed/simple;
	bh=PVZQea4vz3DuEQPtaVt+MCdeOQtQVI09e+jW/aO8CU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sj5HuuSleJT4o7GQxJCh559/7sTQloT4p4yHXNL+fZUzPpRjN9FkpvrEVSB4MzAotJPmwi1fzTAxFACwG8T5SHqVN8LRqjaDxV+Sl99WOU3cUTTe4c9u4trnqclWF68Be0Ced3uqlwfxWyBimSZ10hQqGhvdPsdGU+Fz9vQkads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAGcJ1T2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417803; x=1738953803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PVZQea4vz3DuEQPtaVt+MCdeOQtQVI09e+jW/aO8CU8=;
  b=kAGcJ1T2BWTEGt5qdPTTm5lcfX9APq3SxhI2kwrVbbeLHkz9LEmp9Dbi
   uvxz5ngxDJw9x2ZI3cDbUo5zh1Dga4k1U53bpPUvc2OJeQMWzQJ+ShJoO
   xfISCEPAcwfWND33OnEQ6gr935cS/+hb/lfjVMyDmaZHzdna3Eg3N9LVp
   YpqSMcYeWYaFbwaamYAt8NA2y2cXh7Do47SS4IlrxVUy0puLOb+SnEugC
   BnnmKoODGU4fzLAqj4vmAiGxo6Dq74xCcyc/n+rgAL8ag23D8t1EqIU5j
   v1rKjI/MZlfy5Bbxm43sVYBkSJV/S12UI0Vkwo/wjHz5qEM0qmZew3JYh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1184669"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1184669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:43:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934213719"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934213719"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:43:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 284ECE1; Thu,  8 Feb 2024 20:43:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Thompson <daniel.thompson@linaro.org>,
	Flavio Suligoi <f.suligoi@asem.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [resend, PATCH v3 0/3] backlight: mp3309c: Allow to use on non-OF platforms
Date: Thu,  8 Feb 2024 20:42:25 +0200
Message-ID: <20240208184313.2224579-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to use driver on non-OF platforms and other cleanups.

Changelog v3:
- rebased on top of the last changes against this driver (Lee)
- added tags to patch 2 (Daniel, Flavio)

Changelog v2:
- rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)                                             - add tags (Daniel, Flavio)
- new patch 2

Andy Shevchenko (3):
  backlight: mp3309c: Make use of device properties
  backlight: mp3309c: use dev_err_probe() instead of dev_err()
  backlight: mp3309c: Utilise temporary variable for struct device

 drivers/video/backlight/mp3309c.c | 88 ++++++++++++-------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


