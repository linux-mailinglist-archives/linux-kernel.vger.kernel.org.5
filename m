Return-Path: <linux-kernel+bounces-48359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C2F845ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2F81F28E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C462140;
	Thu,  1 Feb 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCKAqLK0"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247E5F48C;
	Thu,  1 Feb 2024 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800006; cv=none; b=SCH7tZZox1L2DUAp2yeveBSkdYRK2xhc6tY4njtT2MJZbd0+amd5ZtTywDZyyZzWuFIugbGlOSVpVB8QFSbvzr0ZHVgMOgHgkM0h//0hp2uzBwVWjtGI5j62MrUJcc3rM3wOloc5wPMSSWddzKrkhndZbPFl87AqInJMpOw/AvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800006; c=relaxed/simple;
	bh=gV3rpgXyCLB5Os65qh8tufSawczRz8oU+Pr448CXlGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3uFctfhF7y2LAVnvbIWkgSTbSdlUczgHvPF4TpsCrPuNPITEJE/UY8dpuF3mnx8IhsZJOwynPoluMHgVPAWm6Zj4MtiGOKsPdIiYLRgEXHYn3XbU+RVTuRUPRFp4NbEue9Q4FscOh6DJc8V1ZZdbOGHfRSJ8OpZHgmBhGO1jvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCKAqLK0; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800004; x=1738336004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gV3rpgXyCLB5Os65qh8tufSawczRz8oU+Pr448CXlGg=;
  b=MCKAqLK0RfwhPWd9iVsIcTGsaO9oEGvfEJA/Qv1Ox9Woim3mHqetGOWg
   pXcVwRX84lqROjYOyOFbLKwVu7eFvUYJT8D+24nV26eFn0hJZyuYSzZs1
   pncEkN4OFqnnpgpKh0JkYMVI3Tqzyr4xR3Vay5lmY06C8GC2sztAMYBwi
   4nHcOnwaGSXC0RtxRLWxuxUKIwpX/c+GVMYBXFFNRXSKrZ27GlXs1E/rQ
   r2ZGe655MHzYsCML/jKkCyBwwyoHroNtVlslUeQ3yZE7PDaQOP0rCJxFC
   PoG8pLaDsbBAkToJQ/EqElCUxn9jylUi843ocOcgfLvB2RV94SCFAf9a9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403525475"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="403525475"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="859168146"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="859168146"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2024 07:06:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DD39EA23; Thu,  1 Feb 2024 16:49:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v2 0/4] backlight: hx8357: Clean up and make OF-independent
Date: Thu,  1 Feb 2024 16:47:41 +0200
Message-ID: <20240201144951.294215-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few ad-hoc cleanups and one patch to make driver OF-independent.

Chagelog v2:
- renamed init to init_fn and typedef accordingly (Daniel)
- added tags (Daniel, Javier)

Andy Shevchenko (4):
  backlight: hx8357: Make use of device properties
  backlight: hx8357: Move OF table closer to its consumer
  backlight: hx8357: Make use of dev_err_probe()
  backlight: hx8357: Utilise temporary variable for struct device

 drivers/video/backlight/hx8357.c | 57 +++++++++++++++-----------------
 1 file changed, 27 insertions(+), 30 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


