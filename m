Return-Path: <linux-kernel+bounces-85640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AD86B890
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0971C24D13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FC15DBAE;
	Wed, 28 Feb 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWq3WaT+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BAD5E09B;
	Wed, 28 Feb 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709149706; cv=none; b=e2+MuNRX6y9H8EWMpq0uKAosulWXYohC8dNf8vXLqOPUXmAw4v+EnihcddVQTf8mKP7CFLnpPbjrf1S4p/LO6IrzbJQsz5KGloHdrD02Z2kD6o6wjTzFnv190BHdlf5pr5Q57IFEFzb/SILB7dnSrLuWU1zT1tNFYrBRoV9B7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709149706; c=relaxed/simple;
	bh=RICB52h8F07eWZ8R3FPvLlk8h5Ejw6F2UCLBQVHpQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYmD9zgL2PJJgt+8MDbfCMdKWs3u6cpIheYqVO4F6MuP5L7lC0ZjKmFa+rX9G3gUMsqfOusxlaOElTrsINbzOkC3DkISQkMK7mO02qfp7W3ofwIetZFO3Ar25Q6lPp8GbBYj0sxdH1tk0sTWsQqikN/yE8Yj4HC87ZVgw6M7vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWq3WaT+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709149705; x=1740685705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RICB52h8F07eWZ8R3FPvLlk8h5Ejw6F2UCLBQVHpQqw=;
  b=PWq3WaT+YziUJylxrZS1iXa5tL8n/9oRG9jfvLTVjhuziMUBNedZPzMr
   teLbpKVxq7khSr88JZyUHZciIewZR05jG6iVYzXX+FjNZhATcDyTUF9T0
   IoN4Ss3QUaPGBVh6gftJ1LG+9q2iro1YW0iGtQUEKlq/G8bEBGcynwGiz
   l5/YMB55c0JcSm/bQE0yQfxusFCg8rxvkT/ftJ1LQLnm+iLLIKxPbg5R9
   epyJHdKN3H0dzk4H+iYPSasoVCDhxZFcL+kaRGs399iYVxjknLEXRI85o
   sG9z/BmF4MS2/01GEA30xK/m48F+AY5rXRvdmWDX3376TJdtzpON19sHE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14992232"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="14992232"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 11:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034611"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034611"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 11:48:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AA0D51C5; Wed, 28 Feb 2024 21:48:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] spi: pic32: Replace of_gpio.h by proper one
Date: Wed, 28 Feb 2024 21:48:08 +0200
Message-ID: <20240228194818.3606841-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_gpio.h is deprecated and subject to remove.
The driver doesn't use it directly, replace it
with what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo in Subject
 drivers/spi/spi-pic32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index f55b38c577e4..709edb70ad7d 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -11,13 +11,13 @@
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/gpio/consumer.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-- 
2.43.0.rc1.1.gbec44491f096


