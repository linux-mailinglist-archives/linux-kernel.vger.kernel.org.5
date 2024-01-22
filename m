Return-Path: <linux-kernel+bounces-32291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9828835990
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7556B215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF64C7D;
	Mon, 22 Jan 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwS3fHC6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6517F8;
	Mon, 22 Jan 2024 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892576; cv=none; b=XBxZRMPiD69Var2+1CUZBrX6PVP3bFuZCP+pHpyBIhnp83/VrWF47Dj+nKjw13vF3o9TuYBEA7Vn4YmKxo/7KZZnjJhafpl4fqYllvQW8Yi2Tc/e4F7UiV19a3BIcI5DaU8W+xJKhRtDsjDI/34v3DB8MIvxOj0AhRczejPOGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892576; c=relaxed/simple;
	bh=JU9q0bJ7a4jYOvykJk01qQpv3D5tvVRO+GJ+CDcsGr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIu6/n3eMENcq+CA2GWif1a6N69gj1ckvWawLXsonGur9+qBeeM08ZEKNdI+QsOQjZmK1JodVV8pTK3w8EvDZYpwAfivrjCrHjDXpqU8N+GnaDPfxDPxILzD7xvyBasx35/7d9QaaOV+v4b1HgExBPu+q1KbxJp2JaHAhLK9noE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwS3fHC6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705892575; x=1737428575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JU9q0bJ7a4jYOvykJk01qQpv3D5tvVRO+GJ+CDcsGr4=;
  b=PwS3fHC6LmoPS8UCvDbnq0zn6jox3QbhMuoT3NLt3xM4sRAm/M19LLk5
   X/z7t81aT7+95RjsGh8LTGg6cYiDOgatVlZMzhGvnPYizoyHe1H8Ss528
   dAfG5Mlj1uoCql7pTeRFwH5c+naK8O3KXxaCbcbHiauzGdiOXmXA0uBCn
   OeEUH4o2XmCtAObNc/4ARARlI5xbmqFqDGGTNHMmbAfBKZCQwoPYyWGv8
   noN5DB4qNGPxMZ7qpsjdjTHYJ6E+/J4jtLOPT6hpMueZz/YKP2oUf60XQ
   jMtAWDaArioROOeuZUcI3cvZQQ13IhaaNmsi18RnjbspotwUX3L92YqAi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14607320"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14607320"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 19:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1085519"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2024 19:02:42 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 1C3D147C1;
	Mon, 22 Jan 2024 08:32:41 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 1785C1600100; Mon, 22 Jan 2024 08:32:41 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 0/3] DesignWare PWM improvements
Date: Mon, 22 Jan 2024 08:32:35 +0530
Message-Id: <20240122030238.29437-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds 16 channel support for Intel Elkhart Lake and simplifies
code using standard helpers in DesignWare PWM driver.

Raag Jadav (3):
  pwm: dwc: Add 16 channel support for Intel Elkhart Lake
  pwm: dwc: simplify error handling
  pwm: dwc: use to_pci_dev() helper

 drivers/pwm/pwm-dwc.c | 71 +++++++++++++++++++++++++++++--------------
 drivers/pwm/pwm-dwc.h |  5 +++
 2 files changed, 54 insertions(+), 22 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.35.3


