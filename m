Return-Path: <linux-kernel+bounces-128269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE51F89587F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E007B2603A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED913D2B1;
	Tue,  2 Apr 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7L/XuPj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1D137C33;
	Tue,  2 Apr 2024 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072556; cv=none; b=DIUpyRUE3RCjgRNiJ6JfCbIutqp5ZmRpavlxlQEw6dlMlHhylEAybTrHcdi7GUAyYywfTgYUgvtm1mnvMqk366MebPFBD3ZTJdPH4bLnl86YsuynK3XHJtE7PxTm63ePtdu4myknfI20UU4Grb2Y8xhcqIRQI97cTeamsGS8XRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072556; c=relaxed/simple;
	bh=9PMPvNt/graUgF5IwGBIHwem/5+4HBKF7gr4a0TYsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdS86H73z4HibsoIC2NM+XFgo3nVrLZrYBpS7ZVi9TBhkfX1eITI4YgMx03Umk0DEuJOwt3vCrtnsBm/0UOEmhmnQMCDavGxcLk8UbfWVts81hhMqsBoVTOHKq8dQHPsXeaxb/GFbKV9TOALZieW7lvvMO8z8EnrpnEZUjbHZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7L/XuPj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072554; x=1743608554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9PMPvNt/graUgF5IwGBIHwem/5+4HBKF7gr4a0TYsBo=;
  b=c7L/XuPjLYRBCNK0LQybxQ8B33EK91N2YnnZlXojtoiqchWV6scFX8js
   CgAHZdqoqH7mgtzmJ+Qu+dujxEREdZW6QQl/SCAp5uRavUsR82B40oZPo
   Y4x8Q9DH/Fw15EEcFffnGYo1gsuaYss8Pn59ilfHuP0zujzgL3utGMhYk
   YXKGbGlg71lSAhP7KtW8kBc3XqVUpt7Odd7EKhiys+LLyx3XN4zNA0BKq
   QHleoMor2lPziBnJ04fgcMcoIDZc5OfhTKWuqf7s9zBlaR2NoEvh5va/O
   /mBRZlaRl2EI7VSAul2rzAUgi4xeZStpp2NbvB9ZhzfePIoyZ+KcLxC+4
   Q==;
X-CSE-ConnectionGUID: CzSgz+PTRxCV0c+FPHdNXg==
X-CSE-MsgGUID: yNa272ObQkaiEjEX4VnwFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="17870097"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="17870097"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:42:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937083650"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="937083650"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2024 08:42:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D07D51567; Tue,  2 Apr 2024 18:42:20 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 15/16] serial: max3100: Sort headers
Date: Tue,  2 Apr 2024 18:38:21 +0300
Message-ID: <20240402154219.3583679-16-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
References: <20240402154219.3583679-1-andriy.shevchenko@linux.intel.com>
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
index e63ac027b4f3..d7c0e274e00c 100644
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


