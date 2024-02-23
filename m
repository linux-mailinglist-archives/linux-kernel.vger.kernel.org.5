Return-Path: <linux-kernel+bounces-79106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AD3861D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B501C22B95
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C51482E7;
	Fri, 23 Feb 2024 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzSAA1Oo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F828146E96;
	Fri, 23 Feb 2024 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720217; cv=none; b=b78Y50li7VgaxWmaAoMwddaRG8UgSzW4mMfc6Y0qdqbLJSAqxt8KT67C26CQ2Gy21b5RqaCoKOfrpNUq2z2PyKo5BgvQVpXEtcKKp+0biUT5Jjy/zlB+FxaNMCVG3qDoq1zxm/QHJ+VjV29dEnPzQQ7I8/S96HEjJfZIGohbrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720217; c=relaxed/simple;
	bh=Ha3KeLTITa/qwislXa09L9QKN+hTvp4TmZbpeNy2fNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hByUr/+jGQxtI+Q66oGPcPiAv7yrThOvxN+syDBtEzymnQvJ4cs9ypx9RVvXEXJMLPjt/xGXdViu6Ji7FopT7/bQyhb+amutrN81vz23Or06UBbH/xlByJfRnpqwFsKtA/cke8cKHxGnwYBvc8a56cWqTya4Qbt3mUVC1pPlY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzSAA1Oo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708720215; x=1740256215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ha3KeLTITa/qwislXa09L9QKN+hTvp4TmZbpeNy2fNU=;
  b=nzSAA1OoHcwdxwUo4BnepSrlE+Q+0VCjt/algpYHCXjQ98rEbgAaR9kM
   lMM1VFOemAu9Nisa1QvmYhKftBHTbPlt3/pUzDBP8k8BhhIq6s4+GRbed
   4MEowGd0c/7z/W9GatIi14PM7XMpXEfHoUeyhdpQ8zWFg+b+5bu4TO6IC
   xR/RRYpN/UrDXFlfU9TKwK2vjbz/1wi0MuHi2PQpZvsZPjvI3qYB6Qfh+
   tiwU7WptaqE+ONzYrfosrO8gBcRqO0TSNdisn7LUIyjGGE2BAnb2k91lh
   HMB++MdmI+E/2ixfujdQnon+Ktkef+fBxeXi4PZ8tdSU7/qDl866TYBmy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13758102"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13758102"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:30:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025702"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025702"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 12:30:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6B9F534C; Fri, 23 Feb 2024 22:30:11 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
Date: Fri, 23 Feb 2024 22:30:00 +0200
Message-ID: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added one more missing header
 drivers/leds/leds-expresswire.c  | 4 ++++
 include/linux/leds-expresswire.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-expresswire.c b/drivers/leds/leds-expresswire.c
index 89e147b0e019..e4937a8e0f44 100644
--- a/drivers/leds/leds-expresswire.c
+++ b/drivers/leds/leds-expresswire.c
@@ -5,8 +5,12 @@
  * ktd2692 and ktd2801 are known to use this protocol.
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/export.h>
 #include <linux/gpio/consumer.h>
+#include <linux/types.h>
+
 #include <linux/leds-expresswire.h>
 
 void expresswire_power_off(struct expresswire_common_props *props)
diff --git a/include/linux/leds-expresswire.h b/include/linux/leds-expresswire.h
index 3c61902ccac8..a422921f4159 100644
--- a/include/linux/leds-expresswire.h
+++ b/include/linux/leds-expresswire.h
@@ -8,7 +8,9 @@
 #ifndef _LEDS_EXPRESSWIRE_H
 #define _LEDS_EXPRESSWIRE_H
 
-#include <linux/gpio/consumer.h>
+#include <linux/types.h>
+
+struct gpio_desc;
 
 struct expresswire_timing {
 	unsigned long poweroff_us;
-- 
2.43.0.rc1.1.gbec44491f096


