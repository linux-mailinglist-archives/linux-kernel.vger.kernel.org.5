Return-Path: <linux-kernel+bounces-95411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F4874D51
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 113D4B229EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F751292CA;
	Thu,  7 Mar 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpmjCSFE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6982D91;
	Thu,  7 Mar 2024 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810652; cv=none; b=stGjNnFsRlRlhZp+G8Q6PSMVeTm3XoNqmSj414GOP8k7YWo46AhmvPZD+v7X3bUkoovmRGf6r5lSGR5erA0xyihIC+4h1HhZkhm8ajGvjhp5OKBH1T9iBMqQ5L1woXhgF0AY18cXcyuNe4jtH5GyDl21+EZjitYU/aJH1xZe+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810652; c=relaxed/simple;
	bh=VQNpMcdrVmdHySPPhS2W+ZB0l9yLXptAua58xe/6us4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaoSGwCAETfwMD/P1JxICBrKJGxeG9rK6/XsJPUgAIfLuu1dDA4kebd/e0PDw8nTli4yRWl0wdKAYhpf0Pzex0Q46wDaWDRbX5NEm8IdKnMaweFpDSt/etzl75Ikj0n0eGGzGL4TBBbXUlkC+28uZmNeW47gzynWnSvJV4p9ms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpmjCSFE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709810651; x=1741346651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VQNpMcdrVmdHySPPhS2W+ZB0l9yLXptAua58xe/6us4=;
  b=CpmjCSFEf+N63wl+xF637RiXSVb0ew/3xdvZREZpSVM1HZyC3b3hpnJF
   0u5PnCtZNRHZnVJ92kAJrvZzXI0Ae1ktYy0OkLJ5DyGjeJALa+GBK8TYG
   FjwO63Srw8tlxYGKiIAFVztoMs00yHS889k5d6s0sle5mmgbifNhqI2Oe
   eCFiB/EwXYQSHJ/NywGbrK9sp2ETZpvGDHxdeLyxF9sSKANhPq6XZEQxY
   NgBT0wGBiwUX33gTyU4fiCRJMN0Qp2aMOuXxrRECgLVT9jlKE+KD9H8DQ
   jd1hOq8cu5S227AVdPCQGXzlEKEV4Frvgv9WbrmxfQqGB3k/QYRwMpu7l
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="5059653"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="5059653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 03:24:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="937045836"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="937045836"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2024 03:24:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BDC7E193; Thu,  7 Mar 2024 13:24:07 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: ohci-pxa27x: Remove unused of_gpio.h
Date: Thu,  7 Mar 2024 13:24:06 +0200
Message-ID: <20240307112406.3625756-1-andriy.shevchenko@linux.intel.com>
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
 drivers/usb/host/ohci-pxa27x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 357d9aee38a3..3348c25ddb18 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -27,7 +27,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/pxa2xx_udc.h>
 #include <linux/platform_device.h>
-- 
2.43.0.rc1.1.gbec44491f096


