Return-Path: <linux-kernel+bounces-158711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C78B2411
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EB8285738
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114414A618;
	Thu, 25 Apr 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiN7Pdu/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80914A0BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055236; cv=none; b=RCmoMF5iL0Ib/Aro3LA6CvTVV+fhjYmpijPsa/SV6jEEkFZwJvNB3gV+Xnk4k6l4LvGci2WG5IHKkiQrELCCb4ts277IHRfxPMJnDKjK195hy4RvLuKV0sbNaMFH5xHUGC0GHrk63diKaqwYRSgPlK+3OtJHQujVCr/VHhmcGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055236; c=relaxed/simple;
	bh=AMj8GBIK2qx9hLs4ADXwTtXqaHbEx9/BpDAwkFfqL8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uy5zvP38g7AcJhPKk0P6przDSiIRmRWD7+LWGww5ILEuDQW2yFEp2OyvrN3haIlCA+4/OA92/WJI3z4aUXBKrVbSJWLGIDOKvtcRzb6S5T4YLvpwv3O0wWLaAnZl2o8V+mrpA8sxCxgW2nJii+H9vMWWsuqK19gntCbIRKqLhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiN7Pdu/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714055235; x=1745591235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AMj8GBIK2qx9hLs4ADXwTtXqaHbEx9/BpDAwkFfqL8g=;
  b=PiN7Pdu/yn1qg0w1avhXcAa3Doj/2HX+cR0WVZ9NmmZodZU/BQ1a5NP3
   dl5x+qQTDf+SRQJDyDmwLY17lGfXCIdRgoRmvzljUkzD9nH+9ESCqWElI
   hJJAV+PZEDC9bemfSrg0ULsJvuUEShgFBAjLckhjjt1hUmmRBCxU7t9/8
   G0ozvmqI+eP4eEOxHergajZln6apuGGmks3ugUqBQLWm0fJvjV5OS+APb
   VsK0RIjvy3bjiSvzfL96NnoSYs4/uDnT8qJVexZoZwb9nOzAHmbts5EKJ
   ZTS5ZKfEkgvYkBtifhC0XlqOvHvgwN94157WxEjhukWHCvdx2ubYJeG2d
   Q==;
X-CSE-ConnectionGUID: c0xMNg2dR6KPM7CLibYDqg==
X-CSE-MsgGUID: w0FQY3kpTwKqSWEtBh47jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10281373"
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="10281373"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 07:27:11 -0700
X-CSE-ConnectionGUID: mk5t2bsNSIyut26pxbla8g==
X-CSE-MsgGUID: dm/FMWDlS7KOCXXTemblqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,229,1708416000"; 
   d="scan'208";a="56027432"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 25 Apr 2024 07:27:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EAD35557; Thu, 25 Apr 2024 17:27:06 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 0/3] drm/panel: ili9341: Obvious fixes
Date: Thu, 25 Apr 2024 17:26:16 +0300
Message-ID: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few obvious fixes to the driver.

Andy Shevchenko (3):
  drm/panel: ili9341: Correct use of device property APIs
  drm/panel: ili9341: Respect deferred probe
  drm/panel: ili9341: Use predefined error codes

 drivers/gpu/drm/panel/Kconfig                |  2 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


