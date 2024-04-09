Return-Path: <linux-kernel+bounces-137124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B44289DD44
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7194CB21DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F50131E23;
	Tue,  9 Apr 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9Vd3lXR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02F130E40;
	Tue,  9 Apr 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674056; cv=none; b=O2bKrn5PEViDpk9kg0jHP+LQBwbqBhnRcCaN8o/E0eRyKIaqrSHaykbeiO7fEAda20pvZHqcGukIjHknyT88JdlXreIwyisa/nGdkNlFn810Xp389TjKT8vvkE5Wq3NMgGZTDz0EstLwHGPBCoZVQhNxIcatOxBrBlq3HDk4GzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674056; c=relaxed/simple;
	bh=tu2SnYTw7xf2lMZm5p0+FQbEOrP8kSvSQ5bQJwoOWbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT4C/C9bF91iFNDoJg5BykZ6AiY3SHiCJ2cM/auS4KAH/+kXpk9IKrbWfcWCTdy29fAa6Y17piO2Lj3LO5cpoeEV8VBA1OZJUB207xCryiXwmWxh2uDrAx1eEnmB2jvuXNQ4W4fikLTrDXLix86UgM+HUk3+VwlSRi0yQAzc+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9Vd3lXR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674055; x=1744210055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tu2SnYTw7xf2lMZm5p0+FQbEOrP8kSvSQ5bQJwoOWbw=;
  b=T9Vd3lXRKUHq5sMc+a7IYEsJ3+gcWP3DbUcUJlJ2ENpnIq11HgWDEFj5
   3OXiKbPeR8LLcQX7QY+327XO+aZpdXDNjE8JOswk9HH3IIK75cfb4YRW4
   lg7FAiXaqbF/TBpChMlDLX1gMBSeut0IaDWHT7OrFLAzex9X2tJSqb2nf
   ztCe/P6RZfXFEv+Js/Ea6fKHv4dhvkqQvCkfTf/9iFwnISvnRSXku3LWr
   jKcBQ+lMfc2AMUbjJ7i8QNrHBY/faJ+yeEMgFkeZHaTB/aQehhAV4oPQQ
   gJz/ViuiTJ4wJI7u5SFKpza/0TzNLPDkvkoFwRylocbOW+Grtk00oQaY6
   g==;
X-CSE-ConnectionGUID: RXonn10VRO+QZ79UTrtNCg==
X-CSE-MsgGUID: zDgj+hAET0yUhwJvQJ2zRA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905531"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905531"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093486"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093486"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 1AFF7279; Tue,  9 Apr 2024 17:47:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 0/8] serial: max3100: Put into shape
Date: Tue,  9 Apr 2024 17:45:47 +0300
Message-ID: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Put the driver into the shape with all new bells and whistles
from the kernel.

Tested on Intel Merrifield with MAX3111e connected.

In v3:
- dropped applied patches
- rebased on top of tty-testing
- v2 (20240402195306.269276-1-andriy.shevchenko@linux.intel.com)

In v2:
- fixed a few typos in the commit messages (Hugo)
- added an additional fix to patch 2 (Hugo)
- appended tag to patch 13 (Hugo)
- v1 (20240402154219.3583679-1-andriy.shevchenko@linux.intel.com)

Andy Shevchenko (8):
  serial: max3100: Enable TIOCM_LOOP
  serial: max3100: Get crystal frequency via device property
  serial: max3100: Remove duplicating irq field
  serial: max3100: Switch to use dev_err_probe()
  serial: max3100: Replace MODULE_ALIAS() with respective ID tables
  serial: max3100: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
  serial: max3100: Extract to_max3100_port() helper macro
  serial: max3100: Sort headers

 drivers/tty/serial/max3100.c | 208 +++++++++++++++--------------------
 1 file changed, 86 insertions(+), 122 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


