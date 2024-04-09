Return-Path: <linux-kernel+bounces-137123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969FF89DD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377501F2645D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C5131BB2;
	Tue,  9 Apr 2024 14:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egp86RJg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0D130A43;
	Tue,  9 Apr 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674055; cv=none; b=BforQ+Z77Pigbg5Uh0bu3nsQ6bSdo+C6sZvkwuqmts0Y/elipYtCKUEeqBDWr4K8yvUC7lGYq+8NO0d8QOov+SdDiQOwjoT0ZcrDwbC5USf2DpDXVI4ebn551dk6ZBoiltbsjyzDF2SyFt3XeoRtFNaFtfHNfZduCJrpobK0SkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674055; c=relaxed/simple;
	bh=pt7kSYebcjw0FdTN5T5ylrZPelzqHThOoid4ebBFqqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVTXGcvRCTwBBk4XKDETwyeN5RQLwIR5tTk2k/oyek8NXoyGFgqqqgNY6t2T1qiiDcxWPfNA40ipSA9yK2rr5hgnZmb8T4kd7rD/Q0cbkp8dT6tgfMKntGD38bj3jJ6dEiSYRiKZnv0pDLj1F97njSq7nhdZD/tC+4KcNxnzcQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egp86RJg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712674054; x=1744210054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pt7kSYebcjw0FdTN5T5ylrZPelzqHThOoid4ebBFqqQ=;
  b=egp86RJgQ//caVyOkD0lX/rhejNQ+yE0cOltBT4N2XboeL1LTpY7fFCC
   RiiWBp50LlCy7CQm7B2qVTwjdmbsJe919KV/LvUnLI2clg2Aus3Tb5qQ8
   r1NZ78g4HoXQ0O7jupjZlg1o9ZFAZg9WjEJwVlA0JuSpg5UQoH8z/Glij
   Cx/xo0nlihZoH26rAk/rY14+LB5mwU8WNjxo6v+AsS81RIZexkO5KO+5C
   royCb7NqkID2o+xxuVs5yJSUNgwFv/N1815YEDClZtA5l9cJgeemzW2jB
   iEwP8OV7deYCsyQQuRBW9t2aGFXN2e0NfHWaXBTkuvmYasuEZFiXeEZ2b
   A==;
X-CSE-ConnectionGUID: AQWbVTuvT2aaS4lbX4+yLw==
X-CSE-MsgGUID: uqUXtoG3T3K2KszIiCrywg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7905535"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7905535"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:47:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937093489"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="937093489"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Apr 2024 07:47:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7C852BC4; Tue,  9 Apr 2024 17:47:27 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 8/8] serial: max3100: Sort headers
Date: Tue,  9 Apr 2024 17:45:55 +0300
Message-ID: <20240409144721.638326-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
References: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
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
index 4e7cd037cfc2..ce24588150bf 100644
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


