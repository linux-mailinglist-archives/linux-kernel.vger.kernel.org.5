Return-Path: <linux-kernel+bounces-91058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40CD870913
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 607D5288151
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304B6168D;
	Mon,  4 Mar 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NjvZ0sJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8444CE1F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575609; cv=none; b=OcMJtWtBtwGrPoDg7Ejx0+HlvhMQ7L4rR0b7219rMwXdZiro5oEjihygGffGXbo88VJMAQ8JjVYjjsRqgCP3NhUnkvu1ABMiePMUj3YxjXa0FuIAG7Ds/DM5av96zH2TDkyK8YzUkBG8BYw17IoNTkPagigr1Wax2hcEZcpm/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575609; c=relaxed/simple;
	bh=4fH4khuBRr1+JeEQo2yHTA5RkeJkUXkOes54Fy47feQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ0zEy9nlxO+k/Ya74yy+iviTrAYCALFUazshcGnc3G+FX0r8YWk30Rehl2XC5o/bwNxWOXtiiXscA+XXr7BHw9TJCrV5znBFqsde1zhob3KGeAxShMz8kDez17TE7cE5JkAIsxmMI3DDxNhWZxH+LHbMpFlen19k6Jey+VWuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NjvZ0sJj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575608; x=1741111608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4fH4khuBRr1+JeEQo2yHTA5RkeJkUXkOes54Fy47feQ=;
  b=NjvZ0sJjxKlzb6gYvptGL+4K2ACrBbh67mStubIQS3vnyGVIhsNkxBPj
   VX0I+wa5vye36mKEXIteuMKQiMP3vBlpJ+Hy0EPaCO7UpKONWlegRXWf3
   liyL1iV8LhjeG+APE0baAdAlFdL/p/c68cx46IPeEpb/j1VlhkdC7ljx3
   Q/dZry8Zt75KSeWXPIz1pEv16oxmdwOU+bIrr+buDbynCfqwiYmKu05UB
   rT0K4bZ976+SlR2D1NEOhJSQyGOBlr2usMyNUs7B0T+MTWet+scf43+gy
   HZLQ0VaYGHC4yOTREqiDtg6pQGkwIQNU2QdVAPOZcZiEiCakuWrMHO5HG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7855483"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7855483"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:06:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040917"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040917"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:06:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7D38815C; Mon,  4 Mar 2024 20:06:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] misc: eeprom_93xx46: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:06:43 +0200
Message-ID: <20240304180643.1201319-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it, simply remove the unused header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index b630625b3024..e78a76d74ff4 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -14,7 +14,6 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/nvmem-provider.h>
-- 
2.43.0.rc1.1.gbec44491f096


