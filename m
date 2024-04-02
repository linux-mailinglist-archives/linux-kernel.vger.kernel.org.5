Return-Path: <linux-kernel+bounces-128624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84667895D28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1228A1F267FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5915F3F3;
	Tue,  2 Apr 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrNpkTe9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4B15EFAE;
	Tue,  2 Apr 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087606; cv=none; b=fCmMOL5+jofotdfwc6+ZFrQ52t+pxgybObrs9RWRyXjBCF0/Eku6Y5mnWGWi0Uf5Y1NzdFSr31IgBFZ3EY/PJ95K44JMCaEOVbyi1rGaPQTWvA/+NK5FaK8tUDwEZiGK0Q1CaSR7il1mHX9KadI6Do4EHti1Gc+ajEu/JgLw4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087606; c=relaxed/simple;
	bh=NprQ14Gp15g2wulXjCok7Aa/pMesYfi0qsUoZ4gNAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnCHqVlFW6WiIC6o6m7/dnzWSeAuNfPERaMoARZYl6XeUlRuj8OsQ4Vyo14bAvUSIOURvX31NTuyUE40YNWNH7nL0O7EPlVyqzEuJ8RJFIM5SgguY/T850lYlB///GQsoZZfJH6ooLhnb3zGPeKmJt3pOeNKnd+2J6o4b8ODgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrNpkTe9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712087605; x=1743623605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NprQ14Gp15g2wulXjCok7Aa/pMesYfi0qsUoZ4gNAXQ=;
  b=RrNpkTe9rPSIwr5Dm9naCovOaXLG7k5svdWeh5sCOlSS/JQL7zGRrGub
   tAowPx11kLm6FCLe/1i5goODEgnpfU3ccWlKohlSkqut4cniQFnp7l7Ht
   CpZLTigV1ywkge7Epb5DXFdZljB+RC5dJcd7Bgvx3frGYodnZgXN1yc2s
   76VUNnzrXstY/PjOvDrRimExOnswBXQB5cbj2T+bW0byXRKBw06nOJa9S
   koRM86YtZUKwqJhARMl4Ixi2nIx0Ob+UzeKx8L9uMR27/HoSZOu/rb4ez
   94hQSqMbv4eOeNPp44xU4bMtbQfDZVTLW4KbKJGQ5Kq6ukopYhbZwRWtc
   Q==;
X-CSE-ConnectionGUID: Q2Rw5ScASzWmHMTDhkZyiw==
X-CSE-MsgGUID: Lty19qGlRtSMZvpuL4mEhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7151049"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7151049"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083798"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083798"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 12:53:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5FD0316E8; Tue,  2 Apr 2024 22:53:10 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 15/16] serial: max3100: Sort headers
Date: Tue,  2 Apr 2024 22:50:42 +0300
Message-ID: <20240402195306.269276-16-andriy.shevchenko@linux.intel.com>
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

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max3100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5a28df2564b2..004c0a9a6d61 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -18,18 +18,18 @@
 
 #include <linux/container_of.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/freezer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
-#include <linux/freezer.h>
-#include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/tty.h>
 #include <linux/types.h>
 
 #include <asm/unaligned.h>
-- 
2.43.0.rc1.1.gbec44491f096


