Return-Path: <linux-kernel+bounces-91053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CC8708FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3517B1F245FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AA6214E;
	Mon,  4 Mar 2024 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJfQquTb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09491756D;
	Mon,  4 Mar 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575419; cv=none; b=EjBnaYIuLrajsU5mGse6JpmYQXtKp71OWLX8AYS9wF9kXr/VAhJROexuM8j7AsW8l9BUAUpHzLR1L0PeCq+fwPBhygu2sDyPwGd7QeSC7W6qzSL++ZnPRniHcInp2D4nA/rICmx0D31eXq47kPmr/IFNCiAxkjpVlagrGbcx5DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575419; c=relaxed/simple;
	bh=Edx58ysToP3FaFY7mxr4Ae/EJX6jGWhbuK1l41l1MGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qa2SAtbxLDmJZDrVSqBs5gKtEGPaZTSMNrldeQElRbr5qAcSFd++mccvjbpm8X1SM2whDA+yWcJvP4byLz73qym+BZF9gveDk2IbgxnrVSqYjgkIdeR6xH13AeZFwXm5g+w56esGgKOSso3jkCo29v+RWHdMZFH6Kq3gVdZmL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJfQquTb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575418; x=1741111418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Edx58ysToP3FaFY7mxr4Ae/EJX6jGWhbuK1l41l1MGY=;
  b=NJfQquTbR5tZVx2NfXbUIQpm4m4iG+mZ8RRE/t9KG85FaiOFf2KiMr9d
   sWiTjPpDRCnvQNOg/u3kYhwff0clWvlSBG/ZW+Ol3FblrZst1blca0d5d
   PYBcdS4fPoGG5+yT/XHf24S50YFzUmbJnyJfP8oYNhmO6bG01/obO6/Oj
   rK2B4I2dJMmUWnxmQnH7y3Po+B4M+5Q+0RQNsbHAyJgSauCSyofz2cEdu
   cZmbOwxlicKUuKQ8RU7tuMq0wvLGRE/ABw2WAokU+af5ruZJMWWNKlfJc
   O8nl/GndzhyDTR0wUItjpDDegFugsQSKGuiG8oT+IDGAFruy7yIV37B+6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7854931"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="7854931"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="937040915"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="937040915"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2024 10:03:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0607415C; Mon,  4 Mar 2024 20:03:32 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 1/1] media: ir-spi: Remove unused of_gpio.h
Date: Mon,  4 Mar 2024 20:03:31 +0200
Message-ID: <20240304180331.1200827-1-andriy.shevchenko@linux.intel.com>
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
 drivers/media/rc/ir-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index bbc81bed4f90..8afc3cd70b87 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -8,7 +8,6 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <media/rc-core.h>
-- 
2.43.0.rc1.1.gbec44491f096


