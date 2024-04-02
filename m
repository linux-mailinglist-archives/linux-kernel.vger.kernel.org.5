Return-Path: <linux-kernel+bounces-128623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8D1895D25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E010B1C2390B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89B315F32D;
	Tue,  2 Apr 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkGRiSv7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8072915ECF0;
	Tue,  2 Apr 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087606; cv=none; b=RcfDSnTmkP7LL2COXRjvc/KwMEbAUxsXTElTRGVSl0O2PY518BcrS+n84pKO16KMGpZOWyoGftrVk4sKKbvbB9YZJa7z5iKQ0Oug6fKRyE73tb6UncL2p2i9Kt4Wm6/Ah4qCQXo5SOsMFfyxPO4SJM1eCjYXpawO2T6JTuHrRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087606; c=relaxed/simple;
	bh=Pzd4zF55D0Q5tN3ZT/f+vvK1+li7w9jn5Gn98hnh/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aD2SP7AdmQ9GLlA/aUVbVNZYFkO/Jv10PfjeqP8mdXvYcjn9YstqWC5wNcKzrVtaPIezrgKgb1HQ+2QKwVx/Ca56+W9GpoRh/NofQ/KE76CAJUR4DSh692xxwbyAHbAloWGszMY/t5X9eq8YWG3+ycMOdvWLmP5z1eH3iMt2va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkGRiSv7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087605; x=1743623605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pzd4zF55D0Q5tN3ZT/f+vvK1+li7w9jn5Gn98hnh/Tk=;
  b=dkGRiSv7oQID/W21fQbfH/kvluZ7jugMH8rqK2Z9/z2OsxxfRzXdq8zs
   hNqMqRHjZr1fKlC3qubMZ21ag09Hf1ryz8SMIoR/Fi6KWGui7HVrcLiff
   XlMR5ESPt8XfdQ/cCGL/DfgmeW0aqot5GFfrUb+olwLlfijY1D1hEJA34
   LR5dTAq3JbXcNK2ISnCAj3IGciDQb/8C5wYE6dthRaxxiB5c7J/7HrZmC
   sndNo0/6IZBl9sAmZ5f9OdAtZL49XuKb5TQvqzDbCqSylFp0S5+7Ar1yJ
   bzF+kzG7NV6vItaan2wpXAq92YfT6jsyVdVH3SK1r+BXez18DK5+TPRl0
   Q==;
X-CSE-ConnectionGUID: oGWDkvn8SuW1I3eAhr+9pA==
X-CSE-MsgGUID: BdTq/U9fSRSAXDRyWd3HqQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151044"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151044"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083797"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083797"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 64E9016A6; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 16/16] serial: max3100: Update Kconfig entry
Date: Tue,  2 Apr 2024 22:50:43 +0300
Message-ID: <20240402195306.269276-17-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
References: <20240402195306.269276-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver actually supports more than one chip.
Update Kconfig entry to list the supported chips.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index e636a51eb7b6..dcb67c40bf92 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -307,11 +307,14 @@ config SERIAL_TEGRA_TCU_CONSOLE
 	  If unsure, say Y.
 
 config SERIAL_MAX3100
-	tristate "MAX3100 support"
+	tristate "MAX3100/3110/3111/3222 support"
 	depends on SPI
 	select SERIAL_CORE
 	help
-	  MAX3100 chip support
+	  This selects support for an advanced UART from Maxim.
+	  Supported ICs are MAX3100, MAX3110, MAX3111, MAX3222.
+
+	  Say Y here if you want to support these ICs.
 
 config SERIAL_MAX310X
 	tristate "MAX310X support"
-- 
2.43.0.rc1.1.gbec44491f096


