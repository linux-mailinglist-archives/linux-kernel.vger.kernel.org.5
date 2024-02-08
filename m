Return-Path: <linux-kernel+bounces-58541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8584E7D2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F90E1C23573
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266E208AB;
	Thu,  8 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfRWDIZt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5D1DA59;
	Thu,  8 Feb 2024 18:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417753; cv=none; b=axtYlN0eqM7Tfh2XDSl7LpSBQzn3kSUIj5Zm+P0HJk0a7jfYgU+2CWFN0kWvtkNHqPGekO/0DdXhR7FBSquT0e6Gu87B+wZhPjqiwS1oFmFqOT46ua8T5mhY7ti+Mn7RraYfuQtEKlcS5e8tPRAe4c+iPeqJnkBECkoy8nS8x0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417753; c=relaxed/simple;
	bh=PVZQea4vz3DuEQPtaVt+MCdeOQtQVI09e+jW/aO8CU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUZMXqZ71HMevEqHnB6bRylGT59eonnPONZyRcAWd+bYgXFJmQBHqoUaBwBqZu7DiySkNYKQdkD1QZQHLmcpAPDMsS/1KkK6uSQipWhKM3n3f2mfwtKiiA/TyfacxogjZPME1Os9Lbp9v4O3nKOn1HbJDVYKGK9Go6Hnnn+bVs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfRWDIZt; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707417752; x=1738953752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PVZQea4vz3DuEQPtaVt+MCdeOQtQVI09e+jW/aO8CU8=;
  b=SfRWDIZtH7yvyfh+63KULANOs/MDkG/mvb6p4ufhvWRRQ9pNSmUFmg+9
   ImBzMAflEj/+kKemBBQw8RZx7TsLNIob3RDb1kpY/8BqCNRP6s5OLAb4J
   sQLPW9DAteQKIdnulvS61daM0cT7Q5Yg0E6x/3E3ee6HaNF5fyQ7NT9Cv
   CHQWsk/gISfra1ldj51uJg7wRTR5lEMMYx3lpbmhnmGu6LMVaWkmcMcS+
   whU+KFFb3lTvAg1+fqlPSOIS4j1NbnVJ2kAqjI/wO87KRWaxl5SsDECZf
   F3ZFRfH8V+RsQm48t7pnu1YCGv7h+I+8u1fpzELDR4nrvKHue6NOfaN8h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1184540"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1184540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:42:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934213673"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934213673"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:42:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BE757147B; Thu,  8 Feb 2024 20:26:09 +0200 (EET)
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
Subject: [PATCH v3 0/3] backlight: mp3309c: Allow to use on non-OF platforms
Date: Thu,  8 Feb 2024 20:24:45 +0200
Message-ID: <20240208182608.2224191-1-andriy.shevchenko@linux.intel.com>
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


