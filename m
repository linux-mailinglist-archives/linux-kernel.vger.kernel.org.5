Return-Path: <linux-kernel+bounces-85656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0C86B8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510671C23308
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C434CDE;
	Wed, 28 Feb 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOfSTkI8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856CC5E073;
	Wed, 28 Feb 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150617; cv=none; b=Za0VFFGCSkhzjN2WzMxLajcPHKjXmVCqo4MKsD0Bm5t5Hje1mmoaXaY3RdtuUGNfMJM39gsGvEli6f1PwGuoVyQ3oXRiUWkJ6ghQ23Brs8IrGIdnd4+wf8xLPHi6IPlIxSzLjrqV0P0wEbH1L3MUMIe7q6YJ/4OWNlDwjdG3pAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150617; c=relaxed/simple;
	bh=vtCymdQDVWcDC54rcsZA1PscbDVRCdc3nAdb+7GntDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grxNhGmN+TofA93/92xzKwbVdVJgkwJdn6yZrjAFF+YMJsd91Q7kTBjbV5OEvKEsEz6ILmQ9Bef/omjMi+BTTpMKNGosIz+x/pFV/vrZ4lekVZIzQWGDMuNAqisfIaKRqQx9GTbjsMTbGHz8LB1TpDYJX1N0UlVe/sdCgMSuzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOfSTkI8; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709150616; x=1740686616;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vtCymdQDVWcDC54rcsZA1PscbDVRCdc3nAdb+7GntDA=;
  b=IOfSTkI8fRF/ZiGGfJgY3hn2r5e17mR42/9Yj/ANqfE9vlyaZBIti8zr
   fYVPKcpoZdLj04kBonpZpdy2HKX/6iK2s74cXGoH2940M1FQSyRYXypIl
   lF/dDX2nNqWEIr5PMzeORirDBaOMw3ZcODAcI+xXleoLIXsfqD5UculCH
   VKUIB8k4tcky18lPrZrVfX9iKO5hh8GS8Cy9e185mW8zj1hJ3MmNawI00
   Kwknfi6bUHUM6dY9IGZTDIE3rv+45t/VMMSWKn/z6f1+OGbM05ZwHi6NP
   PuO2+vnQgBq7EK+dF+p9rsD7hHmxdqf4OmvNPKR3VsW+W1rw5W3wJEjIz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21122843"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21122843"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 12:03:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937034615"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="937034615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2024 12:03:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9F62E1C5; Wed, 28 Feb 2024 22:03:28 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Felix Fietkau <nbd@nbd.name>,
	Alexander Couzens <lynxis@fe80.eu>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH wireless-next v1 1/1] wifi: mt76: mt7915: Remove unused of_gpio.h
Date: Wed, 28 Feb 2024 22:03:21 +0200
Message-ID: <20240228200321.3607764-1-andriy.shevchenko@linux.intel.com>
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
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index f5b99917c08e..90a6f61d1089 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -7,7 +7,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/of.h>
 #include <linux/of_reserved_mem.h>
-#include <linux/of_gpio.h>
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 #include <linux/of_net.h>
-- 
2.43.0.rc1.1.gbec44491f096


