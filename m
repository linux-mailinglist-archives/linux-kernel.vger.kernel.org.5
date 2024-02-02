Return-Path: <linux-kernel+bounces-51009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD898484FF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B071C25B3A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9115D479;
	Sat,  3 Feb 2024 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mR4HGdrS"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3B5CDC4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706952413; cv=none; b=YD3ypgAwBKKQIIvy+JJuhRhf8So4HVg1JYm7Nj8IRgYU1Rj6W1LZowCLwqb7tdDJ2nl0GRqPSGek+PrC0m9U9ARMa8dN7juSB3wi1URroknbVJatW44OFkvO4jbOBnZhCfyT/RXu7RF1Ac+PxF+DRD3Vk6SQ7q5OTNqfHNZWX/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706952413; c=relaxed/simple;
	bh=ewc2+RS8n9r8I32AbwlyRDrV0xZI3DKnyzUgCv3YY8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kApuVidN68/F9HEs6KGqC880wiAx9ZIp6+XgDV31dmHeTED7lYmZ8g95UYwDXubDgmYYJG727/anADstE2vhY+owIviiReBhsqW64J9xRM0GvJAv3LNlJs6nPuAPEdjGoHZ0/ROAHhfmlLK9r/Ilax8vks1cASLJP55YBRu9/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR4HGdrS; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706952411; x=1738488411;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ewc2+RS8n9r8I32AbwlyRDrV0xZI3DKnyzUgCv3YY8Q=;
  b=mR4HGdrSyY9J6WGi3fQArYdZ5HrPQbYe3x976vcQRoQYcaZPaGtlMPrs
   c6RXhSI1UobaQDNfHZPKhDa5+TuTg/tfW6C+i8jHPPgJCTSlU10NF0FdN
   cQzpuweBnH2kaAbWhOBAYm+2l8AxcZ5C9jRl6Ay6hkhAWxZQLwJ17mFKn
   0327ycc6PGIVfzd8QW3Dq0Xv8cZUi7mPgH4L61U2WCATrkTx81F8oXkzL
   TYr/c9WwqkzPNLM4ChR+yB1DpwWQqhZBhxrQVCSbdUwEJuhn6oT2b1vES
   ctIVMUU7VslhcZ0qAGXcn8xt28vrIYLnK7iPeyP3/7fO/5V3QQFHQ9mti
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="435443636"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="435443636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 01:26:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908819844"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="908819844"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2024 01:26:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DDDB18C7; Fri,  2 Feb 2024 17:47:50 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	John Garry <john.garry@huawei.com>,
	Wei Xu <xuwei5@hisilicon.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Zhichang Yuan <yuanzhichang@hisilicon.com>
Subject: [resend, PATCH v1 1/1] logic_pio: Use RESOURCE_SIZE_MAX definition
Date: Fri,  2 Feb 2024 17:45:59 +0200
Message-ID: <20240202154744.473467-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a predefined limit instead of hardcoding it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v1: resent with the main contributrs in the Cc list
Initial contribution was here more than a few months ago:
https://lore.kernel.org/r/20230911224500.16677-1-andriy.shevchenko@linux.intel.com
followed by
20231016132611.1201402-1-andriy.shevchenko@linux.intel.com

 lib/logic_pio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index 2ea564a40064..1cab23e4f856 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -175,7 +175,7 @@ resource_size_t logic_pio_to_hwaddr(unsigned long pio)
 	if (range)
 		return range->hw_start + pio - range->io_start;
 
-	return (resource_size_t)~0;
+	return RESOURCE_SIZE_MAX;
 }
 
 /**
-- 
2.43.0.rc1.1.gbec44491f096


