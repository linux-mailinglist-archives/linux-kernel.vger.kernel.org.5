Return-Path: <linux-kernel+bounces-48391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8F845B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87DE1B2109E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFABF159572;
	Thu,  1 Feb 2024 15:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9C6h7Bo"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CF77A06;
	Thu,  1 Feb 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800912; cv=none; b=JhageEzXODrB9uHYCO/W5TmmjOCA/rB/2NS/BVaGBIaeZEGIggoIo5h/8Zu4/2zNu+WHMUFRjw5S+iWyv8VQJ6b0DFMTJXuYlxWxSZ3YWthSwvK4zK3a5L/ofkONftMMCqFvZj7+reGSuKTT5F2vYgkllBeP5kSV2r6jf9mMQww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800912; c=relaxed/simple;
	bh=wIQGdFqlY0xAMd+07bg96OAGO6sKPhtrx96e+mX0ZBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODmT/RUuqRowJ3tWVM8LzO+14JMf2QBpZ8fEfdSf1QOI0iVEvnD7KRE68yogJPgjtDdiHqaIK2th592+KSQx+bLReHwP0xivI2zXJOB1zrGX0I4LvkzUWPZa8OiC1mTOVHkLGCLN1bRyoCnQ0Q9c63PS/+2FFXb6l1RAtIffVvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9C6h7Bo; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706800910; x=1738336910;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wIQGdFqlY0xAMd+07bg96OAGO6sKPhtrx96e+mX0ZBE=;
  b=F9C6h7Bo9cJLXeaTQzGJ60VBTRbHYEC4iBNhAZ3Vs/fSxCdMgEcoIJPr
   T+Sw4RhAcxyGvNdbp/sxhogOZMtHjbFafAnkHkmJjJ88kkIO+ILFOvyNk
   Hg4rWdXdTQ2evhdAMWkDv6s3pgb3lRY3CIW05PCDzowVlKBWSBKdnrj11
   4e7zTdH/IozfWza4uXSfgCfx/fzkylKvUdOyc27FIX2IBrbYD/BlzWYrL
   Y8xmwaq4nt4n4+wu+L2XEyVGcNyU730dWnnQabALNyEGSyzv3BQy33WCO
   IRzxfuPIQw8Al+B/E/hNn2+HPO81LFex3ZnQCp0DgSzvcks9gyF5vjASa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402762457"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="402762457"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788953699"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="788953699"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2024 07:21:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B8E0CBA3; Thu,  1 Feb 2024 17:15:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH v2 0/3] backlight: mp3309c: Allow to use on non-OF platforms
Date: Thu,  1 Feb 2024 17:14:12 +0200
Message-ID: <20240201151537.367218-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to use driver on non-OF platforms and other cleanups.

Changelog v2:
- rename pm3309c_parse_dt_node() --> mp3309c_parse_fwnode() (Daniel)
- add tags (Daniel, Flavio)
- new patch 2

Andy Shevchenko (3):
  backlight: mp3309c: Make use of device properties
  backlight: mp3309c: use dev_err_probe() instead of dev_err()
  backlight: mp3309c: Utilise temporary variable for struct device

 drivers/video/backlight/mp3309c.c | 88 ++++++++++++-------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

-- 
2.43.0.rc1.1.gbec44491f096


